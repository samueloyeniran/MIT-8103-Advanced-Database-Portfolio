# MongoDB Practical Session — NaijaMart

## 1. Overview

Project: NaijaMart E-commerce Database
Database: naijamart
Collection: products
Database technology: MongoDB 9.0.4
Environment: Ubuntu on WSL2
Dataset: 200 synthetic product documents

This practical session demonstrates MongoDB document operations,
product filtering, inventory management, indexing, and nested-field
queries for an e-commerce product catalogue.

All product names, prices, and inventory quantities are synthetic
sample data.

## 2. Sample Product Document

{
  productId: 1,
  name: "Laptop Model 1",
  category: "Computing",
  price: 16379,
  stock: 25,
  attributes: {
    model: "NM-0001",
    warranty: "6 months",
    ram: "16GB",
    storage: "512GB SSD"
  },
  tags: ["computing", "laptop"]
}

The document contains basic product fields, an embedded document
for attributes, and an array of tags.

## 3. MongoDB Operations Performed

### 3.1 Dataset Count

Command:
db.products.countDocuments()

Observed result: 200 documents.

### 3.2 Product Filtering

Category query:
db.products.find({ category: "Computing" })

Price query:
db.products.find({ price: { $lt: 20000 } })

Low-stock query:
db.products.find({ stock: { $lt: 10 } })

These queries demonstrate filtering products using field values
and comparison operators.

### 3.3 Sorting and Projection

db.products.find(
  {},
  { _id: 0, productId: 1, name: 1, category: 1, price: 1 }
).sort({ price: 1 }).limit(10)

This query retrieves the ten cheapest products in ascending
price order while displaying selected fields.
### 3.4 Updating Product Stock

Command:

```javascript
db.products.updateOne(
  { productId: 1 },
  { $set: { stock: 25 } }
)
```

The operation matched one document and modified one document. A subsequent query confirmed that product 1 had stock 25.

### 3.5 Creating an Index

Command:

```javascript
db.products.createIndex({ productId: 1 })
```

Observed index name: `productId_1`.

The collection's indexes were inspected using:

```javascript
db.products.getIndexes()
```

The output showed the default `_id_` index and the newly created `productId_1` index.

### 3.6 Query Execution Plan

Command:

```javascript
db.products.find({ productId: 150 }).explain("executionStats")
```

Observed results:

* Documents returned: 1
* Index keys examined: 1
* Documents examined: 1
* Winning plan: `FETCH`, with `IXSCAN` as its input stage
* Index used: `productId_1`

These results confirm that MongoDB used the index to locate product 150. They do not independently prove a specific performance improvement over an unindexed query.


## 5. Flexible Schema and Nested Documents

MongoDB stores records as BSON documents, allowing documents in the same collection to contain different fields when needed.

### 5.1 Adding New Product Attributes

Product 1 initially contained the attributes `model` and `warranty`. We added `ram` and `storage` without replacing the existing attributes.

Command:

```javascript
db.products.updateOne(
  { productId: 1 },
  {
    $set: {
      "attributes.ram": "16GB",
      "attributes.storage": "512GB SSD"
    }
  }
)
```

### 5.2 Verifying the Updated Document

The updated document retained the existing attributes and included the two new fields:

```javascript
{
  productId: 1,
  name: "Laptop Model 1",
  category: "Computing",
  attributes: {
    model: "NM-0001",
    warranty: "6 months",
    ram: "16GB",
    storage: "512GB SSD"
  }
}
```

### 5.3 Querying Nested Attributes

Command:

```javascript
db.products.find(
  {
    category: "Computing",
    "attributes.ram": "16GB"
  },
  {
    _id: 0,
    productId: 1,
    name: 1,
    category: 1,
    "attributes.ram": 1,
    "attributes.storage": 1
  }
)
```

Observed result: Product 1 matched the query.

This experiment demonstrates how MongoDB supports nested documents and queries against specific nested fields. It also illustrates how product attributes can vary between product types without requiring every document to have an identical structure.


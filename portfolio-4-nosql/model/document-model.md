# NaijaMart — MongoDB Document Model

## 1. Introduction

NaijaMart is a fictional Nigerian e-commerce platform used as a case study for the MIT 8103 Advanced Database Systems portfolio.

This document describes a MongoDB document model for the product catalogue. The model groups related product information into documents and supports product categories with different specifications.

The dataset used in the practical exercises contains 200 synthetic product documents. Names, prices, and stock quantities are illustrative sample data.

## 2. Database and Collection

* Database: `naijamart`
* Collection: `products`
* Database technology: MongoDB
* MongoDB version: 9.0.4

Each document represents one product.

## 3. Document Structure

The product documents use the following fields:

| Field        | Data type         | Description                          |
| ------------ | ----------------- | ------------------------------------ |
| `_id`        | ObjectId          | MongoDB-generated unique identifier  |
| `productId`  | Integer           | Application-level product identifier |
| `name`       | String            | Product name                         |
| `category`   | String            | Product category                     |
| `price`      | Number            | Sample product price                 |
| `stock`      | Integer           | Product stock quantity               |
| `attributes` | Embedded document | Product specifications               |
| `tags`       | Array of strings  | Product labels                       |

## 4. Sample Document

```javascript
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
```

This example is based on the document used in the practical session.

## 5. Embedded Documents

The `attributes` field is an embedded document that groups specifications related to a product.

For example, a computing product may include RAM, storage, and warranty information. Other categories may require different attributes, such as clothing size, material, or appliance capacity.

Embedding related information can make it convenient to retrieve a product and its specifications together.

## 6. Arrays

The `tags` field contains multiple labels in an array.

For example:

```javascript
tags: ["computing", "laptop"]
```

MongoDB supports queries against array elements, allowing products to be found by their associated tags.

## 7. Flexible Schema

MongoDB permits documents in the same collection to contain different fields.

This is useful for NaijaMart because different product categories have different specifications. A laptop may have `ram` and `storage` attributes, while a fashion product may need `size` and `material`.

During the practical session, the `ram` and `storage` fields were added to product 1 without replacing its existing attributes.

Schema flexibility should still be supported by validation rules for essential fields such as product identifiers, prices, categories, and stock quantities.

## 8. Indexing Strategy

MongoDB automatically creates an index on `_id`.

During the practical session, an ascending index was created on `productId`:

```javascript
db.products.createIndex({ productId: 1 })
```

The resulting index name was `productId_1`.

An execution-plan inspection confirmed that MongoDB used this index when querying for product 150. The plan examined one index key and one document.

This demonstrates index usage for the tested lookup, although it does not independently quantify the performance improvement over an unindexed query.

## 9. Design Considerations

The current design focuses on product catalogue operations. A complete e-commerce system would require additional design decisions for:

* Product variants and categories.
* Multiple warehouses and inventory records.
* Customers, orders, and order items.
* Payments and refunds.
* Validation, access control, and data consistency.

These relationships should be modelled according to the system's requirements and query patterns.

## 10. Conclusion

The NaijaMart product model demonstrates how MongoDB supports documents, embedded attributes, arrays, flexible schemas, and indexes.

The practical implementation provides a foundation for evaluating MongoDB for an e-commerce product catalogue. Further modelling and testing would be needed before deploying the system in production.


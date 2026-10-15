// MIT 8103 Advanced Database Systems
// Portfolio 4: NaijaMart NoSQL Implementation
// Database: naijamart
// Collection: products
//
// Run these commands in mongosh after selecting the naijamart database.
// Dataset values are synthetic sample data.

db = db.getSiblingDB("naijamart");

// 1. Count all product documents.
db.products.countDocuments({});

// 2. Find products in the Computing category.
db.products.find({
category: "Computing"
});

// 3. Find products priced below 20,000.
db.products.find({
price: { $lt: 20000 }
});

// 4. Find products with low stock.
db.products.find(
{ stock: { $lt: 10 } },
{ _id: 0, productId: 1, name: 1, category: 1, stock: 1 }
);

// 5. Retrieve the ten cheapest products.
db.products.find(
{},
{ _id: 0, productId: 1, name: 1, category: 1, price: 1 }
).sort({ price: 1 }).limit(10);

// 6. Find products with a 12-month warranty.
db.products.find(
{ "attributes.warranty": "12 months" },
{ _id: 0, productId: 1, name: 1, category: 1, "attributes.warranty": 1 }
).limit(10);

// 7. Find computing products priced below 100,000 that are in stock.
db.products.find(
{
category: "Computing",
price: { $lt: 100000 },
stock: { $gt: 0 }
},
{ _id: 0, productId: 1, name: 1, price: 1, stock: 1 }
).sort({ price: 1 });

// 8. Find a product by its application-level identifier.
db.products.findOne({
productId: 150
});

// 9. Query a nested product attribute.
db.products.find(
{
category: "Computing",
"attributes.ram": "16GB"
},
{
_id: 0,
productId: 1,
name: 1,
"attributes.ram": 1,
"attributes.storage": 1
}
);

// 10. Inspect the execution plan for a product lookup.
db.products.find({
productId: 150
}).explain("executionStats");

// 11. Display the indexes defined on the products collection.
db.products.getIndexes();


const { MongoClient, Timestamp } = require('mongodb');
const { Decimal128 } = require('mongodb');
const { Int32 } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const shop = client.db('shop');

    // a way to have a consistent document structure
    await shop.collection('products').insertOne({
      name: 'iPhone 12',
      price: 799,
      description: null
    });

    await shop.collection('products').insertOne({
      name: 'coffee',
      inStock: true,
      sold: 12345678901234567890,
      stock: Decimal128.fromString('12345678901234567890'),
      price: new Int32(32), // 32-bit integer is smaller than 64-bit integer,
      details: { model: 9 },
      tags: ['electronics', 'apple', 'phone', 'smartphone', 'iphone'],
      create: new Date(),
      modified: new Timestamp()
    });

    const products = await shop.collection('products').find().toArray();
    console.log(products);

    // find the coffe:
    const coffee = await shop
      .collection('products')
      .findOne({ name: 'coffee' });

    for (const key in coffee) {
      console.log(key, typeof coffee[key]);
    }
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

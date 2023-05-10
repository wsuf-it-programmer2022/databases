const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const shop = client.db('shop');

    // classic many to many relationship with a join collection
    shop.collection('products').insertOne({
      name: 'iPhone 12',
      price: 799,
      _id: 'p1'
    });

    shop.collection('customers').insertOne({
      name: 'John Doe',
      _id: 'c1',
      age: 42
    });

    shop.collection('orders').insertOne({
      customer_id: 'c1',
      product_id: 'p1',
      quantity: 2
    });

    shop.collection('customers').insertOne({
      name: 'Peter',
      age: 34,
      orders: [
        {
          product_id: 'p1',
          quantity: 1
        }
      ]
    });

    const customersWithOrders = await shop
      .collection('customers')
      .aggregate([
        { $match: { name: 'Peter' } },
        { $unwind: '$orders' },
        {
          $lookup: {
            from: 'products',
            localField: 'orders.product_id',
            foreignField: '_id',
            as: 'orders.product'
          }
        },
        { $unwind: '$orders.product' },
        {
          $group: {
            _id: '$_id',
            name: { $first: '$name' },
            age: { $first: '$age' },
            orderedProducts: {
              $push: {
                _id: '$orders.product._id',
                name: '$orders.product.name',
                price: '$orders.product.price',
                quantity: '$orders.quantity'
              }
            }
          }
        }
      ])
      .toArray();

    console.log('customersWithOrders:');
    console.log(JSON.stringify(customersWithOrders, null, 2));
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

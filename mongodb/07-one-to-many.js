const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');

    // one to many relationship with embedded/nested document
    await carFleet.collection('cars').insertOne({
      name: 'lamborghini',
      passengers: [
        { name: 'John Doe', age: 42, license: 'B' },
        { name: 'Jane Doe', age: 43, license: 'B' }
      ]
    });

    const car = await carFleet
      .collection('cars')
      .findOne({ name: 'lamborghini' });
    console.log(car);

    // ecommerce: user can have multiple orders and each order can have
    // multiple products
    await client
      .db('shop')
      .collection('users')
      .insertOne({
        name: 'John Doe',
        orders: [
          {
            products: [
              { name: 'iPhone 12', price: 799, image: 'iphone12-1.jpg' }
            ]
          },
          {
            products: [
              { name: 'coffee', price: 32, image: 'coffe-1.jpg' },
              { name: 'iPhone 12', price: 799, image: 'iphone12-1.jpg' }
            ]
          }
        ]
      });

    await client.db('shop').collection('products').insertOne({
      name: 'iPhone 12',
      price: 799,
      image: 'iphone12-1.jpg'
    });

    await carFleet.collection('cars').insertOne({
      name: 'Ferrari',
      passengers: ['passenger1', 'passenger2']
    });

    await carFleet.collection('passengers').insertMany([
      {
        name: 'John Doe',
        age: 42,
        _id: 'passenger1'
      },
      {
        name: 'Jane Doe',
        age: 43,
        _id: 'passenger2'
      }
    ]);

    // to query the car with passengers included, we need to use the $loopup operator
    const carWithPassengers = await carFleet
      .collection('cars')
      .aggregate([
        { $match: { name: 'Ferrari' } },
        {
          $lookup: {
            from: 'passengers',
            localField: 'passengers',
            foreignField: '_id',
            as: 'passengers'
          }
        }
      ])
      .toArray();

    console.log(JSON.stringify(carWithPassengers, null, 2));
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

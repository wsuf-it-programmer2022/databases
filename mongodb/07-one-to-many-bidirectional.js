const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');

    await carFleet.collection('cars').insertOne({
      name: 'BMW',
      passengers: ['passenger5', 'passenger6'],
      _id: 'car2'
    });

    await carFleet.collection('passengers').insertMany([
      {
        name: 'John Doe',
        age: 42,
        _id: 'passenger5',
        car_id: 'car2'
      },
      {
        name: 'Jane Doe',
        age: 43,
        _id: 'passenger6',
        car_id: 'car2'
      }
    ]);

    const carWithPassengers = await carFleet
      .collection('cars')
      .aggregate([
        {
          $match: {
            name: 'BMW'
          }
        },
        {
          $lookup: {
            from: 'passengers',
            localField: '_id',
            foreignField: 'car_id',
            as: 'passengers'
          }
        }
      ])
      .toArray();

    console.log('BMW with passengers:');
    console.log(JSON.stringify(carWithPassengers, null, 2));
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

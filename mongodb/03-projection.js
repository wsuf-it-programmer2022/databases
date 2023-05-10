const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');

    const cars = await carFleet
      .collection('cars')
      // get only the fileds we need
      .find({}, { projection: { make: 1 } })
      .toArray();
    console.log('cars: ', cars);
    const carsWithoutID = await carFleet
      .collection('cars')
      // get only the fileds we need
      .find({}, { projection: { make: 1, _id: 0 } })
      .toArray();
    console.log('cars: ', carsWithoutID);
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

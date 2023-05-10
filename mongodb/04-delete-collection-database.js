const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');

    // delete a collection
    await carFleet.collection('cars').drop();

    // delete a database
    await carFleet.dropDatabase();
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

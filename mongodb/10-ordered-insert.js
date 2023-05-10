const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');

    // await carFleet.collection('passengers').drop();

    await carFleet.collection('passengers').insertOne({
      name: 'Person 1',
      _id: 'p1'
    });

    await carFleet.collection('passengers').insertMany([
      {
        name: 'Person 2',
        _id: 'p2'
      },
      {
        name: 'Person 1',
        _id: 'p1'
      },
      {
        name: 'Person 3',
        _id: 'p3'
      }
    ]);
    const passengers = await carFleet.collection('passengers').find().toArray();
    console.log('Passengers:');
    console.log(JSON.stringify(passengers, null, 2));
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

// run();

async function orderedInsert() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');

    await carFleet.collection('passengers').drop();

    await carFleet.collection('passengers').insertOne({
      name: 'Person 1',
      _id: 'p1'
    });

    await carFleet.collection('passengers').insertMany(
      [
        {
          name: 'Person 2',
          _id: 'p2'
        },
        {
          name: 'Person 1',
          _id: 'p1'
        },
        {
          name: 'Person 3',
          _id: 'p3'
        }
      ],
      { ordered: false }
    );
    const passengers = await carFleet.collection('passengers').find().toArray();
    console.log('Passengers:');
    console.log(JSON.stringify(passengers, null, 2));
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

orderedInsert();

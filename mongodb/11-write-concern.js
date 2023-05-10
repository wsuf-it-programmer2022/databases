const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');

    const result = await carFleet.collection('passengers').insertOne({
      name: 'Person'
    });

    console.log(result);

    const result2 = await carFleet.collection('passengers').insertOne(
      {
        name: 'Person'
      },
      // w: 0 means the server does not wait for the acknowledgement of the write operation.
      { writeConcern: { w: 0 } }
    );

    console.log(result2);

    const result3 = await carFleet.collection('passengers').insertOne(
      {
        name: 'Person'
      },
      // j: journal:
      // Journal: is a file on disk that mongoDB uses to record all the changes that are made to the database.
      // in case of any faliure, mongoDB can use the journal file to recover the data.
      // by setting j: false, we are telling mongoDB to not wait for the journal file to be written to disk.
      { writeConcern: { w: 0, j: false } }
    );

    console.log(result3);

    const result4 = await carFleet.collection('passengers').insertOne(
      {
        name: 'Person'
      },
      // wtimeout: 100 means that the server will wait for 100 milliseconds for
      // the acknowledgement of the write operation. if the acknowledgement is not received within 100 milliseconds,
      // the server will return an error. if I set the wtimeout to 0, the server will wait forever.

      { writeConcern: { w: 1, j: true, wtimeout: 100 } }
    );

    console.log(result4);
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

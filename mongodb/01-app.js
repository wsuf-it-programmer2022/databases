const { MongoClient } = require('mongodb');
const Decimal128 = require('mongodb').Decimal128;

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    // establish and verify connection
    await client.db('admin').command({ ping: 1 });
    console.log('Connected successfully to server');

    // create the cars collection and insert a car document;
    // mongodb syntax: db.cars.insertOne({make: "honda", model: 'Accord', year: 1994})
    await client
      .db('carfleet')
      .collection('cars')
      .insertOne({
        make: 'Ford',
        model: 'Mustang',
        year: 1964,
        price: Decimal128.fromString('25000.00'),
        description: 'A classic car'
      });

    // schema is not enforced in mongodb, so we can insert a car document with
    // a different structure

    await client
      .db('carfleet')
      .collection('cars')
      .insertOne({
        type: 'Ford Mustang',
        driver: {
          name: 'John Doe',
          age: 42,
          license: 'B'
        }
      });

    // dataTypes in Mongodb:
    // https://docs.mongodb.com/manual/reference/bson-types/
    // 1. String
    // 2. Number (int32, int64, decimal)
    // 3. Boolean
    // 4. Date
    // 5. Array
    // 6. Null
    // 7. ObjectId
    // 10 Embedded Document
    // ...

    // query for a car document
    const myDoc = await client.db('carfleet').collection('cars').findOne();
    console.log(myDoc);
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

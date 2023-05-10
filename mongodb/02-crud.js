const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function create(db) {
  // CREATE a cars collection and insert a car document
  await db.collection('cars').insertOne({
    make: 'Honda',
    model: 'Accord',
    year: 1994,
    sold: false,
    numberOfPassengers: 5
  });

  // CREATE a cars collection and insert multiple cars
  await db.collection('cars').insertMany([
    {
      make: 'Mercedes',
      model: 'C-Class',
      year: 2010,
      sold: true,
      price: 35000
    },
    {
      make: 'Toyota',
      model: 'Camry',
      year: 2018,
      sold: 4,
      numberOfPassengers: 5
    },
    {
      make: 'Ford',
      model: 'Focus',
      year: 2012,
      sold: true,
      numberOfPassengers: 5
    }
  ]);
}

async function read(db) {
  // READ a car document
  const car = await db.collection('cars').findOne();
  console.log('one car is queried from the database: ', car);

  const honda = await db.collection('cars').findOne({ make: 'Honda' });
  console.log('one honda is queried from the database: ', honda);

  // READ all documents from the cars collection
  const allCars = await db.collection('cars').find().toArray();
  console.log('all cars are queried from the database: ', allCars);
}

async function update(db) {
  // first find the car to update
  // const res = await db.collection('cars').findOne({ make: 'Honda' });
  // console.log(res);
  await db
    .collection('cars')
    .updateOne({ make: 'Honda' }, { $set: { sold: true, year: 2004 } });

  await db
    .collection('cars')
    .updateMany({ make: 'Ford' }, { $set: { sold: false, year: 1999 } });

  // if we don't specify the filter, all documents will be updated
  await db
    .collection('cars')
    .updateMany({}, { $set: { sold: false, year: 1999 } });
}

async function deleteCars(db) {
  // just delete the first document it finds..
  await db.collection('cars').deleteOne();
  // delete one document that match the filter
  await db.collection('cars').deleteOne({ make: 'Honda' });
  // delete all documents that match the filter: where numberOfPassengers > 5
  // https://www.mongodb.com/docs/manual/reference/operator/
  await db.collection('cars').deleteMany({ numberOfPassengers: { $gt: 5 } });
}

async function nestedDocuments(db) {
  // create a nested document. Max nesting level is 100, but it's not recommended
  // to go beyond 3 or 5 levels
  // max document size in mongodb is 16MB for a single document

  // create a nested document
  await db
    .collection('cars')
    .updateMany({}, { $set: { driver: { name: 'Fred', age: 23 } } });

  // we can also use an array to store nested documents
  await db.collection('cars').updateMany(
    {},
    {
      $set: {
        passengers: [
          { name: 'Jane', age: 23 },
          { name: 'John', age: 24 }
        ]
      }
    }
  );
}

async function run() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');
    // await create(carFleet);
    // await read(carFleet);
    // await update(carFleet);
    await nestedDocuments(carFleet);
    await deleteCars(carFleet);
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

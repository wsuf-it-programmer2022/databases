const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const carFleet = client.db('carfleet');

    // one-to-one-relationship with embedded/nested document
    // await carFleet.collection('cars').insertOne({
    //   name: 'Tesla Model 3',
    //   price: 39999,
    //   description: 'A very nice car',
    //   driver: {
    //     name: 'John Doe',
    //     age: 42,
    //     license: 'B'
    //   }
    // });

    const car = await carFleet
      .collection('cars')
      .findOne({ name: 'Tesla Model 3' });
    console.log(car);

    // one-to-one-relationship with reference
    // await carFleet.collection('drivers').insertOne({
    //   name: 'Foo Bar',
    //   age: 42,
    //   license: 'B',
    //   _id: 'driver1'
    // });

    await carFleet.collection('cars').insertOne({
      name: 'Opel Corsa',
      price: 9999,
      description: 'A very nice car',
      driver: 'driver1'
    });

    // which person is driving the Opel Corsa?
    const opelCorsa = await carFleet.collection('cars').findOne({
      name: 'Opel Corsa'
    });

    const driverWhoDrivesOpelCorsa = await carFleet
      .collection('drivers')
      .findOne({
        _id: opelCorsa.driver
      });

    console.log(driverWhoDrivesOpelCorsa);

    // to query the car with the driver included, we need to use the $loopup operator

    const carWithDriver = await carFleet
      .collection('cars')
      .aggregate([
        { $match: { name: 'Opel Corsa' } },
        {
          $lookup: {
            from: 'drivers',
            localField: 'driver',
            foreignField: '_id',
            as: 'driver'
          }
        },
        { $addFields: { driver: { $arrayElemAt: ['$driver', 0] } } }
      ])
      .toArray();

    console.log(JSON.stringify(carWithDriver, null, 2));
  } catch (err) {
    console.error(err);
  } finally {
    await client.close();
  }
}

run();

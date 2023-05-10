const { MongoClient, ObjectId } = require('mongodb');

const uri = 'mongodb://localhost:27017';

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const blog = client.db('blog');

    await blog.collection('authors').insertOne({
      name: 'John Doe'
    });

    await blog.createCollection('posts', {
      validator: {
        $jsonSchema: {
          bsonType: 'object',
          required: ['title', 'content', 'author_id'],
          properties: {
            title: {
              bsonType: 'string',
              description: 'must be a string and is required'
            },
            content: {
              bsonType: 'string',
              description: 'must be a string and is required'
            },
            author_id: {
              bsonType: 'objectId',
              description: 'must be an objectId and is required'
            }
          }
        }
      }
    });

    await blog.collection('posts').insertOne({
      title: 'My first post',
      content: 'This is my first post',
      author_id: new ObjectId('645b98e3fd66055e27607fc3')
    });
  } catch (err) {
    console.error(JSON.stringify(err, null, 2));
  } finally {
    await client.close();
  }
}

run();

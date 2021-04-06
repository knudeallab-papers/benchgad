const express = require('express');
const mongoose = require('mongoose');
const { graphqlHTTP } = require('express-graphql');
const bodyParser = require('body-parser');
const cors = require('cors');

const schema = require('./schema');
const resolvers = require('./resolvers');

const app = express();
const port = 58000;

let dbConnection = null;

if (dbConnection === null) {
  // const uri = "mongodb://iot:dkelab522@155.230.36.61:27017/BenchGAD_TEST?authSource=admin&readPreference=primary&appname=MongoDB%20Compass&ssl=false";
  // replicaSet=rs&
  const uri = "mongodb+srv://spaAdmin:spa12345678@cluster0.yjxev.gcp.mongodb.net/spa?retryWrites=true&w=majority"
  mongoose.Promise = global.Promise;
  mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
  .then((connection) => {})
  .catch((err) => console.log(err.message));

  dbConnection = true;
}

app.use(bodyParser.json());
app.use(cors());
app.use('/graphql', graphqlHTTP({
  schema,
  rootValue: resolvers,
  graphiql: true,
  context: "",
}));

app.listen(port, () => {
  console.log('server on');
});
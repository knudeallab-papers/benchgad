const { buildSchema } = require('graphql');

const Query = require('./Query');
const Mutation = require('./Mutation');
const Experiment = require('./Experiment');

const typeDefs = buildSchema(`
  type Query ${Query}
  type Mutation ${Mutation}
  type Experiment ${Experiment}

  scalar Generation
`);

module.exports = typeDefs;

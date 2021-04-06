const createExperiment = require('./experiment/create');
const getExperimentsListByDB = require('./experiment/listByDB');
const getExperiment = require('./experiment/show');
const verifyExperimentName = require('./experiment/verifyExperimentName');

const resolvers = {
  createExperiment,
  getExperimentsListByDB,
  getExperiment,
  verifyExperimentName,
}

module.exports = resolvers;
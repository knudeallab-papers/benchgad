const mongoose = require('mongoose');
const { DATABASE_SCHEMA } = require('../configs/schema');
const collection = 'omniscidb_dataset';

const Experiment_Model = mongoose.model(collection, DATABASE_SCHEMA);

Experiment_Model.watch().on('change', (data) => {
  console.log('omniscidb update');
});

module.exports = Experiment_Model;
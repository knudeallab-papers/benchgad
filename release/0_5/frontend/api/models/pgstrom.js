const mongoose = require('mongoose');
const { DATABASE_SCHEMA } = require('../configs/schema');
const collection = 'pgstrom_dataset';

const schema = new mongoose.Schema(DATABASE_SCHEMA);

const Experiment_Model = mongoose.model(collection, schema);

Experiment_Model.watch().on('change', (data) => {
  console.log('pgstrom update');
});

module.exports = Experiment_Model;
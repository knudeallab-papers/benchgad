const BlazingsqlModel = require('../../models/blazingsql');
const OmniscidbModel = require('../../models/omniscidb');
const PgstromModel = require('../../models/pgstrom');

const getExperiment = async ({ ExperimentId, DBMS }) => {
  let experiment = {};

  if (DBMS === "BlazingSQL") {
    experiment = await BlazingsqlModel.findOne({ _id: ExperimentId });
  } else if (DBMS === "OmniSci") {
    experiment = await OmniscidbModel.findOne({ _id: ExperimentId });
  } else if (DBMS === "PG-Strom") {
    experiment = await PgstromModel.findOne({ _id: ExperimentId });
  }

  return experiment;
}

module.exports = getExperiment;
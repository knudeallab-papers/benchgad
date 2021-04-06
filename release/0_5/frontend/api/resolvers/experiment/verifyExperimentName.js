const BlazingsqlModel = require('../../models/blazingsql');
const OmniscidbModel = require('../../models/omniscidb');
const PgstromModel = require('../../models/pgstrom');

const verifyExperimentName = async ({ EXPERIMENT_NAME }) => {
  try {
    const [experiment1, experiment2, experiment3] = await Promise.all([
      BlazingsqlModel.findOne({ EXPERIMENT_NAME }),
      OmniscidbModel.findOne({ EXPERIMENT_NAME }),
      PgstromModel.findOne({ EXPERIMENT_NAME })
    ]);

    if(experiment1 || experiment2 || experiment3) {
      return false;
    } else {
      return true;
    }
  } catch(err) {
    throw err;
  }
};

module.exports = verifyExperimentName;

const Query = `
  {
    getExperimentsListByDB(STATUS: String, DBMS: String): [Experiment]
    getExperiment(ExperimentId: String, DBMS: String): Experiment
    verifyExperimentName(EXPERIMENT_NAME: String): Boolean
  }
`;

module.exports = Query;
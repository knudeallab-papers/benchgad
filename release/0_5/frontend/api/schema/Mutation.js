const Mutation = `
  {
    createExperiment(EXPERIMENT_NAME: String, DBMS: [String], IM: String, CF: String, RAM_Size: Int, Gen: [Generation], DB_Size: Int, Q_Set: [String], Number_Of_Q_Execution: Int): Boolean
  }
`;

module.exports = Mutation;
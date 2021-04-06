const experiment = `
  {
    _id: String
    EXPERIMENT_NAME: String
    WORK_LOAD: String
    IM: String
    CF: String
    MG: String
    RAM_Size: Int
    Gen: [Generation]
    GM: String
    IC: String
    DB_Size: Int
    Q_Set: [String]
    Number_Of_Q_Execution: Int
    HDT: Float
    DHT: Float
    PF: Float
    NumIK: Int
    KT: Float
    GPU_Utilization: Float
    ET: Float
    ETN:  Float
    OV: Float
    STATUS: String
    CREATED_AT: Float
  }
`;

module.exports = experiment;

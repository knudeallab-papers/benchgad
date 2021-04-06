import { gql } from 'apollo-boost';

const VERIFY_EXPERIMENT_NAME = gql`
  query VerifyExperimentName($EXPERIMENT_NAME: String){
    verifyExperimentName(EXPERIMENT_NAME: $EXPERIMENT_NAME)
  }
`;

const CREATE_TEST = gql`
  mutation CreateExperiment($EXPERIMENT_NAME: String, $DBMS: [String], $RAM_Size: Int, $Gen: [Generation], $DB_Size: Int, $Q_Set: [String], $Number_Of_Q_Execution: Int){
    createExperiment(EXPERIMENT_NAME: $EXPERIMENT_NAME, DBMS: $DBMS, RAM_Size: $RAM_Size, Gen: $Gen, DB_Size: $DB_Size, Q_Set: $Q_Set, Number_Of_Q_Execution: $Number_Of_Q_Execution)
  }
`;

const GET_EXPERIMENTS_LIST_BY_DB = gql`
  query GetExperimentsListByDB($STATUS: String, $DBMS: String) {
    getExperimentsListByDB(STATUS: $STATUS, DBMS: $DBMS) {
      _id
      EXPERIMENT_NAME
      WORK_LOAD
      IM
      CF
      MG
      RAM_Size
      Gen
      GM
      IC
      DB_Size
      Q_Set
      HDT
      DHT
      PF
      NumIK
      KT
      GPU_Utilization
      ET
      ETN:
      OV
      STATUS
      CREATED_AT
    }
  }
`;

const queries = {
  CREATE_TEST,
  VERIFY_EXPERIMENT_NAME,
  GET_EXPERIMENTS_LIST_BY_DB,
}

export default queries;
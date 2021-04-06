const BlazingsqlModel = require('../../models/blazingsql');
const OmniscidbModel = require('../../models/omniscidb');
const PgstromModel = require('../../models/pgstrom');

const sendMail = require('../../utils/sendMail');

const createExperiment = async ({
  EXPERIMENT_NAME,
  DBMS,
  RAM_Size,
  Gen,
  DB_Size,
  Q_Set,
  Number_Of_Q_Execution,
}) => {
  try {
    const payload = {
      EXPERIMENT_NAME,
      WORK_LOAD: 'TPC-H',
      MG: 'not used',
      RAM_Size,
      Gen,
      GM: '',
      IC: '',
      DB_Size,
      Q_Set,
      Number_Of_Q_Execution,
      HDT: 0,
      DHT: 0,
      PF: 0,
      NumIK: 0,
      KT: 0,
      GPU_Utilization: 0,
      ET: 0,
      ETN: 0,
      OV: 0,
      STATUS: "Pending",
      CREATED_AT: new Date().getTime(),
    }
  
    if (DBMS.includes("BlazingSQL")) {
      const valid = await BlazingsqlModel.findOne({
        RAM_Size,
        Gen,
        DB_Size,
        Q_Set,
      });

      if(valid) throw new Error('ALREADY_EXIST_SPEC');

      const newExperminet = new BlazingsqlModel(payload);
      await newExperminet.save();

      sendMail({
        subject: 'Experiment Request: BlazingSQL',
        html: `
          <p>{</p>
          <p>&nbsp;&nbsp;_id: ${newExperminet._id}</p>
          <p>&nbsp;&nbsp;EXPERIMENT_NAME: ${EXPERIMENT_NAME}</p>
          <p>&nbsp;&nbsp;WORK_LOAD: TPC-H</p>
          <p>&nbsp;&nbsp;IM: ""</p>
          <p>&nbsp;&nbsp;CF: ""</p>
          <p>&nbsp;&nbsp;MG: "not used"</p>
          <p>&nbsp;&nbsp;RAM_Size: ${RAM_Size}</p>
          <p>&nbsp;&nbsp;Gen: ${Gen}</p>
          <p>&nbsp;&nbsp;DB_Size: ${DB_Size}</p>
          <p>&nbsp;&nbsp;Q_Set: ${Q_Set}</p>
          <p>&nbsp;&nbsp;Number_Of_Q_Execution: ${Number_Of_Q_Execution}</p>
          <p>&nbsp;&nbsp;HDT: 0</p>
          <p>&nbsp;&nbsp;DHT: 0</p>
          <p>&nbsp;&nbsp;PF: 0</p>
          <p>&nbsp;&nbsp;NumIK: 0</p>
          <p>&nbsp;&nbsp;KT: 0</p>
          <p>&nbsp;&nbsp;GPU_Utilization: 0</p>
          <p>&nbsp;&nbsp;ET: 0</p>
          <p>&nbsp;&nbsp;ETN: 0</p>
          <p>&nbsp;&nbsp;OV: 0</p>
          <p>&nbsp;&nbsp;STATUS: "Pending"</p>
          <p>&nbsp;&nbsp;CREATED_AT: ${payload.CREATED_AT}</p>
          <p>}</p>
        `
      });
    }
    if (DBMS.includes("OmniSci")) {
      const valid = await OmniscidbModel.findOne({
        RAM_Size,
        Gen,
        DB_Size,
        Q_Set,
      });

      if(valid) throw new Error('ALREADY_EXIST_SPEC');

      const newExperminet = new OmniscidbModel(payload);
      await newExperminet.save();

      sendMail({
        subject: 'Experiment Request: OmniSci',
        html: `
          <p>{</p>
          <p>&nbsp;&nbsp;_id: ${newExperminet._id}</p>
          <p>&nbsp;&nbsp;EXPERIMENT_NAME: ${EXPERIMENT_NAME}</p>
          <p>&nbsp;&nbsp;WORK_LOAD: TPC-H</p>
          <p>&nbsp;&nbsp;IM: ""</p>
          <p>&nbsp;&nbsp;CF: ""</p>
          <p>&nbsp;&nbsp;MG: "not used"</p>
          <p>&nbsp;&nbsp;RAM_Size: ${RAM_Size}</p>
          <p>&nbsp;&nbsp;Gen: ${Gen}</p>
          <p>&nbsp;&nbsp;DB_Size: ${DB_Size}</p>
          <p>&nbsp;&nbsp;Q_Set: ${Q_Set}</p>
          <p>&nbsp;&nbsp;Number_Of_Q_Execution: ${Number_Of_Q_Execution}</p>
          <p>&nbsp;&nbsp;HDT: 0</p>
          <p>&nbsp;&nbsp;DHT: 0</p>
          <p>&nbsp;&nbsp;PF: 0</p>
          <p>&nbsp;&nbsp;NumIK: 0</p>
          <p>&nbsp;&nbsp;KT: 0</p>
          <p>&nbsp;&nbsp;GPU_Utilization: 0</p>
          <p>&nbsp;&nbsp;ET: 0</p>
          <p>&nbsp;&nbsp;ETN: 0</p>
          <p>&nbsp;&nbsp;OV: 0</p>
          <p>&nbsp;&nbsp;STATUS: "Pending"</p>
          <p>&nbsp;&nbsp;CREATED_AT: ${payload.CREATED_AT}</p>
          <p>}</p>
        `
      });
    }
    if (DBMS.includes("PG-Strom")) {
      const valid = await PgstromModel.findOne({
        RAM_Size,
        Gen,
        DB_Size,
        Q_Set,
      });

      if(valid) throw new Error('ALREADY_EXIST_SPEC');

      const newExperminet = new PgstromModel(payload);
      await newExperminet.save();

      sendMail({
        subject: 'Experiment Request: PG-Strom',
        html: `
          <p>{</p>
          <p>&nbsp;&nbsp;_id: ${newExperminet._id}</p>
          <p>&nbsp;&nbsp;EXPERIMENT_NAME: ${EXPERIMENT_NAME}</p>
          <p>&nbsp;&nbsp;WORK_LOAD: TPC-H</p>
          <p>&nbsp;&nbsp;IM: ""</p>
          <p>&nbsp;&nbsp;CF: ""</p>
          <p>&nbsp;&nbsp;MG: "not used"</p>
          <p>&nbsp;&nbsp;RAM_Size: ${RAM_Size}</p>
          <p>&nbsp;&nbsp;Gen: ${Gen}</p>
          <p>&nbsp;&nbsp;DB_Size: ${DB_Size}</p>
          <p>&nbsp;&nbsp;Q_Set: ${Q_Set}</p>
          <p>&nbsp;&nbsp;Number_Of_Q_Execution: ${Number_Of_Q_Execution}</p>
          <p>&nbsp;&nbsp;HDT: 0</p>
          <p>&nbsp;&nbsp;DHT: 0</p>
          <p>&nbsp;&nbsp;PF: 0</p>
          <p>&nbsp;&nbsp;NumIK: 0</p>
          <p>&nbsp;&nbsp;KT: 0</p>
          <p>&nbsp;&nbsp;GPU_Utilization: 0</p>
          <p>&nbsp;&nbsp;ET: 0</p>
          <p>&nbsp;&nbsp;ETN: 0</p>
          <p>&nbsp;&nbsp;OV: 0</p>
          <p>&nbsp;&nbsp;STATUS: "Pending"</p>
          <p>&nbsp;&nbsp;CREATED_AT: ${payload.CREATED_AT}</p>
          <p>}</p>
        `
      });
    }
  
    return true;
  } catch (err) {
    throw err;
  }
}

module.exports = createExperiment;
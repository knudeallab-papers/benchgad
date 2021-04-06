const DATABASE_SCHEMA = {
  EXPERIMENT_NAME: { type: String },
  WORK_LOAD: { type: String },
  IM: { type: String },
  CF: { type: String },
  MG: { type: String },
  RAM_Size: { type: Number },
  Gen: [],
  GM: { type: String },
  IC: { type: String },
  DB_Size: { type:Number, default: 1 },
  Q_Set: [],
  Number_Of_Q_Execution: { type: Number, default: 0 },
  HDT: { type: Number, default: 0 },
  DHT: { type: Number , default: 0 },
  PF: { type: Number , default: 0 },
  NumIK: { type: Number , default: 0 },
  KT: { type: Number , default: 0 },
  GPU_Utilization: { type: Number , default: 0 },
  ET: { type: Number , default: 0 },
  ETN:  { type: Number , default: 0 },
  OV: { type: Number , default: 0 },
  STATUS: { type: String, default: 'Pending' },
  CREATED_AT: { type: Number, default: 0 },
};

module.exports = {
  DATABASE_SCHEMA,
};
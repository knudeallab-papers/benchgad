const { STATES } = require('mongoose');
const BlazingsqlModel = require('../../models/blazingsql');
const OmniscidbModel = require('../../models/omniscidb');
const PgstromModel = require('../../models/pgstrom');

const getExperimentsListByDB = async ({ STATUS, DBMS }) => {
  let condition = { $or:  [{ STATUS: 'Pending' }, { STATUS: 'Executing' }] };

  if(STATUS === "Completed") {
    condition = { STATUS: 'Completed' };
  }

  console.log(STATUS);
  console.log(condition);
  let list = [];

  if (DBMS === "BlazingSQL") {
    list = await BlazingsqlModel.find(condition).sort('-CREATED_AT');
  } else if (DBMS === "OmniSci") {
    list = await OmniscidbModel.find().or(condition).sort('-CREATED_AT');
  } else if (DBMS === "PG-Strom") {
    list = await PgstromModel.find().or(condition).sort('-CREATED_AT');
  }

  return list ? list : [];
};

module.exports = getExperimentsListByDB;

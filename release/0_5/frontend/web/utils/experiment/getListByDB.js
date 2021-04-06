import getApolloClient from 'utils/common/getApolloClient';
import queries from 'configs/queries';

const getExperimentsListByDB = async (payload, setter) => {
  try {
    const client = getApolloClient();

    const {
      STATUS,
      DBMS,
    } = payload;

    const { data } = await client.query({
      query: queries.GET_EXPERIMENTS_LIST_BY_DB,
      variables: {
        STATUS,
        DBMS,
      }
    });

    
    setter(data.getExperimentsListByDB);
    return data.getExperimentsListByDB;
  } catch (err) {
    throw err;
  }
}

export default getExperimentsListByDB;
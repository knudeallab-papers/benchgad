import getApolloClient from 'utils/common/getApolloClient';
import queries from 'configs/queries';

const verifyExperimentName = async (payload, onSuccess, onError) => {
  try {
    const client = getApolloClient();

    const {
      EXPERIMENT_NAME
    } = payload;

    const { data } = await client.query({
      query: queries.VERIFY_EXPERIMENT_NAME,
      variables: {
        EXPERIMENT_NAME,
      }
    });
  
    onSuccess(data.verifyExperimentName);
  } catch (err) {
    onError();
    throw err;
  }
}

export default verifyExperimentName;
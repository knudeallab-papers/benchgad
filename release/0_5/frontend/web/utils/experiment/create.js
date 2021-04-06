import getApolloClient from 'utils/common/getApolloClient';
import queries from 'configs/queries';

const createExperiment = async (payload, onSuccess, onError) => {
  try {
    const {
      EXPERIMENT_NAME,
      DBMS,
      RAM_Size,
      Gen,
      DB_Size,
      Q_Set,
      Number_Of_Q_Execution,
    } = payload;

    const client = getApolloClient();

    await client.mutate({
      mutation: queries.CREATE_TEST,
      variables: {
        EXPERIMENT_NAME,
        DBMS,
        RAM_Size,
        Gen,
        DB_Size,
        Q_Set,
        Number_Of_Q_Execution,
      },
    });
    
    alert('Generate is successfully.');
    onSuccess();
  } catch (err) {
    if(err.message === 'GraphQL error: ALREADY_EXIST_SPEC') {
      alert('Already exist spec');
      return;
    }
    onError();
    throw err;
  }
}

export default createExperiment;
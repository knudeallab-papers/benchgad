import ApolloClient from 'apollo-boost';
import fetch from 'node-fetch';
import cache from 'configs/cache';

// const uri = 'http://localhost:58000/graphql';
const uri = 'http://155.230.36.20:58000/graphql';

const getApolloClient = () =>
  new ApolloClient({
    uri,
    cache,
    fetch,
  });

export default getApolloClient;
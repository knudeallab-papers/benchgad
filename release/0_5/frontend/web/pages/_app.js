import React from 'react';
import { ApolloProvider } from '@apollo/react-hooks';
import getApolloClient from 'utils/common/getApolloClient';

import '../styles/globals.css';

const App = ({ Component, pageProps }) => {
  return (
    <ApolloProvider client={getApolloClient()}>
      <Component {...pageProps} />
    </ApolloProvider>
  )
}

export default App

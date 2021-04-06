import React from 'react';
import Head from 'next/head';
import ReactLoading from 'react-loading';

import styles from './index.module.scss';

const LoadingView = () => {
  return (
    <div>
      <Head>
        <title>Loading...</title>
      </Head>
      <div className={styles['loading-wrapper']}>
        <ReactLoading width={120} height={120} />
      </div>
    </div>
  );
};

export default LoadingView;
import Head from 'next/head'
import React from 'react';
import Nav from 'components/Nav';

import styles from './index.module.scss'

const Layout = ({ children }) => {
  return (
    <div className={styles.container}>
      <Head>
        <title>SPA | BenchGAD</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <div className={styles.row}>
        <Nav />
        <div className={styles['rightsection-wrapper']}>
          {children}
        </div>
      </div>
    </div>
  )
}

export default Layout;
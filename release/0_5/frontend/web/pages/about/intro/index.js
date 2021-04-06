import React from 'react';

import Layout from 'components/Layout';

import styles from 'styles/Intro.module.scss';

const Intro = () => {
  return (
    <Layout>
      <div>
        <div className={styles['intro-nav-label']}>About -> Introduction</div>
        <div className={styles['intro-title']}>Introduction</div>
      </div>
    </Layout>
  )
}

export default Intro;
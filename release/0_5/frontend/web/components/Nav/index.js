import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import Link from 'next/link';

import styles from './index.module.scss';

const Nav = () => {
  const router = useRouter();
  const [activeTab, setActiveTab] = useState("/experiment/create");

  useEffect(() => {
    setActiveTab(router.route);
  }, []);

  return (
    <div className={styles['nav-wrapper']}>
      <div className={styles['nav-header']}>
        <div className={styles['logo']}>BenchGAD</div>
        <div className={styles['nav-tab-section']}>
          <Link href='/experiment/create'>
            <div className={styles[`${activeTab.indexOf('experiment') > -1 ? 'tab-active' : 'tab'}`]}>Experiment</div>
          </Link>
          <Link href='/analysis'>
            <div className={styles[`${activeTab.indexOf('analysis') > -1 ? 'tab-active' : 'tab'}`]}>Analysis</div>
          </Link>
        </div>
        <div />
      </div>
      <div className={styles['nav-contents']}>
      {
        router.route.indexOf('experiment') > -1
        ? (
          <>
          <Link href='/experiment/create'>
            <div className={styles[`${activeTab === '/experiment/create' ? 'tab-active' : 'tab'}`]}>Create an Experiment</div>
          </Link>
          <Link href='/experiment/monitor'>
            <div className={styles[`${activeTab === '/experiment/monitor' ? 'tab-active' : 'tab'}`]}>Monitor Experiments</div>
          </Link>
          <Link href='/experiment/complete'>
            <div className={styles[`${activeTab === '/experiment/complete' ? 'tab-active' : 'tab'}`]}>Completed Experiments</div>
          </Link>
          </>
        ) : router.route.indexOf('analysis') > -1
            ? (
              <>
              <Link href='/analysis'>
                <div className={styles[`${activeTab.indexOf('analysis') > -1 ? 'tab-active' : 'tab'}`]}>Experiment Data Analysis</div>
              </Link>
              </>
            ) : null
      }
      </div>
    </div>
  )
}

export default Nav;
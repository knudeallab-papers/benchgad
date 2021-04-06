import { useEffect, useState } from 'react';
import Skeleton from 'react-loading-skeleton';
import { useRouter } from 'next/router';

import Layout from 'components/Layout';

import getExperimentsListByDB from 'utils/experiment/getListByDB';

import styles from './index.module.scss';

const getTime = () => {
  const time = new Date();
  const year = time.getFullYear();
  const month = time.getMonth() + 1;
  const date = time.getDate();
  const hours = time.getHours();
  const minutes = time.getMinutes();
  const seconds = time.getSeconds();

  return `${year}. ${month}. ${date}. ${hours >= 10 
    ? hours : `0${hours}`}:${minutes >= 10 
      ? minutes : `0${minutes}`}:${seconds >= 10 
        ? seconds : `0${seconds}`}`;
}

const SkeletonList = () => {
  return (
    <>
      <div className={styles['loading-wrapper']}>
        <Skeleton width={872} height={46} />
      </div>
      <div className={styles['loading-wrapper']}>
        <Skeleton width={872} height={46} />
      </div>
      <div className={styles['loading-wrapper']}>
        <Skeleton width={872} height={46} />
      </div>
      <div className={styles['loading-wrapper']}>
        <Skeleton width={872} height={46} />
      </div>
    </>
  )
}

const CompletedExperiment = () => {
  const router = useRouter();
  const [blazingData, setBlazingData] = useState();
  const [omnisciData, setOmnisciData] = useState();
  const [pgstromData, setPgstromData] = useState();
  const [updateAt, setUpdateAt] = useState("0000. 00. 00. 00:00:00");
  const [tab, setTab] = useState('BlazingSQL');

  const getData = async() => {
    const [updated1, updated2, updated3] = await Promise.all([
      getExperimentsListByDB({
        STATUS: 'Completed',
        DBMS: 'BlazingSQL',
      }, setBlazingData),
      getExperimentsListByDB({
        STATUS: 'Completed',
        DBMS: 'OmniSci',
      }, setOmnisciData),
      getExperimentsListByDB({
        STATUS: 'Completed',
        DBMS: 'PG-Strom',
      }, setPgstromData)
    ]);

    return {
      updated1,
      updated2,
      updated3,
    };
  }

  useEffect(() => {
    getData();
    setUpdateAt(getTime());
  }, [])
  
  return (
    <Layout>
      <div className={styles['monitor-wrapper']}>
        <div className={styles['monitor-nav-label']}>Experiment -> Completed Experiments</div>
        <div className={styles['monitor-title-wrapper']}>
          <div className={styles['title']}>Completed Experiments</div>
          <div className={styles['time']} onClick={() => router.reload()}>
            <img src='/icon/reload.png' />
            <div>
              <div>Last Updated: {updateAt}</div>
              <div>(Update at the push of a button)</div>
            </div>
          </div>
          
        </div>
        <div className={styles['monitor-tab-wrapper']}>
          <div
            className={styles[`${tab === 'BlazingSQL' ? 'tab-active' : 'tab'}`]}
            onClick={() => setTab('BlazingSQL')}>
            BlazingSQL</div>
          <div
            className={styles[`${tab === 'OmniSci' ? 'tab-active' : 'tab'}`]}
            onClick={() => setTab('OmniSci')}>
            Omnisci</div>
          <div
            className={styles[`${tab === 'PG-Strom' ? 'tab-active' : 'tab'}`]}
            onClick={() => setTab('PG-Strom')}>
            PG-Strom</div>
        </div>
        {
          tab === 'BlazingSQL'
          ? (
            <div className={styles['monitor-result-wrapper']}>
              <div className={styles.label}>Current In BlazingSQL</div>
              <div className={styles['result-row-header']}>
                <div className={styles['width66']}>ID</div>
                <div className={styles['width122']}>Name</div>
                <div className={styles['width88']}>Workload</div>
                <div className={styles['width88']}>Multi-GPU</div>
                <div className={styles['width88']}>RAM-Size</div>
                <div className={styles['width122']}>Generation</div>
                <div className={styles['width88']}>DB-Size</div>
                <div className={styles['width122']}>Query Number</div>
                <div className={styles['width88']}>STATUS</div>
              </div>
              <div className={styles['result-column']}>
              {
                blazingData
                ? (
                  <>
                  {
                    blazingData.map((data, index) => (
                      <div key={String(index)} className={styles['result-row']}>
                        <div className={styles['width66']}>{index + 1}</div>
                        <div className={styles['width122']}>{data.EXPERIMENT_NAME}</div>
                        <div className={styles['width88']}>TPC-H</div>
                        <div className={styles['width88']}>{data.MG}</div>
                        <div className={styles['width88']}>{data.RAM_Size}</div>
                        <div className={styles['width122']}>{data.Gen.length > 1 ? `${data.Gen[0].Gen}, ${data.Gen[1].Gen}` : data.Gen[0].Gen}</div>
                        <div className={styles['width88']}>{data.DB_Size}</div>
                        <div className={styles['width122']}>{data.Q_Set.join(', ')}</div>
                        <div className={styles['width88']}>{data.STATUS}</div>
                      </div>
                    ))
                  }
                  </>
                ) : <SkeletonList />
              }
              </div>
            </div>
          ) : tab === 'OmniSci'
              ? (
                <div className={styles['monitor-result-wrapper']}>
                  <div className={styles.label}>Current In OmniSci</div>
                  <div className={styles['result-row-header']}>
                    <div className={styles['width66']}>ID</div>
                    <div className={styles['width122']}>Name</div>
                    <div className={styles['width88']}>Workload</div>
                    <div className={styles['width88']}>Multi-GPU</div>
                    <div className={styles['width88']}>RAM-Size</div>
                    <div className={styles['width122']}>Generation</div>
                    <div className={styles['width88']}>DB-Size</div>
                    <div className={styles['width122']}>Query Number</div>
                    <div className={styles['width88']}>STATUS</div>
                  </div>
                  <div className={styles['result-column']}>
                  {
                    omnisciData
                    ? (
                      <>
                      {
                        omnisciData.map((data, index) => (
                          <div key={String(index)} className={styles['result-row']}>
                            <div className={styles['width66']}>{index + 1}</div>
                            <div className={styles['width122']}>{data.EXPERIMENT_NAME}</div>
                            <div className={styles['width88']}>TPC-H</div>
                            <div className={styles['width88']}>{data.MG}</div>
                            <div className={styles['width88']}>{data.RAM_Size}</div>
                            <div className={styles['width122']}>{data.Gen.length > 1 ? `${data.Gen[0].Gen}, ${data.Gen[1].Gen}` : data.Gen[0].Gen}</div>
                            <div className={styles['width88']}>{data.DB_Size}</div>
                            <div className={styles['width122']}>{data.Q_Set.join(', ')}</div>
                            <div className={styles['width88']}>{data.STATUS}</div>
                          </div>
                        ))
                      }
                      </>
                    ) : <SkeletonList />
                  }
                  </div>
                </div>
              ) : tab === 'PG-Strom'
                  ? (
                    <div className={styles['monitor-result-wrapper']}>
                      <div className={styles.label}>Current In PG-Strom</div>
                      <div className={styles['result-row-header']}>
                        <div className={styles['width66']}>ID</div>
                        <div className={styles['width122']}>Name</div>
                        <div className={styles['width88']}>Workload</div>
                        <div className={styles['width88']}>Multi-GPU</div>
                        <div className={styles['width88']}>RAM-Size</div>
                        <div className={styles['width122']}>Generation</div>
                        <div className={styles['width88']}>DB-Size</div>
                        <div className={styles['width122']}>Query Number</div>
                        <div className={styles['width88']}>STATUS</div>
                      </div>
                      <div className={styles['result-column']}>
                      {
                        pgstromData
                        ? (
                          <>
                          {
                            pgstromData.map((data, index) => (
                              <div key={String(index)} className={styles['result-row']}>
                                <div className={styles['width66']}>{index + 1}</div>
                                <div className={styles['width122']}>{data.EXPERIMENT_NAME}</div>
                                <div className={styles['width88']}>TPC-H</div>
                                <div className={styles['width88']}>{data.MG}</div>
                                <div className={styles['width88']}>{data.RAM_Size}</div>
                                <div className={styles['width122']}>{data.Gen.length > 1 ? `${data.Gen[0].Gen}, ${data.Gen[1].Gen}` : data.Gen[0].Gen}</div>
                                <div className={styles['width88']}>{data.DB_Size}</div>
                                <div className={styles['width122']}>{data.Q_Set.join(', ')}</div>
                                <div className={styles['width88']}>{data.STATUS}</div>
                              </div>
                            ))
                          }
                          </>
                        ) : <SkeletonList />
                      }
                      </div>
                    </div>
                  ) : null
        }
      </div>
    </Layout>
  )
}

export default CompletedExperiment;

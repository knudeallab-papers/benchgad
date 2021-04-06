import { PEOPLE_HISTORY } from 'configs/constants';

import Layout from 'components/Layout';

import styles from 'styles/People.module.scss';

const People = () => {
  return (
    <Layout>
      <div>
        <div className={styles['people-nav-label']}>About -> People</div>
        <div className={styles['people-title']}>People</div>
        {
          PEOPLE_HISTORY.map((person, index) => (
            <div className={styles['people-wrapper']}>
              <div className={styles.row}>
                <img src='icon/arrow-right.png' className={styles.icon} />
                <div className={styles.label}>{person.label}</div>
              </div>
              <div className={styles.row}>
                <div className={styles['people-thumbnail']} />
                <div className={styles['people-content-wrapper']}>
                  <div className={styles['people-content-left']}>
                    <div className={styles['people-content-title']}>{person.title}</div>
                    <div className={styles['people-content-subtitle']}>- Brief History -</div>
                    {
                      person.history
                        ? person.history.map((item, index) => <div key={String(index)} className={styles['people-content-history']}>* {item}</div>)
                        : null
                    }
                  </div>
                  <div className={styles['people-content-right']}>
                    <div className={styles['people-content-subtitle']}>Contact</div>
                    {
                      person.contact
                        ? person.contact.map((item, index) => <div key={String(index)} className={styles['people-content-history']}>{item}</div>)
                        : null
                    }
                    <div className={styles['people-link']}>
                      <a href={person.homepage ? person.homepage : null}>DKE Lab Homepage</a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          ))
        }
      </div>
    </Layout>
  )
}

export default People;
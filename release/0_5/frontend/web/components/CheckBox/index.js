import styles from './index.module.scss';

const CheckBox = ({
  label,
  isChecked,
  setIsChecked
}) => {
  return (
    <div className={styles['checkbox-inner']} onClick={() => setIsChecked(label)}>
      {
        isChecked === label ? (
          <>
            <img src='/icon/check-active.png' />
            <div className={styles['checkbox-label-active']}>{label}</div>
          </>
        ) : (
          <>
            <img src='/icon/check.png' />
            <div className={styles['checkbox-label']}>{label}</div>
          </>
        )
      }
    </div>
  )
}

export default CheckBox;
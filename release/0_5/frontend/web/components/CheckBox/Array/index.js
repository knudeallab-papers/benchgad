import styles from './index.module.scss';

const CheckBox = ({
  label,
  isCheckedArray,
  onClick,
}) => {
  return (
    <div className={styles['checkbox-inner']} onClick={onClick}>
      {
        isCheckedArray && isCheckedArray.length && isCheckedArray.indexOf(label) > -1 ? (
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
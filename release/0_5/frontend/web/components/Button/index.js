import styles from './index.module.scss';

const PrimaryButton = ({
  children,
  width,
  onClick
}) => {
  return (
    <div className={styles.button} style={{ width }} onClick={onClick}>
      {children}
    </div>
  )
}

export default PrimaryButton;
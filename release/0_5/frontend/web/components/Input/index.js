import styles from './index.module.scss';

const Input = ({
  labelName,
  type,
  maxLength,
  width,
  placehoder,
  onChange,
  value,
  onBlur,
  onKeyPress,
}) => {
  return (
    <>
    {
      labelName
      ? (
        <div className={styles['input-wrapper']} style={{ width }}>
          <div className={styles.label}>{labelName}</div>
          <input 
            className={styles.input}
            type={type}
            value={value}
            maxLength={maxLength}
            placeholder={placehoder} 
            onChange={onChange}
            onBlur={onBlur} 
            onKeyPress={onKeyPress} />
        </div>
      ) : (
        <input 
          style={{ width }}
          className={styles.input}
          type={type}
          value={value}
          maxLength={maxLength}
          placeholder={placehoder} 
          onChange={onChange}
          onBlur={onBlur} 
          onKeyPress={onKeyPress} />
      )
    }
    </>
  )
}

export default Input;
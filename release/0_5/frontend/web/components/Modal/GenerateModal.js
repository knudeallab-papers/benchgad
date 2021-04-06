import { useEffect, useState } from 'react';

import closeModal from 'utils/modal/close';

import styles from 'styles/Modal.module.scss';

const Modal = () => {
  const [email, setEmail] = useState("");
  const [availableEmail, setAvailableEmail] = useState(false);

  const handleSubmit = () => {
    closeModal();
  };

  const handleText = type => ({ target: { value } }) => {
    if (type === 'email') setEmail(value);
  }

  useEffect(() => {
    var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if (email.match(regExp) !== null) {
      setAvailableEmail(true);
    } else setAvailableEmail(false);
  }, [email]);

  return (
    <div className={styles.row}>
      <div className={styles['modal-wrapper']}>
        <div className={styles['modal-label']}>Send E-mail Address</div>
        <div className={styles['modal-subscription']}>We inform you when the experiment is completed</div>
        <div className={styles['modal-input-label']}>Your E-mail</div>
        <input className={styles['modal-input']} value={email} onChange={handleText('email')} />
        <div className={styles['modal-input-log']} style={{ color: `${availableEmail ? 'blue' : '#f0f0f0'}` }}>Available E-mail</div>
        <button disabled={availableEmail} className={styles['modal-submit-btn']} onClick={handleSubmit}>Send</button>
      </div>
      <div className={styles['modal-close']} onClick={closeModal}>&times;</div>
    </div>
  )
}

export default Modal;
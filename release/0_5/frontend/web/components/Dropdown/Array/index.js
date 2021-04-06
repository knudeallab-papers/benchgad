import queries from 'configs/queries';
import React, { useState, useRef } from 'react';

import styles from './index.module.scss';

const Dropdown = ({
  width,
  data,
  selected,
  setSelected,
  overflow,
}) => {
  const ref = useRef();
  const [isOpen, setIsOpen] = useState(false);

  const handleOpen = () => {
    if(isOpen) {
      ref.current.style.transfrom = "rotate(0)";
      ref.current.style.webkitTransform = "rotate(0)";
      ref.current.style.MozTransform = "rotate(0)";
      ref.current.style.msTransform = "rotate(0)";
      ref.current.style.OTransform = "rotate(0)";
      ref.current.style.transform = "rotate(0)";
    } else {
      ref.current.style.transfrom = "rotate(-180deg)";
      ref.current.style.webkitTransform = "rotate(-180deg)";
      ref.current.style.MozTransform = "rotate(-180deg)";
      ref.current.style.msTransform = "rotate(-180deg)";
      ref.current.style.OTransform = "rotate(-180deg)";
      ref.current.style.transform = "rotate(-180deg)";
    }
    setIsOpen(!isOpen);
  }

  const handleActive = query => () => {
    if (selected.includes(Number(query))) {
      const arr = selected.filter((arg, index, arr) => index !== selected.indexOf(Number(query)));
      setSelected(arr.sort(function (f, s) { return f-s; }));
    } else {
      const arr = [...selected, Number(query)];
      setSelected(arr.sort(function (f, s) { return f-s; }));
    }
  }

  return (
    <div
      style={{width}}
      className={styles[`dropdown-wrapper`]}
      onClick={handleOpen}
    >
      <div className={styles["dropdown-header"]}>
        <div className={styles["dropdown-header-title"]}>
          {selected.join(', ')}
        </div>
        <img 
          ref={ref}
          className={styles.arrow} 
          src="/icon/arrow-bottom.png" />
      </div>
      {isOpen && (
        <ul className={styles[`${overflow ? "dropdown-overflow-list" : "dropdown-list"}`]}>
          {data.map((v, i) => (
            <li
              style={{width}}
              className={styles[`dropdown-list-item${selected.includes(v) ? '-active' : ''}`]}
              key={String(i)}
              onClick={handleActive(v)} >
              {v}
            </li>
          ))}
        </ul>
      )}
    </div>
  )
};

export default Dropdown;
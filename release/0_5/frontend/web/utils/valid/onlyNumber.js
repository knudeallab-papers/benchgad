const onlyNumber = (value) => {
  const isValid = /^[0-9\b]+$/;
  return isValid.test(value);
};

export default onlyNumber;
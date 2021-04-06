const objectsEqual = (o1, o2) => {
  return typeof o1 === 'object' && Object.keys(o1).length > 0 
  ? Object.keys(o1).length === Object.keys(o2).length 
      && Object.keys(o1).every(p => objectsEqual(o1[p], o2[p]))
  : o1 === o2;
};

export default objectsEqual;
    
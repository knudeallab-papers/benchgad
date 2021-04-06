import objectsEqual from 'utils/check/objEqual';

const arraysEqual = (a1, a2) => {
  return a1.length === a2.length && a1.every((o, idx) => objectsEqual(o, a2[idx]));
};

export default arraysEqual;
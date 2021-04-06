const getTime = () => {
  const time = new Date();
  const year = time.getFullYear();
  const month = time.getMonth() + 1;
  const date = time.getDate();
  const hours = time.getHours();
  const minutes = time.getMinutes();

  return `${year}${month >= 10 ? month : `0${month}`}${date >= 10 ? date : `0${date}`}${hours >= 10 ? hours : `0${hours}`}${minutes >= 10 ? minutes : `0${minutes}`}`;
};

export default getTime;
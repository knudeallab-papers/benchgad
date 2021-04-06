import { useState, useEffect, useRef } from 'react';
import { useRouter } from 'next/router';

import LoadingView from 'components/LoadingView';
import Layout from 'components/Layout';
import Button from 'components/Button'; 

import { DEFAULT_RSCRIPT } from 'configs/constants';

import getTime from 'utils/time/get';

import styles from './index.module.scss';

const Analysis = () => {
  const uploadRef = useRef();
  const router = useRouter();
  const [file, setFile] = useState();
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState(DEFAULT_RSCRIPT);
  const [textData, setTextData] = useState(data.join('\n'));

  const handleText = type => ({ target: { value } }) => {
    if(type === 'text') setTextData(value);
  }

  const handleUpload = () => {
    let file = document.getElementById("upload-file").files[0];
    setFile(file);

    data[9] = data[9] + '"/' + file.name + '"';
    setData(data);
    setTextData(data.join('\n'));
  };

  const handleSubmit = () => {
    if(file) {
      setLoading(true);

      setTimeout(() => {
        const newFilename = `${getTime()}.R`;
        const element = document.createElement("a");
        const file = new Blob([textData],    
                    {type: 'text/plain;charset=utf-8'});
        element.href = URL.createObjectURL(file);
        element.download = newFilename;
        document.body.appendChild(element);
        element.click();
        setLoading(false);
      }, 1500);
    } else {
      alert('Empty File');
      return;
    }
  }

  const handleClear = () => {
    setFile(null);
  }

  if (loading) return <LoadingView />
  return (
    <Layout>
      <div className={styles['analysis-wrapper']}>
        <div className={styles['analysis-nav-label']}>Experiment Data Analysis -> Analyze Results</div>
        <div className={styles['analysis-title']}>Analyze Results</div>
        <div className={styles['analysis-contents']}>
          <div className={styles.label}>Upload File</div>
          <div className={styles['analysis-upload-wrapper']}>
            <div className={styles['upload-label']}>{file ? file.name : ''}</div>
            <div className={styles['upload-wrapper']}>
              <label htmlFor="upload-file">Upload</label>
              <input
                ref={uploadRef}
                type="file"
                name="file"
                id="upload-file"
                onChange={handleUpload}
                accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" />
            </div>
          </div>
          <div className={styles.label}>R Script</div>
          <div className={styles['rscript-section']}>
            {file && data
              ? (
                  <textarea className={styles['rscript-textarea-wrapper']}
                    onChange={handleText('text')}
                    value={textData}>
                    {textData}
                  </textarea>
              ) : <div className={styles['rscript-wrapper']} style={{ marginTop: '12px' }} />
            }
          </div>
          <div className={styles['rscript-btn-wrapper']}>
            <div className={styles['button-wrapper']}>
              <Button onClick={handleSubmit}>EXPORT</Button>
            </div>
            <Button onClick={handleClear}>CLEAR</Button>
          </div>
        </div>
      </div>
    </Layout >
  )
}

export default Analysis;
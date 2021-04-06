import React, { useEffect, useRef, useState } from 'react';
import { useRouter } from 'next/router';

import Input from 'components/Input';
import Button from 'components/Button';
import CheckBoxArray from 'components/CheckBox/Array';
import Dropdown from 'components/Dropdown';
import Layout from 'components/Layout';

import { RAM_SIZES, GENERATION_LIST } from 'configs/constants';

import verifyExperimentName from 'utils/experiment/verifyExperimentName';
import createExperiment from 'utils/experiment/create';
import onlyNumber from 'utils/valid/onlyNumber';

import styles from './index.module.scss';

const CreateExperiment = () => {
  const nameRef = useRef();
  const router = useRouter();
  const [step, setStep] = useState(0);
  const [moveStep3, setMoveStep3] = useState(false);
  const [moveStep5, setMoveStep5] = useState(false);
  const [experimentName, setExperimentName] = useState("");
  const [isValidName, setIsValidName] = useState(false);
  const [DBMS, setDBMS] = useState([]);
  const [RAM_Size, setRAM_Size] = useState(64);
  const [RAM_SIZE_CUSTOM, setRAM_SIZE_CUSTOM] = useState(0);
  const [DB_SIZE, setDB_SIZE] = useState(8);
  const [Gen, setGen] = useState("GTX 1080ti");
  const [GenCount, setGenCount] = useState(1);
  const [isMultiGen, setIsMultiGen] = useState(false);
  const [multiGen, setMultiGen] = useState("GTX 1080ti");
  const [multiGenCount, setMultiGenCount] = useState(1);
  const [Q_Set, setQ_Set] = useState([]);
  const [Number_Of_Q_Execution, setNumber_Of_Q_Execution] = useState(3);

  const handleText = type => ({ target: { value } }) => {
    if (type === 'name') setExperimentName(value);
    else if(type === 'RAM_SIZE' && onlyNumber(value)) setRAM_SIZE_CUSTOM(value);
    else if(type === 'DB_SIZE'&& onlyNumber(value)) setDB_SIZE(value);
  }

  const validStepper = type => () => {
    if(type === 'name' && experimentName && isValidName) {
      return true;
    } else if(type === 'DBMS' && DBMS.length) {
      return true;
    } else if(type === 'RAM_Size' && RAM_Size !== 0) {
      if(RAM_Size === 'CUSTOM' && RAM_SIZE_CUSTOM !== 0) {
        return true;
      } else false;
      return true;
    } else if(type === 'Gen' && Gen.length) {
      return true;
    } else if(type === 'DB_SIZE' && DB_SIZE !== 0) {
      return true;
    } else if(type === 'Q_Set' && Q_Set.length) {
      return true;
    } else return false;
  }

  const handlePrev = () => {
    if(step > 0) {
      setStep(step - 1);
    } else {
      alert('There is no page.');
    }
  };

  const handleNext = () => {
    if(step < 6) {
      setStep(step + 1);
    } else {
      alert('There is no page.');
    }
  }

  const handleDB = db => () => {
    const idx = DBMS.indexOf(db);
    if(idx > -1 && DBMS.length <= 4) {
      const temp = DBMS.filter((v) => v !== db);
      setDBMS([...temp]);
    } else if(idx < -1 && DBMS.length < 4) {
      setDBMS([...DBMS, db]);
    } else if(DBMS.length === 4) {
      alert('최대 4개까지 선택가능합니다');
    } else {
      setDBMS([...DBMS, db]);
    }
  };

  const handleQueries = query => () => {
    const idx = Q_Set.indexOf(query);
    if(idx > -1) {
      const temp = Q_Set.filter((v) => v !== query);
      setQ_Set([...temp]);
    } else {
      setQ_Set([...Q_Set, query]);
    }
  };

  const handleMultiGen = () => {
    if(GenCount === 2) {
      alert('Up to two can be entered.');
    } else {
      setIsMultiGen(true);
    }
  }

  const handleGenerate = async () => {
    const onSuccess = () => {
      router.reload();
    };
    const onError = () => {};

    const payload = {
      EXPERIMENT_NAME: experimentName,
      DBMS: DBMS,
      RAM_Size: RAM_Size === 'CUSTOM' ? Number(RAM_SIZE_CUSTOM) : Number(RAM_Size),
      Gen: isMultiGen 
        ? [{ Gen, count: GenCount }, { Gen: multiGen, count: multiGenCount }]
        : [{ Gen, count: GenCount }],
      DB_Size: Number(DB_SIZE),
      Q_Set,
      Number_Of_Q_Execution: Number(Number_Of_Q_Execution),
    };

    const message = confirm('Are you sure you want to start experimenting?');
    if(message) {
      if(!isValidName) {
        alert('Invalid Experiment Name.');
        step(0);
        return;
      }
      if(!experimentName || !DBMS.length) {
        alert('Please fill in all items.');
        return;
      }
      createExperiment(payload, onSuccess, onError);
    }
  }

  useEffect(() => {
    const onSuccess = (data) => {
      if(experimentName && data) {
        nameRef.current.style.opacity = 1;
        setIsValidName(true)
      } else {
        nameRef.current.style.opacity = 0;
        setIsValidName(false);
      }
    };
    const onError = () => {
      nameRef.current.style.opacity = 0;
      setIsValidName(false);
    };

    const payload = {
      EXPERIMENT_NAME: experimentName,
    }
    verifyExperimentName(payload, onSuccess, onError);
  }, [experimentName]);

  useEffect(() => {
    if(step === 2) {
      setMoveStep3(true);
    } else if(step === 4) {
      setMoveStep5(true);
    }
  }, [step]);

  return (
    <Layout>
      <div className={styles['create-wrapper']}>
        <div className={styles['create-nav-label']}>Experiment -> Create an Experiment</div>
        <div className={styles['create-title']}>Create an Experiment</div>
        {
          step === 0
          ? (
            <div className={styles['create-content-wrapper']}>
              <Input 
                labelName="Experiment Name" 
                width={180}
                type='text'
                maxLength={15}
                value={experimentName}
                onChange={handleText('name')} />
              <div ref={nameRef} className={styles['input-check-label']}>사용가능한 project이름입니다</div>
            </div>
          ) : step === 1 
          ? (
            <>
            <div className={styles['create-content-wrapper']}>
              <div className={styles.label}>DBMS</div>
              <div className={styles['create-check-wrapper']}>
                <CheckBoxArray
                  label="PG-Strom"
                  isCheckedArray={DBMS}
                  onClick={handleDB('PG-Strom')} />
                <CheckBoxArray
                  label="OmniSci"
                  isCheckedArray={DBMS}
                  onClick={handleDB('OmniSci')} />
                <CheckBoxArray
                  label="BlazingSQL"
                  isCheckedArray={DBMS}
                  onClick={handleDB('BlazingSQL')} />
              </div>
            </div>
            </>
          ) : step === 2
          ? (
            <>
            <div className={styles['create-content-wrapper']}>
              <div className={styles.label}>Ram Size</div>
              <Dropdown 
                data={RAM_SIZES} 
                selected={RAM_Size} 
                setSelected={setRAM_Size} />
              {
                RAM_Size === "CUSTOM"
                ? (
                  <div className={styles['inner-input-warpper']}>
                    <Input 
                        width={180}
                        type='text'
                        maxLength={8}
                        value={RAM_SIZE_CUSTOM}
                        placeholder="GB"
                        onChange={handleText('RAM_SIZE')} />
                  </div>
                ) : null
              }
            </div>
            </>
          ) :  step === 3
          ? (
            <>
            <div className={styles['create-content-wrapper']}>
              <div className={styles.label}>GPU Spec</div>
              <div>
                <div className={styles['dropdown-list']}>
                  <div className={styles['dropdown-wrapper']}>
                    <Dropdown 
                      data={GENERATION_LIST} 
                      selected={Gen} 
                      setSelected={setGen} />
                  </div>
                  <div className={styles['dropdown-wrapper']}>
                    <Dropdown 
                      data={[1,2]} 
                      selected={GenCount} 
                      setSelected={setGenCount} />
                  </div>
                </div>
                {
                  isMultiGen && GenCount !== 2
                  ? (
                    <div className={styles['dropdown-list']}>
                      <div className={styles['dropdown-wrapper']}>
                        <Dropdown 
                          data={GENERATION_LIST} 
                          selected={multiGen} 
                          setSelected={setMultiGen} />
                      </div>
                      <div className={styles['dropdown-wrapper']}>
                        <Dropdown 
                          data={[1,2]} 
                          selected={multiGenCount} 
                          setSelected={setMultiGenCount} />
                      </div>
                      <div className={styles['dropdown-action-label']} onClick={() => setIsMultiGen(false)}>삭제</div>
                    </div>
                  ) : (
                    <div className={styles['push-button']} onClick={handleMultiGen}>
                      <img src='/icon/plus.png' />
                      <div>Create</div>
                    </div>
                  )
                }
              </div>
            </div>
            </>
          ) : step === 4
          ? (
            <>
            <div className={styles['create-content-wrapper']}>
              <div className={styles.label}>DB Size</div>
              <Input 
                width={180}
                type='text'
                maxLength={8}
                value={DB_SIZE}
                onChange={handleText('DB_SIZE')} />
            </div>
            </>
          ) : step === 5
          ? (
            <>
            <div className={styles['create-content-wrapper']}>
              <div className={styles.label}>Query Set</div>
              <div className={styles['create-check-wrapper']}>
                <div className={styles['check-row']}>
                  <CheckBoxArray
                    label="Q1"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q1')} />
                  <CheckBoxArray
                    label="Q2"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q2')} />
                  <CheckBoxArray
                    label="Q3"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q3')} />
                  <CheckBoxArray
                    label="Q4"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q4')} />
                  <CheckBoxArray
                    label="Q5"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q5')} />
                  <CheckBoxArray
                    label="Q6"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q6')} />
                </div>
                <div className={styles['check-row']}>
                  <CheckBoxArray
                    label="Q7"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q7')} />
                  <CheckBoxArray
                    label="Q8"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q8')} />
                  <CheckBoxArray
                    label="Q9"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q9')} />
                  <CheckBoxArray
                    label="Q10"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q10')} />
                  <CheckBoxArray
                    label="Q11"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q11')} />
                  <CheckBoxArray
                    label="Q12"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q12')} />
                </div>
                <div className={styles['check-row']}>
                  <CheckBoxArray
                    label="Q13"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q13')} />
                  <CheckBoxArray
                    label="Q14"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q14')} />
                  <CheckBoxArray
                    label="Q15"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q15')} />
                  <CheckBoxArray
                    label="Q16"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q16')} />
                  <CheckBoxArray
                    label="Q17"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q17')} />
                  <CheckBoxArray
                    label="Q18"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q18')} />
                </div>
                <div className={styles['check-row']}>
                  <CheckBoxArray
                    label="Q19"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q19')} />
                  <CheckBoxArray
                    label="Q20"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q20')} />
                  <CheckBoxArray
                    label="Q21"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q21')} />
                  <CheckBoxArray
                    label="Q22"
                    isCheckedArray={Q_Set}
                    onClick={handleQueries('Q22')} />
                </div>
              </div>
              <div style={{ marginTop: '24px' }} className={styles.label}>Number Of Executions</div> 
              <Dropdown
                data={[3,5,10]} 
                selected={Number_Of_Q_Execution} 
                setSelected={setNumber_Of_Q_Execution} />
            </div>
            </>
          ) : step === 6
          ? (
            <div className={styles['create-content-wrapper']}>
              <div className={styles['json-wrapper']}>
                <div>Dataset = {'{'}</div>
                <div className={styles['key']}>EXPERIMENT_NAME: {experimentName ? experimentName : '""'},</div>
                <div className={styles['key']}>DBMS: {DBMS.length ? `[${DBMS.join(', ')}]` : JSON.stringify([])},</div>
                <div className={styles['key']}>RAM_Size: {RAM_Size === 'CUSTOM' ? Number(RAM_SIZE_CUSTOM) : Number(RAM_Size)},</div>
                <div className={styles['key']}>Gen: {JSON.stringify(isMultiGen 
                      ? [{ Gen, count: GenCount }, { Gen: multiGen, count: multiGenCount }]
                      : [{ Gen, count: GenCount }])},</div>
                <div className={styles['key']}>DB_Size: {Number(DB_SIZE)},</div>
                <div className={styles['key']}>Q_Set: {Q_Set.length ? `[${Q_Set.join(', ')}]` : JSON.stringify([])},</div>
                <div className={styles['key']}>Number_Of_Q_Execution: {Number_Of_Q_Execution}</div>
                <div>{'}'}</div>               
              </div>
            </div>
          ) : null
        }
        <div className={styles['create-stpper-wrapper']}>
          <div className={styles[`${!experimentName
            ? 'stepper-label'
            : validStepper('name')()
              ? 'stepper-success-label' 
              : 'stepper-fail-label'}`]}>1</div>
          <div className={styles[`${step > 0 ? 'bar-active' : 'bar'}`]} />
          <div className={styles[`${!DBMS.length 
            ? 'stepper-label' 
            : validStepper('DBMS')()
              ? 'stepper-success-label' 
              : 'stepper-fail-label'}`]}>2</div>
          <div className={styles[`${step > 1 ? 'bar-active' : 'bar'}`]} />
          <div className={styles[`${RAM_Size === 0 || !moveStep3
            ? 'stepper-label' 
            : validStepper('RAM_Size')()
              ? 'stepper-success-label' 
              : 'stepper-fail-label'}`]}>3</div>
          <div className={styles[`${step > 2 ? 'bar-active' : 'bar'}`]} />
          <div className={styles[`${!isMultiGen && GenCount === 1
            ? 'stepper-label' 
            : validStepper('Gen')()
              ? 'stepper-success-label' 
              : 'stepper-fail-label'}`]}>4</div>
          <div className={styles[`${step > 3 ? 'bar-active' : 'bar'}`]} />
          <div className={styles[`${DB_SIZE === 0 || !moveStep5
            ? 'stepper-label' 
            : validStepper('DB_SIZE')()
              ? 'stepper-success-label' 
              : 'stepper-fail-label'}`]}>5</div>
          <div className={styles[`${step > 4 ? 'bar-active' : 'bar'}`]} />
          <div className={styles[`${!Q_Set.length
            ? 'stepper-label' 
            : validStepper('Q_Set')()
              ? 'stepper-success-label' 
              : 'stepper-fail-label'}`]}>6</div>
          <div className={styles[`${step > 5 ? 'bar-active' : 'bar'}`]} />
          <div className={styles[`${step === 6 ? 'stepper-label2' : 'stepper-fail-label2'}`]}>confirm</div>
        </div>
        <div className={styles['create-stepper-button']}>
          <Button onClick={handlePrev}>Prev</Button>
          <div style={{ marginRight: '18px' }} />
          <Button onClick={handleNext}>Next</Button>
          {
            step === 6
            ? (
              <>
              <div style={{ marginRight: '18px' }} />
              <Button 
                width={180} 
                onClick={handleGenerate}>
                SUBMIT
              </Button>
              </>
            ) : null
          }
        </div>
      </div>
    </Layout>
  )
}

export default CreateExperiment;

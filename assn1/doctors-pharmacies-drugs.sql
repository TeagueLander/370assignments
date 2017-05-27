CREATE TABLE doctors (
  doctor_id INTEGER,
  name VARCHAR(60),
  specialty VARCHAR(60),
  years_experience INTEGER,
  CONSTRAINT pk_doctors PRIMARY KEY (doctor_id)
);

CREATE TABLE patients (
  healthcare_id INTEGER,
  name VARCHAR(60),
  address VARCHAR(120),
  age INTEGER,
  primary_doctor INTEGER,
  CONSTRAINT pk_patients PRIMARY KEY (healthcare_id),
  CONSTRAINT fk_doctors FOREIGN KEY (primary_doctor) REFERENCES doctors(doctor_id)
);

CREATE TABLE patient_doctors (
  patient_healthcare_id INTEGER,
  doctor_id INTEGER,
  CONSTRAINT pk_patient_doctors PRIMARY KEY (patient_healthcare_id, doctor_id),
  CONSTRAINT fk_pd_patients FOREIGN KEY (patient_healthcare_id) 
    REFERENCES patients(healthcare_id),
  CONSTRAINT fk_pd_doctors FOREIGN KEY (doctor_id) 
    REFERENCES doctors(doctor_id)
);

CREATE TABLE pharma_companies (
  name VARCHAR(60),
  phone_number VARCHAR(20),
  CONSTRAINT pk_pharma_companies PRIMARY KEY (name)
);

CREATE TABLE drugs (
  name VARCHAR(60),
  formula VARCHAR(200),
  pharma_company_name VARCHAR(60),
  CONSTRAINT pk_drugs PRIMARY KEY (name, pharma_company_name),
  CONSTRAINT fk_pharma_companies FOREIGN KEY (pharma_company_name) 
    REFERENCES pharma_companies(name)
);

CREATE TABLE pharmacies (
  name VARCHAR(60),
  address VARCHAR(120),
  phone_number VARCHAR(20),
  CONSTRAINT pk_pharmacies PRIMARY KEY (name)
);

CREATE TABLE pharmacy_drugs (
  pharmacy_name VARCHAR(60),
  drug_name VARCHAR(60),
  pharma_company_name VARCHAR(60),
  price NUMBER(2),
  CONSTRAINT pk_pharmacy_drugs PRIMARY KEY (pharmacy_name, drug_name, pharma_company_name),
  CONSTRAINT fk_pharmacies FOREIGN KEY (pharmacy_name) 
    REFERENCES pharmacies(name),
  CONSTRAINT fk_drugs FOREIGN KEY (drug_name, pharma_company_name) 
    REFERENCES drugs(name, pharma_company_name)
);

CREATE TABLE prescriptions (
  drug_name VARCHAR(60),
  pharma_company_name VARCHAR(60),
  patient_healthcare_id INTEGER,
  doctor_id INTEGER,
  quantity INTEGER,
  date_prescribed DATE,
  CONSTRAINT pk_prescriptions PRIMARY KEY (drug_name, patient_healthcare_id, doctor_id),
  CONSTRAINT fk_pres_drug_name FOREIGN KEY (drug_name, pharma_company_name) 
    REFERENCES drugs(name, pharma_company_name),
  CONSTRAINT fk_pres_patient_doctors FOREIGN KEY (patient_healthcare_id, doctor_id) 
    REFERENCES patient_doctors(patient_healthcare_id, doctor_id)
);

INSERT INTO doctors VALUES (94600, 'Lucy Hildebrande', 'Immunology', 12);
INSERT INTO doctors VALUES (94601, 'Jimminy Falkner', 'Psychiatry', 5);
INSERT INTO patients VALUES (1001, 'Johnny Smith', '1009 12th Street', 42, 94600);
INSERT INTO patient_doctors VALUES (1001, 94600);
INSERT INTO patient_doctors VALUES (1001, 94601);
INSERT INTO pharma_companies VALUES ('MCA Care', '(250) 893-4422');
INSERT INTO drugs 
    VALUES ('myocel-phorumulac', '1 part myoceliac, 3 parts phorumutlous', 'MCA Care');
INSERT INTO drugs 
    VALUES ('cyra-tubulix', '2 parts cyralis, 3 parts tubulous', 'MCA Care');
INSERT INTO pharmacies 
    VALUES ('West Coast Pharmacy #1', '1-299 Westside Rd., Victoria, BC', '(250) 999-3312');
INSERT INTO pharmacies 
    VALUES ('West Coast Pharmacy #2', '1482 Easter Rd., Duncan, BC', '(250) 123-7777');
INSERT INTO pharmacy_drugs 
    VALUES ('West Coast Pharmacy #1', 'myocel-phorumulac', 'MCA Care', 40.00);
INSERT INTO pharmacy_drugs 
    VALUES ('West Coast Pharmacy #2', 'myocel-phorumulac', 'MCA Care', 38.00);
INSERT INTO pharmacy_drugs 
    VALUES ('West Coast Pharmacy #1', 'cyra-tubulix', 'MCA Care', 20.00);
INSERT INTO prescriptions 
    VALUES ('myocel-phorumulac', 'MCA Care', 1001, 94600, 2, TO_DATE('2017/04/04', 'yyyy/mm/dd'));
INSERT INTO prescriptions 
    VALUES ('cyra-tubulix', 'MCA Care', 1001, 94601, 2, TO_DATE('2017/04/20', 'yyyy/mm/dd'));
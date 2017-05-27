DROP TABLE family_practice_doctors;
DROP TABLE hospital_doctors;
DROP TABLE family_practices;
DROP TABLE hospitals;
DROP TABLE doctors;

CREATE TABLE doctors (
  doctor_id INTEGER,
  name VARCHAR(60),
  specialty VARCHAR(60),
  years_experience INTEGER,
  CONSTRAINT pk_doctors PRIMARY KEY (doctor_id)
);

CREATE TABLE hospitals (
  name VARCHAR(60),
  address VARCHAR(60),
  phone_number VARCHAR(60),
  CONSTRAINT pk_hospitals PRIMARY KEY (name)
);

CREATE TABLE family_practices (
  name VARCHAR(60),
  address VARCHAR(60),
  phone_number VARCHAR(60),
  CONSTRAINT pk_family_practices PRIMARY KEY (address)
);

CREATE TABLE hospital_doctors (
  doctor_id INTEGER,
  hospital_name VARCHAR(60),
  CONSTRAINT pk_hospital_doctors PRIMARY KEY (doctor_id, hospital_name),
  CONSTRAINT fk_hd_doctor_id FOREIGN KEY (doctor_id) 
    REFERENCES doctors(doctor_id),
  CONSTRAINT fk_hd_hospital_name FOREIGN KEY (hospital_name) 
    REFERENCES hospitals(name)
);

CREATE TABLE family_practice_doctors (
  doctor_id INTEGER,
  family_practice_address VARCHAR(60),
  CONSTRAINT pk_family_practice_doctors PRIMARY KEY (doctor_id, family_practice_address),
  CONSTRAINT fk_fpd_doctor_id FOREIGN KEY (doctor_id) 
    REFERENCES doctors(doctor_id),
  CONSTRAINT fk_fpd_family_practice_address FOREIGN KEY (family_practice_address) 
    REFERENCES family_practices(address)
);

INSERT INTO doctors VALUES (3001, 'Flloyd Henderson', 'Cardiology', 24);
INSERT INTO hospitals VALUES ('Neonville General Hospital', '2221 Big Lights Way', '(240) 899-0765');
INSERT INTO family_practices VALUES ('Weston Cardiology Clinic', '2-188 Weston Rd.', '(240) 122-1475');
INSERT INTO hospital_doctors VALUES (3001, 'Neonville General Hospital');
INSERT INTO family_practice_doctors VALUES (3001, '2-188 Weston Rd.');
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(20)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(200),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


INSERT INTO clinics VALUES
('cnc-0100001','XYZ Clinic','Mumbai','Maharashtra','India'),
('cnc-0100002','ABC Clinic','Pune','Maharashtra','India'),
('cnc-0100003','PQR Clinic','Chennai','Tamil Nadu','India');

INSERT INTO customer VALUES
('bk-09f3e-95hj','Jon Doe','9700000000'),
('cust-002','Jane Smith','9800000000'),
('cust-003','Ravi Kumar','9900000000');

INSERT INTO clinic_sales VALUES
('ord-001','bk-09f3e-95hj','cnc-0100001',24999,'2021-09-23 12:03:22','online'),
('ord-002','cust-002','cnc-0100001',15000,'2021-09-25 10:00:00','walkin'),
('ord-003','cust-003','cnc-0100002',8000,'2021-10-01 11:00:00','online'),
('ord-004','bk-09f3e-95hj','cnc-0100002',5000,'2021-10-15 09:00:00','referral'),
('ord-005','cust-002','cnc-0100003',12000,'2021-11-10 14:00:00','walkin');

INSERT INTO expenses VALUES
('exp-001','cnc-0100001','first-aid supplies',557,'2021-09-23 07:36:48'),
('exp-002','cnc-0100001','staff salary',10000,'2021-09-30 08:00:00'),
('exp-003','cnc-0100002','utilities',2000,'2021-10-05 08:00:00'),
('exp-004','cnc-0100003','medicines',3000,'2021-11-10 08:00:00');
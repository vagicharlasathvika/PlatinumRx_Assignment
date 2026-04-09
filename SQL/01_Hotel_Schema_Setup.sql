CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);


CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);


INSERT INTO users VALUES
('21wrcxuy-67erfn', 'John Doe',   '97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('21wrcxuy-11aaa',  'Jane Smith', '98XXXXXXXX', 'jane.smith@example.com','YY, Street Z, DEF City'),
('21wrcxuy-22bbb',  'Bob Ray',    '96XXXXXXXX', 'bob.ray@example.com',   'ZZ, Street A, GHI City'),
('21wrcxuy-33ccc',  'Alice Wang', '95XXXXXXXX', 'alice.w@example.com',   'AA, Street B, JKL City'),
('21wrcxuy-44ddd',  'Tom Cruz',   '94XXXXXXXX', 'tom.c@example.com',     'BB, Street C, MNO City');


INSERT INTO items VALUES
('itm-a9e8-q8fu',  'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg',      89),
('itm-w978-23u4',  'Dal Fry',      75),
('itm-x111-aaaa',  'Paneer Curry', 120),
('itm-x222-bbbb',  'Butter Naan',  30),
('itm-x333-cccc',  'Lassi',        45),
('itm-x444-dddd',  'Masala Tea',   20);

INSERT INTO bookings VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o',   '2021-09-23 07:40:00', 'rm-cc11-bbbb',  '21wrcxuy-11aaa'),
('bk-oct1-0001',  '2021-10-05 09:00:00', 'rm-dd22-cccc',  '21wrcxuy-22bbb'),
('bk-oct2-0002',  '2021-10-10 10:00:00', 'rm-ee33-dddd',  '21wrcxuy-33ccc'),
('bk-oct3-0003',  '2021-10-15 11:00:00', 'rm-ff44-eeee',  '21wrcxuy-44ddd'),
('bk-oct4-0004',  '2021-10-20 12:00:00', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-nov1-0001',  '2021-11-02 08:00:00', 'rm-cc11-bbbb',  '21wrcxuy-11aaa'),
('bk-nov2-0002',  '2021-11-10 09:00:00', 'rm-dd22-cccc',  '21wrcxuy-22bbb'),
('bk-nov3-0003',  '2021-11-15 10:00:00', 'rm-ee33-dddd',  '21wrcxuy-33ccc'),
('bk-nov4-0004',  '2021-11-20 11:00:00', 'rm-ff44-eeee',  '21wrcxuy-44ddd');


INSERT INTO booking_commercials VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu',  3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4','bk-q034-q4o',   'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4',  0.5),

-- October bookings for test cases purposes
('oct-0001-aaa1',   'bk-oct1-0001',  'bl-oct1-0001',  '2021-10-05 13:00:00', 'itm-x111-aaaa',  2),
('oct-0001-aaa2',   'bk-oct1-0001',  'bl-oct1-0001',  '2021-10-05 13:00:00', 'itm-x222-bbbb',  3),
('oct-0002-bbb1',   'bk-oct2-0002',  'bl-oct2-0002',  '2021-10-10 14:00:00', 'itm-a9e8-q8fu',  5),
('oct-0002-bbb2',   'bk-oct2-0002',  'bl-oct2-0002',  '2021-10-10 14:00:00', 'itm-x333-cccc',  2),
('oct-0003-ccc1',   'bk-oct3-0003',  'bl-oct3-0003',  '2021-10-15 15:00:00', 'itm-a07vh-aer8', 4),
('oct-0003-ccc2',   'bk-oct3-0003',  'bl-oct3-0003',  '2021-10-15 15:00:00', 'itm-x444-dddd',  6),
('oct-0004-ddd1',   'bk-oct4-0004',  'bl-oct4-0004',  '2021-10-20 16:00:00', 'itm-x111-aaaa',  3),
('oct-0004-ddd2',   'bk-oct4-0004',  'bl-oct4-0004',  '2021-10-20 16:00:00', 'itm-w978-23u4',  2),

-- November bookings for test cases purposes
('nov-0001-eee1',   'bk-nov1-0001',  'bl-nov1-0001',  '2021-11-02 12:00:00', 'itm-a9e8-q8fu',  4),
('nov-0001-eee2',   'bk-nov1-0001',  'bl-nov1-0001',  '2021-11-02 12:00:00', 'itm-x222-bbbb',  2),
('nov-0002-fff1',   'bk-nov2-0002',  'bl-nov2-0002',  '2021-11-10 13:00:00', 'itm-a07vh-aer8', 3),
('nov-0002-fff2',   'bk-nov2-0002',  'bl-nov2-0002',  '2021-11-10 13:00:00', 'itm-x111-aaaa',  1),
('nov-0003-ggg1',   'bk-nov3-0003',  'bl-nov3-0003',  '2021-11-15 14:00:00', 'itm-x333-cccc',  5),
('nov-0003-ggg2',   'bk-nov3-0003',  'bl-nov3-0003',  '2021-11-15 14:00:00', 'itm-w978-23u4',  3),
('nov-0004-hhh1',   'bk-nov4-0004',  'bl-nov4-0004',  '2021-11-20 15:00:00', 'itm-x444-dddd',  4),
('nov-0004-hhh2',   'bk-nov4-0004',  'bl-nov4-0004',  '2021-11-20 15:00:00', 'itm-a9e8-q8fu',  6);
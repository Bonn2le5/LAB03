-- ============================================================
-- BÀI THỰC HÀNH ORACLE SQL BUỔI 1 — LỜI GIẢI THEO HƯỚNG DẪN
-- Schema: Hệ thống Bán Hàng
-- ============================================================


-- ============================================================
-- BÀI 1: TẠO LƯỢC ĐỒ CSDL VÀ NHẬP DỮ LIỆU
-- ============================================================
-- Thứ tự tạo bảng phải đúng (bảng cha trước bảng con):
-- s_region → s_title → s_dept → s_emp → s_customer
-- → s_image → s_longtext → s_product → s_ord → s_item
-- → s_warehouse → s_inventory

-- Xóa bảng nếu đã tồn tại (xóa con trước, cha sau)
DROP TABLE s_inventory  CASCADE CONSTRAINTS;
DROP TABLE s_item       CASCADE CONSTRAINTS;
DROP TABLE s_ord        CASCADE CONSTRAINTS;
DROP TABLE s_customer   CASCADE CONSTRAINTS;
DROP TABLE s_product    CASCADE CONSTRAINTS;
DROP TABLE s_image      CASCADE CONSTRAINTS;
DROP TABLE s_longtext   CASCADE CONSTRAINTS;
DROP TABLE s_emp        CASCADE CONSTRAINTS;
DROP TABLE s_warehouse  CASCADE CONSTRAINTS;
DROP TABLE s_dept       CASCADE CONSTRAINTS;
DROP TABLE s_title      CASCADE CONSTRAINTS;
DROP TABLE s_region     CASCADE CONSTRAINTS;

-- 1. Tạo bảng s_region
CREATE TABLE s_region (
    id   NUMBER(7)    CONSTRAINT s_region_id_pk PRIMARY KEY,
    name VARCHAR2(50) NOT NULL
);

-- 2. Tạo bảng s_title
CREATE TABLE s_title (
    title VARCHAR2(25) CONSTRAINT s_title_pk PRIMARY KEY
);

-- 3. Tạo bảng s_dept (FK → s_region)
CREATE TABLE s_dept (
    id        NUMBER(7)    CONSTRAINT s_dept_id_pk PRIMARY KEY,
    name      VARCHAR2(25) NOT NULL,
    region_id NUMBER(7)    CONSTRAINT s_dept_region_id_fk
    REFERENCES s_region(id)
);

-- 4. Tạo bảng s_emp (FK → s_dept, s_emp tự kết, s_title)
CREATE TABLE s_emp (
    id             NUMBER(7)     CONSTRAINT s_emp_id_pk PRIMARY KEY,
    last_name      VARCHAR2(25)  NOT NULL,
    first_name     VARCHAR2(25),
    userid         VARCHAR2(8)   CONSTRAINT s_emp_userid_uq UNIQUE,
    start_date     DATE,
    comments       VARCHAR2(255),
    manager_id     NUMBER(7)     CONSTRAINT s_emp_mgr_id_fk
                                     REFERENCES s_emp(id),
    title          VARCHAR2(25)  CONSTRAINT s_emp_title_fk
                                     REFERENCES s_title(title),
    dept_id        NUMBER(7)     CONSTRAINT s_emp_dept_id_fk
                                     REFERENCES s_dept(id),
    salary         NUMBER(11,2)  CONSTRAINT s_emp_salary_ck
                                     CHECK (salary > 0),
    commission_pct NUMBER(4,2)
);

-- 5. Tạo bảng s_warehouse (FK → s_region)
CREATE TABLE s_warehouse (
    id         NUMBER(7)    CONSTRAINT s_wh_id_pk PRIMARY KEY,
    region_id  NUMBER(7)    CONSTRAINT s_wh_region_id_fk
                                REFERENCES s_region(id),
    address    VARCHAR2(100),
    city       VARCHAR2(50),
    state      VARCHAR2(50),
    country    VARCHAR2(50),
    zip_code   VARCHAR2(20),
    phone      VARCHAR2(20),
    manager_id NUMBER(7)
);

-- 6. Tạo bảng s_customer (FK → s_emp, s_region)
CREATE TABLE s_customer (
    id            NUMBER(7)    CONSTRAINT s_cust_id_pk PRIMARY KEY,
    name          VARCHAR2(100) NOT NULL,
    phone         VARCHAR2(20),
    address       VARCHAR2(100),
    city          VARCHAR2(50),
    state         VARCHAR2(50),
    country       VARCHAR2(50),
    zip_code      VARCHAR2(20),
    credit_rating VARCHAR2(20),
    sales_rep_id  NUMBER(7)    CONSTRAINT s_cust_srep_id_fk
                                   REFERENCES s_emp(id),
    region_id     NUMBER(7)    CONSTRAINT s_cust_region_id_fk
                                   REFERENCES s_region(id),
    comments      VARCHAR2(255)
);

-- 7. Tạo bảng s_image
CREATE TABLE s_image (
    id           NUMBER(7)    CONSTRAINT s_image_id_pk PRIMARY KEY,
    format       VARCHAR2(20),
    use_filename VARCHAR2(1),
    filename     VARCHAR2(100),
    image        BLOB
);

-- 8. Tạo bảng s_longtext
CREATE TABLE s_longtext (
    id           NUMBER(7)    CONSTRAINT s_longtext_id_pk PRIMARY KEY,
    use_filename VARCHAR2(1),
    filename     VARCHAR2(100),
    text         CLOB
);

-- 9. Tạo bảng s_product (FK → s_longtext, s_image)
CREATE TABLE s_product (
    id                    NUMBER(7)     CONSTRAINT s_prod_id_pk PRIMARY KEY,
    name                  VARCHAR2(100) NOT NULL,
    short_desc            VARCHAR2(255),
    longtext_id           NUMBER(7)     CONSTRAINT s_prod_ltext_id_fk
                                            REFERENCES s_longtext(id),
    image_id              NUMBER(7)     CONSTRAINT s_prod_image_id_fk
                                            REFERENCES s_image(id),
    suggested_whlsl_price NUMBER(10,2),
    whlsl_units           VARCHAR2(50)
);

-- 10. Tạo bảng s_ord (FK → s_customer, s_emp)
CREATE TABLE s_ord (
    id           NUMBER(7)    CONSTRAINT s_ord_id_pk PRIMARY KEY,
    customer_id  NUMBER(7)    CONSTRAINT s_ord_cust_id_fk
                                  REFERENCES s_customer(id),
    date_ordered DATE,
    date_shipped DATE,
    sales_rep_id NUMBER(7)    CONSTRAINT s_ord_srep_id_fk
                                  REFERENCES s_emp(id),
    total        NUMBER(12,2),
    payment_type VARCHAR2(20),
    order_filled VARCHAR2(1)
);

-- 11. Tạo bảng s_item (PK kép, FK → s_ord, s_product)
CREATE TABLE s_item (
    ord_id           NUMBER(7)   CONSTRAINT s_item_ord_id_fk
                                     REFERENCES s_ord(id),
    item_id          NUMBER(7),
    product_id       NUMBER(7)   CONSTRAINT s_item_prod_id_fk
                                     REFERENCES s_product(id),
    price            NUMBER(10,2),
    quantity         NUMBER,
    quantity_shipped NUMBER,
    CONSTRAINT s_item_pk PRIMARY KEY (ord_id, item_id)
);

-- 12. Tạo bảng s_inventory (PK kép, FK → s_product, s_warehouse)
CREATE TABLE s_inventory (
    product_id               NUMBER(7)    CONSTRAINT s_inv_prod_id_fk
                                              REFERENCES s_product(id),
    warehouse_id             NUMBER(7)    CONSTRAINT s_inv_wh_id_fk
                                              REFERENCES s_warehouse(id),
    amount_in_stock          NUMBER,
    reorder_point            NUMBER,
    max_in_stock             NUMBER,
    out_of_stock_explanation VARCHAR2(255),
    restock_date             DATE,
    CONSTRAINT s_inventory_pk PRIMARY KEY (product_id, warehouse_id)
);


INSERT INTO s_region VALUES (1, 'North America');
INSERT INTO s_region VALUES (2, 'South America');
INSERT INTO s_region VALUES (3, 'Asia');
INSERT INTO s_region VALUES (4, 'Europe/Africa');
COMMIT;
 

INSERT INTO s_title VALUES ('President');
INSERT INTO s_title VALUES ('VP, Operations');
INSERT INTO s_title VALUES ('VP, Sales');
INSERT INTO s_title VALUES ('VP, Finance');
INSERT INTO s_title VALUES ('Director');
INSERT INTO s_title VALUES ('Manager');
INSERT INTO s_title VALUES ('Stock Clerk');
INSERT INTO s_title VALUES ('Sales Representative');
INSERT INTO s_title VALUES ('Warehouse Manager');
INSERT INTO s_title VALUES ('Accountant');
INSERT INTO s_title VALUES ('Secretary');
INSERT INTO s_title VALUES ('HR Manager');
INSERT INTO s_title VALUES ('IT Staff');
INSERT INTO s_title VALUES ('Marketing Rep');
INSERT INTO s_title VALUES ('Analyst');
COMMIT;
 
-- -------------------------------------------------------
-- s_dept (15 phòng ban)
-- -------------------------------------------------------
INSERT INTO s_dept VALUES (10,  'Finance',          1);
INSERT INTO s_dept VALUES (20,  'HR',               1);
INSERT INTO s_dept VALUES (31,  'Sales',            1);
INSERT INTO s_dept VALUES (32,  'Sales',            2);
INSERT INTO s_dept VALUES (33,  'Sales',            3);
INSERT INTO s_dept VALUES (34,  'Sales',            4);
INSERT INTO s_dept VALUES (41,  'Operations',       1);
INSERT INTO s_dept VALUES (42,  'Operations',       2);
INSERT INTO s_dept VALUES (43,  'Operations',       3);
INSERT INTO s_dept VALUES (44,  'Operations',       4);
INSERT INTO s_dept VALUES (50,  'Administration',   1);
INSERT INTO s_dept VALUES (51,  'IT',               1);
INSERT INTO s_dept VALUES (52,  'Marketing',        2);
INSERT INTO s_dept VALUES (53,  'Accounting',       3);
INSERT INTO s_dept VALUES (54,  'Logistics',        4);
COMMIT;
 

-- Giám đốc tổng (không có quản lý)
INSERT INTO s_emp VALUES (1, 'Nguyen', 'Minh',   'mnguyen', TO_DATE('03/03/1990','DD/MM/YYYY'), NULL, NULL,   'President',          50,  5000,  NULL);
 
-- Cấp phó — báo cáo cho id=1
INSERT INTO s_emp VALUES (2, 'Tran',   'Lan',    'ltran',   TO_DATE('21/05/1990','DD/MM/YYYY'), NULL, 1,      'VP, Operations',     41,  3500,  NULL);
INSERT INTO s_emp VALUES (3, 'Le',     'Hoa',    'hle',     TO_DATE('18/06/1990','DD/MM/YYYY'), NULL, 1,      'VP, Sales',          31,  3200,  NULL);
INSERT INTO s_emp VALUES (4, 'Pham',   'Son',    'spham',   TO_DATE('17/04/1991','DD/MM/YYYY'), NULL, 1,      'VP, Finance',        10,  3100,  NULL);
 
-- Quản lý — báo cáo cho cấp phó
INSERT INTO s_emp VALUES (5,  'Hoang', 'Linh',   'lhoang',  TO_DATE('01/05/1991','DD/MM/YYYY'), NULL, 2,      'Manager',            42,  2500,  NULL);
INSERT INTO s_emp VALUES (6,  'Vo',    'Nam',     'nvo',     TO_DATE('14/05/1990','DD/MM/YYYY'), NULL, 3,      'Manager',            32,  2400,  NULL);
INSERT INTO s_emp VALUES (7,  'Dang',  'Thanh',   'tdang',   TO_DATE('26/03/1991','DD/MM/YYYY'), NULL, 3,      'Director',           33,  2800,  NULL);
INSERT INTO s_emp VALUES (8,  'Bui',   'Anh',     'abui',    TO_DATE('07/09/1991','DD/MM/YYYY'), NULL, 4,      'Accountant',         10,  1800,  NULL);
INSERT INTO s_emp VALUES (9,  'Do',    'Huong',   'hdo',     TO_DATE('15/11/1991','DD/MM/YYYY'), NULL, 2,      'Warehouse Manager',  43,  2200,  NULL);
INSERT INTO s_emp VALUES (10, 'Ngo',   'Long',    'lngo',    TO_DATE('22/02/1991','DD/MM/YYYY'), NULL, 1,      'HR Manager',         20,  2600,  NULL);
 
-- Nhân viên — báo cáo cho quản lý
INSERT INTO s_emp VALUES (11, 'Ly',    'Mai',     'mlly',    TO_DATE('10/01/1992','DD/MM/YYYY'), NULL, 5,      'Stock Clerk',        42,  1200,  NULL);
INSERT INTO s_emp VALUES (12, 'Trinh', 'Sang',    'strinh',  TO_DATE('20/06/1991','DD/MM/YYYY'), NULL, 6,      'Sales Representative', 32, 1500, 10);
INSERT INTO s_emp VALUES (13, 'Dinh',  'Khanh',   'kdinh',   TO_DATE('05/08/1991','DD/MM/YYYY'), NULL, 7,      'Sales Representative', 33, 1600, 12);
INSERT INTO s_emp VALUES (14, 'Ha',    'Lien',    'lha',     TO_DATE('30/09/1991','DD/MM/YYYY'), NULL, 5,      'Secretary',          41,  1350, NULL);
INSERT INTO s_emp VALUES (15, 'Mac',   'Phuong',  'pmac',    TO_DATE('12/12/1991','DD/MM/YYYY'), NULL, 6,      'Marketing Rep',      31,  1400, 8);
COMMIT;
 

INSERT INTO s_warehouse VALUES (1,  1, '123 Main St',       'New York',      'NY',  'USA',         '10001', '212-555-0101', 2);
INSERT INTO s_warehouse VALUES (2,  1, '456 Oak Ave',       'Los Angeles',   'CA',  'USA',         '90001', '310-555-0102', 2);
INSERT INTO s_warehouse VALUES (3,  1, '789 Pine Rd',       'Chicago',       'IL',  'USA',         '60601', '312-555-0103', 5);
INSERT INTO s_warehouse VALUES (4,  2, '321 Elm St',        'Sao Paulo',     NULL,  'Brazil',      '01310', '55-11-5550104', 5);
INSERT INTO s_warehouse VALUES (5,  2, '654 Maple Dr',      'Buenos Aires',  NULL,  'Argentina',   'C1000', '54-11-5550105', 9);
INSERT INTO s_warehouse VALUES (6,  3, '11 Nguyen Hue',     'Ho Chi Minh',   NULL,  'Vietnam',     '70000', '028-5550106',  9);
INSERT INTO s_warehouse VALUES (7,  3, '22 Le Loi',         'Hanoi',         NULL,  'Vietnam',     '10000', '024-5550107',  9);
INSERT INTO s_warehouse VALUES (8,  3, '33 Sukhumvit',      'Bangkok',       NULL,  'Thailand',    '10110', '66-2-5550108', 2);
INSERT INTO s_warehouse VALUES (9,  3, '44 Orchard Rd',     'Singapore',     NULL,  'Singapore',   '238879','65-5550109',   5);
INSERT INTO s_warehouse VALUES (10, 4, '55 Oxford St',      'London',        NULL,  'UK',          'W1D',   '44-20-5550110', 10);
INSERT INTO s_warehouse VALUES (11, 4, '66 Champs Elysees', 'Paris',         NULL,  'France',      '75008', '33-1-5550111', 10);
INSERT INTO s_warehouse VALUES (12, 4, '77 Kurfurstendamm', 'Berlin',        NULL,  'Germany',     '10707', '49-30-5550112', 10);
INSERT INTO s_warehouse VALUES (13, 1, '88 Commerce Blvd',  'Houston',       'TX',  'USA',         '77001', '713-555-0113', 2);
INSERT INTO s_warehouse VALUES (14, 2, '99 Industrial Ave', 'Lima',          NULL,  'Peru',        'L-27',  '51-1-5550114', 5);
INSERT INTO s_warehouse VALUES (15, 3, '100 Jalan Ampang',  'Kuala Lumpur',  NULL,  'Malaysia',    '50450', '60-3-5550115', 9);
COMMIT;
 
-- -------------------------------------------------------
-- s_customer (15 khách hàng)
-- -------------------------------------------------------
INSERT INTO s_customer VALUES (201, 'Cong Ty ABC',           '028-3812-0001', '10 Tran Hung Dao',   'Ho Chi Minh', NULL,   'Vietnam',   '70000', 'EXCELLENT', 3,  3, 'Khach hang VIP');
INSERT INTO s_customer VALUES (202, 'Cong Ty XYZ',           '028-3812-0002', '20 Nguyen Trai',     'Ho Chi Minh', NULL,   'Vietnam',   '70000', 'GOOD',      6,  3, NULL);
INSERT INTO s_customer VALUES (203, 'Global Tech Ltd',       '212-555-2001',  '500 5th Ave',        'New York',    'NY',   'USA',       '10110', 'EXCELLENT', 12, 1, NULL);
INSERT INTO s_customer VALUES (204, 'Asia Traders Co',       '65-6325-2002',  '10 Marina Blvd',     'Singapore',   NULL,   'Singapore', '018956','GOOD',      13, 3, NULL);
INSERT INTO s_customer VALUES (205, 'Euro Supplies GmbH',    '49-30-2003',    '88 Berliner Str',    'Berlin',      NULL,   'Germany',   '10115', 'EXCELLENT', 7,  4, 'Uu tien giao hang');
INSERT INTO s_customer VALUES (206, 'South Am Exports',      '55-11-2004',    '200 Av Paulista',    'Sao Paulo',   NULL,   'Brazil',    '01310', 'POOR',      6,  2, NULL);
INSERT INTO s_customer VALUES (207, 'Pacific Rim Inc',       '61-2-2005',     '1 George St',        'Sydney',      'NSW',  'Australia', '2000',  'GOOD',      3,  3, NULL);
INSERT INTO s_customer VALUES (208, 'North Star Corp',       '1-416-2006',    '200 Bay St',         'Toronto',     'ON',   'Canada',    'M5J',   'EXCELLENT', 12, 1, NULL);
INSERT INTO s_customer VALUES (209, 'Hanoi Trading JSC',     '024-3812-0007', '15 Hoan Kiem',       'Hanoi',       NULL,   'Vietnam',   '10000', 'GOOD',      3,  3, NULL);
INSERT INTO s_customer VALUES (210, 'Bangkok Supplies Co',   '66-2-2008',     '77 Silom Rd',        'Bangkok',     NULL,   'Thailand',  '10500', 'GOOD',      13, 3, NULL);
INSERT INTO s_customer VALUES (211, 'Lima Export SAC',       '51-1-2009',     '300 Av Larco',       'Lima',        NULL,   'Peru',      'L-18',  'POOR',      6,  2, NULL);
INSERT INTO s_customer VALUES (212, 'London Wholesale Ltd',  '44-20-2010',    '99 Fleet St',        'London',      NULL,   'UK',        'EC4Y',  'EXCELLENT', 7,  4, NULL);
INSERT INTO s_customer VALUES (213, 'KL Distributors Sdn',   '60-3-2011',     '50 Jalan Imbi',      'Kuala Lumpur',NULL,   'Malaysia',  '55100', 'GOOD',      13, 3, NULL);
INSERT INTO s_customer VALUES (214, 'Texas Oil Supply',      '713-555-2012',  '400 Travis St',      'Houston',     'TX',   'USA',       '77002', 'EXCELLENT', 12, 1, NULL);
-- Khách hàng 215 chưa đặt hàng — để kiểm tra Bài 6 Câu 4
INSERT INTO s_customer VALUES (215, 'New Customer Co',       '028-9999-0000', '999 Test St',        'Ho Chi Minh', NULL,   'Vietnam',   '70000', 'GOOD',      3,  3, 'Chua dat hang lan nao');
COMMIT;
 
INSERT INTO s_image (id, format, use_filename, filename) VALUES (1,  'GIF',  'Y', 'ski_helmet.gif');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (2,  'GIF',  'Y', 'pro_bike.gif');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (3,  'JPEG', 'Y', 'tent_01.jpg');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (4,  'JPEG', 'Y', 'ski_pole.jpg');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (5,  'GIF',  'Y', 'pro_gloves.gif');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (6,  'JPEG', 'Y', 'bicycle_lock.jpg');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (7,  'GIF',  'Y', 'pro_helmet.gif');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (8,  'JPEG', 'Y', 'mountain_boot.jpg');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (9,  'GIF',  'N', 'ski_suit.gif');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (10, 'JPEG', 'Y', 'pro_jersey.jpg');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (11, 'GIF',  'Y', 'tent_02.gif');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (12, 'JPEG', 'Y', 'ski_boot.jpg');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (13, 'GIF',  'Y', 'bicycle_chain.gif');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (14, 'JPEG', 'N', 'pro_saddle.jpg');
INSERT INTO s_image (id, format, use_filename, filename) VALUES (15, 'GIF',  'Y', 'ski_goggle.gif');
COMMIT;
 
-- -------------------------------------------------------
-- s_longtext (15 bản ghi)
-- -------------------------------------------------------
INSERT INTO s_longtext (id, use_filename, filename) VALUES (1,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (2,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (3,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (4,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (5,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (6,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (7,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (8,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (9,  'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (10, 'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (11, 'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (12, 'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (13, 'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (14, 'N', NULL);
INSERT INTO s_longtext (id, use_filename, filename) VALUES (15, 'N', NULL);
COMMIT;
 
-- -------------------------------------------------------
-- s_product (15 sản phẩm)
-- Có sản phẩm chứa "Pro", "ski", "bicycle" để test Bài 2/3
-- -------------------------------------------------------
INSERT INTO s_product VALUES (1,  'Pro Ski Helmet',        'Protective helmet for ski sports',            1,  1,   89.99,  'Each');
INSERT INTO s_product VALUES (2,  'Pro Mountain Bike',     'Professional bicycle for mountain terrain',   2,  2,  799.99,  'Each');
INSERT INTO s_product VALUES (3,  'Family Camping Tent',   'Spacious 6-person camping tent',              3,  3,  249.99,  'Each');
INSERT INTO s_product VALUES (4,  'Ski Pole Carbon',       'Lightweight carbon ski pole',                 4,  4,   59.99,  'Pair');
INSERT INTO s_product VALUES (5,  'Pro Cycling Gloves',    'Padded gloves for long bicycle rides',        5,  5,   29.99,  'Pair');
INSERT INTO s_product VALUES (6,  'Bicycle Lock Steel',    'Heavy-duty steel bicycle lock',               6,  6,   19.99,  'Each');
INSERT INTO s_product VALUES (7,  'Pro Ski Helmet Lite',   'Lightweight ski helmet with visor',           7,  7,   99.99,  'Each');
INSERT INTO s_product VALUES (8,  'Mountain Hiking Boot',  'Waterproof boot for mountain hiking',         8,  8,  149.99,  'Pair');
INSERT INTO s_product VALUES (9,  'Ski Suit Pro Series',   'Insulated professional ski suit',             9,  9,  299.99,  'Each');
INSERT INTO s_product VALUES (10, 'Pro Cycling Jersey',    'Aerodynamic jersey for bicycle racing',       10, 10,  44.99,  'Each');
INSERT INTO s_product VALUES (11, 'Trail Camping Tent',    'Lightweight tent for trail camping',          11, 11, 179.99,  'Each');
INSERT INTO s_product VALUES (12, 'Ski Boot Alpine',       'High-performance alpine ski boot',            12, 12, 349.99,  'Pair');
INSERT INTO s_product VALUES (13, 'Bicycle Chain Lube',    'Premium lubricant for bicycle chains',        13, 13,  12.99,  'Bottle');
INSERT INTO s_product VALUES (14, 'Pro Saddle Comfort',    'Ergonomic saddle for long bicycle rides',     14, 14,  79.99,  'Each');
INSERT INTO s_product VALUES (15, 'Ski Goggle UV400',      'UV400 protection ski goggle',                 15, 15,  69.99,  'Each');
COMMIT;
 

INSERT INTO s_ord VALUES (101, 201, TO_DATE('01/03/1992','DD/MM/YYYY'), TO_DATE('08/03/1992','DD/MM/YYYY'), 3,   2150.00,  'CREDIT',  'Y');
INSERT INTO s_ord VALUES (102, 202, TO_DATE('15/03/1992','DD/MM/YYYY'), TO_DATE('22/03/1992','DD/MM/YYYY'), 6,   5500.00,  'CASH',    'Y');
INSERT INTO s_ord VALUES (103, 203, TO_DATE('20/03/1992','DD/MM/YYYY'), TO_DATE('28/03/1992','DD/MM/YYYY'), 12, 125000.00, 'CREDIT',  'Y');
INSERT INTO s_ord VALUES (104, 204, TO_DATE('02/04/1992','DD/MM/YYYY'), TO_DATE('10/04/1992','DD/MM/YYYY'), 13, 210000.00, 'CREDIT',  'Y');
INSERT INTO s_ord VALUES (105, 205, TO_DATE('05/04/1992','DD/MM/YYYY'), TO_DATE('15/04/1992','DD/MM/YYYY'), 7,  115000.00, 'CHECK',   'Y');
INSERT INTO s_ord VALUES (106, 206, TO_DATE('10/04/1992','DD/MM/YYYY'), TO_DATE('20/04/1992','DD/MM/YYYY'), 6,   3200.00,  'CASH',    'Y');
INSERT INTO s_ord VALUES (107, 207, TO_DATE('12/04/1992','DD/MM/YYYY'), TO_DATE('22/04/1992','DD/MM/YYYY'), 3,  88000.00,  'CREDIT',  'Y');
INSERT INTO s_ord VALUES (108, 208, TO_DATE('14/04/1992','DD/MM/YYYY'), TO_DATE('25/04/1992','DD/MM/YYYY'), 12, 175000.00, 'CREDIT',  'Y');
INSERT INTO s_ord VALUES (109, 201, TO_DATE('20/04/1992','DD/MM/YYYY'), TO_DATE('30/04/1992','DD/MM/YYYY'), 3,   9800.00,  'CASH',    'Y');
INSERT INTO s_ord VALUES (110, 209, TO_DATE('01/05/1992','DD/MM/YYYY'), TO_DATE('10/05/1992','DD/MM/YYYY'), 3,   4500.00,  'CREDIT',  'Y');
INSERT INTO s_ord VALUES (111, 210, TO_DATE('05/05/1992','DD/MM/YYYY'), TO_DATE('15/05/1992','DD/MM/YYYY'), 13,  7800.00,  'CASH',    'Y');
INSERT INTO s_ord VALUES (112, 203, TO_DATE('10/05/1992','DD/MM/YYYY'), TO_DATE('20/05/1992','DD/MM/YYYY'), 12, 130000.00, 'CREDIT',  'Y');
INSERT INTO s_ord VALUES (113, 211, TO_DATE('12/05/1992','DD/MM/YYYY'), TO_DATE('22/05/1992','DD/MM/YYYY'), 6,   2100.00,  'CASH',    'N');
INSERT INTO s_ord VALUES (114, 212, TO_DATE('15/05/1992','DD/MM/YYYY'), TO_DATE('25/05/1992','DD/MM/YYYY'), 7,  195000.00, 'CREDIT',  'Y');
INSERT INTO s_ord VALUES (115, 214, TO_DATE('20/05/1992','DD/MM/YYYY'), TO_DATE('30/05/1992','DD/MM/YYYY'), 12, 320000.00, 'CREDIT',  'Y');
COMMIT;
 

INSERT INTO s_item VALUES (101, 1,  1,   89.99, 5,   5);
INSERT INTO s_item VALUES (101, 2,  4,   59.99, 10,  10);
INSERT INTO s_item VALUES (101, 3,  15,  69.99, 8,   8);
INSERT INTO s_item VALUES (102, 1,  2,  799.99, 2,   2);
INSERT INTO s_item VALUES (103, 1,  2,  799.99, 50,  50);
INSERT INTO s_item VALUES (103, 2,  5,   29.99, 100, 100);
INSERT INTO s_item VALUES (104, 1,  9,  299.99, 200, 200);
INSERT INTO s_item VALUES (104, 2,  12, 349.99, 150, 150);
INSERT INTO s_item VALUES (105, 1,  7,   99.99, 300, 300);
INSERT INTO s_item VALUES (106, 1,  6,   19.99, 50,  50);
INSERT INTO s_item VALUES (107, 1,  3,  249.99, 100, 100);
INSERT INTO s_item VALUES (108, 1,  9,  299.99, 100, 100);
INSERT INTO s_item VALUES (108, 2,  12, 349.99, 200, 200);
INSERT INTO s_item VALUES (112, 1,  2,  799.99, 60,  60);
INSERT INTO s_item VALUES (115, 1,  9,  299.99, 500, 500);
COMMIT;
 

INSERT INTO s_inventory VALUES (1,  1,  150, 50,  300, NULL,                  NULL);
INSERT INTO s_inventory VALUES (2,  2,  80,  20,  200, NULL,                  NULL);
INSERT INTO s_inventory VALUES (3,  3,  200, 100, 500, NULL,                  NULL);
INSERT INTO s_inventory VALUES (4,  4,  120, 30,  250, NULL,                  NULL);
INSERT INTO s_inventory VALUES (5,  5,  300, 100, 600, NULL,                  NULL);
INSERT INTO s_inventory VALUES (6,  6,  500, 200, 1000,NULL,                  NULL);
INSERT INTO s_inventory VALUES (7,  1,  90,  30,  200, NULL,                  NULL);
INSERT INTO s_inventory VALUES (8,  2,  60,  20,  150, NULL,                  NULL);
INSERT INTO s_inventory VALUES (9,  3,  0,   50,  200, 'Hang het, dang nhap', TO_DATE('01/06/1992','DD/MM/YYYY'));
INSERT INTO s_inventory VALUES (10, 4,  180, 50,  400, NULL,                  NULL);
INSERT INTO s_inventory VALUES (11, 5,  250, 80,  500, NULL,                  NULL);
INSERT INTO s_inventory VALUES (12, 6,  0,   100, 300, 'Hang het, dang nhap', TO_DATE('15/06/1992','DD/MM/YYYY'));
INSERT INTO s_inventory VALUES (13, 1,  400, 150, 800, NULL,                  NULL);
INSERT INTO s_inventory VALUES (14, 2,  110, 40,  250, NULL,                  NULL);
INSERT INTO s_inventory VALUES (15, 3,  75,  25,  200, NULL,                  NULL);
COMMIT;


-- ============================================================
-- BÀI 2: TRUY VẤN DỮ LIỆU CƠ BẢN
-- ============================================================

-- Câu 1: Tên, mã khách hàng — alias cột, sắp giảm dần theo mã
SELECT name AS "Ten khach hang",
       id   AS "Ma khach hang"
FROM s_customer 
ORDER BY id DESC;

-- Câu 2: Họ tên nhân viên phòng 10, 50 — nối cột thành "Employees", sắp theo tên
-- Lưu ý: alias bảng KHÔNG dùng AS; nối chuỗi dùng ||
SELECT first_name || ' ' || last_name AS "Employees",
       dept_id
FROM s_emp
WHERE dept_id IN (10, 50)
ORDER BY first_name;

-- Câu 3: Tất cả nhân viên có tên chứa chữ "S" (tìm cả họ lẫn tên)
SELECT last_name, first_name
FROM s_emp
WHERE first_name LIKE '%S%'
   OR last_name  LIKE '%S%';

-- Câu 4: Tên truy nhập và ngày bắt đầu làm việc từ 14/5/1990 đến 26/5/1991
SELECT userid, start_date
FROM s_emp
WHERE start_date BETWEEN TO_DATE('14/05/1990', 'DD/MM/YYYY')
                     AND TO_DATE('26/05/1991', 'DD/MM/YYYY');

-- Câu 5: Tên và lương của nhân viên nhận lương từ 1000 đến 2000/tháng
SELECT last_name, salary
FROM s_emp
WHERE salary BETWEEN 1000 AND 2000;

-- Câu 6: Nhân viên phòng 31, 42, 50 có lương > 1350
--         Alias: "Employee Name" và "Monthly Salary"
SELECT last_name || ' ' || first_name AS "Employee Name",
       salary                         AS "Monthly Salary"
FROM s_emp
WHERE dept_id IN (31, 42, 50)
  AND salary > 1350;

-- Câu 7: Tên và ngày bắt đầu làm việc của nhân viên tuyển trong năm 1991
--  Cách 1 — TO_CHAR (ngắn gọn)
SELECT last_name, start_date
FROM s_emp
WHERE TO_CHAR(start_date, 'YYYY') = '1991';

--  Cách 2 — BETWEEN (chính xác hơn, khuyên dùng)
SELECT last_name, start_date
FROM s_emp
WHERE start_date BETWEEN TO_DATE('01/01/1991', 'DD/MM/YYYY')
                     AND TO_DATE('31/12/1991', 'DD/MM/YYYY');

-- Câu 8: Họ tên nhân viên KHÔNG phải người quản lý
-- QUAN TRỌNG: phải lọc NULL trong subquery, nếu không NOT IN trả về rỗng!
SELECT last_name, first_name
FROM s_emp
WHERE id NOT IN (
    SELECT DISTINCT manager_id
    FROM s_emp
    WHERE manager_id IS NOT NULL   -- bắt buộc có dòng này
);

-- Câu 9: Sản phẩm có tên bắt đầu với "Pro", sắp theo thứ tự abc
SELECT name
FROM s_product
WHERE name LIKE 'Pro%'
ORDER BY name ASC;

-- Câu 10: Tên và SHORT_DESC của sản phẩm có mô tả chứa từ "bicycle"
-- Dùng LOWER() để không phân biệt hoa/thường
SELECT name, short_desc
FROM s_product
WHERE LOWER(short_desc) LIKE '%bicycle%';

-- Câu 11: Hiển thị tất cả SHORT_DESC
SELECT short_desc
FROM s_product;

-- Câu 12: Tên nhân viên và chức vụ trong ngoặc đơn — VD: Nguyen Van Tam (Director)
SELECT last_name || ' ' || first_name || ' (' || title || ')' AS "Nhan vien"
FROM s_emp;


-- ============================================================
-- BÀI 3: CÁC LOẠI HÀM TRONG SQL
-- ============================================================

-- Câu 1: Mã nhân viên, tên và mức lương tăng thêm 15%
SELECT id,
       last_name,
       ROUND(salary * 1.15, 2) AS "Luong moi (tang 15%)"
FROM s_emp;

-- Câu 2: Tên NV, ngày tuyển dụng và ngày xét tăng lương
--        (Thứ Hai đầu tiên sau 6 tháng làm việc)
--        Định dạng: "Eighth of May 1992"

SELECT last_name,
       start_date AS "Ngay tuyen dung",
       TO_CHAR(
           NEXT_DAY(ADD_MONTHS(start_date, 6), 'MONDAY'),
           'Ddspth "of" Month YYYY'
       )           AS "Ngay xet tang luong"
FROM s_emp;

-- Câu 3: Tên sản phẩm có chứa chữ "ski" (không phân biệt hoa/thường)
SELECT name
FROM s_product
WHERE LOWER(name) LIKE '%ski%';

-- Câu 4: Số tháng thâm niên của mỗi nhân viên (làm tròn), sắp tăng dần
SELECT last_name,
       ROUND(MONTHS_BETWEEN(SYSDATE, start_date)) AS "So thang tham nien"
FROM s_emp
ORDER BY MONTHS_BETWEEN(SYSDATE, start_date) ASC;

-- Câu 5: Có bao nhiêu người quản lý?
-- Đếm số giá trị phân biệt trong cột manager_id (loại NULL)
SELECT COUNT(DISTINCT manager_id) AS "So nguoi quan ly"
FROM s_emp
WHERE manager_id IS NOT NULL;

-- Câu 6: Mức cao nhất và thấp nhất của đơn hàng trong s_ord
SELECT MAX(total) AS "Highest",
       MIN(total) AS "Lowest"
FROM s_ord;


-- ============================================================
-- BÀI 4: PHÉP KẾT (JOIN)
-- ============================================================

-- Câu 1: Tên, mã sản phẩm và số lượng trong đơn hàng mã 101
--        Cột số lượng đặt tên "ORDERED"
-- Dùng cú pháp Equijoin kiểu Oracle (alias bảng không có AS)
SELECT p.name,
       p.id,
       i.quantity AS "ORDERED"
FROM s_product p, s_item i
WHERE p.id = i.product_id
  AND i.ord_id = 101;

-- Câu 2: Mã khách hàng và mã đơn đặt hàng của TẤT CẢ khách hàng
--        (kể cả khách chưa đặt hàng) — sắp theo mã khách hàng

--  Cách 1 — Cú pháp Oracle OUTER JOIN với dấu (+)
SELECT c.id AS "Ma khach hang",
       o.id AS "Ma don hang"
FROM s_customer c, s_ord o
WHERE c.id = o.customer_id(+)
ORDER BY c.id;

--  Cách 2 — Cú pháp ANSI LEFT JOIN
SELECT c.id AS "Ma khach hang",
       o.id AS "Ma don hang"
FROM s_customer c LEFT JOIN s_ord o ON c.id = o.customer_id
ORDER BY c.id;

-- Câu 3: Mã khách hàng, mã sản phẩm và số lượng đặt của đơn có trị giá > 100.000
SELECT o.customer_id AS "Ma khach hang",
       i.product_id  AS "Ma san pham",
       i.quantity    AS "So luong"
FROM s_ord o, s_item i
WHERE o.id = i.ord_id
  AND o.total > 100000;


-- ============================================================
-- BÀI 5A: CÁC HÀM GOM NHÓM (GROUP BY / HAVING)
-- ============================================================
-- Nhớ: WHERE lọc hàng TRƯỚC GROUP BY (không dùng hàm gộp nhóm)
--      HAVING lọc nhóm SAU GROUP BY (được dùng hàm gộp nhóm)

-- Câu 1: Mã người quản lý và số nhân viên họ quản lý
SELECT manager_id AS "Ma quan ly",
       COUNT(id)  AS "So nhan vien"
FROM s_emp
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY manager_id;

-- Câu 2: Người quản lý quản lý từ 20 nhân viên trở lên
-- Điều kiện trên kết quả GROUP BY → dùng HAVING
SELECT manager_id AS "Ma quan ly",
       COUNT(id)  AS "So nhan vien"
FROM s_emp
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING COUNT(id) >= 20;

-- Câu 3: Mã vùng, tên vùng và số phòng ban trong mỗi vùng
SELECT r.id       AS "Ma vung",
       r.name     AS "Ten vung",
       COUNT(d.id) AS "So phong ban"
FROM s_region r, s_dept d
WHERE r.id = d.region_id
GROUP BY r.id, r.name
ORDER BY r.id;

-- Câu 4: Tên khách hàng và số lượng đơn đặt hàng của mỗi khách
SELECT c.name      AS "Ten khach hang",
       COUNT(o.id) AS "So don dat hang"
FROM s_customer c, s_ord o
WHERE c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY c.name;

-- Câu 5: Khách hàng có số đơn đặt hàng nhiều nhất
-- Dùng subquery lồng nhau: HAVING = MAX(COUNT(...))
SELECT c.name,
       COUNT(o.id) AS "So don hang"
FROM s_customer c, s_ord o
WHERE c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) = (
    SELECT MAX(COUNT(id))
    FROM s_ord
    GROUP BY customer_id
);

-- Câu 6: Khách hàng có tổng tiền mua hàng lớn nhất
SELECT c.name,
       SUM(o.total) AS "Tong tien"
FROM s_customer c, s_ord o
WHERE c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total) = (
    SELECT MAX(SUM(total))
    FROM s_ord
    GROUP BY customer_id
);


-- ============================================================
-- BÀI 5B / BÀI 6: TRUY VẤN CON (SUBQUERY)
-- Các bảng: S_EMP, S_DEPT, S_ORD, S_ITEM, S_PRODUCT
-- ============================================================

-- Câu 1: Họ, tên và ngày tuyển dụng của nhân viên cùng phòng với "Lan"
-- (loại chính Lan ra khỏi kết quả)

--  Cách 1 — Dùng = (khi chỉ có 1 Lan trong CSDL)
SELECT last_name, first_name, start_date
FROM s_emp
WHERE dept_id = (
    SELECT dept_id
    FROM s_emp
    WHERE first_name = 'Lan'
)
  AND first_name != 'Lan';

--  Cách 2 — Dùng IN (an toàn hơn khi có nhiều Lan)
SELECT last_name, first_name, start_date
FROM s_emp
WHERE dept_id IN (
    SELECT dept_id
    FROM s_emp
    WHERE first_name = 'Lan'
)
  AND first_name != 'Lan';

-- Câu 2: Mã, họ, tên và mã truy cập của NV có lương > mức lương trung bình
SELECT id,
       last_name,
       first_name,
       userid
FROM s_emp
WHERE salary > (SELECT AVG(salary) FROM s_emp);

-- Câu 3: Mã, họ, tên của NV có lương > trung bình VÀ tên chứa ký tự "L"
-- Tìm cả trong first_name lẫn last_name, không phân biệt hoa/thường
SELECT id,
       last_name,
       first_name
FROM s_emp
WHERE salary > (SELECT AVG(salary) FROM s_emp)
  AND (UPPER(first_name) LIKE '%L%'
   OR  UPPER(last_name)  LIKE '%L%');

-- Câu 4: Khách hàng chưa bao giờ đặt hàng

--  Cách 1 — NOT IN (phải lọc NULL trong subquery — bắt buộc!)
SELECT name AS "Ten khach hang"
FROM s_customer
WHERE id NOT IN (
    SELECT DISTINCT customer_id
    FROM s_ord
    WHERE customer_id IS NOT NULL   -- bắt buộc, tránh NOT IN trả về rỗng
);

--  Cách 2 — NOT EXISTS (hiệu quả và an toàn với NULL hơn NOT IN)
SELECT c.name AS "Ten khach hang"
FROM s_customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM s_ord o
    WHERE o.customer_id = c.id
);
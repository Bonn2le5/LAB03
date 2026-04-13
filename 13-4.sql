
CREATE TABLE course (
    courseno       NUMBER(8, 0)    CONSTRAINT pk_course PRIMARY KEY,
    description    VARCHAR2(50),
    cost           NUMBER(9, 2),
    prerequisite   NUMBER(8, 0),
    created_by     VARCHAR2(30)    NOT NULL,
    created_date   DATE            NOT NULL,
    modified_by    VARCHAR2(30)    NOT NULL,
    modified_date  DATE            NOT NULL,
    CONSTRAINT fk_course_prerequisite FOREIGN KEY (prerequisite) REFERENCES course (courseno)
);

CREATE TABLE instructor (
    instructorid   NUMBER(8, 0)    CONSTRAINT pk_instructor PRIMARY KEY,
    salutation     VARCHAR2(5),
    firstname      VARCHAR2(25),
    lastname       VARCHAR2(25),
    address        VARCHAR2(50),
    phone          VARCHAR2(15),
    created_by     VARCHAR2(30)    NOT NULL,
    created_date   DATE            NOT NULL,
    modified_by    VARCHAR2(30)    NOT NULL,
    modified_date  DATE            NOT NULL
);

CREATE TABLE student (
    studentid          NUMBER(8, 0)    CONSTRAINT pk_student PRIMARY KEY,
    salutation         VARCHAR2(5),
    firstname          VARCHAR2(25),
    lastname           VARCHAR2(25)    NOT NULL,
    address            VARCHAR2(50),
    phone              VARCHAR2(15),
    employer           VARCHAR2(50),
    registrationdate   DATE            NOT NULL,
    created_by         VARCHAR2(30)    NOT NULL,
    created_date       DATE            NOT NULL,
    modified_by        VARCHAR2(30)    NOT NULL,
    modified_date      DATE            NOT NULL
);

CREATE TABLE class (
    classid         NUMBER(8, 0)    CONSTRAINT pk_class PRIMARY KEY,
    courseno        NUMBER(8, 0)    NOT NULL,
    classno         NUMBER(3, 0)    NOT NULL,
    startdatetime   DATE,
    location        VARCHAR2(50),
    instructorid    NUMBER(8, 0)    NOT NULL,
    capacity        NUMBER(3, 0),
    created_by      VARCHAR2(30)    NOT NULL,
    created_date    DATE            NOT NULL,
    modified_by     VARCHAR2(30)    NOT NULL,
    modified_date   DATE            NOT NULL,
    CONSTRAINT fk_class_course FOREIGN KEY (courseno) REFERENCES course (courseno),
    CONSTRAINT fk_class_instructor FOREIGN KEY (instructorid) REFERENCES instructor (instructorid)
);

CREATE TABLE enrollment (
    studentid       NUMBER(8, 0)    NOT NULL,
    classid         NUMBER(8, 0)    NOT NULL,
    enrolldate      DATE            NOT NULL,
    finalgrade      NUMBER(3, 0),
    created_by      VARCHAR2(30)    NOT NULL,
    created_date    DATE            NOT NULL,
    modified_by     VARCHAR2(30)    NOT NULL,
    modified_date   DATE            NOT NULL,
    CONSTRAINT pk_enrollment PRIMARY KEY (studentid, classid),
    CONSTRAINT fk_enrollment_student FOREIGN KEY (studentid) REFERENCES student (studentid),
    CONSTRAINT fk_enrollment_class FOREIGN KEY (classid) REFERENCES class (classid)
);

CREATE TABLE grade (
    studentid       NUMBER(8, 0)    NOT NULL,
    classid         NUMBER(8, 0)    NOT NULL,
    grade           NUMBER(3, 0)    NOT NULL,
    comments        VARCHAR2(2000),
    created_by      VARCHAR2(30)    NOT NULL,
    created_date    DATE            NOT NULL,
    modified_by     VARCHAR2(30)    NOT NULL,
    modified_date   DATE            NOT NULL,
    CONSTRAINT pk_grade PRIMARY KEY (studentid, classid),
    CONSTRAINT fk_grade_enrollment FOREIGN KEY (studentid, classid) REFERENCES enrollment (studentid, classid)
);

PROMPT ===== SEED DATA =====

INSERT INTO course (courseno, description, cost, prerequisite, created_by, created_date, modified_by, modified_date)
VALUES (10, 'DP Overview', 300, NULL, USER, SYSDATE, USER, SYSDATE);

INSERT INTO course (courseno, description, cost, prerequisite, created_by, created_date, modified_by, modified_date)
VALUES (20, 'Intro to Computers', 500, NULL, USER, SYSDATE, USER, SYSDATE);

INSERT INTO course (courseno, description, cost, prerequisite, created_by, created_date, modified_by, modified_date)
VALUES (30, 'PLSQL Basics', 700, 20, USER, SYSDATE, USER, SYSDATE);

INSERT INTO course (courseno, description, cost, prerequisite, created_by, created_date, modified_by, modified_date)
VALUES (40, 'Advanced SQL', 650, 20, USER, SYSDATE, USER, SYSDATE);

INSERT INTO course (courseno, description, cost, prerequisite, created_by, created_date, modified_by, modified_date)
VALUES (50, 'Data Warehousing', 800, 40, USER, SYSDATE, USER, SYSDATE);

INSERT INTO instructor (instructorid, salutation, firstname, lastname, address, phone, created_by, created_date, modified_by, modified_date)
VALUES (1, 'Mr', 'An', 'Nguyen', 'District 1', '0901000001', USER, SYSDATE, USER, SYSDATE);

INSERT INTO instructor (instructorid, salutation, firstname, lastname, address, phone, created_by, created_date, modified_by, modified_date)
VALUES (2, 'Mr', 'Binh', 'Tran', 'District 3', '0901000002', USER, SYSDATE, USER, SYSDATE);

INSERT INTO instructor (instructorid, salutation, firstname, lastname, address, phone, created_by, created_date, modified_by, modified_date)
VALUES (3, 'Ms', 'Chi', 'Le', 'District 5', '0901000003', USER, SYSDATE, USER, SYSDATE);

INSERT INTO instructor (instructorid, salutation, firstname, lastname, address, phone, created_by, created_date, modified_by, modified_date)
VALUES (4, 'Mr', 'Dung', 'Pham', 'District 7', '0901000004', USER, SYSDATE, USER, SYSDATE);

INSERT INTO class (classid, courseno, classno, startdatetime, location, instructorid, capacity, created_by, created_date, modified_by, modified_date)
VALUES (1001, 10, 2, TO_DATE('10/04/2026 08:00', 'DD/MM/YYYY HH24:MI'), 'R101', 1, 40, USER, SYSDATE, USER, SYSDATE);

INSERT INTO class (classid, courseno, classno, startdatetime, location, instructorid, capacity, created_by, created_date, modified_by, modified_date)
VALUES (1002, 20, 2, TO_DATE('11/04/2026 08:00', 'DD/MM/YYYY HH24:MI'), 'R102', 1, 40, USER, SYSDATE, USER, SYSDATE);

INSERT INTO class (classid, courseno, classno, startdatetime, location, instructorid, capacity, created_by, created_date, modified_by, modified_date)
VALUES (1003, 20, 4, TO_DATE('11/04/2026 13:30', 'DD/MM/YYYY HH24:MI'), 'R103', 2, 40, USER, SYSDATE, USER, SYSDATE);

INSERT INTO class (classid, courseno, classno, startdatetime, location, instructorid, capacity, created_by, created_date, modified_by, modified_date)
VALUES (1004, 30, 1, TO_DATE('12/04/2026 08:00', 'DD/MM/YYYY HH24:MI'), 'R201', 2, 35, USER, SYSDATE, USER, SYSDATE);

INSERT INTO class (classid, courseno, classno, startdatetime, location, instructorid, capacity, created_by, created_date, modified_by, modified_date)
VALUES (1005, 30, 2, TO_DATE('12/04/2026 13:30', 'DD/MM/YYYY HH24:MI'), 'R202', 3, 35, USER, SYSDATE, USER, SYSDATE);

INSERT INTO class (classid, courseno, classno, startdatetime, location, instructorid, capacity, created_by, created_date, modified_by, modified_date)
VALUES (1006, 40, 1, TO_DATE('13/04/2026 08:00', 'DD/MM/YYYY HH24:MI'), 'R301', 2, 30, USER, SYSDATE, USER, SYSDATE);

INSERT INTO class (classid, courseno, classno, startdatetime, location, instructorid, capacity, created_by, created_date, modified_by, modified_date)
VALUES (1007, 50, 1, TO_DATE('13/04/2026 13:30', 'DD/MM/YYYY HH24:MI'), 'R302', 4, 30, USER, SYSDATE, USER, SYSDATE);

INSERT INTO class (classid, courseno, classno, startdatetime, location, instructorid, capacity, created_by, created_date, modified_by, modified_date)
VALUES (1008, 40, 2, TO_DATE('14/04/2026 08:00', 'DD/MM/YYYY HH24:MI'), 'R303', 1, 30, USER, SYSDATE, USER, SYSDATE);

INSERT INTO student (studentid, salutation, firstname, lastname, address, phone, employer, registrationdate, created_by, created_date, modified_by, modified_date)
VALUES (101, 'Mr', 'An', 'Nguyen', 'Thu Duc', '0902000101', NULL, TO_DATE('01/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (102, 'Mr', 'Binh', 'Tran', 'Binh Thanh', '0902000102', NULL, TO_DATE('01/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (103, 'Ms', 'Chau', 'Le', 'Go Vap', '0902000103', NULL, TO_DATE('01/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (104, 'Mr', 'Dung', 'Pham', 'Phu Nhuan', '0902000104', NULL, TO_DATE('01/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (105, 'Ms', 'Giang', 'Hoang', 'District 7', '0902000105', NULL, TO_DATE('02/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (106, 'Mr', 'Hieu', 'Vu', 'District 10', '0902000106', NULL, TO_DATE('02/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (107, 'Mr', 'Khoa', 'Doan', 'District 5', '0902000107', NULL, TO_DATE('02/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (108, 'Ms', 'Lan', 'Bui', 'District 3', '0902000108', NULL, TO_DATE('03/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (109, 'Mr', 'Minh', 'Dang', 'District 1', '0902000109', NULL, TO_DATE('03/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (110, 'Mr', 'Nam', 'Phan', 'District 4', '0902000110', NULL, TO_DATE('03/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (111, 'Ms', 'Oanh', 'Truong', 'District 2', '0902000111', NULL, TO_DATE('04/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (112, 'Mr', 'Phuc', 'Vo', 'District 12', '0902000112', NULL, TO_DATE('04/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (113, 'Ms', 'Quynh', 'Duong', 'District 11', '0902000113', NULL, TO_DATE('04/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (114, 'Mr', 'Son', 'Ngo', 'District 6', '0902000114', NULL, TO_DATE('05/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (115, 'Mr', 'Tien', 'Huynh', 'District 8', '0902000115', NULL, TO_DATE('05/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (116, 'Ms', 'Uyen', 'Cao', 'District 9', '0902000116', NULL, TO_DATE('05/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (117, 'Mr', 'Van', 'Mai', 'District 7', '0902000117', NULL, TO_DATE('06/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (118, 'Ms', 'Xuan', 'Dinh', 'District 3', '0902000118', NULL, TO_DATE('06/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (119, 'Ms', 'Yen', 'Lam', 'District 1', '0902000119', NULL, TO_DATE('06/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (120, 'Mr', 'Zed', 'Ta', 'District 4', '0902000120', NULL, TO_DATE('07/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (121, 'Mr', 'Bao', 'Pham', 'Thu Duc', '0902000121', NULL, TO_DATE('07/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (122, 'Mr', 'Cuong', 'Le', 'Thu Duc', '0902000122', NULL, TO_DATE('07/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (123, 'Ms', 'Diep', 'Tran', 'Thu Duc', '0902000123', NULL, TO_DATE('08/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (124, 'Mr', 'Em', 'Nguyen', 'Go Vap', '0902000124', NULL, TO_DATE('08/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (125, 'Ms', 'Hoa', 'Do', 'Go Vap', '0902000125', NULL, TO_DATE('08/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (126, 'Mr', 'Khanh', 'Bui', 'Go Vap', '0902000126', NULL, TO_DATE('09/03/2026', 'DD/MM/YYYY'), USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (101, 1001, SYSDATE, 85, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (102, 1001, SYSDATE, 78, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (103, 1001, SYSDATE, 92, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (104, 1001, SYSDATE, 88, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (101, 1002, SYSDATE, 91, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (102, 1002, SYSDATE, 83, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (103, 1002, SYSDATE, 75, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (104, 1002, SYSDATE, 68, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (105, 1002, SYSDATE, 80, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (106, 1002, SYSDATE, 77, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (107, 1002, SYSDATE, 89, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (108, 1002, SYSDATE, 94, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (109, 1002, SYSDATE, 73, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (110, 1002, SYSDATE, 66, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (111, 1003, SYSDATE, 82, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (112, 1003, SYSDATE, 79, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (113, 1003, SYSDATE, 95, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (114, 1003, SYSDATE, 87, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (115, 1003, SYSDATE, 70, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (116, 1003, SYSDATE, 65, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (117, 1003, SYSDATE, 90, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (118, 1003, SYSDATE, 76, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (119, 1003, SYSDATE, 84, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (120, 1003, SYSDATE, 88, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (101, 1004, SYSDATE, 86, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (102, 1004, SYSDATE, 72, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (103, 1004, SYSDATE, 69, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (111, 1004, SYSDATE, 74, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (112, 1004, SYSDATE, 81, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (121, 1005, SYSDATE, 78, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (122, 1005, SYSDATE, 91, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (123, 1005, SYSDATE, 67, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (104, 1006, SYSDATE, 90, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (105, 1006, SYSDATE, 85, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (106, 1006, SYSDATE, 73, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (107, 1006, SYSDATE, 79, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (108, 1007, SYSDATE, 88, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (109, 1007, SYSDATE, 92, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (124, 1008, SYSDATE, 80, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (125, 1008, SYSDATE, 71, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (126, 1008, SYSDATE, 83, USER, SYSDATE, USER, SYSDATE);

INSERT INTO grade VALUES (101, 1002, 91, 'Good', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (102, 1002, 83, 'Stable', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (103, 1002, 75, 'Need more practice', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (104, 1002, 68, 'Improve SQL basics', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (105, 1002, 80, 'Solid', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (111, 1003, 82, 'Good', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (112, 1003, 79, 'Close to B', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (113, 1003, 95, 'Excellent', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (114, 1003, 87, 'Very good', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (115, 1003, 70, 'Pass', USER, SYSDATE, USER, SYSDATE);

COMMIT;

PROMPT [1a] Tao bang Cau1
CREATE TABLE cau1 (
    id    NUMBER,
    name  VARCHAR2(20)
);
DROP SEQUENCE cau1seq;
PROMPT [1b] Tao sequence Cau1Seq
CREATE SEQUENCE cau1seq
START WITH 5
INCREMENT BY 5;

PROMPT [1c -> 1j] Block tong hop
DECLARE
    -- [1c] Khai bao bien
    v_name  VARCHAR2(50);
    v_id    NUMBER;
BEGIN
    -- [1d] Them sinh vien dang ky nhieu mon nhat
    SELECT s.firstname || ' ' || s.lastname
    INTO v_name
    FROM student s
    WHERE s.studentid = (
        SELECT studentid
        FROM (
            SELECT e.studentid, COUNT(*) AS cnt
            FROM enrollment e
            GROUP BY e.studentid
            ORDER BY cnt DESC, e.studentid
        )
        WHERE ROWNUM = 1
    );

    INSERT INTO cau1 (id, name)
    VALUES (cau1seq.NEXTVAL, v_name);
    SAVEPOINT sp_a;

    -- [1e] Them sinh vien dang ky it mon nhat
    SELECT s.firstname || ' ' || s.lastname
    INTO v_name
    FROM student s
    WHERE s.studentid = (
        SELECT studentid
        FROM (
            SELECT e.studentid, COUNT(*) AS cnt
            FROM enrollment e
            GROUP BY e.studentid
            ORDER BY cnt ASC, e.studentid
        )
        WHERE ROWNUM = 1
    );

    INSERT INTO cau1 (id, name)
    VALUES (cau1seq.NEXTVAL, v_name);
    SAVEPOINT sp_b;

    -- [1f] Them giao vien day nhieu lop nhat
    SELECT i.firstname || ' ' || i.lastname
    INTO v_name
    FROM instructor i
    WHERE i.instructorid = (
        SELECT instructorid
        FROM (
            SELECT c.instructorid, COUNT(*) AS cnt
            FROM class c
            GROUP BY c.instructorid
            ORDER BY cnt DESC, c.instructorid
        )
        WHERE ROWNUM = 1
    );

    SAVEPOINT sp_c;
    INSERT INTO cau1 (id, name)
    VALUES (cau1seq.NEXTVAL, v_name);

    -- [1g] Lay ID cua giao vien vua them vao bien v_id
    SELECT id
    INTO v_id
    FROM (
        SELECT id
        FROM cau1
        WHERE name = v_name
        ORDER BY id DESC
    )
    WHERE ROWNUM = 1;

    -- [1h] Rollback ban ghi vua them o buoc [1f]
    ROLLBACK TO sp_c;

    -- [1i] Them giao vien day it lop nhat voi ID lay tu v_id
    SELECT i.firstname || ' ' || i.lastname
    INTO v_name
    FROM instructor i
    WHERE i.instructorid = (
        SELECT instructorid
        FROM (
            SELECT c.instructorid, COUNT(*) AS cnt
            FROM class c
            GROUP BY c.instructorid
            ORDER BY cnt ASC, c.instructorid
        )
        WHERE ROWNUM = 1
    );

    INSERT INTO cau1 (id, name)
    VALUES (v_id, v_name);

    -- [1j] Them lai giao vien day nhieu lop nhat voi ID tu sequence
    SELECT i.firstname || ' ' || i.lastname
    INTO v_name
    FROM instructor i
    WHERE i.instructorid = (
        SELECT instructorid
        FROM (
            SELECT c.instructorid, COUNT(*) AS cnt
            FROM class c
            GROUP BY c.instructorid
            ORDER BY cnt DESC, c.instructorid
        )
        WHERE ROWNUM = 1
    );

    INSERT INTO cau1 (id, name)
    VALUES (cau1seq.NEXTVAL, v_name);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Bai 1 C1c->C1j: Hoan tat');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Bai 1 C1c->C1j loi: ' || SQLERRM);
END;
/

PROMPT [1.2] Kiem tra ton tai sinh vien, neu khong co thi them moi
CREATE OR REPLACE PROCEDURE p_check_or_insert_student (
    p_student_id   IN student.studentid%TYPE,
    p_first_name   IN student.firstname%TYPE DEFAULT NULL,
    p_last_name    IN student.lastname%TYPE DEFAULT NULL,
    p_address      IN student.address%TYPE DEFAULT NULL
)
IS
    v_found_name  VARCHAR2(60);
    v_classes     NUMBER;
BEGIN
    SELECT firstname || ' ' || lastname
    INTO v_found_name
    FROM student
    WHERE studentid = p_student_id;

    SELECT COUNT(*)
    INTO v_classes
    FROM enrollment
    WHERE studentid = p_student_id;

    DBMS_OUTPUT.PUT_LINE('Ton tai SV: ' || v_found_name);
    DBMS_OUTPUT.PUT_LINE('So lop dang hoc: ' || v_classes);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF p_first_name IS NULL OR p_last_name IS NULL OR p_address IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('SV chua ton tai. Can truyen ho, ten, dia chi de them moi.');
            RETURN;
        END IF;

        INSERT INTO student (
            studentid, salutation, firstname, lastname, address, phone, employer,
            registrationdate, created_by, created_date, modified_by, modified_date
        )
        VALUES (
            p_student_id, 'Mr', p_first_name, p_last_name, p_address, NULL, NULL,
            SYSDATE, USER, SYSDATE, USER, SYSDATE
        );

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Da them moi SV: ' || p_first_name || ' ' || p_last_name);
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('p_check_or_insert_student loi: ' || SQLERRM);
END p_check_or_insert_student;
/
    
    PROMPT ===== BAI 2 - CAU TRUC DIEU KHIEN =====
    
    PROMPT [2.1] IF/ELSE - so lop giao vien dang day
    CREATE OR REPLACE PROCEDURE p_instructor_workload (
        p_instructor_id  IN instructor.instructorid%TYPE
    )
    IS
        v_exists   NUMBER;
        v_so_lop   NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_exists
        FROM instructor
        WHERE instructorid = p_instructor_id;
    
        IF v_exists = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Loi: Ma giao vien ' || p_instructor_id || ' khong ton tai!');
            RETURN;
        END IF;
    
        SELECT COUNT(*)
        INTO v_so_lop
        FROM class
        WHERE instructorid = p_instructor_id;
    
        IF v_so_lop >= 5 THEN
            DBMS_OUTPUT.PUT_LINE('Giao vien nay nen nghi ngoi!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('So lop giao vien dang day: ' || v_so_lop);
        END IF;
    END p_instructor_workload;
    /
    
    PROMPT [2.2] CASE - quy doi diem chu
    CREATE OR REPLACE PROCEDURE p_print_letter_grade (
        p_student_id  IN student.studentid%TYPE,
        p_class_id    IN class.classid%TYPE
    )
    IS
        v_check  NUMBER;
        v_score  enrollment.finalgrade%TYPE;
        v_grade  VARCHAR2(2);
    BEGIN
        SELECT COUNT(*)
        INTO v_check
        FROM student
        WHERE studentid = p_student_id;
    
        IF v_check = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Loi: Ma sinh vien ' || p_student_id || ' khong ton tai!');
            RETURN;
        END IF;
    
        SELECT COUNT(*)
        INTO v_check
        FROM class
        WHERE classid = p_class_id;
    
        IF v_check = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Loi: Ma lop ' || p_class_id || ' khong ton tai!');
            RETURN;
        END IF;
    
        SELECT finalgrade
        INTO v_score
        FROM enrollment
        WHERE studentid = p_student_id
          AND classid = p_class_id;
    
        IF v_score IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('Sinh vien chua co diem tong ket cho lop nay.');
            RETURN;
        END IF;
    
        CASE
            WHEN v_score >= 90 THEN v_grade := 'A';
            WHEN v_score >= 80 THEN v_grade := 'B';
            WHEN v_score >= 70 THEN v_grade := 'C';
            WHEN v_score >= 50 THEN v_grade := 'D';
            ELSE v_grade := 'F';
        END CASE;
    
        DBMS_OUTPUT.PUT_LINE(
            'SV ' || p_student_id || ', lop ' || p_class_id ||
            ': diem so = ' || v_score || ', diem chu = ' || v_grade
        );
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Sinh vien chua dang ky lop nay hoac chua co diem!');
    END p_print_letter_grade;
    /

PROMPT ===== BAI 3 - CURSOR =====
PROMPT [3] Cursor long nhau in mon hoc/lop/so luong dang ky
 show user;
CREATE OR REPLACE PROCEDURE p_course_class_report
IS
    CURSOR cur_course IS
        SELECT courseno, description
        FROM course
        ORDER BY courseno;

    CURSOR cur_class (p_courseno NUMBER) IS
        SELECT c.classid,
               COUNT(e.studentid) AS so_sv
        FROM class c
        LEFT JOIN enrollment e
               ON e.classid = c.classid
        WHERE c.courseno = p_courseno
        GROUP BY c.classid
        ORDER BY c.classid;
BEGIN
    FOR r_course IN cur_course LOOP
        DBMS_OUTPUT.PUT_LINE(r_course.courseno || ' ' || r_course.description);

        FOR r_class IN cur_class(r_course.courseno) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Lop: ' || r_class.classid ||
                ' co so luong sinh vien dang ki: ' || r_class.so_sv
            );
        END LOOP;
    END LOOP;
END p_course_class_report;
/

BEGIN
    p_course_class_report;
END;
/

PROMPT ===== BAI 4 - PROCEDURE VA FUNCTION =====

PROMPT [4.1a] Procedure find_sname
Show user;
CREATE OR REPLACE PROCEDURE find_sname (
    i_student_id  IN student.studentid%TYPE,
    o_first_name  OUT student.firstname%TYPE,
    o_last_name   OUT student.lastname%TYPE
)
IS
BEGIN
    SELECT firstname, lastname
    INTO o_first_name, o_last_name
    FROM student
    WHERE studentid = i_student_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        o_first_name := NULL;
        o_last_name := NULL;
        DBMS_OUTPUT.PUT_LINE('Khong tim thay sinh vien ID: ' || i_student_id);
END find_sname;
/

PROMPT [4.1b] Procedure print_student_name
CREATE OR REPLACE PROCEDURE print_student_name (
    i_student_id IN student.studentid%TYPE
)
IS
    v_first  student.firstname%TYPE;
    v_last   student.lastname%TYPE;
BEGIN
    find_sname(i_student_id, v_first, v_last);

    IF v_first IS NOT NULL OR v_last IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Ho ten sinh vien: ' || v_first || ' ' || v_last);
    END IF;
END print_student_name;
/

PROMPT [4.2] Procedure discount
CREATE OR REPLACE PROCEDURE discount
IS
BEGIN
    FOR rec IN (
        SELECT c.courseno, c.description, c.cost
        FROM course c
        WHERE (
            SELECT COUNT(*)
            FROM enrollment e
            JOIN class cl
              ON cl.classid = e.classid
            WHERE cl.courseno = c.courseno
        ) > 15
    )
    LOOP
        UPDATE course
        SET cost = ROUND(cost * 0.95, 2)
        WHERE courseno = rec.courseno;

        DBMS_OUTPUT.PUT_LINE(
            'Da giam gia mon: ' || rec.description ||
            ' | Gia cu: ' || rec.cost ||
            ' | Gia moi: ' || ROUND(rec.cost * 0.95, 2)
        );
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('discount loi: ' || SQLERRM);
END discount;
/

PROMPT [4.3] Function total_cost_for_student
CREATE OR REPLACE FUNCTION total_cost_for_student (
    p_student_id IN student.studentid%TYPE
)
RETURN NUMBER
IS
    v_check  NUMBER;
    v_total  NUMBER;    
BEGIN   
    SELECT COUNT(*)
    INTO v_check
    FROM student
    WHERE studentid = p_student_id;

    IF v_check = 0 THEN
        RETURN NULL;
    END IF;

    SELECT SUM(c.cost)
    INTO v_total
    FROM enrollment e
    JOIN class cl
      ON cl.classid = e.classid
    JOIN course c
      ON c.courseno = cl.courseno
    WHERE e.studentid = p_student_id;

    RETURN v_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END total_cost_for_student;
/

PROMPT ===== BAI 5 - TRIGGER =====

PROMPT [5.1] Audit triggers cho tat ca bang
show user;
CREATE OR REPLACE TRIGGER trg_course_audit
BEFORE INSERT OR UPDATE ON course
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.created_date := SYSDATE;
    END IF;

    :NEW.modified_by := USER;
    :NEW.modified_date := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER trg_class_audit
BEFORE INSERT OR UPDATE ON class
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.created_date := SYSDATE;
    END IF;

    :NEW.modified_by := USER;
    :NEW.modified_date := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER trg_student_audit
BEFORE INSERT OR UPDATE ON student
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.created_date := SYSDATE;
    END IF;

    :NEW.modified_by := USER;
    :NEW.modified_date := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER trg_enrollment_audit
BEFORE INSERT OR UPDATE ON enrollment
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.created_date := SYSDATE;
    END IF;

    :NEW.modified_by := USER;
    :NEW.modified_date := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER trg_instructor_audit
BEFORE INSERT OR UPDATE ON instructor
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.created_date := SYSDATE;
    END IF;

    :NEW.modified_by := USER;
    :NEW.modified_date := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER trg_grade_audit
BEFORE INSERT OR UPDATE ON grade
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by := USER;
        :NEW.created_date := SYSDATE;
    END IF;

    :NEW.modified_by := USER;
    :NEW.modified_date := SYSDATE;
END;
/

PROMPT [5.2] Trigger gioi han toi da 3 lop / sinh vien
show user;
CREATE OR REPLACE TRIGGER trg_max_enrollment
BEFORE INSERT ON enrollment
FOR EACH ROW
DECLARE
    v_so_lop  NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_so_lop
    FROM enrollment
    WHERE studentid = :NEW.studentid;

    IF v_so_lop >= 3 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Sinh vien ' || :NEW.studentid || ' da dang ky du 3 lop! Khong the dang ky them.'
        );
    END IF;
END trg_max_enrollment;
/

show user;
PROMPT [1a + 1b + 1c -> 1j] Kiem tra ket qua bang Cau1
SELECT id, name
FROM cau1
ORDER BY id;

PROMPT [1.2 - Case ton tai] Kiem tra SV da ton tai
BEGIN
    p_check_or_insert_student(101, NULL, NULL, NULL);
END;
/

PROMPT [1.2 - Case khong ton tai] Them moi SV
BEGIN
    p_check_or_insert_student(999, 'Test', 'Moi', 'Thu Duc');
END;
/

SELECT studentid, firstname, lastname, address
FROM student
WHERE studentid IN (101, 502)
ORDER BY studentid;

PROMPT
SET FEEDBACK ON
SET SERVEROUTPUT ON
SET LINESIZE 120
SET VERIFY OFF

-- Thiết lập định dạng ngày tháng để tránh lỗi khi đối chiếu dữ liệu
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';

PROMPT ==================================================
PROMPT KIEM TRA RIENG BAI TAP 2
PROMPT ==================================================

-- Giả sử Vũ đã chạy setup schema trước đó, 
-- ở đây ta chỉ tập trung gọi logic của bài 2
SET SERVEROUTPUT ON

PROMPT
PROMPT --------------------------------------------------
PROMPT [TEST 2.1] p_instructor_workload
PROMPT (Kiem tra IF/ELSE: Phan loai khoi luong giang day)
PROMPT --------------------------------------------------
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Case 1: Giang vien ID = 1 (Co ton tai) ---');
    p_instructor_workload(1);
    
    DBMS_OUTPUT.PUT_LINE('--- Case 2: Giang vien ID = 9999 (Khong ton tai) ---');
    p_instructor_workload(9999);
END;
/

PROMPT
PROMPT ==================================================
PROMPT TEST BAI 4
PROMPT ==================================================
PROMPT [4.1a] Test find_sname
DECLARE
    v_first  student.firstname%TYPE;
    v_last   student.lastname%TYPE;
BEGIN
    find_sname(101, v_first, v_last);
    DBMS_OUTPUT.PUT_LINE('find_sname(101) -> ' || v_first || ' ' || v_last);
END;
/

PROMPT [4.1b] Test print_student_name
BEGIN
    print_student_name(102);
END;
/

PROMPT [4.2] COST TRUOC KHI DISCOUNT
SELECT courseno, description, cost
FROM course
ORDER BY courseno;

BEGIN
    discount;
END;
/
PROMPT


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

show user;
CREATE OR REPLACE VIEW vw_course_summary AS
SELECT co.courseno,
co.description,
co.cost,
COUNT(DISTINCT cl.classid) AS so_lop,
COUNT(e.studentid) AS tong_sv
FROM course co
    LEFT JOIN class cl ON co.courseno = cl.courseno
    LEFT JOIN enrollment e ON cl.classid = e.classid
GROUP BY co.courseno, co.description, co.cost
ORDER BY tong_sv DESC;


--1,2 Tạo view vw_student_status - thông tin sinh viên và tình trạng học tập
show user ;
CREATE OR REPLACE VIEW vw_student_status AS
SELECT s.studentid,
s.firstname || ' ' || s.lastname AS ho_ten,
COUNT(e.classid) AS so_lop_hoc,
NVL(SUM(co.cost), 0) AS tong_hoc_phi,
ROUND(AVG(e.finalgrade), 2) AS diem_tb
FROM student s
JOIN enrollment e ON s.studentid = e.studentid
JOIN class cl ON e.classid = cl.classid
JOIN course co ON cl.courseno = co.courseno
GROUP BY s.studentid, s.firstname, s.lastname
HAVING COUNT(e.classid) >= 1
ORDER BY s.studentid;

SELECT * FROM vw_student_status;

-- Câu 1.3: Tạo view vw_class_availability - lớp học còn chỗ trống
show user; 
CREATE OR REPLACE VIEW vw_class_availability AS
SELECT cl.classid,
     cl.courseno,
    co.description,
    i.firstname || ' ' || i.lastname AS ten_giao_vien,
    cl.capacity,
    COUNT(e.studentid) AS so_da_dk,
    cl.capacity - COUNT(e.studentid) AS cho_trong,
    CASE
        WHEN cl.capacity - COUNT(e.studentid) > 0 THEN 'Con cho'
        ELSE 'Het cho'
    END AS trang_thai
FROM class cl
    JOIN course co ON cl.courseno = co.courseno
    JOIN instructor i ON cl.instructorid = i.instructorid
    LEFT JOIN enrollment e ON cl.classid = e.classid
GROUP BY cl.classid, cl.courseno, co.description,
    i.firstname, i.lastname, cl.capacity
HAVING cl.capacity - COUNT(e.studentid) > 0
ORDER BY cl.classid;
SELECT * FROM vw_class_availability;

--Câu 1.4: Tạo view vw_top_courses - chỉ đọc, top 5 môn được đăng ký nhiều nhất
show user;
CREATE OR REPLACE VIEW vw_top_courses AS
SELECT courseno, description, cost, tong_dk, hang
FROM (
    SELECT 
        co.courseno,
        co.description,
        co.cost,
        COUNT(e.studentid) AS tong_dk,
        RANK() OVER (ORDER BY COUNT(e.studentid) DESC) AS hang
    FROM course co
    LEFT JOIN class cl ON co.courseno = cl.courseno
    LEFT JOIN enrollment e ON cl.classid = e.classid
    GROUP BY co.courseno, co.description, co.cost
)
WHERE hang <= 5
ORDER BY hang
WITH READ ONLY;
SELECT * FROM vw_top_courses;


-- Câu 1.5: Tạo view vw_pending_enrollment với WITH CHECK OPTION
show user;
CREATE OR REPLACE VIEW vw_pending_enrollment AS
SELECT 
    studentid, classid, enrolldate, finalgrade,
    created_by, created_date, modified_by, modified_date
FROM enrollment
WHERE finalgrade IS NULL
WITH CHECK OPTION;
SELECT * FROM vw_pending_enrollment;
-- INSERT 1: FinalGrade = NULL -> THANH CONG (thoa dieu kien where)
INSERT INTO vw_pending_enrollment
(studentid, classid, enrolldate, created_by, created_date,
modified_by, modified_date)
VALUES (999, 1, SYSDATE, USER, SYSDATE, USER, SYSDATE);

-- Câu 2.1: Thủ tục enroll_student - đăng ký sinh viên vào lớp học
show user;
CREATE OR REPLACE PROCEDURE enroll_student (
    p_studentid IN NUMBER,
    p_classid IN NUMBER
) IS
    v_check NUMBER;
    v_capacity NUMBER;
    v_enrolled NUMBER;
BEGIN
    -- DK1: Sinh vien phai ton tai
    SELECT COUNT(*) INTO v_check FROM student WHERE studentid = p_studentid;
    IF v_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Sinh vien ' || p_studentid || ' khong ton tai!');
        RETURN;
    END IF;

    -- DK2: Lop hoc phai ton tai
    SELECT COUNT(*) INTO v_check FROM class WHERE classid = p_classid;
    IF v_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Lop hoc ' || p_classid || ' khong ton tai!');
        RETURN;
    END IF;

    -- DK3: Kiem tra con cho trong
    SELECT capacity INTO v_capacity FROM class WHERE classid = p_classid;
    SELECT COUNT(*) INTO v_enrolled FROM enrollment WHERE classid = p_classid;
    IF v_enrolled >= v_capacity THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Lop ' || p_classid || ' da day! (' || v_enrolled || '/' || v_capacity || ')');
        RETURN;
    END IF;

    -- DK4: Sinh vien chua dang ky lop nay
    SELECT COUNT(*) INTO v_check FROM enrollment 
    WHERE studentid = p_studentid AND classid = p_classid;
    IF v_check > 0 THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Sinh vien da dang ky lop nay roi!');
        RETURN;
    END IF;

    -- DK5: Sinh vien chua qua 3 lop
    SELECT COUNT(*) INTO v_check FROM enrollment WHERE studentid = p_studentid;
    IF v_check >= 3 THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Sinh vien da dang ky du 3 lop!');
        RETURN;
    END IF;

    -- Tat ca OK: INSERT
    INSERT INTO enrollment (studentid, classid, enrolldate, created_by, created_date, modified_by, modified_date)
    VALUES (p_studentid, p_classid, SYSDATE, USER, SYSDATE, USER, SYSDATE);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('[OK] Dang ky thanh cong! SV ' || p_studentid || ' -> Lop ' || p_classid);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('[LOI HE THONG] ' || SQLERRM);
END enroll_student;
/
-- Kiem tra:
BEGIN
    enroll_student(101, 5); 
    enroll_student(999, 5); -- SV khong ton tai
    enroll_student(101, 999); -- Lop khong ton tai
END;
/

-- Câu 2.2: Thủ tục update_final_grade - cập nhật điểm tổng kết
show user;
CREATE OR REPLACE PROCEDURE update_final_grade
    (p_studentid IN NUMBER,
     p_classid   IN NUMBER,
     p_grade     IN NUMBER)
IS
    v_check     NUMBER;
    v_old_grade NUMBER;
BEGIN
    -- Kiem tra diem hop le
    IF p_grade < 0 OR p_grade > 100 THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Diem khong hop le! Phai tu 0 den 100.');
        RETURN;
    END IF;
 
    -- Kiem tra cap (StudentID, ClassID) ton tai trong ENROLLMENT
    SELECT COUNT(*) INTO v_check FROM enrollment
    WHERE studentid = p_studentid AND classid = p_classid;
    IF v_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Sinh vien chua dang ky lop nay!');
        RETURN;
    END IF;
 
    -- Luu diem cu
    SELECT finalgrade INTO v_old_grade FROM enrollment
    WHERE studentid = p_studentid AND classid = p_classid;
 
    -- Cap nhat ENROLLMENT
    UPDATE enrollment
    SET finalgrade    = p_grade,
        modified_by   = USER,
        modified_date = SYSDATE
    WHERE studentid = p_studentid AND classid = p_classid;
 
    -- Dong bo sang bang GRADE bang MERGE INTO
    MERGE INTO grade g
    USING (SELECT p_studentid AS sid, p_classid AS cid FROM DUAL) src
    ON (g.studentid = src.sid AND g.classid = src.cid)
    WHEN MATCHED THEN
        UPDATE SET g.grade        = p_grade,
                   g.modified_by  = USER,
                   g.modified_date = SYSDATE
    WHEN NOT MATCHED THEN
        INSERT (studentid, classid, grade,
                created_by, created_date, modified_by, modified_date)
        VALUES (p_studentid, p_classid, p_grade,
                USER, SYSDATE, USER, SYSDATE);
 
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('[OK] Da cap nhat diem SV ' || p_studentid
                         || ' lop ' || p_classid
                         || ': Cu=' || NVL(TO_CHAR(v_old_grade), 'NULL')
                         || ' -> Moi=' || p_grade);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('[LOI] ' || SQLERRM);
END update_final_grade;
/
 
-- Kiem tra:
BEGIN
    update_final_grade(101, 1001, 90);
    update_final_grade(101, 1001, 150); -- diem khong hop le
END;
/

--- Cau 2.3: transfer_student - chuyen lop cho sinh vien
show user ;
CREATE OR REPLACE PROCEDURE transfer_student
    (p_studentid    IN NUMBER,
     p_old_classid  IN NUMBER,
     p_new_classid  IN NUMBER)
IS
    v_check    NUMBER;
    v_capacity NUMBER;
    v_enrolled NUMBER;
BEGIN
    -- DK1: Sinh vien dang hoc o lop cu
    SELECT COUNT(*) INTO v_check FROM enrollment
    WHERE studentid = p_studentid AND classid = p_old_classid;
    IF v_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Sinh vien khong dang hoc lop ' || p_old_classid);
        RETURN;
    END IF;
 
    -- DK2: Lop moi con cho trong
    SELECT capacity INTO v_capacity FROM class WHERE classid = p_new_classid;
    SELECT COUNT(*) INTO v_enrolled FROM enrollment WHERE classid = p_new_classid;
    IF v_enrolled >= v_capacity THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Lop moi ' || p_new_classid || ' da day!');
        RETURN;
    END IF;
 
    -- DK3: Sinh vien chua dang ky lop moi
    SELECT COUNT(*) INTO v_check FROM enrollment
    WHERE studentid = p_studentid AND classid = p_new_classid;
    IF v_check > 0 THEN
        DBMS_OUTPUT.PUT_LINE('[LOI] Sinh vien da o trong lop moi roi!');
        RETURN;
    END IF;
 
    -- Tat ca OK: thuc hien chuyen lop
    SAVEPOINT sp_truoc_chuyen;
 
    DELETE FROM enrollment
    WHERE studentid = p_studentid AND classid = p_old_classid;
 
    SAVEPOINT sp_sau_xoa;
 
    INSERT INTO enrollment
        (studentid, classid, enrolldate,
         created_by, created_date, modified_by, modified_date)
    VALUES
        (p_studentid, p_new_classid, SYSDATE,
         USER, SYSDATE, USER, SYSDATE);
 
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('[OK] Da chuyen SV ' || p_studentid
                         || ' tu lop ' || p_old_classid
                         || ' sang lop ' || p_new_classid);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO sp_truoc_chuyen;
        DBMS_OUTPUT.PUT_LINE('[LOI] Chuyen lop that bai: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Da rollback ve trang thai ban dau.');
END transfer_student;
/
 
 --2.4
 show user;
 CREATE OR REPLACE PROCEDURE report_class_detail
    (p_classid IN NUMBER)
IS
    v_check      NUMBER;
    v_course     VARCHAR2(50);
    v_courseno   NUMBER;
    v_gv         VARCHAR2(50);
    v_loc        VARCHAR2(50);
    v_cap        NUMBER;
    v_stt        NUMBER := 0;
    v_tong       NUMBER := 0;
    v_sum_d      NUMBER := 0;
    v_co_d       NUMBER := 0;
    v_grade_txt  VARCHAR2(15);
BEGIN
    SELECT COUNT(*) INTO v_check FROM class WHERE classid = p_classid;
    IF v_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Lop hoc ' || p_classid || ' khong ton tai!');
        RETURN;
    END IF;
 
    SELECT co.description, co.courseno,
           i.firstname || ' ' || i.lastname,
           cl.location, cl.capacity
    INTO v_course, v_courseno, v_gv, v_loc, v_cap
    FROM class cl
         JOIN course co    ON cl.courseno     = co.courseno
         JOIN instructor i ON cl.instructorid = i.instructorid
    WHERE cl.classid = p_classid;
 
    DBMS_OUTPUT.PUT_LINE('=== BAO CAO LOP HOC: ' || p_classid || ' ===');
    DBMS_OUTPUT.PUT_LINE('Mon hoc : ' || v_courseno || ' - ' || v_course);
    DBMS_OUTPUT.PUT_LINE('Giao vien: ' || v_gv);
    DBMS_OUTPUT.PUT_LINE('Phong hoc: ' || NVL(v_loc, 'Chua xep phong'));
    DBMS_OUTPUT.PUT_LINE('Suc chua : ' || v_cap || ' cho');
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 50, '-'));
    DBMS_OUTPUT.PUT_LINE('DANH SACH SINH VIEN:');
    DBMS_OUTPUT.PUT_LINE(RPAD('STT', 4) || ' | ' || RPAD('Ho Ten', 20)
                         || ' | ' || LPAD('Diem TK', 8) || ' | Xep loai');
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 50, '-'));
 
    FOR rec IN (
        SELECT s.firstname || ' ' || s.lastname AS ho_ten,
               e.finalgrade
        FROM enrollment e
             JOIN student s ON e.studentid = s.studentid
        WHERE e.classid = p_classid
        ORDER BY s.lastname, s.firstname
    ) LOOP
        v_stt  := v_stt + 1;
        v_tong := v_tong + 1;
 
        IF rec.finalgrade IS NULL THEN
            v_grade_txt := 'Chua co diem';
        ELSIF rec.finalgrade >= 90 THEN
            v_grade_txt := 'A';
            v_sum_d := v_sum_d + rec.finalgrade; v_co_d := v_co_d + 1;
        ELSIF rec.finalgrade >= 80 THEN
            v_grade_txt := 'B';
            v_sum_d := v_sum_d + rec.finalgrade; v_co_d := v_co_d + 1;
        ELSIF rec.finalgrade >= 70 THEN
            v_grade_txt := 'C';
            v_sum_d := v_sum_d + rec.finalgrade; v_co_d := v_co_d + 1;
        ELSIF rec.finalgrade >= 50 THEN
            v_grade_txt := 'D';
            v_sum_d := v_sum_d + rec.finalgrade; v_co_d := v_co_d + 1;
        ELSE
            v_grade_txt := 'F';
            v_sum_d := v_sum_d + rec.finalgrade; v_co_d := v_co_d + 1;
        END IF;
 
        DBMS_OUTPUT.PUT_LINE(
            LPAD(v_stt, 3) || ' | '
            || RPAD(rec.ho_ten, 20) || ' | '
            || LPAD(NVL(TO_CHAR(rec.finalgrade), 'NULL'), 7) || ' | '
            || v_grade_txt
        );
    END LOOP;
 
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 50, '-'));
    DBMS_OUTPUT.PUT_LINE('Tong so sinh vien : ' || v_tong);
    IF v_co_d > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Diem trung binh lop: ' || ROUND(v_sum_d / v_co_d, 2));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Diem trung binh lop: Chua co diem');
    END IF;
END report_class_detail;
/
 
-- Kiem tra voi classid thuc te:
BEGIN
    report_class_detail(1001);
END;
/
 
 -- Cau 2.5: sync_grade_from_enrollment - dong bo diem
show user;

CREATE OR REPLACE PROCEDURE sync_grade_from_enrollment
IS
    v_check       NUMBER;
    v_dem_insert  NUMBER := 0;
    v_dem_update  NUMBER := 0;
BEGIN
    FOR rec IN (
        SELECT studentid, classid, finalgrade
        FROM enrollment
        WHERE finalgrade IS NOT NULL
    ) LOOP
        SELECT COUNT(*) INTO v_check FROM grade
        WHERE studentid = rec.studentid AND classid = rec.classid;
 
        IF v_check = 0 THEN
            INSERT INTO grade
                (studentid, classid, grade,
                 created_by, created_date, modified_by, modified_date)
            VALUES
                (rec.studentid, rec.classid, rec.finalgrade,
                 USER, SYSDATE, USER, SYSDATE);
            v_dem_insert := v_dem_insert + 1;
        ELSE
            UPDATE grade
            SET grade         = rec.finalgrade,
                modified_by   = USER,
                modified_date = SYSDATE
            WHERE studentid = rec.studentid AND classid = rec.classid;
            v_dem_update := v_dem_update + 1;
        END IF;
    END LOOP;
 
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('[OK] Dong bo hoan tat!');
    DBMS_OUTPUT.PUT_LINE('  So ban ghi INSERT moi : ' || v_dem_insert);
    DBMS_OUTPUT.PUT_LINE('  So ban ghi UPDATE     : ' || v_dem_update);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('[LOI] ' || SQLERRM);
END sync_grade_from_enrollment;
/
 
BEGIN sync_grade_from_enrollment; END;
/
 
 Cau 3.1: trg_check_capacity - kiem tra suc chua khi dang ky

show user;
CREATE OR REPLACE TRIGGER trg_check_capacity
    BEFORE INSERT ON enrollment
    FOR EACH ROW
DECLARE
    v_capacity NUMBER;
    v_enrolled NUMBER;
BEGIN
    SELECT capacity INTO v_capacity
    FROM class WHERE classid = :NEW.classid;
 
    SELECT COUNT(*) INTO v_enrolled
    FROM enrollment WHERE classid = :NEW.classid;
 
    IF v_enrolled >= v_capacity THEN
        RAISE_APPLICATION_ERROR(
            -20010,
            'LOI: Lop ' || :NEW.classid || ' da day! ('
            || v_enrolled || '/' || v_capacity || ' cho)'
        );
    END IF;
END trg_check_capacity;
/
 
 -- Kiem tra trigger (dang ky vao lop da day):
    INSERT INTO enrollment
    (studentid, classid, enrolldate, created_by, created_date,
    modified_by, modified_date)
    VALUES (999, 1, SYSDATE, USER, SYSDATE, USER, SYSDATE);

-- Cau 3.2: Bang audit log va trigger ghi nhat ky thay doi diem
show user;
CREATE TABLE grade_audit_log (
    log_id     NUMBER GENERATED ALWAYS AS IDENTITY,
    studentid  NUMBER(8),
    classid    NUMBER(8),
    grade_cu   NUMBER(3),
    grade_moi  NUMBER(3),
    nguoi_sua  VARCHAR2(30),
    thoi_gian  DATE
);
 
CREATE OR REPLACE TRIGGER trg_grade_audit_log
    AFTER UPDATE OF finalgrade ON enrollment
    FOR EACH ROW
BEGIN
    IF (   (:OLD.finalgrade IS NULL     AND :NEW.finalgrade IS NOT NULL)
        OR (:OLD.finalgrade IS NOT NULL AND :NEW.finalgrade IS NULL)
        OR (:OLD.finalgrade != :NEW.finalgrade)
       )
    THEN
        INSERT INTO grade_audit_log
            (studentid, classid, grade_cu, grade_moi, nguoi_sua, thoi_gian)
        VALUES
            (:OLD.studentid, :OLD.classid, :OLD.finalgrade,
             :NEW.finalgrade, USER, SYSDATE);
    END IF;
END trg_grade_audit_log;
/
 
-- Kiem tra:
UPDATE enrollment SET finalgrade = 88
WHERE studentid = 102 AND classid = 1001;
COMMIT;
SELECT * FROM grade_audit_log;
 
 

-- Cau 3.3: trg_prevent_course_delete - ngan xoa mon hoc dang co lop
show user;
CREATE OR REPLACE TRIGGER trg_prevent_course_delete
    BEFORE DELETE ON course
    FOR EACH ROW
DECLARE
    v_so_lop NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_so_lop
    FROM class WHERE courseno = :OLD.courseno;
 
    IF v_so_lop > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20020,
            'Khong the xoa mon hoc ' || :OLD.courseno ||
            ' (' || :OLD.description || ') ' ||
            'vi con ' || v_so_lop || ' lop hoc dang ton tai!'
        );
    END IF;
END trg_prevent_course_delete;
/
 
-- Kiem tra: xoa mon co lop (se bao loi)
 DELETE FROM course WHERE courseno = 10;
-- Kiem tra: xoa mon khong co lop (thanh cong)
 DELETE FROM course WHERE courseno = 50; ROLLBACK;
 

-- Cau 3.4: Bang thong ke va trigger cap nhat tu dong
show user;
CREATE TABLE class_grade_summary (
    classid         NUMBER(8) PRIMARY KEY,
    so_sv           NUMBER,
    diem_tb         NUMBER(5, 2),
    diem_cao_nhat   NUMBER(3),
    diem_thap_nhat  NUMBER(3),
    cap_nhat_luc    DATE
);
 
CREATE OR REPLACE TRIGGER trg_update_grade_summary
    AFTER INSERT OR UPDATE OR DELETE ON enrollment
    FOR EACH ROW
DECLARE
    v_classid  NUMBER;
    v_so_sv    NUMBER;
    v_diem_tb  NUMBER;
    v_max_d    NUMBER;
    v_min_d    NUMBER;
BEGIN
    IF INSERTING OR UPDATING THEN
        v_classid := :NEW.classid;
    ELSE
        v_classid := :OLD.classid;
    END IF;
 
    SELECT COUNT(finalgrade),
           ROUND(AVG(finalgrade), 2),
           MAX(finalgrade),
           MIN(finalgrade)
    INTO v_so_sv, v_diem_tb, v_max_d, v_min_d
    FROM enrollment
    WHERE classid = v_classid AND finalgrade IS NOT NULL;
 
    MERGE INTO class_grade_summary cgs
    USING (SELECT v_classid AS cid FROM DUAL) src
    ON (cgs.classid = src.cid)
    WHEN MATCHED THEN
        UPDATE SET so_sv          = v_so_sv,
                   diem_tb        = v_diem_tb,
                   diem_cao_nhat  = v_max_d,
                   diem_thap_nhat = v_min_d,
                   cap_nhat_luc   = SYSDATE
    WHEN NOT MATCHED THEN
        INSERT (classid, so_sv, diem_tb, diem_cao_nhat, diem_thap_nhat, cap_nhat_luc)
        VALUES (v_classid, v_so_sv, v_diem_tb, v_max_d, v_min_d, SYSDATE);
END trg_update_grade_summary;
/
 
-- Kiem tra trigger:
UPDATE enrollment SET finalgrade = 95 WHERE studentid = 101 AND classid = 1001;
COMMIT;
SELECT * FROM class_grade_summary WHERE classid = 1001;
 

-- Cau 4.1 Buoc 1: vw_instructor_workload
show user ;
CREATE OR REPLACE VIEW vw_instructor_workload AS
SELECT i.instructorid,
       i.firstname || ' ' || i.lastname           AS ho_ten,
       COUNT(DISTINCT cl.classid)                  AS so_lop,
       COUNT(e.studentid)                          AS tong_sv,
       ROUND(AVG(e.finalgrade), 2)                 AS diem_tb_chung,
       CASE
           WHEN COUNT(DISTINCT cl.classid) >= 3 THEN 'Ban nhieu'
           WHEN COUNT(DISTINCT cl.classid) = 2  THEN 'Binh thuong'
           ELSE 'Nhe nhang'
       END                                         AS muc_ban
FROM instructor i
     LEFT JOIN class cl      ON i.instructorid = cl.instructorid
     LEFT JOIN enrollment e  ON cl.classid     = e.classid
GROUP BY i.instructorid, i.firstname, i.lastname
ORDER BY so_lop DESC;
 
SELECT * FROM vw_instructor_workload;
 
 

-- Cau 4.1 Buoc 2: print_system_report
show user; 
CREATE OR REPLACE PROCEDURE print_system_report
IS
    v_so_mon  NUMBER;
    v_so_lop  NUMBER;
    v_so_sv   NUMBER;
    v_so_gv   NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_so_mon FROM course;
    SELECT COUNT(*) INTO v_so_lop FROM class;
    SELECT COUNT(*) INTO v_so_sv  FROM student;
    SELECT COUNT(*) INTO v_so_gv  FROM instructor;
 
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('  BAO CAO TOAN HE THONG QUAN LY KHOA HOC');
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('Tong so mon hoc : ' || v_so_mon);
    DBMS_OUTPUT.PUT_LINE('Tong so lop hoc : ' || v_so_lop);
    DBMS_OUTPUT.PUT_LINE('Tong so sinh vien: ' || v_so_sv);
    DBMS_OUTPUT.PUT_LINE('Tong so giao vien: ' || v_so_gv);
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 50, '-'));
 
    -- Phan 1: Thong ke giao vien
    DBMS_OUTPUT.PUT_LINE('THONG KE GIAO VIEN:');
    FOR rec IN (SELECT * FROM vw_instructor_workload) LOOP
        DBMS_OUTPUT.PUT_LINE(
            '  ' || RPAD(rec.ho_ten, 25)
            || ' | ' || LPAD(rec.so_lop, 2) || ' lop'
            || ' | ' || LPAD(rec.tong_sv, 3) || ' SV'
            || ' | DTB: ' || NVL(TO_CHAR(rec.diem_tb_chung), '--')
            || ' | ' || rec.muc_ban
        );
    END LOOP;
 
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 50, '-'));
 
    -- Phan 2: Top 3 mon hoc
    DBMS_OUTPUT.PUT_LINE('TOP 3 MON HOC DUOC DANG KY NHIEU NHAT:');
    FOR rec IN (SELECT * FROM vw_top_courses WHERE hang <= 3) LOOP
        DBMS_OUTPUT.PUT_LINE(
            '  ' || rec.hang || '. '
            || RPAD(rec.description, 30)
            || ' - ' || rec.tong_dk || ' luot dang ky'
        );
    END LOOP;
 
    DBMS_OUTPUT.PUT_LINE('==================================================');
END print_system_report;
/
 
-- Chay bao cao:
BEGIN
    print_system_report;
END;
/
 
 
 
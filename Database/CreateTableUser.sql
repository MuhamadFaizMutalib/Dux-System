CREATE TABLE user (
    id_user INT NOT NULL AUTO_INCREMENT, 
    username VARCHAR(255),
    email VARCHAR(255),
    role VARCHAR(20),
    siri VARCHAR(20),
    password VARCHAR(255),
    PRIMARY KEY (id_user)
);


INSERT INTO user(username, email, role, siri, password ) VALUES('faiz', 'faiz.am@gmail.com', 'admin', 'AD001', 'faiz12345');
INSERT INTO user(username, email, role, siri, password ) VALUES('lew', 'lew.am@gmail.com', 'coordinator', 'CD001', 'lew12345');

INSERT INTO user(username, email, role, siri, password ) VALUES
('John Doe', 'john.doe@studentmail.com', 'student', 'ST001', 'student12345'),
('Jane Smith', 'jane.smith@studentmail.com', 'student', 'ST002', 'student12345'),
('Alex Johnson', 'alex.johnson@studentmail.com', 'student', 'ST003', 'student12345'),
('Emily Davis', 'emily.davis@studentmail.com', 'student', 'ST004', 'student12345'),
('Michael Brown', 'michael.brown@studentmail.com', 'student', 'ST005', 'student12345');
INSERT INTO user(username, email, role, siri, password ) VALUES
('Sophie Williams', 'sophie.williams@studentmail.com', 'student', 'ST006', 'student12345'),
('Benjamin Lee', 'benjamin.lee@studentmail.com', 'student', 'ST007', 'student12345'),
('Emma White', 'emma.white@studentmail.com', 'student', 'ST008', 'student12345'),
('Jacob Turner', 'jacob.turner@studentmail.com', 'student', 'ST009', 'student12345'),
('Olivia Martin', 'olivia.martin@studentmail.com', 'student', 'ST010', 'student12345');

INSERT INTO user(username, email, role, siri, password ) VALUES
('Dr. Robert Miller', 'robert.miller@lecturermail.com', 'lecturer', 'LT001', 'lecturer12345'),
('Prof. Lisa Thompson', 'lisa.thompson@lecturermail.com', 'lecturer', 'LT002', 'lecturer12345'),
('Dr. James Wilson', 'james.wilson@lecturermail.com', 'lecturer', 'LT003', 'lecturer12345'),
('Prof. Sarah Turner', 'sarah.turner@lecturermail.com', 'lecturer', 'LT004', 'lecturer12345'),
('Dr. Kevin Harris', 'kevin.harris@lecturermail.com', 'lecturer', 'LT005', 'lecturer12345');
INSERT INTO user(username, email, role, siri, password ) VALUES
('Prof. David Clark', 'david.clark@lecturermail.com', 'lecturer', 'LT006', 'lecturer12345'),
('Dr. Rebecca Evans', 'rebecca.evans@lecturermail.com', 'lecturer', 'LT007', 'lecturer12345'),
('Prof. Brian Turner', 'brian.turner@lecturermail.com', 'lecturer', 'LT008', 'lecturer12345'),
('Dr. Julia Mitchell', 'julia.mitchell@lecturermail.com', 'lecturer', 'LT009', 'lecturer12345'),
('Prof. Samuel Wright', 'samuel.wright@lecturermail.com', 'lecturer', 'LT010', 'lecturer12345');


CREATE TABLE student (id_student INT NOT NULL AUTO_INCREMENT, 
                      matric VARCHAR(15) NOT NULL UNIQUE, 
                      S_name VARCHAR(100), 
                      S_email VARCHAR(255),
                      S_role VARCHAR(20),
                      programme VARCHAR(20),
                      PRIMARY KEY (id_student));

INSERT INTO student(matric, S_name, S_email, S_role, programme) VALUES
('ST001', 'John Doe', 'john.doe@studentmail.com', 'student', 'SECRH'),
('ST002', 'Jane Smith', 'jane.smith@studentmail.com', 'student', 'SECVH'),
('ST003', 'Alex Johnson', 'alex.johnson@studentmail.com', 'student', 'SECJH'),
('ST004', 'Emily Davis', 'emily.davis@studentmail.com', 'student', 'SECBH'),
('ST005', 'Michael Brown', 'michael.brown@studentmail.com', 'student', 'SECPH'),
('ST006', 'Sophie Williams', 'sophie.williams@studentmail.com', 'student', 'SECRH'),
('ST007', 'Benjamin Lee', 'benjamin.lee@studentmail.com', 'student', 'SECVH'),
('ST008', 'Emma White', 'emma.white@studentmail.com', 'student', 'SECJH'),
('ST009', 'Jacob Turner', 'jacob.turner@studentmail.com', 'student', 'SECBH'),
('ST010', 'Olivia Martin', 'olivia.martin@studentmail.com', 'student', 'SECPH');


CREATE TABLE lecturer (id_lecturer INT NOT NULL AUTO_INCREMENT, 
                      LectID VARCHAR(15) NOT NULL UNIQUE, 
                      L_name VARCHAR(100),
                      L_email VARCHAR(255),
                      L_role VARCHAR(20),
                      programme VARCHAR(20), 
                      PRIMARY KEY (id_lecturer));

INSERT INTO lecturer(LectID, L_name, L_email, L_role, programme) VALUES
('LT001', 'Dr. Robert Miller', 'robert.miller@lecturermail.com', 'lecturer', 'SECRH'),
('LT002', 'Prof. Lisa Thompson', 'lisa.thompson@lecturermail.com', 'lecturer', 'SECVH'),
('LT003', 'Dr. James Wilson', 'james.wilson@lecturermail.com', 'lecturer', 'SECJH'),
('LT004', 'Prof. Sarah Turner', 'sarah.turner@lecturermail.com', 'lecturer', 'SECBH'),
('LT005', 'Dr. Kevin Harris', 'kevin.harris@lecturermail.com', 'lecturer', 'SECPH'),
('LT006', 'Prof. David Clark', 'david.clark@lecturermail.com', 'lecturer', 'SECRH'),
('LT007', 'Dr. Rebecca Evans', 'rebecca.evans@lecturermail.com', 'lecturer', 'SECVH'),
('LT008', 'Prof. Brian Turner', 'brian.turner@lecturermail.com', 'lecturer', 'SECJH'),
('LT009', 'Dr. Julia Mitchell', 'julia.mitchell@lecturermail.com', 'lecturer', 'SECBH'),
('LT010', 'Prof. Samuel Wright', 'samuel.wright@lecturermail.com', 'lecturer', 'SECPH');




CREATE TABLE Timetable(id_TimeTable INT NOT NULL AUTO_INCREMENT, 
                      Session VARCHAR(15) NOT NULL, 
                      Semester VARCHAR(100),
                      Category VARCHAR(255),
                      Programme VARCHAR(20),
                      TimeTable_Link VARCHAR(255), 
                      PRIMARY KEY (id_TimeTable));

INSERT INTO Timetable(Session, Semester, Category, Programme, TimeTable_Link) VALUES
('2019/2020', 'Semester 1', 'Undergraduate', 'SECRH', 'https://timetablelink1.com'),
('2020/2021', 'Semester 2', 'Postgraduate', 'SECVH', 'https://timetablelink2.com'),
('2021/2022', 'Semester 1', 'Undergraduate', 'SECJH', 'https://timetablelink3.com'),
('2019/2020', 'Semester 2', 'Postgraduate', 'SECBH', 'https://timetablelink4.com'),
('2020/2021', 'Semester 1', 'Undergraduate', 'SECPH', 'https://timetablelink5.com'),
('2021/2022', 'Semester 2', 'Postgraduate', 'SECRH', 'https://timetablelink6.com'),
('2019/2020', 'Semester 1', 'Undergraduate', 'SECVH', 'https://timetablelink7.com'),
('2020/2021', 'Semester 2', 'Postgraduate', 'SECJH', 'https://timetablelink8.com'),
('2021/2022', 'Semester 1', 'Undergraduate', 'SECBH', 'https://timetablelink9.com'),
('2019/2020', 'Semester 2', 'Postgraduate', 'SECPH', 'https://timetablelink10.com');




CREATE TABLE Event(id_event INT NOT NULL AUTO_INCREMENT, 
                      Session VARCHAR(15) NOT NULL, 
                      Semester VARCHAR(100),
		      Date VARCHAR(100),
                      Category VARCHAR(255),
                      ProgramName VARCHAR(200),
                      Programme_Link VARCHAR(255), 
                      PRIMARY KEY (id_event));

INSERT INTO Event(Session, Semester, Date, Category, ProgramName, Programme_Link) VALUES
('2019/2020', 'Semester 1', '2023-01-15', 'Leadership', 'Leadership Workshop', 'https://leadershipworkshoplink1.com'),
('2020/2021', 'Semester 2', '2023-02-20', 'Career', 'Career Fair', 'https://careerfairlink2.com'),
('2021/2022', 'Semester 1', '2023-03-25', 'Academic', 'Guest Lecture Series', 'https://lecturelink3.com'),
('2019/2020', 'Semester 2', '2023-04-10', 'Entrepreneurship', 'Startup Expo', 'https://startupexpolink4.com'),
('2020/2021', 'Semester 1', '2023-05-15', 'Volunteer', 'Community Service Day', 'https://communityservicelink5.com'),
('2021/2022', 'Semester 2', '2023-06-20', 'Leadership', 'Leadership Seminar', 'https://leadershipseminarlink6.com'),
('2019/2020', 'Semester 1', '2023-07-25', 'Career', 'Job Fair', 'https://jobfairlink7.com'),
('2020/2021', 'Semester 2', '2023-08-10', 'Academic', 'Research Symposium', 'https://researchsymposiumlink8.com'),
('2021/2022', 'Semester 1', '2023-09-15', 'Entrepreneurship', 'Innovation Conference', 'https://innovationconferencelink9.com'),
('2019/2020', 'Semester 2', '2023-10-20', 'Volunteer', 'Blood Donation Drive', 'https://blooddonationdrivelink10.com');



CREATE TABLE PSM(id_psm INT NOT NULL AUTO_INCREMENT, 
                      Session VARCHAR(15) NOT NULL, 
                      Semester VARCHAR(100),
                      Category VARCHAR(100),
                      student_name VARCHAR(100),
                      student_MatricNo VARCHAR(100),
		      title VARCHAR(100),
                      marks VARCHAR(10),
                      Supervisor VARCHAR(100),
                      psm_link VARCHAR(100), 
                      PRIMARY KEY (id_psm));

INSERT INTO PSM(Session, Semester, Category, student_name, student_MatricNo, title, marks, Supervisor, psm_link) VALUES
('2019/2020', 'Semester 1', 'PSM 1', 'John Doe', 'ST001', 'PSM Title 1', '85', 'Dr. Robert Miller', 'https://psmlink1.com'),
('2019/2020', 'Semester 1', 'PSM 2', 'John Doe', 'ST001', 'PSM Title 2', '92', 'Prof. Lisa Thompson', 'https://psmlink2.com'),
('2020/2021', 'Semester 2', 'PSM 1', 'Jane Smith', 'ST002', 'PSM Title 3', '78', 'Dr. James Wilson', 'https://psmlink3.com'),
('2020/2021', 'Semester 2', 'PSM 2', 'Jane Smith', 'ST002', 'PSM Title 4', '89', 'Dr. Robert Miller', 'https://psmlink4.com'),
('2021/2022', 'Semester 1', 'PSM 1', 'Alex Johnson', 'ST003', 'PSM Title 5', '95', 'Prof. Lisa Thompson', 'https://psmlink5.com'),
('2021/2022', 'Semester 1', 'PSM 2', 'Alex Johnson', 'ST003', 'PSM Title 6', '88', 'Dr. James Wilson', 'https://psmlink6.com'),
('2019/2020', 'Semester 2', 'PSM 1', 'Emily Davis', 'ST004', 'PSM Title 7', '75', 'Prof. Lisa Thompson', 'https://psmlink7.com'),
('2019/2020', 'Semester 2', 'PSM 2', 'Emily Davis', 'ST004', 'PSM Title 8', '82', 'Dr. James Wilson', 'https://psmlink8.com'),
('2020/2021', 'Semester 1', 'PSM 1', 'Michael Brown', 'ST005', 'PSM Title 9', '90', 'Dr. Robert Miller', 'https://psmlink9.com'),
('2020/2021', 'Semester 1', 'PSM 2', 'Michael Brown', 'ST005', 'PSM Title 10', '87', 'Prof. Lisa Thompson', 'https://psmlink10.com');




PRAGMA foreign_keys = on;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS student_course;
DROP TABLE IF EXISTS category_course;
CREATE TABLE student (name VARCHAR (32), email VARCHAR (32), phone VARCHAR (32), user_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE);
CREATE TABLE category_course (category_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, name VARCHAR (32));
CREATE TABLE course (type VARCHAR (32), category_id INTEGER NOT NULL, name VARCHAR (32), description VARCHAR (32), address VARCHAR (32), url VARCHAR (32), course_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, FOREIGN KEY (category_id) REFERENCES category_course(category_id) ON DELETE CASCADE);
CREATE TABLE student_course (student_id INTEGER NOT NULL, course_id INTEGER NOT NULL, FOREIGN KEY (student_id) REFERENCES student(user_id) ON DELETE CASCADE, FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE);

COMMIT TRANSACTION;
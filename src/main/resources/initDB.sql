USE test;
DROP TABLE IF EXISTS library;

CREATE TABLE test.library (
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100),
  description VARCHAR(255),
  author VARCHAR(100),
  isbn VARCHAR(20),
  printYear INTEGER,
  readAlready BOOLEAN);
--
-- BE-IT DK2 A20
-- Gruppe 30
-- Benjamin Eibye, Christian K. Brodersen, Jonas Tvede og Ida Maria Ingerslev
--

--
-- This sqript will delete and create all tables and records when runned. 
--

-- Create DB
CREATE DATABASE IF NOT EXISTS CT;

-- Uses DB
USE CT;

-- Clean DB
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `User`;
DROP TABLE IF EXISTS `Session`;
DROP TABLE IF EXISTS `Quiz`;
DROP TABLE IF EXISTS `Question`;
DROP TABLE IF EXISTS `Answers`;
SET FOREIGN_KEY_CHECKS=1;

-- CREATE TABLES
CREATE TABLE IF NOT EXISTS `User` (
	`id` int NOT NULL AUTO_INCREMENT,
    `firstName` varchar(55) NOT NULL,
    `lastName` varchar(55) NOT NULL,
    `email` varchar(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS `Session` (
	`id` int NOT NULL AUTO_INCREMENT,
    `QuizId` int NOT NULL,
    `userId` int NOT NULL,
    `created` datetime NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Quiz` (
	`id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(55) NOT NULL,
    `info` varchar(155),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS `WeightType` (
	`id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(55) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS `Question` (
	`id` int NOT NULL AUTO_INCREMENT,
    `WeightTypeId` int NOT NULL,
    `QuizId` int NOT NULL,
    `title` varchar(100) NOT NULL,
    `info` varchar(155),
    `weight` int(2) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS `Answers` (
	`id` int NOT NULL AUTO_INCREMENT,
    `QuesitonId` int NOT NULL,
    `SessionId` varchar(55) NOT NULL,
    `answer` int(1) NOT NULL,
    PRIMARY KEY (`id`)
);

-- Create view, with gets a list of alle the users
CREATE OR REPLACE VIEW Users AS
SELECT *
FROM `User`;

-- Use
-- SELECT * FROM Users;

-- Creates a view, with shows all sessions and the connected quiz and users information
CREATE OR REPLACE VIEW Sessions AS
SELECT Session.id AS `Session Id`, Quiz.id AS `Quiz Id`, Quiz.name, User.id AS `User Id`, User.firstName, User.lastName, Session.created
FROM
    Session,
    Quiz,
    User
WHERE
	Session.userId = User.id
    AND
    Session.QuizId = Quiz.id;


-- Creates a view, witch shows all Quizzes
CREATE OR REPLACE VIEW Quizzes AS
SELECT *
FROM `Quiz`;

-- Creates a view, witch shows all questions - Add WHERE `Quiz Id` = {Selected Quiz id} if only want questions from a specefic quiz
CREATE OR REPLACE VIEW Questions AS
SELECT Quiz.id AS `Quiz Id`, Quiz.name AS `Quiz Name`, WeightType.name AS `Type`, Question.title, Question.info, Question.weight
FROM
	Quiz,
    WeightType,
    Question
WHERE
    Quiz.id = Question.QuizId
    AND
    Question.WeightTypeId = WeightType.id;

-- Creates view, with shows the answer for a session. It includes details about the Question, answer, WeightType
CREATE OR REPLACE VIEW SessionAnswers AS
SELECT
	Answers.id,
	Question.id AS `Question ID`,
    Question.title AS `Question Title`,
    Question.weight AS `Weight`,
    Answers.answer AS `Answer`,
    WeightType.name AS `Type`,
    Session.id AS `Session Id`,
    User.id AS `User Id`,
    User.firstName AS `User firstname`
FROM 
	Answers,
    Question,
    WeightType,
    Session,
    User
WHERE
	Answers.QuesitonId = Question.id
AND
	WeightType.id = Question.WeightTypeId
AND
	Answers.SessionId = Session.id
AND
	User.id = Session.userId
;


-- Adds fillerdata to the DB
INSERT INTO `user` (`firstName`, `lastName`, `email`)
VALUES
('Benjamin','Eibye','benj041e@stud.kea.dk'),
('Ida Marie','Ingerslev','idax6700@stud.kea.dk'),
('Christian','Klitgaard Brodersen','chri18e7@stud.kea.dk'),
('Jonas','Tvede','jona97g7@stud.kea.dk');

INSERT INTO `Quiz` (`Name`, `Info`)
VALUES
('Where to start?','This Quiz gets the data about what course element has the heighst interest'),
('Test Quiz 2','This is test Quiz 2');

INSERT INTO `WeightType`
VALUES
(NULL,'Graphical Design'),
(NULL,'Programming'),
(NULL,'SoMe');


INSERT INTO `Question` 
VALUES
(NULL,1,1, 'Do you appreciate design in relation to products?', 'E.g. Does a shoe have to be functional or good looking?', 5),
(NULL,1,1, 'Do you have a favourite artist when it comes to visual art?', 'Could be a painter, performance artist etc.', 5),
(NULL,1,1, 'Do you enjoy making visual presentations for school or business?', 'Do you feel at home with Powerpoint or Keynote?', 5),
(NULL,1,1, 'Have you tried editing video on your mobile device or PC?', 'Maybe editing an insta story or a video editing', 5),
(NULL,2,1, 'Do you like to take online intelligence tests?', 'E.g. Are you interested in developing your analytical skills?', 5),
(NULL,2,1, 'Do you find numbers and logic is preferred over philosophical questions?', 'E.g. Did you like Math in school?', 5),
(NULL,2,1, 'Are you interested in coding and learning to either understand or code yourself?', 'Have you tried learning code at some point?', 5),
(NULL,2,1, 'Have you tried building a website with a CMS like wordpress or Wix?', 'Do you feel the options are limited and would more flexibility', 5),
(NULL,3,1, 'Are you very active on Social Media?', 'Do you have more than 2 SoMe platforms that you actively use?', 5),
(NULL,3,1, 'Do you care about who likes and comments on your posts?', 'Do you create stories on Instagram and track their performance?', 5),
(NULL,3,1, 'Do you find that Social Media influences your buying decisions?', 'Have you bought something via Instagram or Facebook pages?', 5),
(NULL,3,1, 'Do you believe that Social Media is more effective than traditional marketing?', 'Are there SoMe influencers you would trust in recommending products to you?', 5),
(NULL,1,2, 'Dummy question from quizz 2', 'Dummy quiz', 5);

INSERT INTO Session
VALUES
(NULL,1,1, NOW()),
(NULL,1,2, NOW()),
(NULL,1,3, NOW()),
(NULL,1,4, NOW()),
(NULL,2,2, NOW()),
(NULL,1,3, NOW());

INSERT INTO Answers
VALUES
(NULL,1,1,1),
(NULL,2,1,1),
(NULL,3,1,1),
(NULL,4,1,0),
(NULL,5,1,0),
(NULL,6,1,0),
(NULL,7,1,1),
(NULL,8,1,0),
(NULL,9,1,1),
(NULL,10,1,0),
(NULL,11,1,1),
(NULL,12,1,0),
(NULL,1,2,1),
(NULL,2,2,0),
(NULL,3,2,1),
(NULL,4,2,0),
(NULL,5,2,1),
(NULL,6,2,0);

USE messaging;
/*Insert Record into Person table*/
INSERT INTO messaging.person(person_id, first_name, last_name)
VALUES ('7', 'Travis', 'Brown');
SELECT * FROM person;

/*Alter the Person table to 'middle_initial' column defaulted as null for all rows*/
ALTER TABLE messaging.person ADD middle_initial VARCHAR(1) DEFAULT NULL;
SELECT * FROM person;

/*Update the Person table to change the middle initial in the row where 'person_id' is 7*/
UPDATE person SET middle_initial = 'P' WHERE person_id = 7;
SELECT * FROM person;

/*Deletes the row in the person table for Diana Taurasi*/
DELETE FROM person WHERE first_name = 'Diana' AND last_name = 'Taurasi';
SELECT * FROM person;

/*Alters the contact list table to add a 'favorite' column*/
ALTER TABLE messaging.contact_list ADD favorite VARCHAR(10) DEFAULT NULL;
SELECT * FROM contact_list;

/*Update contact list to set favorite column value to 'y' if 'contact_id' = 1*/
UPDATE contact_list SET favorite = 'y' WHERE contact_id = '1';
SELECT * FROM contact_list;

/*Updates favorite column for all rows who's contact_id is not '1' to 'n'*/
UPDATE contact_list SET favorite = 'n' WHERE contact_id <> '1';
SELECT * FROM contact_list;

/*Add three more rows to contact_list table*/
INSERT INTO messaging.contact_list(person_id, contact_id, favorite)
VALUES ('7', '1', 'y');
INSERT INTO messaging.contact_list(person_id, contact_id, favorite)
VALUES ('5', '1', 'y');
INSERT INTO messaging.contact_list(person_id, contact_id, favorite)
VALUES ('3', '2', 'n');
SELECT * FROM contact_list;

/*Create a new table called 'image'*/
CREATE TABLE image (
    image_id INT (8) NOT NULL auto_increment,
    image_name VARCHAR (50) NOT NULL,
    image_location VARCHAR(250) NOT NULL,
    PRIMARY KEY (image_id)
) AUTO_INCREMENT=1;
SHOW COLUMNS FROM image; 

/*Create a new table called message_image created from existing columns in other tables
  FOREIGN KEY sets the column for the new table from and existing table
  REFERENCES sets the table and column to pull from
*/
CREATE TABLE message_image (
    message_id INT (8) NOT NULL,
    image_id INT(8) NOT NULL,
    PRIMARY KEY (message_id, image_id),
    FOREIGN KEY (message_id) REFERENCES message(message_id),
    FOREIGN KEY (image_id) REFERENCES image(image_id)
) AUTO_INCREMENT=1;
SHOW COLUMNS FROM message_image;

/*Adds rows of data to the image table*/
INSERT INTO messaging.image(image_name, image_location)
VALUES ('Ocean View', 'Venice Beach'),
('Family Photo', 'Georgia'),
('Fishing Trip', 'Montana'),
('Concert', 'Virginia'),
('Alligator', 'FLorida');
SELECT * FROM messaging.image;

/*Add records to message_image table*/
INSERT INTO messaging.message_image(message_id, image_id)
VALUES ('1', '2'),
('1', '1'),
('3', '5'),
('4', '3'),
('2', '4');
SELECT * FROM messaging.message_image;

/*Find all messages that michael Phelps sent*/

/*SELECT decides what colums we want to see*/
SELECT sender.first_name, sender.last_name, reciever.first_name, reciever.last_name, message.message_id, message.message, message.send_datetime
/*FROM states which tables the columns are in*/
FROM message message, person sender, person reciever
/*WHERE and AND narrows down the rows pulled to only the rows who meet the criteria*/
WHERE message.sender_id = sender.person_id
AND message.receiver_id = reciever.person_id
AND sender.first_name = 'Michael'
AND sender.last_name = 'Phelps';

/*Find Number of messages sent by every person in the records*/

/*SELECT COUNT(*) displays the number of times a certain parameter is recorded
  AS lets us alias the the table we are creating
*/
SELECT COUNT(*) AS count_message, person.person_id, person.first_name, person.last_name
FROM message, person 
WHERE message.sender_id = person.person_id
GROUP BY person.person_id, person.first_name, person.last_name;

/*Find all messages with an image attached to it*/

/*INNER JOIN puts multiple columns together from different tables into one table*/
SELECT message_image.message_id, min(message.message) AS message, 
       min(message.send_datetime) AS message_timestamp, 
       min(image.image_name) AS image_name, 
       min(image.image_location) AS image_location 
from message  
INNER JOIN message_image ON message.message_id = message_image.message_id 
INNER JOIN image  ON image.image_id = message_image.image_id
GROUP BY message_image.message_id;
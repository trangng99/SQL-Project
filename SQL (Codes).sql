--DDL codes in SQL

--Create the schema
CREATE SCHEMA ACCOMMODATION;

GO

--Create tables
CREATE TABLE ACCOMMODATION.Student (
  student_id INT PRIMARY KEY NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  education_level VARCHAR(255) NOT NULL,
  student_number VARCHAR (255) NOT NULL,
  personal_email VARCHAR(255) NOT NULL,
  school_email VARCHAR(255) NOT NULL,
  student_gender VARCHAR(255) NOT NULL,
  student_DOB DATETIME2 NOT NULL,
  nationality VARCHAR(255) NOT NULL
);

CREATE TABLE ACCOMMODATION.Landlord_Type (
  landlord_type_id INT PRIMARY KEY NOT NULL,
  landlord_type_name VARCHAR(255) NOT NULL
);

CREATE TABLE ACCOMMODATION.Room_Type (
  room_type_id INT PRIMARY KEY NOT NULL,
  room_type VARCHAR(255) NOT NULL
);

CREATE TABLE ACCOMMODATION.Rental_Agent (
  rental_agent_id INT PRIMARY KEY NOT NULL,
  rental_agent_first_name VARCHAR(255) NOT NULL,
  rental_agent_last_name VARCHAR(255) NOT NULL,
  rental_agent_gender VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR (255) NOT NULL
);

CREATE TABLE ACCOMMODATION.ContractLength (
  contract_length_id INT PRIMARY KEY NOT NULL,
  contract_length INT NOT NULL
);

CREATE TABLE ACCOMMODATION.Landlord (
  landlord_id INT PRIMARY KEY NOT NULL,
  landlord_type_id INT NOT NULL,
  landlord_first_name VARCHAR(255) NOT NULL,
  landlord_last_name VARCHAR(255) NOT NULL,
  landlord_gender VARCHAR(255) NULL,
  landlord_email VARCHAR(255) NOT NULL,
  landlord_phone_number VARCHAR(255) NOT NULL,
  FOREIGN KEY (landlord_type_id) REFERENCES ACCOMMODATION.Landlord_Type(landlord_type_id)
);

CREATE TABLE ACCOMMODATION.Residence (
  residence_id INT PRIMARY KEY NOT NULL,
  landlord_id INT NOT NULL,
  is_catered BIT NOT NULL,
  residence_name VARCHAR(255) NOT NULL,
  total_rooms_available INT NOT NULL,
  is_central_social_space BIT NOT NULL,
  is_cleaning_provision BIT NOT NULL,
  residence_postcode VARCHAR(255) NOT NULL,
  FOREIGN KEY (landlord_id) REFERENCES ACCOMMODATION.Landlord(landlord_id)
);

CREATE TABLE ACCOMMODATION.Residence_RoomType (
  residence_roomtype_id INT PRIMARY KEY NOT NULL,
  room_type_id INT NOT NULL,
  residence_id INT NOT NULL,
  fee INT NOT NULL,
  FOREIGN KEY (room_type_id) REFERENCES ACCOMMODATION.Room_Type(room_type_id),
  FOREIGN KEY (residence_id) REFERENCES ACCOMMODATION.Residence(residence_id)
);

CREATE TABLE ACCOMMODATION.Student_Residence_Option (
  residence_option_id INT PRIMARY KEY NOT NULL,
  student_id INT NOT NULL,
  contract_length_id INT NOT NULL,
  residence_roomtype_id INT NOT NULL,
  residence_priority INT NOT NULL,
  date_created DATETIME NOT NULL,
  FOREIGN KEY (student_id) REFERENCES ACCOMMODATION.Student(student_id),
  FOREIGN KEY (contract_length_id) REFERENCES ACCOMMODATION.ContractLength(contract_length_id),
  FOREIGN KEY (residence_roomtype_id) REFERENCES ACCOMMODATION.Residence_RoomType(residence_roomtype_id)
);

CREATE TABLE ACCOMMODATION.Room (
  room_id INT PRIMARY KEY NOT NULL,
  residence_roomtype_id INT NOT NULL,
  contract_length_id INT NOT NULL,
  room_number INT NOT NULL,
  FOREIGN KEY (residence_roomtype_id) REFERENCES ACCOMMODATION.Residence_RoomType(residence_roomtype_id),
  FOREIGN KEY (contract_length_id) REFERENCES ACCOMMODATION.ContractLength(contract_length_id)
);

CREATE TABLE ACCOMMODATION.Student_Contract (
  student_contract_id INT PRIMARY KEY NOT NULL,
  rental_agent_id INT NOT NULL,
  student_id INT NOT NULL,
  room_id INT NOT NULL,
  offer_paid_on DATETIME NOT NULL,
  arrival_date DATETIME NOT NULL,
  departure_date DATETIME NOT NULL,
  FOREIGN KEY (rental_agent_id) REFERENCES ACCOMMODATION.Rental_Agent(rental_agent_id),
  FOREIGN KEY (student_id) REFERENCES ACCOMMODATION.Student(student_id),
  FOREIGN KEY (room_id) REFERENCES ACCOMMODATION.Room(room_id)
);

-- Relationships

ALTER TABLE ACCOMMODATION.Student_Residence_Option
ADD CONSTRAINT FK_Student_Residence_Option_Student FOREIGN KEY (student_id) REFERENCES ACCOMMODATION.Student(student_id);

ALTER TABLE ACCOMMODATION.Student_Residence_Option
ADD CONSTRAINT FK_Student_Residence_Option_ContractLength FOREIGN KEY (contract_length_id) REFERENCES ACCOMMODATION.ContractLength(contract_length_id);

ALTER TABLE ACCOMMODATION.Student_Residence_Option
ADD CONSTRAINT FK_Student_Residence_Option_Residence_RoomType FOREIGN KEY (residence_roomtype_id) REFERENCES ACCOMMODATION.Residence_RoomType(residence_roomtype_id);

ALTER TABLE ACCOMMODATION.Room
ADD CONSTRAINT FK_Room_Residence_RoomType FOREIGN KEY (residence_roomtype_id) REFERENCES ACCOMMODATION.Residence_RoomType(residence_roomtype_id);

ALTER TABLE ACCOMMODATION.Room
ADD CONSTRAINT FK_Room_ContractLength FOREIGN KEY (contract_length_id) REFERENCES ACCOMMODATION.ContractLength(contract_length_id);

ALTER TABLE ACCOMMODATION.Student_Contract
ADD CONSTRAINT FK_Student_Contract_Rental_Agent FOREIGN KEY (rental_agent_id) REFERENCES ACCOMMODATION.Rental_Agent(rental_agent_id);

ALTER TABLE ACCOMMODATION.Student_Contract
ADD CONSTRAINT FK_Student_Contract_Student FOREIGN KEY (student_id) REFERENCES ACCOMMODATION.Student(student_id);

ALTER TABLE ACCOMMODATION.Student_Contract
ADD CONSTRAINT FK_Student_Contract_Room FOREIGN KEY (room_id) REFERENCES ACCOMMODATION.Room(room_id);

ALTER TABLE ACCOMMODATION.Landlord
ADD CONSTRAINT FK_Landlord_Landlord_Type FOREIGN KEY (landlord_type_id) REFERENCES ACCOMMODATION.Landlord_Type(landlord_type_id);

ALTER TABLE ACCOMMODATION.Residence
ADD CONSTRAINT FK_Residence_Landlord FOREIGN KEY (landlord_id) REFERENCES ACCOMMODATION.Landlord(landlord_id);

ALTER TABLE ACCOMMODATION.Residence_RoomType
ADD CONSTRAINT FK_Residence_RoomType_Room_Type FOREIGN KEY (room_type_id) REFERENCES ACCOMMODATION.Room_Type(room_type_id);

ALTER TABLE ACCOMMODATION.Residence_RoomType
ADD CONSTRAINT FK_Residence_RoomType_Residence FOREIGN KEY (residence_id) REFERENCES ACCOMMODATION.Residence(residence_id);
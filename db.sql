
-- -----------------------------------------------------
-- Schema HRM
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `HRM` ;

-- -----------------------------------------------------
-- Schema HRM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HRM` DEFAULT CHARACTER SET utf8 ;
USE `HRM` ;

-- -----------------------------------------------------
-- Table `HRM`.`departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`departments` ;

CREATE TABLE IF NOT EXISTS `HRM`.`departments` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
   PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`pay_grades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`pay_grades` ;

CREATE TABLE IF NOT EXISTS `HRM`.`pay_grades` (
  `pay_grade_id` INT NOT NULL AUTO_INCREMENT,
  `pay_grade` VARCHAR(45) NOT NULL,
   PRIMARY KEY (`pay_grade_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`employment_statuses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`employment_statuses` ;

CREATE TABLE IF NOT EXISTS `HRM`.`employment_statuses` (
  `employee_status_id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
   PRIMARY KEY (`employee_status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`job_titles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`job_titles` ;

CREATE TABLE IF NOT EXISTS `HRM`.`job_titles` (
  `job_title_id` INT NOT NULL AUTO_INCREMENT,
  `job_title` VARCHAR(45) NOT NULL,
   PRIMARY KEY (`job_title_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`employees` ;

CREATE TABLE IF NOT EXISTS `HRM`.`employees` (
  `employee_id` CHAR(5) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('male', 'female') NOT NULL CHECK (gender = 'male' OR gender = 'female'),
  `birthdate` DATE NOT NULL,
  `marital_status` TINYINT NOT NULL,
  `supervisor_id` CHAR(5) NOT NULL,
  `department_id` INT NOT NULL,
  `pay_grade_id` INT NOT NULL,
  `employee_status_id` INT NOT NULL,
  `job_title_id` INT NOT NULL,
  
   PRIMARY KEY (`employee_id`),
   
   FOREIGN KEY (`department_id`)
   REFERENCES `HRM`.`departments` (`department_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE,
   
   FOREIGN KEY (`pay_grade_id`)
   REFERENCES `HRM`.`pay_grades` (`pay_grade_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE,
   
   FOREIGN KEY (`employee_status_id`)
   REFERENCES `HRM`.`employment_statuses` (`employee_status_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE,

   FOREIGN KEY (`job_title_id`)
   REFERENCES `HRM`.`job_titles` (`job_title_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`leave_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`leave_types` ;

CREATE TABLE IF NOT EXISTS `HRM`.`leave_types` (
  `leave_type_id` INT NOT NULL AUTO_INCREMENT,
  `leave_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`leave_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`leave_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`leave_requests` ;

CREATE TABLE IF NOT EXISTS `HRM`.`leave_requests` (
  `request_id` CHAR(5) NOT NULL,
  `reason` TEXT NOT NULL,
  `leave_day_count` INT NOT NULL,
  `leave_start_date` DATE NOT NULL,
  `approved` TINYINT NOT NULL,
  `employee_id` CHAR(5) NOT NULL,
  `leave_type_id` INT NOT NULL,
	  `request_date` DATETIME,
  
   PRIMARY KEY (`request_id`),

   FOREIGN KEY (`employee_id`)
   REFERENCES `HRM`.`employees` (`employee_id`)
   ON DELETE CASCADE
   ON UPDATE CASCADE,

   FOREIGN KEY (`leave_type_id`)
   REFERENCES `HRM`.`leave_types` (`leave_type_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`remaining_leaving_days`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`remaining_leaving_days` ;

CREATE TABLE IF NOT EXISTS `HRM`.`remaining_leaving_days` (
  `leave_type_id` INT NOT NULL,
  `employee_id` CHAR(5) NOT NULL,
  `remaining_days` INT NOT NULL,
  
  PRIMARY KEY (`leave_type_id`, `employee_id`),

   FOREIGN KEY (`leave_type_id`)
   REFERENCES `HRM`.`leave_types` (`leave_type_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE,

   FOREIGN KEY (`employee_id`)
   REFERENCES `HRM`.`employees` (`employee_id`)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`user_account_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`user_account_roles` ;

CREATE TABLE IF NOT EXISTS `HRM`.`user_account_roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`user_accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`user_accounts` ;

CREATE TABLE IF NOT EXISTS `HRM`.`user_accounts` (
  `user_id` CHAR(5) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(75) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `employee_id` CHAR(5) NOT NULL,
  `role_id` INT NOT NULL,
  
  PRIMARY KEY (`user_id`),

   FOREIGN KEY (`employee_id`)
   REFERENCES `HRM`.`employees` (`employee_id`)
   ON DELETE CASCADE
   ON UPDATE CASCADE,

   FOREIGN KEY (`role_id`)
   REFERENCES `HRM`.`user_account_roles` (`role_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE)
ENGINE = InnoDB;

ALTER TABLE `hrm`.`user_accounts` 
ADD UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE;
;


-- -----------------------------------------------------
-- Table `HRM`.`num_of_leaving_days`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`num_of_leaving_days` ;

CREATE TABLE IF NOT EXISTS `HRM`.`num_of_leaving_days` (
  `pay_grade_id` INT NOT NULL,
  `leave_type_id` INT NOT NULL,
  `total_days` INT NOT NULL,
  
  PRIMARY KEY (`pay_grade_id`, `leave_type_id`),

   FOREIGN KEY (`pay_grade_id`)
   REFERENCES `HRM`.`pay_grades` (`pay_grade_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE,

   FOREIGN KEY (`leave_type_id`)
   REFERENCES `HRM`.`leave_types` (`leave_type_id`)
   ON DELETE NO ACTION
   ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`emergency_contact_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`emergency_contact_details` ;

CREATE TABLE IF NOT EXISTS `HRM`.`emergency_contact_details` (
  `emergency_contact_id` CHAR(5) NOT NULL ,
  `contact_name` VARCHAR(45) NOT NULL,
  `relationship` VARCHAR(45) NOT NULL,
  `contact_number` VARCHAR(45) NOT NULL,
  `employee_id` CHAR(5) NOT NULL,
  
  PRIMARY KEY (`emergency_contact_id`),
  
   FOREIGN KEY (`employee_id`)
   REFERENCES `HRM`.`employees` (`employee_id`)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HRM`.`dependents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HRM`.`dependents` ;

CREATE TABLE IF NOT EXISTS `HRM`.`dependents` (
  `dependent_id` CHAR(5) NOT NULL,
  `employee_id` CHAR(5) NOT NULL,
  `dependent_name` VARCHAR(45) NOT NULL,
  `relationship` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  
   PRIMARY KEY (`dependent_id`),
   
   FOREIGN KEY (`employee_id`)
   REFERENCES `HRM`.`employees` (`employee_id`)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


-- ----------------------------------------------------
-- triggers
-- ----------------------------------------------------

-- trigger for auto incrementing employee_id

DROP TRIGGER IF EXISTS employee_id_trigger;
DELIMITER //
CREATE TRIGGER employee_id_trigger 
BEFORE INSERT
ON hrm.employees
FOR EACH ROW 
BEGIN
	DECLARE max_val INT;
    SET max_val=(SELECT MAX(CAST(substring(employee_id,2) AS SIGNED))
				 FROM employees);
	IF max_val IS NULL THEN 
		SET max_val=0;
	END iF;
    
    SET NEW.employee_id=CONCAT('A',LPAD(max_val+1,4,'0'));
END;
//
DELIMITER ;


-- trigger for auto inserting the number of leaving days when a new employee entry is is inserted
DROP TRIGGER IF EXISTS employees_after_insert ;
DELIMITER //

CREATE TRIGGER  employees_after_insert
	AFTER INSERT ON HRM.employees
	FOR EACH ROW
BEGIN
    DECLARE paygrade_id INT;

    SET paygrade_id = NEW.pay_grade_id;

    INSERT INTO HRM.remaining_leaving_days (employee_id, leave_type_id, remaining_days)
    SELECT NEW.employee_id, leave_type_id, 
        CASE
            WHEN leave_type_id = 1 THEN 
                (SELECT total_days FROM num_of_leaving_days WHERE leave_type_id = 1 AND pay_grade_id = NEW.pay_grade_id LIMIT 1)
            WHEN leave_type_id = 2 THEN 
                (SELECT total_days FROM num_of_leaving_days WHERE leave_type_id = 2 AND pay_grade_id = NEW.pay_grade_id LIMIT 1)
            WHEN leave_type_id = 3 AND NEW.gender = 'female' THEN 
                (SELECT total_days FROM num_of_leaving_days WHERE leave_type_id = 3 AND pay_grade_id = NEW.pay_grade_id LIMIT 1)
            WHEN leave_type_id = 4 THEN 
                (SELECT total_days FROM num_of_leaving_days WHERE leave_type_id = 4 AND pay_grade_id = NEW.pay_grade_id LIMIT 1)
            ELSE 0  -- Handle other leave_type_id values
        END
    FROM HRM.leave_types;
END;
//
DELIMITER ;




-- Create a new trigger to update remaining_leaving_days
DROP TRIGGER IF EXISTS update_remaining_leaving_days;
DELIMITER //

CREATE TRIGGER update_remaining_leaving_days
AFTER INSERT ON HRM.leave_requests
FOR EACH ROW
BEGIN
    DECLARE current_remaining_days INT;
    
    -- Check if the leave request was approved (approved = 1)
    IF NEW.approved = 1 THEN
        -- Retrieve the remaining days for the specific leave_type_id and employee_id
        SELECT remaining_days
        INTO current_remaining_days
        FROM HRM.remaining_leaving_days
        WHERE leave_type_id = NEW.leave_type_id
        AND employee_id = NEW.employee_id;
        
        -- Check if there are enough remaining days for the leave request
        IF current_remaining_days >= NEW.leave_day_count THEN
            -- Update the remaining days in the remaining_leaving_days table
            UPDATE HRM.remaining_leaving_days
            SET remaining_days = remaining_days - NEW.leave_day_count
            WHERE leave_type_id = NEW.leave_type_id
            AND employee_id = NEW.employee_id;
        ELSE
            -- Handle the case where there are not enough remaining days
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient remaining leave days for this request.';
        END IF;
    END IF;
END;
//
DELIMITER ;

-- trigger for auto incrementing leave request_id

DROP TRIGGER IF EXISTS request_id_trigger;
DELIMITER //
CREATE TRIGGER request_id_trigger 
BEFORE INSERT
ON hrm.leave_requests
FOR EACH ROW 
BEGIN
	DECLARE max_val INT;
    SET max_val=(SELECT MAX(CAST(substring(request_id,2) AS SIGNED))
				 FROM leave_requests);
	IF max_val IS NULL THEN 
		SET max_val=0;
	END iF;
    
    SET NEW.request_id=CONCAT('L',LPAD(max_val+1,4,'0'));
END;
//
DELIMITER ;


-- trigger for auto incrementing dependent_id

DROP TRIGGER IF EXISTS dependent_id_trigger;
DELIMITER //
CREATE TRIGGER dependent_id_trigger 
BEFORE INSERT
ON hrm.dependents
FOR EACH ROW 
BEGIN
	DECLARE max_val INT;
    SET max_val=(SELECT MAX(CAST(substring(dependent_id,2) AS SIGNED))
				 FROM dependents);
	IF max_val IS NULL THEN 
		SET max_val=0;
	END iF;
    
    SET NEW.dependent_id=CONCAT('D',LPAD(max_val+1,4,'0'));
END;
//
DELIMITER ;

-- trigger for auto incrementing user_id

DROP TRIGGER IF EXISTS user_id_trigger;
DELIMITER //
CREATE TRIGGER user_id_trigger 
BEFORE INSERT
ON hrm.user_accounts
FOR EACH ROW 
BEGIN
	DECLARE max_val INT;
    SET max_val=(SELECT MAX(CAST(substring(user_id,2) AS SIGNED))
				 FROM user_accounts);
	IF max_val IS NULL THEN 
		SET max_val=0;
	END iF;
    
    SET NEW.user_id=CONCAT('U',LPAD(max_val+1,4,'0'));
END;
//
DELIMITER ;

-- trigger for auto incrementing emergency_contact_id 

DROP TRIGGER IF EXISTS emergency_contact_id_trigger;
DELIMITER //
CREATE TRIGGER emergency_contact_id_trigger 
BEFORE INSERT
ON hrm.emergency_contact_details
FOR EACH ROW 
BEGIN
    DECLARE max_val INT;
    SET max_val=(SELECT MAX(CAST(substring(emergency_contact_id,2) AS SIGNED))
				 FROM emergency_contact_details);
	IF max_val IS NULL THEN 
		SET max_val=0;
	END iF;
    
    SET NEW.emergency_contact_id=CONCAT('E',LPAD(max_val+1,4,'0'));
END;
//
DELIMITER ;





use hrm;
-- departments
INSERT INTO `departments` (`name`) VALUES ('Human Resource');
INSERT INTO `departments` (`name`) VALUES ('Finance and Accounting');
INSERT INTO `departments` (`name`) VALUES ('Operations');

-- job titles
INSERT INTO `job_titles` (`job_title`) VALUES ('HR Manager');
INSERT INTO `job_titles` (`job_title`) VALUES ('Accountant');
INSERT INTO `job_titles` (`job_title`) VALUES ('Software Engineer');
INSERT INTO `job_titles` (`job_title`) VALUES ('QA Engineer');

-- employement statuses
INSERT INTO `employment_statuses` (`employee_status_id`, `status`) VALUES (1, 'Intern - full time');
INSERT INTO `employment_statuses` (`employee_status_id`, `status`) VALUES (2, 'Intern - part time');
INSERT INTO `employment_statuses` (`employee_status_id`, `status`) VALUES (3, 'Contract - full time');
INSERT INTO `employment_statuses` (`employee_status_id`, `status`) VALUES (4, 'Contract - part time');
INSERT INTO `employment_statuses` (`employee_status_id`, `status`) VALUES (5, 'Permanent');
INSERT INTO `employment_statuses` (`employee_status_id`, `status`) VALUES (6, 'Freelance');

-- leave types
INSERT INTO `HRM`.`leave_types` (`leave_type`) VALUES ('Annual');
INSERT INTO `HRM`.`leave_types` (`leave_type`) VALUES ('Casual');
INSERT INTO `HRM`.`leave_types` (`leave_type`) VALUES ('Maternity');
INSERT INTO `HRM`.`leave_types` (`leave_type`) VALUES ('No-pay');

-- pay grades
INSERT INTO `HRM`.`pay_grades` (`pay_grade`) VALUES ('Level 1');
INSERT INTO `HRM`.`pay_grades` (`pay_grade`) VALUES ('Level 2');
INSERT INTO `HRM`.`pay_grades` (`pay_grade`) VALUES ('Level 3');
INSERT INTO `HRM`.`pay_grades` (`pay_grade`) VALUES ('Level 4');

-- user account roles
INSERT INTO `HRM`.`user_account_roles` (`role`) VALUES ('Admin');
INSERT INTO `HRM`.`user_account_roles` (`role`) VALUES ('HR');
INSERT INTO `HRM`.`user_account_roles` (`role`) VALUES ('Employee');

-- num_of_leaving_days
INSERT INTO `HRM`.`num_of_leaving_days` (`pay_grade_id`, `leave_type_id`, `total_days`)
VALUES 
(1, 1, 20),
(1, 2, 20),
(1, 3, 120),
(1, 4, 50),
(2, 1, 20),
(2, 2, 20),
(2, 3, 120),
(2, 4, 50),
(3, 1, 20),
(3, 2, 20),
(3, 3, 120),
(3, 4, 50),
(4, 1, 20),
(4, 2, 20),
(4, 3, 120),
(4, 4, 50);


-- employees
INSERT INTO `employees` (`first_name`, `last_name`, `gender`, `birthdate`,`marital_status`, `supervisor_id`, `department_id`, `pay_grade_id`, `employee_status_id`, `job_title_id`)
VALUES
('Chamari', 'Fernando', 'female', '1989-05-07', 1, 'A0002', 1, 3, 4, 2),
('Dinuka', 'Perera', 'male', '1990-11-15', 0, 'A0001', 1, 4, 5, 1),
('Isuri', 'Silva', 'female', '1986-04-20', 1, 'A0002', 2, 2, 2, 2),
('Janith', 'Karunaratne', 'male', '1992-03-03', 0, 'A0002', 3, 2, 5, 2),
('Nethmi', 'Ratnayake', 'female', '1993-08-18', 1, 'A0002', 1, 2, 1, 3),
('Pasan', 'Jayawardena', 'male', '1987-12-29', 0, 'A0003', 2, 1, 5, 3),
('Dimalsha', 'Wijeratne', 'female', '1988-07-09', 1, 'A0003', 3, 3, 2, 2),
('Sahan', 'Bandara', 'male', '1985-01-26', 0, 'A0002', 1, 3, 4, 3),
('Sanduni', 'Perera', 'female', '1989-10-03', 1, 'A0004', 2, 1, 3, 4),
('Lahiru', 'Dissanayake', 'male', '1986-06-17', 0, 'A0003', 3, 2, 6, 3),
('Chathuri', 'Gunasekara', 'female', '1990-03-22', 1, 'A0002', 1, 3, 1, 2),
('Nisal', 'Samarasekera', 'male', '1991-09-11', 0, 'A0003', 2, 3, 2, 3),
('Shanika', 'Mendis', 'female', '1992-04-07', 1, 'A0004', 3, 1, 5, 4),
('Sankalpa', 'Wickramasinghe', 'male', '1988-08-16', 0, 'A0004', 1, 2, 6, 4),
('Thisari', 'Jayasundara', 'female', '1987-11-24', 1, 'A0003', 2, 3, 3, 2),
('Ashen', 'Senanayake', 'male', '1993-02-12', 0, 'A0004', 3, 3, 4, 3),
('Kavindya', 'Alwis', 'female', '1986-10-28', 1, 'A0003', 1, 1, 2, 4),
('Milinda', 'Rajapaksa', 'male', '1985-05-05', 0, 'A0003', 2, 2, 1, 2),
('Ruvini', 'Peris', 'female', '1989-09-09', 1, 'A0004', 3, 3, 5, 2),
('Buddhika', 'Kodikara', 'male', '1990-07-15', 0, 'A0003', 1, 3, 6, 3),
('Dinuka', 'Perera', 'male', '1980-11-15', 0, 'A0003', 3, 1, 4, 4);

-- user accounts
INSERT INTO `HRM`.`user_accounts` (`username`, `password`, `user_email`, `employee_id`, `role_id`)
VALUES 
('ChamariFernando', '$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'chamari.fernando@gmail.com', 'A0001', 1),
('DinukaPerera', '$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'dinuka.perera@gmail.com', 'A0002', 2),
('IsuriSilva', '$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'isuri.silva@gmail.com', 'A0003', 3),
('JanithKarunaratne', '$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'janith.karunaratne@gmail.com', 'A0004', 3),
('NethmiRatnayake', '$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'nethmi.ratnayake@gmail.com', 'A0005', 3),
('PasanJayawardena', '$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'pasan.jayawardena@gmail.com', 'A0006', 3),
('DimalshaWijeratne','$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'dimalsha.wijeratne@gmail.com', 'A0007', 3),
('SahanBandara', '$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'sahan.bandara@gmail.com', 'A0008', 3),
('SanduniPerera', '$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'sanduni.perera@gmail.com', 'A0009', 3),
('LahiruDissanayake','$2a$12$1vtCLCvEqLBU4qd7QadcLOMoYnTz7A2pNncXYp.Hr/Puq3YVe/IsK', 'lahiru.dissanayake@gmail.com', 'A0010', 3);

-- emergency contact details
INSERT INTO `HRM`.`emergency_contact_details` (`contact_name`, `relationship`, `contact_number`, `employee_id`)
VALUES 
('Ranil Fernando', 'Father', '+94 701234561', 'A0001'),
('Dilani Perera', 'Sister', '+94 701234562', 'A0002'),
('Lakmal Silva', 'Brother', '+94 701234563', 'A0003'),
('Manjula Karunaratne', 'Uncle', '+94 701234564', 'A0004'),
('Priyani Ratnayake', 'Mother', '+94 701234565', 'A0005'),
('Saman Jayawardena', 'Father', '+94 701234566', 'A0006'),
('Kusum Wijeratne', 'Aunty', '+94 701234567', 'A0007'),
('Dulani Bandara', 'Sister', '+94 701234568', 'A0008'),
('Lasith Perera', 'Cousin', '+94 701234569', 'A0009'),
('Nalaka Dissanayake', 'Brother', '+94 701234570', 'A0010'),
('Rukmal Gunasekara', 'Husband', '+94 701234571', 'A0011'),
('Kaveen Samarasekera', 'Son', '+94 701234572', 'A0012'),
('Niroshi Mendis', 'Wife', '+94 701234573', 'A0013'),
('Chinthaka Wickramasinghe', 'Father-in-law', '+94 701234574', 'A0014'),
('Anusha Jayasundara', 'Mother', '+94 701234575', 'A0015'),
('Dhananjaya Senanayake', 'Brother', '+94 701234576', 'A0016'),
('Chamila Alwis', 'Sister', '+94 701234577', 'A0017'),
('Dilum Rajapaksa', 'Cousin', '+94 701234578', 'A0018'),
('Kumudini Peris', 'Aunty', '+94 701234579', 'A0019'),
('Charith Kodikara', 'Uncle', '+94 701234580', 'A0020'),
('Gamage Peris', 'Father', '+94 701274080', 'A0021'); --------------------------------------

-- leave requests
INSERT INTO `HRM`.`leave_requests` 
(`reason`, `leave_day_count`, `leave_start_date`, `approved`, `employee_id`, `leave_type_id`) 
VALUES 
('Family event', 3, '2023-01-01', 1, 'A0001', 1),
('Medical leave', 2, '2023-01-05', 0, 'A0002', 2),
('Vacation', 5, '2023-01-10', 1, 'A0003', 2),
('Family event', 1, '2023-01-25', 0, 'A0005', 1),
('Medical leave', 4, '2023-01-30', 1, 'A0006', 2),
('Vacation', 7, '2023-02-05', 0, 'A0007', 2),
('Medical leave', 3, '2023-02-10', 1, 'A0008', 2),
('Family event', 2, '2023-02-15', 0, 'A0009', 1),
('Maternity leave', 70, '2023-01-20', 1, 'A0019', 3);


-- dependents
INSERT INTO `HRM`.`dependents` (`employee_id`, `dependent_name`, `relationship`, `age`) VALUES
('A0001', 'Roshan', 'Husband', 34),
('A0002', 'Tharushi', 'Wife', 32),
('A0003', 'Charith', 'Husband', 37),
('A0004', 'Anushi', 'Wife', 30),
('A0005', 'Nimal', 'Husband', 33),
('A0006', 'Thamara', 'Wife', 35),
('A0007', 'Ravi', 'Husband', 36),
('A0008', 'Kasuni', 'Wife', 37),
('A0009', 'Janaka', 'Husband', 34),
('A0010', 'Dilini', 'Wife', 35),
('A0011', 'Anura', 'Husband', 35),
('A0012', 'Chamila', 'Wife', 32),
('A0013', 'Dushyantha', 'Husband', 33),
('A0014', 'Nelum', 'Wife', 33),
('A0015', 'Priyantha', 'Husband', 35),
('A0016', 'Dulani', 'Wife', 31),
('A0017', 'Thilina', 'Husband', 38),
('A0018', 'Nilmini', 'Wife', 36),
('A0019', 'Lahiru', 'Husband', 34),
('A0020', 'Heshani', 'Wife', 33),
('A0021', 'Rukshani', 'Wife', 41);






-- add indexes

CREATE INDEX idx_name ON hrm.departments (name);

CREATE INDEX idx_leave_type ON hrm.leave_types (leave_type);


USE `hrm`;
DROP function IF EXISTS `hrm`.`get_total_leaving_count`;
;

DELIMITER $$
USE `hrm`$$
CREATE FUNCTION `get_total_leaving_count`( dept_id int) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE total_leaving_count int;
    SELECT count(*) into total_leaving_count FROM  all_accept_leavings a JOIN employees e ON e.employee_id = a.employee_id left join departments d on e.department_id = d.department_id where d.department_id = dept_id; 


RETURN total_leaving_count;
END$$

DELIMITER ;



DELIMITER //
CREATE FUNCTION Check_enough_remaianing_leaves(requested_no_of_leaves INT, employee_id CHAR(5), leave_type_id INT )
RETURNS integer
DETERMINISTIC
READS SQL DATA
BEGIN
 DECLARE available_days integer;
 SELECT remaining_days INTO available_days FROM remaining_leaving_days r WHERE r.leave_type_id=leave_type_id AND r.employee_id=employee_id;
 IF requested_no_of_leaves > available_days THEN 
	RETURN 0;
 ELSE
	RETURN 1;
 END IF;
END //
DELIMITER ;


USE `hrm`;
DROP function IF EXISTS `GetLastEmployeeID`;

USE `hrm`;
DROP function IF EXISTS `hrm`.`GetLastEmployeeID`;
;

DELIMITER $$
USE `hrm`$$
CREATE FUNCTION `GetLastEmployeeID`() RETURNS char(5) CHARSET utf8mb3
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE lastEmployeeID char(5);
    SELECT employee_id INTO lastEmployeeID FROM employees ORDER BY employee_id DESC LIMIT 1;
    RETURN lastEmployeeID;
END$$

DELIMITER ;
;


-- add views  

USE `hrm`;

-- view 1

CREATE  OR REPLACE VIEW `hrm`.`all_accept_leavings` AS
    SELECT 
        `hrm`.`leave_requests`.`request_id` AS `request_id`,
        `hrm`.`leave_requests`.`reason` AS `reason`,
        `hrm`.`leave_requests`.`leave_day_count` AS `leave_day_count`,
        `hrm`.`leave_requests`.`leave_start_date` AS `leave_start_date`,
        `hrm`.`leave_requests`.`approved` AS `approved`,
        `hrm`.`leave_requests`.`employee_id` AS `employee_id`,
        `hrm`.`leave_requests`.`leave_type_id` AS `leave_type_id`
    FROM
        `hrm`.`leave_requests`
    WHERE
        (`hrm`.`leave_requests`.`approved` = 1);

-- view 2


CREATE 
 OR REPLACE VIEW `hrm`.`emp_supervisor` AS
    SELECT 
        `e`.`employee_id` AS `employee_id`,
        `e`.`first_name` AS `emp_name`,
        `e`.`supervisor_id` AS `supervisor_id`,
        `s`.`first_name` AS `sup_name`
    FROM
        (`hrm`.`employees` `e`
        LEFT JOIN `hrm`.`employees` `s` ON ((`e`.`supervisor_id` = `s`.`employee_id`)));

-- view 3

CREATE  OR REPLACE VIEW `hrm`.`employee_without_custom_attributes` AS
    SELECT 
        `hrm`.`employees`.`employee_id` AS `employee_id`,
        `hrm`.`employees`.`first_name` AS `first_name`,
        `hrm`.`employees`.`last_name` AS `last_name`,
        `hrm`.`employees`.`gender` AS `gender`,
        `hrm`.`employees`.`birthdate` AS `birthdate`,
        `hrm`.`employees`.`marital_status` AS `marital_status`,
        `hrm`.`employees`.`supervisor_id` AS `supervisor_id`,
        `hrm`.`employees`.`department_id` AS `department_id`,
        `hrm`.`employees`.`pay_grade_id` AS `pay_grade_id`,
		`hrm`.`employees`.`employee_status_id` AS `employee_status_id`,
		`hrm`.`employees`.`job_title_id` AS `job_title_id`

    FROM
        `hrm`.`employees`;


-- view 4


CREATE  OR REPLACE VIEW hrm.profile_view AS
    SELECT 
        hrm.employees.employee_id AS employee_id,
        hrm.employees.first_name AS first_name,
        hrm.employees.last_name AS last_name
    FROM
        hrm.employees;

-- view 5
CREATE  OR REPLACE VIEW  `hrm`.`employee_paygrade` AS
    SELECT 
        `hrm`.`employees`.`employee_id` AS `employee_id`,
        `hrm`.`employees`.`pay_grade_id` AS `pay_grade_id`
    FROM
        `hrm`.`employees`;
        
-- stored Procedures-----------------------------------------------------

USE `hrm`;
DROP procedure IF EXISTS `UpdateEmployeeAndRelatedData`;

USE `hrm`;
DROP procedure IF EXISTS `hrm`.`UpdateEmployeeAndRelatedData`;
;

DELIMITER $$
USE `hrm`$$
CREATE  PROCEDURE `UpdateEmployeeAndRelatedData`(
  IN employee_id CHAR(5),
  IN first_name VARCHAR(45),
  IN last_name VARCHAR(45),
  IN gender ENUM('male', 'female'),
  IN birthdate DATE,
  IN marital_status TINYINT,
  IN supervisor_id CHAR(5),
  IN department_id INT,
  IN pay_grade_id INT,
  IN employee_status_id INT,
  IN job_title_id INT,
  IN contact_name VARCHAR(45),
  IN relationship VARCHAR(45),
  IN contact_number VARCHAR(45),
  IN username VARCHAR(45),
  IN password VARCHAR(75),
  IN user_email VARCHAR(45),
  IN role_id INT,
  IN dependent_name  VARCHAR(45),
  IN dep_relationship  VARCHAR(45),
  IN age INT
)
BEGIN
  START TRANSACTION;
  
-- Update the employees table
UPDATE `employees` e
SET
  `first_name` = first_name,
  `last_name` = last_name,
  `gender` = gender,
  `birthdate` = birthdate,
  `marital_status` = marital_status,
  `supervisor_id` = supervisor_id,
  `department_id` = department_id,
  `pay_grade_id` = pay_grade_id,
  `employee_status_id` = employee_status_id,
  `job_title_id` = job_title_id
WHERE e.employee_id = employee_id;


-- Update the emergency_contact_details table
UPDATE `HRM`.`emergency_contact_details` ec
SET
  `contact_name` = contact_name,
  `relationship` = relationship,
  `contact_number` = contact_number
WHERE ec.employee_id = employee_id;

-- Update the user_accounts table
UPDATE `HRM`.`user_accounts` ua
SET
  `username` = username,
  `password` = password,
  `user_email` = user_email,
  `role_id` = role_id
WHERE ua.employee_id = employee_id;

UPDATE `HRM`.`dependents` ua
SET
  `dependent_name` = dependent_name,
  `relationship` =  dep_relationship,
  `age` = age
  
WHERE ua.employee_id = employee_id;
	
  COMMIT;
  ROLLBACK; 
  
END$$

DELIMITER ;
;



USE `hrm`;
DROP procedure IF EXISTS `InsertEmployeeAndRelatedData`;

USE `hrm`;
DROP procedure IF EXISTS `hrm`.`InsertEmployeeAndRelatedData`;
;
DELIMITER $$
USE `hrm`$$
CREATE  PROCEDURE `InsertEmployeeAndRelatedData`(
  IN first_name VARCHAR(45),
  IN last_name VARCHAR(45),
  IN gender ENUM('male', 'female'),
  IN birthdate DATE,
  IN marital_status TINYINT,
  IN supervisor_id CHAR(5),
  IN department_id INT,
  IN pay_grade_id INT,
  IN employee_status_id INT,
  IN job_title_id INT,
  IN contact_name VARCHAR(45) ,
  IN relationship VARCHAR(45) ,
  IN contact_number VARCHAR(45) ,
  IN username VARCHAR(45) ,
  IN password VARCHAR(75),
  IN user_email VARCHAR(45),
  IN role_id INT,
  IN dependent_name VARCHAR(45),
  IN dep_relationship VARCHAR(45),
  IN dep_age INT
)
BEGIN
  DECLARE last_employee_id CHAR(5);

  START TRANSACTION;

  INSERT INTO `employees` (
    `first_name`, `last_name`, `gender`, `birthdate`,
    `marital_status`, `supervisor_id`, `department_id`,
    `pay_grade_id`, `employee_status_id`, `job_title_id`
  )
  VALUES (first_name, last_name, gender, birthdate, marital_status, supervisor_id, department_id, pay_grade_id, employee_status_id, job_title_id);

  -- Get the last inserted employee_id
SELECT  GetLastEmployeeID() INTO last_employee_id;

  INSERT INTO `HRM`.`emergency_contact_details` (
    `contact_name`, `relationship`, `contact_number`, `employee_id`
  )
  VALUES (contact_name, relationship, contact_number, last_employee_id);

  INSERT INTO `HRM`.`user_accounts` (
    `username`, `password`, `user_email`, `employee_id`, `role_id`
  )
  VALUES (username, password, user_email, last_employee_id, role_id);
  
  INSERT INTO `HRM`.`dependents` (
    `employee_id`, `dependent_name`, `relationship`, `age`
  )
  VALUES (last_employee_id, dependent_name, dep_relationship, dep_age);

  COMMIT;
ROLLBACK; 
END$$

DELIMITER ;
;

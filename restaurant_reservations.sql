CREATE DATABASE restaurant_reservations;

USE restaurant_reservations; 

CREATE TABLE Customers (
    customerId INT NOT NULL AUTO_INCREMENT,
    customerName VARCHAR(45) NOT NULL,
    contactInfo VARCHAR(200),
    PRIMARY KEY (customerId)
);

CREATE TABLE Reservations (
    reservationId INT NOT NULL AUTO_INCREMENT,
    customerId INT NOT NULL,
    reservationTime DATETIME NOT NULL,
    numberOfGuests INT NOT NULL,
    specialRequests VARCHAR(200),
    PRIMARY KEY (reservationId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
    );
    
    CREATE TABLE DiningPreferences (
    preferenceId INT NOT NULL AUTO_INCREMENT,
    customerId INT NOT NULL,
    favoriteTable VARCHAR(45),
    dietaryRestrictions VARCHAR(200),
    PRIMARY KEY (preferenceId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
    );
    
  DELIMITER //
CREATE PROCEDURE findReservations(IN customerIdParam INT)
BEGIN
    SELECT * FROM Reservations WHERE customerId = customerIdParam;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE addSpecialRequest(IN reservationIdParam INT, IN requests VARCHAR(200))
BEGIN
    UPDATE Reservations SET specialRequests = requests WHERE reservationId = reservationIdParam;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE addReservation(IN customerNameParam VARCHAR(45), IN reservationTimeParam DATETIME, IN numberOfGuestsParam INT, IN specialRequestsParam VARCHAR(200))
BEGIN
    DECLARE customerIdVal INT;
 SELECT customerId INTO customerIdVal FROM Customers WHERE customerName = customerNameParam;
    IF customerIdVal IS NULL THEN
        INSERT INTO Customers (customerName) VALUES (customerNameParam);
        SET customerIdVal = LAST_INSERT_ID();
    END IF;
    INSERT INTO Reservations (customerId, reservationTime, numberOfGuests, specialRequests) VALUES (customerIdVal, reservationTimeParam, numberOfGuestsParam, specialRequestsParam);
END //
DELIMITER ;


INSERT INTO Customers (customerName, contactInfo) VALUES
('Johnny Smith', 'johnny@johnny.com'),
('Alex Sith', 'alex@alex.com'),
('Bobbyy Jaysonson', 'bobbby@bobbyy.com');


INSERT INTO Reservations (customerId, reservationTime, numberOfGuests, specialRequests)
VALUES
    (1, '2024-05-1 11:00:00', 4, 'Window seat'),
    (2, '2024-05-2 12:30:00', 2, 'No kids'),
    (3, '2024-05-3 1:00:00', 6, 'Vegan Only');


INSERT INTO DiningPreferences (customerId, favoriteTable, dietaryRestrictions) VALUES
(1, 'Table 2', 'Caranvor Diet '),
(2, 'Table 3', 'Gluten Free'),
(3, 'Table 4', 'Vegan');
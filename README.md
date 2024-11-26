# Trip_Helper
Trip Helper
CREATE TABLE Trip (
    user_id INT PRIMARY KEY NOT NULL,
    starting_position VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    car_mileage FLOAT NOT NULL,
    number_of_passengers INT NOT NULL
);

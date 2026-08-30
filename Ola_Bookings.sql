create database data_analyst_projects;

use data_analyst_projects;

CREATE TABLE bookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(20) PRIMARY KEY,
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INT,
    C_TAT INT,
    Canceled_Rides_by_Customer VARCHAR(100),
    Canceled_Rides_by_Driver VARCHAR(100),
    Incomplete_Rides VARCHAR(100),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value DECIMAL(10,2),
    Payment_Method VARCHAR(50),
    Ride_Distance DECIMAL(10,2),
    Driver_Ratings DECIMAL(3,2),
    Customer_Rating DECIMAL(3,2)
);

SELECT * FROM BOOKINGS;

-- 1. Retrieve all successful bookings:

CREATE VIEW Successful_bookings as
select * from bookings
WHERE Booking_Status = "Success";

-- 2. Find the average ride distance for each vehicle type: 

CREATE VIEW avg_ride_distance_by_vehicle AS
SELECT 
    vehicle_type,
    AVG(ride_distance) AS avg_ride_distance
FROM bookings
GROUP BY vehicle_type;


-- 3. Get the total number of cancelled rides by customers:

CREATE VIEW cancelled_rides_by_customers as
SELECT COUNT(*) FROM bookings
WHERE Booking_Status = "Canceled by Customer" ;


-- 4. List the top 5 customers who booked the highest number of rides:

CREATE VIEW Top_5_Customers as
SELECT Customer_ID,
	   count(Booking_ID) 
FROM bookings
GROUP BY Customer_ID
ORDER BY 2 DESC 
LIMIT 5;


-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:

CREATE VIEW Canceled_rides_P_C_by_driver AS
select Count(*) as Total_Canceled_rides_P_C_by_driver
from bookings
WHERE Canceled_Rides_by_Driver = "Personal & Car related issue";


-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

CREATE VIEW Max_Min_Driver_Ratings AS
SELECT MAX(Driver_Ratings) as Maximun_Driver_Rating,
	   MIN(Driver_Ratings) as Minimun_Driver_Rating
FROM bookings
WHERE Vehicle_Type = "Prime Sedan";


-- 7. Retrieve all rides where payment was made using UPI:

CREATE VIEW UPI_Payment AS
SELECT * FROM bookings
WHERE Payment_Method = "UPI";


-- 8. Find the average customer rating per vehicle type:

CREATE VIEW Avg_Customer_Rating AS
SELECT Vehicle_Type,
	   AVG(Customer_Rating) as Avg_Customer_Rating
FROM bookings
GROUP BY  Vehicle_Type ;


-- 9. Calculate the total booking value of rides completed successfully:

CREATE VIEW Total_Rides_Value AS
SELECT SUM(Booking_Value) AS Total_Booking_Value 
FROM bookings
WHERE Booking_Status = "Success";


-- 10. List all incomplete rides along with the reason:

CREATE VIEW Incomplete_Rides_Reason AS
SELECT Booking_ID, Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = "Yes";


-- DATA ANALYSIS QUESTIONS

-- 1. Retrieve all successful bookings:
SELECT * FROM Successful_bookings;

-- 2. Find the average ride distance for each vehicle type:
SELECT * FROM avg_ride_distance_by_vehicle ;

-- 3. Get the total number of cancelled rides by customers:
SELECT * FROM cancelled_rides_by_customers;

-- 4. List the top 5 customers who booked the highest number of rides:
SELECT * FROM Top_5_Customers;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT * FROM Canceled_rides_P_C_by_driver;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT * FROM Max_Min_Driver_Ratings;

-- 7. Retrieve all rides where payment was made using UPI:
SELECT * FROM UPI_Payment;

-- 8. Find the average customer rating per vehicle type:
SELECT * FROM Avg_Customer_Rating;

-- 9. Calculate the total booking value of rides completed successfully:
SELECT * FROM Total_Rides_Value;

-- 10. List all incomplete rides along with the reason:
SELECT * FROM Incomplete_Rides_Reason;


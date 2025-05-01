create database Electricity_Consumption;
use Electricity_Consumption;

# Stores consumer details.
CREATE TABLE Consumers (
    ConsumerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10)
);

# MeterReadings Table
#Records daily electricity usage per consumer.
CREATE TABLE MeterReadings (
    ReadingID INT PRIMARY KEY AUTO_INCREMENT,
    ConsumerID INT,
    ReadingDate DATE,
    UsageKWh DECIMAL(10,2),
    PeakHoursUsageKWh DECIMAL(10,2),
    FOREIGN KEY (ConsumerID) REFERENCES Consumers(ConsumerID)
);
# Data Insertion
# Sample records are inserted into both tables.

INSERT INTO Consumers (Name, Address, City, State, ZipCode) VALUES
('John Doe', '123 Elm St', 'Los Angeles', 'CA', '90001'),
('Jane Smith', '456 Maple Ave', 'San Francisco', 'CA', '94102'),
('Alice Johnson', '789 Pine Rd', 'New York', 'NY', '10001');

INSERT INTO MeterReadings (ConsumerID, ReadingDate, UsageKWh, PeakHoursUsageKWh) VALUES
(1, '2025-01-01', 35.5, 12.0),
(1, '2025-01-02', 32.8, 10.5),
(2, '2025-01-01', 28.4, 9.8),
(2, '2025-01-02', 30.2, 11.2),
(3, '2025-01-01', 40.1, 15.3),
(3, '2025-01-02', 38.7, 14.0);

# Data Analysis with SQL Queries

# q1.  Total energy consumption per consumer

SELECT ConsumerID, SUM(UsageKWh) AS TotalUsage 
FROM MeterReadings 
GROUP BY ConsumerID;

# q2.  Average daily consumption
SELECT AVG(UsageKWh) AS AvgDailyUsage FROM MeterReadings;

# q3. Peak vs. Off-Peak Usage
SELECT ConsumerID, SUM(PeakHoursUsageKWh) AS PeakUsage, 
       SUM(UsageKWh) - SUM(PeakHoursUsageKWh) AS OffPeakUsage 
FROM MeterReadings 
GROUP BY ConsumerID;

# q4 Consumers using more than 70 KWh
SELECT ConsumerID, SUM(UsageKWh) AS TotalUsage 
FROM MeterReadings 
GROUP BY ConsumerID 
HAVING TotalUsage > 70;

#q5 Highest electricity usage consumer
SELECT ConsumerID, SUM(UsageKWh) AS TotalUsage 
FROM MeterReadings 
GROUP BY ConsumerID 
ORDER BY TotalUsage DESC 
LIMIT 1;

# q6 Daily electricity consumption trend
SELECT ReadingDate, SUM(UsageKWh) AS TotalUsage 
FROM MeterReadings 
GROUP BY ReadingDate;

#q7 Average peak-hour usage per consumer
SELECT ConsumerID, AVG(PeakHoursUsageKWh) AS AvgPeakUsage 
FROM MeterReadings 
GROUP BY ConsumerID;

#q8 Consumers using more than 50% of energy in peak hours
SELECT ConsumerID 
FROM MeterReadings 
WHERE PeakHoursUsageKWh > (UsageKWh / 2);

#q9 Least electricity usage consumer
SELECT ConsumerID, SUM(UsageKWh) AS TotalUsage 
FROM MeterReadings 
GROUP BY ConsumerID 
ORDER BY TotalUsage ASC 
LIMIT 1;

# q10 Peak usage percentage per consumer
SELECT ConsumerID, (SUM(PeakHoursUsageKWh) / SUM(UsageKWh)) * 100 AS PeakUsagePercentage 
FROM MeterReadings 
GROUP BY ConsumerID;

#q11  Consumers with multiple readings
SELECT ConsumerID, COUNT(DISTINCT ReadingDate) AS DaysRecorded 
FROM MeterReadings 
GROUP BY ConsumerID 
HAVING DaysRecorded > 1;

#q12 Retrieve all readings for ConsumerID = 1
SELECT * FROM MeterReadings WHERE ConsumerID = 1;

#q13 Highest single-day electricity usage
SELECT MAX(UsageKWh) AS MaxDailyUsage FROM MeterReadings;

#q14 Average daily consumption per consumer
SELECT ConsumerID, AVG(UsageKWh) AS AvgDailyUsage 
FROM MeterReadings 
GROUP BY ConsumerID;

# q15 Consumers above overall average consumption
SELECT ConsumerID, SUM(UsageKWh) AS TotalUsage 
FROM MeterReadings 
GROUP BY ConsumerID 
HAVING TotalUsage > (SELECT AVG(UsageKWh) FROM MeterReadings);
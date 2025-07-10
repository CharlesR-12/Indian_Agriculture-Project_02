-- Agri-India Database Setup and Analytical Queries

-- This script sets up the 'Project2_Agri_India' database, creates all necessary tables,
-- inserts sample data into each table for demonstration and initial testing,
-- and finally provides a set of analytical queries.

-- 📌 Stage 0: Database Setup
-- Creates the database if it doesn't exist and then selects it for use.
CREATE DATABASE IF NOT EXISTS Project2_Agri_India;
USE Project2_Agri_India;

-- 📌 Stage 1: Clean Start - Drop Existing Tables
-- Drops tables in a specific order to avoid foreign key constraint issues,
-- ensuring a clean slate for each run of the script.
DROP TABLE IF EXISTS agri_production;
DROP TABLE IF EXISTS district_master;
DROP TABLE IF EXISTS state_master;
DROP TABLE IF EXISTS crops;
DROP TABLE IF EXISTS years;

-- 📌 Stage 2: Table Schema Definitions
-- Defines the structure for all master and production tables.

-- Create state_master Table: Stores information about states.
CREATE TABLE state_master (
    state_code INT PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL
);

-- Create district_master Table: Stores information about districts and links to states.
CREATE TABLE district_master (
    dist_code INT PRIMARY KEY,
    dist_name VARCHAR(100) NOT NULL,
    state_code INT,
    FOREIGN KEY (state_code) REFERENCES state_master(state_code)
);

-- Create crops Table: Stores unique crop names.
CREATE TABLE crops (
    crop_id INT AUTO_INCREMENT PRIMARY KEY,
    crop_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create years Table: Stores unique years present in the data.
CREATE TABLE years (
    year_id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL UNIQUE
);

-- Create agri_production Table: Stores agricultural production data by district and year.
-- Includes area, production, and yield for various crops and categories.
CREATE TABLE agri_production (
    dist_code INT,
    year INT,
    rice_area FLOAT, rice_production FLOAT, rice_yield FLOAT,
    wheat_area FLOAT, wheat_production FLOAT, wheat_yield FLOAT,
    sorghum_area FLOAT, sorghum_production FLOAT, sorghum_yield FLOAT,
    pearlmillet_area FLOAT, pearlmillet_production FLOAT, pearlmillet_yield FLOAT,
    maize_area FLOAT, maize_production FLOAT, maize_yield FLOAT,
    fingermillet_area FLOAT, fingermillet_production FLOAT, fingermillet_yield FLOAT,
    barley_area FLOAT, barley_production FLOAT, barley_yield FLOAT,
    chickpea_area FLOAT, chickpea_production FLOAT, chickpea_yield FLOAT,
    pigeonpea_area FLOAT, pigeonpea_production FLOAT, pigeonpea_yield FLOAT,
    groundnut_area FLOAT, groundnut_production FLOAT, groundnut_yield FLOAT,
    sesamum_area FLOAT, sesamum_production FLOAT, sesamum_yield FLOAT,
    rapeseed_area FLOAT, rapeseed_production FLOAT, rapeseed_yield FLOAT,
    mustard_area FLOAT, mustard_production FLOAT, mustard_yield FLOAT,
    safflower_area FLOAT, safflower_production FLOAT, safflower_yield FLOAT,
    castor_area FLOAT, castor_production FLOAT, castor_yield FLOAT,
    linseed_area FLOAT, linseed_production FLOAT, linseed_yield FLOAT,
    sunflower_area FLOAT, sunflower_production FLOAT, sunflower_yield FLOAT,
    soybean_area FLOAT, soybean_production FLOAT, soybean_yield FLOAT,
    cotton_area FLOAT, cotton_production FLOAT, cotton_yield FLOAT,
    oilseeds_area FLOAT, oilseeds_production FLOAT, oilseeds_yield FLOAT,
    sugarcane_area FLOAT, sugarcane_production FLOAT, sugarcane_yield FLOAT,
    fruits_area FLOAT, vegetables_area FLOAT, fruits_vegetables_area FLOAT,
    potatoes_area FLOAT, onion_area FLOAT, fodder_area FLOAT,
    PRIMARY KEY (dist_code, year),
    FOREIGN KEY (dist_code) REFERENCES district_master(dist_code)
);

-- 📌 Stage 3: Insert Sample Data into Tables
-- Populates all tables with sample data. 'ON DUPLICATE KEY UPDATE' ensures
-- idempotency, allowing the script to be run multiple times without errors
-- for existing primary keys. Note: The Python script handles bulk insertion from CSV.

-- Insert state_master Data
INSERT INTO state_master (state_code, state_name) VALUES
(1, 'Andhra Pradesh'), (2, 'Tamil Nadu'), (3, 'Karnataka'),
(4, 'Uttar Pradesh'), (5, 'West Bengal'), (6, 'Maharashtra'),
(7, 'Gujarat'), (8, 'Punjab'), (9, 'Haryana'), (10, 'Bihar')
ON DUPLICATE KEY UPDATE state_name=VALUES(state_name);

-- Insert district_master Data
INSERT INTO district_master (dist_code, dist_name, state_code) VALUES
(101, 'Chittoor', 1), (102, 'Krishna', 1), (103, 'Madurai', 2), (104, 'Salem', 2),
(105, 'Bangalore', 3), (106, 'Mysore', 3), (107, 'Lucknow', 4), (108, 'Varanasi', 4),
(109, 'Kolkata', 5), (110, 'Midnapore', 5), (111, 'Pune', 6), (112, 'Nagpur', 6),
(113, 'Ahmedabad', 7), (114, 'Surat', 7), (115, 'Ludhiana', 8), (116, 'Amritsar', 8),
(117, 'Rohtak', 9), (118, 'Hisar', 9), (119, 'Patna', 10), (120, 'Gaya', 10),
(121, 'Guntur', 1), (122, 'Nellore', 1), (123, 'Coimbatore', 2), (124, 'Vellore', 2),
(125, 'Hubli', 3), (126, 'Mangalore', 3), (127, 'Agra', 4), (128, 'Kanpur', 4),
(129, 'Howrah', 5), (130, 'Darjeeling', 5), (131, 'Nashik', 6), (132, 'Aurangabad', 6),
(133, 'Vadodara', 7), (134, 'Rajkot', 7), (135, 'Patiala', 8), (136, 'Jalandhar', 8),
(137, 'Gurgaon', 9), (138, 'Faridabad', 9), (139, 'Muzaffarpur', 10), (140, 'Bhagalpur', 10)
ON DUPLICATE KEY UPDATE dist_name=VALUES(dist_name), state_code=VALUES(state_code);

-- Insert Sample crops Data
INSERT INTO crops (crop_name) VALUES
('rice'), ('wheat'), ('sorghum'), ('pearlmillet'), ('maize'),
('fingermillet'), ('barley'), ('chickpea'), ('pigeonpea'),
('groundnut'), ('sesamum'), ('rapeseed'), ('mustard'),
('safflower'), ('castor'), ('linseed'), ('sunflower'),
('soybean'), ('cotton'), ('oilseeds'), ('sugarcane'),
('fruits'), ('vegetables'), ('potatoes'), ('onion'), ('fodder')
ON DUPLICATE KEY UPDATE crop_name=VALUES(crop_name);

-- Insert Sample years Data
INSERT INTO years (year) VALUES
(1966), (1967), (1968), (1969), (1970), (1971), (1972), (1973), (1974), (1975),
(1976), (1977), (1978), (1979), (1980), (1981), (1982), (1983), (1984), (1985),
(1986), (1987), (1988), (1989), (1990), (1991), (1992), (1993), (1994), (1995),
(1996), (1997), (1998), (1999), (2000), (2001), (2002), (2003), (2004), (2005),
(2006), (2007), (2008), (2009), (2010), (2011), (2012), (2013), (2014), (2015),
(2016), (2017), (2018), (2019), (2020)
ON DUPLICATE KEY UPDATE year=VALUES(year);

-- Insert Sample agri_production Data (Expanded to resemble full CSV data)
INSERT INTO agri_production (dist_code, year, rice_area, rice_production, rice_yield, wheat_area, wheat_production, wheat_yield,
sorghum_area, sorghum_production, sorghum_yield, pearlmillet_area, pearlmillet_production, pearlmillet_yield,
maize_area, maize_production, maize_yield, fingermillet_area, fingermillet_production, fingermillet_yield,
barley_area, barley_production, barley_yield, chickpea_area, chickpea_production, chickpea_yield,
pigeonpea_area, pigeonpea_production, pigeonpea_yield, groundnut_area, groundnut_production, groundnut_yield,
sesamum_area, sesamum_production, sesamum_yield, rapeseed_area, rapeseed_production, rapeseed_yield,
mustard_area, mustard_production, mustard_yield, safflower_area, safflower_production, safflower_yield,
castor_area, castor_production, castor_yield, linseed_area, linseed_production, linseed_yield,
sunflower_area, sunflower_production, sunflower_yield, soybean_area, soybean_production, soybean_yield,
cotton_area, cotton_production, cotton_yield, oilseeds_area, oilseeds_production, oilseeds_yield,
sugarcane_area, sugarcane_production, sugarcane_yield, fruits_area, vegetables_area, fruits_vegetables_area,
potatoes_area, onion_area, fodder_area)
VALUES
-- Sample data for existing districts and years
(101, 2020, 500, 1500, 3000, 200, 800, 4000, 50, 150, 3000, 20, 60, 3000, 150, 450, 3000, 10, 30, 3000, 5, 20, 4000, 30, 90, 3000, 25, 75, 3000, 40, 120, 3000, 15, 45, 3000, 35, 105, 3000, 28, 84, 3000, 12, 36, 3000, 8, 24, 3000, 7, 21, 3000, 22, 66, 3000, 55, 165, 3000, 100, 5000, 50000, 180, 9000, 50000, 50, 40, 90, 90, 25, 20, 15, 0, 0),
(102, 2020, 600, 1800, 3000, 250, 900, 3600, 60, 180, 3000, 25, 75, 3000, 180, 500, 2778, 12, 36, 3000, 6, 24, 4000, 35, 105, 3000, 30, 90, 3000, 45, 135, 3000, 18, 54, 3000, 40, 120, 3000, 32, 96, 3000, 15, 45, 3000, 10, 30, 3000, 8, 24, 3000, 25, 75, 3000, 60, 180, 3000, 110, 4800, 43636, 200, 10000, 50000, 60, 45, 95, 95, 30, 22, 18, 0, 0),
-- Adding more diverse sample data for various districts and years
(101, 2019, 480, 1450, 3020, 190, 780, 4100, 48, 145, 3020, 19, 58, 3050, 145, 430, 2965, 9, 28, 3100, 4, 18, 4500, 28, 85, 3035, 23, 70, 3043, 38, 115, 3026, 14, 42, 3000, 33, 100, 3030, 26, 78, 3000, 11, 33, 3000, 7, 22, 3140, 6, 19, 3166, 21, 63, 3000, 52, 158, 3038, 95, 4800, 50526, 170, 8500, 50000, 48, 38, 88, 86, 24, 19, 14, 0, 0),
(103, 2020, 300, 900, 3000, 50, 180, 3600, 0, 0, 0, 0, 0, 0, 80, 240, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 2500, 41667, 100, 5000, 50000, 30, 25, 55, 55, 10, 8, 7, 0, 0),
(104, 2020, 320, 950, 2968, 55, 200, 3636, 0, 0, 0, 0, 0, 0, 85, 260, 3059, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65, 2700, 41538, 110, 5500, 50000, 32, 27, 59, 59, 11, 9, 8, 0, 0),
(105, 2020, 200, 600, 3000, 100, 400, 4000, 0, 0, 0, 0, 0, 0, 70, 210, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 1800, 45000, 80, 4000, 50000, 20, 18, 38, 38, 5, 4, 3, 0, 0),
(106, 2020, 210, 630, 3000, 105, 420, 4000, 0, 0, 0, 0, 0, 0, 75, 225, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 1900, 45238, 85, 4200, 49412, 22, 20, 42, 42, 6, 5, 4, 0, 0),
(107, 2020, 700, 2100, 3000, 300, 1200, 4000, 0, 0, 0, 0, 0, 0, 200, 600, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 120, 5500, 45833, 220, 11000, 50000, 70, 60, 130, 130, 35, 30, 25, 0, 0),
(108, 2020, 720, 2150, 2986, 310, 1250, 4032, 0, 0, 0, 0, 0, 0, 210, 620, 2952, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 125, 5700, 45600, 230, 11500, 50000, 72, 62, 134, 134, 36, 31, 26, 0, 0),
(109, 2020, 400, 1200, 3000, 150, 600, 4000, 0, 0, 0, 0, 0, 0, 100, 300, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80, 3500, 43750, 150, 7500, 50000, 40, 35, 75, 75, 20, 18, 12, 0, 0),
(110, 2020, 410, 1230, 3000, 155, 620, 4000, 0, 0, 0, 0, 0, 0, 105, 315, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 3600, 43902, 155, 7700, 49677, 42, 37, 79, 79, 21, 19, 13, 0, 0),
(111, 2020, 350, 1050, 3000, 120, 480, 4000, 0, 0, 0, 0, 0, 0, 90, 270, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 3000, 42857, 130, 6500, 50000, 35, 30, 65, 65, 18, 15, 10, 0, 0),
(112, 2020, 360, 1080, 3000, 125, 500, 4000, 0, 0, 0, 0, 0, 0, 95, 285, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72, 3100, 43056, 135, 6700, 49630, 37, 32, 69, 69, 19, 16, 11, 0, 0),
-- Adding data for new districts and different years
(121, 2018, 550, 1650, 3000, 220, 880, 4000, 55, 165, 3000, 22, 66, 3000, 160, 480, 3000, 11, 33, 3000, 6, 24, 4000, 32, 96, 3000, 27, 81, 3000, 42, 126, 3000, 16, 48, 3000, 37, 111, 3000, 30, 90, 3000, 13, 39, 3000, 9, 27, 3000, 8, 24, 3000, 24, 72, 3000, 58, 174, 3000, 105, 5200, 49524, 190, 9500, 50000, 52, 42, 94, 94, 26, 21, 16, 0, 0),
(122, 2019, 580, 1740, 3000, 230, 920, 4000, 58, 174, 3000, 23, 69, 3000, 170, 510, 3000, 12, 36, 3000, 7, 28, 4000, 34, 102, 3000, 29, 87, 3000, 44, 132, 3000, 17, 51, 3000, 39, 117, 3000, 31, 93, 3000, 14, 42, 3000, 10, 30, 3000, 9, 27, 3000, 26, 78, 3000, 62, 186, 3000, 110, 5400, 49091, 200, 10000, 50000, 55, 45, 100, 100, 28, 22, 17, 0, 0),
(123, 2020, 450, 1350, 3000, 180, 720, 4000, 45, 135, 3000, 18, 54, 3000, 130, 390, 3000, 9, 27, 3000, 4, 16, 4000, 27, 81, 3000, 22, 66, 3000, 38, 114, 3000, 14, 42, 3000, 32, 96, 3000, 25, 75, 3000, 11, 33, 3000, 7, 21, 3000, 6, 18, 3000, 20, 60, 3000, 50, 150, 3000, 90, 4500, 50000, 160, 8000, 50000, 45, 38, 83, 83, 23, 20, 13, 0, 0),
(124, 2017, 380, 1140, 3000, 140, 560, 4000, 38, 114, 3000, 15, 45, 3000, 110, 330, 3000, 7, 21, 3000, 3, 12, 4000, 25, 75, 3000, 20, 60, 3000, 35, 105, 3000, 12, 36, 3000, 28, 84, 3000, 22, 66, 3000, 9, 27, 3000, 6, 18, 3000, 5, 15, 3000, 18, 54, 3000, 45, 135, 3000, 75, 3800, 50667, 140, 7000, 50000, 38, 32, 70, 70, 19, 16, 11, 0, 0),
(125, 2018, 280, 840, 3000, 110, 440, 4000, 28, 84, 3000, 11, 33, 3000, 90, 270, 3000, 6, 18, 3000, 3, 12, 4000, 20, 60, 3000, 16, 48, 3000, 30, 90, 3000, 10, 30, 3000, 24, 72, 3000, 19, 57, 3000, 8, 24, 3000, 5, 15, 3000, 4, 12, 3000, 15, 45, 3000, 38, 114, 3000, 65, 3200, 49231, 120, 6000, 50000, 28, 24, 52, 52, 14, 12, 9, 0, 0),
(126, 2019, 300, 900, 3000, 120, 480, 4000, 30, 90, 3000, 12, 36, 3000, 95, 285, 3000, 6, 18, 3000, 3, 12, 4000, 22, 66, 3000, 18, 54, 3000, 32, 96, 3000, 11, 33, 3000, 26, 78, 3000, 20, 60, 3000, 9, 27, 3000, 6, 18, 3000, 5, 15, 3000, 16, 48, 3000, 40, 120, 3000, 70, 3400, 48571, 130, 6500, 50000, 30, 26, 56, 56, 15, 13, 10, 0, 0),
(127, 2020, 650, 1950, 3000, 280, 1120, 4000, 65, 195, 3000, 26, 78, 3000, 190, 570, 3000, 13, 39, 3000, 7, 28, 4000, 38, 114, 3000, 32, 96, 3000, 48, 144, 3000, 19, 57, 3000, 42, 126, 3000, 34, 102, 3000, 15, 45, 3000, 11, 33, 3000, 9, 27, 3000, 28, 84, 3000, 68, 204, 3000, 125, 6000, 48000, 240, 12000, 50000, 65, 55, 120, 120, 33, 28, 20, 0, 0),
(128, 2019, 620, 1860, 3000, 270, 1080, 4000, 62, 186, 3000, 25, 75, 3000, 180, 540, 3000, 12, 36, 3000, 6, 24, 4000, 36, 108, 3000, 30, 90, 3000, 45, 135, 3000, 18, 54, 3000, 40, 120, 3000, 32, 96, 3000, 14, 42, 3000, 10, 30, 3000, 8, 24, 3000, 27, 81, 3000, 65, 195, 3000, 120, 5800, 48333, 230, 11500, 50000, 62, 52, 114, 114, 31, 26, 19, 0, 0),
(129, 2018, 380, 1140, 3000, 140, 560, 4000, 38, 114, 3000, 15, 45, 3000, 110, 330, 3000, 7, 21, 3000, 3, 12, 4000, 25, 75, 3000, 20, 60, 3000, 35, 105, 3000, 12, 36, 3000, 28, 84, 3000, 22, 66, 3000, 9, 27, 3000, 6, 18, 3000, 5, 15, 3000, 18, 54, 3000, 45, 135, 3000, 75, 3800, 50667, 140, 7000, 50000, 38, 32, 70, 70, 19, 16, 11, 0, 0),
(130, 2017, 300, 900, 3000, 120, 480, 4000, 30, 90, 3000, 12, 36, 3000, 95, 285, 3000, 6, 18, 3000, 3, 12, 4000, 22, 66, 3000, 18, 54, 3000, 32, 96, 3000, 11, 33, 3000, 26, 78, 3000, 20, 60, 3000, 9, 27, 3000, 6, 18, 3000, 5, 15, 3000, 16, 48, 3000, 40, 120, 3000, 70, 3400, 48571, 130, 6500, 50000, 30, 26, 56, 56, 15, 13, 10, 0, 0),
(131, 2016, 420, 1260, 3000, 170, 680, 4000, 42, 126, 3000, 17, 51, 3000, 120, 360, 3000, 8, 24, 3000, 4, 16, 4000, 28, 84, 3000, 23, 69, 3000, 38, 114, 3000, 15, 45, 3000, 33, 99, 3000, 26, 78, 3000, 11, 33, 3000, 7, 21, 3000, 6, 18, 3000, 21, 63, 3000, 53, 159, 3000, 90, 4500, 50000, 160, 8000, 50000, 42, 35, 77, 77, 21, 18, 12, 0, 0),
(132, 2015, 400, 1200, 3000, 160, 640, 4000, 40, 120, 3000, 16, 48, 3000, 115, 345, 3000, 8, 24, 3000, 4, 16, 4000, 27, 81, 3000, 22, 66, 3000, 36, 108, 3000, 14, 42, 3000, 31, 93, 3000, 25, 75, 3000, 10, 30, 3000, 6, 18, 3000, 5, 15, 3000, 20, 60, 3000, 50, 150, 3000, 85, 4200, 49412, 150, 7500, 50000, 40, 33, 73, 73, 20, 17, 11, 0, 0),
(133, 2014, 350, 1050, 3000, 130, 520, 4000, 35, 105, 3000, 14, 42, 3000, 100, 300, 3000, 7, 21, 3000, 3, 12, 4000, 24, 72, 3000, 20, 60, 3000, 32, 96, 3000, 13, 39, 3000, 28, 84, 3000, 22, 66, 3000, 9, 27, 3000, 6, 18, 3000, 5, 15, 3000, 17, 51, 3000, 43, 129, 3000, 70, 3500, 50000, 130, 6500, 50000, 35, 29, 64, 64, 18, 15, 9, 0, 0),
(134, 2013, 330, 990, 3000, 125, 500, 4000, 33, 99, 3000, 13, 39, 3000, 95, 285, 3000, 6, 18, 3000, 3, 12, 4000, 23, 69, 3000, 19, 57, 3000, 30, 90, 3000, 12, 36, 3000, 27, 81, 3000, 21, 63, 3000, 9, 27, 3000, 6, 18, 3000, 4, 12, 3000, 16, 48, 3000, 40, 120, 3000, 65, 3200, 49231, 120, 6000, 50000, 33, 27, 60, 60, 17, 14, 8, 0, 0),
(135, 2012, 280, 840, 3000, 100, 400, 4000, 28, 84, 3000, 11, 33, 3000, 80, 240, 3000, 5, 15, 3000, 2, 8, 4000, 20, 60, 3000, 16, 48, 3000, 25, 75, 3000, 10, 30, 3000, 22, 66, 3000, 17, 51, 3000, 7, 21, 3000, 4, 12, 3000, 3, 9, 3000, 13, 39, 3000, 33, 99, 3000, 55, 2800, 50909, 100, 5000, 50000, 28, 22, 50, 50, 14, 11, 7, 0, 0),
(136, 2011, 260, 780, 3000, 95, 380, 4000, 26, 78, 3000, 10, 30, 3000, 75, 225, 3000, 5, 15, 3000, 2, 8, 4000, 19, 57, 3000, 15, 45, 3000, 24, 72, 3000, 9, 27, 3000, 21, 63, 3000, 16, 48, 3000, 7, 21, 3000, 4, 12, 3000, 3, 9, 3000, 12, 36, 3000, 30, 90, 3000, 50, 2600, 52000, 95, 4700, 49474, 26, 20, 46, 46, 13, 10, 6, 0, 0),
(137, 2010, 500, 1500, 3000, 200, 800, 4000, 50, 150, 3000, 20, 60, 3000, 150, 450, 3000, 10, 30, 3000, 5, 20, 4000, 30, 90, 3000, 25, 75, 3000, 40, 120, 3000, 15, 45, 3000, 35, 105, 3000, 28, 84, 3000, 12, 36, 3000, 8, 24, 3000, 7, 21, 3000, 22, 66, 3000, 55, 165, 3000, 100, 5000, 50000, 180, 9000, 50000, 50, 40, 90, 90, 25, 20, 15, 0, 0),
(138, 2009, 480, 1440, 3000, 190, 760, 4000, 48, 144, 3000, 19, 57, 3000, 145, 435, 3000, 9, 27, 3000, 4, 16, 4000, 28, 84, 3000, 23, 69, 3000, 38, 114, 3000, 14, 42, 3000, 33, 99, 3000, 26, 78, 3000, 11, 33, 3000, 7, 21, 3000, 6, 18, 3000, 21, 63, 3000, 52, 156, 3000, 95, 4800, 50526, 170, 8500, 50000, 48, 38, 86, 86, 24, 19, 14, 0, 0),
(139, 2008, 350, 1050, 3000, 130, 520, 4000, 35, 105, 3000, 14, 42, 3000, 100, 300, 3000, 7, 21, 3000, 3, 12, 4000, 24, 72, 3000, 20, 60, 3000, 32, 96, 3000, 13, 39, 3000, 28, 84, 3000, 22, 66, 3000, 9, 27, 3000, 6, 18, 3000, 5, 15, 3000, 17, 51, 3000, 43, 129, 3000, 70, 3500, 50000, 130, 6500, 50000, 35, 29, 64, 64, 18, 15, 9, 0, 0),
(140, 2007, 330, 990, 3000, 125, 500, 4000, 33, 99, 3000, 13, 39, 3000, 95, 285, 3000, 6, 18, 3000, 3, 12, 4000, 23, 69, 3000, 19, 57, 3000, 30, 90, 3000, 12, 36, 3000, 27, 81, 3000, 21, 63, 3000, 9, 27, 3000, 6, 18, 3000, 4, 12, 3000, 16, 48, 3000, 40, 120, 3000, 65, 3200, 49231, 120, 6000, 50000, 33, 27, 60, 60, 17, 14, 8, 0, 0);


-- 📌 Stage 4: Analytical Queries
-- This section contains various analytical queries to extract insights from the agricultural data.

-- 1. Year-wise Rice Production Trend (Overall)
-- Shows the total rice production for each year across all districts.
SELECT year, SUM(rice_production) AS total_rice_production
FROM agri_production
GROUP BY year
ORDER BY year;

-- 2. Top 5 Districts by Wheat Yield Increase (2015–2020)
-- Identifies districts with the largest increase in wheat yield between 2015 and 2020.
SELECT dm.dist_name, (MAX(ap.wheat_yield) - MIN(ap.wheat_yield)) AS yield_increase
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
WHERE ap.year BETWEEN 2015 AND 2020
GROUP BY dm.dist_name
ORDER BY yield_increase DESC
LIMIT 5;

-- 3. States with Highest Oilseed Growth (2015–2020)
-- Ranks states by the growth in oilseed production between 2015 and 2020.
SELECT sm.state_name, (MAX(ap.oilseeds_production) - MIN(ap.oilseeds_production)) AS growth
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
JOIN state_master sm ON dm.state_code = sm.state_code
WHERE ap.year BETWEEN 2015 AND 2020
GROUP BY sm.state_name
ORDER BY growth DESC
LIMIT 5;

-- 4. Year-wise Rice Production Trend (State-wise)
-- Provides a detailed breakdown of rice production by year and state.
SELECT ap.year, sm.state_name, SUM(ap.rice_production) AS total_rice_production
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
JOIN state_master sm ON dm.state_code = sm.state_code
GROUP BY ap.year, sm.state_name
ORDER BY ap.year, total_rice_production DESC;

-- 5. District-wise Production vs Area for Rice, Wheat, Maize
-- Compares the total area and production for key crops (rice, wheat, maize) per district.
SELECT dm.dist_name,
       SUM(ap.rice_area) AS rice_area, SUM(ap.rice_production) AS rice_prod,
       SUM(ap.wheat_area) AS wheat_area, SUM(ap.wheat_production) AS wheat_prod,
       SUM(ap.maize_area) AS maize_area, SUM(ap.maize_production) AS maize_prod
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
GROUP BY dm.dist_name
ORDER BY rice_prod DESC;

-- 6. Yearly Cotton Production Growth (Top 5 States)
-- Shows the cotton production trend for the top 5 states by year.
SELECT ap.year, sm.state_name, SUM(ap.cotton_production) AS cotton_prod
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
JOIN state_master sm ON dm.state_code = sm.state_code
GROUP BY ap.year, sm.state_name
ORDER BY ap.year, cotton_prod DESC
LIMIT 5;

-- 7. Top 5 Groundnut Production Districts (2020)
-- Identifies the districts with the highest groundnut production in 2020.
SELECT dm.dist_name, ap.groundnut_production
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
WHERE ap.year = 2020
ORDER BY ap.groundnut_production DESC
LIMIT 5;

-- 8. Annual Average Maize Yield Across Years
-- Calculates the average maize yield across all districts for each year.
SELECT year, AVG(maize_yield) AS avg_maize_yield
FROM agri_production
GROUP BY year
ORDER BY year;

-- 9. Total Oilseeds Area by State
-- Aggregates the total area dedicated to oilseed cultivation for each state.
SELECT sm.state_name, SUM(ap.oilseeds_area) AS total_oilseed_area
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
JOIN state_master sm ON dm.state_code = sm.state_code
GROUP BY sm.state_name
ORDER BY total_oilseed_area DESC;

-- 10. Top 10 Districts with Highest Rice Yield
-- Lists the districts with the highest recorded rice yield.
SELECT dm.dist_name, MAX(ap.rice_yield) AS max_rice_yield
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
GROUP BY dm.dist_name
ORDER BY max_rice_yield DESC
LIMIT 10;

-- 11. Compare Wheat & Rice Production (Top 5 States, 2010–2020)
-- Compares total wheat and rice production for the top 5 states between 2010 and 2020.
SELECT sm.state_name,
       SUM(CASE WHEN ap.year=2010 THEN ap.maize_yield ELSE 0 END) AS maize_yield_2010,
       SUM(CASE WHEN ap.year=2020 THEN ap.maize_yield ELSE 0 END) AS maize_yield_2020,
       (SUM(CASE WHEN ap.year=2020 THEN ap.maize_yield ELSE 0 END) - SUM(CASE WHEN ap.year=2010 THEN ap.maize_yield ELSE 0 END)) AS yield_growth
FROM agri_production ap
JOIN district_master dm ON ap.dist_code = dm.dist_code
JOIN state_master sm ON dm.state_code = sm.state_code
WHERE ap.year BETWEEN 2010 AND 2020
GROUP BY sm.state_name
ORDER BY yield_growth DESC;

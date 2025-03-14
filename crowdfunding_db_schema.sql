
-- Create Database called crowdfunding_db
--CREATE DATABASE crowdfunding_db;   - Commented out as the database is already created inside pgAdmin4


-- Create the tables
CREATE TABLE category (
    category_id VARCHAR(10) PRIMARY KEY,
    category VARCHAR(255) NOT NULL
);

CREATE TABLE subcategory (
    subcategory_id VARCHAR(10) PRIMARY KEY,
    subcategory VARCHAR(255) NOT NULL
);

CREATE TABLE contacts (
    contact_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE campaign (
    cf_id INT PRIMARY KEY,
    contact_id INT NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    goal FLOAT NOT NULL,
    pledged FLOAT NOT NULL,
    outcome VARCHAR(255) NOT NULL,
    backers_count INT NOT NULL,
    country VARCHAR(10) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    launch_date DATE NOT NULL,
    end_date DATE NOT NULL,
    category VARCHAR(255) NOT NULL,
    subcategory VARCHAR(255) NOT NULL,
    category_id VARCHAR(10) NOT NULL,
    subcategory_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (contact_id) REFERENCES contacts(contact_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id)
);

ALTER TABLE campaign ADD CONSTRAINT fk_campaign_contact_id FOREIGN KEY(contact_id)
REFERENCES contacts (contact_id);

ALTER TABLE campaign ADD CONSTRAINT fk_campaign_category_id FOREIGN KEY(category_id)
REFERENCES category (category_id);

ALTER TABLE campaign ADD CONSTRAINT fk_campaign_subcategory_id FOREIGN KEY(subcategory_id)
REFERENCES subcategory (subcategory_id);

-- Import data from CSV files into tables
COPY category
FROM './Resources/category.csv'
WITH (FORMAT CSV, HEADER);

COPY subcategory
FROM './Resources/subcategory.csv'
WITH (FORMAT CSV, HEADER);

COPY contacts
FROM './Resources/contacts.csv'
WITH (FORMAT CSV, HEADER);

COPY campaign
FROM './Resources/campaign.csv'
WITH (FORMAT CSV, HEADER);

--Query to check the data in the tables
SELECT * FROM category;
SELECT * FROM subcategory;
SELECT * FROM contacts;
SELECT * FROM campaign;
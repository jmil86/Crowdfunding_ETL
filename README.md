# Crowdfunding_ETL

# Cat & Subcat dataframes - Forrest

Extracted the crowdfunding.xlsx and split the Category column to be two separate columns being Category and Subcategory. From those columns I created dataframes for both subcategories and categories with their respective sub/category id number. When this was complete, I exported these dataframes as csv files. 



# Contacts Data Processing - Megan / Haley

We extracted and transformed data from contacts.xlsx using **both dictionary methods and regular expressions.**
**Dictionary Method:** Created and iterated through the DataFrame, converted each row into a dictionary, extracted values, and structured the data into a new DataFrame.
**Regex Method:** Used regular expressions to extract contact_id, name, and email, converted contact_id to integer, and split names into separate columns.




# Campaign DataFrame-  Leo

To construct the campaign_df, I started by loading the crowdfunding.xlsx file and extracting the "campaign_data" sheet. From this sheet, I carefully selected columns such as cf_id, contact_id, company_name, blurb, goal, pledged, outcome, backers_count, country, currency, launched_at, and deadline. I renamed the blurb column to description for better clarity.

Next, I applied the necessary data transformations. I converted the goal and pledged columns to the float data type for consistency. I also transformed the launched_at and deadline columns into datetime format in UTC, renaming them to launch_date and end_date, respectively.

To simplify the dataset, I removed unnecessary columns such as staff_pick, spotlight, and category & sub-category. This created a streamlined DataFrame that included only the most relevant information.

Finally, I exported the campaign_df to a CSV file named campaign.csv. This cleaned and organized dataset was now ready for analysis or integration into other workflows.




# Crowdfunding Database Setup - Joe

This section outlines the steps taken to design and implement the crowdfunding database.

## 1. ERD Sketch Creation

   * The process began with an analysis of the provided CSV files (`category.csv`, `contacts.csv`, `subcategory.csv`, and `campaign.csv`)
   * The columns and their data types in each file were inspected using Pandas in a Python environment.
   * Relationships between the files were identified based on common columns (e.g., `category_id`, `subcategory_id`, `contact_id`).
   * An Entity-Relationship Diagram (ERD) sketch was created using QuickDBD to visually represent the tables and their relationships.
   * The following tables and relationships were defined:
        * **contacts**
            * Attributes: `contact_id` (PK), `first_name`, `last_name`, `email`
        * **category**
            * Attributes: `category_id` (PK), `category`
        * **subcategory**
            * Attributes: `subcategory_id` (PK), `subcategory`
        * **campaign**
            * Attributes: `cf_id` (PK), `contact_id` (FK), `company_name`, `description`, `goal`, `pledged`, `outcome`, `backers_count`, `country`, `currency`, `launch_date`, `end_date`, `category_id` (FK), `subcategory_id` (FK)
   * Table relationships were established as follows:
        * The `campaign` table has foreign key relationships with the `contacts`, `category`, and `subcategory` tables.
        * `category` table is the parent table for `campaign` table on `category_id` column.
        * `subcategory` table is the parent table for `campaign` table on `subcategory_id` column.
        * `contacts` table is the parent table for `campaign` table on `contact_id` column.

## 2. Database Creation in pgAdmin 4

   * **Database Creation:**
        * pgAdmin 4 was opened, and the server was connected to.
        * In the "Object" explorer, the server was expanded.
        * "Databases" was right-clicked, and "Create" -> "Database..." was selected.
        * In the "Create - Database" dialog, "crowdfunding_db" was entered in the "Database" field, and "Save" was clicked.

## 3. Table Creation in pgAdmin 4

   * **Table Creation Order:** The tables were created in a specific order to handle foreign key constraints: `category`, `subcategory`, `contacts`, and then `campaign`.
   * **Query Tool:**
        * In the "Object" explorer, the server, "Databases," and "crowdfunding_db" were expanded.
        * "Query Tool" was selected by right-clicking on "crowdfunding\_db".
   * **`CREATE TABLE` Statements:**
        * The following SQL `CREATE TABLE` statements were executed in the Query Tool, in the specified order:
        * **`category` Table:**

            ```sql
            CREATE TABLE category (
                category_id VARCHAR(10) PRIMARY KEY,
                category VARCHAR(255) NOT NULL
            );
            ```
        * **`subcategory` Table:**

            ```sql
            CREATE TABLE subcategory (
                subcategory_id VARCHAR(10) PRIMARY KEY,
                subcategory VARCHAR(255) NOT NULL
            );
            ```
        * **`contacts` Table:**

            ```sql
            CREATE TABLE contacts (
                contact_id INT PRIMARY KEY,
                first_name VARCHAR(255) NOT NULL,
                last_name VARCHAR(255) NOT NULL,
                email VARCHAR(100) NOT NULL
            );
            ```
        * **`campaign` Table:**

            ```sql
            CREATE TABLE campaign (
                cf_id INT PRIMARY KEY,
                contact_id INT,
                company_name VARCHAR(255) NOT NULL,
                description TEXT NOT NULL,
                goal FLOAT NOT NULL,
                pledged FLOAT NOT NULL,
                outcome VARCHAR(50) NOT NULL,
                backers_count INT NOT NULL,
                country VARCHAR(10) NOT NULL,
                currency VARCHAR(10) NOT NULL,
                launch_date DATE NOT NULL,
                end_date DATE NOT NULL,
                category VARCHAR(255),
                subcategory VARCHAR(255),
                category_id VARCHAR(10),
                subcategory_id VARCHAR(10),
                FOREIGN KEY (contact_id) REFERENCES contacts(contact_id),
                FOREIGN KEY (category_id) REFERENCES category(category_id),
                FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id)
            );
            ```
   * **Table Verification:**
        * In the "Object" explorer, the created tables were verified under "crowdfunding\_db" -> "Schemas" -> "public" -> "Tables".

## 4. Data Import and Verification

   * **CSV File Preparation:**
        * The CSV files were prepared to ensure data consistency:
            * Column order in CSV files matched the table definitions.
            * CSV files included a header row with column names.
            * Data types in CSV files were compatible with table column data types.
            * For `campaign.csv`, foreign key values were validated against the parent tables.
            * Date/time formats in `campaign.csv` were checked for PostgreSQL compatibility.
            * Text fields with commas or special characters were properly enclosed in double quotes.
            * CSV files were encoded in UTF-8.
   * **Data Import using `Import`:**
        * The following csv files were imported into their respective tables:
            1.  `category.csv` into `category`
            2.  `subcategory.csv` into `subcategory`
            3.  `contacts.csv` into `contacts`
            4.  `campaign.csv` into `campaign`
      
   * **Data Verification:**
        * `SELECT` queries were used in the Query Tool to verify that the data was imported correctly.

            ```sql
            SELECT * FROM category;
            SELECT * FROM subcategory;
            SELECT * FROM contacts;
            SELECT * FROM campaign;
            ```

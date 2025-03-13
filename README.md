# Crowdfunding_ETL



Campaign DataFrame-Leo

To construct the campaign_df, I started by loading the crowdfunding.xlsx file and extracting the "campaign_data" sheet. From this sheet, I carefully selected columns such as cf_id, contact_id, company_name, blurb, goal, pledged, outcome, backers_count, country, currency, launched_at, and deadline. I renamed the blurb column to description for better clarity.

Next, I applied the necessary data transformations. I converted the goal and pledged columns to the float data type for consistency. I also transformed the launched_at and deadline columns into datetime format in UTC, renaming them to launch_date and end_date, respectively.

To simplify the dataset, I removed unnecessary columns such as staff_pick, spotlight, and category & sub-category. This created a streamlined DataFrame that included only the most relevant information.

Finally, I exported the campaign_df to a CSV file named campaign.csv. This cleaned and organized dataset was now ready for analysis or integration into other workflows.
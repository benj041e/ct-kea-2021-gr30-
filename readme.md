BE-IT DK2 A20
Gruppe 30
Benjamin Eibye, Christian K. Brodersen, Jonas Tvede og Ida Maria Ingerslev

File structure

| +---SQL Scripts
    | +---DML Queries 
        | +--- DML.sql
    | +---DDL Queries
        | +--- DDL.sql

The SQL scripts are developed and testet on a local MySQL server V. 8.0.21

For using the database, run DML.sql in on your own MySQL server via your favoired SQL editor Ex. MySQL Workbench, TablePlus or Sequel Pro

When running the DML.sql file, a new DB will be created named CT. It will then create all the tables discribed in the Case Repport. Finaly it will create views for showind the data, and fill the tables with dummy data.

To use the views, run the scripts in DDL.sql, by uncommenting the "--" lines in the beginning of each comment.
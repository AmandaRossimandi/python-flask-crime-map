# Crime reporting database

A database application using flask webservice and a MySQL db for 
geographically mapping crime events.

### Table Description


| Column Name             | Column Description                                                  |
|-------------------------|---------------------------------------------------------------------| 
| id                      | Unique record for every crime generated automatically starting at 1 |
| latitude and longitude  | Float with 10 digits and 6 after the decimal of crime               |
| date                    | Date and time of crime                                              |
| category                | Category of classification of crime, 50 character limit             |
| description             | Detailed description, 1000 character limit                          |
| updated_at              | Time stamp of entry or modification generated automatically         |




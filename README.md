# Crime reporting database

A database application using flask webservice and a MySQL database for 
geographically mapping crime events, with a frontend/backend programmed from scratch.

Google maps API, application programming interface, is used to embed a map widget and a 
categories, date, description, longitude and latitude submission form.


### Files
1. `crimemap.py` contains flask app
2. `templates/home.html` contains html for page
3. `static/css/style.css` contains style encodings
4. `vps_setup.sh` contains shell commands for setting up sql, the server, and flask


### Table Description


| Column Name             | Column Description                                                  |
|-------------------------|---------------------------------------------------------------------| 
| id                      | Unique record for every crime generated automatically starting at 1 |
| latitude and longitude  | Float with 10 digits and 6 after the decimal of crime               |
| date                    | Date and time of crime                                              |
| category                | Category of classification of crime, 50 character limit             |
| description             | Detailed description, 1000 character limit                          |
| updated_at              | Time stamp of entry or modification generated automatically         |




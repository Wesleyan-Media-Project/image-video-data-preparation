library(RMySQL)
library(data.table)


# Get text and ad information from the unicode friendly table

# Create mySQL connection:

db = dbConnect(RMySQL::MySQL(), 
               host="localhost",
               dbname="ad_media", # replace with your database name 
               user="wmp_student", # replace with your username
               password="my_password") # replace with your password

d <- dbGetQuery(db, "select ad_id, ad_title, ad_text from my_table") # replace my_table with your MySQL table

dbDisconnect(db)

write.csv(d,"output_filepath.csv", row.names = FALSE) # replace with desired destination for queried text ads data 
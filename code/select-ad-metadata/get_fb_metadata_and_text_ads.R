library(dplyr)
library(jsonlite)
library(readr)
library(RMySQL)
library(data.table)


## Get text ads and ads metadata for all ads from the unicode friendly table

## Create mySQL connection:
db = dbConnect(RMySQL::MySQL(), 
               host="localhost",
               dbname="my_fb_db", # replace with your database name 
               user="wmp_student", # replace with your username
               password="my_password") # replace with your password

# Query 2022 election cycle data. Replace "race2022_utf8" with your own table name
d <- dbGetQuery(db, "select * from race2022_utf8 where date > '2022-09-01'")

# Keep only the most recent version of ads 
# This also cleans up ads with different ad_delivery_start_date
df <- d[order(d$date, decreasing = T),]
df <- df[!duplicated(df$id),]

# Dates
df$ad_delivery_start_time <- as.Date(df$ad_delivery_start_time)
df$ad_delivery_stop_time <- as.Date(df$ad_delivery_stop_time)

# Ads that end some time equal to or after 09/05 (beginning date of time period)
df2 <- df[df$ad_delivery_stop_time >= "2022-09-05",]
df2 <- df2[is.na(df2$id) == F,]

# Ads that never end
df3 <- df[is.na(df$ad_delivery_stop_time),]
df3 <- df3[is.na(df3$id) == F,]

# Combine the two
df4 <- rbind(df2, df3)

# Remove ads that start after the end date (end date of time period)
df4 <- df4[df4$ad_delivery_start_time <= "2022-11-08",]

#################
# Add pd ids to the dataframe
e <- dbGetQuery(db, "select `ad_id`, `pd_id` from ad_pd_id")
e <- e[!duplicated(e$ad_id),]

f <- left_join(df4, e, by=c('id' = 'ad_id'))
f$ad_id <- paste0('x_',f$id)

dbDisconnect(db)

# Save metadata information. Replace with your own output file path. 
write.csv(f,"fb2022_master_0905_1108.csv", row.names = FALSE)



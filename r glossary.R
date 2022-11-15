#---------------
# PACKAGES
#---------------

library(tidyverse)
library(data.table)

#---------------
# MOCK DATA-FRAMES 
#---------------

df <- data_frame(
  ID = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
  Date = c("14/12/2018", "15/12/2018", "16/12/2018", "17/12/2018", "18/12/2018", "19/12/2018", "20/12/2018", "21/12/2018", "22/12/2018", "23/12/2018"),
  Time = c("12:30:03", "12:32:27", "17:25:16", "00:09:41", "07:11:58", "11:59:53", "14:14:14", "12:16:31", "18:14:16", "19:13:27"),
  DateTime = c("14/12/2018, 12:30:03", "15/12/2018, 12:32:27", "16/12/2018, 17:25:16", "17/12/2018, 00:09:41", "18/12/2018, 07:11:58", "19/12/2018, 11:59:53", "20/12/2018, 14:14:14", "21/12/2018, 12:16:31", "22/12/2018, 18:14:16", "23/12/2018, 19:13:27"),
  Category = c("C1", "C1", "C1", "C1", "C1", "C2", "C2", "C2", "C2", "C2"),
  Category2 = c("D1", "D1", "D2", "D2", "D3", "D3", "D4", "D4", "D5", "D5"),
  Group = c("G1", "G1", "G1", "G1", "G1", "G1", "G1", "G1", "G1", "G1"),
  Value1 = c(4.13, 9.62, 12.89, 3.45, 8.54, 5.55, 6.73, 6.31, 10.04, 1.43),
  Value2 = c(1.98, 2.41, 1.89, 5.45, 6.17, 0.94, 3.45, 4.10, 8.99, 4.00),
  Value3 = c(4.62, NA, NA, 4.56, 2.83, NA, 2.35, 9.51, "", 2.80),
  Value4 = c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
  Value5 = c(NA, 3.62, NA, NA, NA, NA, NA, 2.53, NA, NA),
  )

df.2 <- data_frame(
  ID = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
  Date = c("14/12/2018", "15/12/2018", "16/12/2018", "17/12/2018", "18/12/2018", "19/12/2018", "20/12/2018", "21/12/2018", "22/12/2018", "23/12/2018"),
  Value6 = c(11.42, 16.08, 14.47, 12.34, 19.99, 18.51, 10.97, 12.15, 16.81, 11.43),
)

df.reshape <- data_frame(
  Year = c(2012, 2012, 2012, 2012, 2012, 2013, 2013, 2013, 2013, 2013),
  Level = c("Level 1", "Level 1", "Level 1", "Level 1", "Level 1", "Level 2", "Level 2", "Level 2", "Level 2", "Level 2"),
  Units = c("Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars"),
  Variable = c("Income", "Sales", "Expenditure", "Tax", "Salaries", "Income", "Sales", "Expenditure", "Tax", "Salaries"),
  VariableCode = c("C1", "C2", "C3", "C4", "C5", "C1", "C2", "C3", "C4", "C5"),
  VariableCat = c("Inbound", "Inbound", "Outbound", "Outbound", "Outbound", "Inbound", "Inbound", "Outbound", "Outbound", "Outbound"),
  Value = c(10000, 20000, 4000, 1000, 3000, 7000, 7000, 3000, 2000, 4000),
)

df.reshape2 <- data_frame(
  ID = c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5),
  TimePoint = c(1, 2, 1, 2, 1, 2, 1, 2, 1, 2),
  Score = c(NA, 2.6, 7.4, NA, 8.8, 6.0, NA, 3.9, 4.5, 4.5),
)


#---------------
# BASIC DATA EVALUATION
#---------------

# Nice overall summary
str(df)

# Check all unique values in a column
unique.category <- unique(df$Category)
unique.category

# Ordering Data (by ID and date)
df <- df[with(df, order(ID, Date)), ]

# Top 3 cases of a particular column 
head(df[order(df$Value1, decreasing = TRUE),], 3)

# provides N, mean, SD, SE and CI
Rmisc::summarySE(df, measurevar="Value1", 
          groupvars= NULL, na.rm = TRUE)

#Remove caps and spaces from column headers
names(df) %<>% 
  stringr::str_replace_all("\\s","_") %>% 
  tolower

# Extract out ID 
df.ID <- df$ID 

# Capitalise all strings in a column 
df.reshape[,2] = toupper(df.reshape[,2])

# two-way comparison
prop.table(table(df$Category, df$Category2), 1)



#---------------
# READING IN DATA / EXPORTING OUT DATA 
#---------------

# Importing

#Set working directory
work_dir_home <- "/Users/perkot/Dropbox/R Programming - Personal/git/itunes/"
setwd(work_dir_home)

# .data file from a URL with readr
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
wdbc <- read.table(url, sep=",")

# .csv from PC directory 
work_dir_home <- "/Users/perkot/Dropbox/R Programming - Personal/Spreadsheets/"
setwd(work_dir_home)
NYC <- read.csv("NYPD_Motor_Vehicle_Collisions.csv", 
                header = TRUE, 
                stringsAsFactors=FALSE)

# from PostGres SQL
# create a connection
# save the password so that we can "hide" it as best as we can by collapsing it
pw <- {
  "new_user_password"
}
# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")
# creates a connection to the postgres database
# note that "con" will be used later in each connection to the database

con <- dbConnect(drv, user="rstudio", password="rstudio",
                 host="localhost", port=5432, dbname="postgres")
# check for the cartable
dbExistsTable(con2, "actor")
# TRUE if table exists in database. If false, potential error 
df_dvd2 <- dbGetQuery(con2, "SELECT * FROM actor")


# Exporting

# Export out multiple dataframes into one excel file 
library(openxlsx)
Phone <- createWorkbook()

addWorksheet(Phone, "PBPSC")
addWorksheet(Phone, "PBPSC - Aggregated")
addWorksheet(Phone, "PBSPC - All")
addWorksheet(Phone, "PBSPC - Queue")
addWorksheet(Phone, "PBSPC - Overflow")

writeData(Phone, 1, PBSPC2)
writeData(Phone, 2, PBSPCAgg2)
writeData(Phone, 3, PBSPC)
writeData(Phone, 4, PBSPCWaitQ)
writeData(Phone, 5, PBSPCWaitOF)

saveWorkbook(Phone, 
             file = "Phones PBSPC.xlsx", 
             overwrite = TRUE)

# Standard .csv export 
write.csv(NxGroup, file = "NxGroup.csv",
          na = "", 
          row.names = FALSE)


#---------------
#CHANGING DATA TYPES
#---------------

# Date
df$Date = as.Date(df$Date, "%d/%m/%Y")

# Date and Time
df$DateTime <- as.POSIXct(df$DateTime, format="%d/%m/%Y, %H:%M:%S")

# Time
df$Time <- as.POSIXlt(df$Time, format="%H:%M:%S")

# Numeric
df$Value5 = as.numeric(df$Value5)

# Character
df$Group <- as.character(df$Group)

# Factor
df$Category <- as.factor(df$Category)

# Integer
df$Year <- as.integer(df$Year)



#---------------
# OBJECTS
#---------------

# Convert to data.frame 
df <- as.data.frame(df)

# Change from List to DataFrame
df$ID <- unlist(df$ID)



#---------------
# IDs / INDEXES
#---------------

# Create an ID column
df$ID2 <- 1:nrow(df)

# Create an ID column, based upon date
df <- df %>% group_by(ID) %>% 
  transform(., DateID = match(Date, unique(Date)))

# If row names get jumbled, use this to reset them
rownames(df) <- 1:nrow(df)



#---------------
# COLUMNS 
#---------------

# Identify all column classes
sapply(df, class)

# Change column names
colnames(df) <- c("ID", "Date", "Category", "Value1", "Value2")
# Or
df <- rename(df, c("ID" = "ID", "Value1" = "Value1"))
# Or
names(df)[4] <- "Value1"

# Check column names
colnames(ePPOC2_CS_PS)

# Subset selected columns from df 
df <- select(df, ID, Date, Category, Value1, Value2)

# Subset to only numeric variables 
df <- dplyr::select_if(df, is.numeric)

# Re-order Columns
df <- df[,c(1, 3, 2, 4, 5)]

# Duplicate a column 
df$Date2 = df$Date

# Populate column with single value 
df$Country <- "Australia"

#---------------
# COLUMN AGGREGATION 
#---------------

# Total up values of multiple columns into new column
df <- df %>% 
  mutate(Total = Value1 + Value2 + Value3 + Value4)

# Arithmetic calculations of multiple columns  
df$V1minusV2 <- df$Value1 - df$Value2 # could also * / +

# Calculate difference & percentage change of two columns with DPLYR
df <- df %>%
  mutate(Difference = Value2 - Value1) %>%
  mutate(Percent_change = (Difference / Value1)*100)

# Calculate Percentage Contribution and Running Sum
df <- df %>% mutate(`Percent Contribution` = (Value1 / sum(df$Value1)) * 100) %>% 
  mutate(Cumulative = cumsum(`Percent Contribution`))

# Order sum total from largest to smallest
df.largest <- 
  df[,c(7:9)] %>% # only numerical columns 
  na.omit() # no missing data
Largest = sort(colSums(df.largest[,1:length(df.largest)]), decreasing = TRUE)[1:3]
Largest # call function 

# Get sum of multiple columns (only numeric)
 rapply(df, sum, class = "numeric")


#---------------
# ROWS
#---------------

# Slice a data-frame up to a certain number of rows
slice(df, 1:5)

# Bind two dataframes
df2 = df
rbind(df, df2)



#---------------
# DPLYR AGGREGATION
#---------------

#SUM

# Sum total of value by a column category 
df.category <- df %>% 
  group_by(Category) %>% # grouping variable 
  summarise(Cat_Sum = sum(Value1)) %>% # give name to new variable 'Cat_Sum'
  arrange(desc(Cat_Sum)) %>% # arrange in order of value
  top_n(20) # could also limit to top 'n' values if many categories 

# Sum total of multiple values by a column category 
df.multi.value <- df %>% 
  group_by(Category) %>% 
  summarise(Cat_Sum = sum(Value1), 
            Cat_Sum2 = sum(Value2))

# Multiple sum total of value by multiple column categories 
df.category <- df %>% 
  group_by(Category, Category2) %>% #grouping variable 
  summarise(SumV1 = sum(Value1))


#COUNTS (N)

# Count of column category
df.category.count <- df %>% 
  group_by(Category) %>% 
  summarise(Cat.Count = n()) %>% 
  arrange(desc(Cat.Count)) 

# Count of multiple column categories, separately 
gather(df, Var, Group, -Value1, -Date, -Time, -ID, -Value2, -Value3, -Value4, -Group) %>% 
  group_by(Var, Group) %>% 
  summarise(Cat.Count = sum(Value1))
# Or
gather(df, Var, Group, -c(1:3, 6:10)) %>% 
  group_by(Var, Group) %>% 
  summarise(Cat.Count = sum(Value1))

# Count of percentage contribution to an overall total 
df.percent <- df %>% 
  group_by(Category2) %>% 
  summarise(Count = n()) %>%
  mutate(`Percent Contribution` = Count / sum(Count) * 100)



#---------------
# FILTERING / SUBSETTING / CHANGING  
#---------------

# Filter a particular category from a column 
dplyr::filter(df, Category == "C1")

# Filter by date
dplyr::filter(df, Date >= as.Date("20/12/2018"))

# Filter a particular category from a column by multiple criteria
df[ which( df$Category2 == "D2" | df$Category2 == "D3") , ]

# Filter rows, based on a column category. i.e. remove all rows where Category = C2
subset(df, Category != "C1")

# Changing a specific value to a different value 
df$Category[df$Category == "C1"] <- "C3"
# Or
df$Category <- revalue(df$Category, c("C3" = "C1"))

# Changing all values in a column to a different value
df$Group <- "G2"

# Changing all values in a dataframe to a different value
df[ Category == "C3" ] <- "C6"



#---------------
# RE-SHAPING
#---------------

# Pivot a column into with an index, so the columns categories are a binary 1,0
df.reshape.pivot <- dcast(df.reshape, formula = VariableCode ~ Value, fun.aggregage = length)

# Pivot data where variables are within a single column 
df.reshaped <- dcast(as.data.table(df.reshape), Year + Units + Level ~ Variable, 
                     value.var = c("Value"), 
                     fun.aggregate = sum) #here I have excluded "variablecat"


# Long to wide to only include complete cases
df.reshaped2 <- df.reshape2 %>%
  tidyr::spread(key = TimePoint, value = Score) %>% 
  na.omit() %>% 
  tidyr::gather(key="TimePoint", value="Score", - ID) 

# Cast a specific column's categories into its own columns 
df.cast <- dcast(df, ID ~ Category2, mean, value.var = "Value1")
df.cast[is.na(df.cast)] <- 0


#---------------
# NA VALUES
#---------------

# Check for missing values across all columns 
sapply(df, function(x) sum(is.na(x)))

# Create index of all NA values in a dataframe
na.index <- is.na(df)

# Determine if any NAs in DF 
anyNA(df)

# Keep all NAs for a specified column, deleting all other rows
subset(df, is.na(Value3))

# Convert NA values to 0
df[is.na(df)] <- 0





#---------------
# DELETE - COLUMNS 
#---------------

# Delete Columns (in this case column 5)
subset(df, select = -c(5))

# Delete Columns (individually)
df$Value2 <- NULL

# Delete Columns that contain only NA values   
all_na = sapply(df, function(x) all(is.na(x)))
summary(all_na)
df.clean = df[!all_na]

# Delete specific values from a column 
df[!(df$Category == "C1"),]

# Delete specific values from a column based on criteria of another column
# i.e. turn all dates to 'NA', where category == C1
df$Date[df$Category == "C1"] <- NA

# Delete columns with less than four occurrences 
df <- subset(df, select=c(names(df)[which(colSums(df) > 4)]))



#---------------
# DELETE - ROWS
#---------------

# Delete a specific row, based on a value
df[ !(df$Value1 %in% c(4.13)), ]
# Delete a specific row, based on a category
df[ !(df$Group == "G1"), ]

# Delete all rows where NA values present in a specific column
df %>% drop_na(Value3)

# Delete specific rows, based on a criteria (i.e. particular IDs - delete 1,3,5)
df[ !(df$ID %in% c(1, 3, 5)), ]

# Delete rows with complete data, leaving only data with missing values 
df.incomplete <- subset(df, select = -c(8))
df.incomplete <- df.incomplete[!complete.cases(df.incomplete), ]

# Delete rows with incomplete data
df.complete <- df[complete.cases(df), ]

# Keep rows with blank data
df.blank <- df[ which( df$Value3 == "") , ]

# Keep rows for which one column is missing data, but the other has complete data
df.test <- subset(df , is.na(Value3))



#---------------
# DUPLICATE VALUES / UNIQUE VALUES
#---------------

# Identify duplicates
df$Value1[duplicated(df$Value1)]

# Delete non-distinct values
df %>% distinct(Category, .keep_all = TRUE)
# Or
df <- df[!duplicated(df[c("Category")]),]

# Delete non-distinct values, but keeping the value with the highest date
df <- df[with(df, order(ID, Date)), ]

# Remove Duplicate appointments, by ordering ascending, it will remove all but the next appointment 
df <- df[!duplicated(df[c("Category")]),]



#---------------
# SUB-STRING 
#---------------

# Use Substring to break-up columns
# First number = position where string extraction starts
# Second number = position where string extraction stops 
df$Year <- substring(df$Date, 7, 10)
df$Month <- substring(df$Date, 4, 5)
df$Day <- substring(df$Date, 1, 2)

# Fill empty rows of a column with a particular value

# Populate empty rows with string
# "^$" == Empty 
df$Value3 <- sub("^$", "missing", df$Value3)

# Substitute one value for another
df$Group <- sub("G1", "Group 1", df$Group)

# Remove a particular value from a string 
df$Time <- gsub(":", "", paste(df$Time))

# Add an additional string to another string 
df$Group <- lapply(df$Group, function(x) paste("Intermediate", x, sep = ", "))

# Combine two string columns, separated by specified value
df$CombinedCategory <- paste(df$Category, ",", df$Category2)

# Add leading zeroes to single-figure strings. 
# "%02d" = use leading zeroes with two digits (i.e. 09, not 010)
df$ID <- sprintf("%02d", df$ID)

# Sub out specific character(s) from a column
as.numeric(gsub('[/]', '', df$Date))

# Add strings in front of an existing string 
# i.e.'20' in front of two-figure year (16,17,18)
# ^ = 'before' 
# $ = 'be end)'after'
gsub('^', '20', df$ID)



#---------------
# JOINS
#---------------

# Left Join
df <- left_join(df, df.2, by = "ID")

# Left Join by multiple elements
df <- left_join(df, df.2, by = c("ID" = "ID", "Date" = "Date"))

# Join, but co-erce only certain columns to target DF
PSEQ <- merge(x = df, 
              y = df.2[ , c("ID", "Value6")], 
              by = "ID", all.x=TRUE)

# Join, but limit to only join columns, & create column of matches
PSEQ <- full_join(df,
                  df.2,
                  keep = TRUE,
                  by = "ID") %>% 
  select(ID, ID.x) %>% 
  mutate(id_match = case_when(id == id.x ~ 1, TRUE ~ 0))



#---------------
# TIME DATA - DATES
#---------------

# Ensure date is date format
df$Date = as.Date(df$Date, "%d/%m/%Y")

# Year from date
df$Year <- year(df$Date)

# Quarter from date
df$Quarter <- zoo::as.yearqtr(df$Date, format = "%d/%m/%Y")

# Month from date 
library(anytime)
df$Month <- format(anydate(df$Date), "%m")

# Week from date 
library(lubridate)
df$Week <- isoweek(ymd(df$Date))

# Day of the week
df$DayofWeek <- weekdays(as.Date(df$Date))

# Weekdays versus Weekends
df$DayType[
  df$DayofWeek == "Saturday" |
    df$DayofWeek == "Sunday"] <-
  "Weekend"
df$DayType[is.na(df$DayType)] <- "Weekday"

# Year-Month
setDT(df)[, Yr_Month := format(as.Date(Date), "%Y-%m") ]

# Year-Week (created)
df$Yr_Week <- paste(df$Year, df$Week, sep="-")

#---------------
# TIME DATA - WITHOUT DATES
#---------------

# Absolute Time (not working)
abs(df$Time)

# Convert time to 24 hour (not working)
df$DateTime <- strptime(df$DateTime, "%m/%d/%Y, %I:%M:%S %p")

# Convert minutes and seconds into seconds - appropriate for 'duration' data
# i.e. 1 minute 23 seconds = 83 seconds
df$Time.Seconds = period_to_seconds(hms(df$Time))

# Separate date and time into separate columns 
df <- separate(data = df, 
               col = DateTime, 
               into = c("Date2", "Time2"), 
               sep = " ")

# Round time to nearest hour
# Duplicate time of song scrobble columsn to create 'hour' column 
df$Hour = df$Time
# convert to time format
df$Hour <- as.POSIXct(df$Hour, format = "%H:%M:%S")
# round to nearest hour
df$Hour = format(round(df$Hour, units = "hours"), format = "%H:%M")



#---------------
# CUSTOM COLUMNS 
#---------------

# Create categorical column based upon numerical data of another column 
# Create DF
df$Value1.Cat <- NA
# Under 5 == 1
df$Value1.Cat[df$Value1 < 5] <- 1
# Over or equal to 5 == 0
df$Value1.Cat[df$Value1 >= 5] <- 0

# New column if category 2 == D1, change all category == C1 (the category corresponding to D1)
# Usage : if we have a public holiday categorised as PH, and remaining days as WD
# Change that particular week to "incomplete", weeks with 5 days == "complete"
df <- df %>% 
  group_by(Category) %>% 
  mutate(CategoryFilter = if("D1" %in% Category2) "Incomplete" else "Complete")  %>% 
  ungroup %>% # last two steps assure we still have a workable DF 
  as.data.frame()
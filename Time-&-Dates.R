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
#Duplicate time of song scrobble columsn to create 'hour' column 
df$Hour = df$Time
#convert to time format
df$Hour <- as.POSIXct(df$Hour, format = "%H:%M:%S")
#round to nearest hour
df$Hour = format(round(df$Hour, units = "hours"), format = "%H:%M")

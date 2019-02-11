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

# Get sum of only numeric columns 
rapply(df, sum, class = "numeric")


#---------------
# ROWS
#---------------

# Slice a data-frame up to a certain number of rows
slice(df, 1:5)

# Bind two dataframes
df2 = df
rbind(df, df2)
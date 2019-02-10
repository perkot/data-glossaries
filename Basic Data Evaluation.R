#---------------
# MOCK DATA
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

# Remove caps and spaces from column headers
names(df) %<>% 
  stringr::str_replace_all("\\s","_") %>% 
  tolower

# Extract out ID 
df.ID <- df$ID 

# Capitalise all strings in a column 
df.reshape[,2] = toupper(df.reshape[,2])

# Two-way comparison
prop.table(table(df$Category, df$Category2), 1)


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
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
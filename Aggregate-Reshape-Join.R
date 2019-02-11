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
# AGGREGATION
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
# RE-SHAPING
#---------------

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
# JOINS
#---------------

# Left Join
df <- left_join(df, df.2, by = "ID")

# Left Join by multiple elements
df <- left_join(df, df.2, by = c("ID" = "ID", "Date" = "Date"))

# Join, but co-erce only certain columns to target DF
df <- merge(x = df, 
              y = df.2[ , c("ID", "Value6")], 
              by = "ID", all.x=TRUE)

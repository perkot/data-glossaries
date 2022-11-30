# -------------------------------------------
# PYTHON GLOSSARY
# -------------------------------------------

# https://stackoverflow.com/questions/54331595/vs-code-cant-open-the-terminal
# when terminal gets stuck being invisible

# Pandas Introduction 
# https://pandas.pydata.org/docs/user_guide/dsintro.html

# -------------------------------------------
# BASIC SET-UP / TERMINAL
# -------------------------------------------

# check version of pip
python3 -m pip --version

# get latest version of set-up tools
python3 -m pip install --upgrade pip setuptools wheel


# -------------------------------------------
# STARTING UP A JUPYTER NOTEBOOK 
# -------------------------------------------

# open up terminal
# navigate here as my jupyter working directory 
jupyter notebook --notebook-dir=/Users/perkot/GIT/python

# CREATE AN EMPTY DATAFRAME 
# https://www.geeksforgeeks.org/different-ways-to-create-pandas-dataframe/

# -------------------------------------------
# PACKAGE MANAGEMENT 
# -------------------------------------------

python3 -m pip install "Orbit"

# Importing Pandas to create DataFrame - necessary package for data wrangling 
import pandas as pd
import numpy as np

# -------------------------------------------
# ENVIRONMENT SET-UP
# -------------------------------------------

# get system / package / working directories 
import sys 
sys.path 

# current working directory
os.getcwd()
# change working directory 
os.chdir("Users/perkot/GIT")

# -------------------------------------------
# CREATE DATAFRAMES WITH MOCK DATA FOR WRANGLING 
# -------------------------------------------

# Creating Empty DataFrame and Storing it in variable df
df = pd.DataFrame()
# Printing Empty DataFrame
print(df)

# DF1 : Primary dataframe for wrangling 

# initialize data of lists.
data = {'Name': ['Tom', 'nick', 'krish', 'jack'],
        'Age': [20, 21, 19, 18]}

# initialize mock data-frame, with data presented as series of lists
data = {
        'ID': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        'Date': ['14/12/2018', '15/12/2018', '16/12/2018', '17/12/2018', '18/12/2018', '19/12/2018', '20/12/2018', '21/12/2018', '22/12/2018', '23/12/2018'],
        'Time': ['12:30:03', '12:32:27', '17:25:16', '00:09:41', '07:11:58', '11:59:53', '14:14:14', '12:16:31', '18:14:16', '19:13:27'],
        'DateTime': ['14/12/2018, 12:30:03', '15/12/2018, 12:32:27', '16/12/2018, 17:25:16', '17/12/2018, 00:09:41', '18/12/2018, 07:11:58', '19/12/2018, 11:59:53', '20/12/2018, 14:14:14', '21/12/2018, 12:16:31', '22/12/2018, 18:14:16', '23/12/2018, 19:13:27'],
        'Category': ['C1', 'C1', 'C1', 'C1', 'C1', 'C2', 'C2', 'C2', 'C2', 'C2'],
        'Category2': ['D1', 'D1', 'D2', 'D2', 'D3', 'D3', 'D4', 'D4', 'D5', 'D5'],
        'Group': ['G1', 'G1', 'G1', 'G1', 'G1', 'G1', 'G1', 'G1', 'G1', 'G1'],
        'Value1': [4.13, 9.62, 12.89, 3.45, 8.54, 5.55, 6.73, 6.31, 10.04, 1.43],
        'Value2': [1.98, 2.41, 1.89, 5.45, 6.17, 0.94, 3.45, 4.10, 8.99, 4.00],
        'Value3': [4.62, None, None, 4.56, 2.83, None, 2.35, 9.51, '', 2.80],
        'Value4': [None, None, None, None, None, None, None, None, None, None],
        'Value5': [None, 3.62, None, None, None, None, None, 2.53, None, None]
        }

# Create DataFrame
df = pd.DataFrame(data)
# Print the output.
df

# DF2 : Secondary dataframe for join practice  

# initialize mock data-frame, with data presented as series of lists
data2 = {
        'ID': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        'Date': ['14/12/2018', '15/12/2018', '16/12/2018', '17/12/2018', '18/12/2018', '19/12/2018', '20/12/2018', '21/12/2018', '22/12/2018', '23/12/2018'],
        'Value6': [11.42, 16.08, 14.47, 12.34, 19.99, 18.51, 10.97, 12.15, 16.81, 11.43]
        }

# Create DataFrame
df2 = pd.DataFrame(data2)
# Print the output.
df2

# DF3 : Primary dataframe for reshaping 

# initialize mock data-frame, with data presented as series of lists
data3 = {
        'Year': [2012, 2012, 2012, 2012, 2012, 2013, 2013, 2013, 2013, 2013],
        'Level': ["Level 1", "Level 1", "Level 1", "Level 1", "Level 1", "Level 2", "Level 2", "Level 2", "Level 2", "Level 2"],
        'Units': ["Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars", "Dollars"],
        'Variable': ["Income", "Sales", "Expenditure", "Tax", "Salaries", "Income", "Sales", "Expenditure", "Tax", "Salaries"],
        'VariableCode': ["C1", "C2", "C3", "C4", "C5", "C1", "C2", "C3", "C4", "C5"],
        'VariableCat': ["Inbound", "Inbound", "Outbound", "Outbound", "Outbound", "Inbound", "Inbound", "Outbound", "Outbound", "Outbound"],
        'Value': [10000, 20000, 4000, 1000, 3000, 7000, 7000, 3000, 2000, 4000]
        }
# Create DataFrame
df3 = pd.DataFrame(data3)
# Print the output.
df3

# DF4 : Secondary dataframe for reshaping 

# initialize mock data-frame, with data presented as series of lists
data4 = {
        'ID': [1, 1, 2, 2, 3, 3, 4, 4, 5, 5],
        'TimePoint': [1, 2, 1, 2, 1, 2, 1, 2, 1, 2],
        'Score': [None, 2.6, 7.4, None, 8.8, 6.0, None, 3.9, 4.5, 4.5]
        }
# Create DataFrame
df4 = pd.DataFrame(data4)
# Print the output.
df4

# -------------------------------------------
# KEY CONCEPTS
# -------------------------------------------

# ------------
# SCALAR VALUE
# ------------
# unchanging i.e. 5,5,5,5,5

# ------------
# TUPLE
# ------------
# Similar to list, but cannot be changed once assigned 
# Tuple having integers
tuple1 = (1, 2, 3)
# tuple with mixed datatypes
tuple2 = (1, "Hello", 3.4)

# ------------
# LAMBDA FUNCTION
# ------------
# An anonymous function
# https://www.programiz.com/python-programming/anonymous-function

# a special type of function without the function name
greeting = lambda name : print('Hey there, ', name)
# call lambda function
greeting('Tom')
# Hey there,  Tom

# ------------
# LOC & ILOC 
# ------------
# loc : return rows/columns with particular labels 
# iloc : return rows/columns at integer locations
df.loc["2018-12-14"] # select by index row (in this example, date index assumed)
df.iloc[2] # select by index location 

# -------------------------------------------
# BASIC DATA EVALUATION 
# -------------------------------------------

# Basic descriptive stastistics of a Adf
df.describe()

# get variable types of all columns 
df.dtypes

# useful summary of a df 
df.info()

# print df
print(df)
# print laat 20 rows 
df.tail(20)
# print first 20 rows
df.tail(20)

# -------------------------------------------
# INDEXING 
# -------------------------------------------

# Basic Indexing 
df["Category"] # select a single column
df.loc["2018-12-14"] # select by index row (in this example, date index assumed)
df.iloc[2] # select by index location 
df[1:3] # subset by first 3 rows (remember, zero indexing in python!)

# create an ID
df["id"] = df.index + 1

# set index as date 
df.set_index('Date')


# -------------------------------------------
# COLUMN-WISE 
# -------------------------------------------

# lower case column names
df.columns = [x.lower() for x in df.columns]

# subset columns
df = df[["ID", "Date", "Time"]]

# delete specific column  
del df["Time"]

# create a scalar column 
df["Company"] = "Tom Incorporated"

# new column calculated from two columns - equiv. to dplyr "mutate"
df.assign(value_ratio =df["Value1"] / df["Value2"])
# conditional calculation from two columns - determine ratio when Value1 > 10
(
     df.query("Value1 > 10") # filtered df
    .assign(
            value_ratio = lambda x: x.Value1 / x.Value2 # ratio calculated on filtered df
           )
)


# -------------------------------------------
# VARIABLE CASTING 
# -------------------------------------------

# ------------
# Common Data Types
# ------------
# string                                object
# int64                                  int64
# uint8                                  uint8
# float64                              float64
# bool1                                   bool
# bool2                                   bool
# dates                         datetime64[ns]
# category                            category
# tdeltas                      timedelta64[ns]
# uint64                                uint64
# other_dates                   datetime64[ns]
# tz_aware_dates    datetime64[ns, US/Eastern]

import datetime as dt 

# convert date string to date
df['Date'] = pd.to_datetime(df['Date'])
# convert date time to date
df['DateTime'] = pd.to_datetime(df['Date'])
# convert a year string to year in date format 
df['year'] = pd.df(df['year'], format='%Y')

# -------------------------------------------
# DATE FIELDS
# -------------------------------------------

# ------------
# FORMAT CODES
# ------------
# %a = abbrv. weekday       %A = full weekday      %w weekday as no.
# %d = day of the month     %b = abbrv. month      %B full month
# %m = month as no.         %y = year as no.       %H hour (24h)            %I hour (12h)
# %p = AM/PM                %M = minute            %S second
# %j = day of year          %U = week no. of year  

# ------------
# Year-Month
# ------------
df['yr-month'] = df['Date'].dt.strftime('%Y-%m')

# ------------
# Date Indexing 
# ------------

# If date is a 'DatetimeIndex', 
# https://jakevdp.github.io/PythonDataScienceHandbook/03.11-working-with-time-series.html#Pandas-Time-Series:-Indexing-by-Time
df = df.set_index(pd.DatetimeIndex(df['Date']))
# we can easily add columns with year, month, and weekday name
df['Year'] = df.index.year
df['Month'] = df.index.month
df['Weekday'] = df.index.weekday

# all values for a specific date 
df.loc['2018-12-14']
# range of dates
df.loc['2018-12-14':'2018-12-16']
# all values for a specific year
df.loc['2018']

# -------------------------------------------
# NAs & BLANKS
# -------------------------------------------

# remove rows where blank data in multiple columns 
df = df[df[['Value3','Value4']].eq('').sum(1).lt(2)] # equals '', sum 1, less than 2
# remove rows where NaN data in multiple columns 
df = df.dropna(subset=['Value3','Value5'], thresh=2)

# -------------------------------------------
# JOINS
# -------------------------------------------

# left join on single id
df_lj = df.merge(df2, on = 'ID', how = "left")

# left join on different named id & drop columns 
df_lj = df.merge(df2, left_on='ID', right_on='ID', how = "left").drop(columns = ['Date'])

# -------------------------------------------
# DESCRIPTIVE STATISTICS
# -------------------------------------------

# ------------
# Descriptive Statistics
# # ------------ 
# count     # sum       # mean      # mad
# median    # min       # max       # mode
# abs       # prod      # std       # var
# sem       # skew      # kurt      # quantile
# cumsum    # cumprod   # cummax    # cummin 

# ------------
# Means
# ------------
# mean by index
df.mean(0) # can specify skipna = True/False
# mean by column 
df.mean(1)

# ------------
# Sum
# ------------
# sum of column 
df.sum(axis=0, skipna=True)

# ------------
# Cumululative sum 
# ------------
# cumulative sum of a single column 
df["value1"].cumsum(0)

# ------------
# Multiple descriptive statistics  
# ------------
# generic descriptive statistics
df["value3"].describe()
# specify percentiles 
df["value3"].describe(percentiles=[0.05, 0.25, 0.75, 0.95])
# describe only columns where data type = number (could also be "object" or "all")
df.describe(include=["number"],percentiles=[0.05, 0.25, 0.75, 0.95])

# -------------------------------------------
# GROUP CALCULATIONS
# -------------------------------------------

# https://stackoverflow.com/questions/46938572/pandas-groupby-mean-into-a-dataframe

    # double brackets to ensure a df 
    # also need to include both grouping variables in mean calculation 

# avg
df_avg = df.groupby(['Category','Category2'], as_index = False).mean()[['Category','Category2', 'Value1']]
print(df_avg)
# sum
df_sum = df.groupby(['Category','Category2'], as_index = False).sum()[['Category','Category2', 'Value1']]
print(df_sum)

# -------------------------------------------
# PIVOTS
# -------------------------------------------

# Long to wide 

# https://stackoverflow.com/questions/28337117/how-to-pivot-a-dataframe-in-pandas

    # rows = Category
    # columns = Category2
    # values = Value1
df_avg_piv = pd.pivot_table(df_avg, values = 'Value1', index = ['Category'], columns = 'Category2').reset_index()
print(df_avg_piv)

# -------------------------------------------
# IMPORT / EXPORT TO .CSV  
# -------------------------------------------

# Import
acorn = pd.read_csv(r"/Users/perkot/GIT/data/ACORN-SAT-Clean.csv")
# Import with first column as 'index' - useful for time series 
acorn = pd.read_csv(r"/Users/perkot/GIT/data/ACORN-SAT-Clean.csv", index_col = 0, parse_dates = True) 

# Export 
df_lj.to_csv(r"/Users/perkot/GIT/data/df_lj.csv", index = False)

# -------------------------------------------
# READING JSON FILES 
# -------------------------------------------
# https://towardsdatascience.com/how-to-convert-json-into-a-pandas-dataframe-100b2ae1e0d8

# SIMPLE JSON FILES 
# json file 
URL = 'http://raw.githubusercontent.com/BindiChen/machine-learning/master/data-analysis/027-pandas-convert-json/data/simple.json'
# convert to df
df_json = pd.read_json(URL)
# print
print(df_json)

# NESTED JSON FILES 
import json
# load data using Python JSON module
with open('/Users/perkot/GIT/data/nested_json.json','r') as f:
    data = json.loads(f.read())
# Flatten data
df_nested_list = pd.json_normalize(data, record_path =['students'])
# print json
print(df_nested_list)
# To include school_name and class
df_nested_list = pd.json_normalize(data, record_path =['students'], meta=['school_name', 'class'])
# print json
print(df_nested_list)

# NESTED + DICTIONARY JSON FILES 
# load data using Python JSON module
with open('/Users/perkot/GIT/data/nested_dict_json.json','r') as f:
    data = json.loads(f.read())
# Normalizing data
df = pd.json_normalize(data, record_path =['students'])
df = pd.json_normalize(data, record_path =['students'], meta=['class', ['info', 'president'], ['info', 'contacts', 'tel']])

# -------------------------------------------
# EXTRACT FOLDER NAMES  
# -------------------------------------------

import os
root = '/Users/perkot/GIT'
directory_list = [item for item in os.listdir(root) if os.path.isdir(os.path.join(root, item))]
print(directory_list)

# -------------------------------------------
# GENERAL INFORMATION 
# -------------------------------------------

# ggplot2 equivalent
# from plotnine import ggplot, geom_point, aes, stat_smooth, facet_wrap


# -------------------------------------------
# VIRTUAL ENVIRONMENTS  
# -------------------------------------------

# Create virtual environment - specify directory 
python3 -m venv <DIR>

source <DIR>/bin/activate

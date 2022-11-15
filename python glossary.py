# -------------------------------------------
# PYTHON GLOSSARY
# -------------------------------------------

# https://stackoverflow.com/questions/54331595/vs-code-cant-open-the-terminal
# when terminal gets stuck being invisible

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
# BASIC DATA EVALUATION 
# -------------------------------------------

# Basic descriptive stastistics of a Adf
df.describe()

# get variable types of all columns 
df.dtypes

# create an ID
df["id"] = df.index + 1


# -------------------------------------------
# VARIABLE CASTING 
# -------------------------------------------

import datetime as dt 

df['Date'] = pd.to_datetime(df['Date'])
df['DateTime'] = pd.to_datetime(df['Date'])

# -------------------------------------------
# NAs & BLANKS
# -------------------------------------------

# remove rows where blank data in multiple columns 
df = df[df[['Value3','Value4']].eq('').sum(1).lt(2)]
# remove rows where NaN data in multiple columns 
df = df.dropna(subset=['Value3','Value5'], thresh=2)

# -------------------------------------------
# JOINS
# -------------------------------------------

# left join on single id
df_lj = df.merge(df2, on = 'ID', how = "left")

# -------------------------------------------
# GROUP CALCULATIONS
# -------------------------------------------

# Get mean x grouping variable(s)

# https://stackoverflow.com/questions/46938572/pandas-groupby-mean-into-a-dataframe
# This calculates group means 
# double brackets to ensure a df 
# also need to include both grouping variables in mean calculation 
acorn_avg =  acorn.groupby(['State', 'Year'], as_index = False).mean()[['State', 'Year', 'max_temp']]

# -------------------------------------------
# PIVOTS
# -------------------------------------------

# Long to wide 

# https://stackoverflow.com/questions/28337117/how-to-pivot-a-dataframe-in-pandas
acorn_avg_p = pd.pivot_table(acorn_avg, values = 'max_temp', index=['Year'], columns = 'State').reset_index()

# -------------------------------------------
# IMPORT / EXPORT TO .CSV  
# -------------------------------------------

# Import
acorn = pd.read_csv(r"/Users/perkot/GIT/data/ACORN-SAT-Clean.csv")

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
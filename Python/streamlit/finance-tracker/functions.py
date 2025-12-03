import streamlit as st
import pandas as pd
import os
from typing import List, Dict, Any

def setColumnNames() -> List[str]:
    '''
    Generates a list of column names for the dataframe.
    
    :return: A list of column names
    :rtype: List[str]
    '''
    return ["id", "date", "category", "subcategory", "description", "amount", "type", "isTransfer", "from", "to"]

def setCategories() -> List[str]:
    '''
    Generates a list of categories for the transaction form.
    
    :return: A list of categories.
    :rtype: List[str]
    '''
    return ["Food", "Transport", "Entertainment", "Apparel", "Services", "Health", "Pets", "Other"]

def setSubcategories() -> Dict[str, List[str]]:
    '''
    Generates a dictionary composed of categories as keys and a list of subcategories as values.
    
    :return: A dictionary of categories and their respective subcategories.
    :rtype: Dict[str, List[str]]
    '''
    return {
        "Food": ["Groceries", "Breakfast", "Lunch", "Dinner", "Dessert", "Drinks", "Other"],
        "Transport": ["Uber", "Taxi", "Bus", "Other"],
        "Entertainment": ["Cinema", "Outdoor events", "Other"],
        "Apparel": ["Clothing", "Shoes", "Accessories", "Jewelry", "Other"],
        "Services": ["Online services", "Aid money for bills", "Other"],
        "Health": ["Medicine", "Therapy", "Doctor visits", "Suplements", "Other"],
        "Pets": ["Food", "Veterinary visits", "Medicine", "Bath", "Toys and treats", "Apparel", "Other"],
        "Other": ["Payroll reception", "Deposits", "Money reception", "Other"]
    }

def getSubcategories(category: str) -> List[str]:
    '''
    Gets the subcategories for a given category.
    
    :param category: The category to search.
    :type category: str
    :return: A list of subcategories for the given category.
    :rtype: List[str]
    '''
    return setSubcategories()[category]

def setNavigation() -> List[Any]:
    '''
    Generates a list of pages for navigation.
    
    :return: Description
    :rtype: List[str]
    '''
    return [
        st.Page("pages/form.py", title="Add transactions"),
        st.Page("pages/charts.py", title="View charts and stats"),
        st.Page("pages/tables.py", title="View transactions")
    ]

def checkIfFileExists(path: str) -> bool:
    '''
    Checks if a file exists in a given path.
    
    :param path: The path to check.
    :type path: str
    :return: A boolean value, which will be True if the file exists and False otherwise.
    :rtype: bool
    '''
    return os.path.exists(path)

def createFolder(name: str) -> bool:
    '''
    Creates a folder in the current directory.
    
    :param name: The name of the folder to create.
    :type name: str
    :return: A boolean value, which will be True if the folder was created successfully and False otherwise.
    :rtype: bool
    '''
    try:
        os.mkdir(name)
        return True
    except:
        return False

def createCSVFile(path: str, name: str, data: pd.DataFrame) -> bool:
    '''
    Creates a CSV file in a given path with a given name and data.
    
    :param path: The path to create the file in.
    :type path: str
    :param name: The name of the file to create.
    :type name: str
    :param data: The data to write to the file.
    :type data: pd.DataFrame
    :return: A boolean value, which will be True if the file was created successfully and False otherwise.
    :rtype: bool
    '''
    try:
        data.to_csv(f"{path}/{name}.csv")
        return True
    except:
        return False
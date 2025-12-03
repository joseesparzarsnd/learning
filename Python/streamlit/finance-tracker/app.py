import streamlit as st
import pandas as pd
from typing import List, Dict, Any
import functions as udfs

pg = st.navigation(udfs.setNavigation())
pg.run()

def init() -> None:
    columns: List[str] = ["id", "date", "category", "subcategory", "description", "amount", "type", "isTransfer", "from", "to"]

    if "df" not in st.session_state:
        st.session_state.df = pd.DataFrame(columns = columns)
    if "counter" not in st.session_state:
        st.session_state.counter = 0

def submit() -> None:
    new_transaction: List[int | str | float | None | bool] = [
        len(st.session_state.df) + 1,
        transaction_date,
        category,
        subcategory,
        description,
        amount,
        type,
        is_transaction,
        from_account,
        to
    ]
    st.session_state.df.loc[len(st.session_state.df)] = new_transaction
    st.session_state.counter += 1
    print("Total rows: ", st.session_state.counter)

def draw() -> None:
    st.write(st.session_state.df)


init()

categories: List[str] = ["Food", "Transport", "Entertainment", "Apparel", "Services", "Health", "Pets", "Other"]

subcategories: Dict[str, List[str]] = {
    "Food": ["Groceries", "Breakfast", "Lunch", "Dinner", "Dessert", "Drinks", "Other"],
    "Transport": ["Uber", "Taxi", "Bus", "Other"],
    "Entertainment": ["Cinema", "Outdoor events", "Other"],
    "Apparel": ["Clothing", "Shoes", "Accessories", "Jewelry", "Other"],
    "Services": ["Online services", "Aid money for bills", "Other"],
    "Health": ["Medicine", "Therapy", "Doctor visits", "Suplements", "Other"],
    "Pets": ["Food", "Veterinary visits", "Medicine", "Bath", "Toys and treats", "Apparel", "Other"],
    "Other": ["Payroll reception", "Deposits", "Money reception", "Other"]
}

with st.container(key = "insert-row-form", border = True):
    page_title: str = st.header("Finance tracker")
    transaction_date: str = st.date_input("Date", value = None)
    category: str = st.selectbox("Category", categories)
    subcategory: str = st.selectbox("Subcategory", subcategories[category])
    description: str = st.text_input("Description")
    amount: float = st.number_input("Amount", value = 0.0)
    type: str = st.selectbox("Type", ["Expense", "Income"])
    is_transaction: bool = st.checkbox("Is this a money transfer?", value = False)
    from_account: str = st.text_input("Source")
    to: str | None = st.text_input("Destination") if is_transaction else None 
 
    submitted: bool = st.button("Add transaction", on_click = submit)

draw()
import streamlit as st
import pandas as pd
from typing import List, Dict, Any

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

df: pd.DataFrame = pd.DataFrame(
    columns = ["id", "date", "category", "subcategory", "description", "amount", "type", "isTransfer", "from", "to"]
)

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

submitted: bool = st.form_submit_button("Add transaction")

if submitted:
    new_transaction: pd.DataFrame = pd.DataFrame({
        "id": len(df.index) + 1,
        "date": transaction_date,
        "category": category,
        "subcategory": subcategory,
        "description": description,
        "amount": amount,
        "type": type,
        "isTransfer": is_transaction,
        "from": from_account,
        "to": to
    })
    df = pd.concat([df, new_transaction], ignore_index = True)
    st.write(df)
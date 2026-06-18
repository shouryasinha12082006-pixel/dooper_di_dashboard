import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="123Shorya@",
    database="dooper_bid"
)

cursor = conn.cursor()

cursor.execute("SELECT COUNT(*) FROM patients")
print(cursor.fetchone())

import pandas as pd

patients = pd.read_sql("SELECT * FROM patients", conn)
appointments = pd.read_sql("SELECT * FROM appointments", conn)
billing = pd.read_sql("SELECT * FROM billing", conn)

total_patients = len(patients)

total_appointments = len(appointments)

completed = len(
    appointments[appointments['status'] == 'Completed']
)

revenue = billing[
    billing['payment_status'] == 'Paid'
]['amount'].sum()

status_counts = appointments['status'].value_counts()

import streamlit as st

st.title("Dooper Healthcare BI Dashboard")

st.metric("Total Patients", total_patients)
st.metric("Appointments", total_appointments)
st.metric("Revenue", f"₹{revenue}")

import plotly.express as px

fig = px.pie(
    appointments,
    names='status',
    title='Appointment Status'
)

st.plotly_chart(fig)

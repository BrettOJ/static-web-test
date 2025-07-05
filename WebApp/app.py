import streamlit as st

st.set_page_config(page_title="Azure Web App Test", layout="centered")

st.title("🚀 Streamlit App on Azure")
st.write("✅ This app is deployed to Azure Web App using Visual Studio Code!")

name = st.text_input("What is your name?")
if name:
    st.success(f"Hello, {name}! Your app is working perfectly.")

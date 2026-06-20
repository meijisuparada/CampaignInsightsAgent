# CampaignInsightsAgent
a chat interface where you type a question like "which audience segment had the best ROAS last month?" and it queries a real dataset, runs the analysis, and answers in plain English with a chart.

How it works
1. User asks a question in plain English — "Which campaign had the highest CTR in Q2?"
↓
2. LLM converts the question to SQL — Claude or GPT reads the database schema and writes the query
↓
3. Query runs against your campaign dataset — a SQLite or BigQuery table you built from mock data
↓
4. LLM summarizes the results — turns raw numbers into a sentence + recommendation, the way she already does for clients
↓
5. Answer + chart displayed in a simple Streamlit chat interface

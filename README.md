# E-Commerce Product Analysis

This project explores a synthetic e-commerce product dataset to uncover insights about product performance, category trends, customer sentiment signals, and inventory risk. The analysis combines Python-based exploratory data analysis in Jupyter notebooks with SQL queries for business-focused reporting.

## Project Overview

The workflow includes:
- Loading and cleaning product sales data
- Creating derived features such as weighted ratings and sales-based metrics
- Visualizing category performance and product popularity
- Identifying products at risk of stockout
- Using SQL to surface high-value business insights

## Repository Structure

- data/ - Raw and transformed datasets
  - ecommerce_product_dataset.csv
  - transformed_df.csv
- notebooks/ - Jupyter notebooks for analysis and testing
  - 01_EDA.ipynb
  - 02_tests.ipynb
- sql/ - SQL queries for product and inventory analysis
  - controversial_products.sql
  - product_maturity.sql
  - product_sentiment_and_opimization.sql
  - stockout_risk_warning.sql
  - top_products_per_category.sql

## Dataset

The main dataset contains product-level information such as:
- Product name and category
- Price and discount
- Rating and number of reviews
- Stock quantity
- Sales volume
- Date added
- City

## Key Analysis Areas

### 1. Exploratory Data Analysis
The notebook workflow explores:
- Sales distribution by category
- Top-performing products and categories
- Rating behavior and review volume
- Inventory health indicators

### 2. Rating Enrichment
A Bayesian weighted rating approach is used to smooth raw ratings and reduce the impact of low-review products.

### 3. Inventory and Stockout Risk
The analysis estimates a daily sales rate and calculates how many days of stock remain, flagging critical risk items.

### 4. SQL Insights
The SQL scripts investigate:
- Top products per category
- Products with high sales but poor ratings
- Hidden gems with strong ratings but low sales
- Stockout warning logic

## Getting Started

### Prerequisites
Make sure you have Python installed. This project was developed using a virtual environment.

### Create and activate the environment
On Windows PowerShell:
```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
```

### Install dependencies
```bash
pip install pandas numpy matplotlib seaborn skimpy jupyter
```

### Run the notebooks
```bash
jupyter notebook
```
Then open the notebook in the notebooks/ folder.

## Usage

1. Open notebooks/01_EDA.ipynb to explore the main analysis.
2. Review the SQL scripts in sql/ for business-oriented queries.
3. Use the processed data in data/ for further analysis or reporting.

## Notes

- The data appears to be synthetic and is intended for demonstration and analytical learning.
- The analysis is designed to support product strategy, merchandising, and inventory planning decisions.

## License

This project is for educational and portfolio purposes.

# E-commerce Sales & Profitability Analysis

## Project Overview

This project analyzes 150K+ e-commerce orders to understand sales performance, profitability, discounts, returns, order status, payment methods, sales channels, customer segments, and marketing channels.

The analysis was performed using PostgreSQL, SQL, Power BI, and DAX.

## Tools Used

* PostgreSQL
* SQL
* Power BI
* DAX

## Dataset

The dataset contains 150K+ e-commerce order records.

Each row represents an individual order and includes information about:

* Order details
* Customer information
* Sales and profit
* Discounts
* Payment methods
* Returns
* Marketing channels
* Delivery information

The original CSV dataset is not included in this repository because of its file-size limit on GitHub.

## Key Analysis

The project focuses on:

* Monthly sales and profit trends
* Order status distribution
* Loss-making orders
* Return analysis
* Discount impact on profitability
* Payment method performance
* Sales channel performance
* Customer segment profitability
* Marketing channel profitability

## Key Findings

* The dataset contains more than 150K orders.
* 1,296 orders were identified as loss-making orders.
* Loss-making orders had a substantially higher average discount than profitable orders.
* Completed orders contributed the largest share of total profit among the order statuses.
* Sales and profitability were analyzed across different sales channels, customer segments, payment methods, and marketing channels.

## Power BI Dashboard

The Power BI dashboard was created to provide an interactive view of sales and profitability performance.

The dashboard includes:

* KPI cards for Net Sales, Total Profit, Total Orders, and Average Profit
* Monthly Sales vs Profit
* Order Status Distribution
* Loss Orders by Status
* Average Discount: Loss vs Profit
* Return Analysis
* Net Sales by Payment Method
* Sales vs Profit by Sales Channel
* Profit by Customer Segment
* Profit by Marketing Channel

## Project Files

* `ecommerce_analysis.sql` — SQL analysis and business queries
* `Ecommerce_Sales_Analysis.pbix` — Power BI dashboard
* `sales_data.csv` — Original dataset, stored locally because of GitHub file-size limitations

## Business Objective

The objective of this project is to use sales data to identify profitability patterns, understand potential areas of loss, and provide a business-oriented view of e-commerce performance.

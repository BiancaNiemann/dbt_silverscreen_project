# 🎬 Silver Screen Analytics Project

## 📖 Project Overview

As a BI Analyst for a major entertainment company, I was tasked with analyzing the performance of three newly acquired movie theaters in New Jersey, operating under the brand **Silver Screen**.

The company wanted to understand how profitable each theater is by comparing **monthly movie rental costs** with **revenue from ticket sales**, at a **per-movie, per-location** level.

---

## 🎯 Objectives

The final objective was to create a **monthly performance summary table** that includes:

- 🎞️ Movie details
- 📍 Location information
- 💸 Monthly rental cost of each movie
- 🎟️ Total ticket sales
- 📊 Revenue generated per movie per location

---

## 🗂️ Data Sources

The project used five data sources in csv format and with different structures:

| Table Name        | Description |
|------------------|-------------|
| `movie_catalogue` | Contains details about movies (e.g. `movie_id`, `title`, `genre`, `studio`) rented out in 2024 |
| `invoices`        | Contains monthly rental cost per movie per location |
| `nj_001`          | Location #1 transaction data |
| `nj_002`          | Location #2 daily ticket sales |
| `nj_003`          | Location #3 individual transactions (tickets, snacks, drinks, etc.) |

---

## 🏗️ Transformation Process (dbt & Snowflake)

The following steps were performed in dbt and executed on Snowflake:

### 1. **Clean the movie catalogue**
- Standardized column names and formats
- Check and removed nulls and duplicates
- Ensured data consistency across `movie_id`, `title`, and `genre`
- Replaced nulls for genre with 'Unknown'

### 2. **Normalize location data**
- Transformed each NJ location dataset into a consistent structure with:
  - `movie_id`, `tickets_sold`, `ticket_price`, `revenue`, `location_id`, `month`
- Created staging models for each location (`stg_nj_001`, `stg_nj_002`, `stg_nj_003`)
- Unified all locations into a single fact model (`union_nj_tables`)

### 3. **Aggregate rental costs**
- Cleaned and staged the `invoices` table
- Aggregated at a monthly level

### 4. **Final model**
- Created a final reporting model  
- Joined Invoice and movie details to the location sales tables
- Created a unique row id using dbt_utils (see packages.yml)
✅ `fct_movie_monthly_performance`  
Includes:
- `unique_row_id`
- `movie_id`
- `movie_title`
- `genre`
- `studio`
- `month`
- `location_id`
- `total_rental_cost`
- `total_tickets_sold`
- `total_revenue`
- `profit` # not 100% accurate as dont have all the costs, only the rental cost

---

## ✅ Custom dbt Tests & Macros

A custom macro was created to ensure **revenue is never negative**:

```sql
-- macros/revenue_non_negative.sql
{% test revenue_non_negative(model, column_name) %}
  SELECT *
  FROM {{ model }}
  WHERE {{ column_name }} < 0
{% endtest %}

````

A custom test was created to ensure **rental cost is never negative**:

```sql
-- tests/rental_cost_non_negative.sql
select month, total_rental_cost
from {{ ref("final_cost_revenue_table") }}
where total_rental_cost < 0

````
## 🧠 Insights & Usage

This project helps stakeholders understand the **financial performance** of each movie per theater location per month by combining revenue from ticket sales with rental costs.

Key use cases include:

- 📊 **Profitability Tracking**  
  Track monthly profitability per movie and location by comparing rental costs to revenue.

- 🏢 **Location Performance Comparison**  
  Identify which of the three NJ theaters is generating the most revenue or has the best cost-to-income ratio.

- 🎥 **Movie-Level Insights**  
  Evaluate which movie genres or studios are most profitable to inform future rental decisions.

- 📆 **Time-Based Trends**  
  Analyze revenue and rental costs across months to detect seasonality or performance spikes.

- 📉 **Operational Efficiency**  
  Understand underperforming locations or movies with high rental costs but low ticket sales.

---

## 🧰 Tools & Technologies

This project used the following technologies:

| Tool | Purpose |
|------|---------|
| **dbt (Data Build Tool)** | Data transformation, modeling, and testing |
| **Snowflake** | Cloud-based data warehouse to store and query data |
| **SQL** | Used in dbt models to transform and analyze data |
| **Git** | Version control for tracking model and test changes |
| **Tableau** *(optional)* | For creating dashboards to visualize revenue and rental trends |

## 🧪 Sample dbt Commands

To execute the project in dbt, use the following commands:

```bash
# Compile and run all models
dbt run

# Run all tests (including custom tests)
dbt test

# Optionally, check model dependencies
dbt deps

# Complete build in Snowflake
dbt build

```

## 🚀 Next Steps

Potential improvements and future enhancements for this project:

- 📊 **Build Visual Dashboards**  
  Use Tableau or Looker to create interactive dashboards that highlight key insights.

- 🍿 **Incorporate Concessions Sales**  
  Add snack and drink revenue from `nj_003` and ask 2 other locations for more detailed data, for a fuller picture of total earnings.

- 🎯 **ROI Analysis**  
  Calculate return on investment (ROI) per movie, studio, or genre to support purchasing decisions.

- ⏱️ **Trend Analysis**  
  Evaluate monthly and seasonal trends across locations and movie types.

---

## 👤 Author

**Bianca Niemann**  
BI Analyst | Data Analytics Bootcamp (Soon to be)Graduate

📧 payrollsollutions@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/bianca-niemann)
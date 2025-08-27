#  365 Super Mart Promotional Campaign Analysis

##  Project Overview
This project analyzes **365 Super Mart’s promotional campaigns** using **SQL (MySQL)**.  
365 Super Mart is a leading FMCG enterprise with a diverse product portfolio including **Grocery & Staples, Home Care, Personal Care, and Home Appliances**.  

Promotions are typically launched during major festivals (Eid ul Fitr, Shab-e-Baraat) and include **percentage discounts, Cashback, and BOGOF offers**.  
The goal of this project is to determine which promotions, categories, and store locations drive the most **incremental revenue and units sold**.

---

##  Objectives
- Assess whether discount campaigns generate measurable improvements in sales.  
- Identify **top-performing stores and cities** based on campaign results.  
- Compare the effectiveness of **different promotion types** (BOGOF, Cashback, %OFF).  
- Analyze **product categories** to understand which segments benefit most.  
- Provide **data-driven recommendations** for future campaigns.  

---

##  Tools & Technologies
- **SQL (MySQL)** – Data extraction and analysis    
- **Azure Data Studio** – Query execution environment  

---

##  Dataset
The analysis uses multiple relational tables:  
- `fact_events` → promotional campaign transactions  
- `dim_stores` → store details (IDs, cities)  
- `dim_products` → product details (categories, codes, names)  
- `dim_campaigns` → campaign metadata (IDs, types)  
- `cost_margin` → product cost margins  

---

##  Analysis & Queries

### Store-Level Analysis
- **Top Performing Stores by Incremental Revenue**  
- **Bottom Performing Stores by Incremental Units Sold**  
- **Average Incremental Revenue by City**  

### Promotion Analysis
- **Highest Incremental Revenue by Promotion Type**  
- **Lowest Incremental Units Sold by Promotion Type**  
- **Comparing Promotion Effectiveness (Discount vs Cashback vs BOGOF)**  
- **Profit Margin vs. Units Sold by Promotion Type**  

### Product & Category Analysis
- **Top Performing Categories (by Sales Lift)**  
- **Top & Bottom Performing Products (by Sales Lift)**  
- **Category and Promotion Effectiveness**  

---

##  Repository Contents
- `README.md` → Project overview & documentation  
- `queries.sql` → SQL queries used for analysis  
- `Project365Store.pdf` → Final presentation (insights + visuals)

---

##  Key Insights (Sample)
-  **Peshawar and Sialkot** showed the highest responsiveness to campaigns.  
-  **BOGOF and Cashback promotions** outperformed percentage discounts in revenue and units sold.  
-  **Grocery & Staples** benefited the most from targeted promotions.  
-  Certain products (e.g., Dishwashing Scrub Sponge) underperformed, suggesting the need for revised strategies.  

---

##  Deliverables
- SQL queries for all analyses (included in repository).  
- Power BI dashboard summarizing store, promotion, and category insights.  
- Business recommendations for campaign optimization.  

---

##  Future Work
- Extend analysis with **time-series trends** of campaigns.  
- Apply **A/B testing frameworks** for underperforming stores.  
- Integrate machine learning models for **promotion success prediction**.  
 
---

##  Author
-  **Zohair Raza**  
-  Data Analyst (SQL | Power BI | Excel) 



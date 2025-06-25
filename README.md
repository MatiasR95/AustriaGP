# 🏁 Austrian Grand Prix Analysis (2025)

## 🧠 Overview

This **SQL-driven project** analyzes **38 races at the Red Bull Ring** (1964, 1970–1987, 1997–2003, 2014–2024), comprising:

- **36 Austrian Grands Prix**
- **2 Styrian Grands Prix** (2020, 2021)

It delivers **historical performance** and **strategic insights** for the **2025 F1 season**.

Crafted for **F1 fans** and **data analysts**, the project includes:

- A **6-page Canva report** featuring top winners and constructors.
- **Hybrid-era filters** (2014–2024, ~13 races) for recent trend analysis.
- ~30 **practice queries** to strengthen intermediate and advanced SQL skills.

🎯 A perfect **portfolio project** to showcase analytical thinking and SQL expertise.

---

## 📂 Project Structure

### `sql/`
Contains all SQL queries.

### `Practice/`
~25–30 practice queries organized by subtopic:

- `filtering_formatting/`  
  *Queries using* `WHERE`, `CONCAT`, `FORMAT`  
  _Example:_ `p1_driver_nationalities.sql`

- `aggregations_joins/`  
  *Queries using* `GROUP BY`, `JOIN`, `HAVING`  
  _Example:_ `p6_constructor_points.sql`

- `ctes_window_functions/`  
  *Queries using* `WITH`, `RANK`, `LAG`  
  _Example:_ `p11_driver_rankings.sql`

- `statistical_advanced/`  
  *Queries using* `STDDEV`, `CORR`, `PERCENTILE_CONT`  
  _Example:_ `p16_points_variability.sql`

---

### `CanvaReportTasks/`
7 final queries for Canva visualizations:

- `h1_historical_winners.sql` – **Top 5 drivers by wins** (1964–2024)
- `h2_dominant_constructors.sql` – **Top 5 constructors by wins** (1964–2024)
- `h3_top_poles.sql` – **Top 5 pole-sitters** (2004–2024)
- `j1_overtaking_frequency.sql` – **Avg. position changes** (2014–2024)
- `j2_pole_to_win.sql` – **Pole-to-win rate** (2014–2024)
- `c1_points_probability.sql` & `c2_position_dynamics.sql` – **Points and position trends** (2014–2024)

---

### `docs/`
- `Austrian_GP_2025_Report.pdf`: Final Canva report  
- CSVs for charts (e.g., `top_5_winners.csv`, `points_probability.csv`)

---

## ⚙️ Usage

### ✅ Setup

- Clone the repo to:  
  `C:\Projects\AustriaGP\`

- Download the F1 dataset from Kaggle. Required tables:  
  `races`, `results`, `drivers`, `constructors`, `qualifying`, `pit_stops`, `lap_times`  
  (Use `circuitId = 70` for Red Bull Ring)

### 🛠️ Run Queries

- Use a SQL editor (e.g., **SQL Server**, **PostgreSQL**)
- Export CSVs with:  
  `COPY (SELECT ...) TO 'path.csv' WITH CSV HEADER` *(or equivalent)*

### 🧪 Practice Queries

- Run `P1–P20` to master:
  - `CONCAT`
  - `RANK`
  - `STDDEV`
  - And more

### 📊 Report Queries

- Run final queries to generate CSVs for Canva charts  
  _e.g._ `top_5_winners.csv` → Page 1 bar chart

---

## 📈 Canva Report

- Import CSVs into Canva
- Configure visualizations (bar, line, scorecard)
- Add insights from `docs/*.txt`  
  _e.g._ `Historical_Winners_Insight.txt`

**📄 View Full Report**:  
`docs/Austrian_GP_2025_Report.pdf`

---

## 📝 Notes

- Uses the **2010–present F1 scoring system**:  
  `P1=25`, `P2=18`, … `P10=1`, `+1` point for **fastest lap** since 2019
- The report starts with **historical metrics** (1964–2024)  
  then filters down to **hybrid-era** races (2014–2024)
- Includes **Styrian GPs (2020, 2021)** – both held at Red Bull Ring (`circuitId = 70`)
- Practice query files are **placeholders** – populate them as you advance
- All commits are on the **`austria-gp`** branch

---

## 👤 About Me

I’m passionate about **uncovering stories through data**, especially in the thrilling world of **Formula 1**! 🏎️

- 📌 [**My LinkedIn Profile**](http://www.linkedin.com/in/matias-rossi-95-data-strength)  
- 🌐 [**My Portfolio Website**](https://matirossi87mr.wixsite.com/matiasrossi-porfolio)

Let’s chat about **F1**, **data analysis**, or **collaborations** — I’d love to connect!

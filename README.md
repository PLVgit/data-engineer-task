# Data Engineer Task

## Overview

You are joining a team that maintains an internal data warehouse built with **dbt** and **BigQuery**. Your task is to design and implement a small data pipeline that demonstrates your understanding of dbt concepts, Python data processing, and testing.

## Your Task

Build a data pipeline that processes **employee project assignments** data using **Python** and **dbt**.

### Source Data

You are provided with two Excel files mocking exports from an HR system:

- `data/hr_employees_export.xlsx` - Employee master data
- `data/project_assignments_report.xlsx` - Project assignment records

Open the files and explore their structure before starting.

### Requirements

#### Part 1: Data Loading (Python)

Write a Python script that reads the Excel files and loads the data into your database (or outputs CSV files for dbt seeds). Follow good software engineering practices.

#### Part 2: Data Transformation (dbt)

Create a dbt project that produces a model called `project_staffing` with the following characteristics:

1. **Information required** (how you structure it is up to you):
   - Project code and name
   - Project lead - who is leading the project?
   - Team size - how many active employees are assigned?
   - Total weekly hours allocated (active employees only)

2. **Business rules to implement**:
   - Only include **active employees** in team size and hours aggregations
   - A project should appear in the output even if it has no active employees assigned
   - The source data contains inconsistencies that need to be cleaned (you decide where and how)

3. **Testing requirements**:
   - Add at least 2 meaningful dbt tests
   - Tests should validate data quality, not just column existence

4. **Documentation**:
   - Add column descriptions for your model in a `schema.yml` file

### Technical Setup

Use **Docker** to run the solution. You may choose your database for the project, viable options are: psql, clickhouse, duckdb.

Provide a `docker-compose.yml` (if needed) and clear instructions in a `README.md`.

Use **uv** for Python package management (preferred over pip or poetry).

### Deliverables

- A link to a **public git repository** with your solution, you may fork this one if you want
- The repository should contain at least one **merged pull request** demonstrating your git workflow
- A `README.md` with clear instructions on how to run the solution

### Evaluation Criteria

We will evaluate:

| Criteria | What we're looking for |
|----------|------------------------|
| **Correctness** | Does the output match the requirements? |
| **Python skills** | Is the extraction script clean and handles edge cases? |
| **dbt understanding** | Is the project well-structured? Appropriate use of models? |
| **Testing strategy** | Are the tests meaningful and well-chosen? |
| **Documentation** | Are columns documented? Is the README clear? |
| **Decision-making** | How did you handle ambiguous requirements? |

### AI Policy

We have no way to verify whether you used AI tools to complete this task - and frankly, we don't mind if you did. AI-assisted development is part of modern engineering.

However, during the technical interview, we will ask you to explain your decisions in detail: why you structured the models this way, why you chose certain tests, how you handled the data inconsistencies, and so on. What matters is that you **understand** the solution, not whether you wrote every line yourself.

### Questions?

If something is unclear, make a reasonable assumption and document it in your README. We will discuss your decisions during the interview.

---

**Good luck!**

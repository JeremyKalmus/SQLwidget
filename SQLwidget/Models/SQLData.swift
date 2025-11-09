//
//  SQLData.swift
//  SQLwidget
//
//  Created on 2025-11-09.
//

import Foundation

/// Contains all SQL reference content organized into searchable sections
struct SQLData {
    static let allSections: [SQLSection] = [
        // MARK: - 1. Query Execution Order
        SQLSection(
            title: "Query Execution Order",
            description: "Understanding how SQL executes queries vs. how we write them",
            examples: [
                SQLExample(
                    code: """
                    -- Writing Order:
                    SELECT column1, column2
                    FROM table_name
                    WHERE condition
                    GROUP BY column1
                    HAVING aggregate_condition
                    ORDER BY column1
                    LIMIT 10;

                    -- Execution Order:
                    -- 1. FROM - Get data from tables
                    -- 2. WHERE - Filter rows
                    -- 3. GROUP BY - Group rows
                    -- 4. HAVING - Filter groups
                    -- 5. SELECT - Choose columns
                    -- 6. ORDER BY - Sort results
                    -- 7. LIMIT - Limit results
                    """,
                    explanation: "Key insight: SELECT aliases cannot be used in WHERE because WHERE executes before SELECT"
                )
            ],
            keywords: ["execution", "order", "from", "where", "group by", "having", "select", "order by", "limit"]
        ),

        // MARK: - 2. Basic Queries
        SQLSection(
            title: "Basic Queries",
            description: "Fundamental SELECT statements and aliases",
            examples: [
                SQLExample(
                    code: """
                    -- Simple SELECT
                    SELECT column1, column2, column3
                    FROM table_name;
                    """,
                    explanation: "Basic column selection"
                ),
                SQLExample(
                    code: """
                    -- Column aliases
                    SELECT
                        first_name AS fname,
                        last_name AS lname,
                        salary * 12 AS annual_salary
                    FROM employees;
                    """,
                    explanation: "Rename columns in output using AS"
                ),
                SQLExample(
                    code: """
                    -- Table aliases
                    SELECT e.name, d.department_name
                    FROM employees e
                    JOIN departments d ON e.dept_id = d.id;
                    """,
                    explanation: "Short aliases for tables make queries cleaner"
                ),
                SQLExample(
                    code: """
                    -- DISTINCT removes duplicates
                    SELECT DISTINCT country
                    FROM customers;
                    """,
                    explanation: "Get unique values only"
                )
            ],
            keywords: ["select", "from", "distinct", "alias", "as", "column", "table", "basic"]
        ),

        // MARK: - 3. Filtering (WHERE)
        SQLSection(
            title: "Filtering (WHERE Clause)",
            description: "Filter rows with conditions",
            examples: [
                SQLExample(
                    code: """
                    -- Comparison operators
                    SELECT * FROM products
                    WHERE price > 100;

                    SELECT * FROM orders
                    WHERE order_date >= '2024-01-01';
                    """,
                    explanation: "Use =, !=, >, <, >=, <="
                ),
                SQLExample(
                    code: """
                    -- BETWEEN for ranges
                    SELECT * FROM products
                    WHERE price BETWEEN 50 AND 100;
                    """,
                    explanation: "Inclusive range (50 to 100)"
                ),
                SQLExample(
                    code: """
                    -- IN for multiple values
                    SELECT * FROM customers
                    WHERE country IN ('USA', 'Canada', 'Mexico');
                    """,
                    explanation: "Match any value in the list"
                ),
                SQLExample(
                    code: """
                    -- LIKE for pattern matching
                    SELECT * FROM customers
                    WHERE name LIKE 'John%';  -- Starts with John

                    SELECT * FROM products
                    WHERE sku LIKE '%_XL_%';  -- Contains _XL_
                    """,
                    explanation: "% = any characters, _ = single character"
                ),
                SQLExample(
                    code: """
                    -- NULL handling
                    SELECT * FROM employees
                    WHERE manager_id IS NULL;

                    SELECT * FROM products
                    WHERE description IS NOT NULL;
                    """,
                    explanation: "Must use IS NULL, not = NULL"
                ),
                SQLExample(
                    code: """
                    -- Logical operators
                    SELECT * FROM products
                    WHERE (category = 'Electronics' AND price < 500)
                       OR (category = 'Books' AND in_stock = true);
                    """,
                    explanation: "Combine conditions with AND, OR, NOT"
                )
            ],
            keywords: ["where", "filter", "comparison", "between", "in", "like", "null", "is null", "and", "or", "not", "pattern"]
        ),

        // MARK: - 4. Joins
        SQLSection(
            title: "Joining Tables",
            description: "Combine data from multiple tables",
            examples: [
                SQLExample(
                    code: """
                    -- INNER JOIN (matching rows only)
                    SELECT e.name, d.department_name
                    FROM employees e
                    INNER JOIN departments d ON e.dept_id = d.id;
                    """,
                    explanation: "Returns only rows where match exists in both tables"
                ),
                SQLExample(
                    code: """
                    -- LEFT JOIN (all from left, matching from right)
                    SELECT c.name, o.order_id
                    FROM customers c
                    LEFT JOIN orders o ON c.id = o.customer_id;
                    """,
                    explanation: "All customers, even those with no orders (NULLs for orders)"
                ),
                SQLExample(
                    code: """
                    -- RIGHT JOIN (all from right, matching from left)
                    SELECT c.name, o.order_id
                    FROM customers c
                    RIGHT JOIN orders o ON c.id = o.customer_id;
                    """,
                    explanation: "All orders, even if customer info is missing"
                ),
                SQLExample(
                    code: """
                    -- FULL OUTER JOIN (all rows from both)
                    SELECT c.name, o.order_id
                    FROM customers c
                    FULL OUTER JOIN orders o ON c.id = o.customer_id;
                    """,
                    explanation: "All customers AND all orders, with NULLs where no match"
                ),
                SQLExample(
                    code: """
                    -- Multiple joins
                    SELECT
                        o.order_id,
                        c.customer_name,
                        p.product_name,
                        od.quantity
                    FROM orders o
                    JOIN customers c ON o.customer_id = c.id
                    JOIN order_details od ON o.id = od.order_id
                    JOIN products p ON od.product_id = p.id;
                    """,
                    explanation: "Chain multiple joins together"
                ),
                SQLExample(
                    code: """
                    -- Self join (hierarchical data)
                    SELECT
                        e.name AS employee,
                        m.name AS manager
                    FROM employees e
                    LEFT JOIN employees m ON e.manager_id = m.id;
                    """,
                    explanation: "Join table to itself to find relationships"
                )
            ],
            keywords: ["join", "inner join", "left join", "right join", "full outer join", "self join", "on", "multiple join"]
        ),

        // MARK: - 5. Aggregates
        SQLSection(
            title: "Aggregate Functions",
            description: "Summarize data with COUNT, SUM, AVG, etc.",
            examples: [
                SQLExample(
                    code: """
                    -- Basic aggregates
                    SELECT
                        COUNT(*) AS total_orders,
                        COUNT(DISTINCT customer_id) AS unique_customers,
                        SUM(amount) AS total_revenue,
                        AVG(amount) AS avg_order_value,
                        MIN(amount) AS min_order,
                        MAX(amount) AS max_order
                    FROM orders;
                    """,
                    explanation: "Aggregate entire table"
                ),
                SQLExample(
                    code: """
                    -- GROUP BY (group rows for aggregation)
                    SELECT
                        category,
                        COUNT(*) AS product_count,
                        AVG(price) AS avg_price
                    FROM products
                    GROUP BY category;
                    """,
                    explanation: "Calculate aggregates per group"
                ),
                SQLExample(
                    code: """
                    -- Multiple GROUP BY columns
                    SELECT
                        category,
                        brand,
                        COUNT(*) AS count,
                        AVG(price) AS avg_price
                    FROM products
                    GROUP BY category, brand
                    ORDER BY category, brand;
                    """,
                    explanation: "Group by multiple columns"
                ),
                SQLExample(
                    code: """
                    -- HAVING (filter aggregates)
                    SELECT
                        customer_id,
                        COUNT(*) AS order_count,
                        SUM(amount) AS total_spent
                    FROM orders
                    GROUP BY customer_id
                    HAVING COUNT(*) >= 5 AND SUM(amount) > 1000;
                    """,
                    explanation: "WHERE filters rows, HAVING filters groups"
                )
            ],
            keywords: ["aggregate", "count", "sum", "avg", "average", "min", "max", "group by", "having", "distinct"]
        ),

        // MARK: - 6. Window Functions
        SQLSection(
            title: "Window Functions",
            description: "Perform calculations across sets of rows",
            examples: [
                SQLExample(
                    code: """
                    -- Basic window function syntax
                    SELECT
                        name,
                        department,
                        salary,
                        AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
                    FROM employees;
                    """,
                    explanation: "Calculate aggregates without collapsing rows"
                ),
                SQLExample(
                    code: """
                    -- ROW_NUMBER (unique row number)
                    SELECT
                        ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
                        name,
                        salary
                    FROM employees;
                    """,
                    explanation: "Assign unique sequential numbers"
                ),
                SQLExample(
                    code: """
                    -- RANK and DENSE_RANK
                    SELECT
                        name,
                        score,
                        RANK() OVER (ORDER BY score DESC) AS rank,
                        DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank
                    FROM test_scores;
                    """,
                    explanation: "RANK skips numbers after ties, DENSE_RANK doesn't"
                ),
                SQLExample(
                    code: """
                    -- NTILE (divide into buckets)
                    SELECT
                        name,
                        salary,
                        NTILE(4) OVER (ORDER BY salary) AS quartile
                    FROM employees;
                    """,
                    explanation: "Split data into N equal groups"
                ),
                SQLExample(
                    code: """
                    -- LAG and LEAD (previous/next row values)
                    SELECT
                        order_date,
                        revenue,
                        LAG(revenue) OVER (ORDER BY order_date) AS prev_day_revenue,
                        LEAD(revenue) OVER (ORDER BY order_date) AS next_day_revenue
                    FROM daily_sales;
                    """,
                    explanation: "Access values from other rows"
                ),
                SQLExample(
                    code: """
                    -- Running total
                    SELECT
                        order_date,
                        amount,
                        SUM(amount) OVER (
                            ORDER BY order_date
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                        ) AS running_total
                    FROM orders;
                    """,
                    explanation: "Cumulative sum over ordered rows"
                ),
                SQLExample(
                    code: """
                    -- Moving average (last 7 days)
                    SELECT
                        date,
                        sales,
                        AVG(sales) OVER (
                            ORDER BY date
                            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                        ) AS moving_avg_7day
                    FROM daily_sales;
                    """,
                    explanation: "Average over sliding window"
                )
            ],
            keywords: ["window", "over", "partition by", "row_number", "rank", "dense_rank", "ntile", "lag", "lead", "first_value", "last_value", "running total", "moving average"]
        ),

        // MARK: - 7. Date Functions
        SQLSection(
            title: "Date Functions",
            description: "Work with dates and timestamps",
            examples: [
                SQLExample(
                    code: """
                    -- Current date/time
                    SELECT
                        CURRENT_DATE AS today,
                        CURRENT_TIMESTAMP AS now,
                        NOW() AS now_alt;  -- MySQL/PostgreSQL
                    """,
                    explanation: "Get current date and time"
                ),
                SQLExample(
                    code: """
                    -- Date arithmetic (PostgreSQL/MySQL)
                    SELECT
                        order_date,
                        order_date + INTERVAL '7 days' AS plus_7_days,
                        order_date - INTERVAL '1 month' AS minus_1_month
                    FROM orders;
                    """,
                    explanation: "Add or subtract time periods"
                ),
                SQLExample(
                    code: """
                    -- Date difference
                    SELECT
                        order_date,
                        DATEDIFF(CURRENT_DATE, order_date) AS days_ago  -- MySQL
                    FROM orders;

                    -- PostgreSQL version:
                    SELECT
                        order_date,
                        CURRENT_DATE - order_date AS days_ago
                    FROM orders;
                    """,
                    explanation: "Calculate days between dates"
                ),
                SQLExample(
                    code: """
                    -- Extract date parts
                    SELECT
                        order_date,
                        YEAR(order_date) AS year,
                        MONTH(order_date) AS month,
                        DAY(order_date) AS day,
                        QUARTER(order_date) AS quarter,
                        DAYOFWEEK(order_date) AS day_of_week
                    FROM orders;
                    """,
                    explanation: "Get individual date components"
                ),
                SQLExample(
                    code: """
                    -- Date formatting
                    SELECT
                        order_date,
                        DATE_FORMAT(order_date, '%Y-%m-%d') AS formatted,  -- MySQL
                        TO_CHAR(order_date, 'YYYY-MM-DD') AS formatted     -- PostgreSQL
                    FROM orders;
                    """,
                    explanation: "Format dates as strings"
                )
            ],
            keywords: ["date", "time", "timestamp", "current_date", "now", "interval", "datediff", "year", "month", "day", "quarter", "date_format", "dateadd", "datesub"]
        ),

        // MARK: - 8. String Functions
        SQLSection(
            title: "String Functions",
            description: "Manipulate text data",
            examples: [
                SQLExample(
                    code: """
                    -- Case conversion
                    SELECT
                        UPPER(name) AS uppercase,
                        LOWER(name) AS lowercase,
                        INITCAP(name) AS title_case  -- PostgreSQL
                    FROM customers;
                    """,
                    explanation: "Change text case"
                ),
                SQLExample(
                    code: """
                    -- Substring operations
                    SELECT
                        SUBSTRING(name, 1, 5) AS first_5_chars,
                        LEFT(name, 3) AS left_3,
                        RIGHT(name, 3) AS right_3
                    FROM products;
                    """,
                    explanation: "Extract parts of strings"
                ),
                SQLExample(
                    code: """
                    -- String concatenation
                    SELECT
                        CONCAT(first_name, ' ', last_name) AS full_name,
                        first_name || ' ' || last_name AS full_name_alt  -- PostgreSQL
                    FROM employees;
                    """,
                    explanation: "Combine strings together"
                ),
                SQLExample(
                    code: """
                    -- Trimming whitespace
                    SELECT
                        TRIM(name) AS trimmed,
                        LTRIM(name) AS left_trimmed,
                        RTRIM(name) AS right_trimmed
                    FROM products;
                    """,
                    explanation: "Remove leading/trailing spaces"
                ),
                SQLExample(
                    code: """
                    -- Replace and find
                    SELECT
                        REPLACE(description, 'old', 'new') AS replaced,
                        POSITION('word' IN description) AS position,  -- PostgreSQL
                        LENGTH(description) AS length
                    FROM products;
                    """,
                    explanation: "Search and modify strings"
                )
            ],
            keywords: ["string", "text", "upper", "lower", "substring", "concat", "trim", "ltrim", "rtrim", "replace", "position", "length", "left", "right"]
        ),

        // MARK: - 9. Math Functions
        SQLSection(
            title: "Mathematical Functions",
            description: "Perform calculations and rounding",
            examples: [
                SQLExample(
                    code: """
                    -- Basic arithmetic
                    SELECT
                        price * quantity AS total,
                        price * 1.1 AS price_with_tax,
                        revenue / 100 AS revenue_hundreds,
                        total % 10 AS remainder
                    FROM orders;
                    """,
                    explanation: "Use +, -, *, /, % operators"
                ),
                SQLExample(
                    code: """
                    -- Rounding functions
                    SELECT
                        price,
                        ROUND(price, 2) AS rounded_2_decimals,
                        CEIL(price) AS rounded_up,
                        FLOOR(price) AS rounded_down,
                        TRUNCATE(price, 1) AS truncated  -- MySQL
                    FROM products;
                    """,
                    explanation: "Different ways to round numbers"
                ),
                SQLExample(
                    code: """
                    -- Other math functions
                    SELECT
                        ABS(profit) AS absolute_value,
                        POWER(2, 3) AS two_cubed,
                        SQRT(area) AS square_root,
                        MOD(value, 10) AS modulo
                    FROM calculations;
                    """,
                    explanation: "Common mathematical operations"
                )
            ],
            keywords: ["math", "arithmetic", "round", "ceil", "floor", "truncate", "abs", "power", "sqrt", "mod", "modulo"]
        ),

        // MARK: - 10. Conditional Logic
        SQLSection(
            title: "Conditional Logic",
            description: "IF-THEN logic in SQL",
            examples: [
                SQLExample(
                    code: """
                    -- Simple CASE statement
                    SELECT
                        name,
                        price,
                        CASE
                            WHEN price < 10 THEN 'Cheap'
                            WHEN price < 50 THEN 'Moderate'
                            ELSE 'Expensive'
                        END AS price_category
                    FROM products;
                    """,
                    explanation: "Create categories based on conditions"
                ),
                SQLExample(
                    code: """
                    -- CASE with multiple conditions
                    SELECT
                        name,
                        CASE
                            WHEN category = 'Electronics' AND price > 1000 THEN 'Premium'
                            WHEN category = 'Electronics' THEN 'Standard'
                            WHEN in_stock = false THEN 'Out of Stock'
                            ELSE 'Available'
                        END AS status
                    FROM products;
                    """,
                    explanation: "Complex conditional logic"
                ),
                SQLExample(
                    code: """
                    -- COALESCE (return first non-NULL value)
                    SELECT
                        name,
                        COALESCE(phone, mobile, email, 'No contact') AS contact_info
                    FROM customers;
                    """,
                    explanation: "Handle NULL values with fallbacks"
                ),
                SQLExample(
                    code: """
                    -- NULLIF (return NULL if equal)
                    SELECT
                        revenue,
                        cost,
                        revenue / NULLIF(cost, 0) AS profit_margin
                    FROM products;
                    """,
                    explanation: "Avoid division by zero errors"
                ),
                SQLExample(
                    code: """
                    -- IIF (SQL Server inline if)
                    SELECT
                        name,
                        IIF(in_stock = true, 'Available', 'Sold Out') AS availability
                    FROM products;
                    """,
                    explanation: "Simple if-then-else (SQL Server only)"
                )
            ],
            keywords: ["case", "when", "then", "else", "end", "coalesce", "nullif", "iif", "conditional", "if"]
        ),

        // MARK: - 11. Subqueries
        SQLSection(
            title: "Subqueries",
            description: "Nested queries for complex logic",
            examples: [
                SQLExample(
                    code: """
                    -- Subquery in SELECT
                    SELECT
                        name,
                        price,
                        (SELECT AVG(price) FROM products) AS avg_price
                    FROM products;
                    """,
                    explanation: "Calculate value for each row"
                ),
                SQLExample(
                    code: """
                    -- Subquery in FROM (derived table)
                    SELECT
                        category,
                        avg_price
                    FROM (
                        SELECT
                            category,
                            AVG(price) AS avg_price
                        FROM products
                        GROUP BY category
                    ) AS category_stats
                    WHERE avg_price > 50;
                    """,
                    explanation: "Treat subquery result as a table"
                ),
                SQLExample(
                    code: """
                    -- Subquery with IN
                    SELECT name, price
                    FROM products
                    WHERE category_id IN (
                        SELECT id
                        FROM categories
                        WHERE name LIKE '%Electronics%'
                    );
                    """,
                    explanation: "Filter based on list from subquery"
                ),
                SQLExample(
                    code: """
                    -- Subquery with EXISTS
                    SELECT c.name
                    FROM customers c
                    WHERE EXISTS (
                        SELECT 1
                        FROM orders o
                        WHERE o.customer_id = c.id
                          AND o.order_date > '2024-01-01'
                    );
                    """,
                    explanation: "Check if related records exist (often faster than IN)"
                ),
                SQLExample(
                    code: """
                    -- Correlated subquery
                    SELECT
                        name,
                        salary,
                        (SELECT AVG(salary)
                         FROM employees e2
                         WHERE e2.department = e1.department) AS dept_avg
                    FROM employees e1;
                    """,
                    explanation: "Subquery references outer query"
                )
            ],
            keywords: ["subquery", "nested", "in", "exists", "any", "all", "correlated", "derived table"]
        ),

        // MARK: - 12. CTEs
        SQLSection(
            title: "Common Table Expressions (CTEs)",
            description: "Named temporary result sets",
            examples: [
                SQLExample(
                    code: """
                    -- Single CTE
                    WITH high_value_customers AS (
                        SELECT
                            customer_id,
                            SUM(amount) AS total_spent
                        FROM orders
                        GROUP BY customer_id
                        HAVING SUM(amount) > 10000
                    )
                    SELECT
                        c.name,
                        hvc.total_spent
                    FROM high_value_customers hvc
                    JOIN customers c ON hvc.customer_id = c.id;
                    """,
                    explanation: "Create reusable named query"
                ),
                SQLExample(
                    code: """
                    -- Multiple CTEs
                    WITH
                    monthly_sales AS (
                        SELECT
                            DATE_TRUNC('month', order_date) AS month,
                            SUM(amount) AS revenue
                        FROM orders
                        GROUP BY DATE_TRUNC('month', order_date)
                    ),
                    monthly_costs AS (
                        SELECT
                            DATE_TRUNC('month', expense_date) AS month,
                            SUM(amount) AS costs
                        FROM expenses
                        GROUP BY DATE_TRUNC('month', expense_date)
                    )
                    SELECT
                        s.month,
                        s.revenue,
                        c.costs,
                        s.revenue - c.costs AS profit
                    FROM monthly_sales s
                    JOIN monthly_costs c ON s.month = c.month;
                    """,
                    explanation: "Chain multiple CTEs together"
                ),
                SQLExample(
                    code: """
                    -- Recursive CTE (organizational hierarchy)
                    WITH RECURSIVE employee_hierarchy AS (
                        -- Base case: top-level employees
                        SELECT
                            id,
                            name,
                            manager_id,
                            0 AS level
                        FROM employees
                        WHERE manager_id IS NULL

                        UNION ALL

                        -- Recursive case: employees with managers
                        SELECT
                            e.id,
                            e.name,
                            e.manager_id,
                            eh.level + 1
                        FROM employees e
                        JOIN employee_hierarchy eh ON e.manager_id = eh.id
                    )
                    SELECT * FROM employee_hierarchy
                    ORDER BY level, name;
                    """,
                    explanation: "Traverse hierarchical data structures"
                )
            ],
            keywords: ["cte", "with", "common table expression", "recursive", "hierarchy"]
        ),

        // MARK: - 13. Set Operations
        SQLSection(
            title: "Set Operations",
            description: "Combine results from multiple queries",
            examples: [
                SQLExample(
                    code: """
                    -- UNION (removes duplicates)
                    SELECT name, email FROM customers
                    UNION
                    SELECT name, email FROM prospects;
                    """,
                    explanation: "Combine and deduplicate results"
                ),
                SQLExample(
                    code: """
                    -- UNION ALL (keeps duplicates - faster)
                    SELECT product_id FROM online_orders
                    UNION ALL
                    SELECT product_id FROM in_store_orders;
                    """,
                    explanation: "Combine without removing duplicates"
                ),
                SQLExample(
                    code: """
                    -- INTERSECT (common rows)
                    SELECT customer_id FROM orders_2023
                    INTERSECT
                    SELECT customer_id FROM orders_2024;
                    """,
                    explanation: "Find customers who ordered in both years"
                ),
                SQLExample(
                    code: """
                    -- EXCEPT (difference)
                    SELECT customer_id FROM all_customers
                    EXCEPT
                    SELECT customer_id FROM churned_customers;
                    """,
                    explanation: "Find active customers (not in churned list)"
                )
            ],
            keywords: ["union", "union all", "intersect", "except", "minus", "set", "combine"]
        ),

        // MARK: - 14. Data Modification
        SQLSection(
            title: "Data Modification",
            description: "INSERT, UPDATE, DELETE statements",
            examples: [
                SQLExample(
                    code: """
                    -- INSERT single row
                    INSERT INTO customers (name, email, country)
                    VALUES ('John Doe', 'john@example.com', 'USA');
                    """,
                    explanation: "Add one row"
                ),
                SQLExample(
                    code: """
                    -- INSERT multiple rows
                    INSERT INTO products (name, price, category)
                    VALUES
                        ('Product A', 19.99, 'Electronics'),
                        ('Product B', 29.99, 'Electronics'),
                        ('Product C', 9.99, 'Books');
                    """,
                    explanation: "Add multiple rows at once"
                ),
                SQLExample(
                    code: """
                    -- INSERT from SELECT
                    INSERT INTO archive_orders (order_id, customer_id, amount)
                    SELECT id, customer_id, amount
                    FROM orders
                    WHERE order_date < '2023-01-01';
                    """,
                    explanation: "Copy data from another table"
                ),
                SQLExample(
                    code: """
                    -- UPDATE with WHERE
                    UPDATE products
                    SET price = price * 1.1,
                        updated_at = CURRENT_TIMESTAMP
                    WHERE category = 'Electronics';
                    """,
                    explanation: "Modify existing rows (always use WHERE!)"
                ),
                SQLExample(
                    code: """
                    -- DELETE with WHERE
                    DELETE FROM orders
                    WHERE status = 'cancelled'
                      AND order_date < '2023-01-01';
                    """,
                    explanation: "Remove rows (always use WHERE!)"
                )
            ],
            keywords: ["insert", "update", "delete", "values", "set", "into", "modify", "add", "remove"]
        ),

        // MARK: - 15. Common Calculations
        SQLSection(
            title: "Common Calculations",
            description: "Frequently used business metrics",
            examples: [
                SQLExample(
                    code: """
                    -- Year-over-year variance
                    WITH current_year AS (
                        SELECT SUM(revenue) AS revenue
                        FROM sales
                        WHERE YEAR(sale_date) = 2024
                    ),
                    previous_year AS (
                        SELECT SUM(revenue) AS revenue
                        FROM sales
                        WHERE YEAR(sale_date) = 2023
                    )
                    SELECT
                        (cy.revenue - py.revenue) / py.revenue * 100 AS yoy_growth_pct
                    FROM current_year cy, previous_year py;
                    """,
                    explanation: "Calculate year-over-year growth percentage"
                ),
                SQLExample(
                    code: """
                    -- Percent of total
                    SELECT
                        category,
                        revenue,
                        revenue / SUM(revenue) OVER () * 100 AS pct_of_total
                    FROM category_sales;
                    """,
                    explanation: "Calculate percentage contribution"
                ),
                SQLExample(
                    code: """
                    -- Running total by date
                    SELECT
                        sale_date,
                        daily_revenue,
                        SUM(daily_revenue) OVER (
                            ORDER BY sale_date
                        ) AS cumulative_revenue
                    FROM daily_sales;
                    """,
                    explanation: "Track cumulative revenue"
                ),
                SQLExample(
                    code: """
                    -- Moving average (7-day)
                    SELECT
                        date,
                        revenue,
                        AVG(revenue) OVER (
                            ORDER BY date
                            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
                        ) AS moving_avg_7day
                    FROM daily_revenue;
                    """,
                    explanation: "Smooth out daily fluctuations"
                ),
                SQLExample(
                    code: """
                    -- Percentile calculation
                    SELECT
                        name,
                        salary,
                        PERCENT_RANK() OVER (ORDER BY salary) * 100 AS percentile
                    FROM employees;
                    """,
                    explanation: "Find where value ranks in distribution"
                )
            ],
            keywords: ["yoy", "year over year", "variance", "percent", "percentage", "running total", "cumulative", "moving average", "percentile", "calculation"]
        ),

        // MARK: - 16. Performance Tips
        SQLSection(
            title: "Performance Tips",
            description: "Optimize query speed",
            examples: [
                SQLExample(
                    code: """
                    -- Use indexes on frequently joined/filtered columns
                    CREATE INDEX idx_orders_customer_id ON orders(customer_id);
                    CREATE INDEX idx_orders_date ON orders(order_date);
                    """,
                    explanation: "Speed up lookups and joins"
                ),
                SQLExample(
                    code: """
                    -- Filter early with WHERE before GROUP BY
                    -- GOOD:
                    SELECT category, COUNT(*)
                    FROM products
                    WHERE active = true  -- Filter first
                    GROUP BY category;

                    -- BAD:
                    SELECT category, COUNT(*)
                    FROM products
                    GROUP BY category
                    HAVING active = true;  -- Too late
                    """,
                    explanation: "Reduce rows before aggregation"
                ),
                SQLExample(
                    code: """
                    -- Select only needed columns
                    -- GOOD:
                    SELECT id, name, price FROM products;

                    -- BAD:
                    SELECT * FROM products;  -- Fetches all columns
                    """,
                    explanation: "Reduce data transfer and processing"
                ),
                SQLExample(
                    code: """
                    -- EXISTS vs IN for subqueries
                    -- GOOD (stops at first match):
                    SELECT name FROM customers c
                    WHERE EXISTS (
                        SELECT 1 FROM orders o
                        WHERE o.customer_id = c.id
                    );

                    -- SLOWER (builds full list):
                    SELECT name FROM customers
                    WHERE id IN (SELECT customer_id FROM orders);
                    """,
                    explanation: "EXISTS is often faster for large datasets"
                ),
                SQLExample(
                    code: """
                    -- UNION ALL vs UNION
                    -- GOOD (when duplicates ok):
                    SELECT id FROM table1
                    UNION ALL
                    SELECT id FROM table2;

                    -- SLOWER (removes duplicates):
                    SELECT id FROM table1
                    UNION
                    SELECT id FROM table2;
                    """,
                    explanation: "Skip deduplication if not needed"
                ),
                SQLExample(
                    code: """
                    -- Avoid functions on indexed columns in WHERE
                    -- BAD:
                    WHERE YEAR(order_date) = 2024

                    -- GOOD:
                    WHERE order_date >= '2024-01-01'
                      AND order_date < '2025-01-01'
                    """,
                    explanation: "Let database use indexes efficiently"
                )
            ],
            keywords: ["performance", "optimization", "index", "explain", "slow", "fast", "speed", "efficient", "exists", "in"]
        ),

        // MARK: - 17. Common Patterns
        SQLSection(
            title: "Common SQL Patterns",
            description: "Real-world query templates",
            examples: [
                SQLExample(
                    code: """
                    -- Get current year data only
                    SELECT *
                    FROM sales
                    WHERE order_date >= DATE_TRUNC('year', CURRENT_DATE);
                    """,
                    explanation: "Filter to current year dynamically"
                ),
                SQLExample(
                    code: """
                    -- Year-over-year comparison with CTE
                    WITH yearly_metrics AS (
                        SELECT
                            YEAR(order_date) AS year,
                            SUM(amount) AS revenue,
                            COUNT(*) AS order_count
                        FROM orders
                        GROUP BY YEAR(order_date)
                    )
                    SELECT
                        curr.year,
                        curr.revenue AS current_revenue,
                        prev.revenue AS previous_revenue,
                        (curr.revenue - prev.revenue) / prev.revenue * 100 AS growth_pct
                    FROM yearly_metrics curr
                    LEFT JOIN yearly_metrics prev ON curr.year = prev.year + 1;
                    """,
                    explanation: "Compare metrics across years"
                ),
                SQLExample(
                    code: """
                    -- Find first-time customers
                    WITH first_orders AS (
                        SELECT
                            customer_id,
                            MIN(order_date) AS first_order_date
                        FROM orders
                        GROUP BY customer_id
                    )
                    SELECT
                        DATE_TRUNC('month', first_order_date) AS month,
                        COUNT(*) AS new_customers
                    FROM first_orders
                    GROUP BY DATE_TRUNC('month', first_order_date)
                    ORDER BY month;
                    """,
                    explanation: "Track customer acquisition over time"
                ),
                SQLExample(
                    code: """
                    -- Cohort retention analysis
                    WITH cohorts AS (
                        SELECT
                            customer_id,
                            DATE_TRUNC('month', MIN(order_date)) AS cohort_month
                        FROM orders
                        GROUP BY customer_id
                    ),
                    cohort_activity AS (
                        SELECT
                            c.cohort_month,
                            DATE_TRUNC('month', o.order_date) AS activity_month,
                            COUNT(DISTINCT o.customer_id) AS active_customers
                        FROM cohorts c
                        JOIN orders o ON c.customer_id = o.customer_id
                        GROUP BY c.cohort_month, DATE_TRUNC('month', o.order_date)
                    )
                    SELECT
                        cohort_month,
                        activity_month,
                        active_customers,
                        EXTRACT(MONTH FROM AGE(activity_month, cohort_month)) AS months_since_first
                    FROM cohort_activity
                    ORDER BY cohort_month, activity_month;
                    """,
                    explanation: "Analyze customer retention by cohort"
                )
            ],
            keywords: ["pattern", "template", "example", "cohort", "retention", "first time", "current year", "yoy"]
        ),

        // MARK: - 18. Pro Tips
        SQLSection(
            title: "Pro Tips",
            description: "Best practices for writing SQL",
            examples: [
                SQLExample(
                    code: """
                    -- Always use table aliases in joins
                    -- GOOD:
                    SELECT
                        c.name,
                        o.order_date,
                        p.product_name
                    FROM customers c
                    JOIN orders o ON c.id = o.customer_id
                    JOIN products p ON o.product_id = p.id;

                    -- CONFUSING:
                    SELECT name, order_date, product_name
                    FROM customers
                    JOIN orders ON customers.id = orders.customer_id
                    JOIN products ON orders.product_id = products.id;
                    """,
                    explanation: "Makes queries clearer and easier to debug"
                ),
                SQLExample(
                    code: """
                    -- Format SQL for readability
                    SELECT
                        customer_id,
                        order_date,
                        SUM(amount) AS total_amount,
                        COUNT(*) AS order_count
                    FROM orders
                    WHERE order_date >= '2024-01-01'
                      AND status = 'completed'
                    GROUP BY
                        customer_id,
                        order_date
                    HAVING SUM(amount) > 100
                    ORDER BY total_amount DESC;
                    """,
                    explanation: "Proper indentation makes code maintainable"
                ),
                SQLExample(
                    code: """
                    -- Comment your complex logic
                    WITH monthly_revenue AS (
                        -- Calculate total revenue per month for active customers
                        SELECT
                            DATE_TRUNC('month', order_date) AS month,
                            SUM(amount) AS revenue
                        FROM orders
                        WHERE status = 'completed'  -- Exclude cancelled orders
                        GROUP BY DATE_TRUNC('month', order_date)
                    )
                    -- Compare each month to previous month
                    SELECT
                        month,
                        revenue,
                        LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue
                    FROM monthly_revenue;
                    """,
                    explanation: "Future you will thank present you"
                ),
                SQLExample(
                    code: """
                    -- Use CTEs for complex queries
                    -- Makes logic clearer and easier to test incrementally
                    WITH step1 AS (
                        SELECT ...
                    ),
                    step2 AS (
                        SELECT ... FROM step1
                    )
                    SELECT ... FROM step2;
                    """,
                    explanation: "Break complex logic into readable steps"
                ),
                SQLExample(
                    code: """
                    -- Be careful with data types in division
                    -- INTEGER DIVISION:
                    SELECT 5 / 2;  -- Returns 2 (not 2.5!)

                    -- DECIMAL DIVISION:
                    SELECT 5.0 / 2;  -- Returns 2.5
                    SELECT CAST(5 AS DECIMAL) / 2;  -- Returns 2.5
                    """,
                    explanation: "Always check data types for calculations"
                ),
                SQLExample(
                    code: """
                    -- Check for NULLs in calculations
                    -- NULL propagates through calculations:
                    SELECT 10 + NULL;  -- Returns NULL

                    -- Use COALESCE to handle NULLs:
                    SELECT 10 + COALESCE(maybe_null_column, 0);
                    """,
                    explanation: "NULLs can cause unexpected results"
                )
            ],
            keywords: ["tip", "best practice", "formatting", "comment", "alias", "null", "division", "decimal", "readability"]
        )
    ]
}

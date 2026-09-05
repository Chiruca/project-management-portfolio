-- Renombramos algunas columnas (employee_id y department_id)
ALTER TABLE head_shots
RENAME COLUMN Employee_ID TO employee_ID;
-- --------------

-- Unimos las tablas de proyectos con la información que necesitaremos
WITH project_status AS (
    SELECT 
        project_id,
        project_name,
        project_budget,
        project_start_date,
        project_end_date,
        'upcoming' AS status
    FROM `upcoming projects`
    UNION ALL
    SELECT 
        project_id,
        project_name,
        project_budget,
        project_start_date,
        project_end_date,
        'completed' AS status
    FROM completed_projects
)

SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_title,
    e.salary,
    d.Department_Name,
    d.Department_Budget,
    d.Department_Goals,
    p.project_id,
    p.project_name,
    p.project_budget,
    p.status,
    p.project_start_date,
    p.project_end_date
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_ID
JOIN project_assignments AS pa
    ON e.employee_id = pa.employee_id
JOIN project_status AS p
    ON pa.project_id = p.project_id
ORDER BY  p.status, p.project_start_date;
    

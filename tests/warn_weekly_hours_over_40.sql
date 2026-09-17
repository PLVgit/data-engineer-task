{{ config(severity='warn') }}

select
    assignments.employee_id,
    sum(assignments.weekly_hours) as total_weekly_hours
from {{ ref('stg_project_assignments') }} as assignments
inner join {{ ref('stg_hr_employees') }} as employees
    on assignments.employee_id = employees.employee_id
where employees.status = 'active'
group by assignments.employee_id
having sum(assignments.weekly_hours) > 40

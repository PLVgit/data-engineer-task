with assignments as (
    select * from {{ ref('stg_project_assignments') }}
),

employees as (
    select * from {{ ref('stg_hr_employees') }}
),

projects as (
    select
        project_code,
        min(project_name) as project_name
    from assignments
    group by project_code
),

lead_assignments as (
    select distinct
        project_code,
        employee_id
    from assignments
    where assignment_role = 'lead'
),

project_leads as (
    select
        leads.project_code,
        string_agg(
            trim(concat(employees.first_name, ' ', employees.last_name)),
            '; ' order by leads.employee_id
        ) as project_lead
    from lead_assignments as leads
    inner join employees
        on leads.employee_id = employees.employee_id
    group by leads.project_code
),

active_staffing as (
    select
        assignments.project_code,
        count(distinct case
            when employees.status = 'active' then assignments.employee_id
        end) as team_size,
        coalesce(sum(case
            when employees.status = 'active' then assignments.weekly_hours
            else 0
        end), 0) as total_weekly_hours
    from assignments
    inner join employees
        on assignments.employee_id = employees.employee_id
    group by assignments.project_code
)

select
    projects.project_code,
    projects.project_name,
    project_leads.project_lead,
    coalesce(active_staffing.team_size, 0) as team_size,
    coalesce(active_staffing.total_weekly_hours, 0) as total_weekly_hours
from projects
left join project_leads
    on projects.project_code = project_leads.project_code
left join active_staffing
    on projects.project_code = active_staffing.project_code


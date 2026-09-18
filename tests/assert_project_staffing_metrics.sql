with expected as (
    select
        assignments.project_code,
        count(distinct case
            when employees.status = 'active' then assignments.employee_id
        end) as team_size,
        coalesce(sum(case
            when employees.status = 'active' then assignments.weekly_hours
            else 0
        end), 0) as total_weekly_hours
    from {{ ref('stg_project_assignments') }} as assignments
    inner join {{ ref('stg_hr_employees') }} as employees
        on assignments.employee_id = employees.employee_id
    group by assignments.project_code
)

select
    staffing.project_code,
    staffing.team_size as actual_team_size,
    expected.team_size as expected_team_size,
    staffing.total_weekly_hours as actual_total_weekly_hours,
    expected.total_weekly_hours as expected_total_weekly_hours
from {{ ref('project_staffing') }} as staffing
inner join expected
    on staffing.project_code = expected.project_code
where staffing.team_size != expected.team_size
   or staffing.total_weekly_hours != expected.total_weekly_hours


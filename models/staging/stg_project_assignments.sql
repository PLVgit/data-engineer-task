with source as (
    select * from {{ source('raw', 'project_assignments') }}
)

select
    nullif(trim(assignment_id), '') as assignment_id,
    nullif(trim(employee_id), '') as employee_id,
    nullif(trim(project_code), '') as project_code,
    nullif(trim(project_name), '') as project_name,
    lower(nullif(trim(assignment_role), '')) as assignment_role,
    try_cast(nullif(trim(start_date), '') as date) as start_date,
    try_cast(nullif(trim(weekly_hours), '') as decimal(10, 2)) as weekly_hours,
    case lower(nullif(trim(billable_raw), ''))
        when 'y' then true
        when 'yes' then true
        when 'n' then false
        when 'no' then false
    end as is_billable,
    _source_file,
    _source_row_number,
    _source_snapshot_date
from source

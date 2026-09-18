with source as (
    select * from {{ source('raw', 'hr_employees') }}
)

select
    nullif(trim(employee_id), '') as employee_id,
    nullif(trim(first_name), '') as first_name,
    nullif(trim(last_name), '') as last_name,
    nullif(trim(email_address), '') as email_address,
    nullif(trim(department), '') as department,
    nullif(trim(job_title), '') as job_title,
    try_cast(nullif(trim(date_of_hire), '') as date) as date_of_hire,
    try_cast(nullif(trim(termination_date), '') as date) as termination_date,
    lower(nullif(trim(status), '')) as status,
    nullif(trim(reports_to_employee_id), '') as reports_to_employee_id,
    _source_file,
    _source_row_number,
    _source_snapshot_date
from source

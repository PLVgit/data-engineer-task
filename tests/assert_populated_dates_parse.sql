with date_values as (
    select
        raw._source_file,
        raw._source_row_number,
        'date_of_hire' as date_column,
        raw.date_of_hire as raw_date,
        staged.date_of_hire as parsed_date
    from {{ source('raw', 'hr_employees') }} as raw
    inner join {{ ref('stg_hr_employees') }} as staged
        using (_source_file, _source_row_number)

    union all

    select
        raw._source_file,
        raw._source_row_number,
        'termination_date' as date_column,
        raw.termination_date as raw_date,
        staged.termination_date as parsed_date
    from {{ source('raw', 'hr_employees') }} as raw
    inner join {{ ref('stg_hr_employees') }} as staged
        using (_source_file, _source_row_number)

    union all

    select
        raw._source_file,
        raw._source_row_number,
        'start_date' as date_column,
        raw.start_date as raw_date,
        staged.start_date as parsed_date
    from {{ source('raw', 'project_assignments') }} as raw
    inner join {{ ref('stg_project_assignments') }} as staged
        using (_source_file, _source_row_number)
)

select
    _source_file,
    _source_row_number,
    date_column,
    raw_date
from date_values
where nullif(trim(raw_date), '') is not null
    and parsed_date is null

select source_projects.project_code
from (
    select distinct project_code
    from {{ ref('stg_project_assignments') }}
) as source_projects
left join {{ ref('project_staffing') }} as staffing
    on source_projects.project_code = staffing.project_code
where staffing.project_code is null


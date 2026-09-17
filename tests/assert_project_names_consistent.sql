select
    project_code
from {{ ref('stg_project_assignments') }}
group by project_code
having count(distinct project_name) != 1


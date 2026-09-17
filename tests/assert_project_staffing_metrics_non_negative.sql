select
    project_code,
    team_size,
    total_weekly_hours
from {{ ref('project_staffing') }}
where team_size < 0
   or total_weekly_hours < 0


set
    search_path = sb_crm_schema;

-- Запрос подсчета очков с групировкой
SELECT
    year_game,
    SUM(points) as sum_points
FROM
    statistic
GROUP BY
    year_game;

-- Аналог запроса через CTE
WITH summer as (
    SELECT
        year_game,
        SUM(points) as sum_points
    FROM
        statistic
    GROUP BY
        year_game
)
select
    year_game,
    sum_points
from
    summer;

-- функция LAG подсчета за текущий год и предыдущий
SELECT
    year_game,
    player_name,
    points,
    LAG(points, 1) OVER (
        partition by player_id
        ORDER BY
            year_game
    ) prev_year_points
FROM
    statistic ORDER BY year_game;
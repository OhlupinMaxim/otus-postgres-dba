set
    search_path = sb_crm_schema;

-- Запрос подсчета очков с групировкой
SELECT
    year_game,
    SUM(points) as sum_points
FROM
    statistic
GROUP BY
    year_game
ORDER BY year_game;

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
SELECT
    year_game,
    sum_points
FROM
    summer
ORDER BY year_game;

-- функция LAG подсчета за текущий год и предыдущий
SELECT
    year_game,
    player_name,
    points,
    LAG(points, 1) OVER (
        PARTITION BY player_id
        ORDER BY
            year_game
    ) prev_year_points
FROM
    statistic ORDER BY year_game;
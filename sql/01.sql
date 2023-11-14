SELECT
    clie_codigo,
    clie_razon_social
FROM
    [dbo].[Cliente]
WHERE
    clie_limite_credito >= 1000
ORDER BY
    1
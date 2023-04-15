SELECT
DISTINCT
f.cidade_do_usuario,
f.estado_do_usuario,
e.regiao,
{{ dbt_utils.generate_surrogate_key(['f.cidade_do_usuario', 'f.estado_do_usuario']) }} AS id

FROM 
{{ref('case_completo')}} AS f

LEFT JOIN {{ ref("estados")}} AS e
ON f.estado_do_usuario = e.uf



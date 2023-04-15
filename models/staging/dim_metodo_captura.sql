-- depends_on: {{ ref('metodo_captura') }}
{% set metodos_captura = dbt_utils.get_column_values(table=ref('case_completo'), column='metodo_de_captura') %}


{% for metodo_captura in metodos_captura %}
SELECT
  base.id,
  base.metodo_de_captura,
  COALESCE(m.descricao, "Método sem descrição") AS descricao
FROM (
    SELECT 
    "{{ loop.index }}" AS id,
    "{{ metodo_captura }}" AS metodo_de_captura) AS base

    LEFT JOIN {{ ref('metodo_captura')}} AS m
       ON base.metodo_de_captura = m.metodo_de_captura
    {{ "UNION ALL" if not loop.last }}
{% endfor %}
ORDER BY 1
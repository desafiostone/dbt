{% macro valores_multiplas_colunas(nomes_colunas, fonte) %}
{% set results_list = [] %}
{% set query_fonte %}

SELECT DISTINCT
{% for nome_coluna in nomes_colunas %} 
    {{ nome_coluna }}
    {{ "," if not loop.last }} 
{% endfor %}
FROM {{ fonte }}
ORDER BY 1

{% endset %}

{% set results = run_query(query_fonte) %}

{% if execute %}
    {{ results_list.append( results.columns[1].values()) }}

{% else %}
    {% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}




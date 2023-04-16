{% set bandeiras_cartao = dbt_utils.get_column_values(table=ref('case_completo'), column='bandeira_do_cartao') %}
 
{% for bandeira_cartao in bandeiras_cartao %}
    SELECT 
    CASE "{{ bandeira_cartao }}"
        WHEN "None" THEN -1
        ELSE
    {{ loop.index }} END AS id,
    "{{ bandeira_cartao }}" AS bandeira_do_cartao,
    CASE "{{ bandeira_cartao }}"
        WHEN "None" THEN "Bandeira não informada"
        ELSE 
    "Bandeira {{ bandeira_cartao }}" END AS descricao
    {{ "UNION ALL" if not loop.last }}
{% endfor %}
ORDER BY 1
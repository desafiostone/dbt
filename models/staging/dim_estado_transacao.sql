-- depends_on: {{ ref('estado_transacao') }}
{% set estados_transacao = dbt_utils.get_column_values(table=ref('case_completo'), column='estado_da_transacao') %}
 
{% for estado_transacao in estados_transacao %}
SELECT
  base.id,
  base.estado_da_transacao,
  COALESCE(et.nome_amigavel,base.estado_da_transacao) AS nome_amigavel,
  COALESCE(et.descricao, "Método sem descrição") AS descricao
FROM (
    SELECT 
    "{{ loop.index }}" AS id,
    "{{ estado_transacao }}" AS estado_da_transacao) AS base

    LEFT JOIN {{ ref('estado_transacao')}} AS et
       ON base.estado_da_transacao = et.estado_da_transacao
    {{ "UNION ALL" if not loop.last }}
{% endfor %}
ORDER BY 1

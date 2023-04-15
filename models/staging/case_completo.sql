-- depends_on: {{ ref('estados') }}
{% set tabelas = ["case_parte1", "case_parte2"] %}
{% set fonte = "raw_data" %}

{%- for tabela in tabelas -%}
    {{ gera_fonte(fonte, tabela)}}
    {{ "UNION ALL" if not loop.last}}

{%- endfor -%}
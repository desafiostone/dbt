-- depends_on: {{ ref('eph_metodo_pagamento') }}
{% set metodos_pagamento = dbt_utils.get_column_values(table=ref('case_completo'), column='metodo_de_pagamento') %}
 
{% for metodo_pagamento in metodos_pagamento %}
SELECT
  base.id,
  base.metodo_de_pagamento,
  COALESCE(m.nome_amigavel,base.metodo_de_pagamento) AS nome_amigavel,
  COALESCE(m.descricao, "Método sem descrição") AS descricao
  FROM (
    SELECT 
    "{{ loop.index }}" AS id,
    "{{ metodo_pagamento }}" AS metodo_de_pagamento) AS base
    LEFT JOIN {{ ref('eph_metodo_pagamento')}} AS m
       ON base.metodo_de_pagamento = m.metodo_de_pagamento
    {{ "UNION ALL" if not loop.last }}
{% endfor %}
ORDER BY 1

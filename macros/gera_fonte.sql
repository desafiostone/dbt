{%- macro gera_fonte(fonte, tabela) -%}


SELECT
codigo_da_transacao,
DATETIME(data_e_hora_da_transacao,"America/Sao_Paulo") AS data_e_hora_da_transacao_br,
UPPER(metodo_de_captura) AS metodo_de_captura,
CASE bandeira_do_cartao
    WHEN "<null>" THEN NULL
    ELSE UPPER(bandeira_do_cartao) 
END AS bandeira_do_cartao,
UPPER(metodo_de_pagamento) AS metodo_de_pagamento,
UPPER(estado_da_transacao) AS estado_da_transacao,
SAFE_CAST(valor_da_transacao AS FLOAT64) AS valor_da_transacao,
codigo_do_usuario,
UPPER(estado_do_usuario) AS estado_do_usuario,
CASE 
    WHEN REGEXP_CONTAINS(cidade_do_usuario, r'^\(.+\)$') THEN INITCAP(TRIM(REPLACE(cidade_do_usuario,"'"," "),' (),')) 
    WHEN REGEXP_CONTAINS(cidade_do_usuario, r'\d') THEN "Cidade Inválida"
ELSE 
    INITCAP(TRIM(REPLACE(cidade_do_usuario,"'"," "),' ,')) 
END AS cidade_do_usuario

FROM {{ source(fonte,tabela) }} 
WHERE UPPER(estado_da_transacao) IN ("PAID", "REFUSED", "REFUNDED", "CHARGEDBACK")
AND UPPER(estado_do_usuario) IN (SELECT DISTINCT uf FROM {{ ref("estados")}})

{%- endmacro -%}

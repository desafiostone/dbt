{{ config (
    materialized="ephemeral"
)}}

WITH metodos AS (

    SELECT
        "DEBIT_CARD" AS metodo_de_pagamento,
        "Cartão de débito" AS nome_amigavel,
        "Pago com dinheiro retirado instantaneamente da conta" AS descricao
    
    UNION ALL
            SELECT
        "CREDIT_CARD" AS metodo_de_pagamento,
        "Cartão de crédito" AS nome_amigavel,
        "Valor pago será adicionado na fatura mensal do cartão" AS descricao
)

SELECT * FROM metodos
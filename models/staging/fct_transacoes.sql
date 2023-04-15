SELECT
base.codigo_da_transacao,
base.data_e_hora_da_transacao_br,
mc.id AS id_metodo_de_captura,
COALESCE(bc.id,-1) AS id_bandeira_do_cartao,
mp.id AS id_metodo_de_pagamento,
et.id AS id_estado_da_transacao,
base.valor_da_transacao,
base.codigo_do_usuario,
c.id AS id_cidade_do_usuario

FROM {{ ref("case_completo") }} AS base

LEFT JOIN {{ ref("dim_metodo_captura")}} AS mc
    ON base.metodo_de_captura = mc.metodo_de_captura

LEFT JOIN {{ ref("dim_bandeira_cartao")}} AS bc
    ON base.bandeira_do_cartao = bc.bandeira_do_cartao

LEFT JOIN {{ ref("dim_metodo_pagamento")}} AS mp
    ON base.metodo_de_pagamento = mp.metodo_de_pagamento

LEFT JOIN {{ ref("dim_estado_transacao")}} AS et
    ON base.estado_da_transacao = et.estado_da_transacao

LEFT JOIN {{ ref("dim_cidade_usuario")}} AS c
    ON base.cidade_do_usuario = c.cidade_do_usuario
        AND base.estado_do_usuario = c.estado_do_usuario
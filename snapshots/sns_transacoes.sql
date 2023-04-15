{% snapshot check_transacoes %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key="codigo_da_transacao||'-'||data_e_hora_da_transacao_br||'-'||codigo_do_usuario",
          check_cols=['id_estado_da_transacao'],
        )
    }}

    select * from {{ ref("fct_transacoes")}}

{% endsnapshot %}
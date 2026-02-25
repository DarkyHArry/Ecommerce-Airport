# Projeto de Gerenciamento de Voos e Aeroportos

Este projeto consiste em um sistema de banco de dados simplificado para gerenciar informações de aeroportos, aeronaves, voos, clientes e reservas. O objetivo principal é demonstrar a estrutura de um banco de dados relacional com integridade referencial e consultas básicas.

## Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

-   `tb_aeroportos`: Armazena detalhes sobre os aeroportos (código IATA, nome, cidade, país).
-   `tb_aeronaves`: Contém informações sobre as aeronaves (modelo, capacidade total).
-   `tb_voos`: Registra os voos, incluindo aeronave, origem, destino, datas, preço e assentos disponíveis.
-   `tb_clientes`: Guarda os dados dos clientes (nome, e-mail, CPF).
-   `tb_reservas`: Gerencia as reservas de voos, ligando clientes a voos específicos.

### Diagrama Conceitual (Simplificado)

```mermaid
ERD
    tb_aeroportos {
        CHAR(3) pk_id_aeroporto PK
        TEXT nm_aeroporto
        TEXT nm_cidade
        TEXT nm_pais
    }

    tb_aeronaves {
        INTEGER pk_id_aeronave PK
        TEXT nm_modelo
        INTEGER nr_capacidade_total
    }

    tb_voos {
        INTEGER pk_id_voo PK
        TEXT codigo_voo
        INTEGER fk_id_aeronave FK
        CHAR(3) fk_origem FK
        CHAR(3) fk_destino FK
        DATETIME dt_partida
        DATETIME dt_chegada
        REAL vl_passagem
        INTEGER nr_assentos_disponiveis
    }

    tb_clientes {
        INTEGER pk_id_cliente PK
        TEXT nm_cliente
        TEXT ds_email
        TEXT nr_cpf
    }

    tb_reservas {
        INTEGER pk_id_reserva PK
        INTEGER fk_id_voo FK
        INTEGER fk_id_cliente FK
        TIMESTAMP dt_compra
        TEXT st_pagamento
    }

    tb_voos ||--o{ tb_aeronaves : fk_id_aeronave
    tb_voos ||--o{ tb_aeroportos : fk_origem
    tb_voos ||--o{ tb_aeroportos : fk_destino
    tb_reservas ||--o{ tb_voos : fk_id_voo
    tb_reservas ||--o{ tb_clientes : fk_id_cliente
```

## Arquivos SQL

O projeto inclui os seguintes arquivos SQL:

-   `schema_corrected.sql`: Define a estrutura das tabelas e suas relações, incluindo chaves primárias e estrangeiras com nomes lógicos para facilitar a compreensão e manutenção.
    ```sql
    -- Exemplo de definição de chave estrangeira com nome lógico
    FOREIGN KEY (fk_id_aeronave) REFERENCES tb_aeronaves(pk_id_aeronave)
    -- Corrigido para:
    CONSTRAINT fk_voos_aeronaves FOREIGN KEY (fk_id_aeronave) REFERENCES tb_aeronaves(pk_id_aeronave)
    ```

-   `Airport.session.sql`: Contém comandos DML (Data Manipulation Language) para inserção de dados de exemplo e uma consulta relatorial para demonstrar como as tabelas podem ser unidas para obter informações significativas.
    ```sql
    -- Exemplo de consulta relatorial
    SELECT
        V.codigo_voo AS "Código Voo",
        A1.nm_cidade AS "Origem",
        A2.nm_cidade AS "Destino"
    FROM tb_voos V
    JOIN tb_aeroportos A1 ON V.fk_origem = A1.pk_id_aeroporto
    JOIN tb_aeroportos A2 ON V.fk_destino = A2.pk_id_aeroporto;
    ```

## Como Utilizar

1.  **Criação do Banco de Dados**: Execute o script `schema_corrected.sql` em um ambiente SQLite para criar as tabelas.
2.  **Inserção de Dados**: Execute o script `Airport.session.sql` para popular o banco de dados com dados de exemplo.
3.  **Consultas**: Utilize as consultas presentes no `Airport.session.sql` ou crie suas próprias para explorar os dados.

## Contribuição

Sinta-se à vontade para propor melhorias, correções ou novas funcionalidades. Este projeto é um ponto de partida para um sistema de gerenciamento de voos mais robusto.

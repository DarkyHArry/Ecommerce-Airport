-- LIMPEZA DE DADOS (Opcional, para testes)
DELETE FROM tb_reservas;
DELETE FROM tb_voos;
DELETE FROM tb_clientes;
DELETE FROM tb_aeronaves;
DELETE FROM tb_aeroportos;

-- INSERÇÃO DE DADOS (DML)
INSERT INTO tb_aeroportos VALUES ('GRU', 'Guarulhos Internacional', 'São Paulo', 'Brasil');
INSERT INTO tb_aeroportos VALUES ('LIS', 'Aeroporto de Lisboa', 'Lisboa', 'Portugal');
INSERT INTO tb_aeroportos VALUES ('JFK', 'John F. Kennedy', 'Nova York', 'EUA');

INSERT INTO tb_aeronaves (nm_modelo, nr_capacidade_total) VALUES ('Airbus A350', 300);

INSERT INTO tb_voos (codigo_voo, fk_id_aeronave, fk_origem, fk_destino, dt_partida, dt_chegada, vl_passagem, nr_assentos_disponiveis)
VALUES ('TP082', 1, 'GRU', 'LIS', '2026-06-15 19:00:00', '2026-06-16 07:00:00', 4500.00, 300);

INSERT INTO tb_clientes (nm_cliente, ds_email, nr_cpf) 
VALUES ('Alex Aluno', 'alex@faculdade.com', '123.456.789-00');

-- CONSULTA RELATORIAL (O JOIN que você precisava)
-- Esta consulta mostra o voo com os nomes dos aeroportos em vez de apenas os IDs
SELECT 
    V.codigo_voo AS "Código Voo",
    V.dt_partida AS "Partida",
    A1.nm_cidade AS "Origem",
    A2.nm_cidade AS "Destino",
    V.vl_passagem AS "Preço (R$)",
    AERO.nm_modelo AS "Aeronave"
FROM tb_voos V
JOIN tb_aeroportos A1 ON V.fk_origem = A1.pk_id_aeroporto
JOIN tb_aeroportos A2 ON V.fk_destino = A2.pk_id_aeroporto
JOIN tb_aeronaves AERO ON V.fk_id_aeronave = AERO.pk_id_aeronave;
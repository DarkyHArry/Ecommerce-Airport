-- CONFIGURAÇÕES DE INTEGRIDADE
PRAGMA foreign_keys = ON;

-- 1. TABELA DE AEROPORTOS
CREATE TABLE IF NOT EXISTS tb_aeroportos (
    pk_id_aeroporto CHAR(3) PRIMARY KEY,
    nm_aeroporto TEXT NOT NULL,
    nm_cidade TEXT NOT NULL,
    nm_pais TEXT NOT NULL
);

-- 2. TABELA DE AERONAVES
CREATE TABLE IF NOT EXISTS tb_aeronaves (
    pk_id_aeronave INTEGER PRIMARY KEY AUTOINCREMENT,
    nm_modelo TEXT NOT NULL,
    nr_capacidade_total INTEGER NOT NULL
);

-- 3. TABELA DE VOOS (Onde a mágica acontece)
CREATE TABLE IF NOT EXISTS tb_voos (
    pk_id_voo INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo_voo TEXT NOT NULL UNIQUE,
    fk_id_aeronave INTEGER NOT NULL,
    fk_origem CHAR(3) NOT NULL,
    fk_destino CHAR(3) NOT NULL,
    dt_partida DATETIME NOT NULL,
    dt_chegada DATETIME NOT NULL,
    vl_passagem REAL NOT NULL,
    nr_assentos_disponiveis INTEGER NOT NULL,
    CONSTRAINT fk_voos_aeronaves FOREIGN KEY (fk_id_aeronave) REFERENCES tb_aeronaves(pk_id_aeronave),
    CONSTRAINT fk_voos_origem_aeroportos FOREIGN KEY (fk_origem) REFERENCES tb_aeroportos(pk_id_aeroporto),
    CONSTRAINT fk_voos_destino_aeroportos FOREIGN KEY (fk_destino) REFERENCES tb_aeroportos(pk_id_aeroporto)
);

-- 4. TABELA DE CLIENTES
CREATE TABLE IF NOT EXISTS tb_clientes (
    pk_id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nm_cliente TEXT NOT NULL,
    ds_email TEXT NOT NULL UNIQUE,
    nr_cpf TEXT NOT NULL UNIQUE
);

-- 5. TABELA DE RESERVAS (Vendas)
CREATE TABLE IF NOT EXISTS tb_reservas (
    pk_id_reserva INTEGER PRIMARY KEY AUTOINCREMENT,
    fk_id_voo INTEGER NOT NULL,
    fk_id_cliente INTEGER NOT NULL,
    dt_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    st_pagamento TEXT CHECK(st_pagamento IN ('Pendente', 'Confirmado', 'Cancelado')),
    CONSTRAINT fk_reservas_voos FOREIGN KEY (fk_id_voo) REFERENCES tb_voos(pk_id_voo),
    CONSTRAINT fk_reservas_clientes FOREIGN KEY (fk_id_cliente) REFERENCES tb_clientes(pk_id_cliente)
);

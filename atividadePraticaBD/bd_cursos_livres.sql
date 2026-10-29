CREATE DATABASE bd_cursos_livres
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE bd_cursos_livres;

CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(150),
    data_nascimento DATE
);

CREATE TABLE instrutor (
    id_instrutor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    especialidade VARCHAR(150) NOT NULL
);

CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    carga_horaria INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL DEFAULT 0.00,

    CONSTRAINT chk_carga_horaria
        CHECK (carga_horaria > 0),

    CONSTRAINT chk_valor_curso
        CHECK (valor >= 0)
);

CREATE TABLE turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    id_instrutor INT NOT NULL,
    data_inicio DATE NOT NULL,
    quantidade_vagas INT NOT NULL,

    CONSTRAINT chk_quantidade_vagas
        CHECK (quantidade_vagas > 0),

    CONSTRAINT fk_turma_curso
        FOREIGN KEY (id_curso)
        REFERENCES curso(id_curso)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_turma_instrutor
        FOREIGN KEY (id_instrutor)
        REFERENCES instrutor(id_instrutor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_curso INT NOT NULL,
    data_matricula DATE NOT NULL DEFAULT (CURRENT_DATE),
    situacao VARCHAR(20) NOT NULL DEFAULT 'Ativa',

    CONSTRAINT uq_aluno_curso
        UNIQUE (id_aluno, id_curso),

    CONSTRAINT chk_situacao_matricula
        CHECK (situacao IN ('Ativa', 'Cancelada', 'Concluída')),

    CONSTRAINT fk_matricula_aluno
        FOREIGN KEY (id_aluno)
        REFERENCES aluno(id_aluno)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_matricula_curso
        FOREIGN KEY (id_curso)
        REFERENCES curso(id_curso)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
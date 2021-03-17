--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12
-- Dumped by pg_dump version 10.1

-- Started on 2021-03-17 15:59:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 201 (class 1259 OID 25084)
-- Name: acoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE acoes (
    id integer DEFAULT nextval(('public.acoes_id_seq'::text)::regclass) NOT NULL,
    descricao character varying(60) NOT NULL,
    ativo character(1),
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer
);


ALTER TABLE acoes OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 25092)
-- Name: acoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE acoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1;


ALTER TABLE acoes_id_seq OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 25156)
-- Name: entidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidades (
    id integer NOT NULL,
    pessoa_id integer,
    pessoa_tipo character(1),
    nome character varying(200) NOT NULL,
    fantasia character varying(200) NOT NULL,
    cnpj_cpf character varying(14) NOT NULL,
    insc_mun character varying(20),
    insc_est character varying(20),
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL,
    dt_inc date NOT NULL,
    dt_alt date,
    us_inc integer NOT NULL,
    us_alt integer
);


ALTER TABLE entidades OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25178)
-- Name: entidades_dados_complementares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidades_dados_complementares (
    entidade_id integer NOT NULL,
    nome_contato character varying(200) NOT NULL,
    porte_id character(1) DEFAULT 'I'::bpchar NOT NULL,
    cnae_principal character varying(7) NOT NULL,
    grupo_empresarial_id integer NOT NULL,
    CONSTRAINT entidades_dados_complementares_porte_id_chk CHECK ((porte_id = ANY (ARRAY['P'::bpchar, 'M'::bpchar, 'G'::bpchar, 'I'::bpchar])))
);


ALTER TABLE entidades_dados_complementares OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25240)
-- Name: entidades_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidades_email (
    entidade_id integer NOT NULL,
    conta character varying(60) NOT NULL,
    email character varying(60) NOT NULL,
    ativo character(1),
    dt_inc date,
    us_inc integer,
    dt_alt date,
    us_alt integer
);


ALTER TABLE entidades_email OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25250)
-- Name: entidades_enderecos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidades_enderecos (
    entidade_id integer,
    cep character(8) NOT NULL,
    logradouro character varying(200),
    numero character varying(15),
    bairro character varying(60),
    cidade_ibge integer NOT NULL,
    uf character(2) NOT NULL,
    complemento character varying(100),
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL,
    dt_inc date NOT NULL,
    dt_alt date,
    us_inc integer NOT NULL,
    us_alt integer
);


ALTER TABLE entidades_enderecos OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 25213)
-- Name: entidades_estagiario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidades_estagiario (
    entidade_id integer NOT NULL,
    estagiario_id integer NOT NULL,
    dt_inicio date,
    dt_final date,
    dt_inc date,
    us_inc integer,
    dt_alt date,
    us_alt integer,
    ativo character(1) DEFAULT 'S'::bpchar
);
ALTER TABLE ONLY entidades_estagiario ALTER COLUMN entidade_id SET STATISTICS 0;
ALTER TABLE ONLY entidades_estagiario ALTER COLUMN estagiario_id SET STATISTICS 0;


ALTER TABLE entidades_estagiario OWNER TO postgres;

--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN entidades_estagiario.entidade_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN entidades_estagiario.entidade_id IS 'ID entidade responsavel pelo estagiario';


--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN entidades_estagiario.estagiario_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN entidades_estagiario.estagiario_id IS 'ID do estagiario no cadastro de entidades';


--
-- TOC entry 215 (class 1259 OID 25154)
-- Name: entidades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE entidades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entidades_id_seq OWNER TO postgres;

--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 215
-- Name: entidades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE entidades_id_seq OWNED BY entidades.id;


--
-- TOC entry 219 (class 1259 OID 25229)
-- Name: entidades_oab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidades_oab (
    entidade_id integer NOT NULL,
    numero_oab character varying(20) NOT NULL,
    uf_oab character(2) NOT NULL,
    ativo character(1) DEFAULT 'A'::bpchar NOT NULL,
    dt_inc date NOT NULL,
    us_inc integer NOT NULL,
    dt_alt date,
    us_alt integer
);
ALTER TABLE ONLY entidades_oab ALTER COLUMN entidade_id SET STATISTICS 0;
ALTER TABLE ONLY entidades_oab ALTER COLUMN numero_oab SET STATISTICS 0;
ALTER TABLE ONLY entidades_oab ALTER COLUMN uf_oab SET STATISTICS 0;
ALTER TABLE ONLY entidades_oab ALTER COLUMN ativo SET STATISTICS 0;


ALTER TABLE entidades_oab OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 25130)
-- Name: etapasprocessuais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE etapasprocessuais (
    id integer NOT NULL,
    descricao character varying(100) NOT NULL,
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer,
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL
);


ALTER TABLE etapasprocessuais OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 25128)
-- Name: etapasprocessuais_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE etapasprocessuais_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE etapasprocessuais_id_seq OWNER TO postgres;

--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 209
-- Name: etapasprocessuais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE etapasprocessuais_id_seq OWNED BY etapasprocessuais.id;


--
-- TOC entry 200 (class 1259 OID 25082)
-- Name: grupoempresarial_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE grupoempresarial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE grupoempresarial_id_seq OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 25073)
-- Name: gruposempresariais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gruposempresariais (
    id integer DEFAULT nextval(('public.grupoempresarial_id_seq'::text)::regclass) NOT NULL,
    descricao character varying(60) NOT NULL,
    ativo character(1) DEFAULT 'A'::bpchar NOT NULL,
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer
);


ALTER TABLE gruposempresariais OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 25096)
-- Name: localizacoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE localizacoes (
    id integer NOT NULL,
    descricao character varying(60) NOT NULL,
    ativo character(1),
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer
);


ALTER TABLE localizacoes OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 25094)
-- Name: localizacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE localizacao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE localizacao_id_seq OWNER TO postgres;

--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 203
-- Name: localizacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE localizacao_id_seq OWNED BY localizacoes.id;


--
-- TOC entry 207 (class 1259 OID 25117)
-- Name: orgaoscompetentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE orgaoscompetentes (
    id integer DEFAULT nextval(('public.grupoempresarial_id_seq'::text)::regclass) NOT NULL,
    descricao character varying(100) NOT NULL,
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer,
    ativo character(1) DEFAULT 'A'::bpchar NOT NULL
);


ALTER TABLE orgaoscompetentes OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 25123)
-- Name: orgaoscompetentes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orgaoscompetentes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE orgaoscompetentes_id_seq OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 25148)
-- Name: tiposdepessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tiposdepessoa (
    id integer NOT NULL,
    descricao character varying(30) NOT NULL,
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer,
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL
);


ALTER TABLE tiposdepessoa OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 25146)
-- Name: pessoas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pessoas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pessoas_id_seq OWNER TO postgres;

--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 213
-- Name: pessoas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pessoas_id_seq OWNED BY tiposdepessoa.id;


--
-- TOC entry 205 (class 1259 OID 25104)
-- Name: servicos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE servicos (
    id integer DEFAULT nextval(('public.servicos_id_seq'::text)::regclass) NOT NULL,
    descricao character varying(100) NOT NULL,
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer,
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL
);


ALTER TABLE servicos OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 25112)
-- Name: servicos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE servicos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE servicos_id_seq OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 25068)
-- Name: tbusuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tbusuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE tbusuarios_id_seq OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 25139)
-- Name: tiposdeocorrencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tiposdeocorrencia (
    id integer NOT NULL,
    descricao character varying(100) NOT NULL,
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer,
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL,
    tipo_faturar character(1)
);


ALTER TABLE tiposdeocorrencia OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 25137)
-- Name: tiposdeocorrencia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tiposdeocorrencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tiposdeocorrencia_id_seq OWNER TO postgres;

--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 211
-- Name: tiposdeocorrencia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tiposdeocorrencia_id_seq OWNED BY tiposdeocorrencia.id;


--
-- TOC entry 197 (class 1259 OID 25056)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuarios (
    id integer DEFAULT nextval(('public.tbusuarios_id_seq'::text)::regclass) NOT NULL,
    user_name character varying(35),
    email character varying(200) NOT NULL,
    password character varying(200),
    perfil_id integer NOT NULL,
    ativo character(1) DEFAULT 'A'::bpchar NOT NULL,
    dt_inc date,
    dt_alt date,
    us_inc integer,
    us_alt integer,
    entidade_id integer
);


ALTER TABLE usuarios OWNER TO postgres;

--
-- TOC entry 2762 (class 2604 OID 25159)
-- Name: entidades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades ALTER COLUMN id SET DEFAULT nextval('entidades_id_seq'::regclass);


--
-- TOC entry 2756 (class 2604 OID 25133)
-- Name: etapasprocessuais id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapasprocessuais ALTER COLUMN id SET DEFAULT nextval('etapasprocessuais_id_seq'::regclass);


--
-- TOC entry 2751 (class 2604 OID 25099)
-- Name: localizacoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes ALTER COLUMN id SET DEFAULT nextval('localizacao_id_seq'::regclass);


--
-- TOC entry 2758 (class 2604 OID 25142)
-- Name: tiposdeocorrencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdeocorrencia ALTER COLUMN id SET DEFAULT nextval('tiposdeocorrencia_id_seq'::regclass);


--
-- TOC entry 2760 (class 2604 OID 25151)
-- Name: tiposdepessoa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdepessoa ALTER COLUMN id SET DEFAULT nextval('pessoas_id_seq'::regclass);


--
-- TOC entry 2943 (class 0 OID 25084)
-- Dependencies: 201
-- Data for Name: acoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (2, 'AÇÃO ORDINARIA', 'A', '2020-11-09', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (5, 'AÇÃO CONDENATÓRIA DA OBRIGAÇÃO DE FAZER', 'A', '2020-11-09', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (4, 'HABEAS CORPUS', 'A', '2020-11-09', '2020-11-09', 1, 1);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (12, 'teste de inclusão se erro', 'A', '2020-11-13', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (13, 'aaaaaaa', 'A', '2020-11-13', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (14, 'aaaaaa', 'A', '2020-11-13', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (15, 'bbbbbbbbbb', 'A', '2020-11-13', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (16, 'bbbbbbbbbx', 'A', '2020-11-13', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (19, 'zxzxzxzxzxz', 'A', '2020-11-13', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (20, 'inclusão se erro', 'A', '2020-11-13', NULL, 1, NULL);
INSERT INTO acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (21, 'de inclusão se furo', 'A', '2020-11-13', '2020-11-13', 1, 1);


--
-- TOC entry 2958 (class 0 OID 25156)
-- Dependencies: 216
-- Data for Name: entidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO entidades (id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (129, 7, 'F', 'Ze Mané de Tota', 'Zé de Tota', '31598804006', NULL, NULL, 'A', '2021-03-16', NULL, 1, NULL);
INSERT INTO entidades (id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (155, 3, 'F', 'joselito', 'Joselito Jose do Nascimento', '37353373415', NULL, NULL, 'A', '2021-03-16', NULL, 1, NULL);
INSERT INTO entidades (id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (156, 3, 'F', 'joselito nascimentor', 'joselito nascimentor', '939.297.330-65', '', '', 'A', '2020-07-10', NULL, 1, NULL);


--
-- TOC entry 2959 (class 0 OID 25178)
-- Dependencies: 217
-- Data for Name: entidades_dados_complementares; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2962 (class 0 OID 25240)
-- Dependencies: 220
-- Data for Name: entidades_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO entidades_email (entidade_id, conta, email, ativo, dt_inc, us_inc, dt_alt, us_alt) VALUES (155, 'teste', 'joselito_nascimento@yahoo.com.br', 'A', '2021-03-16', 1, NULL, NULL);


--
-- TOC entry 2963 (class 0 OID 25250)
-- Dependencies: 221
-- Data for Name: entidades_enderecos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO entidades_enderecos (entidade_id, cep, logradouro, numero, bairro, cidade_ibge, uf, complemento, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (129, '52030020', 'Rua Domingos Bastos', '35', 'Encruzilhada', 2611606, 'PE', 'casa b', 'A', '2021-03-16', NULL, 1, NULL);
INSERT INTO entidades_enderecos (entidade_id, cep, logradouro, numero, bairro, cidade_ibge, uf, complemento, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (155, '52030060', 'Rua Castro Alves', '105', 'Encruzilhada', 2611606, 'PE', 'apto 703', 'A', '2021-03-16', NULL, 1, NULL);


--
-- TOC entry 2960 (class 0 OID 25213)
-- Dependencies: 218
-- Data for Name: entidades_estagiario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO entidades_estagiario (entidade_id, estagiario_id, dt_inicio, dt_final, dt_inc, us_inc, dt_alt, us_alt, ativo) VALUES (155, 129, '2021-03-16', NULL, '2021-03-16', 1, NULL, NULL, 'A');


--
-- TOC entry 2961 (class 0 OID 25229)
-- Dependencies: 219
-- Data for Name: entidades_oab; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO entidades_oab (entidade_id, numero_oab, uf_oab, ativo, dt_inc, us_inc, dt_alt, us_alt) VALUES (155, '123456', 'AC', 'A', '2021-03-16', 1, NULL, NULL);


--
-- TOC entry 2952 (class 0 OID 25130)
-- Dependencies: 210
-- Data for Name: etapasprocessuais; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO etapasprocessuais (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (1, 'teste de etapa processual', '2020-12-03', NULL, 1, NULL, 'A');
INSERT INTO etapasprocessuais (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (2, 'nova etapa processual alterada', '2020-12-03', '2020-12-03', 1, 1, 'A');


--
-- TOC entry 2941 (class 0 OID 25073)
-- Dependencies: 199
-- Data for Name: gruposempresariais; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (1, 'Não Informado', 'A', '2020-10-19', NULL, 1, NULL);
INSERT INTO gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (12, 'Grupo coisa e tal e tal e coisa', 'A', '2020-10-21', NULL, 1, NULL);
INSERT INTO gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (13, 'Grupos do valle', 'A', '2020-10-21', NULL, 1, NULL);
INSERT INTO gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (10, 'Grupo coisa e tal', 'A', '2020-10-21', '2020-11-04', 1, 1);
INSERT INTO gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (18, 'coisa e tal e tal e coisa', 'A', '2020-10-21', '2020-11-04', 1, 1);
INSERT INTO gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (4, 'grupo datapress alterado', 'A', '2020-10-21', '2020-11-04', 1, 1);
INSERT INTO gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (22, 'MANDADO DE SEGURANÇA', 'A', '2020-11-09', NULL, 1, NULL);
INSERT INTO gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (3, 'Grupo Bom Leite', 'A', '2020-10-21', '2021-01-12', 1, 1);


--
-- TOC entry 2946 (class 0 OID 25096)
-- Dependencies: 204
-- Data for Name: localizacoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO localizacoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (2, 'JUSTIÇAFEDERAL', 'A', '2020-11-12', NULL, 1, NULL);
INSERT INTO localizacoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (3, 'JUSTICA FEDERAL', 'A', '2020-11-12', NULL, 1, NULL);
INSERT INTO localizacoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (4, 'JUSTIKA FEDERAL', 'A', '2020-11-12', NULL, 1, NULL);
INSERT INTO localizacoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (5, 'JUSTIÇAFEDERALa', 'A', '2020-11-12', NULL, 1, NULL);
INSERT INTO localizacoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (6, 'JUSTIÇA FEDERAL', 'A', '2020-11-12', NULL, 1, NULL);
INSERT INTO localizacoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) VALUES (1, 'TESTE DE ALTERAÇÃO', 'A', '2020-11-12', '2020-11-18', 1, 1);


--
-- TOC entry 2949 (class 0 OID 25117)
-- Dependencies: 207
-- Data for Name: orgaoscompetentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (23, 'JUSTIÇA FEDERAL DO ESTADO DE PERNAMBUCO', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (24, 'RECEITA FEDERAL DO BRASIL', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (25, 'JUSTIÇA FEDERAL DO ESTADO DO CEARÁ', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (26, 'JUSTIÇA FEDERAL DO ESTADO DE SÃO PAULO', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (27, 'JUSTIÇA FEDERAL DO ESTADO DE ALAGOAS', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (28, 'JUSTIÇA FEDERAL DO ESTADO DO PIAUÍ', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (29, 'JUSTIÇA FEDERAL DO ESTADO DO RIO GRANDE DO NORTE', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (30, 'JUSTIÇA FEDERAL DO ESTADO DA PARAÍBA', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (31, 'JUSTIÇA FEDERAL DO ESTADO DE SERGIPE', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (32, 'JUSTIÇA FEDERAL DO ESTADO DA BAHIA', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (33, 'JUSTIÇA FEDERAL DO ESTADO DO RIO DE JANEIRO', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (34, 'JUSTIÇA FEDERAL DO ESTADO DO MARANHÃO', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (35, 'JUSTIÇA FEDERAL DO ESTADO DO PARÁ', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (36, 'JUSTIÇA FEDERAL DO ESTADO DE RONDÔNIA', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (37, 'JUSTIÇA FEDERAL DO ESTADO DE RORAIMA', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (38, 'JUSTIÇA FEDERAL DO ESTADO DO AMAPÁ', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (39, 'JUSTIÇA FEDERAL DO ESTADO DO ACRE', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (40, 'JUSTIÇA FEDERAL DO ESTADO DE MINAS GERAIS', '2020-12-10', NULL, 1, NULL, 'A');
INSERT INTO orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (41, 'JUSTIÇA FEDERAL DO ESTADO DE GOIÁS', '2020-12-10', NULL, 1, NULL, 'A');


--
-- TOC entry 2947 (class 0 OID 25104)
-- Dependencies: 205
-- Data for Name: servicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO servicos (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (1, 'PIS/COFINS - SALDO CREDOR - PRODUÇÃO DE OVOS', '2020-11-13', '2020-11-13', 1, 1, 'A');
INSERT INTO servicos (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (3, 'teste de inclusão de os', '2020-11-13', NULL, 1, NULL, 'A');
INSERT INTO servicos (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (4, 'bla bla bla bla bla', '2020-11-13', NULL, 1, NULL, 'A');
INSERT INTO servicos (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (5, 'Teste de cadastro de serviços', '2020-11-17', NULL, 1, NULL, 'A');
INSERT INTO servicos (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (6, 'Teste Etapa Processual', '2020-12-03', NULL, 1, NULL, 'A');


--
-- TOC entry 2954 (class 0 OID 25139)
-- Dependencies: 212
-- Data for Name: tiposdeocorrencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tiposdeocorrencia (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo, tipo_faturar) VALUES (1, 'AÇÃO PROPOSTA', '2020-12-11', NULL, 1, NULL, 'A', NULL);
INSERT INTO tiposdeocorrencia (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo, tipo_faturar) VALUES (2, 'CUSTAS PAGAS', '2020-12-11', NULL, 1, NULL, 'A', NULL);
INSERT INTO tiposdeocorrencia (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo, tipo_faturar) VALUES (3, 'AUTOS CONCLUSOS PARA DESPACHO', '2020-12-11', NULL, 1, NULL, 'A', NULL);


--
-- TOC entry 2956 (class 0 OID 25148)
-- Dependencies: 214
-- Data for Name: tiposdepessoa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (1, 'CLIENTE', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (2, 'FORNECEDOR', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (3, 'ADVOGADO', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (4, 'CONSULTOR', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (5, 'CONVENIADO', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (6, 'PARCEIROS', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (7, 'ESTAGIÁRIO', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (8, 'DESPACHANTE', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (9, 'FUNCIONÁRIO', NULL, NULL, NULL, NULL, 'S');
INSERT INTO tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) VALUES (10, 'SÓCIO', NULL, NULL, NULL, NULL, 'S');


--
-- TOC entry 2939 (class 0 OID 25056)
-- Dependencies: 197
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuarios (id, user_name, email, password, perfil_id, ativo, dt_inc, dt_alt, us_inc, us_alt, entidade_id) VALUES (3, 'Joselito', 'joselito_nascimento@yahoo.com.br', '$2b$10$hOBDMX/ao4XNg6kp5GMusuOiWPsr0xsFfuSIlrAbRYtVBzdeob9ru', 1, 'A', '2020-07-10', NULL, 1, NULL, 1);


--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 202
-- Name: acoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('acoes_id_seq', 21, true);


--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 215
-- Name: entidades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('entidades_id_seq', 173, true);


--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 209
-- Name: etapasprocessuais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('etapasprocessuais_id_seq', 3, true);


--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 200
-- Name: grupoempresarial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('grupoempresarial_id_seq', 41, true);


--
-- TOC entry 2983 (class 0 OID 0)
-- Dependencies: 203
-- Name: localizacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('localizacao_id_seq', 9, true);


--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 208
-- Name: orgaoscompetentes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orgaoscompetentes_id_seq', 23, false);


--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 213
-- Name: pessoas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pessoas_id_seq', 1, false);


--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 206
-- Name: servicos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('servicos_id_seq', 6, true);


--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 198
-- Name: tbusuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tbusuarios_id_seq', 3, true);


--
-- TOC entry 2988 (class 0 OID 0)
-- Dependencies: 211
-- Name: tiposdeocorrencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tiposdeocorrencia_id_seq', 3, true);


--
-- TOC entry 2781 (class 2606 OID 25091)
-- Name: acoes acoes_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY acoes
    ADD CONSTRAINT acoes_descricao_key UNIQUE (descricao);


--
-- TOC entry 2783 (class 2606 OID 25089)
-- Name: acoes acoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY acoes
    ADD CONSTRAINT acoes_pkey PRIMARY KEY (id);


--
-- TOC entry 2805 (class 2606 OID 25218)
-- Name: entidades_estagiario entidade_estagiario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_estagiario
    ADD CONSTRAINT entidade_estagiario_pkey PRIMARY KEY (entidade_id, estagiario_id);


--
-- TOC entry 2803 (class 2606 OID 25182)
-- Name: entidades_dados_complementares entidades_dados_complementares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_pkey PRIMARY KEY (entidade_id);


--
-- TOC entry 2809 (class 2606 OID 25244)
-- Name: entidades_email entidades_email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_email
    ADD CONSTRAINT entidades_email_pkey PRIMARY KEY (entidade_id, conta, email);


--
-- TOC entry 2807 (class 2606 OID 25234)
-- Name: entidades_oab entidades_oab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_oab
    ADD CONSTRAINT entidades_oab_pkey PRIMARY KEY (entidade_id, numero_oab, uf_oab);


--
-- TOC entry 2801 (class 2606 OID 25165)
-- Name: entidades entidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades
    ADD CONSTRAINT entidades_pkey PRIMARY KEY (id);


--
-- TOC entry 2794 (class 2606 OID 25136)
-- Name: etapasprocessuais etapasprocessuais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapasprocessuais
    ADD CONSTRAINT etapasprocessuais_pkey PRIMARY KEY (id);


--
-- TOC entry 2777 (class 2606 OID 25081)
-- Name: gruposempresariais grupoempresarial_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruposempresariais
    ADD CONSTRAINT grupoempresarial_descricao_key UNIQUE (descricao);


--
-- TOC entry 2779 (class 2606 OID 25079)
-- Name: gruposempresariais grupoempresarial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruposempresariais
    ADD CONSTRAINT grupoempresarial_pkey PRIMARY KEY (id);


--
-- TOC entry 2785 (class 2606 OID 25103)
-- Name: localizacoes localizacao_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes
    ADD CONSTRAINT localizacao_descricao_key UNIQUE (descricao);


--
-- TOC entry 2787 (class 2606 OID 25101)
-- Name: localizacoes localizacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes
    ADD CONSTRAINT localizacao_pkey PRIMARY KEY (id);


--
-- TOC entry 2792 (class 2606 OID 25122)
-- Name: orgaoscompetentes orgaoscompetentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orgaoscompetentes
    ADD CONSTRAINT orgaoscompetentes_pkey PRIMARY KEY (id);


--
-- TOC entry 2789 (class 2606 OID 25115)
-- Name: servicos servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY servicos
    ADD CONSTRAINT servicos_pkey PRIMARY KEY (id);


--
-- TOC entry 2798 (class 2606 OID 25153)
-- Name: tiposdepessoa tbpessoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdepessoa
    ADD CONSTRAINT tbpessoa_pkey PRIMARY KEY (id);


--
-- TOC entry 2770 (class 2606 OID 25067)
-- Name: usuarios tbusuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_email_key UNIQUE (email);


--
-- TOC entry 2772 (class 2606 OID 25071)
-- Name: usuarios tbusuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2775 (class 2606 OID 25065)
-- Name: usuarios tbusuarios_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_user_name_key UNIQUE (user_name);


--
-- TOC entry 2796 (class 2606 OID 25145)
-- Name: tiposdeocorrencia tiposdeocorrencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdeocorrencia
    ADD CONSTRAINT tiposdeocorrencia_pkey PRIMARY KEY (id);


--
-- TOC entry 2799 (class 1259 OID 25172)
-- Name: entidades_cnpj_cpf_unique__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidades_cnpj_cpf_unique__idx ON public.entidades USING btree (cnpj_cpf);


--
-- TOC entry 2790 (class 1259 OID 25126)
-- Name: orgaoscompetentes_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX orgaoscompetentes_idx ON public.orgaoscompetentes USING btree (descricao);


--
-- TOC entry 2773 (class 1259 OID 25062)
-- Name: tbusuarios_user_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tbusuarios_user_name_idx ON public.usuarios USING btree (user_name);


--
-- TOC entry 2813 (class 2606 OID 25219)
-- Name: entidades_estagiario entidade_estagiario_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_estagiario
    ADD CONSTRAINT entidade_estagiario_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2814 (class 2606 OID 25224)
-- Name: entidades_estagiario entidade_estagiario_estagiario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_estagiario
    ADD CONSTRAINT entidade_estagiario_estagiario_fk FOREIGN KEY (estagiario_id) REFERENCES entidades(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2811 (class 2606 OID 25194)
-- Name: entidades_dados_complementares entidades_dados_complementares_entidade_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_entidade_id_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2812 (class 2606 OID 25199)
-- Name: entidades_dados_complementares entidades_dados_complementares_grupo_empresarial_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_grupo_empresarial_fk1 FOREIGN KEY (grupo_empresarial_id) REFERENCES gruposempresariais(id) ON DELETE RESTRICT;


--
-- TOC entry 2816 (class 2606 OID 25245)
-- Name: entidades_email entidades_email_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_email
    ADD CONSTRAINT entidades_email_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2810 (class 2606 OID 25173)
-- Name: entidades entidades_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades
    ADD CONSTRAINT entidades_fk FOREIGN KEY (pessoa_id) REFERENCES tiposdepessoa(id);


--
-- TOC entry 2817 (class 2606 OID 25259)
-- Name: entidades_enderecos entidades_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_enderecos
    ADD CONSTRAINT entidades_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2815 (class 2606 OID 25235)
-- Name: entidades_oab entidades_oab_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_oab
    ADD CONSTRAINT entidades_oab_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


-- Completed on 2021-03-17 15:59:44

--
-- PostgreSQL database dump complete
--


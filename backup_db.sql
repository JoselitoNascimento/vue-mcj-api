--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12
-- Dumped by pg_dump version 10.1

-- Started on 2021-02-22 17:29:59

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
-- TOC entry 2955 (class 0 OID 0)
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
-- TOC entry 2956 (class 0 OID 0)
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
-- TOC entry 218 (class 1259 OID 25213)
-- Name: entidade_estagiario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidade_estagiario (
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
ALTER TABLE ONLY entidade_estagiario ALTER COLUMN entidade_id SET STATISTICS 0;
ALTER TABLE ONLY entidade_estagiario ALTER COLUMN estagiario_id SET STATISTICS 0;


ALTER TABLE entidade_estagiario OWNER TO postgres;

--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN entidade_estagiario.entidade_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN entidade_estagiario.entidade_id IS 'ID entidade responsavel pelo estagiario';


--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN entidade_estagiario.estagiario_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN entidade_estagiario.estagiario_id IS 'ID do estagiario no cadastro de entidades';


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
    endereco character varying(200),
    numero character varying(15),
    bairro character varying(60),
    cidade_ibge integer NOT NULL,
    uf character(2) NOT NULL,
    cep character(8) NOT NULL,
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
-- TOC entry 2959 (class 0 OID 0)
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
-- TOC entry 2960 (class 0 OID 0)
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
-- TOC entry 2961 (class 0 OID 0)
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
-- TOC entry 2962 (class 0 OID 0)
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
-- TOC entry 2963 (class 0 OID 0)
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
-- TOC entry 2754 (class 2604 OID 25159)
-- Name: entidades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades ALTER COLUMN id SET DEFAULT nextval('entidades_id_seq'::regclass);


--
-- TOC entry 2748 (class 2604 OID 25133)
-- Name: etapasprocessuais id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapasprocessuais ALTER COLUMN id SET DEFAULT nextval('etapasprocessuais_id_seq'::regclass);


--
-- TOC entry 2743 (class 2604 OID 25099)
-- Name: localizacoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes ALTER COLUMN id SET DEFAULT nextval('localizacao_id_seq'::regclass);


--
-- TOC entry 2750 (class 2604 OID 25142)
-- Name: tiposdeocorrencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdeocorrencia ALTER COLUMN id SET DEFAULT nextval('tiposdeocorrencia_id_seq'::regclass);


--
-- TOC entry 2752 (class 2604 OID 25151)
-- Name: tiposdepessoa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdepessoa ALTER COLUMN id SET DEFAULT nextval('pessoas_id_seq'::regclass);


--
-- TOC entry 2930 (class 0 OID 25084)
-- Dependencies: 201
-- Data for Name: acoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY acoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) FROM stdin;
2	AÇÃO ORDINARIA	A	2020-11-09	\N	1	\N
5	AÇÃO CONDENATÓRIA DA OBRIGAÇÃO DE FAZER	A	2020-11-09	\N	1	\N
4	HABEAS CORPUS	A	2020-11-09	2020-11-09	1	1
12	teste de inclusão se erro	A	2020-11-13	\N	1	\N
13	aaaaaaa	A	2020-11-13	\N	1	\N
14	aaaaaa	A	2020-11-13	\N	1	\N
15	bbbbbbbbbb	A	2020-11-13	\N	1	\N
16	bbbbbbbbbx	A	2020-11-13	\N	1	\N
19	zxzxzxzxzxz	A	2020-11-13	\N	1	\N
20	inclusão se erro	A	2020-11-13	\N	1	\N
21	de inclusão se furo	A	2020-11-13	2020-11-13	1	1
\.


--
-- TOC entry 2947 (class 0 OID 25213)
-- Dependencies: 218
-- Data for Name: entidade_estagiario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidade_estagiario (entidade_id, estagiario_id, dt_inicio, dt_final, dt_inc, us_inc, dt_alt, us_alt, ativo) FROM stdin;
\.


--
-- TOC entry 2945 (class 0 OID 25156)
-- Dependencies: 216
-- Data for Name: entidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades (id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, endereco, numero, bairro, cidade_ibge, uf, cep, ativo, dt_inc, dt_alt, us_inc, us_alt) FROM stdin;
1	1	J	GRANJA ALMEIDA LTDA	GRANJA ALMEIDA	10744587000105	\N	\N	R PROJETADA	100	CENTRO	2613008	PE	55370000	S	2021-01-15	\N	1	\N
10	1	F	joselito	Joselito Jose do Nascimento	37353373415	\N	\N	Rua Castro Alves	105	Encruzilhada	2611606	XX	52030060	A	2021-02-10	\N	1	\N
15	1	F	joselito nascimentor	joselito nascimentor	084.355.400-22			Rua Castro Alves	105	Encruzilhada	2613008	PE	        	A	2020-07-10	\N	1	\N
17	1	F	joselito nascimentor	joselito nascimentor	099.973.910-71			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
19	1	F	joselito nascimentor	joselito nascimentor	922.998.900-25			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
21	1	F	joselito nascimentor	joselito nascimentor	770.056.920-71			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
22	1	F	joselito nascimentor	joselito nascimentor	750.623.240-50			Rua Castro Alves	105	Encruzilhada	2613008	PE	        	A	2020-07-10	\N	1	\N
24	1	F	joselito nascimentor	joselito nascimentor	819.342.100-05			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
28	2	F	joselito nascimentor	joselito nascimentor	158.458.310-08			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
29	2	F	joselito nascimentor	joselito nascimentor	756.278.990-85			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
30	2	F	joselito nascimentor	joselito nascimentor	838.606.100-66			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
31	2	F	joselito nascimentor	joselito nascimentor	957.779.860-80			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
32	2	F	joselito nascimentor	joselito nascimentor	112.345.200-87			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
33	2	F	joselito nascimentor	joselito nascimentor	804.327.140-22			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
34	2	F	joselito nascimentor	joselito nascimentor	382.123.300-10			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
39	2	F	joselito nascimentor	joselito nascimentor	645.743.430-44			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
41	2	F	joselito nascimentor	joselito nascimentor	736.522.820-27			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
43	2	F	joselito nascimentor	joselito nascimentor	566.908.040-89			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
44	2	F	joselito nascimentor	joselito nascimentor	795.232.320-29			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
48	2	F	joselito nascimentor	joselito nascimentor	770.150.020-00			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
49	2	F	joselito nascimentor	joselito nascimentor	507.536.210-96			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
51	2	F	joselito nascimentor	joselito nascimentor	316.052.140-00			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
52	2	F	joselito nascimentor	joselito nascimentor	450.312.470-61			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
55	2	F	joselito nascimentor	joselito nascimentor	939.297.330-64			Rua Castro Alves	105	Encruzilhada	2613008	PE	52030060	A	2020-07-10	\N	1	\N
\.


--
-- TOC entry 2946 (class 0 OID 25178)
-- Dependencies: 217
-- Data for Name: entidades_dados_complementares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_dados_complementares (entidade_id, nome_contato, porte_id, cnae_principal, grupo_empresarial_id) FROM stdin;
1	Fulano de Tal	I	1111111	22
48	Joselito Nascimento	I	6911701	1
49		I	6911701	1
51	Null	I	6911701	1
52		I	6911701	1
55		G	6911701	1
\.


--
-- TOC entry 2948 (class 0 OID 25229)
-- Dependencies: 219
-- Data for Name: entidades_oab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_oab (entidade_id, numero_oab, uf_oab, ativo, dt_inc, us_inc, dt_alt, us_alt) FROM stdin;
1	212223	PE	A	2021-02-22	0	\N	\N
\.


--
-- TOC entry 2939 (class 0 OID 25130)
-- Dependencies: 210
-- Data for Name: etapasprocessuais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY etapasprocessuais (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) FROM stdin;
1	teste de etapa processual	2020-12-03	\N	1	\N	A
2	nova etapa processual alterada	2020-12-03	2020-12-03	1	1	A
\.


--
-- TOC entry 2928 (class 0 OID 25073)
-- Dependencies: 199
-- Data for Name: gruposempresariais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gruposempresariais (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) FROM stdin;
1	Não Informado	A	2020-10-19	\N	1	\N
12	Grupo coisa e tal e tal e coisa	A	2020-10-21	\N	1	\N
13	Grupos do valle	A	2020-10-21	\N	1	\N
10	Grupo coisa e tal	A	2020-10-21	2020-11-04	1	1
18	coisa e tal e tal e coisa	A	2020-10-21	2020-11-04	1	1
4	grupo datapress alterado	A	2020-10-21	2020-11-04	1	1
22	MANDADO DE SEGURANÇA	A	2020-11-09	\N	1	\N
3	Grupo Bom Leite	A	2020-10-21	2021-01-12	1	1
\.


--
-- TOC entry 2933 (class 0 OID 25096)
-- Dependencies: 204
-- Data for Name: localizacoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY localizacoes (id, descricao, ativo, dt_inc, dt_alt, us_inc, us_alt) FROM stdin;
2	JUSTIÇAFEDERAL	A	2020-11-12	\N	1	\N
3	JUSTICA FEDERAL	A	2020-11-12	\N	1	\N
4	JUSTIKA FEDERAL	A	2020-11-12	\N	1	\N
5	JUSTIÇAFEDERALa	A	2020-11-12	\N	1	\N
6	JUSTIÇA FEDERAL	A	2020-11-12	\N	1	\N
1	TESTE DE ALTERAÇÃO	A	2020-11-12	2020-11-18	1	1
\.


--
-- TOC entry 2936 (class 0 OID 25117)
-- Dependencies: 207
-- Data for Name: orgaoscompetentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY orgaoscompetentes (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) FROM stdin;
23	JUSTIÇA FEDERAL DO ESTADO DE PERNAMBUCO	2020-12-10	\N	1	\N	A
24	RECEITA FEDERAL DO BRASIL	2020-12-10	\N	1	\N	A
25	JUSTIÇA FEDERAL DO ESTADO DO CEARÁ	2020-12-10	\N	1	\N	A
26	JUSTIÇA FEDERAL DO ESTADO DE SÃO PAULO	2020-12-10	\N	1	\N	A
27	JUSTIÇA FEDERAL DO ESTADO DE ALAGOAS	2020-12-10	\N	1	\N	A
28	JUSTIÇA FEDERAL DO ESTADO DO PIAUÍ	2020-12-10	\N	1	\N	A
29	JUSTIÇA FEDERAL DO ESTADO DO RIO GRANDE DO NORTE	2020-12-10	\N	1	\N	A
30	JUSTIÇA FEDERAL DO ESTADO DA PARAÍBA	2020-12-10	\N	1	\N	A
31	JUSTIÇA FEDERAL DO ESTADO DE SERGIPE	2020-12-10	\N	1	\N	A
32	JUSTIÇA FEDERAL DO ESTADO DA BAHIA	2020-12-10	\N	1	\N	A
33	JUSTIÇA FEDERAL DO ESTADO DO RIO DE JANEIRO	2020-12-10	\N	1	\N	A
34	JUSTIÇA FEDERAL DO ESTADO DO MARANHÃO	2020-12-10	\N	1	\N	A
35	JUSTIÇA FEDERAL DO ESTADO DO PARÁ	2020-12-10	\N	1	\N	A
36	JUSTIÇA FEDERAL DO ESTADO DE RONDÔNIA	2020-12-10	\N	1	\N	A
37	JUSTIÇA FEDERAL DO ESTADO DE RORAIMA	2020-12-10	\N	1	\N	A
38	JUSTIÇA FEDERAL DO ESTADO DO AMAPÁ	2020-12-10	\N	1	\N	A
39	JUSTIÇA FEDERAL DO ESTADO DO ACRE	2020-12-10	\N	1	\N	A
40	JUSTIÇA FEDERAL DO ESTADO DE MINAS GERAIS	2020-12-10	\N	1	\N	A
41	JUSTIÇA FEDERAL DO ESTADO DE GOIÁS	2020-12-10	\N	1	\N	A
\.


--
-- TOC entry 2934 (class 0 OID 25104)
-- Dependencies: 205
-- Data for Name: servicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY servicos (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) FROM stdin;
1	PIS/COFINS - SALDO CREDOR - PRODUÇÃO DE OVOS	2020-11-13	2020-11-13	1	1	A
3	teste de inclusão de os	2020-11-13	\N	1	\N	A
4	bla bla bla bla bla	2020-11-13	\N	1	\N	A
5	Teste de cadastro de serviços	2020-11-17	\N	1	\N	A
6	Teste Etapa Processual	2020-12-03	\N	1	\N	A
\.


--
-- TOC entry 2941 (class 0 OID 25139)
-- Dependencies: 212
-- Data for Name: tiposdeocorrencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tiposdeocorrencia (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo, tipo_faturar) FROM stdin;
1	AÇÃO PROPOSTA	2020-12-11	\N	1	\N	A	\N
2	CUSTAS PAGAS	2020-12-11	\N	1	\N	A	\N
3	AUTOS CONCLUSOS PARA DESPACHO	2020-12-11	\N	1	\N	A	\N
\.


--
-- TOC entry 2943 (class 0 OID 25148)
-- Dependencies: 214
-- Data for Name: tiposdepessoa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tiposdepessoa (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) FROM stdin;
1	CLIENTE	\N	\N	\N	\N	S
2	FORNECEDOR	\N	\N	\N	\N	S
3	ADVOGADO	\N	\N	\N	\N	S
4	CONSULTOR	\N	\N	\N	\N	S
5	CONVENIADO	\N	\N	\N	\N	S
6	PARCEIROS	\N	\N	\N	\N	S
7	ESTAGIÁRIO	\N	\N	\N	\N	S
8	DESPACHANTE	\N	\N	\N	\N	S
9	FUNCIONÁRIO	\N	\N	\N	\N	S
10	SÓCIO	\N	\N	\N	\N	S
\.


--
-- TOC entry 2926 (class 0 OID 25056)
-- Dependencies: 197
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarios (id, user_name, email, password, perfil_id, ativo, dt_inc, dt_alt, us_inc, us_alt, entidade_id) FROM stdin;
3	Joselito	joselito_nascimento@yahoo.com.br	$2b$10$hOBDMX/ao4XNg6kp5GMusuOiWPsr0xsFfuSIlrAbRYtVBzdeob9ru	1	A	2020-07-10	\N	1	\N	1
\.


--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 202
-- Name: acoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('acoes_id_seq', 21, true);


--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 215
-- Name: entidades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('entidades_id_seq', 80, true);


--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 209
-- Name: etapasprocessuais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('etapasprocessuais_id_seq', 3, true);


--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 200
-- Name: grupoempresarial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('grupoempresarial_id_seq', 41, true);


--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 203
-- Name: localizacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('localizacao_id_seq', 9, true);


--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 208
-- Name: orgaoscompetentes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orgaoscompetentes_id_seq', 23, false);


--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 213
-- Name: pessoas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pessoas_id_seq', 1, false);


--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 206
-- Name: servicos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('servicos_id_seq', 6, true);


--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 198
-- Name: tbusuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tbusuarios_id_seq', 3, true);


--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 211
-- Name: tiposdeocorrencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tiposdeocorrencia_id_seq', 3, true);


--
-- TOC entry 2772 (class 2606 OID 25091)
-- Name: acoes acoes_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY acoes
    ADD CONSTRAINT acoes_descricao_key UNIQUE (descricao);


--
-- TOC entry 2774 (class 2606 OID 25089)
-- Name: acoes acoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY acoes
    ADD CONSTRAINT acoes_pkey PRIMARY KEY (id);


--
-- TOC entry 2796 (class 2606 OID 25218)
-- Name: entidade_estagiario entidade_estagiario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidade_estagiario
    ADD CONSTRAINT entidade_estagiario_pkey PRIMARY KEY (entidade_id, estagiario_id);


--
-- TOC entry 2794 (class 2606 OID 25182)
-- Name: entidades_dados_complementares entidades_dados_complementares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_pkey PRIMARY KEY (entidade_id);


--
-- TOC entry 2798 (class 2606 OID 25234)
-- Name: entidades_oab entidades_oab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_oab
    ADD CONSTRAINT entidades_oab_pkey PRIMARY KEY (entidade_id, numero_oab, uf_oab);


--
-- TOC entry 2792 (class 2606 OID 25165)
-- Name: entidades entidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades
    ADD CONSTRAINT entidades_pkey PRIMARY KEY (id);


--
-- TOC entry 2785 (class 2606 OID 25136)
-- Name: etapasprocessuais etapasprocessuais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapasprocessuais
    ADD CONSTRAINT etapasprocessuais_pkey PRIMARY KEY (id);


--
-- TOC entry 2768 (class 2606 OID 25081)
-- Name: gruposempresariais grupoempresarial_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruposempresariais
    ADD CONSTRAINT grupoempresarial_descricao_key UNIQUE (descricao);


--
-- TOC entry 2770 (class 2606 OID 25079)
-- Name: gruposempresariais grupoempresarial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruposempresariais
    ADD CONSTRAINT grupoempresarial_pkey PRIMARY KEY (id);


--
-- TOC entry 2776 (class 2606 OID 25103)
-- Name: localizacoes localizacao_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes
    ADD CONSTRAINT localizacao_descricao_key UNIQUE (descricao);


--
-- TOC entry 2778 (class 2606 OID 25101)
-- Name: localizacoes localizacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes
    ADD CONSTRAINT localizacao_pkey PRIMARY KEY (id);


--
-- TOC entry 2783 (class 2606 OID 25122)
-- Name: orgaoscompetentes orgaoscompetentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orgaoscompetentes
    ADD CONSTRAINT orgaoscompetentes_pkey PRIMARY KEY (id);


--
-- TOC entry 2780 (class 2606 OID 25115)
-- Name: servicos servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY servicos
    ADD CONSTRAINT servicos_pkey PRIMARY KEY (id);


--
-- TOC entry 2789 (class 2606 OID 25153)
-- Name: tiposdepessoa tbpessoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdepessoa
    ADD CONSTRAINT tbpessoa_pkey PRIMARY KEY (id);


--
-- TOC entry 2761 (class 2606 OID 25067)
-- Name: usuarios tbusuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_email_key UNIQUE (email);


--
-- TOC entry 2763 (class 2606 OID 25071)
-- Name: usuarios tbusuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2766 (class 2606 OID 25065)
-- Name: usuarios tbusuarios_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_user_name_key UNIQUE (user_name);


--
-- TOC entry 2787 (class 2606 OID 25145)
-- Name: tiposdeocorrencia tiposdeocorrencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdeocorrencia
    ADD CONSTRAINT tiposdeocorrencia_pkey PRIMARY KEY (id);


--
-- TOC entry 2790 (class 1259 OID 25172)
-- Name: entidades_cnpj_cpf_unique__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidades_cnpj_cpf_unique__idx ON public.entidades USING btree (cnpj_cpf);


--
-- TOC entry 2781 (class 1259 OID 25126)
-- Name: orgaoscompetentes_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX orgaoscompetentes_idx ON public.orgaoscompetentes USING btree (descricao);


--
-- TOC entry 2764 (class 1259 OID 25062)
-- Name: tbusuarios_user_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tbusuarios_user_name_idx ON public.usuarios USING btree (user_name);


--
-- TOC entry 2802 (class 2606 OID 25219)
-- Name: entidade_estagiario entidade_estagiario_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidade_estagiario
    ADD CONSTRAINT entidade_estagiario_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2803 (class 2606 OID 25224)
-- Name: entidade_estagiario entidade_estagiario_estagiario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidade_estagiario
    ADD CONSTRAINT entidade_estagiario_estagiario_fk FOREIGN KEY (estagiario_id) REFERENCES entidades(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2800 (class 2606 OID 25194)
-- Name: entidades_dados_complementares entidades_dados_complementares_entidade_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_entidade_id_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2801 (class 2606 OID 25199)
-- Name: entidades_dados_complementares entidades_dados_complementares_grupo_empresarial_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_grupo_empresarial_fk1 FOREIGN KEY (grupo_empresarial_id) REFERENCES gruposempresariais(id) ON DELETE RESTRICT;


--
-- TOC entry 2799 (class 2606 OID 25173)
-- Name: entidades entidades_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades
    ADD CONSTRAINT entidades_fk FOREIGN KEY (pessoa_id) REFERENCES tiposdepessoa(id);


--
-- TOC entry 2804 (class 2606 OID 25235)
-- Name: entidades_oab entidades_oab_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_oab
    ADD CONSTRAINT entidades_oab_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


-- Completed on 2021-02-22 17:30:02

--
-- PostgreSQL database dump complete
--


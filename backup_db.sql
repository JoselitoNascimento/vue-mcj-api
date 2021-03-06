--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12
-- Dumped by pg_dump version 10.1

-- Started on 2021-04-20 17:00:47

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
-- TOC entry 3074 (class 0 OID 0)
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
-- TOC entry 3075 (class 0 OID 0)
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
    ativo character(1) DEFAULT 'S'::bpchar,
    dt_inc date DEFAULT now(),
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
-- TOC entry 227 (class 1259 OID 25306)
-- Name: crm_comentarios_visitas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE crm_comentarios_visitas (
    id integer NOT NULL,
    visitas_id integer NOT NULL,
    dt_comentario date NOT NULL,
    comentario text,
    situacao integer,
    dt_inc date DEFAULT now(),
    us_inc integer,
    dt_alt date,
    us_alt integer
);


ALTER TABLE crm_comentarios_visitas OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25304)
-- Name: crm_comentarios_visitas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE crm_comentarios_visitas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE crm_comentarios_visitas_id_seq OWNER TO postgres;

--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 226
-- Name: crm_comentarios_visitas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE crm_comentarios_visitas_id_seq OWNED BY crm_comentarios_visitas.id;


--
-- TOC entry 224 (class 1259 OID 25290)
-- Name: crm_leads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE crm_leads (
    id integer NOT NULL,
    dt_cadastro date NOT NULL,
    escritorio_id integer,
    entidade_id integer,
    grupo_empresarial_id integer,
    cnpj_cpf character varying(14) NOT NULL,
    nome character varying(200),
    fantasia character varying(200),
    contato character varying(100) NOT NULL,
    logradouro character varying(200) NOT NULL,
    numero character varying(16) NOT NULL,
    bairro character varying(60) NOT NULL,
    cidade_ibge integer NOT NULL,
    uf character(2) NOT NULL,
    cep character varying(8),
    telefone character varying(40),
    email character varying(60),
    cnae_principal character varying(7) NOT NULL,
    dt_retorno date,
    comentario text,
    situacao integer NOT NULL,
    ativo character(1) DEFAULT 'S'::bpchar,
    dt_inc date DEFAULT now(),
    us_inc integer,
    dt_alt date,
    us_alt integer,
    pessoa_tipo character(1),
    complemento character varying(100),
    CONSTRAINT crm_leads_pessoa_tipochk CHECK (((pessoa_tipo = 'F'::bpchar) OR (pessoa_tipo = 'J'::bpchar)))
);


ALTER TABLE crm_leads OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25288)
-- Name: crm_leads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE crm_leads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE crm_leads_id_seq OWNER TO postgres;

--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 223
-- Name: crm_leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE crm_leads_id_seq OWNED BY crm_leads.id;


--
-- TOC entry 229 (class 1259 OID 25317)
-- Name: crm_servicos_visitas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE crm_servicos_visitas (
    id integer NOT NULL,
    visita_id integer NOT NULL,
    servico_id integer NOT NULL,
    situacao integer,
    dt_inc date DEFAULT now(),
    us_inc integer,
    dt_alt date,
    us_alt integer
);


ALTER TABLE crm_servicos_visitas OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 25315)
-- Name: crm_servicos_visitas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE crm_servicos_visitas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE crm_servicos_visitas_id_seq OWNER TO postgres;

--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 228
-- Name: crm_servicos_visitas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE crm_servicos_visitas_id_seq OWNED BY crm_servicos_visitas.id;


--
-- TOC entry 225 (class 1259 OID 25299)
-- Name: crm_visitas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE crm_visitas (
    id integer NOT NULL,
    lead_id integer NOT NULL,
    dt_visita date NOT NULL,
    entidade_id integer NOT NULL,
    situacao integer NOT NULL,
    dt_inc date DEFAULT now(),
    us_inc integer,
    dt_alt date,
    us_alt integer
);


ALTER TABLE crm_visitas OWNER TO postgres;

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
    dt_inc date DEFAULT now() NOT NULL,
    dt_alt date,
    us_inc integer NOT NULL,
    us_alt integer,
    CONSTRAINT entidades_pessos_tipochk CHECK (((pessoa_tipo = 'F'::bpchar) OR (pessoa_tipo = 'J'::bpchar)))
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
    ativo character(1) DEFAULT 'S'::bpchar,
    dt_inc date DEFAULT now(),
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
    dt_inc date DEFAULT now() NOT NULL,
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
    dt_inc date DEFAULT now(),
    us_inc integer,
    dt_alt date,
    us_alt integer,
    ativo character(1) DEFAULT 'S'::bpchar
);
ALTER TABLE ONLY entidades_estagiario ALTER COLUMN entidade_id SET STATISTICS 0;
ALTER TABLE ONLY entidades_estagiario ALTER COLUMN estagiario_id SET STATISTICS 0;


ALTER TABLE entidades_estagiario OWNER TO postgres;

--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN entidades_estagiario.entidade_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN entidades_estagiario.entidade_id IS 'ID entidade responsavel pelo estagiario';


--
-- TOC entry 3080 (class 0 OID 0)
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
-- TOC entry 3081 (class 0 OID 0)
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
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL,
    dt_inc date DEFAULT now() NOT NULL,
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
-- TOC entry 222 (class 1259 OID 25264)
-- Name: entidades_parceiros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE entidades_parceiros (
    entidade_id integer NOT NULL,
    parceiro_id integer NOT NULL
);
ALTER TABLE ONLY entidades_parceiros ALTER COLUMN entidade_id SET STATISTICS 0;


ALTER TABLE entidades_parceiros OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25407)
-- Name: escritorio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE escritorio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1;


ALTER TABLE escritorio_id_seq OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25378)
-- Name: escritorios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE escritorios (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    fantasia character varying(100),
    logradouro character varying(100) NOT NULL,
    cnpj character varying(14),
    inscricao_municipal character varying(20),
    numero_nfe integer DEFAULT 0 NOT NULL,
    cnae character varying(10) NOT NULL,
    numero character varying(10) NOT NULL,
    bairro character varying(60) NOT NULL,
    cidade_ibge integer NOT NULL,
    uf character(2) NOT NULL,
    cep character(8) NOT NULL,
    fonefixo character varying(30),
    fonecel character varying(30),
    email character varying(100),
    perc_pis numeric(6,2) DEFAULT 0.0,
    perc_cofins numeric(6,2) DEFAULT 0.0,
    perc_irpj numeric(6,2) DEFAULT 0.0,
    perc_csll numeric(6,2) DEFAULT 0.0,
    perc_iss numeric(6,2) DEFAULT 0.0,
    perc_custo numeric(6,2) DEFAULT 0.0,
    perc_finan numeric(6,2) DEFAULT 0.0,
    perc_inss numeric(6,2) DEFAULT 0.0,
    regime_tributario numeric(1,0),
    valor_limite_tributacao numeric(8,2) DEFAULT 0,
    regime_tributacao_especial integer,
    retem_iss character(1),
    contador_id integer,
    responsavel_id integer,
    prefeitura character varying(100),
    proxy_host character varying(50),
    proxy_port integer,
    proxy_user character varying(50),
    proxy_pass character varying(150),
    escritorio_host character varying(50),
    escritorio_port integer,
    escritorio_user character varying(50),
    escritorio_pass character varying(150),
    escritorio_email character varying(100),
    escritorio_tls bit(1),
    escritorio_ssl bit(1),
    ssltype integer,
    ssllib integer,
    cryptlib integer,
    httplib integer,
    xmlsignlib integer,
    arq_logo_nfe_emissor character varying(250),
    arq_logo_nfe_municipio character varying(250),
    certificado_numero character varying(100),
    certificado_senha character varying(200),
    certificado_path character varying(200),
    orientacao_danfe character(1),
    ambiente_nfe character(1),
    versao_emissor_nfe character varying(8),
    observacao_nfe text,
    ativo character(1) DEFAULT 'S'::bpchar,
    dt_inc date DEFAULT now(),
    dt_alt date,
    us_inc integer,
    us_alt integer
);


ALTER TABLE escritorios OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 25376)
-- Name: escritorios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE escritorios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE escritorios_id_seq OWNER TO postgres;

--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 230
-- Name: escritorios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE escritorios_id_seq OWNED BY escritorios.id;


--
-- TOC entry 210 (class 1259 OID 25130)
-- Name: etapasprocessuais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE etapasprocessuais (
    id integer NOT NULL,
    descricao character varying(100) NOT NULL,
    dt_inc date DEFAULT now(),
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
-- TOC entry 3083 (class 0 OID 0)
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
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL,
    dt_inc date DEFAULT now(),
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
    ativo character(1) DEFAULT 'S'::bpchar,
    dt_inc date DEFAULT now(),
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
-- TOC entry 3084 (class 0 OID 0)
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
    dt_inc date DEFAULT now(),
    dt_alt date,
    us_inc integer,
    us_alt integer,
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL
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
    dt_inc date DEFAULT now(),
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
-- TOC entry 3085 (class 0 OID 0)
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
    dt_inc date DEFAULT now(),
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
    dt_inc date DEFAULT now(),
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
-- TOC entry 3086 (class 0 OID 0)
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
    ativo character(1) DEFAULT 'S'::bpchar NOT NULL,
    dt_inc date DEFAULT now(),
    dt_alt date,
    us_inc integer,
    us_alt integer,
    entidade_id integer
);


ALTER TABLE usuarios OWNER TO postgres;

--
-- TOC entry 2829 (class 2604 OID 25309)
-- Name: crm_comentarios_visitas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_comentarios_visitas ALTER COLUMN id SET DEFAULT nextval('crm_comentarios_visitas_id_seq'::regclass);


--
-- TOC entry 2824 (class 2604 OID 25293)
-- Name: crm_leads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_leads ALTER COLUMN id SET DEFAULT nextval('crm_leads_id_seq'::regclass);


--
-- TOC entry 2831 (class 2604 OID 25320)
-- Name: crm_servicos_visitas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_servicos_visitas ALTER COLUMN id SET DEFAULT nextval('crm_servicos_visitas_id_seq'::regclass);


--
-- TOC entry 2810 (class 2604 OID 25159)
-- Name: entidades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades ALTER COLUMN id SET DEFAULT nextval('entidades_id_seq'::regclass);


--
-- TOC entry 2833 (class 2604 OID 25381)
-- Name: escritorios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY escritorios ALTER COLUMN id SET DEFAULT nextval('escritorios_id_seq'::regclass);


--
-- TOC entry 2801 (class 2604 OID 25133)
-- Name: etapasprocessuais id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapasprocessuais ALTER COLUMN id SET DEFAULT nextval('etapasprocessuais_id_seq'::regclass);


--
-- TOC entry 2792 (class 2604 OID 25099)
-- Name: localizacoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes ALTER COLUMN id SET DEFAULT nextval('localizacao_id_seq'::regclass);


--
-- TOC entry 2804 (class 2604 OID 25142)
-- Name: tiposdeocorrencia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdeocorrencia ALTER COLUMN id SET DEFAULT nextval('tiposdeocorrencia_id_seq'::regclass);


--
-- TOC entry 2807 (class 2604 OID 25151)
-- Name: tiposdepessoa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdepessoa ALTER COLUMN id SET DEFAULT nextval('pessoas_id_seq'::regclass);


--
-- TOC entry 3036 (class 0 OID 25084)
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
22	novo teste	A	2021-04-07	\N	1	\N
23	TESTE DATA E HORA	X	2021-04-15	\N	1	\N
\.


--
-- TOC entry 3062 (class 0 OID 25306)
-- Dependencies: 227
-- Data for Name: crm_comentarios_visitas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY crm_comentarios_visitas (id, visitas_id, dt_comentario, comentario, situacao, dt_inc, us_inc, dt_alt, us_alt) FROM stdin;
\.


--
-- TOC entry 3059 (class 0 OID 25290)
-- Dependencies: 224
-- Data for Name: crm_leads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY crm_leads (id, dt_cadastro, escritorio_id, entidade_id, grupo_empresarial_id, cnpj_cpf, nome, fantasia, contato, logradouro, numero, bairro, cidade_ibge, uf, cep, telefone, email, cnae_principal, dt_retorno, comentario, situacao, ativo, dt_inc, us_inc, dt_alt, us_alt, pessoa_tipo, complemento) FROM stdin;
3	2021-04-13	1	129	1	37353373415	JOSELITO NASCIMENTO	JOSELITO NASCIMENTO	JOSELITO NASCIMENTO	RUA CASTRO ALVES	105	ENCRUZILHADA	2611606	PE	52030060	99999999	joselito@mcadv.com.br	5201111	\N	SEM COMENTARIOS	1	A	2021-04-13	1	\N	\N	F	\N
\.


--
-- TOC entry 3064 (class 0 OID 25317)
-- Dependencies: 229
-- Data for Name: crm_servicos_visitas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY crm_servicos_visitas (id, visita_id, servico_id, situacao, dt_inc, us_inc, dt_alt, us_alt) FROM stdin;
\.


--
-- TOC entry 3060 (class 0 OID 25299)
-- Dependencies: 225
-- Data for Name: crm_visitas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY crm_visitas (id, lead_id, dt_visita, entidade_id, situacao, dt_inc, us_inc, dt_alt, us_alt) FROM stdin;
\.


--
-- TOC entry 3051 (class 0 OID 25156)
-- Dependencies: 216
-- Data for Name: entidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades (id, pessoa_id, pessoa_tipo, nome, fantasia, cnpj_cpf, insc_mun, insc_est, ativo, dt_inc, dt_alt, us_inc, us_alt) FROM stdin;
183	1	F	joselito	Joselito Jose do Nascimento	90538221003	\N	asasas	A	2021-03-17	\N	1	\N
184	1	F	joselito Nascimento	Joselito Jose do Nascimento	46743258032	\N	\N	A	2021-03-17	\N	1	\N
156	4	F	joselito nascimentor	joselito nascimentor	26634971005			A	2020-07-10	2021-04-05	1	3
187	6	F	joselito Nascimento	Joselito Jose do Nascimento	68882107078	\N	\N	A	2021-04-06	2021-04-06	3	3
155	3	F	joselito	Joselito Jose do Nascimento	37353373415	\N	\N	A	2021-03-16	\N	1	\N
202	3	F	Marcos de Oliveira	Marcos Oliveira	17840232051	\N	\N	A	2021-04-12	\N	3	\N
207	6	F	Marcelo Leão	Marcelo leão	73524168035	\N	\N	A	2021-04-12	\N	3	\N
208	9	F	Valéria Leão	Valéria leão	91481340077	\N	\N	A	2021-04-12	2021-04-12	3	3
129	7	F	Ze Mané de Tota	Zé de Tota	31598804006	\N	\N	A	2021-03-16	\N	1	\N
\.


--
-- TOC entry 3052 (class 0 OID 25178)
-- Dependencies: 217
-- Data for Name: entidades_dados_complementares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_dados_complementares (entidade_id, nome_contato, porte_id, cnae_principal, grupo_empresarial_id) FROM stdin;
183	Joselito Jose do Nascimento	P	6911701	3
184	Joselito Jose do Nascimento	P	6911701	3
\.


--
-- TOC entry 3055 (class 0 OID 25240)
-- Dependencies: 220
-- Data for Name: entidades_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_email (entidade_id, conta, email, ativo, dt_inc, us_inc, dt_alt, us_alt) FROM stdin;
155	teste	joselito_nascimento@yahoo.com.br	A	2021-03-16	1	\N	\N
183	teste	joselito_nascimento@yahoo.com.br	A	2021-03-17	1	\N	\N
184	teste	joselito_nascimento@yahoo.com.br	A	2021-03-17	1	\N	\N
156	teste	joselito_nascimento@yahoo.com.br	A	2021-04-05	3	\N	\N
187	teste	joselito_nascimento@yahoo.com.br	A	2021-04-06	3	\N	\N
202	Marcos Oliveira	joselito_nascimento@yahoo.com.br	A	2021-04-12	3	\N	\N
207	Marcelo	marceloleao@mcadv.com.br	A	2021-04-12	3	\N	\N
208	Valéria	valerialeao@mcadv.com.br	A	2021-04-12	3	\N	\N
\.


--
-- TOC entry 3056 (class 0 OID 25250)
-- Dependencies: 221
-- Data for Name: entidades_enderecos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_enderecos (entidade_id, cep, logradouro, numero, bairro, cidade_ibge, uf, complemento, ativo, dt_inc, dt_alt, us_inc, us_alt) FROM stdin;
207	52030060	Rua Castro Alves	100	Encruzilhada	2611606	PE	\N	A	2021-04-12	\N	3	\N
208	52030060	Rua Castro Alves	100	Encruzilhada	2611606	PE	\N	A	2021-04-12	\N	3	\N
129	52030020	Rua Domingos Bastos	35	Encruzilhada	2611606	PE	casa b	A	2021-03-16	\N	1	\N
155	52030060	Rua Castro Alves	105	Encruzilhada	2611606	PE	apto 703	A	2021-03-16	\N	1	\N
183	52030060	Rua Castro Alves	105	Encruzilhada	2611606	PE	apto 703	A	2021-03-17	\N	1	\N
184	52030060	Rua Castro Alves	105	Encruzilhada	2611606	PE	APT 702	A	2021-03-17	\N	1	\N
156	52030060	Rua Castro Alves	105	Encruzilhada	2611606	PE	\N	A	2021-04-05	\N	3	\N
187	52030060	Rua Castro Alves	105	Encruzilhada	2611606	PE	\N	A	2021-04-06	\N	3	\N
202	52030060	Rua Castro Alves	100	Encruzilhada	2611606	PE	\N	A	2021-04-12	\N	3	\N
\.


--
-- TOC entry 3053 (class 0 OID 25213)
-- Dependencies: 218
-- Data for Name: entidades_estagiario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_estagiario (entidade_id, estagiario_id, dt_inicio, dt_final, dt_inc, us_inc, dt_alt, us_alt, ativo) FROM stdin;
155	129	2021-03-16	\N	2021-03-16	1	\N	\N	A
202	129	2021-04-12	\N	2021-04-12	3	\N	\N	A
\.


--
-- TOC entry 3054 (class 0 OID 25229)
-- Dependencies: 219
-- Data for Name: entidades_oab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_oab (entidade_id, numero_oab, uf_oab, ativo, dt_inc, us_inc, dt_alt, us_alt) FROM stdin;
155	123456	AC	A	2021-03-16	1	\N	\N
202	252525	PE	A	2021-04-12	3	\N	\N
\.


--
-- TOC entry 3057 (class 0 OID 25264)
-- Dependencies: 222
-- Data for Name: entidades_parceiros; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_parceiros (entidade_id, parceiro_id) FROM stdin;
187	156
207	156
\.


--
-- TOC entry 3066 (class 0 OID 25378)
-- Dependencies: 231
-- Data for Name: escritorios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY escritorios (id, nome, fantasia, logradouro, cnpj, inscricao_municipal, numero_nfe, cnae, numero, bairro, cidade_ibge, uf, cep, fonefixo, fonecel, email, perc_pis, perc_cofins, perc_irpj, perc_csll, perc_iss, perc_custo, perc_finan, perc_inss, regime_tributario, valor_limite_tributacao, regime_tributacao_especial, retem_iss, contador_id, responsavel_id, prefeitura, proxy_host, proxy_port, proxy_user, proxy_pass, escritorio_host, escritorio_port, escritorio_user, escritorio_pass, escritorio_email, escritorio_tls, escritorio_ssl, ssltype, ssllib, cryptlib, httplib, xmlsignlib, arq_logo_nfe_emissor, arq_logo_nfe_municipio, certificado_numero, certificado_senha, certificado_path, orientacao_danfe, ambiente_nfe, versao_emissor_nfe, observacao_nfe, ativo, dt_inc, dt_alt, us_inc, us_alt) FROM stdin;
1	MANUEL CAVALCANTE JÚNIOR - SOCIEDADE DE ADVOGADOS	MCJ (PE)	AV. RUI BARBOSA - SALA 1205/1206	08471721000191	3750698	15	6911701	715	GRAÇAS	2611606	PE	52011902	8132158750	\N	naoresponda@mcadv.com.br	0.65	3.00	1.50	1.00	5.00	0.00	16.33	0.00	1	0.00	0	N	1	1	Prefeitura da Cidade do Recife	\N	\N	\N	\N	email-ssl.com.br	465	naoresponda@mcadv.com.br	053056055050064100102086	naoresponda@mcadv.com.br	1	1	0	0	0	0	0	E:\\Baoba\\Imagens\\Logo-NFSe-Recife.jpg	E:\\Baoba\\Imagens\\2611606.jpg	6DEC06A708C7968D	065117100105049054048049077067065068086	\N	R	2	1.00	EMPRESA OPTANTE PELO REGIME DE TRIBUTAÇÃO COM BASE NO SIMPLES NACIONAL	S	2017-09-05	\N	1	\N
\.


--
-- TOC entry 3045 (class 0 OID 25130)
-- Dependencies: 210
-- Data for Name: etapasprocessuais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY etapasprocessuais (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) FROM stdin;
1	teste de etapa processual	2020-12-03	\N	1	\N	A
2	nova etapa processual alterada	2020-12-03	2020-12-03	1	1	A
\.


--
-- TOC entry 3034 (class 0 OID 25073)
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
42	alguma coisa alterada	A	2021-04-09	2021-04-09	1	1
\.


--
-- TOC entry 3039 (class 0 OID 25096)
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
10	novo teste	A	2021-04-07	\N	1	\N
\.


--
-- TOC entry 3042 (class 0 OID 25117)
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
-- TOC entry 3040 (class 0 OID 25104)
-- Dependencies: 205
-- Data for Name: servicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY servicos (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo) FROM stdin;
1	PIS/COFINS - SALDO CREDOR - PRODUÇÃO DE OVOS	2020-11-13	2020-11-13	1	1	A
3	teste de inclusão de os	2020-11-13	\N	1	\N	A
4	bla bla bla bla bla	2020-11-13	\N	1	\N	A
5	Teste de cadastro de serviços	2020-11-17	\N	1	\N	A
6	Teste Etapa Processual	2020-12-03	\N	1	\N	A
7	novo serviço de teste	2021-04-07	\N	1	\N	A
\.


--
-- TOC entry 3047 (class 0 OID 25139)
-- Dependencies: 212
-- Data for Name: tiposdeocorrencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tiposdeocorrencia (id, descricao, dt_inc, dt_alt, us_inc, us_alt, ativo, tipo_faturar) FROM stdin;
1	AÇÃO PROPOSTA	2020-12-11	2021-04-07	1	1	A	S
2	CUSTAS PAGAS	2020-12-11	2021-04-07	1	1	A	N
3	AUTOS CONCLUSOS PARA DESPACHO	2020-12-11	2021-04-07	1	1	A	N
5	noto tipo de ocorrencia	2021-04-07	\N	1	\N	A	S
4	aaaa noco teste	2021-04-07	2021-04-07	1	1	A	 
6	sasasas	2021-04-07	2021-04-07	1	1	A	N
\.


--
-- TOC entry 3049 (class 0 OID 25148)
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
-- TOC entry 3032 (class 0 OID 25056)
-- Dependencies: 197
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarios (id, user_name, email, password, perfil_id, ativo, dt_inc, dt_alt, us_inc, us_alt, entidade_id) FROM stdin;
3	Joselito	joselito_nascimento@yahoo.com.br	$2b$10$hOBDMX/ao4XNg6kp5GMusuOiWPsr0xsFfuSIlrAbRYtVBzdeob9ru	1	A	2020-07-10	\N	1	\N	1
\.


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 202
-- Name: acoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('acoes_id_seq', 23, true);


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 226
-- Name: crm_comentarios_visitas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('crm_comentarios_visitas_id_seq', 1, false);


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 223
-- Name: crm_leads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('crm_leads_id_seq', 3, true);


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 228
-- Name: crm_servicos_visitas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('crm_servicos_visitas_id_seq', 1, false);


--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 215
-- Name: entidades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('entidades_id_seq', 208, true);


--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 232
-- Name: escritorio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('escritorio_id_seq', 1, false);


--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 230
-- Name: escritorios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('escritorios_id_seq', 1, false);


--
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 209
-- Name: etapasprocessuais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('etapasprocessuais_id_seq', 3, true);


--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 200
-- Name: grupoempresarial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('grupoempresarial_id_seq', 42, true);


--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 203
-- Name: localizacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('localizacao_id_seq', 10, true);


--
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 208
-- Name: orgaoscompetentes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orgaoscompetentes_id_seq', 23, false);


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 213
-- Name: pessoas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pessoas_id_seq', 1, false);


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 206
-- Name: servicos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('servicos_id_seq', 7, true);


--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 198
-- Name: tbusuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tbusuarios_id_seq', 3, true);


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 211
-- Name: tiposdeocorrencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tiposdeocorrencia_id_seq', 6, true);


--
-- TOC entry 2858 (class 2606 OID 25091)
-- Name: acoes acoes_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY acoes
    ADD CONSTRAINT acoes_descricao_key UNIQUE (descricao);


--
-- TOC entry 2860 (class 2606 OID 25089)
-- Name: acoes acoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY acoes
    ADD CONSTRAINT acoes_pkey PRIMARY KEY (id);


--
-- TOC entry 2894 (class 2606 OID 25314)
-- Name: crm_comentarios_visitas comentarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_comentarios_visitas
    ADD CONSTRAINT comentarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2896 (class 2606 OID 25322)
-- Name: crm_servicos_visitas crm_servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_servicos_visitas
    ADD CONSTRAINT crm_servicos_pkey PRIMARY KEY (id);


--
-- TOC entry 2882 (class 2606 OID 25218)
-- Name: entidades_estagiario entidade_estagiario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_estagiario
    ADD CONSTRAINT entidade_estagiario_pkey PRIMARY KEY (entidade_id, estagiario_id);


--
-- TOC entry 2880 (class 2606 OID 25182)
-- Name: entidades_dados_complementares entidades_dados_complementares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_pkey PRIMARY KEY (entidade_id);


--
-- TOC entry 2886 (class 2606 OID 25244)
-- Name: entidades_email entidades_email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_email
    ADD CONSTRAINT entidades_email_pkey PRIMARY KEY (entidade_id, conta, email);


--
-- TOC entry 2884 (class 2606 OID 25234)
-- Name: entidades_oab entidades_oab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_oab
    ADD CONSTRAINT entidades_oab_pkey PRIMARY KEY (entidade_id, numero_oab, uf_oab);


--
-- TOC entry 2878 (class 2606 OID 25165)
-- Name: entidades entidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades
    ADD CONSTRAINT entidades_pkey PRIMARY KEY (id);


--
-- TOC entry 2898 (class 2606 OID 25396)
-- Name: escritorios escritorios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY escritorios
    ADD CONSTRAINT escritorios_pkey PRIMARY KEY (id);


--
-- TOC entry 2871 (class 2606 OID 25136)
-- Name: etapasprocessuais etapasprocessuais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapasprocessuais
    ADD CONSTRAINT etapasprocessuais_pkey PRIMARY KEY (id);


--
-- TOC entry 2854 (class 2606 OID 25081)
-- Name: gruposempresariais grupoempresarial_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruposempresariais
    ADD CONSTRAINT grupoempresarial_descricao_key UNIQUE (descricao);


--
-- TOC entry 2856 (class 2606 OID 25079)
-- Name: gruposempresariais grupoempresarial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruposempresariais
    ADD CONSTRAINT grupoempresarial_pkey PRIMARY KEY (id);


--
-- TOC entry 2890 (class 2606 OID 25298)
-- Name: crm_leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- TOC entry 2862 (class 2606 OID 25103)
-- Name: localizacoes localizacao_descricao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes
    ADD CONSTRAINT localizacao_descricao_key UNIQUE (descricao);


--
-- TOC entry 2864 (class 2606 OID 25101)
-- Name: localizacoes localizacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localizacoes
    ADD CONSTRAINT localizacao_pkey PRIMARY KEY (id);


--
-- TOC entry 2869 (class 2606 OID 25122)
-- Name: orgaoscompetentes orgaoscompetentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orgaoscompetentes
    ADD CONSTRAINT orgaoscompetentes_pkey PRIMARY KEY (id);


--
-- TOC entry 2888 (class 2606 OID 25268)
-- Name: entidades_parceiros parceiros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_parceiros
    ADD CONSTRAINT parceiros_pkey PRIMARY KEY (entidade_id, parceiro_id);


--
-- TOC entry 2866 (class 2606 OID 25115)
-- Name: servicos servicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY servicos
    ADD CONSTRAINT servicos_pkey PRIMARY KEY (id);


--
-- TOC entry 2875 (class 2606 OID 25153)
-- Name: tiposdepessoa tbpessoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdepessoa
    ADD CONSTRAINT tbpessoa_pkey PRIMARY KEY (id);


--
-- TOC entry 2847 (class 2606 OID 25067)
-- Name: usuarios tbusuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_email_key UNIQUE (email);


--
-- TOC entry 2849 (class 2606 OID 25071)
-- Name: usuarios tbusuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 2852 (class 2606 OID 25065)
-- Name: usuarios tbusuarios_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT tbusuarios_user_name_key UNIQUE (user_name);


--
-- TOC entry 2873 (class 2606 OID 25145)
-- Name: tiposdeocorrencia tiposdeocorrencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiposdeocorrencia
    ADD CONSTRAINT tiposdeocorrencia_pkey PRIMARY KEY (id);


--
-- TOC entry 2892 (class 2606 OID 25303)
-- Name: crm_visitas visitas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_visitas
    ADD CONSTRAINT visitas_pkey PRIMARY KEY (id);


--
-- TOC entry 2876 (class 1259 OID 25172)
-- Name: entidades_cnpj_cpf_unique__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX entidades_cnpj_cpf_unique__idx ON public.entidades USING btree (cnpj_cpf);


--
-- TOC entry 2867 (class 1259 OID 25126)
-- Name: orgaoscompetentes_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX orgaoscompetentes_idx ON public.orgaoscompetentes USING btree (descricao);


--
-- TOC entry 2850 (class 1259 OID 25062)
-- Name: tbusuarios_user_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tbusuarios_user_name_idx ON public.usuarios USING btree (user_name);


--
-- TOC entry 2909 (class 2606 OID 25333)
-- Name: crm_leads crm_leads_entidades_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_leads
    ADD CONSTRAINT crm_leads_entidades_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2910 (class 2606 OID 25343)
-- Name: crm_leads crm_leads_grupos_empresariais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY crm_leads
    ADD CONSTRAINT crm_leads_grupos_empresariais_fk FOREIGN KEY (grupo_empresarial_id) REFERENCES gruposempresariais(id) ON DELETE CASCADE;


--
-- TOC entry 2902 (class 2606 OID 25219)
-- Name: entidades_estagiario entidade_estagiario_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_estagiario
    ADD CONSTRAINT entidade_estagiario_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2903 (class 2606 OID 25224)
-- Name: entidades_estagiario entidade_estagiario_estagiario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_estagiario
    ADD CONSTRAINT entidade_estagiario_estagiario_fk FOREIGN KEY (estagiario_id) REFERENCES entidades(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2900 (class 2606 OID 25194)
-- Name: entidades_dados_complementares entidades_dados_complementares_entidade_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_entidade_id_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2901 (class 2606 OID 25199)
-- Name: entidades_dados_complementares entidades_dados_complementares_grupo_empresarial_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_dados_complementares
    ADD CONSTRAINT entidades_dados_complementares_grupo_empresarial_fk1 FOREIGN KEY (grupo_empresarial_id) REFERENCES gruposempresariais(id) ON DELETE RESTRICT;


--
-- TOC entry 2905 (class 2606 OID 25245)
-- Name: entidades_email entidades_email_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_email
    ADD CONSTRAINT entidades_email_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2899 (class 2606 OID 25173)
-- Name: entidades entidades_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades
    ADD CONSTRAINT entidades_fk FOREIGN KEY (pessoa_id) REFERENCES tiposdepessoa(id);


--
-- TOC entry 2906 (class 2606 OID 25259)
-- Name: entidades_enderecos entidades_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_enderecos
    ADD CONSTRAINT entidades_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2904 (class 2606 OID 25235)
-- Name: entidades_oab entidades_oab_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_oab
    ADD CONSTRAINT entidades_oab_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2907 (class 2606 OID 25269)
-- Name: entidades_parceiros parceiros_entidade_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_parceiros
    ADD CONSTRAINT parceiros_entidade_fk FOREIGN KEY (entidade_id) REFERENCES entidades(id) ON DELETE CASCADE;


--
-- TOC entry 2908 (class 2606 OID 25274)
-- Name: entidades_parceiros parceiros_parceiro_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY entidades_parceiros
    ADD CONSTRAINT parceiros_parceiro_fk FOREIGN KEY (parceiro_id) REFERENCES entidades(id) ON DELETE CASCADE;


-- Completed on 2021-04-20 17:00:50

--
-- PostgreSQL database dump complete
--


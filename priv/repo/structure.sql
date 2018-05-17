--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE images (
    id bigint NOT NULL,
    url character varying(255),
    alt character varying(255),
    caption character varying(255),
    poll_id bigint,
    user_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE messages (
    id bigint NOT NULL,
    message character varying(255),
    author character varying(255),
    poll_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE options (
    id bigint NOT NULL,
    title character varying(255),
    votes integer DEFAULT 0,
    poll_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE options_id_seq OWNED BY options.id;


--
-- Name: polls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE polls (
    id bigint NOT NULL,
    title character varying(255),
    description text,
    user_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: polls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE polls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: polls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE polls_id_seq OWNED BY polls.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id bigint NOT NULL,
    username character varying(255),
    email character varying(255),
    password_hash character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    token character varying(255),
    provider character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: vote_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE vote_records (
    id bigint NOT NULL,
    ip_address character varying(255),
    poll_id bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: vote_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE vote_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: vote_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE vote_records_id_seq OWNED BY vote_records.id;


--
-- Name: images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY options ALTER COLUMN id SET DEFAULT nextval('options_id_seq'::regclass);


--
-- Name: polls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY polls ALTER COLUMN id SET DEFAULT nextval('polls_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: vote_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY vote_records ALTER COLUMN id SET DEFAULT nextval('vote_records_id_seq'::regclass);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- Name: polls polls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT polls_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vote_records vote_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY vote_records
    ADD CONSTRAINT vote_records_pkey PRIMARY KEY (id);


--
-- Name: messages_poll_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX messages_poll_id_index ON messages USING btree (poll_id);


--
-- Name: options_poll_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX options_poll_id_index ON options USING btree (poll_id);


--
-- Name: polls_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX polls_user_id_index ON polls USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON users USING btree (email);


--
-- Name: users_username_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_username_index ON users USING btree (username);


--
-- Name: images images_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES polls(id);


--
-- Name: images images_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: messages messages_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES polls(id);


--
-- Name: options options_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY options
    ADD CONSTRAINT options_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES polls(id);


--
-- Name: polls polls_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT polls_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: vote_records vote_records_poll_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY vote_records
    ADD CONSTRAINT vote_records_poll_id_fkey FOREIGN KEY (poll_id) REFERENCES polls(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20180514223045), (20180515165901), (20180516145805), (20180516150338), (20180517013414), (20180517033006), (20180517044048);


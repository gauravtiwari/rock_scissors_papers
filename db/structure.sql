--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    play_id integer,
    sender_id integer,
    body text,
    created_at timestamp without time zone NOT NULL,
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
-- Name: moves; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE moves (
    id integer NOT NULL,
    play_id integer,
    player_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_id integer,
    player_choice character varying,
    opponent_choice character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: moves_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE moves_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: moves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE moves_id_seq OWNED BY moves.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE players (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    nickname character varying DEFAULT ''::character varying NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_id integer,
    invited_by_type character varying,
    invitations_count integer DEFAULT 0
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE players_id_seq OWNED BY players.id;


--
-- Name: plays; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plays (
    id integer NOT NULL,
    player_id integer,
    opponent_id integer,
    winner_id integer,
    looser_id integer,
    min_moves integer DEFAULT 3,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: plays_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE plays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE plays_id_seq OWNED BY plays.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY moves ALTER COLUMN id SET DEFAULT nextval('moves_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY players ALTER COLUMN id SET DEFAULT nextval('players_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY plays ALTER COLUMN id SET DEFAULT nextval('plays_id_seq'::regclass);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: moves_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY moves
    ADD CONSTRAINT moves_pkey PRIMARY KEY (id);


--
-- Name: players_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: plays_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plays
    ADD CONSTRAINT plays_pkey PRIMARY KEY (id);


--
-- Name: index_messages_on_play_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_play_id ON messages USING btree (play_id);


--
-- Name: index_messages_on_play_id_and_sender_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_play_id_and_sender_id ON messages USING btree (play_id, sender_id);


--
-- Name: index_messages_on_sender_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_sender_id ON messages USING btree (sender_id);


--
-- Name: index_moves_on_opponent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_moves_on_opponent_id ON moves USING btree (opponent_id);


--
-- Name: index_moves_on_play_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_moves_on_play_id ON moves USING btree (play_id);


--
-- Name: index_moves_on_play_id_and_opponent_id_and_opponent_choice; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_moves_on_play_id_and_opponent_id_and_opponent_choice ON moves USING btree (play_id, opponent_id, opponent_choice);


--
-- Name: index_moves_on_play_id_and_player_id_and_player_choice; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_moves_on_play_id_and_player_id_and_player_choice ON moves USING btree (play_id, player_id, player_choice);


--
-- Name: index_moves_on_play_id_and_winner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_moves_on_play_id_and_winner_id ON moves USING btree (play_id, winner_id);


--
-- Name: index_moves_on_player_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_moves_on_player_id ON moves USING btree (player_id);


--
-- Name: index_moves_on_winner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_moves_on_winner_id ON moves USING btree (winner_id);


--
-- Name: index_players_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_players_on_email ON players USING btree (email);


--
-- Name: index_players_on_invitation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_players_on_invitation_token ON players USING btree (invitation_token);


--
-- Name: index_players_on_invitations_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_players_on_invitations_count ON players USING btree (invitations_count);


--
-- Name: index_players_on_invited_by_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_players_on_invited_by_id ON players USING btree (invited_by_id);


--
-- Name: index_players_on_nickname; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_players_on_nickname ON players USING btree (nickname);


--
-- Name: index_players_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_players_on_reset_password_token ON players USING btree (reset_password_token);


--
-- Name: index_plays_on_looser_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plays_on_looser_id ON plays USING btree (looser_id);


--
-- Name: index_plays_on_min_moves; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plays_on_min_moves ON plays USING btree (min_moves);


--
-- Name: index_plays_on_opponent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plays_on_opponent_id ON plays USING btree (opponent_id);


--
-- Name: index_plays_on_player_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plays_on_player_id ON plays USING btree (player_id);


--
-- Name: index_plays_on_winner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plays_on_winner_id ON plays USING btree (winner_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_28a8ec35f5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY moves
    ADD CONSTRAINT fk_rails_28a8ec35f5 FOREIGN KEY (player_id) REFERENCES players(id);


--
-- Name: fk_rails_443b58301c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plays
    ADD CONSTRAINT fk_rails_443b58301c FOREIGN KEY (player_id) REFERENCES players(id);


--
-- Name: fk_rails_b28c665d59; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY moves
    ADD CONSTRAINT fk_rails_b28c665d59 FOREIGN KEY (play_id) REFERENCES plays(id);


--
-- Name: fk_rails_dfa393f0dc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_dfa393f0dc FOREIGN KEY (play_id) REFERENCES plays(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150919191713');

INSERT INTO schema_migrations (version) VALUES ('20150919191816');

INSERT INTO schema_migrations (version) VALUES ('20150919211236');

INSERT INTO schema_migrations (version) VALUES ('20150919213150');

INSERT INTO schema_migrations (version) VALUES ('20150919215200');

INSERT INTO schema_migrations (version) VALUES ('20150920171949');


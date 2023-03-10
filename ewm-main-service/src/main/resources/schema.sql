CREATE TABLE IF NOT EXISTS category (
                          category_id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                          category_name VARCHAR,
                          CONSTRAINT pk_category PRIMARY KEY (category_id),
                          CONSTRAINT UQ_CATEGORY UNIQUE (category_name)
);

CREATE TABLE IF NOT EXISTS locations (
                           location_id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                           lat FLOAT NOT NULL,
                           lon FLOAT NOT NULL,
                           CONSTRAINT pk_location PRIMARY KEY (location_id),
                           CONSTRAINT UQ_COORDINATES UNIQUE (lat, lon)
);
CREATE TABLE IF NOT EXISTS users (
                       user_id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                       user_name VARCHAR(255) NOT NULL,
                       email VARCHAR(512) NOT NULL,
                       CONSTRAINT pk_user PRIMARY KEY (user_id),
                       CONSTRAINT UQ_USER_EMAIL UNIQUE (email)

);

CREATE TABLE IF NOT EXISTS events (
                        event_id BIGINT GENERATED BY DEFAULT  AS IDENTITY NOT NULL,
                        annotation varchar NOT NULL ,
                        category_id BIGINT references category (category_id),
                        confirmed_requests INT,
                        created_on timestamp,
                        description varchar NOT NULL ,
                        event_date timestamp,
                        initiator BIGINT references  users (user_id),
                        location BIGINT references locations (location_id),
                        paid boolean,
                        participant_limit int,
                        published_on timestamp,
                        request_moderation boolean NOT NULL,
                        state varchar(255),
                        title varchar,
    comment boolean,
                        CONSTRAINT pk_event PRIMARY KEY (event_id)
);


 CREATE TABLE IF NOT EXISTS participation_requests (
                                          request_id BIGINT GENERATED BY DEFAULT  AS IDENTITY NOT NULL,
                                          created timestamp,
                                          event_id BIGINT REFERENCES events(event_id),
                                          requester BIGINT REFERENCES users(user_id),
                                          status varchar(255),
                                          CONSTRAINT pk_request PRIMARY KEY (request_id),
                                          CONSTRAINT UQ_EVENT_REQUESTER UNIQUE (event_id, requester)
);

 CREATE TABLE IF NOT EXISTS compilations (
                                compilation_id BIGINT GENERATED BY DEFAULT  AS IDENTITY NOT NULL,
                                pinned boolean,
                                title varchar(255),
                                CONSTRAINT pk_compilation PRIMARY KEY (compilation_id)

);

CREATE TABLE IF NOT EXISTS compilation_event (
                                     compilation_id BIGINT  REFERENCES compilations (compilation_id),
                                     event_id BIGINT  references events (event_id),
                                     CONSTRAINT pk_compilation_event PRIMARY KEY (compilation_id, event_id)
);

CREATE TABLE IF NOT EXISTS comments (
                                        comment_id BIGINT GENERATED BY DEFAULT  AS IDENTITY NOT NULL,
                                        event BIGINT references  events (event_id),
                                        author BIGINT references  users (user_id),
                                        message varchar NOT NULL,
                                        createTime timestamp NOT NULL,
                                        CONSTRAINT pk_comment PRIMARY KEY (comment_id)
);

CREATE TABLE IF NOT EXISTS comments_event (
                                        comment_id BIGINT  REFERENCES comments (comment_id),
                                        event_id BIGINT  references events (event_id),
                                        CONSTRAINT pk_compilation_event PRIMARY KEY (comment_id, event_id)
);
CREATE TABLE IF NOT EXISTS comments_user(
                                        comment_id BIGINT  REFERENCES comments (comment_id),
                                        user_id BIGINT  references users (user_id),
                                        CONSTRAINT pk_compilation_event PRIMARY KEY (comment_id, user_id)
);
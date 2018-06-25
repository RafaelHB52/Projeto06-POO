DROP TABLE users;
CREATE TABLE users(
    id BIGINT not null primary key
        GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1)
    , role varchar(200) not null
    , name varchar(200) not null
    , login varchar(20) not null
    , passwordHash BIGINT not null
);
INSERT INTO users VALUES
(default, 'ADMIN', 'Administrador', 'admin', 1509442);
INSERT INTO users VALUES
(default, 'OPERADOR', 'Roberto', 'roberto', 1509442);

DROP TABLE movies;
CREATE TABLE movies(
    id BIGINT not null primary key
        GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1)
    , genre varchar(200) not null
    , name varchar(200) not null
    , release TIMESTAMP not null
    , stock varchar(3) not null
    , price DOUBLE PRECISION not null
);
INSERT INTO movies VALUES
(default, 'TERROR', 'Fatec PG', '2018-06-26 13:30:00', 'SIM', 3.85);


DROP TABLE leased_movies;
CREATE TABLE leased_movies(
    id BIGINT not null primary key
        GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1)
    , name varchar(200) not null
    , client varchar(200) not null
    , begin_period TIMESTAMP not null
    , end_period TIMESTAMP
    , price DOUBLE PRECISION
    /*, CONSTRAINT id_movies FOREIGN KEY(id) REFERENCES movies(id) */
);

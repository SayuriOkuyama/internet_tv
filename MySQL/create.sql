CREATE DATABASE internet_tv;

CREATE TABLE channels (
    channel_no INTEGER NOT NULL AUTO_INCREMENT,
    channel_name VARCHAR(50) NOT NULL UNIQUE KEY,
    PRIMARY KEY (channel_no)
);

CREATE TABLE genres (
    genre_no INTEGER NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(20) NOT NULL UNIQUE KEY,
    PRIMARY KEY (genre_no)
);

CREATE TABLE programs (
    program_no INTEGER NOT NULL AUTO_INCREMENT,
    program_name VARCHAR(100) NOT NULL UNIQUE KEY,
    program_detail VARCHAR(500) NOT NULL,
    PRIMARY KEY (program_no)
);

CREATE TABLE episodes (
    episode_index INTEGER NOT NULL AUTO_INCREMENT,
    program_no INTEGER NOT NULL,
    season_no INTEGER,
    episode_no INTEGER,
    episode_name VARCHAR(100) NOT NULL UNIQUE KEY,
    episode_detail VARCHAR(500) NOT NULL,
    video_length TIME NOT NULL,
    publication_at DATE NOT NULL,
    viewers INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (episode_index),
    UNIQUE KEY (program_no, season_no, episode_no),
    FOREIGN KEY (program_no) REFERENCES programs(program_no)
);

CREATE TABLE program_genres (
    program_no INTEGER NOT NULL,
    genre_no INTEGER NOT NULL,
    PRIMARY KEY (program_no, genre_no),
    FOREIGN KEY (program_no) REFERENCES programs(program_no),
    FOREIGN KEY (genre_no) REFERENCES genres(genre_no)
);

CREATE TABLE program_schedules (
    channel_no INTEGER NOT NULL,
    broadcasting_at DATETIME NOT NULL,
    episode_index INTEGER NOT NULL,
    PRIMARY KEY (channel_no, broadcasting_at),
    FOREIGN KEY (channel_no) REFERENCES channels(channel_no),
    FOREIGN KEY (episode_index) REFERENCES episodes(episode_index)
);
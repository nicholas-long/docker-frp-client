create table targets(
    id INT NOT NULL AUTO_INCREMENT,
    ip VARCHAR(20) NOT NULL,
    port INT NOT NULL,
    valid INT NOT NULL,
    PRIMARY KEY(id)
);

DROP INDEX IF EXISTS IX_machine_drink;


DROP INDEX IF EXISTS IX_machine_count;


DROP INDEX IF EXISTS IX_machine_price;


DROP INDEX IF EXISTS IX_machine_wallet_value;


DROP INDEX IF EXISTS IX_my_wallet_value;


DROP TABLE IF EXISTS machine;


DROP TABLE IF EXISTS machine_wallet;


DROP TABLE IF EXISTS my_wallet;


DROP TABLE IF EXISTS coins_value;

--в случае наличия таблицы с таким же именем - удаляем ее


CREATE TABLE coins_value(PK_coins_value_id serial PRIMARY KEY, value integer check(value >= 0));
--таблица, в которой будем хранить id и номиналы, чтоб не хранить их в других таблицах

CREATE TABLE machine(	--создаем таблицу ассортимента автомата
 id serial PRIMARY KEY,	--айдишник каждого элемента
 drink varchar (20) NOT NULL,	--тип напитка
 COUNT integer check(COUNT >= 0),	--кол-во напитков доступных для продажи
 price integer	--цена напитка
);


CREATE INDEX IX_machine_drink ON machine(drink);


CREATE INDEX IX_machine_count ON machine(COUNT);


CREATE INDEX IX_machine_price ON machine(price);
--создаем индексы по шаблону из задания №3

CREATE TABLE machine_wallet(	--создаем таблицу кошелька автомата
 FK_machine_wallet_id integer,	--value integer check(value >= 0),    --виды купюр(10,5,2,1)
 COUNT integer check(COUNT >= 0),
   FOREIGN KEY (FK_machine_wallet_id) REFERENCES coins_value(PK_coins_value_id) ON DELETE CASCADE);
--устанавливаем внешний ключ

CREATE INDEX IX_machine_wallet_value ON machine_wallet(FK_machine_wallet_id);
--создаем индексы по шаблону из задания №3


CREATE TABLE my_wallet
  (--аналогично создаем кошелек для пользователя
 FK_my_wallet_id integer, --value integer check(value >= 0),
 COUNT integer check(COUNT >= 0),
   FOREIGN KEY (FK_my_wallet_id) REFERENCES coins_value(PK_coins_value_id) ON DELETE CASCADE);
--устанавливаем внешний ключ

CREATE INDEX IX_my_wallet_value ON my_wallet(FK_my_wallet_id);


INSERT INTO machine(drink, COUNT, price)
VALUES('чай', 0, 25);


INSERT INTO machine(drink, COUNT, price)
VALUES('капучино', 0, 39);


INSERT INTO machine(drink, COUNT, price)
VALUES('какао', 0, 23);


INSERT INTO machine(drink, COUNT, price)
VALUES('шоколад', 0, 31);


INSERT INTO coins_value(value)
VALUES(10);


INSERT INTO coins_value(value)
VALUES(5);


INSERT INTO coins_value(value)
VALUES(2);


INSERT INTO coins_value(value)
VALUES(1);


INSERT INTO machine_wallet
SELECT PK_coins_value_id AS FK_machine_wallet_id,
       0 AS COUNT
FROM coins_value;


INSERT INTO my_wallet
SELECT PK_coins_value_id AS FK_my_wallet_id,
       0 AS COUNT
FROM coins_value;
--заполняем вручную таблицы начальными данными

UPDATE machine_wallet
SET COUNT = 10
WHERE COUNT = 0;
--"кошелек автомата содержать набор монет каждого номинала по 10 шт."

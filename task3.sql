CREATE FUNCTION sell(coin_value integer) RETURNS void AS $$
begin
UPDATE my_wallet
SET COUNT = COUNT + 1	--увеличим счетчик монет определенного номинала
WHERE my_wallet.FK_my_wallet_id IN
    (SELECT my_wallet.FK_my_wallet_id
     FROM coins_value	--сливаем две таблицы по id, чтоб выбрать номинал монеты
     JOIN my_wallet ON coins_value.PK_coins_value_id = my_wallet.FK_my_wallet_id
     WHERE value = coin_value );	--находим нужный нам номинал
end;
$$ LANGUAGE PLPGSQL;

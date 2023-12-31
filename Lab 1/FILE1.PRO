%факт: товар(id товара, название, категория, цена).
товар(1, "футболка", одежда, 600).
товар(2, "кроссовки", обувь, 2500).
товар(3, "рюкзак", аксессуары, 1000).
товар(4, "куртка", верхняя_одежда, 5000).
товар(5, "брюки", одежда, 1600).
товар(6, "ботинки", обувь, 3500).
товар(7, "солнцезащитные_очки", аксессуары, 450).
товар(8, "плащ", верхняя_одежда, 4000).
товар(9, "шапка", аксессуары, 350).
товар(10, "свитер", одежда, 2000).
товар(11, "туфли", обувь, 1500).
товар(12, "пальто", верхняя_одежда, 6000).

%факт: покупатель(имя, номер телефона, статус покупателя).
покупатель("Гарри Поттер", 1234, silver).
покупатель("Гермиона Грейнджер", 5678, gold).
покупатель("Рон Уизли", 9101, standart).
покупатель("Драко Малфой", 1121, standart).
покупатель("Альбус Дамблдор", 3141, silver).
покупатель("Джинни Уизли", 5161, gold).
покупатель("Том Реддл", 7181, silver).
покупатель("Седрик Диггори", 9202, gold).
покупатель("Сириус Блэк", 1222, standart).
покупатель("Невилл Долгопупс", 3242, silver).

%факт: покупка(телефон покупателя, id товара, количество товара, дата покупки)
покупка(1234, 1, 1, "01.09.2023").
покупка(1234, 2, 2, "01.09.2023").
покупка(1234, 3, 1, "03.09.2023").
покупка(5678, 4, 1, "02.09.2023").
покупка(5678, 5, 1, "02.09.2023").
покупка(5678, 6, 1, "01.09.2023").
покупка(9101, 7, 3, "03.09.2023").
покупка(9101, 8, 1, "02.09.2023").
покупка(9101, 9, 7, "01.09.2023").
покупка(1121, 10, 1, "02.09.2023").
покупка(1121, 11, 1, "03.09.2023").
покупка(1121, 12, 1, "02.09.2023").
покупка(3141, 1, 3, "02.09.2023").
покупка(3141, 2, 1, "02.09.2023").
покупка(5161, 3, 1, "01.09.2023").
покупка(5161, 4, 1, "03.09.2023").
покупка(7181, 5, 1, "01.09.2023").
покупка(7181, 6, 1, "02.09.2023").
покупка(9202, 7, 1, "01.09.2023").
покупка(9202, 8, 2, "03.09.2023").
покупка(1222, 9, 1, "02.09.2023").
покупка(1222, 10, 2, "03.09.2023").
покупка(3242, 11, 1, "02.09.2023").
покупка(3242, 12, 1, "01.09.2023").

%правило: выводит название товара и цену по категории товара
товар(Категория, Товар, Цена) :-
    товар(_, Товар, Категория, Цена).
    
%правило: выводит имена покупателей по статусу/выводит статус по имени покупателя
статус_покупателя(Покупатель, Статус) :-
    покупатель(Покупатель, _, Статус).
    
%правило: выводит имена покупателей, которые купили определенный товар
купили_товар(Товар, Покупатель) :-
    товар(Id, Товар, _, _),
    покупатель(Покупатель, Телефон, _),
    покупка(Телефон, Id, _, _).
    
%правило: выводит товары на сумму до введенного значения суммы
товары_на_сумму_до(Сумма, Товар) :-
    товар(_, Товар, _, Цена),
    Цена < Сумма,
    write("Товары до ", Сумма, " рублей: ").
    
%правило: выводит названия товаров, их количство и потраченную сумму определенного покупателя
сумма_покупки_товаров(Покупатель, Товар, Количество, Сумма) :-
    товар(Id, Товар, _, Цена),
    покупатель(Покупатель, Телефон, _),
    покупка(Телефон, Id, Количество, _),
    Сумма is Количество * Цена.
    
%правило: выводит размер скидки для покупателей по их статусу 
скидки_покупателю(Покупатель, Скидка) :- 
    покупатель(Покупатель, _, standart),
    Скидка is "5%";
    покупатель(Покупатель, _, silver),
    Скидка is "10%";
    покупатель(Покупатель, _, gold),
    Скидка is "20%".
    
%правило: выводит цену товара с учетом скидкой по имени покупателя
цена_с_учетом_скидки(Покупатель, Товар, Скидка, Итоговая_Цена) :-
    товар(Id, Товар, _, Цена),
    покупка(Телефон, Id, _, _),
    покупатель(Покупатель, Телефон, standart),
    Скидка is Цена * 0.05,
    Итоговая_Цена is Цена - Скидка;
    товар(Id, Товар, _, Цена),
    покупка(Телефон, Id, _, _),
    покупатель(Покупатель, Телефон, silver),
    Скидка is Цена * 0.1,
    Итоговая_Цена is Цена - Скидка;
    товар(Id, Товар, _, Цена),
    покупка(Телефон, Id, _, _),
    покупатель(Покупатель, Телефон, gold),
    Скидка is Цена * 0.2,
    Итоговая_Цена is Цена - Скидка.
    
%правило: выводит названия товаров и их количество, проданные в определенный день
товары_проданные_в_день(Дата, Товар, Количество) :-
    товар(Id, Товар, _, Цена),
    покупка(_, Id, Количество, Дата).
    
    
/* запросы

товар(обувь, Товар, Цена)

статус_покупателя('Гарри Поттер', Статус)

купили_товар(ботинки, Покупатель)

товары_на_сумму_до(2000, Товар)

сумма_покупки_товаров('Джинни Уизли', Товар, Количество, Сумма)

скидки_покупателю('Седрик Диггори', Скидка)

цена_с_учетом_скидки('Гермиона Грейнджер', Товар, Скидка, Итоговая_Цена)

товары_проданные_в_день('02.09.2023', Товар, Количество)
*/
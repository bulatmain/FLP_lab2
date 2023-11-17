tezka(voron, voronov).
tezka(golub, golubev).
tezka(kanareika, kanareikin).
tezka(grach, grachev).
tezka(chaika, chaikin).
tezka(popugai, popugaev).
tezka(skvorec, skvorcov).
 
solve_rebus(Ans, SkvorecOwner):-
    % A, B, C, ..., G - переменные, олицетворяющие птиц,
    % Ans - список пар [хозяин; птица] .
    Ans = [voronov/A, golubev/B, kanareikin/C, grachev/D, chaikin/E, popugaev/F, skvorcov/G],
    % Переберем все комбинации [хозяин; птица].
    permutation([voron, golub, kanareika, grach, chaika, popugai, skvorec], [A, B, C, D, E, F, G]),
    % Будем считать, что ворон, грач и скворец - самые темные из всех птиц.
    Dark = [voron, grach, skvorec],

    % Из 3 предложения.
    member(VoronOwner/voron, Ans), tezka(TezkaVO, VoronOwner), not(member(TezkaVO, Dark)),
    member(GrachOwner/grach, Ans), tezka(TezkaGO, GrachOwner), not(member(TezkaGO, Dark)),
    member(SkvorecOwner/skvorec, Ans), tezka(TezkaSO, SkvorecOwner), not(member(TezkaSO, Dark)),

    % Из 4, 5 и того, что А - птица Воронова следует, что ни первый, ни второй не могут быть тезками А.
    not(tezka(A, golubev)), not(tezka(A, kanareikin)),
    % ИЗ 6 и того, что B, C - птицы голубева и канарейкина соответственно, следует, что ни B, ни C не могут быть грачом.
    B \= grach, C \= grach,
    % Из 6 следует, что владелец грача не может быть Чайкином, ведь Чайкин не может быть женат на сестре своей жены
    GrachOwner \= chaikin,
    % Раз у хозяина ворона есть невеста, то это кто-то из холостяков
    (B == voron; C == voron), 
    % Реализация 8-го ограничения (D - птица Грачева)
    tezka(D, KanareikaOwner), member(KanareikaOwner/kanareika, Ans), 
    % Реализация 9 ограничения% Тёзка птицы Грачёва - хозяин канарейки
    member(PopugaiOwner/popugai, Ans), tezka(TezkaPO, PopugaiOwner),
    member(OwnerTPO/TezkaPO, Ans), tezka(TezkaOTPO, OwnerTPO),
    member(voronov/TezkaOTPO, Ans), !.

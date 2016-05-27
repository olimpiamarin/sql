

-- 1. INSERT

insert into useri
values (1, 'maria', 'bababatrana', 29, 'Mures', 0)

insert into useri
values (5, 'dani', 'covrig', 17, 'Turda', 1)


insert into postari
values (1, '2016-05-23', 'hei, ce buna e prajitura',3)


-- 2. afisam pe ionel si postarile

select postari.data, mesaj
from postari, useri
where useri.username='ionel'
	and postari.user_id=useri.id

-- 2.1 afiseaza toti userii
select username from useri

-- 3.afiseaza toti userii care nu sunt blocati
select username
from useri
where blocat=0

-- 4. Sa se afiseze userul cu varsta cea mai mica
select username
from useri
where varsta=(select min(varsta) from useri)

-- 5.Sa se afiseze userii cu varsta intre 23 si 33 de ani , ordonati dupa varsta
select username, varsta
from useri
where varsta>=23 and varsta<=33
order by varsta

-- 6.sa se afizeze media varstei userilor blocati
select avg(varsta)
from useri
where blocat=1

-- 7. sa se afiseze userii neblocati din dej
select username, oras, blocat
from useri
where oras='Dej'
	and blocat=0

-- 8.sa se afiseze postarile userilor neblocati din turda care au varsta
peste 40 de ani

select postari.data, postari.mesaj, useri.username
from postari, useri
where useri.id=postari.user_id
	and useri.oras='Turda'
	and useri.blocat=0
	and useri.varsta>=40

-- 9. sa sa afiseze userul cu cele mai multe postari

select useri.username, ab.nrpost --ab.user_id,ab.nrpost
from (select user_id, count(user_id) as nrpost
      from postari
	group by user_id
	order by user_id
	)ab, useri
where ab.nrpost=(select max(abmax.y)
		from (select user_id, count(user_id) as y
			from postari
			group by user_id
			order by user_id
			)abmax
	)
     and useri.id = ab.user_id

-- SAU

select useri.username, count(*) as nrpostari
from useri, postari
where useri.id=postari.user_id
group by useri.username
order by count(*) desc
limit 1;

-- SAU

select useri.username, count(*) as nrpostari
from useri
join postari
on useri.id=postari.user_id
group by useri.username
order by count(*) desc
limit 1;

-- 10.sa se afiseze postarile userilor care
--incep cu numele D si sunt postate intre 1 si 31 martie 2016

select postari.data, postari.mesaj, useri.username
from postari, useri
where useri.id=postari.user_id
	and postari.data>='2016-03-01'
	and postari.data<='2016-03-31'
	and useri.username like 'd%'

-- 11.sa se afiseze postarile ordonate
dupa data postarii descendent, indiferent de user

select postari.data, postari.mesaj
from postari
order by postari.data desc

-- 12.sa se stearga postarile userilor sub 18 ani care contin  textul ‘politica’
select postari.mesaj, useri.username
from postari, useri
where useri.id=postari.user_id
	and postari.mesaj like '%politica%'
	and useri.varsta<=18

delete from postari
where id = ( select postari.id
		from postari, useri
		where useri.id=postari.user_id
			and postari.mesaj like '%politica%'
			and useri.varsta<=18
			)




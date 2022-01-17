set pg_strom.enabled = on;

EXPLAIN ANALYZE
select
	o_year,
	sum(case
		when nation = 'INDIA' then volume
		else 0
	end) / sum(volume) as mkt_share
from
	(
		select
			extract(year from o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) as volume,
			n2.n_name as nation
		from
			lineitem
			inner join part on p_partkey = l_partkey
			inner join supplier on s_suppkey = l_suppkey
			inner join orders on o_orderkey = l_orderkey
			inner join customer on c_custkey = o_custkey
			inner join nation as n1 on n1.n_nationkey = c_nationkey
			inner join nation as n2 on n2.n_nationkey = s_nationkey
			inner join region on r_regionkey = n1.n_regionkey
		where
			r_name = 'ASIA'
			and o_orderdate between date '1995-01-01' and date '1996-12-31'
			and p_type = 'LARGE BRUSHED NICKEL'
	) as all_nations
group by
	o_year
order by
	o_year
limit 1

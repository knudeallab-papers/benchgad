set pg_strom.enabled = on;

EXPLAIN ANALYZE
select
	nation,
	o_year,
	sum(amount) as sum_profit
from
	(
		select
			n_name as nation,
			extract(year from o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
		from
			lineitem
			inner join supplier on s_suppkey = l_suppkey
			inner join partsupp on ps_suppkey = l_suppkey and ps_partkey = l_partkey
			inner join part on p_partkey = l_partkey
			inner join orders on o_orderkey = l_orderkey
			inner join nation on n_nationkey = s_nationkey
		where
			p_name like '%orchid%'
	) as profit
group by
	nation,
	o_year
order by
	nation,
	o_year desc
limit 1

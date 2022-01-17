set pg_strom.enabled = on;

EXPLAIN ANALYZE
select
	100.00 * CAST(sum(case
		when p_type like 'PROMO%'
			then l_extendedprice * (1 - l_discount)
		else 0
	end) AS FLOAT) / CAST(sum(l_extendedprice * (1 - l_discount)) AS FLOAT) as promo_revenue
from
	lineitem,
	part
where
	l_partkey = p_partkey
	and l_shipdate >= date '1994-09-01'
	and l_shipdate < date '1994-10-01'


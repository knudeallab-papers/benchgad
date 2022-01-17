set pg_strom.enabled = on;

EXPLAIN ANALYZE
select
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date '1995-01-01'
	and l_shipdate < date '1996-01-01'
	and l_discount between 0.08 and 0.1
	and l_quantity < 24
limit 1

set pg_strom.enabled = on;

EXPLAIN ANALYZE
select
	l_orderkey,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	o_orderdate,
	o_shippriority
from
	orders
	inner join customer on c_custkey = o_custkey
	inner join lineitem on l_orderkey = o_orderkey
where
	c_mktsegment = 'HOUSEHOLD'
	and o_orderdate < date '1995-03-21'
	and l_shipdate > date '1995-03-21'
group by
	l_orderkey,
	o_orderdate,
	o_shippriority
order by
	revenue desc,
	o_orderdate

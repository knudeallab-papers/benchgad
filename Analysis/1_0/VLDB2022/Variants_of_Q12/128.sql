select
	l_shipmode,
	sum(l_quantity) as sum_qty,
	sum(l_extendedprice) as sum_base_price,
	sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
	sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge
from
	lineitem
	inner join orders on l_orderkey = o_orderkey
	inner join partsupp on l_suppkey = ps_suppkey
	inner join part on l_partkey = p_partkey
where
	l_shipmode in ('TRUCK', 'AIR')
	and l_commitdate < l_receiptdate
	and l_shipdate < l_commitdate
	and l_receiptdate >= date '1997-01-01'
	and l_receiptdate < date '1997-01-01' + interval '1' year
	and ps_supplycost = (
		select
			min(ps_supplycost)
		from
			part
			inner join partsupp on ps_partkey = p_partkey
			inner join supplier on s_suppkey = ps_suppkey
			inner join nation on n_nationkey = s_nationkey
			inner join region on r_regionkey = n_regionkey
		where
			r_name = 'EUROPE'
	)
group by
	l_shipmode
order by
	l_shipmode
limit 1


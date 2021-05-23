select
	l_shipmode,
	case
		when o_orderpriority = '1-URGENT'
			or o_orderpriority = '2-HIGH'
			then 1
		else 0
   end
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
order by
	l_shipmode
limit 1

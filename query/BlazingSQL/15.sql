select
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
from
	supplier
	inner join (select
		l_suppkey as supplier_no,
		sum(l_extendedprice * (1 - l_discount)) as total_revenue
	from
		lineitem
	where
		l_shipdate >= date '1997-05-01'
		and l_shipdate < date '1997-08-01'
	group by
		l_suppkey) as revenue0 on supplier_no = s_suppkey
order by
	s_suppkey
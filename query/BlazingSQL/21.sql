select
	s_name,
	count(*) as numwait
from
	lineitem l1
	inner join supplier on s_suppkey = l1.l_suppkey
	inner join orders on o_orderkey = l1.l_orderkey
	inner join nation on n_nationkey = s_nationkey
where
	o_orderstatus = 'F'
	and l1.l_receiptdate > l1.l_commitdate
	and exists (
		select
			*
		from
			lineitem l2
		where
			l2.l_orderkey = l1.l_orderkey
			and l2.l_suppkey <> l1.l_suppkey
	)
	and not exists (
		select
			*
		from
			lineitem l3
		where
			l3.l_orderkey = l1.l_orderkey
			and l3.l_suppkey <> l1.l_suppkey
			and l3.l_receiptdate > l3.l_commitdate
	)
	and n_name = 'VIETNAM'
group by
	s_name
order by
	numwait desc,
	s_name
limit 1

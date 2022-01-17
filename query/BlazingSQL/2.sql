select
	s_acctbal,
	s_name,
	n_name,
	p_partkey,
	p_mfgr,
	s_address,
	s_phone,
	s_comment
from
	part
	inner join partsupp on ps_partkey = p_partkey
	inner join supplier on s_suppkey = ps_suppkey
	inner join nation on n_nationkey = s_nationkey
	inner join region on r_regionkey = n_regionkey
where
	p_size = 25
	and p_type like '%STEEL'
	and r_name = 'EUROPE'
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
order by
	s_acctbal desc,
	n_name,
	s_name,
	p_partkey
LIMIT 100

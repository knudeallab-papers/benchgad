
select
	ps_partkey,
	sum(ps_supplycost * ps_availqty) as val
from
	partsupp,
	supplier,
	nation
where
	ps_suppkey = s_suppkey
	and s_nationkey = n_nationkey
	and n_name = 'SAUDI ARABIA'
group by
	ps_partkey 
having
	sum(ps_supplycost * ps_availqty) > (
		select
			sum(ps_supplycost * ps_availqty) * 0.0001000000
		from
			partsupp,
			supplier,
			nation
		where
			ps_suppkey = s_suppkey
			and s_nationkey = n_nationkey
			and n_name = 'SAUDI ARABIA'
	)
order by
	val desc
limit 1;

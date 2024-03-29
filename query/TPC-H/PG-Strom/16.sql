set pg_strom.enabled = on;

EXPLAIN ANALYZE
select
	p_brand,
	p_type,
	p_size,
	count(distinct ps_suppkey) as supplier_cnt
from
	partsupp,
	part
where
	p_partkey = ps_partkey
	and p_brand <> 'Brand#53'
	and p_type not like 'LARGE ANODIZED%'
	and p_size in (45, 37, 43, 7, 18, 13, 22, 12)
	and not exists (
		select
			1
		from
			supplier ss
		where
			ss.s_comment like '%Customer%Complaints%'
			and ss.s_suppkey = ps_suppkey
	)
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size
limit 1

select
	cntrycode,
	count(*) as numcust,
	sum(c_acctbal) as totacctbal
from
	(
		select
			substring(c_phone, 1, 2) as cntrycode,
			c_acctbal
		from
			customer
		where
			substring(c_phone, 1, 2) in
				('11', '18', '15', '20', '12', '29', '30')
			and not exists (
				select
					*
				from
					orders
				where
					o_custkey = c_custkey
			)
			and c_acctbal > (
				select
					avg(c_acctbal)
				from
					customer
				where
					c_acctbal > 0.00
					and substring(c_phone, 1, 2) in
						('11', '18', '15', '20', '12', '29', '30')
			)
	) as custsale
group by
	cntrycode
order by
	cntrycode
limit 1
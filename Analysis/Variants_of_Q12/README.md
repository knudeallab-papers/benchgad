# Twelve variants of Q12

> ### **_S_** for selection, **_P_** for projection, and **_J_** for join condition.

| **Query Alias** | **Description** |
| -: | :-|
| 12.sql | Original Q12 in [TPC-H](http://www.tpc.org/tpch/) |
| 121.sql | _SP_ without aggregation (selective scan) |
| 122.sql | _SP_ with aggregation and order by |
| 123.sql | _SPJ_ without aggregation |
| 124.sql | _SPJ_ with aggregation |
| 125.sql | _SPJ_ with aggregation and order by |
| 126.sql | _SPJ_ with multi-way join |
| 127.sql | _SPJ_ with multi-way join and aggregation |
| 128.sql | _SPJ_ with multi-way join, aggregation, and sub-query |
| 129.sql | _SPJ_ with aggregation, order by and case-when |
| 1210.sql | _SPJ_ with multi-way join and case-when |
| 1211.sql | _SPJ_ with multi-way join, aggregation, and case-when |
| 1212.sql | _SPJ_ with multi-way join, aggregation, sub-query, and case-when |
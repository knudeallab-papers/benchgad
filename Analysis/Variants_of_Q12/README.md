# Eight variants of Q12

> ### **_S_** for selection, **_P_** for projection, and **_J_** for join condition.

| **Query Alias** | **Description** |
| -: | :-|
| 12.sql | Original Q12 in [TPC-H](http://www.tpc.org/tpch/) |
| 121.sql | _SPJ_ without aggregation |
| 122.sql | _SPJ_ with aggregation |
| 123.sql | _SPJ_ with multi-way join |
| 124.sql | _SPJ_ with multi-way join and aggregation |
| 125.sql | _SPJ_ with multi-way join, aggregation, and sub-query |
| 126.sql | _SPJ_ with aggregation, order by and case-when |
| 127.sql | _SPJ_ with multi-way join, aggregation, and case-when |
| 128.sql | _SPJ_ with multi-way join, aggregation, sub-query, and case-when |

ttl-serials
===========
TTL range: 0 - 2147483647 (2^31-1) [RFC 2181 section 8]

```text
2147483647 vs. popular serial number formats:
yyMMddhhmm - works until 2021-12-31
unix epoch - works until 2038-01-19
yyyyMMddvv - works until 2147-12-31; 100 updates/day = 1 per 14min 24sec
yyyDDDhhmm - works until 2214-12-31; with DDD := (MM * 50) + dd
                        = ((MM * 5) * 10) + dd = ((half of MM) * 100) + dd
```

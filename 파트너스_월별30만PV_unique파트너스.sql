with total as
(
SELECT ts.*, M.uname, substr(ts.sdate,1,7) as month
FROM tbTotalStat ts inner join 
     (SELECT requestKey, uname
      FROM member
	  where level in ('60','61') )M on ts.requestKey = M.requestKey
)
,
total_30 as 
(
select month, requestKey, uname, sum(visitCount) as PV
from  total
group by month, requestKey, uname
HAVING PV >= 300000
)
select distinct requestKey, uname
from total_30;
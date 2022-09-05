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
select *
      , case when PV  <1000000   then '1_30만이상'  
             when PV  <1500000   then '2_100만이상'  
			 when PV  <2000000   then '3_150만이상'  
             when PV  <3000000   then '4_200만이상' 
             when PV  <5000000   then '5_300만이상' 
             when PV  <10000000  then '6_500만이상' 
             else "7_1000만이상" end grade
from   total_30
order by month;

--       , case when PV >=300000 then '30만이상' AS grade
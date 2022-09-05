-- 파트너스 총 1차클릭수 합계, 사용자수 합계
with partners as
(
select MS.*
from   tbMemberStat MS
	  ,(
	   select M.requestKey
       from   member M
       where  level in ('60','61','65')
       ) part
 where  1=1
 and    MS.requestKey = part.requestKey
 and    MS.sdate between 20210531 and 20210606
 )
 select sdate, sum(clickCnt)
 from   partners
 group by sdate
;

-- 타퍼블리셔 1차클릭수 합계, 사용자수 합계
select MS.sdate
       , case when  requestKey='G9BUz12T' then '1_캐시워크 잠금화면'
              when  requestKey='X4uGJ61p' then '2_캐시워크 drawer'
              when  requestKey='k8rlD25H' then '4_Tnear'
              when  requestKey='q2EdR50I' then '5_버즈빌'
              when  requestKey='F9fzY14o' then '6_버즈빌피드' 
                    else 'd'    end as 퍼블리셔명
		,MS.clickCnt
from   tbMemberStat MS
where  1=1
and    sdate between 20210531 and 20210613
and    requestKey in ('G9BUz12T','X4uGJ61p','k8rlD25H','q2EdR50I','F9fzY14o')
order by 퍼블리셔명, sdate
;
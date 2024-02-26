https://www.youtube.com/watch?v=dOLBRfwzYcU&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=2
Approach1:
-- using Co-related subquery
with cte as (
select gold player_name,'gold' award from events
union all
select silver player_name,'silver' award from events
union all
select bronze player_name,'bronze' award from events	
),
cte2 as (
select player_name from cte cte1 where not exists 
(select player_name from cte cte2 where cte1.player_name=cte2.player_name and cte2.award!='gold' )
and cte1.award='gold')
select player_name,count(*) from cte2 group by player_name
--using join
with cte as (
select g_events.gold player_name,s_events.silver,b_events.bronze from events g_events
left join events s_events on g_events.gold=s_events.silver
left join events b_events on g_events.gold=b_events.bronze	
where s_events.silver is null and b_events.bronze is null
)
select player_name,count(*)
from cte
group by player_name

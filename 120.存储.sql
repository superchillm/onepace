USE [drgbiyanshi]
GO
/****** Object:  StoredProcedure [dbo].[p_SJFYXH]    Script Date: 09/30/2019 15:15:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---- exec [p_SJFYXH] '2018-01-01','2018-01-30'
------非手术科室时间费用消耗
ALTER procedure [dbo].[p_SJFYXH]
@startTime datetime,            
@endTime datetime
  AS 
 BEGIN

select biyear, bimonth,drgcode,cyks,zyysdm,
count(drgcode) rs,
avg(isnull(a.CH0B83,0)) jgpzfy,
avg(isnull(a.CH0A29,0)) jgpzts  into #jgdrgpz13
from T_BA_VsCh0A a 
where isnull(DRGCode,'') not in ('','0000','9999') 
and a.bidate between  @startTime and @endTime
group by biyear,drgcode,bimonth,cyks,zyysdm
--drop table #jgdrgpz13

select year_time biyear,drg drgcode,avg_days jgpzts,avg_fee jgpzfy
into #jgdrgpz23
 from HDP_RPT_LOT_DRGS
----drop table   #jgdrgpz23
select 
 sum(a.jgpzfy*1.0/b.jgpzfy*a.rs) fyxhzs,
sum(a.jgpzts*1.0/b.jgpzts*a.rs) sjxhzs,bimonth,a.biyear,a.cyks,a.zyysdm,sum(a.rs) rs into #sjfyxhdf
 from  #jgdrgpz13 a join #jgdrgpz23 b on a.drgcode=b.drgcode and a.biyear=b.biyear 
group by bimonth,a.biyear,a.cyks,a.zyysdm;
--drop table #sjfyxhdf
select bimonth,
 SUM(ISNULL(fyxhzs,0)) fyxhzsdf,
 SUM(ISNULL(sjxhzs,0))  sjxhzsdf,
 sum(rs) rs,biyear,cyks,zyysdm
 from  #sjfyxhdf
 group by bimonth,biyear,cyks,zyysdm
 end
 
 


GO
/****** Object:  StoredProcedure [dbo].[p_SJFYXH]    Script Date: 09/26/2019 09:19:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---- exec [P_BA_DRG_ALLTARGET2] '2019-01-01','2019-08-31','3'


--非手术科室时间费用消耗 

 Alter procedure [dbo].[P_BA_DRG_ALLTARGET2]
@startTime datetime,            
 @endTime DATETIME,
 -- @yq varchar(100)
@ks int
  AS 
 BEGIN
 create table #hbtemp1(
 biyear INT,
 bimonth INT,
cyks nvarchar(max),
cyrs int,
drgzs int,
zqz numeric(10,2) null,
rzls numeric(18,0) null,
rzl numeric(18,2) null,
CMI numeric(18,2) null,

dfxswls numeric(18,0) null,
dfxswl numeric(18,4) null,
zdfxswls numeric(18,0) null,
zdfxswl numeric(18,4) null,
zgfxswls numeric(18,0) null,
zgfxswl numeric(18,4) null,
gfxswls numeric(18,0) null, 
gfxswl numeric(18,4) null,
--sjrw numeric(18,2) null,
--fyrw numeric(18,2) null,

zyzfy numeric(18,2) null,
pjzyr numeric(18,2) null,
yzb numeric(18,2) null,
hcb numeric(18,2) null,
pjzyfy numeric(18,2) null,
 zdf numeric(18,2) null,
zdfzb numeric(18,2) null,
zhylf numeric(18,2) null,
zhylfzb numeric(18,2) null,
zlf numeric(18,2) null,
zlfzb numeric(18,2) null,
xyzpf numeric(18,2) null,
xyzbfzb numeric(18,2) null,
kff numeric(18,2) null,
kffzb numeric(18,2) null,

rw0_05ls numeric(18,0) null,
rw05_1ls numeric(18,0) null,
rw1_2ls numeric(18,0) null,
rw2_5ls numeric(18,0) null,
rw5_10ls numeric(18,0) null,
rw10ls numeric(18,0) NULL,
sjxhzs numeric(18,4) NULL,
fyxhzs numeric(18,4) NULL,
 mqzzyr numeric(18,4) NULL,
  mqzzyfy numeric(18,4) NULL
)
 IF @ks=3
 BEGIN
SELECT a.biyear,a.bimonth,
COUNT(1) cyrs,
  count(distinct drgcode) as drgzs,
--ISNULL(CASE WHEN ISNULL(drgcode,'') NOT IN ('','0000','9999') THEN COUNT(DISTINCT drgcode) ELSE 0 END,0) drgzs,
--COUNT(DISTINCT drgcode) drgzs,
SUM(ISNULL(ISNUMERIC(qz),''))  zqz, 
CAST( (sum(case when isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end)) As decimal(18,0)) As rzls,
CAST((SUM(CASE WHEN ISNULL(DRGCode,'') NOT IN ('','0000','9999')THEN 1 ELSE 0 END )*100.0/COUNT(*)) AS decimal(18,2)) AS rzl,
Cast( (Case When isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end),0)=0 Then 0 Else (sum(isnull(QZ,0)))/  (sum(case when isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end)) End)  As decimal(18,2)) As CMI,
 CAST( (isnull(sum(case when(as_risk_level=1 and Ch0ANE=5)then 1 else 0 end ),0))  As decimal(18,0)) As dfxswls,
 Cast( (Case When isnull(sum(case when as_risk_level=1 and isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end),0)=0 Then 0 Else(sum(case when(as_risk_level=1 and Ch0ANE=5) and  isnull(DRGCode,'') 
    not in ('','0000','9999') then 1 else 0 end )*100.0)/  (sum(case when as_risk_level=1 and isnull(DRGCode,'')
     not in ('','0000','9999') then 1 else 0 end)) End)  As decimal(18,2)) As dfxswl,
CAST( (isnull(sum(case when(as_risk_level=2 and Ch0ANE=5) then 1 else 0 end ),0))  As decimal(18,0))  As zdfxswls,
     Cast( (Case When isnull(sum(case when as_risk_level=2 AND isnull(DRGCode,'') not in ('','0000','9999') 
   then 1 else 0 end),0)=0 Then 0 Else (sum(case when(as_risk_level=2 and Ch0ANE=5 and isnull(DRGCode,'') not in ('','0000','9999')) then 1 else 0 end )*100.0)/  (sum(case when as_risk_level=2 and isnull(DRGCode,'')  not in ('','0000','9999') then 1 else 0 end)) End)  As decimal(18,2))As zdfxswl, 
   
  CAST( (isnull(sum(case when(as_risk_level=3 and Ch0ANE=5) then 1 else 0 end ),0))  As decimal(18,0))  As zgfxswls,
    Cast( (Case When isnull(sum(case when as_risk_level=3 and isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end),0)=0 Then 0 Else (sum(case when(as_risk_level=3 and Ch0ANE=5)then 1 else 0 end )*100.0)/  (sum(case when as_risk_level=3 and isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end)) End)  As decimal(18,2)) As zgfxswl,
     
     Cast( (isnull(sum(case when(as_risk_level=4 and Ch0ANE=5)then 1 else 0 end ),0))  As decimal(18,0)) As gfxswls,
      Cast( (Case When isnull(sum(case when as_risk_level=4 and isnull(DRGCode,'') not in ('','0000','9999')then 1 else 0 end),0)=0 Then 0 Else (sum(case when(as_risk_level=4 and Ch0ANE=5)then 1 else 0 end )*100.0)/  (sum(case when as_risk_level=4 and isnull(DRGCode,'') 
    not in ('','0000','9999') then 1 else 0 end)) End)  
    As decimal(18,2))  As gfxswl,
    
    Cast( (isnull(sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end),0))  As decimal(18,2)) zyzfy,
    CAST (case when sum( case when isnull(drgcode,'') not in ('0000','9999','') then 1 else 0 end)=0 then 0 else sum( case when isnull(drgcode,'') not in ('0000','9999','') then CAST( isnull(CH0A29,0) As decimal(18,2) )else 0 end )/sum( case when isnull(drgcode,'') not in ('0000','9999','') then 1 else 0 end) end  as  decimal(18,2))
as pjzyr,
Cast( Case When sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end)=0 Then 0 Else sum(case when isnull(drgcode,'') not in ('0000','9999','') then (isnull(CH0BPH,0)+isnull(CH0BPJ,0)+isnull(CH0BPK,0))*100.0 else 0 end)/sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end) end as decimal(18,2)) As yzb,
   Cast( Case When sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end)=0 Then 0 Else sum(case when isnull(drgcode,'') not in ('0000','9999','') then (isnull(CH0BPQ,0)+isnull(CH0BPR,0)+isnull(CH0BPS,0))*100.0 else 0 end)/sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end) end as decimal(18,2)) As hcb,
    CAST (case when sum( case when isnull(drgcode,'') not in ('0000','9999','') then 1 else 0 end)=0 then 0 Else sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0)else 0 end) / sum( case when isnull(drgcode,'') not in ('0000','9999','') then 1 else 0 end) end  as decimal(18,2)) as pjzyfy,
    Cast((sum(isnull(CH0BP6,0)+isnull(CH0BP7,0)+isnull(CH0BP8,0)+isnull(CH0BP9,0))) As decimal(18,2)) As zdf,
   Cast( (Case When isnull(sum(isnull(CH0B83,0)),0)=0 Then 0 Else (sum(isnull(CH0BP6,0)+isnull(CH0BP7,0)+isnull(CH0BP8,0)+isnull(CH0BP9,0))*100.0)/  (sum(isnull(CH0B83,0))) End)  As decimal(18,2)) As zdfzb,
   Cast((sum (isnull(CH0BP2,0)+isnull(CH0BP3,0)+isnull(CH0BP4,0)+isnull(CH0BP5,0)))  As decimal(18,2)) As zhylf,
   Cast( (Case When isnull(sum(isnull(CH0B83,0)),0)=0 Then 0 Else (sum(isnull(CH0BP2,0)+isnull(CH0BP3,0)+isnull(CH0BP4,0)+isnull(CH0BP5,0))*100.0)/  (sum(isnull(CH0B83,0))) End)  As decimal(18,2)) As zhylfzb,
   Cast( sum(case when isnull(drgcode,'') not in ('0000','9999','')then (isnull(CH0BPA,0)+isnull(CH0BPC,0)) end) As decimal(18,2)) As zlf,
   Cast( Case When sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end)=0 Then 0 Else sum(case when isnull(drgcode,'') not in ('0000','9999','') then (isnull(CH0BPA,0)+isnull(CH0BPC,0))*100.0 else 0 end)/sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end) end as decimal(18,2)) As zlfzb,
      Cast(  (sum(isnull(CH0BPL,0)+isnull(CH0BPM,0)+isnull(CH0BPN,0)+isnull(CH0BPO,0)+isnull(CH0BPP,0)))  As decimal(18,2)) As xyzpf,
   Cast( (Case When isnull(sum(isnull(CH0B83,0)),0)=0 Then 0 Else (sum(isnull(CH0BPL,0)+isnull(CH0BPM,0)+isnull(CH0BPN,0)+isnull(CH0BPO,0)+isnull(CH0BPP,0))*100.0)/  (sum(isnull(CH0B83,0))) End)  As decimal(18,2)) As xyzbfzb,
    Cast( (sum(isnull(CH0BPF,0)) )  As decimal(18,2)) As kff,
   CAST( (Case When isnull(sum(isnull(CH0B83,0)),0)=0 Then 0 Else (sum(isnull(CH0BPF,0))*100.0)/  (sum(isnull(CH0B83,0))) End)  As decimal(18,2)) As kffzb,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=0 and qz<0.5 then 1 else 0 end),0))  As decimal(18,0)) As rw0_05ls,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=0.5 and qz<1 then 1 else 0 end),0))  As decimal(18,0)) As rw05_1ls,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=1 and qz<2 then 1 else 0 end),0))  As decimal(18,0)) As rw1_2ls,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=2 and qz<5 then 1 else 0 end),0))  As decimal(18,0)) As rw2_5ls,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=5 and qz<10 then 1 else 0 end),0))  As decimal(18,0)) As rw5_10ls, 
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=10 then 1 else 0 end),0))  As decimal(18,0)) As rw10ls,
   sum(isnull(ch0a29,0))/sum(isnull(qz,0)) AS mqzzyr,sum(isnull(CH0B83,0))/sum(isnull(qz,0))AS mqzzyfy
   INTO #hbtemp11
   FROM dbo.T_BA_VsCh0A a 
	WHERE 
	a.CH0A27 between ''+convert(char(110),@startTime,121)
	and convert(char(110),@endTime,121)
	group by a.biyear,a.bimonth 
	
insert into #hbtemp1(biyear,bimonth,cyrs,drgzs,zqz,rzls,rzl,CMI,dfxswls,dfxswl,zdfxswls,zdfxswl,zgfxswls,zgfxswl,gfxswls,gfxswl,zyzfy,pjzyr,yzb,hcb,pjzyfy,zdf,zdfzb,zhylf,zhylfzb,zlf,zlfzb,xyzpf,xyzbfzb,kff,kffzb,rw0_05ls,rw05_1ls,rw1_2ls,rw2_5ls,rw5_10ls,rw10ls,fyxhzs,sjxhzs,mqzzyr,mqzzyfy
)
SELECT 
a.biyear,a.bimonth,cyrs,drgzs,zqz,rzls,rzl,CMI,dfxswls,dfxswl,zdfxswls,zdfxswl,zgfxswls,zgfxswl,gfxswls,gfxswl,zyzfy,pjzyr,yzb,hcb,pjzyfy,zdf,zdfzb,zhylf,zhylfzb,zlf,zlfzb,xyzpf,xyzbfzb,kff,kffzb,rw0_05ls,rw05_1ls,rw1_2ls,rw2_5ls,rw5_10ls,rw10ls,fyxhzs,sjxhzs,mqzzyr,mqzzyfy
 FROM #hbtemp11 a
LEFT JOIN (SELECT  
				biyear,bimonth, 
				SUM(rs*(jgpjfy/qspjfy))/SUM(rs) fyxhzs,
				SUM(rs*(jgpjsj/qspjsj))/SUM(rs) sjxhzs
				FROM
				(SELECT biyear,bimonth,COUNT(1) rs,avg(cast(isnull(CH0A29,0) as decimal(12,6))) jgpjsj,
				AVG(isnull(CH0B83,0)) jgpjfy ,avg(AVG_DAYS) qspjsj,avg(AVG_FEE) qspjfy 
				from 
				(SELECT biyear,bimonth,cyks,CH0A29,CH0B83,AVG_DAYS,AVG_FEE 
				FROM dbo.T_BA_VsCh0A a 
				left join HDP_RPT_LOT_DRGS b on a.DRGCode=b.DRG and PERIOD='AY' 
				and b.YEAR_TIME=a.biyear
				where isnull(DRGCode,'') not in ('','0000','9999')
				and a.bidate between ''+convert(char(110),@startTime,121)+'' 
				and ''+convert(char(110),@endTime,121))#1
				GROUP BY biyear,bimonth)#2
				--AND #2.bimonth BETWEEN convert(char(110),@startTime,121)
				--and convert(char(110),@endTime,121)
				GROUP BY biyear,bimonth) c ON a.biyear =c.biyear AND a.bimonth=c.bimonth
				
SELECT * FROM #hbtemp1

END
 ELSE
BEGIN					
-- SELECT biyear,bimonth,cyks,COUNT(1) rs,avg(cast(isnull(CH0A29,0) as decimal(12,6))) jgpjsj,
--AVG(isnull(CH0B83,0)) jgpjfy ,avg(AVG_DAYS) qspjsj,avg(AVG_FEE) qspjfy 
--into #xhzsTemp 
--from 
--(SELECT biyear,bimonth,cyks,CH0A29,CH0B83,AVG_DAYS,AVG_FEE 
--FROM dbo.T_BA_VsCh0A a 
--left join HDP_RPT_LOT_DRGS b on a.DRGCode=b.DRG and PERIOD='AY' 
--and b.YEAR_TIME=a.biyear 
--where isnull(DRGCode,'') not in ('','0000','9999') 
--and a.bidate between ''+convert(char(110),@startTime,121)+'' 
--and ''+convert(char(110),@endTime,121))#1
--GROUP BY biyear,bimonth,cyks


--费用消耗指数:（（机构DRG平均费用/总的DRG平均费用）*DRG入组人数）/总入组人数
--时间消耗指数:（（机构DRG平均住院天数/总的DRG平均住院天数）*DRG入组人数）/总入组人数
--set @sql += 'select sum(rzrs*(jgpjfy/qspjfy))/SUM(rzrs) fy,sum(rzrs*(jgpjsj/qspjsj))/SUM(rzrs) sj ,'+@tableWei+' '+
--Create Table #sjfyxhdf ( fyxhzs numeric(18,4)  null,
-- sjxhzs numeric(18,4)  null,
-- cyks varchar(200)  NULL) 
--insert into #sjfyxhdf(fyxhzs,sjxhzs,cyks) 
--SELECT sum(rs*(jgpjfy/qspjfy))/SUM(rs) fyxhzs,sum(rs*(jgpjsj/qspjsj))/SUM(rs) sjxhzs,cyks  
--FROM #xhzsTemp 
--WHERE cyks=@ks
--GROUP BY cyks
	
SELECT a.biyear,a.bimonth,cyks,
COUNT(1) cyrs,
  count(distinct drgcode) as drgzs,
--ISNULL(CASE WHEN ISNULL(drgcode,'') NOT IN ('','0000','9999') THEN COUNT(DISTINCT drgcode) ELSE 0 END,0) drgzs,
--COUNT(DISTINCT drgcode) drgzs,
SUM(ISNULL(ISNUMERIC(qz),''))  zqz, 
CAST( (sum(case when isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end)) As decimal(18,0)) As rzls,
CAST((SUM(CASE WHEN ISNULL(DRGCode,'') NOT IN ('','0000','9999')THEN 1 ELSE 0 END )*100.0/COUNT(*)) AS decimal(18,2)) AS rzl,
Cast( (Case When isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end),0)=0 Then 0 Else (sum(isnull(QZ,0)))/  (sum(case when isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end)) End)  As decimal(18,2)) As CMI,
 CAST( (isnull(sum(case when(as_risk_level=1 and Ch0ANE=5)then 1 else 0 end ),0))  As decimal(18,0)) As dfxswls,
 Cast( (Case When isnull(sum(case when as_risk_level=1 and isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end),0)=0 Then 0 Else(sum(case when(as_risk_level=1 and Ch0ANE=5) and  isnull(DRGCode,'') 
    not in ('','0000','9999') then 1 else 0 end )*100.0)/  (sum(case when as_risk_level=1 and isnull(DRGCode,'')
     not in ('','0000','9999') then 1 else 0 end)) End)  As decimal(18,2)) As dfxswl,
CAST( (isnull(sum(case when(as_risk_level=2 and Ch0ANE=5) then 1 else 0 end ),0))  As decimal(18,0))  As zdfxswls,
     Cast( (Case When isnull(sum(case when as_risk_level=2 AND isnull(DRGCode,'') not in ('','0000','9999') 
   then 1 else 0 end),0)=0 Then 0 Else (sum(case when(as_risk_level=2 and Ch0ANE=5 and isnull(DRGCode,'') not in ('','0000','9999')) then 1 else 0 end )*100.0)/  (sum(case when as_risk_level=2 and isnull(DRGCode,'')  not in ('','0000','9999') then 1 else 0 end)) End)  As decimal(18,2))As zdfxswl, 
   
  CAST( (isnull(sum(case when(as_risk_level=3 and Ch0ANE=5) then 1 else 0 end ),0))  As decimal(18,0))  As zgfxswls,
    Cast( (Case When isnull(sum(case when as_risk_level=3 and isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end),0)=0 Then 0 Else (sum(case when(as_risk_level=3 and Ch0ANE=5)then 1 else 0 end )*100.0)/  (sum(case when as_risk_level=3 and isnull(DRGCode,'') not in ('','0000','9999') then 1 else 0 end)) End)  As decimal(18,2)) As zgfxswl,
     
     Cast( (isnull(sum(case when(as_risk_level=4 and Ch0ANE=5)then 1 else 0 end ),0))  As decimal(18,0)) As gfxswls,
      Cast( (Case When isnull(sum(case when as_risk_level=4 and isnull(DRGCode,'') not in ('','0000','9999')then 1 else 0 end),0)=0 Then 0 Else (sum(case when(as_risk_level=4 and Ch0ANE=5)then 1 else 0 end )*100.0)/  (sum(case when as_risk_level=4 and isnull(DRGCode,'') 
    not in ('','0000','9999') then 1 else 0 end)) End)  
    As decimal(18,2))  As gfxswl,
    
    Cast( (isnull(sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end),0))  As decimal(18,2)) zyzfy,
    CAST (case when sum( case when isnull(drgcode,'') not in ('0000','9999','') then 1 else 0 end)=0 then 0 else sum( case when isnull(drgcode,'') not in ('0000','9999','') then CAST( isnull(CH0A29,0) As decimal(18,2) )else 0 end )/sum( case when isnull(drgcode,'') not in ('0000','9999','') then 1 else 0 end) end  as  decimal(18,2))
as pjzyr,
Cast( Case When sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end)=0 Then 0 Else sum(case when isnull(drgcode,'') not in ('0000','9999','') then (isnull(CH0BPH,0)+isnull(CH0BPJ,0)+isnull(CH0BPK,0))*100.0 else 0 end)/sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end) end as decimal(18,2)) As yzb,
   Cast( Case When sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end)=0 Then 0 Else sum(case when isnull(drgcode,'') not in ('0000','9999','') then (isnull(CH0BPQ,0)+isnull(CH0BPR,0)+isnull(CH0BPS,0))*100.0 else 0 end)/sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end) end as decimal(18,2)) As hcb,
    CAST (case when sum( case when isnull(drgcode,'') not in ('0000','9999','') then 1 else 0 end)=0 then 0 Else sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0)else 0 end) / sum( case when isnull(drgcode,'') not in ('0000','9999','') then 1 else 0 end) end  as decimal(18,2)) as pjzyfy,
    Cast((sum(isnull(CH0BP6,0)+isnull(CH0BP7,0)+isnull(CH0BP8,0)+isnull(CH0BP9,0))) As decimal(18,2)) As zdf,
   Cast( (Case When isnull(sum(isnull(CH0B83,0)),0)=0 Then 0 Else (sum(isnull(CH0BP6,0)+isnull(CH0BP7,0)+isnull(CH0BP8,0)+isnull(CH0BP9,0))*100.0)/  (sum(isnull(CH0B83,0))) End)  As decimal(18,2)) As zdfzb,
   Cast((sum (isnull(CH0BP2,0)+isnull(CH0BP3,0)+isnull(CH0BP4,0)+isnull(CH0BP5,0)))  As decimal(18,2)) As zhylf,
   Cast( (Case When isnull(sum(isnull(CH0B83,0)),0)=0 Then 0 Else (sum(isnull(CH0BP2,0)+isnull(CH0BP3,0)+isnull(CH0BP4,0)+isnull(CH0BP5,0))*100.0)/  (sum(isnull(CH0B83,0))) End)  As decimal(18,2)) As zhylfzb,
   Cast( sum(case when isnull(drgcode,'') not in ('0000','9999','')then (isnull(CH0BPA,0)+isnull(CH0BPC,0)) end) As decimal(18,2)) As zlf,
   Cast( Case When sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end)=0 Then 0 Else sum(case when isnull(drgcode,'') not in ('0000','9999','') then (isnull(CH0BPA,0)+isnull(CH0BPC,0))*100.0 else 0 end)/sum(case when isnull(drgcode,'') not in ('0000','9999','') then isnull(CH0B83,0) else 0 end) end as decimal(18,2)) As zlfzb,
      Cast(  (sum(isnull(CH0BPL,0)+isnull(CH0BPM,0)+isnull(CH0BPN,0)+isnull(CH0BPO,0)+isnull(CH0BPP,0)))  As decimal(18,2)) As xyzpf,
   Cast( (Case When isnull(sum(isnull(CH0B83,0)),0)=0 Then 0 Else (sum(isnull(CH0BPL,0)+isnull(CH0BPM,0)+isnull(CH0BPN,0)+isnull(CH0BPO,0)+isnull(CH0BPP,0))*100.0)/  (sum(isnull(CH0B83,0))) End)  As decimal(18,2)) As xyzbfzb,
    Cast( (sum(isnull(CH0BPF,0)) )  As decimal(18,2)) As kff,
   CAST( (Case When isnull(sum(isnull(CH0B83,0)),0)=0 Then 0 Else (sum(isnull(CH0BPF,0))*100.0)/  (sum(isnull(CH0B83,0))) End)  As decimal(18,2)) As kffzb,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=0 and qz<0.5 then 1 else 0 end),0))  As decimal(18,0)) As rw0_05ls,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=0.5 and qz<1 then 1 else 0 end),0))  As decimal(18,0)) As rw05_1ls,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=1 and qz<2 then 1 else 0 end),0))  As decimal(18,0)) As rw1_2ls,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=2 and qz<5 then 1 else 0 end),0))  As decimal(18,0)) As rw2_5ls,
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=5 and qz<10 then 1 else 0 end),0))  As decimal(18,0)) As rw5_10ls, 
   Cast( (isnull(sum(case when isnull(DRGCode,'') not in ('','0000','9999') and  qz>=10 then 1 else 0 end),0))  As decimal(18,0)) As rw10ls,
   sum(isnull(ch0a29,0))/sum(isnull(qz,0)) AS mqzzyr,sum(isnull(CH0B83,0))/sum(isnull(qz,0))AS mqzzyfy
   INTO #hbtemp12
   FROM dbo.T_BA_VsCh0A a 
	WHERE 
	a.CH0A27 between ''+convert(char(110),@startTime,121)
	and convert(char(110),@endTime,121)
	AND a.cyks=@ks
	group by a.biyear,a.bimonth,cyks 
	
insert into #hbtemp1(biyear,bimonth,cyks,cyrs,drgzs,zqz,rzls,rzl,CMI,dfxswls,dfxswl,zdfxswls,zdfxswl,zgfxswls,zgfxswl,gfxswls,gfxswl,zyzfy,pjzyr,yzb,hcb,pjzyfy,zdf,zdfzb,zhylf,zhylfzb,zlf,zlfzb,xyzpf,xyzbfzb,kff,kffzb,rw0_05ls,rw05_1ls,rw1_2ls,rw2_5ls,rw5_10ls,rw10ls,fyxhzs,sjxhzs,mqzzyr,mqzzyfy
)
SELECT 
a.biyear,a.bimonth,a.cyks,cyrs,drgzs,zqz,rzls,rzl,CMI,dfxswls,dfxswl,zdfxswls,zdfxswl,zgfxswls,zgfxswl,gfxswls,gfxswl,zyzfy,pjzyr,yzb,hcb,pjzyfy,zdf,zdfzb,zhylf,zhylfzb,zlf,zlfzb,xyzpf,xyzbfzb,kff,kffzb,rw0_05ls,rw05_1ls,rw1_2ls,rw2_5ls,rw5_10ls,rw10ls,fyxhzs,sjxhzs,mqzzyr,mqzzyfy
 FROM #hbtemp12 a
LEFT JOIN (SELECT  
				biyear,bimonth,#2.cyks,  
				SUM(rs*(jgpjfy/qspjfy))/SUM(rs) fyxhzs,
				SUM(rs*(jgpjsj/qspjsj))/SUM(rs) sjxhzs
				FROM
				(SELECT biyear,bimonth,cyks,COUNT(1) rs,avg(cast(isnull(CH0A29,0) as decimal(12,6))) jgpjsj,
				AVG(isnull(CH0B83,0)) jgpjfy ,avg(AVG_DAYS) qspjsj,avg(AVG_FEE) qspjfy 
				from 
				(SELECT biyear,bimonth,cyks,CH0A29,CH0B83,AVG_DAYS,AVG_FEE 
				FROM dbo.T_BA_VsCh0A a 
				left join HDP_RPT_LOT_DRGS b on a.DRGCode=b.DRG and PERIOD='AY' 
				and b.YEAR_TIME=a.biyear AND a.cyks=@ks
				where isnull(DRGCode,'') not in ('','0000','9999')
				AND a.cyks=@ks 
				and a.bidate between ''+convert(char(110),@startTime,121)+'' 
				and ''+convert(char(110),@endTime,121))#1
				GROUP BY biyear,bimonth,cyks)#2
				WHERE cyks=@ks 
				--AND #2.bimonth BETWEEN convert(char(110),@startTime,121)
				--and convert(char(110),@endTime,121)
				GROUP BY biyear,bimonth,cyks) c ON a.cyks =c.cyks AND a.bimonth=c.bimonth
--select cyks,
-- SUM(ISNULL(fyxhzs,0)) fyxhzsdf,
-- SUM(ISNULL(sjxhzs,0))  sjxhzsdf,
-- sum(rs) rs
-- from  #sjfyxhdf
-- group by cyks 
SELECT * FROM #hbtemp1
END

END
 
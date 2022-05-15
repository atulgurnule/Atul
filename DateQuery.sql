use swlive

Select DateAdd(year, -2, getdate())

select t_stdt from swlive..ttccom100100 group by t_stdt order by t_stdt

Select DATEADD(MONTH,-24,GETDATE()) as last2yeardate,getdate() as todaydate

SELECT DATEADD(YEAR, -2, GETDATE()) as last2yeardate, CAST( DATEADD(YEAR, -2, GETDATE()) AS DATE) as last2yeardate 

select max(t_stdt) as maxt_stdt,min(t_stdt) as mint_stdt FROM swlive..ttccom100100 WHERE convert(date, t_stdt) >= DATEADD(MONTH,-24,GETDATE()) and convert(date, t_stdt) <= GETDATE() order by t_stdt

select max(t_stdt) as maxt_stdt,min(t_stdt) as mint_stdt,getdate() as todaydt from swlive..ttccom100100 where t_stdt >= DATEADD(month,-24,GETDATE()) group by t_stdt order by t_stdt

select * from swlive..ttccom100100 where t_stdt >= DATEADD(month,-24,GETDATE()) order by t_stdt

select * from swlive..ttccom100100 where t_stdt >= DATEADD(YEAR,-2,GETDATE()) order by t_stdt


--INSERT swlive.DBO.ttccom100100 ([t_bpid], [t_ctit], [t_nama], [t_seak], [t_prbp], [t_prst], [t_stdt], [t_endt], [t_clan], [t_ccur], [t_sndr], [t_edyn], [t_fovn], [t_lvdt], [t_inrl], [t_iscn], [t_lgid], [t_cmid], [t_bptx], [t_cadr], [t_telp], [t_tlcy], [t_tlci], [t_tlln], [t_tlex], [t_tefx], [t_tfcy], [t_tfci], [t_tfln], [t_tfex], [t_ccnt], [t_cint], [t_foid], [t_crid], [t_icst], [t_icod], [t_fact], [t_ecmp], [t_coff], [t_crdt], [t_lmdt], [t_lmus], [t_bprl], [t_btbv], [t_usid], [t_clcd], [t_cbcl], [t_beid], [t_inet], [t_imag], [t_smt1], [t_sml1], [t_smt2], [t_sml2], [t_smt3], [t_sml3], [t_smt4], [t_sml4], [t_smt5], [t_sml5], [t_txta], [t_Refcntd], [t_Refcntu]) VALUES (N'VD000197', N'', N'ATUL BOOT HOUSE', N'RASHTRIYA BOOT H', N'', 2, CAST(N'2022-05-14T18:30:00.000' AS DateTime), CAST(N'1970-01-01T00:00:00.000' AS DateTime), N'ENG', N'INR', 2, 2, N'', CAST(N'1970-01-01T00:00:00.000' AS DateTime), 2, 0, N'', N'', N'', N'ADD040829', N' 8007772502', N'', N'', N' 8007772502', N'', N'', N'', N'', N'', N'', N'CON000049', 2, 0, 0, 2, 1, 2, 0, 2, CAST(N'2022-03-30T04:27:14.000' AS DateTime), CAST(N'2022-03-30T04:29:05.000' AS DateTime), N'swfa03', 3, 2, N'swfa03', 2, N'', N'', N'', N'3PXp+xdFSXKEZheEkxmIwg', 1, N'', 5, N'', 10, N'', 99, N'', 99, N'', 0, 0, 0)

select * FROM swlive..ttccom100100 WHERE convert(date, t_stdt) >= DATEADD(MONTH,-24,GETDATE()) and convert(date, t_stdt) <= GETDATE() order by t_stdt

select * from swlive..ttccom100100   where convert(date, t_stdt) >= '2020-05-13' and convert(date, t_stdt) <= '2022-05-14' order by t_stdt

select [t_bpid], [t_ctit], [t_nama], [t_seak], [t_prbp], [t_prst], [t_stdt] from swlive..ttccom100100 group by t_stdt order by t_stdt



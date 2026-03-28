SET ECHO ON

SELECT DISTINCT s.Ename
FROM SkipperN s, ImplementsN i, VoyageN v
WHERE s.Eid=i.Eid
AND i.Vnum=v.Vnum
AND v.Sdate>TO_DATE('01-JUN-25','DD-MON-RR');

SELECT v.Vnum, v.Sdate
FROM VoyageN v, ImplementsN i 
WHERE v.Vnum=i.Vnum
AND v.Sdate<TO_DATE('15-JUL-25','DD-MON-RR')
GROUP BY v.Vnum,v.Sdate
HAVING COUNT(i.Eid)>1;

SELECT Bnum,Btype
FROM BoatN 
WHERE Bnum NOT IN 
(SELECT Bnum FROM VoyageN);

SELECT s.Ename,SUM(v.Duration)
FROM SkipperN s 
LEFT JOIN ImplementsN i ON s.Eid=i.Eid
LEFT JOIN VoyageN v ON i.Vnum=v.Vnum 
GROUP BY s.Ename;

SELECT DISTINCT b.Bnum,b.Btype
FROM BoatN b,VoyageN v
WHERE b.Bnum=v.Bnum
AND v.Duration=
(SELECT MAX(Duration) FROM VoyageN);

SELECT DISTINCT b.Bnum,b.Btype
FROM BoatN b,VoyageN v,ImplementsN i,SkipperN s 
WHERE b.Bnum=v.Bnum
AND v.Vnum=i.Vnum
AND i.Eid=s.Eid
AND s.Mid=
(SELECT Eid FROM SkipperN WHERE Ename='Loftus'); 

SELECT DISTINCT s.Eid,s.Ename
FROM SkipperN s, ImplementsN i,VoyageN v,BoatN b 
WHERE s.Eid=i.Eid
AND i.Vnum=v.Vnum
AND v.Bnum=b.Bnum
AND b.Btype IN ('Deck','Catamaran');

SELECT DISTINCT b.Bnum,b.Btype
FROM BoatN b,VoyageN v
WHERE b.Bnum=v.Bnum
AND v.Duration< 
(SELECT AVG(Duration) FROM VoyageN);



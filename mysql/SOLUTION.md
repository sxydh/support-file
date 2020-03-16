* 中位数工资
  ```sql
  # Write your MySQL query statement below
  SELECT r.id, r.company, r.salary FROM (
  SELECT partnume.*, partnume.partnum % 2 odd, CEIL(partnume.partnum / 2) middle FROM (
  SELECT desce.*, @partnum := IF(@descepre = desce.company, @partnum, desce.partrn) partnum, @descepre := desce.company FROM (
  SELECT parte.* FROM (
  SELECT asce.*, @partrn := IF(@ascepre = asce.company, @partrn + 1, 1) partrn, @ascepre := asce.company part FROM 
  (SELECT e.*, @rn := @rn + 1 rn FROM employee e, (SELECT @rn := 0) rnt ORDER BY e.company, e.salary) asce, (SELECT @ascepre := NULL, @partrn := 0) partt
  ) parte ORDER BY parte.rn DESC
  ) desce, (SELECT @descepre := NULL, @partnum := 0) partnumt
  ) partnume
  ) r WHERE (r.odd = 1 AND r.partrn = r.middle) OR (r.odd = 0 AND r.partrn IN (r.middle, r.middle + 1)) ORDER BY rn 
  ```
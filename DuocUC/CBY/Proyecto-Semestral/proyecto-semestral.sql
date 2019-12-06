--1
SELECT distinct(upper(E.edi_nombre_edificio)) as "NOMBRE EDIFICIO", count(distinct nro_departamento) AS "TOTAL DEPTOS",
SUM(CASE WHEN D.total_dormitorios=1 THEN 1 ELSE 0 END) AS "TOTAL DEPTOS 1 DORMITORIO",
SUM(CASE WHEN D.total_dormitorios=2 THEN 1 ELSE 0 END) AS "TOTAL DEPTOS 2 DORMITORIO",
SUM(CASE WHEN D.total_dormitorios=3 THEN 1 ELSE 0 END) AS "TOTAL DEPTOS 3 DORMITORIO",
SUM(CASE WHEN D.total_dormitorios=4 THEN 1 ELSE 0 END) AS "TOTAL DEPTOS 4 DORMITORIO",
SUM(CASE WHEN D.total_dormitorios=5 THEN 1 ELSE 0 END) AS "TOTAL DEPTOS 5 DORMITORIO"
from departamento D
left join edificio E
on D.id_edificio=E.id_edificio
group by E.edi_nombre_edificio
order by 1;

--2
select e.edi_nombre_edificio AS "NOMBRE EDIFICIO", c.nombre_comuna AS COMUNA ,to_char(a.adm_numrun,'999g999g999')||'-'||a.adm_dvrun AS "RUN ADMINISTRADOR"
, a.adm_pnombre||' '||a.adm_snombre||' '||a.adm_apellido_paterno||' '||a.adm_apellido_materno as "NOMBRE ADMINISTRADOR", count(distinct(d.nro_departamento)) as "TOTAL DEPARTAMENTO"
, count(distinct(g.gas_fecha_pago)) as "TOTAL DEPTO NO CANCELAN GC  "
from edificio e join comuna c on e.id_comuna=c.id_comuna join administrador a on e.adm_numrun=a.adm_numrun JOIN departamento d on d.id_edificio=e.id_edificio
join gasto_comun g on e.id_edificio=g.id_edificio join pago_gasto_comun pg on g.id_edificio=pg.id_edificio
where extract(year from g.gas_fecha_pago)=extract(year from sysdate)
and extract(month from g.gas_fecha_pago)=extract(month from sysdate)-1
and pg.pgc_monto_cancelado!=g.gas_gasto_total
group by  e.edi_nombre_edificio,c.nombre_comuna, to_char(a.adm_numrun,'999g999g999')||'-'||a.adm_dvrun ,a.adm_pnombre||' '||a.adm_snombre||' '||a.adm_apellido_paterno||' '||a.adm_apellido_materno;
---3
SELECT
(SELECT UPPER(edi.edi_nombre_edificio) FROM EDIFICIO edi WHERE gas.id_edificio=edi.id_edificio) as "EDIFICIO",
gas.nro_departamento AS "DEPARTAMENTO",
TO_CHAR(gas.gas_fecha_hasta,'MM/YYYY') AS  "PERIODO COBRO",
gas.gas_fecha_pago AS "FECHA DE PAGO",
pag.pgc_fecha_cancelacion AS "FECHA CANCELACION",
TO_CHAR(gas.gas_gasto_total,'$999g999g999') AS "TOTAL GASTO COMUN",
(pag.pgc_fecha_cancelacion)-(gas.gas_fecha_pago) AS "DIAS MORA",
('Se cobrará como multa del periodo ')||TO_CHAR(gas.gas_fecha_hasta,'MM/YYYY')||TO_CHAR(
CASE WHEN((pag.pgc_fecha_cancelacion)-(gas.gas_fecha_pago)) BETWEEN 1 AND 9 THEN ROUND(gas.gas_gasto_total*0.02)
WHEN((pag.pgc_fecha_cancelacion)-(gas.gas_fecha_pago)) BETWEEN 10 AND 15 THEN ROUND(gas.gas_gasto_total*0.04)
WHEN((pag.pgc_fecha_cancelacion)-(gas.gas_fecha_pago)) BETWEEN 16 AND 20 THEN ROUND(gas.gas_gasto_total*0.06)
WHEN((pag.pgc_fecha_cancelacion)-(gas.gas_fecha_pago)) BETWEEN 21 AND 25 THEN ROUND(gas.gas_gasto_total*0.08)
ELSE ROUND(gas.gas_gasto_total*0.1)END ,'$999g999g999') "OBSERVACION COBRO MULTAS"
FROM gasto_comun gas JOIN pago_gasto_comun pag
ON(gas.id_edificio=pag.id_edificio AND gas.nro_departamento=pag.nro_departamento AND gas.pco_periodo=pag.pco_periodo)
WHERE (pag.pgc_fecha_cancelacion)-(gas.gas_fecha_pago)>5
ORDER BY
7 DESC,1 ASC;

--4
SELECT
    (SELECT UPPER(e.edi_nombre_edificio) FROM EDIFICIO E WHERE e.id_edificio=g.id_edificio)AS "NOMBRE EDIFICIO",
    g.nro_departamento "DEPARTAMENTO",
    TO_CHAR(g.gas_gasto_total,'$999g999g999') AS "TOTAL GASTOS COMUNES",
    (SELECT TO_CHAR(g.rpgc_numrun,'999g999g999')||'-'||r.rpgc_dvrun FROM responsable_pago_gasto_comun r
                WHERE g.rpgc_numrun=r.rpgc_numrun)AS "RUN RESPONSABLE",
    (SELECT NVL(INITCAP(r.rpgc_pnombre),'')||' '||NVL(INITCAP(r.rpgc_snombre),'')||' '||NVL(INITCAP(r.rpgc_apellido_paterno),'')||' '||NVL(INITCAP(r.rpgc_apellido_materno),'')
                  FROM responsable_pago_gasto_comun r WHERE g.rpgc_numrun=r.rpgc_numrun)"NOMBRE RESPONSABLE",
    (SELECT tip.tp_descripcion FROM tipo_persona tip WHERE tip.id_tipo_persona=(SELECT r.id_tipo_persona FROM responsable_pago_gasto_comun r WHERE g.rpgc_numrun=r.rpgc_numrun))"DUEÑO/ARRIENDA/REPRESENTA"
FROM gasto_comun g
WHERE TO_CHAR(g.pco_periodo)=TO_CHAR(ADD_MONTHS(sysdate,-1),'YYYYMM');
--5


select E.edi_nombre_edificio, G.nro_departamento, TO_CHAR(g.gas_fecha_desde,'MM/YYYY')"PERIODO COBRO",TO_CHAR((NVL(g.gas_gasto_total,0)),'$999g999g999') as "TOTAL GASTO COMUN"
, TO_CHAR((NVL(pg.pgc_monto_cancelado,0)),'$999g999g999') as "MONTO CANCELADO", TO_CHAR((g.gas_gasto_total-NVL(pg.pgc_monto_cancelado,0)),'$999g999g999')AS "DEUDA"
from edificio E, GASTO_COMUN G ,PAGO_GASTO_COMUN PG
WHERE E.ID_EDIFICIO=G.ID_EDIFICIO
AND G.NRO_DEPARTAMENTO=PG.NRO_DEPARTAMENTO
AND G.ID_EDIFICIO=PG.ID_EDIFICIO
AND G.PCO_PERIODO=PG.PCO_PERIODO
AND g.gas_gasto_total<>(NVL(pg.pgc_monto_cancelado,0))
and extract(year from g.gas_fecha_DESDE)=extract(year from sysdate)
and extract(month from g.gas_fecha_DESDE)=extract(month from sysdate)-1

GROUP BY E.edi_nombre_edificio, G.nro_departamento, G.gas_fecha_desde,G.gas_gasto_total, PG.pgc_monto_cancelado
ORDER BY 3,1, 6 desc;
---6
SELECT
(SELECT UPPER(edi.edi_nombre_edificio) FROM edificio edi WHERE edi.id_edificio=gas.id_edificio) AS "EDIFICIO",
gas.nro_departamento AS "DEPARTAMENTO",
TO_CHAR(gas.gas_fecha_hasta,'MM/YYYY') AS "PERIODO COBRO",
gas.gas_fecha_pago AS "FECHA DE PAGO",
pag.pgc_fecha_cancelacion AS "FECHA EN QUE CANCELÓ",
TO_CHAR(gas.gas_gasto_total,'$999g999g999') AS  "TOTAL GASTO COMUN",
TO_CHAR(pag.pgc_monto_cancelado,'$999g999g999') AS "MONTO CANCELADO",
(SELECT INITCAP(f.fpa_descripcion) FROM forma_pago f WHERE pag.id_forma_pago=f.id_forma_pago) AS  "FORMA DE PAGO"
FROM gasto_comun gas
JOIN pago_gasto_comun pag
ON(gas.id_edificio=pag.id_edificio AND gas.nro_departamento=pag.nro_departamento AND gas.pco_periodo=pag.pco_periodo)
WHERE TO_CHAR(gas.pco_periodo)=TO_CHAR(ADD_MONTHS(sysdate,-1),'YYYYMM')
ORDER BY 1 , 2 ;



--7
SELECT pco_periodo "PERIODO COBRO GASTO COMUN",
(SELECT edi.edi_nombre_edificio FROM edificio edi WHERE edi.id_edificio=gas.id_edificio)"EDIFICIO",
nro_departamento "NUMERO DE DEPARTAMENTO"
FROM gasto_comun gas
WHERE TO_CHAR(pco_periodo)=TO_CHAR(ADD_MONTHS(sysdate,-1),'YYYYMM')--Igualar el Atributo de periodo de cobro a la fecha actual con mes anterior
MINUS
SELECT pco_periodo "PERIODO COBRO GASTO COMUN",
(SELECT edi.edi_nombre_edificio FROM edificio edi WHERE edi.id_edificio=gas.id_edificio)"EDIFICIO",
nro_departamento "NUMERO DE DEPARTAMENTO"
FROM pago_gasto_comun gas
WHERE    TO_CHAR(pco_periodo)=TO_CHAR(ADD_MONTHS(sysdate,-1),'YYYYMM')
ORDER BY 2 ;
--8

SELECT
(SELECT UPPER(edi.edi_nombre_edificio) FROM edificio edi WHERE gas.id_edificio=edi.id_edificio) "NOMBRE EDIFICIO",
(SELECT (SELECT INITCAP(co.nombre_comuna) FROM COMUNA CO WHERE CO.id_comuna=edi.id_comuna) FROM edificio edi WHERE edi.id_edificio=gas.id_edificio) "COMUNA",
(gas.gas_fecha_desde ||'-'||gas.gas_fecha_hasta) "PERIODO COBRO",
COUNT(gas.nro_departamento) "TOTAL DEPARTAMENTOS",
TO_CHAR(SUM(NVL(gas.gas_fondo_reserva,0)),'$999g999g999') "FONDO RESERVA",
TO_CHAR(SUM(NVL(gas.gas_agua_individual,0)),'$999g999g999') "AGUA INDIVIDUAL",
TO_CHAR(SUM(NVL(gas.gas_combustible_individual,0)),'$999g999g999') "COMBUSTIBLE INDIVIDUAL",
TO_CHAR(SUM(NVL(gas.gas_lavanderia,0)),'$999g999g999') "LAVANDERIA",
TO_CHAR(SUM(NVL(gas.gas_eventos,0)),'$999g999g999') "EVENTOS",
TO_CHAR(SUM(NVL(gas.gas_gastos_atrasados,0)),'$999g999g999') "GASTOS ATRASADOS",
TO_CHAR(SUM(NVL(gas.gas_multas,0)),'$999g999g999') "MULTAS",
TO_CHAR(SUM(NVL(gas.gas_gasto_total,0)),'$999g999g999') "TOTAL GASTOS COMUNES"
FROM gasto_comun gas
WHERE (EXTRACT(YEAR from gas.gas_fecha_desde)=EXTRACT(YEAR from sysdate)-1)
GROUP BY gas.gas_fecha_desde, gas.gas_fecha_hasta, gas.id_edificio
ORDER BY 3  ,1  ;
-- 10
UPDATE GASTO_COMUN_PRUEBAESTPAGO GCP set ID_ESTADO_PAGO=
(
SELECT
(CASE
WHEN NVL(gasto_total,0)-NVL(monto_cancelado,0)=0 THEN (SELECT id_estado_pago FROM estado_pago WHERE epa_descripcion='PAGADO')
WHEN (NVL(gasto_total,0)-NVL(monto_cancelado,0))>0 AND (NVL(gasto_total,0)-NVL(monto_cancelado,0))<gasto_total  THEN (SELECT id_estado_pago FROM estado_pago WHERE epa_descripcion='ATRASADO')
ELSE (SELECT id_estado_pago FROM estado_pago WHERE epa_descripcion='PENDIENTE')
END) as "id_est_pago"
FROM
(SELECT
gc.PCO_PERIODO as pco,
gc.NRO_DEPARTAMENTO as depto,
gc.ID_EDIFICIO as edi,
gc.gas_gasto_total as gasto_total,
pgc.pgc_monto_cancelado as monto_cancelado
FROM gasto_comun_pruebaestpago gc LEFT JOIN pago_gasto_comun_pruebaestpago pgc
ON(gc.pco_periodo=pgc.pco_periodo AND gc.id_edificio=pgc.id_edificio AND gc.nro_departamento=pgc.nro_departamento))
WHERE(pco=gcp.PCO_PERIODO AND depto=gcp.NRO_DEPARTAMENTO AND edi=gcp.ID_EDIFICIO));

--11.1

SELECT gc.pco_periodo,
gc.id_edificio,
gc.nro_departamento,
pgc.pgc_monto_cancelado,
pgc.id_forma_pago
FROM GASTO_COMUN gc JOIN PAGO_GASTO_COMUN pgc ON (gc.PCO_PERIODO=pgc.PCO_PERIODO AND gc.NRO_DEPARTAMENTO=pgc.NRO_DEPARTAMENTO AND gc.ID_EDIFICIO=pgc.ID_EDIFICIO)
WHERE(EXTRACT(MONTH FROM gc.GAS_FECHA_HASTA)=09)
UNION
SELECT gc.pco_periodo,
gc.id_edificio,
gc.nro_departamento,
pgc.pgc_monto_cancelado,
pgc.id_forma_pago
FROM GASTO_COMUN gc JOIN PAGO_GASTO_COMUN_MENSUAL pgc ON(gc.PCO_PERIODO=pgc.PCO_PERIODO AND gc.NRO_DEPARTAMENTO=pgc.NRO_DEPARTAMENTO AND gc.ID_EDIFICIO=pgc.ID_EDIFICIO)
WHERE(EXTRACT(MONTH FROM gc.GAS_FECHA_HASTA)=09);
------------------
--11.2

SELECT gc.pco_periodo,
gc.id_edificio,
gc.nro_departamento,
pgc.pgc_monto_cancelado,
pgc.id_forma_pago
FROM GASTO_COMUN gc JOIN PAGO_GASTO_COMUN_MENSUAL pgc ON(gc.PCO_PERIODO=pgc.PCO_PERIODO AND gc.NRO_DEPARTAMENTO=pgc.NRO_DEPARTAMENTO AND gc.ID_EDIFICIO=pgc.ID_EDIFICIO)
WHERE(EXTRACT(MONTH FROM gc.GAS_FECHA_HASTA)=09)
MINUS
SELECT gc.pco_periodo,
gc.id_edificio,
gc.nro_departamento,
pgc.pgc_monto_cancelado,
pgc.id_forma_pago
FROM GASTO_COMUN gc JOIN PAGO_GASTO_COMUN pgc ON (gc.PCO_PERIODO=pgc.PCO_PERIODO AND gc.NRO_DEPARTAMENTO=pgc.NRO_DEPARTAMENTO AND gc.ID_EDIFICIO=pgc.ID_EDIFICIO)
WHERE(EXTRACT(MONTH FROM gc.GAS_FECHA_HASTA)=09);

-- 11.3


INSERT INTO pago_gasto_comun pgc
(SELECT GC.pco_periodo,
        GC.id_edificio,
        GC.nro_departamento,
        pgc.pgc_fecha_cancelacion,
        pgc.pgc_monto_cancelado,
        pgc.id_forma_pago
        FROM GASTO_COMUN GC JOIN PAGO_GASTO_COMUN_MENSUAL pgc
        ON (GC.PCO_PERIODO=pgc.PCO_PERIODO AND gc.NRO_DEPARTAMENTO=pgc.NRO_DEPARTAMENTO AND GC.ID_EDIFICIO=pgc.ID_EDIFICIO)
        WHERE(EXTRACT(MONTH FROM GC.GAS_FECHA_HASTA)=09)
        MINUS
        SELECT GC.pco_periodo,
        GC.id_edificio,
        GC.nro_departamento,
        pgc.pgc_fecha_cancelacion,
        pgc.pgc_monto_cancelado,
        pgc.id_forma_pago
        FROM PAGO_GASTO_COMUN GC JOIN PAGO_GASTO_COMUN_MENSUAL pgc
        ON (GC.PCO_PERIODO=pgc.PCO_PERIODO AND GC.NRO_DEPARTAMENTO=pgc.NRO_DEPARTAMENTO AND GC.ID_EDIFICIO=pgc.ID_EDIFICIO)
        WHERE(EXTRACT(MONTH FROM GC.PGC_FECHA_CANCELACION)-1=09));

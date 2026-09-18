-- ==========================================================================
-- Compilacao da package apos a alteracao
-- ==========================================================================
ALTER PACKAGE Xxisv_Csf_Nfe_Pkg COMPILE PACKAGE;
ALTER PACKAGE Xxisv_Csf_Nfe_Pkg COMPILE BODY;

-- Erros de compilacao (se houver), do specification e do body
SELECT ue.line, ue.position, ue.text
  FROM user_errors ue
 WHERE ue.name = 'XXISV_CSF_NFE_PKG'
 ORDER BY ue.type, ue.sequence;

-- ==========================================================================
-- 1) Reexecutar a query original isolada para uma linha conhecida,
--    comparando com o que a package efetivamente gravou
-- ==========================================================================
-- Troque :p_customer_trx_line_id pela linha que deseja validar.

-- ---- 1.1: saida da query de referencia (mesma logica incorporada na package)
WITH item AS
(
    SELECT rctl.customer_trx_line_id,
           rctl.customer_trx_id,
           rctl.org_id,
           rctt.global_attribute7 AS rctt_global_attribute7,
           rctt.global_attribute8 AS rctt_global_attribute8
      FROM ra_customer_trx_lines_all rctl
      JOIN ra_customer_trx_all rcta
        ON rcta.customer_trx_id = rctl.customer_trx_id
       AND rcta.org_id          = rctl.org_id
      JOIN ra_cust_trx_types_all rctt
        ON rctt.cust_trx_type_id = rcta.cust_trx_type_id
       AND rctt.org_id            = rcta.org_id
     WHERE rctl.customer_trx_line_id = :p_customer_trx_line_id
       AND rctl.line_type = 'LINE'
),
tax_base AS
(
    SELECT zl.trx_line_id AS link_to_cust_trx_line_id,
           zl.trx_id      AS customer_trx_id,
           arvt.global_attribute10 AS arvt_global_attribute10,
           arvt.global_attribute13 AS arvt_global_attribute13,
           arvt.global_attribute14 AS arvt_global_attribute14,
           arvt.global_attribute20 AS arvt_global_attribute20,
           zl.global_attribute13   AS zl_global_attribute13,
           zl.global_attribute14   AS zl_global_attribute14,
           zl.taxable_amt,
           zl.tax_rate,
           ABS(NVL(zl.cal_tax_amt, zl.tax_amt)) AS tax_amount,
           i.rctt_global_attribute7,
           i.rctt_global_attribute8,
           COALESCE(zl.global_attribute13,
               CASE
                   WHEN UPPER(arvt.global_attribute10) LIKE '%CBS%' THEN SUBSTR(i.rctt_global_attribute7, 1, 3)
                   WHEN UPPER(arvt.global_attribute10) LIKE '%IBS%' THEN SUBSTR(i.rctt_global_attribute8, 1, 3)
               END) AS cst_resolvido,
           COALESCE(zl.global_attribute14,
               CASE
                   WHEN UPPER(arvt.global_attribute10) LIKE '%CBS%' THEN i.rctt_global_attribute7
                   WHEN UPPER(arvt.global_attribute10) LIKE '%IBS%' THEN i.rctt_global_attribute8
               END) AS cclass_trib_resolvida
      FROM zx_lines zl
      JOIN ar_vat_tax_all arvt
        ON arvt.vat_tax_id = zl.tax_rate_id
       AND arvt.org_id      = zl.internal_organization_id
      JOIN item i
        ON i.customer_trx_line_id = zl.trx_line_id
       AND i.customer_trx_id      = zl.trx_id
     WHERE arvt.global_attribute2 = 'Y'
       AND (UPPER(arvt.global_attribute10) LIKE '%IBS%' OR UPPER(arvt.global_attribute10) LIKE '%CBS%')
),
tax_calculo AS
(
    SELECT tb.*,
           SUBSTR(TRIM(tb.cst_resolvido), 1, 3) AS cst_normalizado,
           CASE
               WHEN REGEXP_LIKE(TRIM(tb.arvt_global_attribute13), '^[+-]?([0-9]+([,.][0-9]*)?|[,.][0-9]+)$')
               THEN FND_NUMBER.CANONICAL_TO_NUMBER(REPLACE(TRIM(tb.arvt_global_attribute13), ',', '.'))
           END AS aliq_arvt_attribute13,
           CASE
               WHEN REGEXP_LIKE(TRIM(tb.arvt_global_attribute14), '^[+-]?([0-9]+([,.][0-9]*)?|[,.][0-9]+)$')
               THEN FND_NUMBER.CANONICAL_TO_NUMBER(REPLACE(TRIM(tb.arvt_global_attribute14), ',', '.'))
           END AS per_redaliq
      FROM tax_base tb
),
tax AS
(
    SELECT tc.*,
           CASE
               WHEN tc.cst_normalizado IN ('200', '510', '515') THEN COALESCE(tc.aliq_arvt_attribute13, ABS(tc.tax_rate))
               ELSE ABS(tc.tax_rate)
           END AS aliquota_aplicavel,
           CASE
               WHEN tc.arvt_global_attribute20 = tc.cclass_trib_resolvida AND tc.cst_normalizado IN ('510', '515') THEN 1
               ELSE 0
           END AS ind_diferimento,
           CASE
               WHEN tc.arvt_global_attribute20 = tc.cclass_trib_resolvida AND tc.cst_normalizado IN ('510', '515') THEN 100
               ELSE 0
           END AS percent_difer
      FROM tax_calculo tc
)
SELECT t.link_to_cust_trx_line_id,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%MUN%' THEN t.aliquota_aplicavel END) AS aliq_apli_ibsmun,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%MUN%' AND t.cst_normalizado IN ('200','510','515') THEN t.per_redaliq END) AS per_redaliq_ibs_mun,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%MUN%' AND t.ind_diferimento = 1 THEN t.percent_difer END) AS percent_difer_ibsmun,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%MUN%' AND t.ind_diferimento = 1 THEN ROUND(t.tax_amount * (t.percent_difer/100), 2) END) AS vl_imp_difer_ibs_mun,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%MUN%' THEN ROUND(t.tax_amount - (t.tax_amount * (t.percent_difer/100)), 2) END) AS vl_imp_trib_ibsmun,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%UF%' THEN t.aliquota_aplicavel END) AS aliq_apli_ibsuf,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%UF%' AND t.cst_normalizado IN ('200','510','515') THEN t.per_redaliq END) AS per_redaliq_ibs_uf,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%UF%' AND t.ind_diferimento = 1 THEN t.percent_difer END) AS percent_difer_ibs_uf,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%UF%' AND t.ind_diferimento = 1 THEN ROUND(t.tax_amount * (t.percent_difer/100), 2) END) AS vl_imp_difer_ibs_uf,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%IBS%UF%' THEN ROUND(t.tax_amount - (t.tax_amount * (t.percent_difer/100)), 2) END) AS vl_imp_trib_ibsuf,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%CBS%' THEN t.aliquota_aplicavel END) AS aliq_apli_cbs,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%CBS%' AND t.cst_normalizado IN ('200','510','515') THEN t.per_redaliq END) AS per_redaliq_cbs,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%CBS%' AND t.ind_diferimento = 1 THEN t.percent_difer END) AS percent_difer_cbs,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%CBS%' AND t.ind_diferimento = 1 THEN ROUND(t.tax_amount * (t.percent_difer/100), 2) END) AS vl_imp_difer_cbs,
       MAX(CASE WHEN UPPER(t.arvt_global_attribute10) LIKE '%CBS%' THEN ROUND(t.tax_amount - (t.tax_amount * (t.percent_difer/100)), 2) END) AS vl_imp_trib_cbs
  FROM tax t
 GROUP BY t.link_to_cust_trx_line_id;

-- ---- 1.2: o que a package efetivamente gravou na tabela base (valor final do imposto)
SELECT cpj.cod_imposto,   -- 28 = IBS Estadual, 29 = CBS
       cpj.dm_tipo,
       cpj.cod_st,
       cpj.vl_base_calc,
       cpj.aliq_apli,
       cpj.vl_imp_trib     -- deve bater com vl_imp_trib_ibsuf (28) ou vl_imp_trib_cbs (29) da query acima
  FROM vw_csf_imp_itemnf cpj
 WHERE cpj.cod_imposto IN (28, 29)
   AND EXISTS (SELECT 1
                 FROM ra_customer_trx_lines_all rctla
                WHERE rctla.customer_trx_line_id = :p_customer_trx_line_id
                  AND rctla.customer_trx_id = cpj.cpf_cnpj_emit /* ajuste conforme as chaves reais de rvcinf usadas na carga */);
-- Observacao: como Vw_Csf_Imp_Itemnf nao guarda o customer_trx_line_id diretamente,
-- valide preferencialmente pela chave de negocio (Cpf_Cnpj_Emit + Cod_Mod + Serie + Nro_Nf + Nro_Item)
-- correspondente a nota gerada a partir dessa linha, ou rode via debug/trace na propria carga.

-- ---- 1.3: atributos gravados na tabela de extensao (FF), para a mesma chave
SELECT ff.cod_imposto,
       ff.dm_tipo,
       ff.atributo,
       ff.valor
  FROM vw_csf_imp_itemnf_ff ff
 WHERE ff.cod_imposto IN (28, 29)
   AND ff.atributo IN ('PERCENT_DIFER',
                        'VL_IMP_DIFER_UF',
                        'PER_REDALIQ_IBS_CBS',
                        'ALIQ_EFET_IBS_CBS',
                        'ALIQ_APLIC_MUN',
                        'VL_IMP_TRIB_MUN',
                        'PER_REDALIQ_IBS_MUN',
                        'PERCENT_DIFER_MUN',
                        'VL_IMP_DIFER_MUN')
   -- complete com Cpf_Cnpj_Emit/Cod_Mod/Serie/Nro_Nf/Nro_Item da nota gerada para a linha testada
 ORDER BY ff.cod_imposto, ff.dm_tipo, ff.atributo;

-- ==========================================================================
-- 2) Checagem de duplicidade (nao deve haver mais de 1 linha por chave+atributo)
-- ==========================================================================
SELECT cpf_cnpj_emit, dm_ind_emit, dm_ind_oper, cod_part, cod_mod, serie,
       nro_nf, nro_item, cod_imposto, dm_tipo, atributo, COUNT(*) qtd
  FROM vw_csf_imp_itemnf_ff
 GROUP BY cpf_cnpj_emit, dm_ind_emit, dm_ind_oper, cod_part, cod_mod, serie,
          nro_nf, nro_item, cod_imposto, dm_tipo, atributo
HAVING COUNT(*) > 1;

-- ==========================================================================
-- 3) Simulacao dos 3 cenarios (Full Taxation, Tax Rate Reduction, Deferred)
--    para IBS Municipal, IBS Estadual e CBS, isolada da query, so com valores
--    de exemplo (ajuste conforme o caso real que quiser validar)
-- ==========================================================================
-- 3.1 Sem diferimento e sem reducao (CST 000): vl_imp_trib = tax_amount (percent_difer = 0)
--     Ex.: tax_amount = 100,00  -> vl_imp_trib = 100,00 ; vl_imp_difer = null (nao aplicavel)

-- 3.2 Com reducao de aliquota, sem diferimento (CST 200):
--     aliquota_aplicavel = 0,0400 ; per_redaliq = 60,0000
--     aliquota_efetiva   = 0,0400 * (1 - 60/100) = 0,0160
--     (vl_imp_trib segue vindo do proprio Zx_Lines/Tax_Amt, que a essa altura
--      ja foi calculado pelo motor de imposto do EBS usando a aliquota reduzida)

-- 3.3 Com diferimento (CST 510 ou 515), ClassTrib da linha = ClassTrib do diferimento (ARVT.GLOBAL_ATTRIBUTE20):
--     tax_amount = 100,00 ; percent_difer = 100
--     vl_imp_difer = ROUND(100,00 * (100/100), 2) = 100,00
--     vl_imp_trib  = ROUND(100,00 - (100,00 * (100/100)), 2) = 0,00  <- valor final, sem segunda deducao

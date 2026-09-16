CREATE OR REPLACE Package Xxisv_Csf_Nfe_Pkg Authid Current_User As

  --
  -- +=================================================================+
  -- |     COPYRIGHT (C) 2017 ALC Soluções em TI e Processos LTDA.     |
  -- |            SÃO PAULO, BRASIL, ALL RIGHTS RESERVED.              |
  -- |                   PHONE: (11) 98119-4405                        |
  -- +=================================================================+
  -- | NOME OBJETO.........: XXISV.Xxisv_Csf_NFE_Pkg                   |
  -- | NOME FISICO.........: XXISV.Xxisv_Csf_NFE_Pkg.pck               |
  -- | LAYOUT..............: NFE                                       |
  -- | TIPO_OBJETO.........: PACKAGE                                   |
  -- | VERSÃO..............: EBS R12.1.3                               |
  -- | REFERENCIA..........: AR                                        |
  -- | VIEW CLL  ..........:                                           |
  -- | AUTOR...............: ANDRE LUIZ CARRANZA                       |
  -- | E-MAIL..............: andre.carranza@alcconsulting.com.br       |
  -- | TELEFONE............: (11) 98119-4405                           |
  -- | DATA................: 01/01/2017                                |
  -- |                                                                 |
  -- *******************************************************************
  -- *                    A L T E R A Ç Õ E S                          *
  -- *******************************************************************
  -- *                                                                 *
  -- *                                                                 *
  -- *                                                                 *
  -- *******************************************************************
  -- *                  C U S T O M I Z A Ç Õ E S                      *
  -- *******************************************************************
  -- *                                                                 *
  -- *                                                                 *
  -- *                                                                 *
  -- *******************************************************************
  --
  g_Retcode Number := 0;

  g_Erro     Number := 0; ---ito 23/10/2017
  g_Erro_Msg Varchar2(4000);

  g_Vsegment Varchar2(30);

  Procedure Main_p(Errbuf            Out Varchar2
                  ,Retcode           Out Number
                  ,p_Org_Id          In Ra_Customer_Trx_All.Org_Id%Type
                  ,p_Mod_Fiscal      In Fnd_Lookup_Values.Lookup_Code%Type
                  ,p_Status_Nfe      In Fnd_Lookup_Values.Lookup_Code%Type Default Null
                  ,p_Batch_Source_Id In Ar.Ra_Batch_Sources_All.Batch_Source_Id%Type
                  ,p_Trx_Num_Ini     In Ra_Customer_Trx_All.Trx_Number%Type
                  ,p_Trx_Num_Fim     In Ra_Customer_Trx_All.Trx_Number%Type
                  ,p_Data_Ini        In Varchar2
                  ,p_Data_Fim        In Varchar2);

  --
  Procedure Main_Resp_Canc_p(Errbuf  Out Varchar2
                            ,Retcode Out Number);

  --
  Procedure Vw_Csf_Resp_Nf_Erp_p;

  --
  Procedure Vw_Csf_Nota_Fiscal_Canc_p;

  --
  Procedure Atualiza_Vw_Csf_Resp_Nf_Erp_p;

  --
  --Procedure Delete_Vw_Csf_p;
  --
  /*Procedure Del_Vw_Csf_Nf_p
  (
    p_Cpf_Cnpj_Emit In Varchar2
   ,p_Dm_Ind_Emit   In Number
   ,p_Dm_Ind_Oper   In Number
   ,p_Cod_Part      In Varchar2
   ,p_Cod_Mod       In Varchar2
   ,p_Serie         In Varchar2
   ,p_Nro_Nf        In Number
  );*/
  --
  Procedure Pb_Limpa_Interface_p(p_Sist_Orig     Varchar2 Default Null
                                ,p_Cnpj_Cpf_Emit Varchar2 Default Null
                                ,p_Nro_Nf        Varchar2 Default Null
                                ,p_Serie         Varchar2 Default Null);

  --
  Procedure Vw_Csf_Nota_Fiscal_p(p_Customer_Trx_Id Number
                                ,p_Rotina          Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Ff_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                   ,p_Customer_Trx_Id Number
                                   ,p_Uf_Ibge_Dest    Number
                                   ,p_Dm_Ind_Final    Number
                                   ,p_Im              Varchar2
                                   ,p_Rotina          Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Compl_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                      ,p_Customer_Trx_Id Number
                                      ,p_Rotina          Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Emit_p(p_Rvcnf        Vw_Csf_Nota_Fiscal%Rowtype
                                     ,p_Warehouse_Id Number
                                     ,p_Ie           Varchar2
                                     ,p_Im           Varchar2
                                     ,p_Rotina       Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Dest_p(p_Rvcnf       Vw_Csf_Nota_Fiscal%Rowtype
                                     ,p_Site_Use_Id Number
                                     ,p_Rotina      Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Dest_Ff_p(p_Rvcnfd         Vw_Csf_Nota_Fiscal_Dest%Rowtype
                                        ,p_Dm_Ind_Ie_Dest Number
                                        ,p_Rotina         Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Total_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                      ,p_Customer_Trx_Id Number
                                      ,p_Rotina          Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Total_Ff_p(p_Rvcnft          Vw_Csf_Nota_Fiscal_Total%Rowtype
                                         ,p_Customer_Trx_Id Number
                                         ,p_Dm_Fin_Nfe      Number
                                         ,p_Rotina          Varchar2);

  -- 
  Procedure Vw_Csf_Nf_Total_Ff_Custom_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                       ,p_Customer_Trx_Id Number
                                        ---                                       ,p_Dm_Fin_Nfe      Number
                                       ,p_Rotina Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Referen_p(p_Rvcnf               Vw_Csf_Nota_Fiscal%Rowtype
                                        ,p_Customer_Trx_Id     Number
                                        ,p_Customer_Trx_Id_Ref Number
                                        ,p_Rotina              Varchar2);

  --
  Procedure Vw_Csf_Nfinfor_Adic_p(p_Rvcnf                    Vw_Csf_Nota_Fiscal%Rowtype
                                 ,p_Customer_Trx_Id          Number
                                 ,p_Comments                 Varchar2
                                 ,p_Legal_Process_Source_Ind Varchar2
                                 ,p_Rotina                   Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Cobr_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                     ,p_Customer_Trx_Id Number
                                     ,p_Rotina          Varchar2);

  --
  Procedure Vw_Csf_Nf_Cobr_Dup_p(p_Rvcnfc          Vw_Csf_Nota_Fiscal_Cobr%Rowtype
                                ,p_Customer_Trx_Id Number
                                ,p_Rotina          Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Local_p(p_Rvcnf               Vw_Csf_Nota_Fiscal%Rowtype
                                      ,p_Warehouse_Id        Number
                                      ,p_Ie                  Varchar2
                                      ,p_Ship_To_Site_Use_Id Number
                                      ,p_Rotina              Varchar2);

  --
  Procedure Vw_Csf_Nota_Fiscal_Transp_p(p_Rvcnf        Vw_Csf_Nota_Fiscal%Rowtype
                                       ,p_Fob_Point    Ra_Customer_Trx_All.Fob_Point%Type
                                       ,p_Ship_Via     Ra_Customer_Trx_All.Ship_Via%Type
                                       ,p_Warehouse_Id Number
                                       ,p_Rotina       Varchar2);

  --
  Procedure Vw_Csf_Nftransp_Veic_p(p_Rvcnf                       Vw_Csf_Nota_Fiscal%Rowtype
                                  ,p_License_Plate               Varchar2
                                  ,p_Vehicle_Plate_State_Code    Varchar2
                                  ,p_Vehicle_Antt_Inscription    Varchar2
                                  ,p_Towing_Veh_Plate_Number     Varchar2
                                  ,p_Towing_Veh_Plate_State_Code Varchar2
                                  ,p_Towing_Veh_Antt_Inscription Varchar2
                                  ,p_Wagon_Code                  Varchar2
                                  ,p_Ferry_Code                  Varchar2
                                  ,p_Rotina                      Varchar2);

  --
  Procedure Vw_Csf_Nftransp_Vol_p(p_Rvcnf            Vw_Csf_Nota_Fiscal%Rowtype
                                 ,p_Bulk_Number      Varchar2
                                 ,p_Bulk             Varchar2
                                 ,p_Species_Turnover Varchar2
                                 ,p_Weight           Number
                                 ,p_Net_Weight       Number
                                 ,p_Rotina           Varchar2);

  --
  Procedure Vw_Csf_Nftranspvol_Lacre_p(p_Rvcnf       Vw_Csf_Nota_Fiscal%Rowtype
                                      ,p_Bulk_Number Varchar2
                                      ,p_Seal_Number Varchar2
                                      ,p_Rotina      Varchar2);

  --
  Procedure Vw_Csf_Item_Nota_Fiscal_p(p_Rvcnf              Vw_Csf_Nota_Fiscal%Rowtype
                                     ,p_Customer_Trx_Id    Number
                                     ,p_Vl_Frete           Number
                                     ,p_Vl_Seguro          Number
                                     ,p_Vl_Outras_Despesas Number
                                     ,p_Uf_Dest            Varchar2
                                     ,p_Pedido_Compra      Varchar2
                                     ,p_Tipo_Transacao     Varchar2
                                     ,p_Rotina             Varchar2);

  --
  Procedure Vw_Csf_Item_Nota_Fiscal_Ff_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                                        ,p_Customer_Trx_Line_Id Number
                                        ,p_Customer_Trx_Id      Number
                                        ,p_Dm_Fin_Nfe           Number
                                        ,p_Tipo_Transacao       Varchar2
                                        ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnf_Compl_p(p_Rvcinf            Vw_Csf_Item_Nota_Fiscal%Rowtype
                                 ,p_Inventory_Item_Id Number
                                 ,p_Rotina            Varchar2);

  --
  Procedure Vw_Csf_Imp_Itemnf_p(p_Rvcinf                 Vw_Csf_Item_Nota_Fiscal%Rowtype
                               ,p_Customer_Trx_Line_Id   Number
                               ,p_Customer_Trx_Id        Number
                               ,p_Interface_Line_Context Varchar2
                               ,p_Cclass_Trib_Cbs        Varchar2
                               ,p_Cclass_Trib_Ibs        Varchar2
                               ,p_Rotina                 Varchar2);

  --
  Procedure Vw_Csf_Imp_Itemnf_Cust_p(p_Rvcinf                 Vw_Csf_Item_Nota_Fiscal%Rowtype
                                    ,p_Customer_Trx_Line_Id   Number
                                    ,p_Customer_Trx_Id        Number
                                    ,p_Interface_Line_Context Varchar2
                                    ,p_Cclass_Trib_Cbs        Varchar2
                                    ,p_Cclass_Trib_Ibs        Varchar2
                                    ,p_Rotina                 Varchar2);

  --
  Procedure Vw_Csf_Imp_Itemnf_Ff_p(p_Rvcii                Vw_Csf_Imp_Itemnf%Rowtype
                                  ,p_Customer_Trx_Line_Id Number
                                  ,p_Cod_Imposto          Number
                                  ,p_Cclass_Trib_Cbs      Varchar2
                                  ,p_Cclass_Trib_Ibs      Varchar2
                                  ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Imp_Itemnf_Icms_Dest_p(p_Rvcii                  Vw_Csf_Imp_Itemnf%Rowtype
                                         ,p_Customer_Trx_Line_Id   Number
                                         ,p_Customer_Trx_Id        Number
                                         ,p_Cod_Imposto            Number
                                         ,p_Interface_Line_Context Varchar2
                                         ,p_Rotina                 Varchar2);

  --
  Procedure Vw_Csf_Impitemnf_Icmsdest_Ff_p(p_Rvciid Vw_Csf_Imp_Itemnf_Icms_Dest%Rowtype
                                          ,p_Rotina Varchar2);

  --
  Procedure Vw_Csf_Itemnf_Comb_p(p_Rvcinf            Vw_Csf_Item_Nota_Fiscal%Rowtype
                                ,p_Inventory_Item_Id Number
                                ,p_Warehouse_Id      Number
                                ,p_Uf_Cons           Varchar2
                                ,p_Rotina            Varchar2);

  --
  Procedure Vw_Csf_Itemnf_Med_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                               ,p_Customer_Trx_Line_Id Number
                               ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnf_Med_Ff_p(p_Rvcim                Vw_Csf_Itemnf_Med%Rowtype
                                  ,p_Customer_Trx_Line_Id Number
                                  ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnf_Rastreab_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                                    ,p_Customer_Trx_Line_Id Number
                                    ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnf_Dec_Impor_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                                     ,p_Customer_Trx_Line_Id Number
                                     ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnf_Dec_Impor_Ff_p(p_Rvcidi               Vw_Csf_Itemnf_Dec_Impor%Rowtype
                                        ,p_Customer_Trx_Line_Id Number
                                        ,p_Customer_Trx_Id      Number
                                        ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnfdi_Adic_p(p_Rvcidi               Vw_Csf_Itemnf_Dec_Impor%Rowtype
                                  ,p_Customer_Trx_Line_Id Number
                                  ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnfdi_Adic_Ff_p(p_Rvcia                Vw_Csf_Itemnfdi_Adic%Rowtype
                                     ,p_Customer_Trx_Line_Id Number
                                     ,p_Customer_Trx_Id      Number
                                     ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnf_Export_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                                  ,p_Customer_Trx_Line_Id Number
                                  ,p_Customer_Trx_Id      Number
                                  ,p_Rotina               Varchar2);

  --
  Procedure Vw_Csf_Itemnfe_Compl_Serv_p(p_Rvcinf            Vw_Csf_Item_Nota_Fiscal%Rowtype
                                       ,p_Inventory_Item_Id Number
                                       ,p_Warehouse_Id      Number
                                       ,p_Rotina            Varchar2);

  --
  Procedure Vw_Csf_Nf_Forma_Pgto_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                  ,p_Customer_Trx_Id Number
                                  ,p_Rotina          Varchar2);

  --
  Procedure Atualiza_Jl_Br_p(p_Customer_Trx_Id Number);

  --
  Function Get_Nfe_Warehouse_Id_f(p_Customer_Trx_Id In Number) Return Number;

  --
  Function Get_Nfe_Cpf_Cnpj_Emit_f(p_Location_Id          Number
                                  ,p_Legal_Entity_Id      Number
                                  ,p_Legislative_Category Varchar2)
    Return Varchar2;

  --
  Function Get_Nfe_Cod_Part_f(p_Site_Use_Id In Number) Return Varchar2;

  --
  Function Get_Nfe_Cidade_Ibge_Emit_f(p_Organization_Id In Number)
    Return Varchar2;

  --
  Function Get_Nfe_Uf_Ibge_Emit_f(p_Organization_Id In Number) Return Varchar2;

  --
  Function Get_Nfe_Cod_Pais_Ibge_f(p_Country In Varchar2) Return Varchar2;

  --
  Function Get_Nfe_Nome_Pais_f(p_Country In Varchar2) Return Varchar2;

  --
  Function Get_Nfe_Cidade_Ibge_Dest_f(p_City  In Varchar2
                                     ,p_State In Varchar2) Return Varchar2;

  --
  Function Get_Nfe_Msg_Legal(p_Customer_Trx_Id In Number) Return Varchar2;

  --
  Procedure Get_Nfe_Nfinfor_Adic_p(p_Customer_Trx_Id          In Number
                                  ,p_Comments                 In Varchar2
                                  ,p_Legal_Process_Source_Ind In Varchar2
                                  ,p_Conteudo                 Out Varchar2);

  --
  Function Get_Nfe_Site_Use_Id_f(p_Cod_Part In Varchar2) Return Number;

  --
  Function Get_Nfe_Converte_Char_f(p_Text In Varchar2) Return Varchar2;

  --
  Function Get_Nfe_Cod_Cta_f(p_Customer_Trx_Line_Id In Number
                            ,p_Org_Id               In Number) Return Varchar2;

  --
  Function Get_Nfe_Dm_Cod_Trib_Issqn_f(p_Customer_Trx_Id      In Number
                                      ,p_Customer_Trx_Line_Id In Number)
    Return Number;

  --
  Function Get_Nfe_Dm_Mod_Base_Calc_St_f(p_Customer_Trx_Id      In Number
                                        ,p_Customer_Trx_Line_Id In Number)
    Return Number;

  --
  Function Get_Nfe_Vl_Total_Nf_f(p_Customer_Trx_Id In Number) Return Number;

  --
  Function Get_Nfe_Pedido_Compra_f(p_Interface_Line_Attribute6 Number
                                  ,p_Org_Id                    Number)
    Return Varchar2;

  --
  Function Get_Nfe_Item_Pedido_Compra_f(p_Interface_Line_Attribute6 Number
                                       ,p_Org_Id                    Number)
    Return Varchar2;

  --
  Function Get_Nfe_Dm_Mot_Des_Icms_f(p_Customer_Trx_Id      In Number
                                    ,p_Customer_Trx_Line_Id In Number)
    Return Number;

  --
  Function Get_Nfe_Cod_Ocor_Aj_Icms_f(p_Customer_Trx_Line_Id In Number)
    Return Varchar2;

  --
  Function Get_Nfe_Dt_Ini_Integr_f Return Date;

  --
  Function Get_Nfe_Ncm_f(p_Customer_Trx_Id      In Number
                        ,p_Customer_Trx_Line_Id In Number) Return Varchar2;

  --
  Function Get_Nfe_Total_Bc_Iss_f(p_Customer_Trx_Id In Number) Return Number;

  --
  Function Get_Nfe_Total_Vl_Iss_f(p_Customer_Trx_Id In Number) Return Number;

  --
  Function Get_Nfe_Vl_Total_Serv_f(p_Customer_Trx_Id In Number) Return Number;

  --
  Function Get_Nfe_Total_Bc_Icms_f(p_Customer_Trx_Id In Number) Return Number;

  --
  Function Get_Nfe_Version_f Return Varchar2;

  --
  Function Get_Nfe_Razao_Social_f(p_Cnpj_Emit In Varchar2) Return Varchar2;

  --
  Function Get_Nfe_Descr_Item_f(p_Customer_Trx_Line_Id In Number)
    Return Varchar2;

  --
  Function Get_Nfe_Cbenef_f(p_Uf             In Varchar2
                           ,p_Tipo_Transacao In Varchar2
                           ,p_Cfop           In Varchar2
                           ,p_Cst            In Varchar2
                           ,p_Ncm            In Varchar2) Return Varchar2;

  --
  Procedure Odi_Nfe_p;

  --
  Procedure Sic_Nfe_p(En_Agendintegrsic_Id   Number Default Null
                     ,Ed_Dt_Ini              Date
                     ,Ed_Dt_Fin              Date
                     ,Ev_Objintegrsic_Cd     Varchar2 Default Null
                     ,Ev_Tipoobjintegrsic_Cd Varchar2 Default Null);

  --
  Procedure Sic_Nfe_Online_p(Ev_Objintegrsic_Cd     Varchar2 Default Null
                            ,Ev_Tipoobjintegrsic_Cd Varchar2 Default Null);

  --
  Procedure Get_Account_Segment_p;

--
End Xxisv_Csf_Nfe_Pkg;
/
CREATE OR REPLACE Package Body Xxisv_Csf_Nfe_Pkg As

  --
  -- +=================================================================+
  -- |     COPYRIGHT (C) 2017 ALC Soluções em TI e Processos LTDA.     |
  -- |            SÃO PAULO, BRASIL, ALL RIGHTS RESERVED.              |
  -- |                   PHONE: (11) 98119-4405                        |
  -- +=================================================================+
  -- | NOME OBJETO.........: XXISV.Xxisv_Csf_NFE_Pkg                   |
  -- | NOME FISICO.........: XXISV.Xxisv_Csf_NFE_Pkg.pck               |
  -- | LAYOUT..............: NFE                                       |
  -- | TIPO_OBJETO.........: PACKAGE_BODY                              |
  -- | VERSÃO..............: EBS R12.1.3                               |
  -- | REFERENCIA..........: AR                                        |
  -- | VIEW CLL  ..........:                                           |
  -- | AUTOR...............: ANDRE LUIZ CARRANZA                       |
  -- | E-MAIL..............: andre.carranza@alcconsulting.com.br       |
  -- | TELEFONE............: (11) 98119-4405                           |
  -- | DATA................: 01/01/2017                                |
  -- |                                                                 |
  -- *******************************************************************
  -- *                    A L T E R A Ç Õ E S                          *
  -- *******************************************************************
  -- *                                                                 *
  -- *                                                                 *
  -- *                                                                 *
  -- *******************************************************************
  -- *                  C U S T O M I Z A Ç Õ E S                      *
  -- *******************************************************************
  -- *                                                                 *
  -- *                                                                 *
  -- *                                                                 *
  -- *******************************************************************
  --
  Procedure Main_p(Errbuf            Out Varchar2
                  ,Retcode           Out Number
                  ,p_Org_Id          In Ra_Customer_Trx_All.Org_Id%Type
                  ,p_Mod_Fiscal      In Fnd_Lookup_Values.Lookup_Code%Type
                  ,p_Status_Nfe      In Fnd_Lookup_Values.Lookup_Code%Type Default Null
                  ,p_Batch_Source_Id In Ar.Ra_Batch_Sources_All.Batch_Source_Id%Type
                  ,p_Trx_Num_Ini     In Ra_Customer_Trx_All.Trx_Number%Type
                  ,p_Trx_Num_Fim     In Ra_Customer_Trx_All.Trx_Number%Type
                  ,p_Data_Ini        In Varchar2
                  ,p_Data_Fim        In Varchar2) Is
    ---
    Cursor C0 Is
      Select /*+ FULL RCT */
       Rct.Customer_Trx_Id Customer_Trx_Id
      ,Rct.Trx_Number
      ,Rct.Trx_Date
      ,Rct.Org_Id
        From Ra_Customer_Trx_All     Rct
            ,Ra_Cust_Trx_Types_All   Rctt
            ,Ar.Ra_Batch_Sources_All Rbs
            ,Jl_Br_Customer_Trx_Exts Jbct
       Where 1 = 1
         And Rct.Org_Id = p_Org_Id
         And Rct.Batch_Source_Id =
             Nvl(p_Batch_Source_Id, Rct.Batch_Source_Id)
            ---
         And ((p_Trx_Num_Ini Is Not Null And p_Trx_Num_Fim Is Not Null And
             p_Data_Ini Is Not Null And p_Data_Fim Is Not Null And
             To_Number(Regexp_Replace(Rct.Trx_Number, '[^0-9]+', '')) Between
             p_Trx_Num_Ini And p_Trx_Num_Fim And
             Rct.Trx_Date Between Fnd_Date.Canonical_To_Date(p_Data_Ini) And
             Fnd_Date.Canonical_To_Date(p_Data_Fim)) Or
             (p_Trx_Num_Ini Is Not Null And p_Trx_Num_Fim Is Not Null And
             p_Data_Ini Is Null And p_Data_Fim Is Null And To_Number(Regexp_Replace(Rct.Trx_Number, '[^0-9]+', '')) Between
             p_Trx_Num_Ini And p_Trx_Num_Fim) Or
             (p_Trx_Num_Ini Is Null And p_Trx_Num_Fim Is Null And
             p_Data_Ini Is Not Null And p_Data_Fim Is Not Null And
             Rct.Trx_Date Between Fnd_Date.Canonical_To_Date(p_Data_Ini) And
             Fnd_Date.Canonical_To_Date(p_Data_Fim)) Or
             (p_Trx_Num_Ini Is Null And p_Trx_Num_Fim Is Null And
             p_Data_Ini Is Null And p_Data_Fim Is Null And 1 = 1))
            ---
         And Rct.Status_Trx <> 'VD'
         And Rct.Complete_Flag = 'Y'
         And Rct.Trx_Date >=
             Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Dt_Ini_Integr_f, Rct.Trx_Date) -- Carranza 16/03/2023
         And Rctt.Cust_Trx_Type_Id = Rct.Cust_Trx_Type_Id
         And Rctt.Org_Id = Rct.Org_Id
         And Rctt.Type = 'INV'
         And Nvl(Rctt.End_Date, Sysdate) >= Sysdate
         And Rbs.Batch_Source_Id = Rct.Batch_Source_Id
         And Rbs.Org_Id = Rct.Org_Id
         And Rbs.Global_Attribute6 = p_Mod_Fiscal
         And Rbs.Global_Attribute5 = 'Y'
         And Rbs.Status = 'A'
         And Nvl(Rbs.End_Date, Sysdate) >= Sysdate
         And Jbct.Customer_Trx_Id(+) = Rct.Customer_Trx_Id
         And Nvl(Jbct.Electronic_Inv_Status, '0') Not In
             ('4', '9', '7', '2', '8', '6') /*0 =  Aguardando Envio / 4  = Cancelado / 9 = Denegado / 7  = Emissão de Contingência / 1 = Enviado / 3 = Erro / 2  = Finalizado / 8  = Inutilizado / 6 = Obsoleto / 5  = Rejeitado pela SEFAZ*/
         And Nvl(Jbct.Electronic_Inv_Status, '0') = p_Status_Nfe;
    R0            C0%Rowtype;
    l_Nrequest_Id Number;
    l_Berror      Boolean;
    l_Vphase      Varchar2(2000);
    l_Vstatus     Varchar2(2000);
    l_Vdev_Phase  Varchar2(2000);
    l_Vdev_Status Varchar2(2000);
    l_Vmessage    Varchar2(2000);
  Begin
    ----------------------------------------------
    --- chama rotina de retorno / cancelamento ---
    ----------------------------------------------
    --
    Xxisv_Csf_Nfe_Pkg.Vw_Csf_Resp_Nf_Erp_p;
    --
    Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Canc_p;
    --
    Xxisv_Csf_Nfe_Pkg.Get_Account_Segment_p;
    --
    Xxisv_Csf_Nfe_Pkg.Atualiza_Vw_Csf_Resp_Nf_Erp_p;
    --
    Open C0;
    Loop
      Fetch C0
        Into R0;
      Exit When C0%Notfound;
      -----------------------------
      --- chama rotina de envio ---
      -----------------------------
      Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_p(p_Customer_Trx_Id => R0.Customer_Trx_Id, p_Rotina => 'Xxisv_Csf_NFe_Pkg.Main');
      --
    End Loop;
    Close C0;
    --
    Retcode := g_Retcode;
    --
  End Main_p;

  Procedure Main_Resp_Canc_p(Errbuf  Out Varchar2
                            ,Retcode Out Number) Is
  Begin
    --
    Xxisv_Csf_Nfe_Pkg.Vw_Csf_Resp_Nf_Erp_p;
    --
    Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Canc_p;
    --
    Retcode := g_Retcode;
    --
  End Main_Resp_Canc_p;

  --------------------------------------------------------------------
  --- Procedure utilizada para atualizar o status da NFe (retorno) ---
  --------------------------------------------------------------------
  Procedure Vw_Csf_Resp_Nf_Erp_p Is
    Cursor Cc Is
      Select Vcrnef.Valor Customer_Trx_Id
            ,Vcrne.Rowid  Row_Id
            ,Vcrne.*
        From Vw_Csf_Resp_Nf_Erp    Vcrne
            ,Vw_Csf_Resp_Nf_Erp_Ff Vcrnef
       Where Vcrne.Dm_Leitura = 0
         And Vcrne.Dm_Ind_Emit = 0
         And Vcrne.Sist_Orig = 'EBS_AR'
         And Vcrnef.Cpf_Cnpj_Emit = Vcrne.Cpf_Cnpj_Emit
         And Vcrnef.Dm_Ind_Emit = Vcrne.Dm_Ind_Emit
         And Vcrnef.Dm_Ind_Oper = Vcrne.Dm_Ind_Oper
         And Vcrnef.Cod_Mod = Vcrne.Cod_Mod
         And Vcrnef.Serie = Vcrne.Serie
         And Vcrnef.Nro_Nf = Vcrne.Nro_Nf
         And Vcrnef.Atributo = 'ID_ERP';
    ---
    Rr Cc%Rowtype;
    --
    l_Desc_Erro             Varchar2(4000);
    v_Status                Varchar2(2000);
    v_Message_Text          Varchar2(2000);
    v_Inv_Access_Key        Varchar2(2000);
    v_Inv_Protocol          Varchar2(2000);
    x_Return_Status         Varchar2(2000);
    x_Msg_Data              Varchar2(2000);
    v_Ds_Status             Varchar2(2000);
    v_Dt_Autoriza           Date;
    v_Hr_Autoriza           Varchar2(10);
    v_Dt_Hr_Aut             Varchar2(20);
    v_Dt_Cancela            Date;
    v_Prt_Cancela           Varchar2(2000);
    l_Electronic_Inv_Status Jl_Br_Customer_Trx_Exts.Electronic_Inv_Status%Type;
    --
  Begin
    Open Cc;
    Loop
      Fetch Cc
        Into Rr;
      Exit When Cc%Notfound;
      ---
      -- Check Status
      If Rr.Dm_St_Proc In ('0', '1', '2', '3')
      Then
        v_Status := '1';
        If Rr.Dm_St_Proc = '0'
        Then
          v_Message_Text := '0 - Nao validada';
        Elsif Rr.Dm_St_Proc = '1'
        Then
          v_Message_Text := '1 - Nao Processada. Aguardando Processamento';
        Elsif Rr.Dm_St_Proc = '2'
        Then
          v_Message_Text := '2 - Nota Processada. NF Validada e XML Gerado. Aguardando Envio';
        Elsif Rr.Dm_St_Proc = '3'
        Then
          v_Message_Text := '3 - Nota Enviada ao SEFAZ. Aguardando Retorno';
        End If;
      Elsif Rr.Dm_St_Proc In ('4')
      Then
        v_Status       := '2';
        v_Message_Text := '4 - Nota Autorizada';
      Elsif Rr.Dm_St_Proc = '5'
      Then
        v_Status       := '5';
        v_Message_Text := '5 - Nota Rejeitada';
      Elsif Rr.Dm_St_Proc = '6'
      Then
        v_Status       := '9';
        v_Message_Text := '6 - Nota Denegada';
      Elsif Rr.Dm_St_Proc In ('7')
      Then
        v_Status       := '4';
        v_Message_Text := '7 - Nota Cancelada';
      Elsif Rr.Dm_St_Proc In ('8')
      Then
        v_Status       := '8';
        v_Message_Text := '8 - Nota Inutilizada';
      Elsif Rr.Dm_St_Proc In ('10', '11', '12', '13', '15', '16', '99')
      Then
        v_Status := '3';
        If Rr.Dm_St_Proc = '10'
        Then
          v_Message_Text := '10 - Erro na Validacao da Nota';
        Elsif Rr.Dm_St_Proc = '11'
        Then
          v_Message_Text := '11 - Erro na Montagem do XML';
        Elsif Rr.Dm_St_Proc = '12'
        Then
          v_Message_Text := '12 - Erro ao enviar a Nota ao Sefaz';
        Elsif Rr.Dm_St_Proc = '13'
        Then
          v_Message_Text := '13 - Erro ao obter o retorno do envio da Nota ao Sefaz';
        Elsif Rr.Dm_St_Proc = '15'
        Then
          v_Message_Text := '15 - Erro ao enviar a Solicitacao de Cancelamento ao Sefaz';
        Elsif Rr.Dm_St_Proc = '16'
        Then
          v_Message_Text := '16 - Erro ao enviar a Solicitacao de Inutilizacao ao Sefaz';
        Elsif Rr.Dm_St_Proc = '99'
        Then
          v_Message_Text := '99 - Erro Geral de Sistema';
        End If;
      Elsif Rr.Dm_St_Proc In ('14')
      Then
        v_Status       := '1';
        v_Message_Text := '14 - Autorizada em Contingencia';
      End If;
      -- Check Chave de Acesso
      If Rr.Nro_Chave_Nfe Is Null
      Then
        v_Inv_Access_Key := Null;
      Else
        v_Inv_Access_Key := Rr.Nro_Chave_Nfe;
      End If;
      -- Check Protocolo de validacao
      If Rr.Nro_Protocolo Is Null
      Then
        v_Inv_Protocol := Null;
      Else
        v_Inv_Protocol := Rr.Nro_Protocolo;
      End If;
      -- Check Data de Autorizacao
      If Rr.Dt_Aut_Sefaz Is Null
      Then
        v_Dt_Autoriza := Null;
      Else
        v_Dt_Autoriza := Rr.Dt_Aut_Sefaz;
      End If;
      -- Check Hora de Autorizacao
      If Rr.Hr_Aut_Nfe Is Null
      Then
        v_Hr_Autoriza := Null;
      Else
        v_Hr_Autoriza := Rr.Hr_Aut_Nfe;
      End If;
      -- Data/Hora de Autorizacao
      If v_Dt_Autoriza Is Not Null
         And v_Hr_Autoriza Is Not Null
      Then
        v_Dt_Hr_Aut := To_Char(Trunc(v_Dt_Autoriza), 'DD/MM/YYYY') || ' ' ||
                       v_Hr_Autoriza;
      Elsif v_Dt_Autoriza Is Not Null
            And v_Hr_Autoriza Is Null
      Then
        v_Dt_Hr_Aut := To_Char(Trunc(v_Dt_Autoriza), 'DD/MM/YYYY');
      Else
        v_Dt_Hr_Aut := Null;
      End If;
      -- Check Data de Cancelamento
      If Rr.Dt_Canc Is Null
      Then
        v_Dt_Cancela := Null;
      Else
        v_Dt_Cancela := Rr.Dt_Canc;
      End If;
      -- Check Protocolo de Cancelamento
      If Rr.Nro_Protocolo_Canc Is Null
      Then
        v_Prt_Cancela := Null;
      Else
        v_Prt_Cancela := Rr.Nro_Protocolo_Canc;
      End If;
      ------------------------------------------------------------------------------------------------------------------------
      -- Atualiza atributos da NFe no Oracle                                                                                --
      -- Atualiza tabela JL_BR_CUSTOMER_TRX_EXTS                                                                            --
      ------------------------------------------------------------------------------------------------------------------------
      Jl_Br_Sped_Pub.Update_Attributes(p_Api_Version => 1.0, p_Commit => Apps.Fnd_Api.g_True, p_Customer_Trx_Id => Rr.Customer_Trx_Id, p_Elect_Inv_Web_Address => 'http://www.nfe.fazenda.gov.br/portal/principal.aspx', p_Elect_Inv_Status => v_Status, p_Elect_Inv_Access_Key => v_Inv_Access_Key, p_Elect_Inv_Protocol => v_Inv_Protocol, x_Return_Status => x_Return_Status, x_Msg_Data => x_Msg_Data);
      If Nvl(x_Return_Status, 'U') <> 'S'
      Then
        --
        Begin
          Select Electronic_Inv_Status
            Into l_Electronic_Inv_Status
            From Jl_Br_Customer_Trx_Exts
           Where Customer_Trx_Id = Rr.Customer_Trx_Id;
        Exception
          When Others Then
            l_Electronic_Inv_Status := '#';
        End;
        --
        If l_Electronic_Inv_Status = '2'
        Then
          --
          ------------------------------------------------------------------------------------------------------------------------
          -- Atualiza DM_LEITURA da tabela de resposta da Integração da Nota Fiscal ¿ Oracle                                    --
          -- Atualiza tabela VW_CSF_RESP_NF_ERP                                                                                 --
          ------------------------------------------------------------------------------------------------------------------------
          Begin
            Update Vw_Csf_Resp_Nf_Erp Vcrne
               Set Vcrne.Dm_Leitura = 1
             Where Vcrne.Cpf_Cnpj_Emit = Rr.Cpf_Cnpj_Emit
               And Vcrne.Dm_Ind_Emit = Rr.Dm_Ind_Emit
               And Vcrne.Dm_Ind_Oper = Rr.Dm_Ind_Oper
               And Vcrne.Cod_Mod = Rr.Cod_Mod
               And Vcrne.Serie = Rr.Serie
               And Vcrne.Nro_Nf = Rr.Nro_Nf
               And Vcrne.Sist_Orig = 'EBS_AR'
               And Vcrne.Dm_Leitura = 0
               And Vcrne.Rowid = Rr.Row_Id;
          Exception
            When Others Then
              --
              g_Retcode   := 1;
              l_Desc_Erro := 'VW_CSF_RESP_NF_ERP_P (01a) - ' ||
                             'Cpf_Cnpj_Emit: ' || Rr.Cpf_Cnpj_Emit ||
                             ', Dm_Ind_Emit: ' || Rr.Dm_Ind_Emit ||
                             ', Cod_Mod: ' || Rr.Cod_Mod || ', Serie: ' ||
                             Rr.Serie || ', Nro_Nf: ' || Rr.Nro_Nf ||
                             ', Erro: ' || Sqlerrm || x_Msg_Data;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
          --
        Else
          --
          g_Retcode   := 1;
          l_Desc_Erro := 'VW_CSF_RESP_NF_ERP_P (01b) - ' || 'Cpf_Cnpj_Emit: ' ||
                         Rr.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         Rr.Dm_Ind_Emit || ', Cod_Mod: ' || Rr.Cod_Mod ||
                         ', Serie: ' || Rr.Serie || ', Nro_Nf: ' || Rr.Nro_Nf ||
                         ', Erro: ' || Sqlerrm || x_Msg_Data;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        End If;
        --
      Else
        --
        ------------------------------------------------------------------------------------------------------------------------
        -- Insere Log com o Status da NFe                                                                                     --
        -- Insere linha na tabela JL_BR_EILOG                                                                                 --
        ------------------------------------------------------------------------------------------------------------------------
        Jl_Br_Sped_Pub.Insert_Log(p_Api_Version => 1.0, p_Commit => Apps.Fnd_Api.g_True, p_Customer_Trx_Id => Rr.Customer_Trx_Id, p_Occurrence_Date => Sysdate, p_Elect_Inv_Status => v_Status, p_Message_Text => v_Message_Text, x_Return_Status => x_Return_Status, x_Msg_Data => x_Msg_Data);
        --
        ------------------------------------------------------------------------------------------------------------------------
        -- Atualiza PRINTING_LAST_PRINTED e DOC_SEQUENCE_VALUE da tabela RA_CUSTOMER_TRX_ALL                                  --
        -- com a data/hora de autorização da nota no SEFAZ e o numero da Nota Fiscal Eletrônica                               --
        ------------------------------------------------------------------------------------------------------------------------
        If v_Dt_Hr_Aut Is Not Null
        Then
          If Length(v_Dt_Hr_Aut) = 10
          Then
            Begin
              Update Ra_Customer_Trx_All
                 Set Printing_Last_Printed = To_Date(v_Dt_Hr_Aut, 'DD/MM/YYYY')
               Where Customer_Trx_Id = Rr.Customer_Trx_Id
                 And Printing_Last_Printed Is Null;
            End;
          Else
            Begin
              Update Ra_Customer_Trx_All
                 Set Printing_Last_Printed = To_Date(v_Dt_Hr_Aut, 'DD/MM/YYYY HH24:MI:SS')
               Where Customer_Trx_Id = Rr.Customer_Trx_Id
                 And Printing_Last_Printed Is Null;
            End;
          End If;
        End If;
        --
        ------------------------------------------------------------------------------------------------------------------------
        -- Atualiza DM_LEITURA da tabela de resposta da Integração da Nota Fiscal ¿ Oracle                                    --
        -- Atualiza tabela VW_CSF_RESP_NF_ERP                                                                                 --
        ------------------------------------------------------------------------------------------------------------------------
        Begin
          Update Vw_Csf_Resp_Nf_Erp Vcrne
             Set Vcrne.Dm_Leitura = 1
           Where Vcrne.Cpf_Cnpj_Emit = Rr.Cpf_Cnpj_Emit
             And Vcrne.Dm_Ind_Emit = Rr.Dm_Ind_Emit
             And Vcrne.Dm_Ind_Oper = Rr.Dm_Ind_Oper
             And Vcrne.Cod_Mod = Rr.Cod_Mod
             And Vcrne.Serie = Rr.Serie
             And Vcrne.Nro_Nf = Rr.Nro_Nf
             And Vcrne.Sist_Orig = 'EBS_AR'
             And Vcrne.Dm_Leitura = 0
             And Vcrne.Rowid = Rr.Row_Id;
        Exception
          When Others Then
            --
            g_Retcode   := 1;
            l_Desc_Erro := 'VW_CSF_RESP_NF_ERP_P (02) - ' ||
                           'Cpf_Cnpj_Emit: ' || Rr.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || Rr.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || Rr.Cod_Mod || ', Serie: ' ||
                           Rr.Serie || ', Nro_Nf: ' || Rr.Nro_Nf ||
                           ', Erro: ' || Sqlerrm || x_Msg_Data;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        ---
      End If;
      ---
      ------------------------------------------------------------------------------------------------------------------------
      -- Limpa Interface notas autorizadas, canceladas, inutilizadas, denegadas e autorizadas em contingencia               --
      ------------------------------------------------------------------------------------------------------------------------
      If Rr.Dm_St_Proc In (4, 6, 7, 8, 14)
      Then
        -- 4-Autorizada, 6-Denegada, 7-Cancelada, 8-inutilizada, 14-Autorizada em Contingencia
        Begin
          Xxisv_Csf_Nfe_Pkg.Pb_Limpa_Interface_p(p_Sist_Orig => Rr.Sist_Orig, p_Cnpj_Cpf_Emit => Rr.Cpf_Cnpj_Emit, p_Nro_Nf => Rr.Nro_Nf, p_Serie => Rr.Serie);
        End;
      End If;
      ---
    End Loop;
    Close Cc;
    --
  End Vw_Csf_Resp_Nf_Erp_p;

  --
  Procedure Vw_Csf_Nota_Fiscal_Canc_p Is
    Cursor c_Can Is
      Select Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cpf_Cnpj_Emit_f(Hou.Location_Id, Rct.Legal_Entity_Id, 'FEDERAL_TAX') Cpf_Cnpj_Emit
            ,0 Dm_Ind_Emit
            ,Case
               When Rctt.Global_Attribute2 = 'ENTRY' Then
                0
               When Rctt.Global_Attribute2 = 'EXIT' Then
                1
             End Dm_Ind_Oper
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Part_f(Rct.Bill_To_Site_Use_Id) Cod_Part
            ,Substr(To_Char(Rbs.Global_Attribute6), 1, 2) Cod_Mod
            ,Substr(To_Char(Rbs.Global_Attribute3), 1, 3) Serie
            ,Substr(To_Number(Rct.Trx_Number), 1, 9) Nro_Nf
            ,Rct_Can.Trx_Date Dt_Canc
            ,Case
               When Rct_Can.Reason_Code Is Not Null
                    And Rct_Can.Comments Is Not Null Then
                Substr((Select Al.Description
                          From Ar_Lookups Al
                         Where Al.Lookup_Code = Rct_Can.Reason_Code
                           And Al.Lookup_Type = 'CREDIT_MEMO_REASON') || ' ' ||
                       Rct_Can.Comments, 1, 240)
               When Rct_Can.Reason_Code Is Not Null
                    And Rct_Can.Comments Is Null Then
                Substr((Select Al.Description
                         From Ar_Lookups Al
                        Where Al.Lookup_Code = Rct_Can.Reason_Code
                          And Al.Lookup_Type = 'CREDIT_MEMO_REASON'), 1, 240)
               When Rct_Can.Reason_Code Is Null
                    And Rct_Can.Comments Is Null Then
                'NOTA CANCELADA POR MOTIVOS OPERACIONAIS'
               When Rct_Can.Reason_Code Is Null
                    And Rct_Can.Comments Is Not Null Then
                Substr(Rct_Can.Comments, 1, 240)
             End Justif
            ,Rct_Can.Customer_Trx_Id Customer_Trx_Id_Canc
            ,Rct_Can.Previous_Customer_Trx_Id Customer_Trx_Id_Nfe
        From Ra_Customer_Trx_All       Rct_Can
            ,Ra_Customer_Trx_All       Rct
            ,Ra_Cust_Trx_Types_All     Rctt
            ,Ar.Ra_Batch_Sources_All   Rbs
            ,Jl_Br_Customer_Trx_Exts   Jbct
            ,Hr_All_Organization_Units Hou
       Where 1 = 1
         And Rct_Can.Status_Trx = 'VD'
         And Rct_Can.Complete_Flag = 'Y'
         And Rct.Trx_Date >=
             Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Dt_Ini_Integr_f, Rct.Trx_Date) -- Carranza 16/03/2023
         And Rct.Customer_Trx_Id = Rct_Can.Previous_Customer_Trx_Id
         And Rctt.Cust_Trx_Type_Id = Rct.Cust_Trx_Type_Id
         And Rctt.Org_Id = Rct.Org_Id
         And Rctt.Type = 'INV'
         And Hou.Organization_Id =
             Xxisv_Csf_Nfe_Pkg.Get_Nfe_Warehouse_Id_f(Rct.Customer_Trx_Id)
         And Rbs.Batch_Source_Id = Rct.Batch_Source_Id
         And Rbs.Org_Id = Rct.Org_Id
         And Rbs.Global_Attribute5 = 'Y'
         And Rbs.Global_Attribute6 = '55'
         And Rbs.Global_Attribute3 Is Not Null
         And Rbs.Status = 'A'
         And Jbct.Customer_Trx_Id(+) = Rct.Customer_Trx_Id
         And Jbct.Electronic_Inv_Status Not In ('4', '6', '8', '9');
    r_Can       c_Can%Rowtype;
    l_Desc_Erro Varchar2(4000);
  Begin
    --
    Begin
      Delete Vw_Csf_Nota_Fiscal_Canc;
    End;
    --
    Open c_Can;
    Loop
      Fetch c_Can
        Into r_Can;
      Exit When c_Can%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Canc
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Dt_Canc
          ,Justif)
        Values
          (r_Can.Cpf_Cnpj_Emit
          ,r_Can.Dm_Ind_Emit
          ,r_Can.Dm_Ind_Oper
          ,r_Can.Cod_Part
          ,r_Can.Cod_Mod
          ,r_Can.Serie
          ,r_Can.Nro_Nf
          ,r_Can.Dt_Canc
          ,r_Can.Justif);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_CANC_P (01) - ' ||
                         'Cpf_Cnpj_Emit: ' || r_Can.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || r_Can.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || r_Can.Cod_Mod || ', Serie: ' ||
                         r_Can.Serie || ', Nro_Nf: ' || r_Can.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      ---
    End Loop;
    Close c_Can;
  End Vw_Csf_Nota_Fiscal_Canc_p;

  ---
  -------------------------------------------------------------
  --- Procedure de contingencia em falhas da API de retorno ---
  -------------------------------------------------------------
  Procedure Atualiza_Vw_Csf_Resp_Nf_Erp_p Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C6 Is
      Select Vcnfc.Id_Erp               Customer_Trx_Id_Csf
            ,Jbct.Customer_Trx_Id       Customer_Trx_Id_Ebs
            ,Vcrne.Dm_St_Proc           Status_Csf
            ,Jbct.Electronic_Inv_Status Status_Ebs
            ,Vcrne.Dt_Emiss             Dt_Emiss_Csf
            ,Rcta.Trx_Date              Dt_Emiss_Ebs
            ,Vcrne.*
        From Vw_Csf_Resp_Nf_Erp       Vcrne
            ,Vw_Csf_Nota_Fiscal_Compl Vcnfc
            ,Jl_Br_Customer_Trx_Exts  Jbct
            ,Ra_Customer_Trx_All      Rcta
       Where 1 = 1
         And Vcrne.Dm_Leitura = 1
         And Vcrne.Dm_Ind_Emit = 0
         And Vcrne.Sist_Orig = 'EBS_AR'
         And Vcnfc.Cpf_Cnpj_Emit = Vcrne.Cpf_Cnpj_Emit
         And Vcnfc.Dm_Ind_Emit = Vcrne.Dm_Ind_Emit
         And Vcnfc.Dm_Ind_Oper = Vcrne.Dm_Ind_Oper
         And Vcnfc.Cod_Mod = Vcrne.Cod_Mod
         And Vcnfc.Serie = Vcrne.Serie
         And Vcnfc.Nro_Nf = Vcrne.Nro_Nf
         And Vcnfc.Id_Erp = Jbct.Customer_Trx_Id
         And Jbct.Customer_Trx_Id = Rcta.Customer_Trx_Id
         And Vcrne.Dm_St_Proc = 4
         And Decode(Vcrne.Dm_St_Proc, '4', '2') <> Jbct.Electronic_Inv_Status;
    R6 C6%Rowtype;
    --
  Begin
    Open C6;
    Loop
      Fetch C6
        Into R6;
      Exit When C6%Notfound;
      --
      Begin
        Update Vw_Csf_Resp_Nf_Erp Vcrne
           Set Vcrne.Dm_Leitura = 0
         Where Vcrne.Cpf_Cnpj_Emit = R6.Cpf_Cnpj_Emit
           And Vcrne.Dm_Ind_Emit = R6.Dm_Ind_Emit
           And Vcrne.Dm_Ind_Oper = R6.Dm_Ind_Oper
           And Vcrne.Cod_Mod = R6.Cod_Mod
           And Vcrne.Serie = R6.Serie
           And Vcrne.Nro_Nf = R6.Nro_Nf
           And Vcrne.Sist_Orig = 'EBS_AR'
           And Vcrne.Dm_Leitura = 1;
        --
      Exception
        When Others Then
          --
          g_Retcode   := 1;
          l_Desc_Erro := 'VW_CSF_RESP_NF_ERP_P (03) - ' || 'Cpf_Cnpj_Emit: ' ||
                         R6.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         R6.Dm_Ind_Emit || ', Cod_Mod: ' || R6.Cod_Mod ||
                         ', Serie: ' || R6.Serie || ', Nro_Nf: ' || R6.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close C6;
    --
    Commit;
    --
  End Atualiza_Vw_Csf_Resp_Nf_Erp_p;

  ---
  ------------------------------------------------
  --- Procedure de Limpeza da Interface VW_CSF ---
  ------------------------------------------------
  Procedure Pb_Limpa_Interface_p(p_Sist_Orig     Varchar2 Default Null
                                ,p_Cnpj_Cpf_Emit Varchar2 Default Null
                                ,p_Nro_Nf        Varchar2 Default Null
                                ,p_Serie         Varchar2 Default Null) Is
    Cursor c_Vw_Csf_Nf Is
      Select *
        From Vw_Csf_Nota_Fiscal
       Where (Trim(p_Sist_Orig) Is Null Or Sist_Orig = p_Sist_Orig)
         And Cpf_Cnpj_Emit = p_Cnpj_Cpf_Emit
         And Nro_Nf = p_Nro_Nf
         And Serie = p_Serie;
  Begin
    For i In c_Vw_Csf_Nf
    Loop
      --
      Delete Vw_Csf_Nf_Forma_Pgto
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nf_Obs_Agend_Transp
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nf_Agend_Transp
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nfinfor_Fiscal
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Inf_Nf_Romaneio
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nf_Aquis_Cana_Ded
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nf_Aquis_Cana_Dia
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nf_Aquis_Cana
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnfdi_Adic
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Dec_Impor
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Export
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Arma
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Rastreab
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Med_Ff
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Med
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Veic
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Comb
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Imp_Itemnf_Ff
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Imp_Itemnf_Icms_Dest_Ff
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Imp_Itemnf_Icms_Dest
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Imp_Itemnf
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnf_Compl
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Item_Nota_Fiscal_Ff
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Item_Nota_Fiscal
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nftranspvol_Lacre
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nftransp_Vol
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nftransp_Veic
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Transp
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Local
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nf_Cobr_Dup
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Cobr
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nfinfor_Adic
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Cfe_Ref
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Cupom_Fiscal_Ref
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Referen_Ff
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Referen
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Total_Ff
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Total
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nfdest_Email
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nfdest_Email
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Dest
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Emit
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Compl
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Itemnfe_Compl_Serv
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Ff
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal_Dest_Ff
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
      Delete Vw_Csf_Nota_Fiscal
       Where Cpf_Cnpj_Emit = i.Cpf_Cnpj_Emit
         And Nro_Nf = i.Nro_Nf
         And Serie = i.Serie;
      Commit;
      --
    End Loop;
  Exception
    When Others Then
      Raise_Application_Error(-20001, 'Erro ao apagar interface do Xxisv_Csf_Nfe_Pkg.Pb_Limpa_Interface_p');
      --
      Fnd_File.Put_Line(Fnd_File.Log, Sqlerrm);
      --
  End Pb_Limpa_Interface_p;

  ---
  -------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal ---
  -------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_p(p_Customer_Trx_Id Number
                                ,p_Rotina          Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cpf_Cnpj_Emit_f(Hou.Location_Id, Rcta.Legal_Entity_Id, 'FEDERAL_TAX') Cpf_Cnpj_Emit
            ,0 Dm_Ind_Emit
            ,Case
               When Cfai.Movement_In_Out = 'ENTRY' Then
                0
               When Cfai.Movement_In_Out = 'EXIT' Then
                1
             End Dm_Ind_Oper
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Part_f(Cfai.Bill_To_Site_Use_Id) Cod_Part
            ,Substr(To_Char(Cfai.Rbs_Global_Attribute6), 1, 2) Cod_Mod
            ,Substr(To_Char(Cfai.Series), 1, 3) Serie
            ,Substr(To_Number(Cfai.Trx_Number), 1, 9) Nro_Nf
            ,'00' Sit_Docto
            ,Substr(Cfai.Nature_Operation_Code, 1, 10) Cod_Nat_Oper
             /*,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfai.Description), 1, 60) Descr_Nat_Oper*/ -- Carranza 26/10/2022 (Alterado a pedido da Leticia Galera)
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfai.Nature_Operation_Code), 1, 60) Descr_Nat_Oper -- Carranza 26/10/2022 (Alterado a pedido da Leticia Galera)
             /*,Case
               When Cfai.Term_Due_Date > Cfai.Trx_Date Then
                1
               When Cfai.Term_Due_Date <= Cfai.Trx_Date Then
                0
               When Cfai.Term_Due_Date Is Null Then
                2
             End Dm_Ind_Pag*/ -- Carranza 24/09/2025
            ,Case
               When (Select Due_Date
                       From Apps.Ar_Payment_Schedules_All
                      Where Customer_Trx_Id = Cfai.Customer_Trx_Id
                        And Terms_Sequence_Number = 1) > Cfai.Trx_Date Then
                1
               When (Select Due_Date
                       From Apps.Ar_Payment_Schedules_All
                      Where Customer_Trx_Id = Cfai.Customer_Trx_Id
                        And Terms_Sequence_Number = 1) <= Cfai.Trx_Date Then
                0
               When (Select Due_Date
                       From Apps.Ar_Payment_Schedules_All
                      Where Customer_Trx_Id = Cfai.Customer_Trx_Id
                        And Terms_Sequence_Number = 1) Is Null Then
                9
             End Dm_Ind_Pag
            ,Trunc(Nvl(Rcta.Ship_Date_Actual, Sysdate)) Dt_Sai_Ent
            ,Null Hora_Sai_Ent
            ,To_Date(Cfai.Trx_Date, 'dd/mm/rrrr') Dt_Emiss
            ,Case
               When Rcta.Attribute_Category = 'CSF - NF-e de Exportação' Then
                Substr(Rcta.Attribute3, 1, 2)
               Else
                Null
             End Uf_Embarq /*Apenas para notas de Exportação (Subir Flexfield core CSF)*/
            ,Case
               When Rcta.Attribute_Category = 'CSF - NF-e de Exportação' Then
                Substr(Rcta.Attribute4, 1, 60)
               Else
                Null
             End Local_Embarq /*Apenas para notas de Exportação (Subir Flexfield core CSF)*/
            ,Null Nf_Empenho
            ,Cfai.Purchase_Order Pedido_Compra
            ,Cfai.Purchase_Order_Revision Contrato_Compra
            ,-1 Dm_St_Proc
             --,To_Number(Cfai.Type_Global_Attribute5) Dm_Fin_Nfe -- Carranza 28/04/2026
            ,To_Number(Substr(Cfai.Type_Global_Attribute5, 1, 1)) Dm_Fin_Nfe -- Carranza 28/04/2026
            ,0 Dm_Proc_Emiss
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cidade_Ibge_Emit_f(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Warehouse_Id_f(Rcta.Customer_Trx_Id)) Cidade_Ibge_Emit
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Uf_Ibge_Emit_f(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Warehouse_Id_f(Rcta.Customer_Trx_Id)) Uf_Ibge_Emit
            ,Lower(Substr(Fu.User_Name, 1, 30)) Usuario
            ,Null Vias_Danfe_Custom
            ,Null Nro_Chave_Cte_Ref
            ,'EBS_AR' Sist_Orig
            ,To_Char(Cfai.Org_Id) Unid_Org
            ,Hcas.Global_Attribute13 Dm_Ind_Final
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cidade_Ibge_Dest_f(Loc.City, Loc.State), 1, 2) Uf_Ibge_Dest
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Warehouse_Id_f(Rcta.Customer_Trx_Id) Warehouse_Id
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cpf_Cnpj_Emit_f(Hou.Location_Id, Rcta.Legal_Entity_Id, 'INCOME_TAX') Ie
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cpf_Cnpj_Emit_f(Hou.Location_Id, Rcta.Legal_Entity_Id, 'COMPANY_LAW') Im
            ,Fnd_Number.Canonical_To_Number(Nvl(Rcta.Global_Attribute9, '0')) Vl_Frete
            ,Fnd_Number.Canonical_To_Number(Nvl(Rcta.Global_Attribute10, '0')) Vl_Seguro
            ,Fnd_Number.Canonical_To_Number(Nvl(Rcta.Global_Attribute11, '0')) Vl_Outras_Despesas
            ,Rcta.Bill_To_Site_Use_Id Bill_To_Site_Use_Id
            ,Rcta.Ship_To_Site_Use_Id Ship_To_Site_Use_Id
            ,Rcta.Related_Customer_Trx_Id Customer_Trx_Id_Ref
            ,Cfai.Legal_Process_Source_Ind Legal_Process_Source_Ind
            ,Cfai.Comments Comments
            ,Rcta.Fob_Point Fob_Point
            ,Rcta.Ship_Via Ship_Via
            ,Rcta.Global_Attribute12 License_Plate --PLACA
            ,Cfai.Vehicle_Plate_State_Code Vehicle_Plate_State_Code --UF
            ,Cfai.Vehicle_Antt_Inscription Vehicle_Antt_Inscription --RNTC
            ,Cfai.Towing_Veh_Plate_Number Towing_Veh_Plate_Number --PLACA
            ,Cfai.Towing_Veh_Plate_State_Code Towing_Veh_Plate_State_Code --UF
            ,Cfai.Towing_Veh_Antt_Inscription Towing_Veh_Antt_Inscription --RNTC
            ,Cfai.Wagon_Code Wagon_Code --VAGAO
            ,Cfai.Ferry_Code Ferry_Code --BALSA
            ,Rcta.Global_Attribute15 Bulk_Number --nr_volume
            ,Rcta.Global_Attribute13
        Bulk --volume
      , Rcta.Global_Attribute14 Species_Turnover --especie_volume
      , Cfai.Seal_Number Seal_Number -- lacre
      , Fnd_Number.Canonical_To_Number(Rcta.Global_Attribute16) Weight --peso_bruto
      , Fnd_Number.Canonical_To_Number(Rcta.Global_Attribute17) Net_Weight --peso_liquido
      , Loc.State Uf_Dest, Cfai.Customer_Trx_Id Customer_Trx_Id, Cfai.Nature_Operation_Code -- Carranza 18/03/2026
        From Cll_F255_Ar_Invoices_v    Cfai
            ,Ra_Customer_Trx_All       Rcta
            ,Fnd_User                  Fu
            ,Hz_Cust_Site_Uses_All     Hcsu
            ,Hz_Cust_Acct_Sites_All    Hcas
            ,Hz_Party_Sites            Hps
            ,Hz_Locations              Loc
            ,Hr_All_Organization_Units Hou
       Where 1 = 1
         And Cfai.Customer_Trx_Id = Rcta.Customer_Trx_Id
         And Fu.User_Id = Nvl(Rcta.Last_Updated_By, Rcta.Created_By)
            /*And Cfai.Bill_To_Site_Use_Id = Hcsu.Site_Use_Id*/ -- Carranza 14/07/2020
         And Cfai.Ship_To_Site_Use_Id = Hcsu.Site_Use_Id -- Carranza 14/07/2020
         And Cfai.Org_Id = Hcsu.Org_Id
         And Hcas.Cust_Acct_Site_Id = Hcsu.Cust_Acct_Site_Id
         And Hcas.Party_Site_Id = Hps.Party_Site_Id
         And Hps.Location_Id = Loc.Location_Id
         And Hou.Organization_Id =
             Xxisv_Csf_Nfe_Pkg.Get_Nfe_Warehouse_Id_f(Rcta.Customer_Trx_Id)
         And Cfai.Rbs_Global_Attribute6 In ('55', '65')
         And Cfai.Rbs_Global_Attribute5 = 'Y'
         And Cfai.Status_Trx <> 'VD'
         And Cfai.Customer_Trx_Id = p_Customer_Trx_Id;
    R1      C1%Rowtype;
    l_Rvcnf Vw_Csf_Nota_Fiscal%Rowtype;
  Begin
    --
    g_Erro     := 0;
    g_Erro_Msg := Null;
    --
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      --
      --->> LOG
      /*fnd_file.put_line(fnd_file.log,'CPF_CNPJ_EMIT='||R1.Cpf_Cnpj_Emit||' NRO_NF='||R1.Nro_Nf||' SERIE='||R1.Serie);*/
      Fnd_File.Put_Line(Fnd_File.Output, 'CPF_CNPJ_EMIT=' || R1.Cpf_Cnpj_Emit ||
                         ' NRO_NF=' || R1.Nro_Nf || ' SERIE=' ||
                         R1.Serie);
      --
      l_Rvcnf.Cpf_Cnpj_Emit     := R1.Cpf_Cnpj_Emit;
      l_Rvcnf.Dm_Ind_Emit       := R1.Dm_Ind_Emit;
      l_Rvcnf.Dm_Ind_Oper       := R1.Dm_Ind_Oper;
      l_Rvcnf.Cod_Part          := R1.Cod_Part;
      l_Rvcnf.Cod_Mod           := R1.Cod_Mod;
      l_Rvcnf.Serie             := R1.Serie;
      l_Rvcnf.Nro_Nf            := R1.Nro_Nf;
      l_Rvcnf.Sit_Docto         := R1.Sit_Docto;
      l_Rvcnf.Cod_Nat_Oper      := R1.Cod_Nat_Oper;
      l_Rvcnf.Descr_Nat_Oper    := R1.Descr_Nat_Oper;
      l_Rvcnf.Dm_Ind_Pag        := R1.Dm_Ind_Pag;
      l_Rvcnf.Dt_Sai_Ent        := R1.Dt_Sai_Ent;
      l_Rvcnf.Hora_Sai_Ent      := R1.Hora_Sai_Ent;
      l_Rvcnf.Dt_Emiss          := R1.Dt_Emiss;
      l_Rvcnf.Uf_Embarq         := R1.Uf_Embarq;
      l_Rvcnf.Local_Embarq      := R1.Local_Embarq;
      l_Rvcnf.Nf_Empenho        := R1.Nf_Empenho;
      l_Rvcnf.Pedido_Compra     := R1.Pedido_Compra;
      l_Rvcnf.Contrato_Compra   := R1.Contrato_Compra;
      l_Rvcnf.Dm_St_Proc        := R1.Dm_St_Proc;
      l_Rvcnf.Dm_Fin_Nfe        := R1.Dm_Fin_Nfe;
      l_Rvcnf.Dm_Proc_Emiss     := R1.Dm_Proc_Emiss;
      l_Rvcnf.Cidade_Ibge_Emit  := R1.Cidade_Ibge_Emit;
      l_Rvcnf.Uf_Ibge_Emit      := R1.Uf_Ibge_Emit;
      l_Rvcnf.Usuario           := R1.Usuario;
      l_Rvcnf.Vias_Danfe_Custom := R1.Vias_Danfe_Custom;
      l_Rvcnf.Nro_Chave_Cte_Ref := R1.Nro_Chave_Cte_Ref;
      l_Rvcnf.Sist_Orig         := R1.Sist_Orig;
      l_Rvcnf.Unid_Org          := R1.Unid_Org;
      --
      Begin
        Xxisv_Csf_Nfe_Pkg.Pb_Limpa_Interface_p(l_Rvcnf.Sist_Orig, l_Rvcnf.Cpf_Cnpj_Emit, l_Rvcnf.Nro_Nf, l_Rvcnf.Serie);
      End;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Sit_Docto
          ,Cod_Nat_Oper
          ,Descr_Nat_Oper
          ,Dm_Ind_Pag
          ,Dt_Sai_Ent
          ,Hora_Sai_Ent
          ,Dt_Emiss
          ,Uf_Embarq
          ,Local_Embarq
          ,Nf_Empenho
          ,Pedido_Compra
          ,Contrato_Compra
          ,Dm_St_Proc
          ,Dm_Fin_Nfe
          ,Dm_Proc_Emiss
          ,Cidade_Ibge_Emit
          ,Uf_Ibge_Emit
          ,Usuario
          ,Vias_Danfe_Custom
          ,Nro_Chave_Cte_Ref
          ,Sist_Orig
          ,Unid_Org)
        Values
          (l_Rvcnf.Cpf_Cnpj_Emit
          ,l_Rvcnf.Dm_Ind_Emit
          ,l_Rvcnf.Dm_Ind_Oper
          ,l_Rvcnf.Cod_Part
          ,l_Rvcnf.Cod_Mod
          ,l_Rvcnf.Serie
          ,l_Rvcnf.Nro_Nf
          ,l_Rvcnf.Sit_Docto
          ,l_Rvcnf.Cod_Nat_Oper
          ,l_Rvcnf.Descr_Nat_Oper
          ,l_Rvcnf.Dm_Ind_Pag
          ,l_Rvcnf.Dt_Sai_Ent
          ,l_Rvcnf.Hora_Sai_Ent
          ,l_Rvcnf.Dt_Emiss
          ,l_Rvcnf.Uf_Embarq
          ,l_Rvcnf.Local_Embarq
          ,l_Rvcnf.Nf_Empenho
          ,l_Rvcnf.Pedido_Compra
          ,l_Rvcnf.Contrato_Compra
          ,l_Rvcnf.Dm_St_Proc
          ,l_Rvcnf.Dm_Fin_Nfe
          ,l_Rvcnf.Dm_Proc_Emiss
          ,l_Rvcnf.Cidade_Ibge_Emit
          ,l_Rvcnf.Uf_Ibge_Emit
          ,l_Rvcnf.Usuario
          ,l_Rvcnf.Vias_Danfe_Custom
          ,l_Rvcnf.Nro_Chave_Cte_Ref
          ,l_Rvcnf.Sist_Orig
          ,l_Rvcnf.Unid_Org);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Ff_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Uf_Ibge_Dest => R1.Uf_Ibge_Dest, p_Dm_Ind_Final => R1.Dm_Ind_Final, p_Im => R1.Im, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Compl_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Emit_p(p_Rvcnf => l_Rvcnf, p_Warehouse_Id => R1.Warehouse_Id, p_Ie => R1.Ie, p_Im => R1.Im, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Dest_p(p_Rvcnf => l_Rvcnf, p_Site_Use_Id => R1.Bill_To_Site_Use_Id, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Total_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Referen_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => R1.Customer_Trx_Id, p_Customer_Trx_Id_Ref => R1.Customer_Trx_Id_Ref, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nfinfor_Adic_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Comments => R1.Comments, p_Legal_Process_Source_Ind => R1.Legal_Process_Source_Ind, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Cobr_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Local_p(p_Rvcnf => l_Rvcnf, p_Warehouse_Id => R1.Warehouse_Id, p_Ie => R1.Ie, p_Ship_To_Site_Use_Id => R1.Ship_To_Site_Use_Id, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Transp_p(p_Rvcnf => l_Rvcnf, p_Fob_Point => R1.Fob_Point, p_Ship_Via => R1.Ship_Via, p_Warehouse_Id => R1.Warehouse_Id, p_Rotina => p_Rotina);
        --
        If R1.Uf_Ibge_Dest <> R1.Uf_Ibge_Emit
        Then
          /*Incluida essa condição por conta da NFe 4.0*/
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nftransp_Veic_p(p_Rvcnf => l_Rvcnf, p_License_Plate => R1.License_Plate, p_Vehicle_Plate_State_Code => R1.Vehicle_Plate_State_Code, p_Vehicle_Antt_Inscription => R1.Vehicle_Antt_Inscription, p_Towing_Veh_Plate_Number => R1.Towing_Veh_Plate_Number, p_Towing_Veh_Plate_State_Code => R1.Towing_Veh_Plate_State_Code, p_Towing_Veh_Antt_Inscription => R1.Towing_Veh_Antt_Inscription, p_Wagon_Code => R1.Wagon_Code, p_Ferry_Code => R1.Ferry_Code, p_Rotina => p_Rotina);
        End If;
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nftransp_Vol_p(p_Rvcnf => l_Rvcnf, p_Bulk_Number => R1.Bulk_Number, p_Bulk => R1.Bulk, p_Species_Turnover => R1.Species_Turnover, p_Weight => R1.Weight, p_Net_Weight => R1.Net_Weight, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nftranspvol_Lacre_p(p_Rvcnf => l_Rvcnf, p_Bulk_Number => R1.Bulk_Number, p_Seal_Number => R1.Seal_Number, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Item_Nota_Fiscal_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Vl_Frete => R1.Vl_Frete, p_Vl_Seguro => R1.Vl_Seguro, p_Vl_Outras_Despesas => R1.Vl_Outras_Despesas, p_Uf_Dest => R1.Uf_Dest, p_Pedido_Compra => R1.Pedido_Compra, p_Tipo_Transacao => R1.Nature_Operation_Code, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nf_Total_Ff_Custom_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id,
                                                      ---                                                      p_Dm_Fin_Nfe => , 
                                                      p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nf_Forma_Pgto_p(p_Rvcnf => l_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Rotina => p_Rotina);
        --
        Xxisv_Csf_Nfe_Pkg.Atualiza_Jl_Br_p(p_Customer_Trx_Id => p_Customer_Trx_Id);
        --
        Begin
          Update Vw_Csf_Nota_Fiscal Vcnf
             Set Vcnf.Dm_St_Proc = 0
           Where Vcnf.Cpf_Cnpj_Emit = R1.Cpf_Cnpj_Emit
             And Vcnf.Dm_Ind_Emit = R1.Dm_Ind_Emit
             And Vcnf.Dm_Ind_Oper = R1.Dm_Ind_Oper
             And Vcnf.Cod_Part = R1.Cod_Part
             And Vcnf.Cod_Mod = R1.Cod_Mod
             And Vcnf.Serie = R1.Serie
             And Vcnf.Nro_Nf = R1.Nro_Nf
             And Vcnf.Dm_St_Proc = -1;
        End;
        --
        Commit;
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL - ' || 'Cpf_Cnpj_Emit: ' ||
                         l_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         l_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         l_Rvcnf.Cod_Mod || ', Serie: ' || l_Rvcnf.Serie ||
                         ', Nro_Nf: ' || l_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_p;

  ---
  -----------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_ff ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Ff_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                   ,p_Customer_Trx_Id Number
                                   ,p_Uf_Ibge_Dest    Number
                                   ,p_Dm_Ind_Final    Number
                                   ,p_Im              Varchar2
                                   ,p_Rotina          Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C2 Is
      Select 'DM_ID_DEST' Atributo
            ,Case
               When p_Uf_Ibge_Dest = 99 Then
                '3'
               When p_Uf_Ibge_Dest <> p_Rvcnf.Uf_Ibge_Emit Then
                '2'
               When p_Uf_Ibge_Dest = p_Rvcnf.Uf_Ibge_Emit Then
                '1'
             End Valor
        From Dual
       Where 1 = 1
      --
      Union
      --
      Select 'DM_IND_FINAL' Atributo /*Verificar se esta é a regra a ser considerada (Carranza)*/
            ,Case
               When p_Dm_Ind_Final = 1 Then
                '0'
               When p_Dm_Ind_Final = 2 Then
                '1'
               When p_Dm_Ind_Final = 9 Then
                '1'
               Else
                '1'
             End Valor
        From Dual
       Where 1 = 1
      --
      Union
      --
      Select 'DM_IND_PRES' Atributo
            ,Jbcte.Buyer_Presence_Ind Valor
        From Jl_Br_Customer_Trx_Exts Jbcte
       Where 1 = 1
         And Jbcte.Customer_Trx_Id = p_Customer_Trx_Id
         And Jbcte.Buyer_Presence_Ind Is Not Null
      --
      Union
      --
      Select 'DM_NAT_OPER' Atributo
            ,Case
               When (Select Sum(Zl.Unrounded_Tax_Amt)
                       From Zx_Lines                  Zl
                           ,Ar_Vat_Tax_All            Arvt
                           ,Ra_Customer_Trx_Lines_All Rctla
                      Where 1 = 1
                        And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                        And Zl.Internal_Organization_Id = Arvt.Org_Id
                        And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                        And Rctla.Line_Type = 'LINE'
                        And Regexp_Like(Arvt.Tax, 'ISS')
                        And Arvt.Tax_Rate >= 0
                        And Rctla.Global_Attribute1 = '5933'
                        And Zl.Trx_Id = p_Customer_Trx_Id) > 0 Then
                '1'
               When (Select Sum(Zl.Unrounded_Tax_Amt)
                       From Zx_Lines                  Zl
                           ,Ar_Vat_Tax_All            Arvt
                           ,Ra_Customer_Trx_Lines_All Rctla
                      Where 1 = 1
                        And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                        And Zl.Internal_Organization_Id = Arvt.Org_Id
                        And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                        And Rctla.Line_Type = 'LINE'
                        And Regexp_Like(Arvt.Tax, 'ISS')
                        And Arvt.Tax_Rate >= 0
                        And Rctla.Global_Attribute1 = '6933'
                        And Zl.Trx_Id = p_Customer_Trx_Id) > 0 Then
                '2'
               When (Select Sum(Zl.Unrounded_Tax_Amt)
                       From Zx_Lines                  Zl
                           ,Ar_Vat_Tax_All            Arvt
                           ,Ra_Customer_Trx_Lines_All Rctla
                      Where 1 = 1
                        And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                        And Zl.Internal_Organization_Id = Arvt.Org_Id
                        And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                        And Rctla.Line_Type = 'LINE'
                        And Regexp_Like(Arvt.Tax, 'ISS')
                        And Arvt.Tax_Rate >= 0
                        And Rctla.Global_Attribute1 In ('5933', '6933', '7933')
                        And Zl.Trx_Id = p_Customer_Trx_Id) = 0 Then
                '3'
               When (Select Sum(Zl.Unrounded_Tax_Amt)
                       From Zx_Lines                  Zl
                           ,Ar_Vat_Tax_All            Arvt
                           ,Ra_Customer_Trx_Lines_All Rctla
                      Where 1 = 1
                        And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                        And Zl.Internal_Organization_Id = Arvt.Org_Id
                        And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                        And Rctla.Line_Type = 'LINE'
                        And Regexp_Like(Arvt.Tax, 'ISS')
                        And Arvt.Tax_Rate >= 0
                        And Rctla.Global_Attribute1 = '7933'
                        And Zl.Trx_Id = p_Customer_Trx_Id) > 0 Then
                '4'
             End Valor
        From Dual
       Where 1 = 1
      ---
      Union
      --
      Select 'DT_EXE_SERV' Atributo
             /*,To_Char(Jbcte.Srv_Exec_Date, 'dd/mm/rrrr') Valor*/ -- Carranza 15/10/2020
            ,Nvl(To_Char(Jbcte.Srv_Exec_Date, 'dd/mm/rrrr'), To_Char(p_Rvcnf.Dt_Emiss, 'dd/mm/rrrr')) Valor -- -- Carranza 15/10/2020
        From Jl_Br_Customer_Trx_Exts Jbcte
       Where 1 = 1
         And Jbcte.Customer_Trx_Id = p_Customer_Trx_Id
         And p_Im Is Not Null
      --
      Union
      --
      Select 'DM_TP_NF_DEBITO' Atributo
            ,Regexp_Substr(Rctt.Global_Attribute5, '\.(\d+)', 1, 1, Null, 1) Valor
        From Ra_Cust_Trx_Types_All Rctt
            ,Ra_Customer_Trx_All   Rcta
       Where Rcta.Cust_Trx_Type_Id = Rctt.Cust_Trx_Type_Id
         And Substr(Rctt.Global_Attribute5, 1, 1) = '6'
         And Rcta.Customer_Trx_Id = p_Customer_Trx_Id -- Carranza 28/04/2026
      --
      Union
      --
      Select 'DM_TP_NF_CREDITO' Atributo
            ,Regexp_Substr(Rctt.Global_Attribute5, '\.(\d+)', 1, 1, Null, 1) Valor
        From Ra_Cust_Trx_Types_All Rctt
            ,Ra_Customer_Trx_All   Rcta
       Where Rcta.Cust_Trx_Type_Id = Rctt.Cust_Trx_Type_Id
         And Substr(Rctt.Global_Attribute5, 1, 1) = '5'
         And Rcta.Customer_Trx_Id = p_Customer_Trx_Id; -- Carranza 28/04/2026
    R2 C2%Rowtype;
    --
  Begin
    Open C2;
    Loop
      Fetch C2
        Into R2;
      Exit When C2%Notfound;
      --
      If R2.Valor Is Not Null
      Then
        --
        Begin
          Insert Into Vw_Csf_Nota_Fiscal_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Atributo
            ,Valor)
          Values
            (p_Rvcnf.Cpf_Cnpj_Emit
            ,p_Rvcnf.Dm_Ind_Emit
            ,p_Rvcnf.Dm_Ind_Oper
            ,p_Rvcnf.Cod_Part
            ,p_Rvcnf.Cod_Mod
            ,p_Rvcnf.Serie
            ,p_Rvcnf.Nro_Nf
            ,R2.Atributo
            ,R2.Valor);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_FF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                           ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
      End If;
      --
    End Loop;
    Close C2;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_FF_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Ff_p;

  ---
  -----------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Compl ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Compl_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                      ,p_Customer_Trx_Id Number
                                      ,p_Rotina          Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
  Begin
    --
    Begin
      Insert Into Vw_Csf_Nota_Fiscal_Compl
        (Cpf_Cnpj_Emit
        ,Dm_Ind_Emit
        ,Dm_Ind_Oper
        ,Cod_Part
        ,Cod_Mod
        ,Serie
        ,Nro_Nf
        ,Nro_Chave_Nfe
        ,Id_Erp
        ,Sub_Serie
        ,Cod_Infor
        ,Cod_Cta
        ,Cod_Cons
        ,Dm_Tp_Ligacao
        ,Dm_Cod_Grupo_Tensao
        ,Dm_Tp_Assinante
        ,Nro_Ord_Emb
        ,Seq_Nro_Ord_Emb)
      Values
        (p_Rvcnf.Cpf_Cnpj_Emit
        ,p_Rvcnf.Dm_Ind_Emit
        ,p_Rvcnf.Dm_Ind_Oper
        ,p_Rvcnf.Cod_Part
        ,p_Rvcnf.Cod_Mod
        ,p_Rvcnf.Serie
        ,p_Rvcnf.Nro_Nf
        ,Null
        ,p_Customer_Trx_Id
        ,Null
        ,Null
        ,Null
        ,Null
        ,Null
        ,Null
        ,Null
        ,Null
        ,Null);
      --
    Exception
      When Dup_Val_On_Index Then
        Null;
      When Others Then
        --
        g_Retcode   := 1;
        g_Erro      := Nvl(g_Erro, 0) + 1;
        l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_COMPL_P - ' || 'Cpf_Cnpj_Emit: ' ||
                       p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                       p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                       p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                       ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                       Sqlerrm;
        g_Erro_Msg  := l_Desc_Erro;
        --
        Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
        --
    End;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_COMPL_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Compl_p;

  ---
  -----------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Emit ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Emit_p(p_Rvcnf        Vw_Csf_Nota_Fiscal%Rowtype
                                     ,p_Warehouse_Id Number
                                     ,p_Ie           Varchar2
                                     ,p_Im           Varchar2
                                     ,p_Rotina       Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C2 Is
      Select /*Substr(Cfe.Establishment_Name, 1, 60) Nome*/ -- Carranza 19/10/2022
       Substr(Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Razao_Social_f(Cfe.Registration_Number), Cfe.Establishment_Name), 1, 60) Nome -- Carranza 19/10/2022
      ,Substr(Cfe.Location_Code, 1, 60) Fantasia
      ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfe.Address_Line_1), 1, 60) Lograd
      ,Substr(Cfe.Address_Line_2, 1, 10) Nro
      ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfe.Address_Line_3), 1, 60) Compl
      ,Substr(Cfe.Region_1, 1, 60) Bairro
      ,Substr(Cfe.Town_Or_City, 1, 60) Cidade
      ,Substr(Xep.Etb_Information1, 1, 7) Cidade_Ibge
      ,Substr(Cfe.Region_2, 1, 2) Uf
      ,Substr(Regexp_Replace(Cfe.Postal_Code, '[^0-9]'), 1, 8) Cep
      ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Pais_Ibge_f(Cfe.Country) Cod_Pais
      ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Nome_Pais_f(Cfe.Country) Pais
      ,Substr(Regexp_Replace(Cfe.Telephone_Number_1, '[^0-9]'), 1, 14) Fone
      ,p_Ie Ie
      ,Null Iest
      ,p_Im Im
      ,Case
         When p_Im Is Null Then
          Null
         Else
          Substr(Xep.Activity_Code, 1, 7)
       End Cnae
       /*,Case
         When Xep.Type_Of_Company In ('LLC', 'SA', 'ILLE', 'SAF') Then
          3
         Else
          1
       End Dm_Reg_Trib*/ -- Carranza 28/08/2018
      ,Case
         When Xep.Type_Of_Company In ('ASL') Then
          1
         Else
          3
       End Dm_Reg_Trib -- Carranza 28/08/2018
        From Cll_F255_Establishment_v Cfe
            ,Xle_Etb_Profiles         Xep
            ,Xle_Registrations        Xr
       Where 1 = 1
         And Cfe.Inventory_Organization_Id = p_Warehouse_Id
         And Cfe.Establishment_Id = Xep.Establishment_Id
         And Cfe.Registration_Number = Xr.Registration_Number
         And Cfe.Location_Id = Xr.Location_Id
         And Xr.Source_Id = Xep.Establishment_Id
         And Xr.Source_Table = 'XLE_ETB_PROFILES'
         And Nvl(Xr.Effective_To, Sysdate) >= Sysdate;
    R2 C2%Rowtype;
    --
  Begin
    Open C2;
    Loop
      Fetch C2
        Into R2;
      Exit When C2%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Emit
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nome
          ,Fantasia
          ,Lograd
          ,Nro
          ,Compl
          ,Bairro
          ,Cidade
          ,Cidade_Ibge
          ,Uf
          ,Cep
          ,Cod_Pais
          ,Pais
          ,Fone
          ,Ie
          ,Iest
          ,Im
          ,Cnae
          ,Dm_Reg_Trib)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,R2.Nome
          ,R2.Fantasia
          ,R2.Lograd
          ,R2.Nro
          ,R2.Compl
          ,R2.Bairro
          ,R2.Cidade
          ,R2.Cidade_Ibge
          ,R2.Uf
          ,R2.Cep
          ,R2.Cod_Pais
          ,R2.Pais
          ,R2.Fone
          ,R2.Ie
          ,R2.Iest
          ,R2.Im
          ,R2.Cnae
          ,R2.Dm_Reg_Trib);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_EMIT_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                         ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close C2;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_EMIT_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Emit_p;

  ---
  -----------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Dest ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Dest_p(p_Rvcnf       Vw_Csf_Nota_Fiscal%Rowtype
                                     ,p_Site_Use_Id Number
                                     ,p_Rotina      Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C2 Is
      Select Case
               When Cfac.Document_Type = 'CNPJ' Then
                Substr(Cfac.Document_Number, 1, 14)
               Else
                Null
             End Cnpj
            ,Case
               When Cfac.Document_Type = 'CPF' Then
                Substr(Cfac.Document_Number, 1, 11)
               Else
                Null
             End Cpf
            ,Nvl((Select Substr(Addressee, 1, 60)
                   From Hz_Party_Sites a
                  Where a.Party_Site_Id = Cfac.Party_Site_Id), Substr(Cfac.Customer_Name, 1, 60)) Nome
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfac.Address1), 1, 60) Lograd
            ,Substr(Nvl(Cfac.Address2, 'S/N'), 1, 10) Nro
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfac.Address3), 1, 60) Compl
            ,Substr(Nvl(Cfac.Address4, 'S/B'), 1, 60) Bairro
            ,Substr(Cfac.City, 1, 60) Cidade
            ,Case
               When Cfac.Country <> 'BR' Then
                '9999999'
               Else
                Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cidade_Ibge_Dest_f(Cfac.City, Cfac.State)
             End Cidade_Ibge
            ,Case
               When Cfac.Country <> 'BR' Then
                'EX'
               Else
                Cfac.State
             End Uf
            ,Case
               When Cfac.Country <> 'BR' Then
                Null
               Else
                Substr(Regexp_Replace(Cfac.Postal_Code, '[^0-9]'), 1, 8)
             End Cep
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Pais_Ibge_f(Cfac.Country) Cod_Pais
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Nome_Pais_f(Cfac.Country) Pais
            ,(Select Substr(Regexp_Replace(Hcp.Raw_Phone_Number, '[^0-9]'), 1, 14)
                From Hz_Contact_Points Hcp
                    ,Hz_Party_Sites    Hps
               Where 1 = 1
                 And Hcp.Owner_Table_Id(+) = Hps.Party_Site_Id
                 And Hps.Location_Id = Cfac.Location_Id
                 And Hcp.Owner_Table_Name(+) = 'HZ_PARTY_SITES'
                 And Hcp.Contact_Point_Type = 'PHONE'
                 And Hcp.Primary_Flag(+) = 'Y') Fone
            ,Case
               When Cfac.Global_Attribute13 In ('2') Then
                Null
               Else
                To_Char(Substr(Replace(Replace((Cfac.Ie), '.', ''), '-', ''), 1, 14))
             End Ie
            ,Substr(Cfac.Global_Attribute10, 1, 9) Suframa
             /*,(Select lower(Hcp.Email_Address)
              From Hz_Contact_Points Hcp
                  ,Hz_Party_Sites    Hps
             Where 1 = 1
               And Hcp.Owner_Table_Id(+) = Hps.Party_Site_Id
               And Hps.Location_Id = Cfac.Location_Id
               And Hcp.Owner_Table_Name(+) = 'HZ_PARTY_SITES'
               And Hcp.Contact_Point_Type = 'EMAIL'
               And Hcp.Contact_Point_Purpose = 'NFE') Email*/ -- Alterado para atender demanda Venancio (se atrapalhar podemos voltar anterior e criar custom) Carranza 09/05/2018
             ---
            ,Nvl((Select Lower(Hcp.Email_Address) /*e-mail a nivel de local do cliente*/
                   From Hz_Contact_Points Hcp
                       ,Hz_Party_Sites    Hps
                  Where 1 = 1
                    And Hcp.Owner_Table_Id(+) = Hps.Party_Site_Id
                    And Hps.Location_Id = Cfac.Location_Id
                    And Hcp.Owner_Table_Name(+) = 'HZ_PARTY_SITES'
                    And Hcp.Contact_Point_Type = 'EMAIL'
                    And Hcp.Contact_Point_Purpose = 'NFE'
                    And Hcp.Status = 'A'), (Select Lower(Hcp.Email_Address) /*e-mail a nivel de conta do cliente*/
                     From Hz_Contact_Points Hcp
                         ,Hz_Party_Sites    Hps
                    Where 1 = 1
                      And Hcp.Owner_Table_Id(+) =
                          Hps.Party_Id
                      And Hps.Location_Id =
                          Cfac.Location_Id
                      And Hcp.Owner_Table_Name(+) =
                          'HZ_PARTIES'
                      And Hcp.Contact_Point_Type =
                          'EMAIL'
                      And Hcp.Contact_Point_Purpose =
                          'NFE'
                      And Hcp.Status = 'A'
                      And Hcp.Email_Address Is Not Null
                      And Rownum = 1)) Email -- Alterado para atender demanda Venancio (se atrapalhar podemos voltar anterior e criar custom) Carranza 09/05/2018
             ---
            ,Nvl(Cfac.Global_Attribute13, 9) Dm_Ind_Ie_Dest
        From Cll_F255_Ar_Customers_v Cfac
       Where 1 = 1
         And Rownum = 1
         And Cfac.Site_Use_Id = p_Site_Use_Id;
    R2       C2%Rowtype;
    l_Rvcnfd Vw_Csf_Nota_Fiscal_Dest%Rowtype;
    --
  Begin
    Open C2;
    Loop
      Fetch C2
        Into R2;
      Exit When C2%Notfound;
      --
      --
      l_Rvcnfd.Cpf_Cnpj_Emit := p_Rvcnf.Cpf_Cnpj_Emit;
      l_Rvcnfd.Dm_Ind_Emit   := p_Rvcnf.Dm_Ind_Emit;
      l_Rvcnfd.Dm_Ind_Oper   := p_Rvcnf.Dm_Ind_Oper;
      l_Rvcnfd.Cod_Part      := p_Rvcnf.Cod_Part;
      l_Rvcnfd.Cod_Mod       := p_Rvcnf.Cod_Mod;
      l_Rvcnfd.Serie         := p_Rvcnf.Serie;
      l_Rvcnfd.Nro_Nf        := p_Rvcnf.Nro_Nf;
      l_Rvcnfd.Cnpj          := R2.Cnpj;
      l_Rvcnfd.Cpf           := R2.Cpf;
      l_Rvcnfd.Nome          := R2.Nome;
      l_Rvcnfd.Lograd        := R2.Lograd;
      l_Rvcnfd.Nro           := R2.Nro;
      l_Rvcnfd.Compl         := R2.Compl;
      l_Rvcnfd.Bairro        := R2.Bairro;
      l_Rvcnfd.Cidade        := R2.Cidade;
      l_Rvcnfd.Cidade_Ibge   := R2.Cidade_Ibge;
      l_Rvcnfd.Uf            := R2.Uf;
      l_Rvcnfd.Cep           := R2.Cep;
      l_Rvcnfd.Cod_Pais      := R2.Cod_Pais;
      l_Rvcnfd.Pais          := R2.Pais;
      l_Rvcnfd.Fone          := R2.Fone;
      l_Rvcnfd.Ie            := R2.Ie;
      l_Rvcnfd.Suframa       := R2.Suframa;
      l_Rvcnfd.Email         := R2.Email;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Dest
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Cnpj
          ,Cpf
          ,Nome
          ,Lograd
          ,Nro
          ,Compl
          ,Bairro
          ,Cidade
          ,Cidade_Ibge
          ,Uf
          ,Cep
          ,Cod_Pais
          ,Pais
          ,Fone
          ,Ie
          ,Suframa
          ,Email)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,R2.Cnpj
          ,R2.Cpf
          ,R2.Nome
          ,R2.Lograd
          ,R2.Nro
          ,R2.Compl
          ,R2.Bairro
          ,R2.Cidade
          ,R2.Cidade_Ibge
          ,R2.Uf
          ,R2.Cep
          ,R2.Cod_Pais
          ,R2.Pais
          ,R2.Fone
          ,To_Char(R2.Ie)
          ,R2.Suframa
          ,R2.Email);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Dest_Ff_p(p_Rvcnfd => l_Rvcnfd, p_Dm_Ind_Ie_Dest => R2.Dm_Ind_Ie_Dest, p_Rotina => p_Rotina);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_DEST_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                         ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close C2;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_DEST_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Dest_p;

  ---
  -----------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Dest_Ff ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Dest_Ff_p(p_Rvcnfd         Vw_Csf_Nota_Fiscal_Dest%Rowtype
                                        ,p_Dm_Ind_Ie_Dest Number
                                        ,p_Rotina         Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
  Begin
    --
    Begin
      Insert Into Vw_Csf_Nota_Fiscal_Dest_Ff
        (Cpf_Cnpj_Emit
        ,Dm_Ind_Emit
        ,Dm_Ind_Oper
        ,Cod_Part
        ,Cod_Mod
        ,Serie
        ,Nro_Nf
        ,Atributo
        ,Valor)
      Values
        (p_Rvcnfd.Cpf_Cnpj_Emit
        ,p_Rvcnfd.Dm_Ind_Emit
        ,p_Rvcnfd.Dm_Ind_Oper
        ,p_Rvcnfd.Cod_Part
        ,p_Rvcnfd.Cod_Mod
        ,p_Rvcnfd.Serie
        ,p_Rvcnfd.Nro_Nf
        ,'DM_IND_IE_DEST'
        ,p_Dm_Ind_Ie_Dest);
      --
    Exception
      When Dup_Val_On_Index Then
        Null;
      When Others Then
        --
        g_Retcode   := 1;
        g_Erro      := Nvl(g_Erro, 0) + 1;
        l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_DEST_FF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                       p_Rvcnfd.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                       p_Rvcnfd.Dm_Ind_Emit || ', Cod_Mod: ' ||
                       p_Rvcnfd.Cod_Mod || ', Serie: ' || p_Rvcnfd.Serie ||
                       ', Nro_Nf: ' || p_Rvcnfd.Nro_Nf || ', Erro: ' ||
                       Sqlerrm;
        g_Erro_Msg  := l_Desc_Erro;
        --
        Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
        --
    End;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_DEST_FF_P - ' || ' Erro: ' ||
                     Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Dest_Ff_p;

  ---
  ---
  -----------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Total ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Total_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                      ,p_Customer_Trx_Id Number
                                      ,p_Rotina          Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    x_Retorno   Number;
    --
    Cursor C2 Is
      Select /*Nvl((Select Sum(Nvl(Aux.Valor, 0))
                                                                                                                                                                                     From (Select Case
                                                                                                                                                                                                    When Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7) Not In
                                                                                                                                                                                                        \*('30', '40', '41', '50', '60', '90') Then*\ -- Carranza 08/05/2020
                                                                                                                                                                                                         ('30', '40', '41', '50', '51', '60', '90') Then -- Carranza 08/05/2020
                                                                                                                                                                                                     Abs(Sum(Zl.Taxable_Amt))
                                                                                                                                                                                                    Else
                                                                                                                                                                                                     0
                                                                                                                                                                                                  End Valor
                                                                                                                                                                                             From Zx_Lines                  Zl
                                                                                                                                                                                                 ,Ar_Vat_Tax_All            Arvt
                                                                                                                                                                                                 ,Ra_Customer_Trx_Lines_All Rctla
                                                                                                                                                                                            Where 1 = 1
                                                                                                                                                                                              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                                                                                                                                                                                              And Zl.Internal_Organization_Id = Arvt.Org_Id
                                                                                                                                                                                              And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                                                                                                                                                                                              And Rctla.Line_Type = 'LINE'
                                                                                                                                                                                              And Arvt.Global_Attribute10 = 'ICMS'
                                                                                                                                                                                              And Arvt.Global_Attribute2 = 'Y'
                                                                                                                                                                                              And Zl.Trx_Id = p_Customer_Trx_Id
                                                                                                                                                                                            Group By Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7)) Aux), 0) Vl_Base_Calc_Icms*/ -- Carranza 08/02/2021
       Xxisv_Csf_Nfe_Pkg.Get_Nfe_Total_Bc_Icms_f(Rcta.Customer_Trx_Id) Vl_Base_Calc_Icms -- Carranza 08/02/2021
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines                  Zl
                 ,Ar_Vat_Tax_All            Arvt
                 ,Ra_Customer_Trx_Lines_All Rctla
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
              And Rctla.Line_Type = 'LINE'
              And Arvt.Global_Attribute10 = 'ICMS'
              And Arvt.Global_Attribute2 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Imp_Trib_Icms
      ,Nvl((Select Abs(Sum(Zl.Taxable_Amt))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'ICMS-ST'
              And Arvt.Global_Attribute2 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Base_Calc_St
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'ICMS-ST'
              And Arvt.Global_Attribute2 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Imp_Trib_St
      ,Nvl((Select Sum(Nvl(Rctl.Gross_Extended_Amount, Rctl.Extended_Amount))
             From Apps.Ra_Customer_Trx_Lines_All Rctl
                 ,Mtl_System_Items_Kfv           Msik
            Where 1 = 1
              And Msik.Inventory_Item_Id = Rctl.Inventory_Item_Id
              And Msik.Organization_Id = Rctl.Warehouse_Id
              And (Msik.Item_Type <> 'FRT' Or Msik.Item_Type Is Null)
              And Rctl.Line_Type = 'LINE'
              And Rctl.Customer_Trx_Id = Rcta.Customer_Trx_Id
              And (Rctl.Interface_Line_Attribute11 = 0 Or
                  Rctl.Interface_Line_Attribute11 Is Null)
              And Rctl.Global_Attribute1 Not In
                  ('1933', '2933', '5933', '6933')), 0) Vl_Total_Item
      ,Case
         When Rcta.Global_Attribute9 Is Null Then
          Nvl((Select Sum(Nvl(Rctl.Gross_Extended_Amount, Rctl.Extended_Amount))
                From Apps.Ra_Customer_Trx_Lines_All Rctl
                    ,Mtl_System_Items_Kfv           Msik
               Where 1 = 1
                 And Msik.Inventory_Item_Id = Rctl.Inventory_Item_Id
                 And Msik.Organization_Id = Rctl.Warehouse_Id
                 And Msik.Item_Type = 'FRT'
                 And Rctl.Line_Type = 'LINE'
                 And Rctl.Customer_Trx_Id = Rcta.Customer_Trx_Id), 0) +
          Nvl((Select Sum(Nvl(Rctl.Gross_Extended_Amount, Rctl.Extended_Amount))
                From Apps.Ra_Customer_Trx_Lines_All Rctl
               Where 1 = 1
                 And Rctl.Line_Type = 'FREIGHT'
                 And Rctl.Customer_Trx_Id = Rcta.Customer_Trx_Id), 0)
         Else
          Nvl(Fnd_Number.Canonical_To_Number(Rcta.Global_Attribute9), 0)
       End Vl_Frete
      ,Fnd_Number.Canonical_To_Number(Nvl(Rcta.Global_Attribute10, '0')) Vl_Seguro
      ,Nvl((Select Abs(Sum(Nvl(a.Gross_Extended_Amount, a.Extended_Amount)))
             From Ra_Customer_Trx_Lines_All a
            Where 1 = 1
              And a.Customer_Trx_Id = Rcta.Customer_Trx_Id
              And a.Line_Type = 'LINE'
              And a.Interface_Line_Attribute11 <> 0
              And a.Interface_Line_Context = 'ORDER ENTRY'
              And Nvl(a.Gross_Extended_Amount, a.Extended_Amount) < 0), 0) Vl_Desconto
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'II'
              And Arvt.Global_Attribute2 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Imp_Trib_Ii
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'IPI'
              And Arvt.Global_Attribute2 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Imp_Trib_Ipi
      ,Case
         When Rcta.Interface_Header_Context = 'CLL F189 INTEGRATED RCV' Then
          Nvl((Select Sum(Round(Cfil.Pis_Amount_Recover, 2))
                From Ra_Customer_Trx_Lines_All Rctla
                    ,Cll_F189_Invoice_Lines    Cfil
               Where Rctla.Customer_Trx_Id = Rcta.Customer_Trx_Id
                 And Rctla.Line_Type = 'LINE'
                 And Rctla.Interface_Line_Context = 'CLL F189 INTEGRATED RCV'
                 And Cfil.Invoice_Line_Id = Rctla.Interface_Line_Attribute4), 0)
         Else
          Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
                From Zx_Lines                  Zl
                    ,Ar_Vat_Tax_All            Arvt
                    ,Ra_Customer_Trx_Lines_All Rctla
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Rctla.Line_Type = 'LINE'
                 And Arvt.Global_Attribute10 = 'PIS'
                 And Arvt.Global_Attribute2 = 'Y'
                 And (Arvt.Global_Attribute11 = 'N' Or
                     Arvt.Global_Attribute11 Is Null)
                 And Rctla.Global_Attribute1 Not In ('5933', '6933')
                 And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0)
       End Vl_Imp_Trib_Pis
      ,Case
         When Rcta.Interface_Header_Context = 'CLL F189 INTEGRATED RCV' Then
          Nvl((Select Sum(Round(Cfil.Cofins_Amount_Recover, 2))
                From Ra_Customer_Trx_Lines_All Rctla
                    ,Cll_F189_Invoice_Lines    Cfil
               Where Rctla.Customer_Trx_Id = Rcta.Customer_Trx_Id
                 And Rctla.Line_Type = 'LINE'
                 And Rctla.Interface_Line_Context = 'CLL F189 INTEGRATED RCV'
                 And Cfil.Invoice_Line_Id = Rctla.Interface_Line_Attribute4), 0)
         Else
          Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
                From Zx_Lines                  Zl
                    ,Ar_Vat_Tax_All            Arvt
                    ,Ra_Customer_Trx_Lines_All Rctla
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Rctla.Line_Type = 'LINE'
                 And Arvt.Global_Attribute10 = 'COFINS'
                 And Arvt.Global_Attribute2 = 'Y'
                 And (Arvt.Global_Attribute11 = 'N' Or
                     Arvt.Global_Attribute11 Is Null)
                 And Rctla.Global_Attribute1 Not In ('5933', '6933')
                 And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0)
       End Vl_Imp_Trib_Cofins
      ,Nvl(Nvl((Nvl((Select Sum(Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt))) Vl_Outro
                      From Zx_Lines       Zl
                          ,Ar_Vat_Tax_All Arvt
                     Where 1 = 1
                       And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                       And Zl.Internal_Organization_Id = Arvt.Org_Id
                       And Zl.Trx_Id = Rcta.Customer_Trx_Id
                       And Zl.Tax_Amt_Included_Flag = 'Y'
                       And Nvl(Arvt.Global_Attribute10, 'Nulo') Not In
                          /*('IPI', 'ICMS-ST', 'PIS', 'COFINS')*/ -- Carranza 20/02/2019
                          /*('IPI', 'ICMS-ST', 'PIS', 'COFINS', 'II', 'ICMS') -- Carranza 20/02/2019*/ -- Carranza 08/04/2020
                           ('IPI', 'ICMS-ST', 'PIS', 'COFINS', 'II', 'ICMS', 'ICMS-ST-FP') -- Carranza 08/04/2020
                       And Arvt.Global_Attribute2 = 'N'), 0) +
               Nvl((Select Sum(Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt))) Vl_Outro
                      From Zx_Lines       Zl
                          ,Ar_Vat_Tax_All Arvt
                     Where 1 = 1
                       And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                       And Zl.Internal_Organization_Id = Arvt.Org_Id
                       And Zl.Trx_Id = Rcta.Customer_Trx_Id
                       And Nvl(Arvt.Global_Attribute10, 'Nulo') In ('IPI') /*Considerar o IPI de não contribuinte apenas quando não for operação de devolução NFe 4.0*/
                       And Arvt.Global_Attribute2 = 'N'
                       And Nvl(p_Rvcnf.Dm_Fin_Nfe, 0) <> 4), 0) +
               Nvl((Select Sum(Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt))) Vl_Outro
                      From Zx_Lines       Zl
                          ,Ar_Vat_Tax_All Arvt
                     Where 1 = 1
                       And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                       And Zl.Internal_Organization_Id = Arvt.Org_Id
                       And Zl.Trx_Id = Rcta.Customer_Trx_Id
                       And Zl.Tax_Amt_Included_Flag = 'N'
                          /*And Arvt.Global_Attribute10 = 'ICMS-ST'*/ -- Carranza 08/04/2020
                       And Arvt.Global_Attribute10 In
                           ('ICMS-ST', 'ICMS-ST-FP') -- Carranza 08/04/2020
                       And Arvt.Global_Attribute2 = 'N'), 0)), (Fnd_Number.Canonical_To_Number(Nvl(Rcta.Global_Attribute11, '0')))), 0) Vl_Outra_Despesas
      ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Vl_Total_Nf_f(Rcta.Customer_Trx_Id) Vl_Total_Nf
       /*,Nvl((Select Sum(Cfaiig_Itn.Vl_Item)
        From Apps.Cll_F255_Ar_Invoice_Items_v Cfaiig_Itn
       Where 1 = 1
         And Cfaiig_Itn.Line_Type = 'LINE'
         And Cfaiig_Itn.Customer_Trx_Id = Rcta.Customer_Trx_Id
         And Cfaiig_Itn.Code_Cfo In
             ('1933', '2933', '3933', '5933', '6933', '7933')), 0) Vl_Serv_Nao_Trib*/ -- Carranza 03/02/2021
       /*,Nvl((Xxisv_Csf_Nfe_Pkg.Get_Nfe_Vl_Total_Serv_f(Rcta.Customer_Trx_Id) -
       Xxisv_Csf_Nfe_Pkg.Get_Nfe_Total_Bc_Iss_f(Rcta.Customer_Trx_Id)), 0) Vl_Serv_Nao_Trib \*Valor Total dos Serviços sob não incidência ou não tributados pelo ICMS*\*/ -- Carranza 08/02/2021
      ,Nvl((Xxisv_Csf_Nfe_Pkg.Get_Nfe_Vl_Total_Serv_f(Rcta.Customer_Trx_Id) -
           Xxisv_Csf_Nfe_Pkg.Get_Nfe_Total_Bc_Icms_f(Rcta.Customer_Trx_Id)), 0) Vl_Serv_Nao_Trib /*Valor Total dos Serviços sob não incidência ou não tributados pelo ICMS*/
      ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Total_Bc_Iss_f(Rcta.Customer_Trx_Id) Vl_Base_Calc_Iss
      ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Total_Vl_Iss_f(Rcta.Customer_Trx_Id) Vl_Imp_Trib_Iss
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines                  Zl
                 ,Ar_Vat_Tax_All            Arvt
                 ,Ra_Customer_Trx_Lines_All Rctla
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
              And Rctla.Line_Type = 'LINE'
              And Arvt.Global_Attribute10 = 'PIS'
              And Arvt.Global_Attribute2 = 'Y'
              And (Arvt.Global_Attribute11 = 'N' Or
                  Arvt.Global_Attribute11 Is Null)
              And Rctla.Global_Attribute1 In ('5933', '6933')
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Pis_Iss
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines                  Zl
                 ,Ar_Vat_Tax_All            Arvt
                 ,Ra_Customer_Trx_Lines_All Rctla
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
              And Rctla.Line_Type = 'LINE'
              And Arvt.Global_Attribute10 = 'COFINS'
              And Arvt.Global_Attribute2 = 'Y'
              And (Arvt.Global_Attribute11 = 'N' Or
                  Arvt.Global_Attribute11 Is Null)
              And Rctla.Global_Attribute1 In ('5933', '6933')
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Cofins_Iss
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'PIS'
              And Arvt.Global_Attribute2 = 'Y'
              And Arvt.Global_Attribute11 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Ret_Pis
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'COFINS'
              And Arvt.Global_Attribute2 = 'Y'
              And Arvt.Global_Attribute11 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Ret_Cofins
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'CSLL'
              And Arvt.Global_Attribute2 = 'Y'
              And Arvt.Global_Attribute11 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Ret_Csll
      ,Nvl((Select Abs(Sum(Zl.Taxable_Amt))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'IRRF'
              And Arvt.Global_Attribute2 = 'Y'
              And Arvt.Global_Attribute11 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Base_Calc_Irrf
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'IRRF'
              And Arvt.Global_Attribute2 = 'Y'
              And Arvt.Global_Attribute11 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Ret_Irrf
      ,Nvl((Select Abs(Sum(Zl.Taxable_Amt))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'INSS'
              And Arvt.Global_Attribute2 = 'Y'
              And Arvt.Global_Attribute11 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Base_Calc_Ret_Prev
      ,Nvl((Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)))
             From Zx_Lines       Zl
                 ,Ar_Vat_Tax_All Arvt
            Where 1 = 1
              And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
              And Zl.Internal_Organization_Id = Arvt.Org_Id
              And Arvt.Global_Attribute10 = 'INSS'
              And Arvt.Global_Attribute2 = 'Y'
              And Arvt.Global_Attribute11 = 'Y'
              And Zl.Trx_Id = Rcta.Customer_Trx_Id), 0) Vl_Ret_Prev
       /*,Nvl((Select Sum(Cfaiig_Itn.Vl_Item)
        From Apps.Cll_F255_Ar_Invoice_Items_v Cfaiig_Itn
       Where 1 = 1
         And Cfaiig_Itn.Line_Type = 'LINE'
         And Cfaiig_Itn.Customer_Trx_Id = Rcta.Customer_Trx_Id
         And Cfaiig_Itn.Code_Cfo In
             ('1933', '2933', '3933', '5933', '6933', '7933')), 0) Vl_Total_Serv*/ -- Carranza 03/02/2021
      ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Vl_Total_Serv_f(Rcta.Customer_Trx_Id) Vl_Total_Serv
        From Ra_Customer_Trx_All Rcta
       Where 1 = 1
         And Rcta.Customer_Trx_Id = p_Customer_Trx_Id;
    R2       C2%Rowtype;
    l_Rvcnft Vw_Csf_Nota_Fiscal_Total%Rowtype;
    --
  Begin
    --
    Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Nota_Fiscal_Total_p(p_Rvcnf => p_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Rotina => 'Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Nota_Fiscal_Total_p', p_Retorno => x_Retorno);
    If x_Retorno = 0
    Then
      --
      Open C2;
      Loop
        Fetch C2
          Into R2;
        Exit When C2%Notfound;
        --
        l_Rvcnft.Cpf_Cnpj_Emit         := p_Rvcnf.Cpf_Cnpj_Emit;
        l_Rvcnft.Dm_Ind_Emit           := p_Rvcnf.Dm_Ind_Emit;
        l_Rvcnft.Dm_Ind_Oper           := p_Rvcnf.Dm_Ind_Oper;
        l_Rvcnft.Cod_Part              := p_Rvcnf.Cod_Part;
        l_Rvcnft.Cod_Mod               := p_Rvcnf.Cod_Mod;
        l_Rvcnft.Serie                 := p_Rvcnf.Serie;
        l_Rvcnft.Nro_Nf                := p_Rvcnf.Nro_Nf;
        l_Rvcnft.Vl_Base_Calc_Icms     := R2.Vl_Base_Calc_Icms;
        l_Rvcnft.Vl_Imp_Trib_Icms      := R2.Vl_Imp_Trib_Icms;
        l_Rvcnft.Vl_Base_Calc_St       := R2.Vl_Base_Calc_St;
        l_Rvcnft.Vl_Imp_Trib_St        := R2.Vl_Imp_Trib_St;
        l_Rvcnft.Vl_Total_Item         := R2.Vl_Total_Item;
        l_Rvcnft.Vl_Frete              := R2.Vl_Frete;
        l_Rvcnft.Vl_Seguro             := R2.Vl_Seguro;
        l_Rvcnft.Vl_Desconto           := R2.Vl_Desconto;
        l_Rvcnft.Vl_Imp_Trib_Ii        := R2.Vl_Imp_Trib_Ii;
        l_Rvcnft.Vl_Imp_Trib_Ipi       := R2.Vl_Imp_Trib_Ipi;
        l_Rvcnft.Vl_Imp_Trib_Pis       := R2.Vl_Imp_Trib_Pis;
        l_Rvcnft.Vl_Imp_Trib_Cofins    := R2.Vl_Imp_Trib_Cofins;
        l_Rvcnft.Vl_Outra_Despesas     := R2.Vl_Outra_Despesas;
        l_Rvcnft.Vl_Total_Nf           := R2.Vl_Total_Nf;
        l_Rvcnft.Vl_Serv_Nao_Trib      := R2.Vl_Serv_Nao_Trib;
        l_Rvcnft.Vl_Base_Calc_Iss      := R2.Vl_Base_Calc_Iss;
        l_Rvcnft.Vl_Imp_Trib_Iss       := R2.Vl_Imp_Trib_Iss;
        l_Rvcnft.Vl_Pis_Iss            := R2.Vl_Pis_Iss;
        l_Rvcnft.Vl_Cofins_Iss         := R2.Vl_Cofins_Iss;
        l_Rvcnft.Vl_Ret_Pis            := R2.Vl_Ret_Pis;
        l_Rvcnft.Vl_Ret_Cofins         := R2.Vl_Ret_Cofins;
        l_Rvcnft.Vl_Ret_Csll           := R2.Vl_Ret_Csll;
        l_Rvcnft.Vl_Base_Calc_Irrf     := R2.Vl_Base_Calc_Irrf;
        l_Rvcnft.Vl_Ret_Irrf           := R2.Vl_Ret_Irrf;
        l_Rvcnft.Vl_Base_Calc_Ret_Prev := R2.Vl_Base_Calc_Ret_Prev;
        l_Rvcnft.Vl_Ret_Prev           := R2.Vl_Ret_Prev;
        l_Rvcnft.Vl_Total_Serv         := R2.Vl_Total_Serv;
        --
        Begin
          Insert Into Vw_Csf_Nota_Fiscal_Total
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Vl_Base_Calc_Icms
            ,Vl_Imp_Trib_Icms
            ,Vl_Base_Calc_St
            ,Vl_Imp_Trib_St
            ,Vl_Total_Item
            ,Vl_Frete
            ,Vl_Seguro
            ,Vl_Desconto
            ,Vl_Imp_Trib_Ii
            ,Vl_Imp_Trib_Ipi
            ,Vl_Imp_Trib_Pis
            ,Vl_Imp_Trib_Cofins
            ,Vl_Outra_Despesas
            ,Vl_Total_Nf
            ,Vl_Serv_Nao_Trib
            ,Vl_Base_Calc_Iss
            ,Vl_Imp_Trib_Iss
            ,Vl_Pis_Iss
            ,Vl_Cofins_Iss
            ,Vl_Ret_Pis
            ,Vl_Ret_Cofins
            ,Vl_Ret_Csll
            ,Vl_Base_Calc_Irrf
            ,Vl_Ret_Irrf
            ,Vl_Base_Calc_Ret_Prev
            ,Vl_Ret_Prev
            ,Vl_Total_Serv)
          Values
            (p_Rvcnf.Cpf_Cnpj_Emit
            ,p_Rvcnf.Dm_Ind_Emit
            ,p_Rvcnf.Dm_Ind_Oper
            ,p_Rvcnf.Cod_Part
            ,p_Rvcnf.Cod_Mod
            ,p_Rvcnf.Serie
            ,p_Rvcnf.Nro_Nf
            ,R2.Vl_Base_Calc_Icms
            ,R2.Vl_Imp_Trib_Icms
            ,R2.Vl_Base_Calc_St
            ,R2.Vl_Imp_Trib_St
            ,R2.Vl_Total_Item
            ,R2.Vl_Frete
            ,R2.Vl_Seguro
            ,R2.Vl_Desconto
            ,R2.Vl_Imp_Trib_Ii
            ,R2.Vl_Imp_Trib_Ipi
            ,R2.Vl_Imp_Trib_Pis
            ,R2.Vl_Imp_Trib_Cofins
            ,R2.Vl_Outra_Despesas
            ,R2.Vl_Total_Nf
            ,R2.Vl_Serv_Nao_Trib
            ,R2.Vl_Base_Calc_Iss
            ,R2.Vl_Imp_Trib_Iss
            ,R2.Vl_Pis_Iss
            ,R2.Vl_Cofins_Iss
            ,R2.Vl_Ret_Pis
            ,R2.Vl_Ret_Cofins
            ,R2.Vl_Ret_Csll
            ,R2.Vl_Base_Calc_Irrf
            ,R2.Vl_Ret_Irrf
            ,R2.Vl_Base_Calc_Ret_Prev
            ,R2.Vl_Ret_Prev
            ,R2.Vl_Total_Serv);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nota_Fiscal_Total_Ff_p(p_Rvcnft => l_Rvcnft, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Dm_Fin_Nfe => p_Rvcnf.Dm_Fin_Nfe, p_Rotina => p_Rotina);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_P - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                           p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
      End Loop;
      Close C2;
      --
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Total_p;

  ---
  ---
  --------------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Total_Ff ---
  --------------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Total_Ff_p(p_Rvcnft          Vw_Csf_Nota_Fiscal_Total%Rowtype
                                         ,p_Customer_Trx_Id Number
                                         ,p_Dm_Fin_Nfe      Number
                                         ,p_Rotina          Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor c_Icms_d Is
      Select Sum(Nvl(a.Icms_Tax_Destnation, 0) - Nvl(a.Icms_Poverty_Tax, 0)) Vl_Icms_Uf_Dest
        From Jl_Br_Cust_Trx_Lines_Exts a
       Where 1 = 1
         And a.Customer_Trx_Id = p_Customer_Trx_Id Having
       Sum(Nvl(a.Icms_Tax_Destnation, 0) - Nvl(a.Icms_Poverty_Tax, 0)) > 0;
    R1 c_Icms_d%Rowtype;
    --
    Cursor c_Icms_r Is
      Select Sum(Nvl(a.Icms_Tax_Origin, 0)) Vl_Icms_Uf_Remet
        From Jl_Br_Cust_Trx_Lines_Exts a
       Where 1 = 1
         And a.Customer_Trx_Id = p_Customer_Trx_Id Having
       Sum(Nvl(a.Icms_Tax_Origin, 0)) > 0;
    R2 c_Icms_r%Rowtype;
    --
    Cursor c_Icms_p Is
      Select Sum(Nvl(a.Icms_Poverty_Tax, 0)) Vl_Comb_Pobr_Uf_Dest
        From Jl_Br_Cust_Trx_Lines_Exts a
       Where 1 = 1
         And a.Customer_Trx_Id = p_Customer_Trx_Id Having
       Sum(Nvl(a.Icms_Poverty_Tax, 0)) > 0;
    R3 c_Icms_p%Rowtype;
    --
    Cursor c_Fcp_p Is
      Select Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) Vl_Fcp
        From Zx_Lines                  Zl
            ,Ar_Vat_Tax_All            Arvt
            ,Ra_Customer_Trx_Lines_All Rctla
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Internal_Organization_Id = Arvt.Org_Id
         And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
         And Zl.Trx_Id = Rctla.Customer_Trx_Id
         And Rctla.Line_Type = 'LINE'
         And Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
             'CLL F189 INTEGRATED RCV' /*Não pegar impostos se a NFe for de origem do RI*/
         And Arvt.Global_Attribute10 = 'ICMS-FP'
         And Arvt.Global_Attribute2 = 'Y'
         And Zl.Trx_Id = p_Customer_Trx_Id Having
       Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) > 0;
    R4 c_Fcp_p%Rowtype;
    --
    Cursor c_Fcp_St_p Is
      Select Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) Vl_Fcp_St
        From Zx_Lines                  Zl
            ,Ar_Vat_Tax_All            Arvt
            ,Ra_Customer_Trx_Lines_All Rctla
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Internal_Organization_Id = Arvt.Org_Id
         And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
         And Zl.Trx_Id = Rctla.Customer_Trx_Id
         And Rctla.Line_Type = 'LINE'
         And Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
             'CLL F189 INTEGRATED RCV' /*Não pegar impostos se a NFe for de origem do RI*/
         And Arvt.Global_Attribute10 = 'ICMS-ST-FP'
         And Arvt.Global_Attribute2 = 'Y'
         And Nvl(Arvt.Global_Attribute11, 'N') = 'N'
         And Zl.Trx_Id = p_Customer_Trx_Id Having
       Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) > 0;
    R5 c_Fcp_St_p%Rowtype;
    --
    Cursor c_Fcp_St_Ret_p Is
      Select Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) Vl_Fcp_St_Ret
        From Zx_Lines                  Zl
            ,Ar_Vat_Tax_All            Arvt
            ,Ra_Customer_Trx_Lines_All Rctla
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Internal_Organization_Id = Arvt.Org_Id
         And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
         And Zl.Trx_Id = Rctla.Customer_Trx_Id
         And Rctla.Line_Type = 'LINE'
         And Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
             'CLL F189 INTEGRATED RCV' /*Não pegar impostos se a NFe for de origem do RI*/
         And Arvt.Global_Attribute10 = 'ICMS-ST-FP'
         And Arvt.Global_Attribute2 = 'Y'
         And Nvl(Arvt.Global_Attribute11, 'N') = 'Y'
         And Zl.Trx_Id = p_Customer_Trx_Id Having
       Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) > 0;
    R6 c_Fcp_St_Ret_p%Rowtype;
    --
    Cursor c_Ipi_Devol Is
      Select /*Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) Vl_Ipi_Devol*/ -- Carranza 11/10/2023
       Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) * 100 Vl_Ipi_Devol -- Carranza 11/10/2023
        From Zx_Lines                  Zl
            ,Ar_Vat_Tax_All            Arvt
            ,Ra_Customer_Trx_Lines_All Rctla
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Internal_Organization_Id = Arvt.Org_Id
         And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
         And Zl.Trx_Id = Rctla.Customer_Trx_Id
         And Rctla.Line_Type = 'LINE'
         And Arvt.Global_Attribute10 = 'IPI'
         And Arvt.Global_Attribute2 = 'N'
         And Zl.Trx_Id = p_Customer_Trx_Id
         And Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) > 0 Having
       Abs(Sum(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0))) > 0;
    R7 c_Ipi_Devol%Rowtype;
    --
    Cursor c_Icms_Deson Is
      Select Sum(Jbctl.Deferred_Icms_Amount) Vl_Icms_Deson
        From Zx_Lines                  Zl
            ,Ar_Vat_Tax_All            Arvt
            ,Jl_Br_Cust_Trx_Lines_Exts Jbctl
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Trx_Id = Jbctl.Customer_Trx_Id
         And Zl.Trx_Line_Id = Jbctl.Customer_Trx_Line_Id
         And Arvt.Global_Attribute10 = 'ICMS'
         And Arvt.Global_Attribute3 = 'ICMS_EXEMPT_REASON'
         And Arvt.Global_Attribute9 In
             ('20', '30', '40', '41', '50', '70', '90')
            /*And Nvl(Zl.Global_Attribute10, Legal_Justification_Text3) Is Not Null*/ -- Carranza 02/09/2019
         And Zl.Trx_Id = p_Customer_Trx_Id Having
       Sum(Jbctl.Deferred_Icms_Amount) > 0;
    R8 c_Icms_Deson%Rowtype;
    --
    Cursor c_Iss_Ret Is
      Select Abs(Sum(Cfatit.Tax_Amount)) Vl_Ret_Iss
        From Cll_F255_Ar_Total_Inv_Taxes_v Cfatit
       Where 1 = 1
         And Cfatit.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfatit.Arvt_Global_Attribute2 = 'Y'
         And Cfatit.Arvt_Global_Attribute10 = 'ISS'
         And Cfatit.Arvt_Global_Attribute11 = 'Y' Having
       Nvl(Abs(Sum(Cfatit.Tax_Amount)), 0) > 0;
    R9 c_Iss_Ret%Rowtype;
    --
    Cursor c_Vl_Bc_Is Is
      Select Abs(Sum(Cfatit.Taxable_Amt)) Vl_Bc_Is
        From Cll_F255_Ar_Total_Inv_Taxes_v Cfatit
       Where 1 = 1
         And Cfatit.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfatit.Arvt_Global_Attribute2 = 'Y'
         And Cfatit.Arvt_Global_Attribute10 = 'IS' Having
       Nvl(Abs(Sum(Cfatit.Taxable_Amt)), 0) > 0;
    R10 c_Vl_Bc_Is%Rowtype;
    --
    Cursor c_Vl_Imp_Is Is
      Select Abs(Sum(Cfatit.Tax_Amount)) Vl_Imp_Is
        From Cll_F255_Ar_Total_Inv_Taxes_v Cfatit
       Where 1 = 1
         And Cfatit.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfatit.Arvt_Global_Attribute2 = 'Y'
         And Cfatit.Arvt_Global_Attribute10 = 'IS' Having
       Nvl(Abs(Sum(Cfatit.Tax_Amount)), 0) > 0;
    R11 c_Vl_Imp_Is%Rowtype;
    --
    Cursor c_Vl_Bc_Ibs_Cbs Is
      Select Distinct Abs(t.Taxable_Amt) As Vl_Bc_Ibs_Cbs
        From Cll_F255_Ar_Total_Inv_Taxes_v t
       Where t.Customer_Trx_Id = p_Customer_Trx_Id
         And t.Arvt_Global_Attribute2 = 'Y'
         And t.Arvt_Global_Attribute10 In ('IBSUF', 'CBS')
         And t.Taxable_Amt Is Not Null
         And t.Taxable_Amt <> 0;
    R12 c_Vl_Bc_Ibs_Cbs%Rowtype;
    --
    Cursor c_Vl_Imp_Trib_Mun Is
      Select Abs(Sum(Cfatit.Tax_Amount)) Vl_Imp_Trib_Mun
        From Cll_F255_Ar_Total_Inv_Taxes_v Cfatit
       Where 1 = 1
         And Cfatit.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfatit.Arvt_Global_Attribute2 = 'Y'
         And Cfatit.Arvt_Global_Attribute10 = 'IBSMUN' Having
       Nvl(Abs(Sum(Cfatit.Tax_Amount)), 0) > 0;
    R13 c_Vl_Imp_Trib_Mun%Rowtype;
    --
    Cursor c_Vl_Imp_Trib_Ibs Is
      Select Abs(Sum(Cfatit.Tax_Amount)) Vl_Imp_Trib_Ibs
        From Cll_F255_Ar_Total_Inv_Taxes_v Cfatit
       Where 1 = 1
         And Cfatit.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfatit.Arvt_Global_Attribute2 = 'Y'
         And Cfatit.Arvt_Global_Attribute10 In ('IBSUF', 'IBSMUN')
       Having Nvl(Abs(Sum(Cfatit.Tax_Amount)), 0) > 0;
    R14 c_Vl_Imp_Trib_Ibs%Rowtype;
    --
    Cursor c_Vl_Imp_Trib_Cbs Is
      Select Abs(Sum(Cfatit.Tax_Amount)) Vl_Imp_Trib_Cbs
        From Cll_F255_Ar_Total_Inv_Taxes_v Cfatit
       Where 1 = 1
         And Cfatit.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfatit.Arvt_Global_Attribute2 = 'Y'
         And Cfatit.Arvt_Global_Attribute10 = 'CBS' Having
       Nvl(Abs(Sum(Cfatit.Tax_Amount)), 0) > 0;
    R15 c_Vl_Imp_Trib_Cbs%Rowtype;
    --
    Cursor c_Vl_Imp_Trib_Uf Is
      Select Abs(Sum(Cfatit.Tax_Amount)) Vl_Imp_Trib_Uf
        From Cll_F255_Ar_Total_Inv_Taxes_v Cfatit
       Where 1 = 1
         And Cfatit.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfatit.Arvt_Global_Attribute2 = 'Y'
         And Cfatit.Arvt_Global_Attribute10 = 'IBSUF' Having
       Nvl(Abs(Sum(Cfatit.Tax_Amount)), 0) > 0;
    R16 c_Vl_Imp_Trib_Uf%Rowtype;
    --    
  Begin
    Open c_Icms_d;
    Loop
      Fetch c_Icms_d
        Into R1;
      Exit When c_Icms_d%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_ICMS_UF_DEST'
          ,(R1.Vl_Icms_Uf_Dest * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_ICMS_UF_DEST) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Icms_d;
    --
    --
    Open c_Icms_r;
    Loop
      Fetch c_Icms_r
        Into R2;
      Exit When c_Icms_r%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_ICMS_UF_REMET'
          ,(R2.Vl_Icms_Uf_Remet * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_ICMS_UF_REMET) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
    End Loop;
    Close c_Icms_r;
    --
    Open c_Icms_p;
    Loop
      Fetch c_Icms_p
        Into R3;
      Exit When c_Icms_p%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_COMB_POBR_UF_DEST'
          ,(R3.Vl_Comb_Pobr_Uf_Dest * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_COMB_POBR_UF_DEST) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Icms_p;
    --
    Open c_Fcp_p;
    Loop
      Fetch c_Fcp_p
        Into R4;
      Exit When c_Fcp_p%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_FCP'
          ,(R4.Vl_Fcp * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_FCP) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Fcp_p;
    --
    Open c_Fcp_St_p;
    Loop
      Fetch c_Fcp_St_p
        Into R5;
      Exit When c_Fcp_St_p%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_FCP_ST'
          ,(R5.Vl_Fcp_St * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_FCP_ST) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Fcp_St_p;
    --
    Open c_Fcp_St_Ret_p;
    Loop
      Fetch c_Fcp_St_Ret_p
        Into R6;
      Exit When c_Fcp_St_Ret_p%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_FCP_ST_RET'
          ,(R6.Vl_Fcp_St_Ret * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_FCP_ST_RET) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Fcp_St_Ret_p;
    --
    Open c_Ipi_Devol;
    Loop
      Fetch c_Ipi_Devol
        Into R7;
      Exit When c_Ipi_Devol%Notfound;
      --
      If p_Dm_Fin_Nfe = 4
      Then
        --
        Begin
          Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Atributo
            ,Valor)
          Values
            (p_Rvcnft.Cpf_Cnpj_Emit
            ,p_Rvcnft.Dm_Ind_Emit
            ,p_Rvcnft.Dm_Ind_Oper
            ,p_Rvcnft.Cod_Part
            ,p_Rvcnft.Cod_Mod
            ,p_Rvcnft.Serie
            ,p_Rvcnft.Nro_Nf
            ,'VL_IPI_DEVOL'
            ,(R7.Vl_Ipi_Devol * 100));
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IPI_DEVOL) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                           p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
      End If;
      --
    End Loop;
    Close c_Ipi_Devol;
    --
    Open c_Icms_Deson;
    Loop
      Fetch c_Icms_Deson
        Into R8;
      Exit When c_Icms_Deson%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_ICMS_DESON'
          ,(R8.Vl_Icms_Deson * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_ICMS_DESON) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Icms_Deson;
    --
    Open c_Iss_Ret;
    Loop
      Fetch c_Iss_Ret
        Into R9;
      Exit When c_Iss_Ret%Notfound;
      --
      If p_Rvcnft.Vl_Total_Serv > 0
      Then
        --
        Begin
          Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Atributo
            ,Valor)
          Values
            (p_Rvcnft.Cpf_Cnpj_Emit
            ,p_Rvcnft.Dm_Ind_Emit
            ,p_Rvcnft.Dm_Ind_Oper
            ,p_Rvcnft.Cod_Part
            ,p_Rvcnft.Cod_Mod
            ,p_Rvcnft.Serie
            ,p_Rvcnft.Nro_Nf
            ,'VL_RET_ISS'
            ,(R9.Vl_Ret_Iss * 100));
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_RET_ISS) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                           p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
      End If;
      --
    End Loop;
    Close c_Iss_Ret;
    --
    Open c_Vl_Bc_Is;
    Loop
      Fetch c_Vl_Bc_Is
        Into R10;
      Exit When c_Vl_Bc_Is%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_BC_IS'
          ,(R10.Vl_Bc_Is * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_BC_IS) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Vl_Bc_Is;
    --
    Open c_Vl_Imp_Is;
    Loop
      Fetch c_Vl_Imp_Is
        Into R11;
      Exit When c_Vl_Imp_Is%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_IMP_IS'
          ,(R11.Vl_Imp_Is * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_IS) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Vl_Imp_Is;
    --
    Open c_Vl_Bc_Ibs_Cbs;
    Loop
      Fetch c_Vl_Bc_Ibs_Cbs
        Into R12;
      Exit When c_Vl_Bc_Ibs_Cbs%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_BC_IBS_CBS'
          ,(R12.Vl_Bc_Ibs_Cbs * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_BC_IBS_CBS) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Vl_Bc_Ibs_Cbs;
    --
    Open c_Vl_Imp_Trib_Mun;
    Loop
      Fetch c_Vl_Imp_Trib_Mun
        Into R13;
      Exit When c_Vl_Imp_Trib_Mun%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_IMP_TRIB_MUN'
          ,(R13.Vl_Imp_Trib_Mun * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_TRIB_MUN) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Vl_Imp_Trib_Mun;
    --
    Open c_Vl_Imp_Trib_Ibs;
    Loop
      Fetch c_Vl_Imp_Trib_Ibs
        Into R14;
      Exit When c_Vl_Imp_Trib_Ibs%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_IMP_TRIB_IBS'
          ,(R14.Vl_Imp_Trib_Ibs * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_TRIB_IBS) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Vl_Imp_Trib_Ibs;
    --
    Open c_Vl_Imp_Trib_Cbs;
    Loop
      Fetch c_Vl_Imp_Trib_Cbs
        Into R15;
      Exit When c_Vl_Imp_Trib_Cbs%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_IMP_TRIB_CBS'
          ,(R15.Vl_Imp_Trib_Cbs * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_TRIB_CBS) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Vl_Imp_Trib_Cbs;
    --
    Open c_Vl_Imp_Trib_Uf;
    Loop
      Fetch c_Vl_Imp_Trib_Uf
        Into R16;
      Exit When c_Vl_Imp_Trib_Uf%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnft.Cpf_Cnpj_Emit
          ,p_Rvcnft.Dm_Ind_Emit
          ,p_Rvcnft.Dm_Ind_Oper
          ,p_Rvcnft.Cod_Part
          ,p_Rvcnft.Cod_Mod
          ,p_Rvcnft.Serie
          ,p_Rvcnft.Nro_Nf
          ,'VL_IMP_TRIB_UF'
          ,(R16.Vl_Imp_Trib_Uf * 100));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_TRIB_UF) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnft.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnft.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnft.Cod_Mod || ', Serie: ' ||
                         p_Rvcnft.Serie || ', Nro_Nf: ' || p_Rvcnft.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close c_Vl_Imp_Trib_Uf;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P - ' || ' Erro: ' ||
                     Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Total_Ff_p;

  ---
  ----------------------------------------------------------------------------
  -- Procedure Custom para inclusão de dados na Vw_Csf_Nota_Fiscal_Total_ff --
  ----------------------------------------------------------------------------
  Procedure Vw_Csf_Nf_Total_Ff_Custom_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                       ,p_Customer_Trx_Id Number
                                        ---                                       ,p_Dm_Fin_Nfe      Number
                                       ,p_Rotina Varchar2) Is
    --
    l_Desc_Erro        Varchar2(4000);
    l_Rvcnftf          Vw_Csf_Nota_Fiscal_Total_Ff%Rowtype;
    l_Bc_Ibs_Cbs       Number;
    l_Valor_Ibs        Number;
    l_Valor_Cbs        Number;
    l_Vl_Imp_Difer_Uf  Number;
    l_Vl_Imp_Difer_Mun Number;
    l_Vl_Imp_Difer_Cbs Number;
    l_Ncount           Number;
    --
  Begin
    Begin
      Select Count(1)
        Into l_Ncount
        From Ra_Customer_Trx_All   Rcta
            ,Ra_Cust_Trx_Types_All Rctt
            ,Fnd_Lookup_Values     Flv
       Where Rcta.Customer_Trx_Id = p_Customer_Trx_Id
         And Rctt.Cust_Trx_Type_Id = Rcta.Cust_Trx_Type_Id
         And Flv.Lookup_Type = 'XXISV_CSF_ALQ_CBSIBS_CLASSTRIB'
         And Flv.Language = Userenv('LANG')
         And Flv.Lookup_Code = Nvl(Rctt.Global_Attribute7, Rctt.Attribute6)
         And Flv.Enabled_Flag = 'Y'
         And Rcta.Trx_Date Between Flv.Start_Date_Active And
             Nvl(Flv.End_Date_Active, Sysdate);
    Exception
      When Others Then
        l_Ncount := 0;
    End;
    If l_Ncount > 0
    Then
      ---Verifica se tem o atributo VL_BC_IBS_CBS na tabela Vw_Csf_Nota_Fiscal_Total_Ff
      Begin
        Select *
          Into l_Rvcnftf
          From Vw_Csf_Nota_Fiscal_Total_Ff
         Where 1 = 1
           And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
           And Cod_Part = p_Rvcnf.Cod_Part
           And Cod_Mod = p_Rvcnf.Cod_Mod
           And Serie = p_Rvcnf.Serie
           And Nro_Nf = p_Rvcnf.Nro_Nf
           And Atributo = 'VL_BC_IBS_CBS'; ---12
      Exception
        When Too_Many_Rows Then -- Carranza 08/09/2026: ja existe mais de uma linha, nao reinserir
          Null;
        When No_Data_Found Then
          ---se não tem o atributo VL_BC_IBS_CBS na tabela Vw_Csf_Nota_Fiscal_Total_Ff, 
          ---buscar os dados na Vw_Csf_Imp_Itemnf para incluir na tabela TOTAL_FF
          Begin
            Select Nvl(Sum(Nvl(Vl_Base_Calc, 0)), 0)
              Into l_Bc_Ibs_Cbs
              From Vw_Csf_Imp_Itemnf
             Where 1 = 1
               And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
               And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
               And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
               And Cod_Part = p_Rvcnf.Cod_Part
               And Cod_Mod = p_Rvcnf.Cod_Mod
               And Serie = p_Rvcnf.Serie
               And Nro_Nf = p_Rvcnf.Nro_Nf
               And Cod_Imposto = 28;
          Exception
            When Others Then
              l_Bc_Ibs_Cbs := 0;
          End;
          Begin
            Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Atributo
              ,Valor)
            Values
              (p_Rvcnf.Cpf_Cnpj_Emit
              ,p_Rvcnf.Dm_Ind_Emit
              ,p_Rvcnf.Dm_Ind_Oper
              ,p_Rvcnf.Cod_Part
              ,p_Rvcnf.Cod_Mod
              ,p_Rvcnf.Serie
              ,p_Rvcnf.Nro_Nf
              ,'VL_BC_IBS_CBS'
              ,(l_Bc_Ibs_Cbs * 100));
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_BC_IBS_CBS) - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                             ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                             ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                             p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                             ', Erro: ' || Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
      End;
      --          ,'VL_IMP_TRIB_MUN'
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Atributo
          ,Valor)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,'VL_IMP_TRIB_MUN'
          ,'0');
      End;
      ---Verifica se tem o atributo VL_IMP_TRIB_IBS na tabela Vw_Csf_Nota_Fiscal_Total_Ff
      Begin
        Select *
          Into l_Rvcnftf
          From Vw_Csf_Nota_Fiscal_Total_Ff
         Where 1 = 1
           And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
           And Cod_Part = p_Rvcnf.Cod_Part
           And Cod_Mod = p_Rvcnf.Cod_Mod
           And Serie = p_Rvcnf.Serie
           And Nro_Nf = p_Rvcnf.Nro_Nf
           And Atributo = 'VL_IMP_TRIB_IBS'; ---14
      Exception
        When Too_Many_Rows Then -- Carranza 08/09/2026: ja existe mais de uma linha, nao reinserir
          Null;
        When No_Data_Found Then
          ---se não tem o atributo VL_IMP_TRIB_IBS na tabela Vw_Csf_Nota_Fiscal_Total_Ff, 
          ---buscar os dados na Vw_Csf_Imp_Itemnf para incluir na tabela TOTAL_FF
          Begin
            ---Select nvl(sum(nvl(Vl_Imp_Trib,0)),0)
            Select Nvl(Sum(Nvl((Case
                                 When Cod_St = '515' Then
                                  0
                                 Else
                                  Vl_Imp_Trib
                               End), 0)), 0)
              Into l_Valor_Ibs
              From Vw_Csf_Imp_Itemnf
             Where 1 = 1
               And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
               And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
               And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
               And Cod_Part = p_Rvcnf.Cod_Part
               And Cod_Mod = p_Rvcnf.Cod_Mod
               And Serie = p_Rvcnf.Serie
               And Nro_Nf = p_Rvcnf.Nro_Nf
               And Cod_Imposto = 28;
          Exception
            When Others Then
              l_Valor_Ibs := 0;
          End;
          Begin
            Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Atributo
              ,Valor)
            Values
              (p_Rvcnf.Cpf_Cnpj_Emit
              ,p_Rvcnf.Dm_Ind_Emit
              ,p_Rvcnf.Dm_Ind_Oper
              ,p_Rvcnf.Cod_Part
              ,p_Rvcnf.Cod_Mod
              ,p_Rvcnf.Serie
              ,p_Rvcnf.Nro_Nf
              ,'VL_IMP_TRIB_IBS'
              ,(l_Valor_Ibs * 100));
            Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Atributo
              ,Valor)
            Values
              (p_Rvcnf.Cpf_Cnpj_Emit
              ,p_Rvcnf.Dm_Ind_Emit
              ,p_Rvcnf.Dm_Ind_Oper
              ,p_Rvcnf.Cod_Part
              ,p_Rvcnf.Cod_Mod
              ,p_Rvcnf.Serie
              ,p_Rvcnf.Nro_Nf
              ,'VL_IMP_TRIB_UF'
              ,(l_Valor_Ibs * 100));
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_TRIB_IBS) - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                             ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                             ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                             p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                             ', Erro: ' || Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
      End;
      ---Verifica se tem o atributo VL_IMP_TRIB_CBS na tabela Vw_Csf_Nota_Fiscal_Total_Ff
      Begin
        Select *
          Into l_Rvcnftf
          From Vw_Csf_Nota_Fiscal_Total_Ff
         Where 1 = 1
           And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
           And Cod_Part = p_Rvcnf.Cod_Part
           And Cod_Mod = p_Rvcnf.Cod_Mod
           And Serie = p_Rvcnf.Serie
           And Nro_Nf = p_Rvcnf.Nro_Nf
           And Atributo = 'VL_IMP_TRIB_CBS'; ---15
      Exception
        When Too_Many_Rows Then -- Carranza 08/09/2026: ja existe mais de uma linha, nao reinserir
          Null;
        When No_Data_Found Then
          ---se não tem o atributo VL_IMP_TRIB_CBS na tabela Vw_Csf_Nota_Fiscal_Total_Ff, 
          ---buscar os dados na Vw_Csf_Imp_Itemnf para incluir na tabela TOTAL_FF
          Begin
            ---Select nvl(sum(nvl(Vl_Imp_Trib,0)),0)
            Select Nvl(Sum(Nvl((Case
                                 When Cod_St = '515' Then
                                  0
                                 Else
                                  Vl_Imp_Trib
                               End), 0)), 0)
              Into l_Valor_Cbs
              From Vw_Csf_Imp_Itemnf
             Where 1 = 1
               And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
               And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
               And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
               And Cod_Part = p_Rvcnf.Cod_Part
               And Cod_Mod = p_Rvcnf.Cod_Mod
               And Serie = p_Rvcnf.Serie
               And Nro_Nf = p_Rvcnf.Nro_Nf
               And Cod_Imposto = 29;
          Exception
            When Others Then
              l_Valor_Cbs := 0;
          End;
          Begin
            Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Atributo
              ,Valor)
            Values
              (p_Rvcnf.Cpf_Cnpj_Emit
              ,p_Rvcnf.Dm_Ind_Emit
              ,p_Rvcnf.Dm_Ind_Oper
              ,p_Rvcnf.Cod_Part
              ,p_Rvcnf.Cod_Mod
              ,p_Rvcnf.Serie
              ,p_Rvcnf.Nro_Nf
              ,'VL_IMP_TRIB_CBS'
              ,(l_Valor_Cbs * 100));
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_TRIB_CBS) - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                             ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                             ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                             p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                             ', Erro: ' || Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
      End;
      --- VL_IMP_DIFER_UF nota_fiscal_total_ff - somar da imp_itemnf_ff
      ---Verifica se tem o atributo VL_IMP_DIFER_UF na tabela Vw_Csf_Nota_Fiscal_Total_Ff
      Begin
        Select *
          Into l_Rvcnftf
          From Vw_Csf_Nota_Fiscal_Total_Ff
         Where 1 = 1
           And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
           And Cod_Part = p_Rvcnf.Cod_Part
           And Cod_Mod = p_Rvcnf.Cod_Mod
           And Serie = p_Rvcnf.Serie
           And Nro_Nf = p_Rvcnf.Nro_Nf
           And Atributo = 'VL_IMP_DIFER_UF';
      Exception
        When Too_Many_Rows Then -- Carranza 08/09/2026: ja existe mais de uma linha, nao reinserir
          Null;
        When No_Data_Found Then
          ---se não tem o atributo VL_IMP_TRIB_UF na tabela Vw_Csf_Nota_Fiscal_Total_Ff, 
          ---buscar os dados na Vw_Csf_Imp_Itemnf para incluir na tabela TOTAL_FF
          Begin
            Select Nvl(Sum(Nvl(Valor, 0)), 0)
              Into l_Vl_Imp_Difer_Uf
              From Vw_Csf_Imp_Itemnf_Ff
             Where 1 = 1
               And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
               And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
               And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
               And Cod_Part = p_Rvcnf.Cod_Part
               And Cod_Mod = p_Rvcnf.Cod_Mod
               And Serie = p_Rvcnf.Serie
               And Nro_Nf = p_Rvcnf.Nro_Nf
               And Cod_Imposto = 28
               And Atributo = 'VL_IMP_DIFER_UF';
          Exception
            When Others Then
              l_Vl_Imp_Difer_Uf := 0;
          End;
          ---If l_VL_IMP_DIFER_UF > 0 Then
          Begin
            Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Atributo
              ,Valor)
            Values
              (p_Rvcnf.Cpf_Cnpj_Emit
              ,p_Rvcnf.Dm_Ind_Emit
              ,p_Rvcnf.Dm_Ind_Oper
              ,p_Rvcnf.Cod_Part
              ,p_Rvcnf.Cod_Mod
              ,p_Rvcnf.Serie
              ,p_Rvcnf.Nro_Nf
              ,'VL_IMP_DIFER_UF'
              ,l_Vl_Imp_Difer_Uf);
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_DIFER_UF) - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                             ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                             ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                             p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                             ', Erro: ' || Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
          ---End If;
      End;
      --- VL_IMP_DIFER_MUN nota_fiscal_total_ff - somar da imp_itemnf_ff
      ---Verifica se tem o atributo VL_IMP_DIFER_MUN na tabela Vw_Csf_Nota_Fiscal_Total_Ff
      Begin
        Select *
          Into l_Rvcnftf
          From Vw_Csf_Nota_Fiscal_Total_Ff
         Where 1 = 1
           And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
           And Cod_Part = p_Rvcnf.Cod_Part
           And Cod_Mod = p_Rvcnf.Cod_Mod
           And Serie = p_Rvcnf.Serie
           And Nro_Nf = p_Rvcnf.Nro_Nf
           And Atributo = 'VL_IMP_DIFER_MUN';
      Exception
        When Too_Many_Rows Then -- Carranza 08/09/2026: ja existe mais de uma linha, nao reinserir
          Null;
        When No_Data_Found Then
          ---se não tem o atributo VL_IMP_TRIB_MUN na tabela Vw_Csf_Nota_Fiscal_Total_Ff, 
          ---buscar os dados na Vw_Csf_Imp_Itemnf para incluir na tabela TOTAL_FF
          Begin
            Select Nvl(Sum(Nvl(Valor, 0)), 0)
              Into l_Vl_Imp_Difer_Mun
              From Vw_Csf_Imp_Itemnf_Ff
             Where 1 = 1
               And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
               And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
               And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
               And Cod_Part = p_Rvcnf.Cod_Part
               And Cod_Mod = p_Rvcnf.Cod_Mod
               And Serie = p_Rvcnf.Serie
               And Nro_Nf = p_Rvcnf.Nro_Nf
               And Cod_Imposto = 28
               And Atributo = 'VL_IMP_DIFER_MUN';
          Exception
            When Others Then
              l_Vl_Imp_Difer_Mun := 0;
          End;
          ---If l_VL_IMP_DIFER_MUN > 0 Then
          Begin
            Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Atributo
              ,Valor)
            Values
              (p_Rvcnf.Cpf_Cnpj_Emit
              ,p_Rvcnf.Dm_Ind_Emit
              ,p_Rvcnf.Dm_Ind_Oper
              ,p_Rvcnf.Cod_Part
              ,p_Rvcnf.Cod_Mod
              ,p_Rvcnf.Serie
              ,p_Rvcnf.Nro_Nf
              ,'VL_IMP_DIFER_MUN'
              ,l_Vl_Imp_Difer_Mun);
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_DIFER_MUN) - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                             ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                             ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                             p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                             ', Erro: ' || Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
          ---End If;
      End;
      --- VL_IMP_DIFER_CBS nota_fiscal_total_ff - somar da imp_itemnf_ff
      ---Verifica se tem o atributo VL_IMP_DIFER_CBS na tabela Vw_Csf_Nota_Fiscal_Total_Ff
      Begin
        Select *
          Into l_Rvcnftf
          From Vw_Csf_Nota_Fiscal_Total_Ff
         Where 1 = 1
           And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
           And Cod_Part = p_Rvcnf.Cod_Part
           And Cod_Mod = p_Rvcnf.Cod_Mod
           And Serie = p_Rvcnf.Serie
           And Nro_Nf = p_Rvcnf.Nro_Nf
           And Atributo = 'VL_IMP_DIFER_CBS';
      Exception
        When Too_Many_Rows Then -- Carranza 08/09/2026: ja existe mais de uma linha, nao reinserir
          Null;
        When No_Data_Found Then
          ---se não tem o atributo VL_IMP_TRIB_MUN na tabela Vw_Csf_Nota_Fiscal_Total_Ff, 
          ---buscar os dados na Vw_Csf_Imp_Itemnf para incluir na tabela TOTAL_FF
          Begin
            Select Nvl(Sum(Nvl(Valor, 0)), 0)
              Into l_Vl_Imp_Difer_Cbs
              From Vw_Csf_Imp_Itemnf_Ff
             Where 1 = 1
               And Cpf_Cnpj_Emit = p_Rvcnf.Cpf_Cnpj_Emit
               And Dm_Ind_Emit = p_Rvcnf.Dm_Ind_Emit
               And Dm_Ind_Oper = p_Rvcnf.Dm_Ind_Oper
               And Cod_Part = p_Rvcnf.Cod_Part
               And Cod_Mod = p_Rvcnf.Cod_Mod
               And Serie = p_Rvcnf.Serie
               And Nro_Nf = p_Rvcnf.Nro_Nf
               And Cod_Imposto = 29
               And Atributo = 'VL_IMP_DIFER_UF';
          Exception
            When Others Then
              l_Vl_Imp_Difer_Cbs := 0;
          End;
          ---If l_VL_IMP_DIFER_CBS > 0 Then
          Begin
            Insert Into Vw_Csf_Nota_Fiscal_Total_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Atributo
              ,Valor)
            Values
              (p_Rvcnf.Cpf_Cnpj_Emit
              ,p_Rvcnf.Dm_Ind_Emit
              ,p_Rvcnf.Dm_Ind_Oper
              ,p_Rvcnf.Cod_Part
              ,p_Rvcnf.Cod_Mod
              ,p_Rvcnf.Serie
              ,p_Rvcnf.Nro_Nf
              ,'VL_IMP_DIFER_CBS'
              ,l_Vl_Imp_Difer_Cbs);
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TOTAL_FF_P (VL_IMP_DIFER_CBS) - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                             ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                             ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                             p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                             ', Erro: ' || Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
          ---End If;
      End;
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NF_TOTAL_FF_CUSTOM_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nf_Total_Ff_Custom_p;

  ---
  ------------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Referen --
  ------------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Referen_p(p_Rvcnf               Vw_Csf_Nota_Fiscal%Rowtype
                                        ,p_Customer_Trx_Id     Number
                                        ,p_Customer_Trx_Id_Ref Number
                                        ,p_Rotina              Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    x_Retorno   Number;
    --
    Cursor C6 Is
    /*Referencia de Notas de Venda/Complementar do AR*/
      Select Cfai.Electronic_Inv_Access_Key Nro_Chave_Nfe_Ref
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Uf_Ibge_Emit_f(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Warehouse_Id_f(Rcta.Customer_Trx_Id)) Ibge_Estado_Emit_Ref
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cpf_Cnpj_Emit_f(Hou.Location_Id, Rcta.Legal_Entity_Id, 'FEDERAL_TAX') Cnpj_Emit_Ref
            ,To_Date(Cfai.Trx_Date, 'dd/mm/rrrr') Dt_Emiss_Ref
            ,Substr(To_Char(Cfai.Rbs_Global_Attribute6), 1, 2) Cod_Mod_Ref
            ,Substr(To_Number(Cfai.Trx_Number), 1, 9) Nro_Nf_Ref
            ,Substr(To_Char(Cfai.Series), 1, 3) Serie_Ref
            ,Substr(To_Char(Cfai.Sub_Series), 1, 3) Subserie_Ref
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Part_f(Cfai.Bill_To_Site_Use_Id) Cod_Part_Ref
            ,Case
               When Cfai.Movement_In_Out = 'ENTRY' Then
                0
               When Cfai.Movement_In_Out = 'EXIT' Then
                1
             End Dm_Ind_Oper_Ref
            ,0 Dm_Ind_Emit_Ref
            ,(Select To_Char(Substr(Replace(Replace((Cfac.Ie), '.', ''), '-', ''), 1, 14))
                From Cll_F255_Ar_Customers_v Cfac
               Where 1 = 1
                 And Cfac.Site_Use_Id = Rcta.Ship_To_Site_Use_Id
                 And Cfac.Ie Is Not Null
                 And Rownum = 1) Ie_Ref
        From Cll_F255_Ar_Invoices_v    Cfai
            ,Ra_Customer_Trx_All       Rcta
            ,Hr_All_Organization_Units Hou
       Where 1 = 1
         And Cfai.Customer_Trx_Id = Rcta.Customer_Trx_Id
         And Hou.Organization_Id =
             Xxisv_Csf_Nfe_Pkg.Get_Nfe_Warehouse_Id_f(Rcta.Customer_Trx_Id)
         And Cfai.Electronic_Inv_Status In (2, 7) /*2-Finalizada / 7-Emissao Contingencia*/
         And Cfai.Status_Trx <> 'VD'
         And Cfai.Customer_Trx_Id = p_Customer_Trx_Id_Ref
      --
      Union
      --
      /*Referencia de Notas de Devolucao de Compras RI*/
      Select (Select a.Eletronic_Invoice_Key
                From Apps.Cll_F255_Ri_Invoices_v a
               Where a.Invoice_Id = Cfip.Invoice_Parent_Id) Nro_Chave_Nfe_Ref
            ,Substr((Select c.Identifier_Value
                      From Cll_F255_Po_Suppliers_v  a
                          ,Hz_Geographies           b
                          ,Hz_Geography_Identifiers c
                     Where 1 = 1
                       And a.City = b.Geography_Name
                       And a.State = b.Geography_Element2
                       And b.Geography_Id = c.Geography_Id
                       And a.Vendor_Site_Id = Cfri.Vendor_Site_Id
                       And c.Identifier_Subtype = 'IBGE'), 1, 2) Ibge_Estado_Emit_Ref
            ,(Select Substr(a.Document_Number, 1, 14)
                From Cll_F189_Fiscal_Entities_All a
               Where a.Entity_Id = Cfri.Entity_Id) Cnpj_Emit_Ref
            ,(Select To_Date(a.Invoice_Date, 'DD/MM/RRRR')
                From Apps.Cll_F255_Ri_Invoices_v a
               Where a.Invoice_Id = Cfip.Invoice_Parent_Id) Dt_Emiss_Ref
            ,(Select Decode(a.Fiscal_Document_Model, '55', '55', 'NFE', '55', 'NF', '01', 'NFF', '01', 'NFCEE', '06', 'NFFSC', '21', 'NFSTE', '22', 'NFST', '07', 'NFFST', '07', 'CTRC', '08', 'CTAC', '09', 'CA', '10', 'CTFC', '11', 'CT-E', '57', 'NFS', '99', '1B', '55')
                From Apps.Cll_F255_Ri_Invoices_v a
               Where a.Invoice_Id = Cfip.Invoice_Parent_Id) Cod_Mod_Ref
            ,(Select Substr(To_Number(Trunc(a.Invoice_Num)), 1, 9) Nro_Nf_Ref
                From Apps.Cll_F255_Ri_Invoices_v a
               Where a.Invoice_Id = Cfip.Invoice_Parent_Id) Nro_Nf_Ref
            ,(Select Series
                From Apps.Cll_F255_Ri_Invoices_v a
               Where a.Invoice_Id = Cfip.Invoice_Parent_Id) Serie_Ref
            ,Null Subserie_Ref
             /*,(Select Io_Cnpj
              From Apps.Cll_F255_Ri_Invoices_v a
             Where a.Invoice_Id = Cfip.Invoice_Parent_Id) Cod_Part_Ref*/ -- Carranza 18/01/2019
            ,p_Rvcnf.Cod_Part Cod_Part_Ref -- Carranza 18/01/2019
            ,(Select Decode(Operation_Type, 'E', 0, 'S', 1)
                From Apps.Cll_F255_Ri_Invoices_v a
               Where a.Invoice_Id = Cfip.Invoice_Parent_Id) Dm_Ind_Oper_Ref
            ,1 Dm_Ind_Emit_Ref
            ,(Select To_Char(Substr(Replace(Replace((a.Ie), '.', ''), '-', ''), 1, 14))
                From Cll_F189_Fiscal_Entities_All a
               Where a.Entity_Id = Cfri.Entity_Id
                 And a.Ie Is Not Null) Ie_Ref
        From Ra_Customer_Trx_All           Rct
            ,Apps.Cll_F255_Ri_Invoices_v   Cfri
            ,Apps.Cll_F189_Invoice_Parents Cfip
       Where 1 = 1
         And Rct.Customer_Trx_Id = p_Customer_Trx_Id
         And Rct.Interface_Header_Attribute3 = Cfri.Invoice_Id
         And Cfri.Invoice_Id = Cfip.Invoice_Id
      --
      Union
      --
      /*Referencia de Notas de Devolucao de Compras RI feita manualmente no AR*/
      /*Select Cfri.Eletronic_Invoice_Key Nro_Chave_Nfe_Ref
           ,Substr((Select c.Identifier_Value
                     From Cll_F255_Po_Suppliers_v  a
                         ,Hz_Geographies           b
                         ,Hz_Geography_Identifiers c
                    Where 1 = 1
                      And a.City = b.Geography_Name
                      And a.State = b.Geography_Element2
                      And b.Geography_Id = c.Geography_Id
                      And a.Vendor_Site_Id = Cfri.Vendor_Site_Id
                      And c.Identifier_Subtype = 'IBGE'), 1, 2) Ibge_Estado_Emit_Ref
           ,Cfri.Document_Number Cnpj_Emit_Ref
           ,Cfri.Invoice_Date Dt_Emiss_Ref
           ,Cfri.Fiscal_Document_Model Cod_Mod_Ref
           ,Substr(To_Number(Trunc(Cfri.Invoice_Num)), 1, 9) Nro_Nf_Ref
           ,Cfri.Series Serie_Ref
           ,Null Subserie_Ref
           ,p_Rvcnf.Cod_Part Cod_Part_Ref
           ,Decode(Cfri.Operation_Type, 'E', 0, 'S', 1) Dm_Ind_Oper_Ref
           ,1 Dm_Ind_Emit_Ref
       From Ra_Customer_Trx_All         Rct
           ,Apps.Cll_F255_Ri_Invoices_v Cfri
           ,Ra_Customer_Trx_Lines_All   Rctl
      Where 1 = 1
        And Rct.Customer_Trx_Id = p_Customer_Trx_Id
        And Rctl.Attribute2 = Cfri.Invoice_Id
        And Rct.Customer_Trx_Id = Rctl.Customer_Trx_Id
        And Rctl.Line_Type = 'LINE'
        And Rctl.Attribute_Category = 'CSF - NF-e Devolução Compras';*/ -- Carranza 03/02/2021
      Select Cfri.Eletronic_Invoice_Key Nro_Chave_Nfe_Ref
            ,Substr(Cfri.Eletronic_Invoice_Key, 1, 2) Ibge_Estado_Emit_Ref
            ,Cffe.Document_Number Cnpj_Emit_Ref
            ,Cfri.Invoice_Date Dt_Emiss_Ref
            ,Cfri.Fiscal_Document_Model Cod_Mod_Ref
            ,Substr(To_Number(Trunc(Cfri.Invoice_Num)), 1, 9) Nro_Nf_Ref
            ,Cfri.Series Serie_Ref
            ,Null Subserie_Ref
            ,p_Rvcnf.Cod_Part Cod_Part_Ref
            ,Decode(Cfri.Operation_Type, 'E', 0, 'S', 1) Dm_Ind_Oper_Ref
            ,1 Dm_Ind_Emit_Ref
            ,To_Char(Substr(Replace(Replace((Cffe.Ie), '.', ''), '-', ''), 1, 14)) Ie_Ref
        From Ra_Customer_Trx_All          Rct
            ,Apps.Cll_F255_Ri_Invoices_v  Cfri
            ,Cll_F189_Fiscal_Entities_All Cffe
       Where 1 = 1
         And Rct.Customer_Trx_Id = p_Customer_Trx_Id
         And Cffe.Entity_Id = Cfri.Entity_Id
         And Rct.Attribute3 = Cfri.Invoice_Id
         And Rct.Attribute_Category = 'CSF - NF-e Devolução Compras';
    R6 C6%Rowtype;
    --
  Begin
    --
    /*Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Nota_Fiscal_Referen_p(p_Customer_Trx_Id => p_Customer_Trx_Id_Ref, p_Rotina => 'Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Nota_Fiscal_Ref_p', p_Retorno => x_Retorno); --- Ito 24/04/2018
    If x_Retorno = 0
    Then
      ---
      Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Nota_Fiscal_Referen_p(p_Customer_Trx_Id => p_Customer_Trx_Id, p_Rotina => 'Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Nota_Fiscal_Ref_p', p_Retorno => x_Retorno); --- Ito 24/04/2018
      If x_Retorno = 0
      Then*/ -- Carranza 26/10/2022
    --- Inicio Carranza 26/10/2022
    Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Nota_Fiscal_Referen_p(p_Rvcnf => p_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Customer_Trx_Id_Ref => p_Customer_Trx_Id_Ref, p_Rotina => 'Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Nota_Fiscal_Ref_p', p_Retorno => x_Retorno); --- Ito 24/04/2018
    If x_Retorno = 0
    Then
      --- Fim Carranza 26/10/2022
      ---
      Open C6;
      Loop
        Fetch C6
          Into R6;
        Exit When C6%Notfound;
        --
        Begin
          --
          Begin
            Insert Into Vw_Csf_Nota_Fiscal_Referen
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Nro_Chave_Nfe_Ref
              ,Ibge_Estado_Emit_Ref
              ,Cnpj_Emit_Ref
              ,Dt_Emiss_Ref
              ,Cod_Mod_Ref
              ,Nro_Nf_Ref
              ,Serie_Ref
              ,Subserie_Ref
              ,Cod_Part_Ref
              ,Dm_Ind_Oper_Ref
              ,Dm_Ind_Emit_Ref)
            Values
              (p_Rvcnf.Cpf_Cnpj_Emit
              ,p_Rvcnf.Dm_Ind_Emit
              ,p_Rvcnf.Dm_Ind_Oper
              ,p_Rvcnf.Cod_Part
              ,p_Rvcnf.Cod_Mod
              ,p_Rvcnf.Serie
              ,p_Rvcnf.Nro_Nf
              ,R6.Nro_Chave_Nfe_Ref
              ,R6.Ibge_Estado_Emit_Ref
              ,R6.Cnpj_Emit_Ref
              ,R6.Dt_Emiss_Ref
              ,R6.Cod_Mod_Ref
              ,R6.Nro_Nf_Ref
              ,R6.Serie_Ref
              ,R6.Subserie_Ref
              ,R6.Cod_Part_Ref
              ,R6.Dm_Ind_Oper_Ref
              ,R6.Dm_Ind_Emit_Ref);
          End;
          --
          Commit;
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_REFEREN_P - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                           p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
        If R6.Ie_Ref Is Not Null
        Then
          --
          Begin
            --
            Begin
              Insert Into Vw_Csf_Nota_Fiscal_Referen_Ff
                (Cpf_Cnpj_Emit
                ,Dm_Ind_Emit
                ,Dm_Ind_Oper
                ,Cod_Part
                ,Cod_Mod
                ,Serie
                ,Nro_Nf
                ,Nro_Chave_Nfe_Ref
                ,Ibge_Estado_Emit_Ref
                ,Cnpj_Emit_Ref
                ,Dt_Emiss_Ref
                ,Cod_Mod_Ref
                ,Nro_Nf_Ref
                ,Serie_Ref
                ,Subserie_Ref
                ,Cod_Part_Ref
                ,Dm_Ind_Oper_Ref
                ,Dm_Ind_Emit_Ref
                ,Atributo
                ,Valor)
              Values
                (p_Rvcnf.Cpf_Cnpj_Emit
                ,p_Rvcnf.Dm_Ind_Emit
                ,p_Rvcnf.Dm_Ind_Oper
                ,p_Rvcnf.Cod_Part
                ,p_Rvcnf.Cod_Mod
                ,p_Rvcnf.Serie
                ,p_Rvcnf.Nro_Nf
                ,R6.Nro_Chave_Nfe_Ref
                ,R6.Ibge_Estado_Emit_Ref
                ,R6.Cnpj_Emit_Ref
                ,R6.Dt_Emiss_Ref
                ,R6.Cod_Mod_Ref
                ,R6.Nro_Nf_Ref
                ,R6.Serie_Ref
                ,R6.Subserie_Ref
                ,R6.Cod_Part_Ref
                ,R6.Dm_Ind_Oper_Ref
                ,R6.Dm_Ind_Emit_Ref
                ,'IE_REF'
                ,R6.Ie_Ref);
            End;
            --
            Commit;
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_REFEREN_P - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                             ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                             ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                             p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                             ', Erro: ' || Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
          --
        End If;
        --
      End Loop;
      Close C6;
      ---
    End If;
    ---
    --End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_REFEREN_P - ' || ' Erro: ' ||
                     Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Referen_p;

  ---
  ------------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_NFInfor_Adic --
  ------------------------------------------------------------------------------
  Procedure Vw_Csf_Nfinfor_Adic_p(p_Rvcnf                    Vw_Csf_Nota_Fiscal%Rowtype
                                 ,p_Customer_Trx_Id          Number
                                 ,p_Comments                 Varchar2
                                 ,p_Legal_Process_Source_Ind Varchar2
                                 ,p_Rotina                   Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    l_Conteudo  Varchar2(4000);
    --
  Begin
    --
    Xxisv_Csf_Nfe_Pkg.Get_Nfe_Nfinfor_Adic_p(p_Customer_Trx_Id => p_Customer_Trx_Id, p_Comments => p_Comments, p_Legal_Process_Source_Ind => p_Legal_Process_Source_Ind, p_Conteudo => l_Conteudo);
    --
    If Length(l_Conteudo) >= 10
    Then
      l_Conteudo := Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(l_Conteudo);
      Begin
        Insert Into Vw_Csf_Nfinfor_Adic
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Dm_Tipo
          ,Campo
          ,Conteudo
          ,Orig_Proc)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,0
          ,Null
          ,l_Conteudo
          ,Nvl(Substr(p_Legal_Process_Source_Ind, 1, 1), '0'));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NFINFOR_ADIC_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                         ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NFINFOR_ADIC_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nfinfor_Adic_p;

  ---
  ------------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Cobr --
  ------------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Cobr_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                     ,p_Customer_Trx_Id Number
                                     ,p_Rotina          Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C6 Is
      Select Sum(Nvl(Apsa.Amount_Due_Original, 0)) Vl_Orig
            ,Sum(Nvl(Apsa.Discount_Original, 0)) Vl_Desc
        From Ar_Payment_Schedules_All Apsa
       Where 1 = 1
         And Apsa.Customer_Trx_Id = p_Customer_Trx_Id
         And p_Rvcnf.Dm_Ind_Pag <> 0 /*Incluida essa condiçao para nao ocorrer erro na Gia-DF*/
       Having Sum(Nvl(Apsa.Amount_Due_Original, 0)) > 0; -- Carranza 24/09/2025
    R6       C6%Rowtype;
    l_Rvcnfc Vw_Csf_Nota_Fiscal_Cobr%Rowtype;
    --
  Begin
    Open C6;
    Loop
      Fetch C6
        Into R6;
      Exit When C6%Notfound;
      --
      l_Rvcnfc.Cpf_Cnpj_Emit   := p_Rvcnf.Cpf_Cnpj_Emit;
      l_Rvcnfc.Dm_Ind_Emit     := p_Rvcnf.Dm_Ind_Emit;
      l_Rvcnfc.Dm_Ind_Oper     := p_Rvcnf.Dm_Ind_Oper;
      l_Rvcnfc.Cod_Part        := p_Rvcnf.Cod_Part;
      l_Rvcnfc.Cod_Mod         := p_Rvcnf.Cod_Mod;
      l_Rvcnfc.Serie           := p_Rvcnf.Serie;
      l_Rvcnfc.Nro_Nf          := p_Rvcnf.Nro_Nf;
      l_Rvcnfc.Nro_Fat         := p_Rvcnf.Nro_Nf;
      l_Rvcnfc.Dm_Ind_Emit_Tit := p_Rvcnf.Dm_Ind_Emit;
      l_Rvcnfc.Dm_Ind_Tit      := '00';
      l_Rvcnfc.Vl_Orig         := R6.Vl_Orig;
      l_Rvcnfc.Vl_Desc         := R6.Vl_Desc;
      l_Rvcnfc.Vl_Liq          := (R6.Vl_Orig - R6.Vl_Desc);
      l_Rvcnfc.Descr_Tit       := Null;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Cobr
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Fat
          ,Dm_Ind_Emit_Tit
          ,Dm_Ind_Tit
          ,Vl_Orig
          ,Vl_Desc
          ,Vl_Liq
          ,Descr_Tit)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,p_Rvcnf.Nro_Nf
          ,p_Rvcnf.Dm_Ind_Emit
          ,'00'
          ,R6.Vl_Orig
          ,R6.Vl_Desc
          ,(R6.Vl_Orig - R6.Vl_Desc)
          ,Null);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Nf_Cobr_Dup_p(p_Rvcnfc => l_Rvcnfc, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Rotina => p_Rotina);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_COBR_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                         ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close C6;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_COBR_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Cobr_p;

  ---
  ------------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_NF_Cobr_Dup --
  ------------------------------------------------------------------------------
  Procedure Vw_Csf_Nf_Cobr_Dup_p(p_Rvcnfc          Vw_Csf_Nota_Fiscal_Cobr%Rowtype
                                ,p_Customer_Trx_Id Number
                                ,p_Rotina          Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C6 Is
      Select Nvl(Apsa.Amount_Due_Original, 0) Vl_Dup
            ,Case
               When Trunc(Apsa.Due_Date) < Sysdate Then
                Trunc(Sysdate)
               Else
                Trunc(Apsa.Due_Date)
             End Dt_Vencto
            ,Lpad(Apsa.Terms_Sequence_Number, 3, '0') Nro_Parc
        From Ar_Payment_Schedules_All Apsa
       Where Apsa.Customer_Trx_Id = p_Customer_Trx_Id;
    R6 C6%Rowtype;
    --
  Begin
    Open C6;
    Loop
      Fetch C6
        Into R6;
      Exit When C6%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nf_Cobr_Dup
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Fat
          ,Nro_Parc
          ,Dt_Vencto
          ,Vl_Dup)
        Values
          (p_Rvcnfc.Cpf_Cnpj_Emit
          ,p_Rvcnfc.Dm_Ind_Emit
          ,p_Rvcnfc.Dm_Ind_Oper
          ,p_Rvcnfc.Cod_Part
          ,p_Rvcnfc.Cod_Mod
          ,p_Rvcnfc.Serie
          ,p_Rvcnfc.Nro_Nf
          ,p_Rvcnfc.Nro_Fat
          ,R6.Nro_Parc
          ,R6.Dt_Vencto
          ,R6.Vl_Dup);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NF_COBR_DUP_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnfc.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnfc.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnfc.Cod_Mod || ', Serie: ' || p_Rvcnfc.Serie ||
                         ', Nro_Nf: ' || p_Rvcnfc.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close C6;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NF_COBR_DUP_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nf_Cobr_Dup_p;

  ---
  ------------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Local --
  ------------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Local_p(p_Rvcnf               Vw_Csf_Nota_Fiscal%Rowtype
                                      ,p_Warehouse_Id        Number
                                      ,p_Ie                  Varchar2
                                      ,p_Ship_To_Site_Use_Id Number
                                      ,p_Rotina              Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C6 Is
      Select 0 Dm_Tipo_Local
            ,p_Rvcnf.Cpf_Cnpj_Emit Cnpj
            ,Null Cpf
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfe.Address_Line_1), 1, 60) Lograd
            ,Substr(Cfe.Address_Line_2, 1, 10) Nro
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfe.Address_Line_3), 1, 60) Compl
            ,Substr(Cfe.Region_1, 1, 60) Bairro
            ,Substr(Cfe.Town_Or_City, 1, 60) Cidade
            ,Substr(Xep.Etb_Information1, 1, 7) Cidade_Ibge
            ,Substr(Cfe.Region_2, 1, 2) Uf
            ,9 Dm_Ind_Carga
            ,To_Char(Trim(Substr(p_Ie, 1, 15))) Ie
        From Cll_F255_Establishment_v Cfe
            ,Xle_Etb_Profiles         Xep
       Where 1 = 1
         And Cfe.Inventory_Organization_Id = p_Warehouse_Id
         And Cfe.Establishment_Id = Xep.Establishment_Id
      -----
      Union
      -----
      Select 1 Dm_Tipo_Local
            ,Case
               When Cfac.Document_Type = 'CNPJ' Then
                Substr(Cfac.Document_Number, 1, 14)
               Else
                Null
             End Cnpj
            ,Case
               When Cfac.Document_Type = 'CPF' Then
                Substr(Cfac.Document_Number, 1, 11)
               Else
                Null
             End Cpf
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfac.Address1), 1, 60) Lograd
            ,Substr(Nvl(Cfac.Address2, 'S/N'), 1, 10) Nro
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfac.Address3), 1, 60) Compl
            ,Substr(Nvl(Cfac.Address4, 'S/B'), 1, 60) Bairro
            ,Substr(Cfac.City, 1, 60) Cidade
            ,Case
               When Cfac.Country <> 'BR' Then
                '9999999'
               Else
                Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cidade_Ibge_Dest_f(Cfac.City, Cfac.State)
             End Cidade_Ibge
            ,Case
               When Cfac.Country <> 'BR' Then
                'EX'
               Else
                Cfac.State
             End Uf
            ,9 Dm_Ind_Carga
            ,To_Char(Trim(Substr(Cfac.Ie, 1, 15))) Ie
        From Cll_F255_Ar_Customers_v Cfac
       Where 1 = 1
         And Cfac.Site_Use_Id = p_Ship_To_Site_Use_Id;
    R6 C6%Rowtype;
    --
  Begin
    Open C6;
    Loop
      Fetch C6
        Into R6;
      Exit When C6%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nota_Fiscal_Local
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Dm_Tipo_Local
          ,Cnpj
          ,Cpf
          ,Lograd
          ,Nro
          ,Compl
          ,Bairro
          ,Cidade
          ,Cidade_Ibge
          ,Uf
          ,Dm_Ind_Carga
          ,Ie)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,R6.Dm_Tipo_Local
          ,R6.Cnpj
          ,R6.Cpf
          ,R6.Lograd
          ,R6.Nro
          ,R6.Compl
          ,R6.Bairro
          ,R6.Cidade
          ,R6.Cidade_Ibge
          ,R6.Uf
          ,R6.Dm_Ind_Carga
          ,To_Char(R6.Ie));
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_LOCAL_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                         ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End Loop;
    Close C6;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_LOCAL_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Local_p;

  ---
  ------------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Nota_Fiscal_Transp --
  ------------------------------------------------------------------------------
  Procedure Vw_Csf_Nota_Fiscal_Transp_p(p_Rvcnf        Vw_Csf_Nota_Fiscal%Rowtype
                                       ,p_Fob_Point    Ra_Customer_Trx_All.Fob_Point%Type
                                       ,p_Ship_Via     Ra_Customer_Trx_All.Ship_Via%Type
                                       ,p_Warehouse_Id Number
                                       ,p_Rotina       Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C10 Is
      Select Substr(Nvl((Substr(Ofv.Global_Attribute5, 2, 8) ||
                        Ofv.Global_Attribute6 || Ofv.Global_Attribute7), (Substr(Cfps.Sup_Site_Global_Attribute10, 2, 8) ||
                         Cfps.Sup_Site_Global_Attribute11 ||
                         Cfps.Sup_Site_Global_Attribute12)), 1, 14) Cnpj_Cpf
            ,p_Rvcnf.Cpf_Cnpj_Emit Cod_Part_Transp
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Nvl(Ofv.Description, Cfps.Vendor_Name)), 1, 60) Nome
            ,Substr(Nvl(Ofv.Global_Attribute8, Cfps.Sup_Site_Global_Attribute13), 1, 14) Ie
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Nvl(Ofv.Global_Attribute1, Cfps.Address_Line1)), 1, 60) Ender
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Nvl(Ofv.Global_Attribute2, Cfps.City)), 1, 60) Cidade
            ,(Select b.Identifier_Value
                From Hz_Geographies           a
                    ,Hz_Geography_Identifiers b
               Where 1 = 1
                 And a.Geography_Id = b.Geography_Id
                 And a.Geography_Name = Nvl(Ofv.Global_Attribute2, Cfps.City)
                 And b.Identifier_Subtype = 'IBGE') Cidade_Ibge
            ,Substr(Nvl(Ofv.Global_Attribute3, Cfps.State), 1, 2) Uf
            ,Null Vl_Serv
            ,Null Vl_Basecalc_Ret
            ,Null Aliqicms_Ret
            ,Null Vl_Icms_Ret
            ,Null Cfop
            ,Null Cpf_Mot
            ,Null Nome_Mot
        From Wsh_Carriers_v          Wc
            ,Apps.Org_Freight_Vl     Ofv
            ,Cll_F255_Po_Suppliers_v Cfps
       Where 1 = 1
         And Wc.Freight_Code = p_Ship_Via
         And Ofv.Freight_Code = Wc.Freight_Code
         And Ofv.Organization_Id = p_Warehouse_Id
         And Cfps.Vendor_Site_Id(+) = Wc.Supplier_Site_Id;
    l_Rvcnft Vw_Csf_Nota_Fiscal_Transp%Rowtype;
  Begin
    ---
    l_Rvcnft.Cpf_Cnpj_Emit := p_Rvcnf.Cpf_Cnpj_Emit;
    l_Rvcnft.Dm_Ind_Emit   := p_Rvcnf.Dm_Ind_Emit;
    l_Rvcnft.Dm_Ind_Oper   := p_Rvcnf.Dm_Ind_Oper;
    l_Rvcnft.Cod_Part      := p_Rvcnf.Cod_Part;
    l_Rvcnft.Cod_Mod       := p_Rvcnf.Cod_Mod;
    l_Rvcnft.Serie         := p_Rvcnf.Serie;
    l_Rvcnft.Nro_Nf        := p_Rvcnf.Nro_Nf;
    l_Rvcnft.Dm_Mod_Frete  := Nvl(p_Fob_Point, 9);
    ---
    If p_Ship_Via Is Not Null
    Then
      Open C10;
      Fetch C10
        Into l_Rvcnft.Cnpj_Cpf
            ,l_Rvcnft.Cod_Part_Transp
            ,l_Rvcnft.Nome
            ,l_Rvcnft.Ie
            ,l_Rvcnft.Ender
            ,l_Rvcnft.Cidade
            ,l_Rvcnft.Cidade_Ibge
            ,l_Rvcnft.Uf
            ,l_Rvcnft.Vl_Serv
            ,l_Rvcnft.Vl_Basecalc_Ret
            ,l_Rvcnft.Aliqicms_Ret
            ,l_Rvcnft.Vl_Icms_Ret
            ,l_Rvcnft.Cfop
            ,l_Rvcnft.Cpf_Mot
            ,l_Rvcnft.Nome_Mot;
      Close C10;
    Else
      l_Rvcnft.Cnpj_Cpf        := Null;
      l_Rvcnft.Cod_Part_Transp := Null;
      l_Rvcnft.Nome            := Null;
      l_Rvcnft.Ie              := Null;
      l_Rvcnft.Ender           := Null;
      l_Rvcnft.Cidade          := Null;
      l_Rvcnft.Cidade_Ibge     := Null;
      l_Rvcnft.Uf              := Null;
      l_Rvcnft.Vl_Serv         := Null;
      l_Rvcnft.Vl_Basecalc_Ret := Null;
      l_Rvcnft.Aliqicms_Ret    := Null;
      l_Rvcnft.Vl_Icms_Ret     := Null;
      l_Rvcnft.Cfop            := Null;
      l_Rvcnft.Cpf_Mot         := Null;
      l_Rvcnft.Nome_Mot        := Null;
    End If;
    ---
    Begin
      Insert Into Vw_Csf_Nota_Fiscal_Transp Values l_Rvcnft;
      --
    Exception
      When Dup_Val_On_Index Then
        Null;
      When Others Then
        --
        g_Retcode   := 1;
        g_Erro      := Nvl(g_Erro, 0) + 1;
        l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TRANSP_P - ' || 'Cpf_Cnpj_Emit: ' ||
                       p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                       p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                       p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                       ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                       Sqlerrm;
        g_Erro_Msg  := l_Desc_Erro;
        --
        Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
        --
    End;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NOTA_FISCAL_TRANSP_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nota_Fiscal_Transp_p;

  ---
  --------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_NFTransp_Veic ---
  --------------------------------------------------------------------------
  Procedure Vw_Csf_Nftransp_Veic_p(p_Rvcnf                       Vw_Csf_Nota_Fiscal%Rowtype
                                  ,p_License_Plate               Varchar2
                                  ,p_Vehicle_Plate_State_Code    Varchar2
                                  ,p_Vehicle_Antt_Inscription    Varchar2
                                  ,p_Towing_Veh_Plate_Number     Varchar2
                                  ,p_Towing_Veh_Plate_State_Code Varchar2
                                  ,p_Towing_Veh_Antt_Inscription Varchar2
                                  ,p_Wagon_Code                  Varchar2
                                  ,p_Ferry_Code                  Varchar2
                                  ,p_Rotina                      Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    l_Rvcnftv Vw_Csf_Nftransp_Veic%Rowtype;
    --
  Begin
    l_Rvcnftv.Cpf_Cnpj_Emit := p_Rvcnf.Cpf_Cnpj_Emit;
    l_Rvcnftv.Dm_Ind_Emit   := p_Rvcnf.Dm_Ind_Emit;
    l_Rvcnftv.Dm_Ind_Oper   := p_Rvcnf.Dm_Ind_Oper;
    l_Rvcnftv.Cod_Part      := p_Rvcnf.Cod_Part;
    l_Rvcnftv.Cod_Mod       := p_Rvcnf.Cod_Mod;
    l_Rvcnftv.Serie         := p_Rvcnf.Serie;
    l_Rvcnftv.Nro_Nf        := p_Rvcnf.Nro_Nf;
    --
    If p_License_Plate Is Not Null
    Then
      l_Rvcnftv.Dm_Tipo := 0;
      l_Rvcnftv.Placa   := p_License_Plate;
      l_Rvcnftv.Uf      := p_Vehicle_Plate_State_Code;
      l_Rvcnftv.Rntc    := p_Vehicle_Antt_Inscription;
      l_Rvcnftv.Vagao   := Null;
      l_Rvcnftv.Balsa   := Null;
      --
      Begin
        Insert Into Vw_Csf_Nftransp_Veic Values l_Rvcnftv;
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          l_Desc_Erro := 'VW_CSF_NFTRANSP_VEIC_P (01) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                         p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End If;
    --
    l_Rvcnftv.Cpf_Cnpj_Emit := p_Rvcnf.Cpf_Cnpj_Emit;
    l_Rvcnftv.Dm_Ind_Emit   := p_Rvcnf.Dm_Ind_Emit;
    l_Rvcnftv.Dm_Ind_Oper   := p_Rvcnf.Dm_Ind_Oper;
    l_Rvcnftv.Cod_Part      := p_Rvcnf.Cod_Part;
    l_Rvcnftv.Cod_Mod       := p_Rvcnf.Cod_Mod;
    l_Rvcnftv.Serie         := p_Rvcnf.Serie;
    l_Rvcnftv.Nro_Nf        := p_Rvcnf.Nro_Nf;
    --
    If p_Towing_Veh_Plate_Number Is Not Null
    Then
      l_Rvcnftv.Dm_Tipo := 1;
      l_Rvcnftv.Placa   := p_Towing_Veh_Plate_Number;
      l_Rvcnftv.Uf      := p_Towing_Veh_Plate_State_Code;
      l_Rvcnftv.Rntc    := p_Towing_Veh_Antt_Inscription;
      l_Rvcnftv.Vagao   := p_Wagon_Code;
      l_Rvcnftv.Balsa   := p_Ferry_Code;
      --
      Begin
        Insert Into Vw_Csf_Nftransp_Veic Values l_Rvcnftv;
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NFTRANSP_VEIC_P (02) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                         p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NFTRANSP_VEIC_P (03) - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nftransp_Veic_p;

  ---
  -------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Nftransp_Vol ---
  -------------------------------------------------------------------------
  Procedure Vw_Csf_Nftransp_Vol_p(p_Rvcnf            Vw_Csf_Nota_Fiscal%Rowtype
                                 ,p_Bulk_Number      Varchar2
                                 ,p_Bulk             Varchar2
                                 ,p_Species_Turnover Varchar2
                                 ,p_Weight           Number
                                 ,p_Net_Weight       Number
                                 ,p_Rotina           Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
  Begin
    If ((p_Bulk_Number Is Not Null) Or (p_Bulk Is Not Null) Or
       (p_Species_Turnover Is Not Null) Or (p_Weight Is Not Null))
    Then
      ---
      Begin
        Insert Into Vw_Csf_Nftransp_Vol
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Vol
          ,Qtdevol
          ,Especie
          ,Marca
          ,Peso_Bruto
          ,Peso_Liq)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,p_Bulk_Number
          ,p_Bulk
          ,p_Species_Turnover
          ,Null
          ,p_Weight
          ,p_Net_Weight);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NFTRANSP_VOL_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                         ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      ---
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NFTRANSP_VOL_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nftransp_Vol_p;

  ---
  ------------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Nftranspvol_Lacre ---
  ------------------------------------------------------------------------------
  Procedure Vw_Csf_Nftranspvol_Lacre_p(p_Rvcnf       Vw_Csf_Nota_Fiscal%Rowtype
                                      ,p_Bulk_Number Varchar2
                                      ,p_Seal_Number Varchar2
                                      ,p_Rotina      Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
  Begin
    If p_Seal_Number Is Not Null
    Then
      ---
      Begin
        Insert Into Vw_Csf_Nftranspvol_Lacre
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Vol
          ,Nro_Lacre)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,p_Bulk_Number
          ,p_Seal_Number);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_NFTRANSPVOL_LACRE_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                         ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      ---
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_NFTRANSPVOL_LACRE_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nftranspvol_Lacre_p;

  ---
  -----------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Item_Nota_Fiscal ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Item_Nota_Fiscal_p(p_Rvcnf              Vw_Csf_Nota_Fiscal%Rowtype
                                     ,p_Customer_Trx_Id    Number
                                     ,p_Vl_Frete           Number
                                     ,p_Vl_Seguro          Number
                                     ,p_Vl_Outras_Despesas Number
                                     ,p_Uf_Dest            Varchar2
                                     ,p_Pedido_Compra      Varchar2
                                     ,p_Tipo_Transacao     Varchar2
                                     ,p_Rotina             Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    x_Retorno   Number;
    --
    Cursor C11 Is
      Select Nvl((Rank()
                  Over(Partition By Cfaii.Customer_Trx_Id Order By
                       Cfaii.Customer_Trx_Line_Id Asc Nulls Last)), Cfaii.Line_Number) Nro_Item
            ,Msik.Concatenated_Segments Cod_Item
            ,Decode(Msik.Inventory_Item_Flag, 'Y', 0, 1) Dm_Ind_Mov
             /*,Nvl(Substr(Msik.Global_Attribute10, 1, 14), 'SEM GTIN') Cean*/ -- Carranza 07/02/2019
             /*,Case
               When Length(Msik.Global_Attribute10) Not In (0, 8, 12, 13, 14) Then
                'SEM GTIN'
               Else
                Nvl(Substr(Msik.Global_Attribute10, 1, 14), 'SEM GTIN')
             End Cean*/ -- Carranza 05/09/2019
            ,Case
               When Length(Regexp_Replace(Msik.Global_Attribute10, '[^0-9]+', '')) Not In
                    (0, 8, 12, 13, 14) Then
                'SEM GTIN'
               Else
                Nvl(Substr(Regexp_Replace(Msik.Global_Attribute10, '[^0-9]+', ''), 1, 14), 'SEM GTIN')
             End Cean
             /*,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfaii.Description), 1, 115) Descr_Item*/ -- Carranza 26/10/2022 (Alterado a pedido da Leticia Galera em reunião com Elaine, Guilherme e Cesar)
            ,Substr((Xxisv_Csf_Nfe_Pkg.Get_Nfe_Descr_Item_f(Cfaii.Customer_Trx_Line_Id)), 1, 115) Descr_Item -- Carranza 26/10/2022 (Alterado a pedido da Leticia Galera em reunião com Elaine, Guilherme e Cesar)
             /*,Substr(Cfaii.Code_Nbm, 1, 8) Cod_Ncm
             ,Substr(Cfaii.Code_Nbm, 1, 2) Genero*/ -- Carranza 03/02/2021
            ,Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Ncm_f(Cfaii.Customer_Trx_Id, Cfaii.Customer_Trx_Line_Id), Substr(Cfaii.Code_Nbm, 1, 8)) Cod_Ncm -- Carranza 03/02/2021
            ,Substr(Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Ncm_f(Cfaii.Customer_Trx_Id, Cfaii.Customer_Trx_Line_Id), Cfaii.Code_Nbm), 1, 2) Genero -- Carranza 03/02/2021
            ,Substr(Msik.Global_Attribute14, 1, 3) Cod_Ext_Ipi
            ,Substr(Regexp_Replace(Cfaii.Code_Cfo, '[^0-9]'), 1, 4) Cfop
            ,Cfaii.Uom_Code Unid_Com
            ,Cfaii.Quantity_Invoiced Qtde_Comerc
            ,Cfaii.Unit_Price Vl_Unit_Comerc
            ,Cfaii.Vl_Item Vl_Item_Bruto
             /*,Nvl(Substr(Msik.Global_Attribute10, 1, 14), 'SEM GTIN') Cean_Trib*/ -- Carranza 07/02/2019
             /*,Case
               When Length(Msik.Global_Attribute10) Not In (0, 8, 12, 13, 14) Then
                'SEM GTIN'
               Else
                Nvl(Substr(Msik.Global_Attribute10, 1, 14), 'SEM GTIN')
             End Cean_Trib*/
            ,Case
               When Length(Regexp_Replace(Msik.Global_Attribute10, '[^0-9]+', '')) Not In
                    (0, 8, 12, 13, 14) Then
                'SEM GTIN'
               Else
                Nvl(Substr(Regexp_Replace(Msik.Global_Attribute10, '[^0-9]+', ''), 1, 14), 'SEM GTIN')
             End Cean_Trib
            ,Cfaii.Uom_Code Unid_Trib
            ,Cfaii.Quantity_Invoiced Qtde_Trib
            ,Cfaii.Unit_Price Vl_Unit_Trib
             /*,Case
               When Cfaii.Interface_Line_Context = 'ORDER ENTRY' Then
                Nvl((Select Round(Opa.Invoiced_Amount, 2)
                      From Apps.Oe_Price_Adjustments Opa
                     Where 1 = 1
                       And Opa.Line_Id = Cfaii.Interface_Line_Attribute6
                       And Opa.Charge_Type_Code = 'FREIGHT'
                       And Opa.Arithmetic_Operator = 'AMT'), 0) +
                Nvl((Select Nvl(Rctl.Gross_Extended_Amount, Rctl.Extended_Amount)
                      From Apps.Ra_Customer_Trx_Lines_All Rctl
                     Where 1 = 1
                       And Rctl.Line_Type = 'FREIGHT'
                       And Rctl.Customer_Trx_Id = Cfaii.Customer_Trx_Id
                       And Rctl.Link_To_Cust_Trx_Line_Id =
                           Cfaii.Customer_Trx_Line_Id), 0)
               Else
                Nvl(p_Vl_Frete / (Count(Cfaii.Customer_Trx_Line_Id) Over()), 0)
             End Vl_Frete*/ -- Carranza 06/04/2021
             ---
            ,Case
               When Cfaii.Interface_Line_Context = 'ORDER ENTRY' Then
                Nvl((Select Round(Opa.Invoiced_Amount, 2)
                      From Apps.Oe_Price_Adjustments Opa
                     Where 1 = 1
                       And Opa.Line_Id = Cfaii.Interface_Line_Attribute6
                       And Opa.Charge_Type_Code = 'FREIGHT'
                       And Opa.Arithmetic_Operator = 'AMT'), 0) +
                Nvl((Select Nvl(Rctl.Gross_Extended_Amount, Rctl.Extended_Amount)
                      From Apps.Ra_Customer_Trx_Lines_All Rctl
                     Where 1 = 1
                       And Rctl.Line_Type = 'FREIGHT'
                       And Rctl.Customer_Trx_Id = Cfaii.Customer_Trx_Id
                       And Rctl.Link_To_Cust_Trx_Line_Id =
                           Cfaii.Customer_Trx_Line_Id), 0) +
                Nvl(((Select Sum(Nvl(Rctl.Gross_Extended_Amount, Rctl.Extended_Amount))
                        From Apps.Ra_Customer_Trx_Lines_All Rctl
                       Where 1 = 1
                         And Rctl.Line_Type = 'FREIGHT'
                         And Rctl.Link_To_Cust_Trx_Line_Id Is Null
                         And Rctl.Customer_Trx_Id = Cfaii.Customer_Trx_Id) /
                    (Count(Cfaii.Customer_Trx_Line_Id) Over())), 0)
               Else
                Nvl(p_Vl_Frete / (Count(Cfaii.Customer_Trx_Line_Id) Over()), 0)
             End Vl_Frete -- Carranza 06/04/2021
             ---
            ,Nvl(p_Vl_Seguro / (Count(Cfaii.Customer_Trx_Line_Id) Over()), 0) Vl_Seguro
            ,Nvl((Select Abs(Nvl(a.Gross_Extended_Amount, a.Extended_Amount))
                   From Ra_Customer_Trx_Lines_All a
                  Where 1 = 1
                    And a.Customer_Trx_Id = Cfaii.Customer_Trx_Id
                    And a.Interface_Line_Attribute6 =
                        Cfaii.Interface_Line_Attribute6
                    And a.Line_Type = 'LINE'
                    And a.Interface_Line_Attribute11 <> 0
                    And a.Interface_Line_Context = 'ORDER ENTRY'
                    And Nvl(a.Gross_Extended_Amount, a.Extended_Amount) < 0), 0) Vl_Desc
             ----------------------------------------
             /*Consideramos o ICMS-ST que estejam configurados com o globla_attribute10 preenchido e com
             o global_attribute2 = 'N' para não ser impresso. Isso por se tratarem de impostos que somam no
             total da nota fiscal - Regra valida para o VL_OUTRO*/
            ,Nvl(Nvl((Nvl((Select Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) Vl_Outro
                            From Zx_Lines       Zl
                                ,Ar_Vat_Tax_All Arvt
                           Where 1 = 1
                             And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                             And Zl.Internal_Organization_Id = Arvt.Org_Id
                             And Zl.Trx_Line_Id = Cfaii.Customer_Trx_Line_Id
                             And Zl.Trx_Id = Cfaii.Customer_Trx_Id
                             And Zl.Tax_Amt_Included_Flag = 'Y'
                             And Nvl(Arvt.Global_Attribute10, 'Nulo') Not In
                                /*('IPI', 'ICMS-ST', 'PIS', 'COFINS')*/ -- Carranza 20/02/2019
                                /*('IPI', 'ICMS-ST', 'PIS', 'COFINS', 'II', 'ICMS') -- Carranza 20/02/2019*/ -- Carranza 08/04/2020
                                 ('IPI', 'ICMS-ST', 'PIS', 'COFINS', 'II', 'ICMS', 'ICMS-ST-FP') -- Carranza 08/04/2020
                             And Arvt.Global_Attribute2 = 'N'), 0) +
                     Nvl((Select Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) Vl_Outro
                            From Zx_Lines       Zl
                                ,Ar_Vat_Tax_All Arvt
                           Where 1 = 1
                             And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                             And Zl.Internal_Organization_Id = Arvt.Org_Id
                             And Zl.Trx_Line_Id = Cfaii.Customer_Trx_Line_Id
                             And Zl.Trx_Id = Cfaii.Customer_Trx_Id
                             And Nvl(Arvt.Global_Attribute10, 'Nulo') In
                                 ('IPI') /*Considerar o IPI de não contribuinte apenas quando não for operação de devolução NFe 4.0*/
                             And Arvt.Global_Attribute2 = 'N'
                             And Nvl(p_Rvcnf.Dm_Fin_Nfe, 0) <> 4), 0) +
                     Nvl((Select Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) Vl_Outro
                            From Zx_Lines       Zl
                                ,Ar_Vat_Tax_All Arvt
                           Where 1 = 1
                             And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                             And Zl.Internal_Organization_Id = Arvt.Org_Id
                             And Zl.Trx_Line_Id = Cfaii.Customer_Trx_Line_Id
                             And Zl.Trx_Id = Cfaii.Customer_Trx_Id
                             And Zl.Tax_Amt_Included_Flag = 'N'
                             And Arvt.Global_Attribute10 = 'ICMS-ST'
                             And Arvt.Global_Attribute2 = 'N'), 0) +
                     Nvl((Select Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) Vl_Outro
                            From Zx_Lines       Zl
                                ,Ar_Vat_Tax_All Arvt
                           Where 1 = 1
                             And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                             And Zl.Internal_Organization_Id = Arvt.Org_Id
                             And Zl.Trx_Line_Id = Cfaii.Customer_Trx_Line_Id
                             And Zl.Trx_Id = Cfaii.Customer_Trx_Id
                             And Zl.Tax_Amt_Included_Flag = 'N'
                             And Arvt.Global_Attribute10 = 'ICMS-ST-FP'
                             And Arvt.Global_Attribute2 = 'N'), 0) -- Carranza 08/04/2020
                     ), (0 / (Count(Cfaii.Customer_Trx_Line_Id) Over()))), 0) Vl_Outro
            ,Case
               When Cfaii.Code_Cfo In ('5933', '6933') Then
                0
               When Cfaii.Vl_Item > 0 Then
                1
               Else
                0
             End Dm_Ind_Tot
             /*,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Cfaii.Description), 116, 500) Infadprod*/ -- Carranza 26/10/2022 (Alterado a pedido da Leticia Galera em reunião com Elaine, Guilherme e Cesar)
            ,Substr(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Descr_Item_f(Cfaii.Customer_Trx_Line_Id), 116, 500) Infadprod -- Carranza 26/10/2022 (Alterado a pedido da Leticia Galera em reunião com Elaine, Guilherme e Cesar)
            ,Cfaii.Type_Item_Origin Orig
            ,0 Dm_Mod_Base_Calc
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Dm_Mod_Base_Calc_St_f(Cfaii.Customer_Trx_Id, Cfaii.Customer_Trx_Line_Id) Dm_Mod_Base_Calc_St
            ,Null Cnpj_Produtor
            ,Null Qtde_Selo_Ipi
            ,Null Vl_Desp_Adu
            ,Null Vl_Iof
            ,Null Cl_Enq_Ipi /*Campo correto arvt_global_attribute8*/
            ,Null Cod_Selo_Ipi
             --,Null Cod_Enq_Ipi /*Campo correto arvt_global_attribute5*/
            ,(Select Distinct Substr(Cfatit.Legal_Justification_Text3, 1, 3)
                From Cll_F255_Ar_Total_Inv_Taxes_v Cfatit
               Where 1 = 1
                 And Cfatit.Customer_Trx_Id = Cfaii.Customer_Trx_Id
                 And Cfatit.Link_To_Cust_Trx_Line_Id =
                     Cfaii.Customer_Trx_Line_Id
                 And Cfatit.Arvt_Global_Attribute10 = 'IPI'
                 And Cfatit.Arvt_Global_Attribute2 = 'Y'
                 And Cfatit.Legal_Justification_Text3 Is Not Null) Cod_Enq_Ipi
            ,Case
               When (Cfaii.Code_Cfo = '5933' Or Cfaii.Code_Cfo = '6933') Then
                Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cidade_Ibge_Emit_f(Cfaii.Organization_Id)
               Else
                Null
             End Cidade_Ibge
            ,Case
               When (Cfaii.Code_Cfo = '5933' Or Cfaii.Code_Cfo = '6933') Then
                (Select Substr(Regexp_Replace(Msi.Global_Attribute11, '[^0-9]', ''), 1, 4) Lc_116
                   From Mtl_Parameters     Mp
                       ,Mtl_System_Items_b Msi
                  Where 1 = 1
                    And Mp.Master_Organization_Id = Msi.Organization_Id
                    And Mp.Organization_Id = Cfaii.Organization_Id
                    And Msi.Inventory_Item_Id = Cfaii.Inventory_Item_Id)
               Else
                Null
             End Cd_Lista_Serv /*Recupera Código do Serviço cadastrado no Item Mestre que corresponde ao código da LC 116*/
            ,Null Dm_Ind_Apur_Ipi
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Cta_f(Cfaii.Customer_Trx_Line_Id, Cfaii.Org_Id) Cod_Cta
             /*,p_Pedido_Compra Pedido_Compra
             ,Case
                When p_Pedido_Compra Is Not Null Then
                 Nvl(Cfaii.Sales_Order_Line, Cfaii.Line_Number)
                Else
                 Null
              End Item_Pedido_Compra*/ -- Carranza 14/01/2020
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Pedido_Compra_f(Cfaii.Interface_Line_Attribute6, Cfaii.Org_Id) Pedido_Compra -- Carranza 14/01/2020
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Item_Pedido_Compra_f(Cfaii.Interface_Line_Attribute6, Cfaii.Org_Id) Item_Pedido_Compra -- Carranza 14/01/2020
             /*,Null Dm_Mot_Des_Icms*/ -- Carranza 19/08/2019
            ,Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Dm_Mot_Des_Icms_f(Cfaii.Customer_Trx_Id, Cfaii.Customer_Trx_Line_Id), Xxisv_Csf_Nfe_Custom_Pkg.Get_Nfe_Dm_Mot_Des_Icms_f(Cfaii.Customer_Trx_Id, Cfaii.Customer_Trx_Line_Id)) Dm_Mot_Des_Icms -- Carranza 19/08/2019
            ,Xxisv_Csf_Nfe_Pkg.Get_Nfe_Dm_Cod_Trib_Issqn_f(Cfaii.Customer_Trx_Id, Cfaii.Customer_Trx_Line_Id) Dm_Cod_Trib_Issqn
            ,Cfaii.Customer_Trx_Id Customer_Trx_Id
            ,Cfaii.Customer_Trx_Line_Id Customer_Trx_Line_Id
            ,Cfaii.Inventory_Item_Id Inventory_Item_Id
            ,Cfaii.Warehouse Warehouse
            ,Cfaii.State_Federal_Tax_Code State_Federal_Tax_Code
            ,Cfaii.State_State_Tax_Code State_State_Tax_Code
            ,Cfaii.Interface_Line_Context Interface_Line_Context
            ,Cfaii.Rctt_Global_Attribute7 Cclass_Trib_Cbs
            ,Cfaii.Rctt_Global_Attribute8 Cclass_Trib_Ibs
        From Cll_F255_Ar_Invoice_Items_v Cfaii
            ,Mtl_System_Items_Kfv        Msik
       Where 1 = 1
         And Cfaii.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfaii.Line_Type = 'LINE'
         And (Cfaii.Interface_Line_Attribute11 = 0 Or
             Cfaii.Interface_Line_Attribute11 Is Null)
         And (Msik.Item_Type <> 'FRT' Or Msik.Item_Type Is Null)
         And Msik.Inventory_Item_Id = Cfaii.Inventory_Item_Id
         And Msik.Organization_Id = Cfaii.Organization_Id;
    R11 C11%Rowtype;
    --
    l_Rvcinf Vw_Csf_Item_Nota_Fiscal%Rowtype;
    --
  Begin
    --
    Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Item_Nota_Fiscal_f(p_Rvcnf => p_Rvcnf, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Vl_Frete => p_Vl_Frete, p_Vl_Seguro => p_Vl_Seguro, p_Vl_Outras_Despesas => p_Vl_Outras_Despesas, p_Uf_Dest => p_Uf_Dest, p_Pedido_Compra => p_Pedido_Compra, p_Rotina => 'Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Item_Nota_Fiscal_f', p_Retorno => x_Retorno);
    If x_Retorno = 0
    Then
      --
      Open C11;
      Loop
        Fetch C11
          Into R11;
        Exit When C11%Notfound;
        ---
        l_Rvcinf.Cpf_Cnpj_Emit       := p_Rvcnf.Cpf_Cnpj_Emit;
        l_Rvcinf.Dm_Ind_Emit         := p_Rvcnf.Dm_Ind_Emit;
        l_Rvcinf.Dm_Ind_Oper         := p_Rvcnf.Dm_Ind_Oper;
        l_Rvcinf.Cod_Part            := p_Rvcnf.Cod_Part;
        l_Rvcinf.Cod_Mod             := p_Rvcnf.Cod_Mod;
        l_Rvcinf.Serie               := p_Rvcnf.Serie;
        l_Rvcinf.Nro_Nf              := p_Rvcnf.Nro_Nf;
        l_Rvcinf.Nro_Item            := R11.Nro_Item;
        l_Rvcinf.Cod_Item            := R11.Cod_Item;
        l_Rvcinf.Dm_Ind_Mov          := R11.Dm_Ind_Mov;
        l_Rvcinf.Cean                := R11.Cean;
        l_Rvcinf.Descr_Item          := R11.Descr_Item;
        l_Rvcinf.Cod_Ncm             := R11.Cod_Ncm;
        l_Rvcinf.Genero              := R11.Genero;
        l_Rvcinf.Cod_Ext_Ipi         := R11.Cod_Ext_Ipi;
        l_Rvcinf.Cfop                := R11.Cfop;
        l_Rvcinf.Unid_Com            := R11.Unid_Com;
        l_Rvcinf.Qtde_Comerc         := R11.Qtde_Comerc;
        l_Rvcinf.Vl_Unit_Comerc      := R11.Vl_Unit_Comerc;
        l_Rvcinf.Vl_Item_Bruto       := R11.Vl_Item_Bruto;
        l_Rvcinf.Cean_Trib           := R11.Cean_Trib;
        l_Rvcinf.Unid_Trib           := R11.Unid_Trib;
        l_Rvcinf.Qtde_Trib           := R11.Qtde_Trib;
        l_Rvcinf.Vl_Unit_Trib        := R11.Vl_Unit_Trib;
        l_Rvcinf.Vl_Frete            := R11.Vl_Frete;
        l_Rvcinf.Vl_Seguro           := R11.Vl_Seguro;
        l_Rvcinf.Vl_Desc             := R11.Vl_Desc;
        l_Rvcinf.Vl_Outro            := R11.Vl_Outro;
        l_Rvcinf.Dm_Ind_Tot          := R11.Dm_Ind_Tot;
        l_Rvcinf.Infadprod           := R11.Infadprod;
        l_Rvcinf.Orig                := R11.Orig;
        l_Rvcinf.Dm_Mod_Base_Calc    := R11.Dm_Mod_Base_Calc;
        l_Rvcinf.Dm_Mod_Base_Calc_St := R11.Dm_Mod_Base_Calc_St;
        l_Rvcinf.Cnpj_Produtor       := R11.Cnpj_Produtor;
        l_Rvcinf.Qtde_Selo_Ipi       := R11.Qtde_Selo_Ipi;
        l_Rvcinf.Vl_Desp_Adu         := R11.Vl_Desp_Adu;
        l_Rvcinf.Vl_Iof              := R11.Vl_Iof;
        l_Rvcinf.Cl_Enq_Ipi          := R11.Cl_Enq_Ipi;
        l_Rvcinf.Cod_Selo_Ipi        := R11.Cod_Selo_Ipi;
        l_Rvcinf.Cod_Enq_Ipi         := R11.Cod_Enq_Ipi;
        l_Rvcinf.Cidade_Ibge         := R11.Cidade_Ibge;
        l_Rvcinf.Cd_Lista_Serv       := R11.Cd_Lista_Serv;
        l_Rvcinf.Dm_Ind_Apur_Ipi     := R11.Dm_Ind_Apur_Ipi;
        l_Rvcinf.Cod_Cta             := R11.Cod_Cta;
        l_Rvcinf.Pedido_Compra       := R11.Pedido_Compra;
        l_Rvcinf.Item_Pedido_Compra  := R11.Item_Pedido_Compra;
        l_Rvcinf.Dm_Mot_Des_Icms     := R11.Dm_Mot_Des_Icms;
        l_Rvcinf.Dm_Cod_Trib_Issqn   := R11.Dm_Cod_Trib_Issqn;
        --
        Begin
          Begin
            Insert Into Vw_Csf_Item_Nota_Fiscal Values l_Rvcinf;
          End;
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Item_Nota_Fiscal_Ff_p(p_Rvcinf => l_Rvcinf, p_Customer_Trx_Line_Id => R11.Customer_Trx_Line_Id, p_Customer_Trx_Id => R11.Customer_Trx_Id, p_Dm_Fin_Nfe => p_Rvcnf.Dm_Fin_Nfe, p_Tipo_Transacao => p_Tipo_Transacao, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnf_Compl_p(p_Rvcinf => l_Rvcinf, p_Inventory_Item_Id => R11.Inventory_Item_Id, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Imp_Itemnf_p(p_Rvcinf => l_Rvcinf, p_Customer_Trx_Line_Id => R11.Customer_Trx_Line_Id, p_Customer_Trx_Id => R11.Customer_Trx_Id, p_Interface_Line_Context => R11.Interface_Line_Context, p_Cclass_Trib_Cbs => R11.Cclass_Trib_Cbs, p_Cclass_Trib_Ibs => R11.Cclass_Trib_Ibs, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnf_Comb_p(p_Rvcinf => l_Rvcinf, p_Inventory_Item_Id => R11.Inventory_Item_Id, p_Warehouse_Id => R11.Warehouse, p_Uf_Cons => p_Uf_Dest, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnf_Med_p(p_Rvcinf => l_Rvcinf, p_Customer_Trx_Line_Id => R11.Customer_Trx_Line_Id, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnf_Rastreab_p(p_Rvcinf => l_Rvcinf, p_Customer_Trx_Line_Id => R11.Customer_Trx_Line_Id, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnf_Dec_Impor_p(p_Rvcinf => l_Rvcinf, p_Customer_Trx_Line_Id => R11.Customer_Trx_Line_Id, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnf_Export_p(p_Rvcinf => l_Rvcinf, p_Customer_Trx_Line_Id => R11.Customer_Trx_Line_Id, p_Customer_Trx_Id => R11.Customer_Trx_Id, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnfe_Compl_Serv_p(p_Rvcinf => l_Rvcinf, p_Inventory_Item_Id => R11.Inventory_Item_Id, p_Warehouse_Id => R11.Warehouse, p_Rotina => p_Rotina);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_ITEM_NOTA_FISCAL_P - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcnf.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcnf.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcnf.Cod_Mod || ', Serie: ' ||
                           p_Rvcnf.Serie || ', Nro_Nf: ' || p_Rvcnf.Nro_Nf ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        ---
      End Loop;
      Close C11;
      --
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_ITEM_NOTA_FISCAL_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Item_Nota_Fiscal_p;

  ---
  ---
  --------------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Item_Nota_Fiscal_Ff ---
  --------------------------------------------------------------------------------
  Procedure Vw_Csf_Item_Nota_Fiscal_Ff_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                                        ,p_Customer_Trx_Line_Id Number
                                        ,p_Customer_Trx_Id      Number
                                        ,p_Dm_Fin_Nfe           Number
                                        ,p_Tipo_Transacao       Varchar2
                                        ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
    /*Select Regexp_Replace(Jbctle.Cest_Code, '[^0-9]') Valor
                                ,'COD_CEST' Atributo
                            From Jl_Br_Cust_Trx_Lines_Exts Jbctle
                           Where Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                             And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
                             And Regexp_Replace(Jbctle.Cest_Code, '[^0-9]') Is Not Null
                          --
                          Union
                          --
                          \*Retornar essa informação apenas quando houver informações de IPI em Devoluções*\
                          Select Regexp_Replace((Jbctle.Perc_Returned_Goods * 100), '[^0-9]') Valor
                                ,'PERCENT_DEVOL' Atributo
                            From Jl_Br_Cust_Trx_Lines_Exts Jbctle
                                ,Zx_Lines                  Zl
                                ,Ar_Vat_Tax_All            Arvt
                                ,Ra_Customer_Trx_All       Rcta
                                ,Ra_Cust_Trx_Types_All     Rctta
                           Where 1 = 1
                             And Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                             And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
                             And Zl.Trx_Id = Jbctle.Customer_Trx_Id
                             And Zl.Trx_Line_Id = Jbctle.Customer_Trx_Line_Id
                             And Arvt.Vat_Tax_Id = Zl.Tax_Rate_Id
                             And Arvt.Org_Id = Zl.Internal_Organization_Id
                             And Arvt.Global_Attribute2 = 'N'
                             And Arvt.Global_Attribute10 = 'IPI'
                             And Rcta.Customer_Trx_Id = Jbctle.Customer_Trx_Id
                             And Rctta.Cust_Trx_Type_Id = Rcta.Cust_Trx_Type_Id
                             And Rctta.Global_Attribute5 = '4'
                             And Nvl(Regexp_Replace((Jbctle.Perc_Returned_Goods * 100), '[^0-9]'), 0) > 0
                          --
                          Union
                          --
                          Select Regexp_Replace((Abs(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0)) * 100), '[^0-9]') Valor
                                ,'VL_IPI_DEVOL' Atributo
                            From Zx_Lines                  Zl
                                ,Ar_Vat_Tax_All            Arvt
                                ,Ra_Customer_Trx_Lines_All Rctla
                           Where 1 = 1
                             And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                             And Zl.Internal_Organization_Id = Arvt.Org_Id
                             And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                             And Zl.Trx_Id = Rctla.Customer_Trx_Id
                             And Rctla.Line_Type = 'LINE'
                             And Arvt.Global_Attribute10 = 'IPI'
                             And Arvt.Global_Attribute2 = 'N'
                             And Zl.Trx_Id = p_Customer_Trx_Id
                             And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
                             And Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) > 0
                             And p_Dm_Fin_Nfe = 4
                          --
                          Union
                          --
                          Select Regexp_Replace(Jbctle.Reinf_Service_Classification, '[^0-9]') Valor
                                ,'CD_TP_SERV_REINF' Atributo
                            From Jl_Br_Cust_Trx_Lines_Exts Jbctle
                           Where 1 = 1
                             And Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                             And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
                             And Jbctle.Reinf_Service_Classification Is Not Null
                          --
                          Union
                          --
                          Select Regexp_Replace(0, '[^0-9]') Valor
                                ,'DM_IND_CPRB' Atributo
                            From Dual
                           Where p_Rvcinf.Cd_Lista_Serv Is Not Null
                          --
                          Union
                          --
                          Select Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Ocor_Aj_Icms_f(p_Customer_Trx_Line_Id), Xxisv_Csf_Nfe_Custom_Pkg.Get_Nfe_Cod_Ocor_Aj_Icms_f(p_Customer_Trx_Line_Id)) Valor --(p_customer_trx_id, p_customer_trx_line_id) Valor
                                ,'COD_OCOR_AJ_ICMS' Atributo
                            From Dual
                           Where Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Ocor_Aj_Icms_f(p_Customer_Trx_Line_Id), Xxisv_Csf_Nfe_Custom_Pkg.Get_Nfe_Cod_Ocor_Aj_Icms_f(p_Customer_Trx_Line_Id)) Is Not Null
                          --
                          Union
                          --
                          Select Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cbenef_f(p_Uf => (Select Cfe.Region_2
                                                                               From Cll_F255_Establishment_v Cfe
                                                                              Where Inventory_Organization_Id =
                                                                                    Rctla.Warehouse_Id), p_Tipo_Transacao => p_Tipo_Transacao, p_Cfop => p_Rvcinf.Cfop, p_Cst => p_Rvcinf.Orig ||
                                                                              Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7), p_Ncm => p_Rvcinf.Cod_Ncm) Valor
                                ,'COD_INF_ADIC_VLR_DECL' Atributo
                            From Zx_Lines                  Zl
                                ,Ar_Vat_Tax_All            Arvt
                                ,Ra_Customer_Trx_Lines_All Rctla
                           Where 1 = 1
                             And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                             And Zl.Internal_Organization_Id = Arvt.Org_Id
                             And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                             And Zl.Trx_Id = Rctla.Customer_Trx_Id
                             And Rctla.Line_Type = 'LINE'
                             And Arvt.Global_Attribute2 = 'Y'
                             And Arvt.Global_Attribute10 = 'ICMS'
                             And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id;*/ -- Carranza 25/03/2026
    --
      Select Valor
            ,Atributo
        From (Select Regexp_Replace(Jbctle.Cest_Code, '[^0-9]') Valor
                    ,'COD_CEST' Atributo
                From Jl_Br_Cust_Trx_Lines_Exts Jbctle
               Where Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
              Union All
              /* Retornar essa informação apenas quando houver informações de IPI em Devoluções */
              Select Regexp_Replace((Jbctle.Perc_Returned_Goods * 100), '[^0-9]') Valor
                    ,'PERCENT_DEVOL' Atributo
                From Jl_Br_Cust_Trx_Lines_Exts Jbctle
                    ,Zx_Lines                  Zl
                    ,Ar_Vat_Tax_All            Arvt
                    ,Ra_Customer_Trx_All       Rcta
                    ,Ra_Cust_Trx_Types_All     Rctta
               Where Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
                 And Zl.Trx_Id = Jbctle.Customer_Trx_Id
                 And Zl.Trx_Line_Id = Jbctle.Customer_Trx_Line_Id
                 And Arvt.Vat_Tax_Id = Zl.Tax_Rate_Id
                 And Arvt.Org_Id = Zl.Internal_Organization_Id
                 And Arvt.Global_Attribute2 = 'N'
                 And Arvt.Global_Attribute10 = 'IPI'
                 And Rcta.Customer_Trx_Id = Jbctle.Customer_Trx_Id
                 And Rctta.Cust_Trx_Type_Id = Rcta.Cust_Trx_Type_Id
                 And Rctta.Global_Attribute5 = '4'
                 And Nvl(Regexp_Replace((Jbctle.Perc_Returned_Goods * 100), '[^0-9]'), '0') > '0'
              Union All
              Select Regexp_Replace((Abs(Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0)) * 100), '[^0-9]') Valor
                    ,'VL_IPI_DEVOL' Atributo
                From Zx_Lines                  Zl
                    ,Ar_Vat_Tax_All            Arvt
                    ,Ra_Customer_Trx_Lines_All Rctla
               Where Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Rctla.Line_Type = 'LINE'
                 And Arvt.Global_Attribute10 = 'IPI'
                 And Arvt.Global_Attribute2 = 'N'
                 And Zl.Trx_Id = p_Customer_Trx_Id
                 And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) > 0
                 And p_Dm_Fin_Nfe = 4
              Union All
              Select Regexp_Replace(Jbctle.Reinf_Service_Classification, '[^0-9]') Valor
                    ,'CD_TP_SERV_REINF' Atributo
                From Jl_Br_Cust_Trx_Lines_Exts Jbctle
               Where Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
                 And Jbctle.Reinf_Service_Classification Is Not Null
              Union All
              Select Regexp_Replace('0', '[^0-9]') Valor
                    ,'DM_IND_CPRB' Atributo
                From Dual
               Where p_Rvcinf.Cd_Lista_Serv Is Not Null
              Union All
              Select Valor
                    ,'COD_OCOR_AJ_ICMS' Atributo
                From (Select Nvl(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cod_Ocor_Aj_Icms_f(p_Customer_Trx_Line_Id), Xxisv_Csf_Nfe_Custom_Pkg.Get_Nfe_Cod_Ocor_Aj_Icms_f(p_Customer_Trx_Line_Id)) Valor
                        From Dual)
              Union All
              Select Valor
                    ,'COD_INF_ADIC_VLR_DECL' Atributo
                From (Select Xxisv_Csf_Nfe_Pkg.Get_Nfe_Cbenef_f(p_Uf => (Select Cfe.Region_2
                                                                           From Cll_F255_Establishment_v Cfe
                                                                          Where Cfe.Inventory_Organization_Id =
                                                                                Rctla.Warehouse_Id), p_Tipo_Transacao => p_Tipo_Transacao, p_Cfop => p_Rvcinf.Cfop, p_Cst => p_Rvcinf.Orig ||
                                                                          Nvl(Lpad(Arvt.Global_Attribute9, 2, '0'), Rctla.Global_Attribute7), p_Ncm => p_Rvcinf.Cod_Ncm) Valor
                        From Zx_Lines                  Zl
                            ,Ar_Vat_Tax_All            Arvt
                            ,Ra_Customer_Trx_Lines_All Rctla
                       Where Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                         And Zl.Internal_Organization_Id = Arvt.Org_Id
                         And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                         And Zl.Trx_Id = Rctla.Customer_Trx_Id
                         And Rctla.Line_Type = 'LINE'
                         And Arvt.Global_Attribute2 = 'Y'
                         And Arvt.Global_Attribute10 = 'ICMS'
                         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id)
              Union All
              /*NRO_CHAVE_REF/NRO_ITEM_REF: referencia da nota de origem para NFe de devolucao do RI -- Carranza 08/09/2026*/
              Select Cfil.Invoice_Key_Doc_Ref Valor
                    ,'NRO_CHAVE_REF' Atributo
                From Ra_Customer_Trx_Lines_All Rctla
                    ,Cll_F189_Invoice_Lines    Cfil
               Where Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Rctla.Interface_Line_Context = 'CLL F189 INTEGRATED RCV'
                 And Cfil.Invoice_Line_Id = Rctla.Interface_Line_Attribute4
                 And Cfil.Invoice_Key_Doc_Ref is not null
              Union All
              Select To_Char(Cfil.Item_Number_Doc_Ref) Valor
                    ,'NRO_ITEM_REF' Atributo
                From Ra_Customer_Trx_Lines_All Rctla
                    ,Cll_F189_Invoice_Lines    Cfil
               Where Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Rctla.Interface_Line_Context = 'CLL F189 INTEGRATED RCV'
                 And Cfil.Invoice_Line_Id = Rctla.Interface_Line_Attribute4
                 And Cfil.Item_Number_Doc_Ref is not null)
       Where Valor Is Not Null; -- Carranza 08/09/2026
    --
    R1 C1%Rowtype;
  Begin
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Item_Nota_Fiscal_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Item
          ,Atributo
          ,Valor)
        Values
          (p_Rvcinf.Cpf_Cnpj_Emit
          ,p_Rvcinf.Dm_Ind_Emit
          ,p_Rvcinf.Dm_Ind_Oper
          ,p_Rvcinf.Cod_Part
          ,p_Rvcinf.Cod_Mod
          ,p_Rvcinf.Serie
          ,p_Rvcinf.Nro_Nf
          ,p_Rvcinf.Nro_Item
          ,p_Rvcinf.Cod_Item
          ,R1.Atributo
          ,R1.Valor);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Item_Nota_Fiscal_Ff_P - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcinf.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcinf.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcinf.Cod_Mod || ', Serie: ' ||
                         p_Rvcinf.Serie || ', Nro_Nf: ' || p_Rvcinf.Nro_Nf ||
                         ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Item_Nota_Fiscal_Ff_P - ' || ' Erro: ' ||
                     Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Item_Nota_Fiscal_Ff_p;

  ---
  -------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnf_Compl ---
  -------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnf_Compl_p(p_Rvcinf            Vw_Csf_Item_Nota_Fiscal%Rowtype
                                 ,p_Inventory_Item_Id Number
                                 ,p_Rotina            Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
  Begin
    If p_Inventory_Item_Id Is Not Null
    Then
      ---
      Begin
        Insert Into Vw_Csf_Itemnf_Compl
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Id_Item_Erp
          ,Cod_Class
          ,Dm_Ind_Rec
          ,Cod_Part_Item
          ,Dm_Ind_Rec_Com
          ,Cod_Nat)
        Values
          (p_Rvcinf.Cpf_Cnpj_Emit
          ,p_Rvcinf.Dm_Ind_Emit
          ,p_Rvcinf.Dm_Ind_Oper
          ,p_Rvcinf.Cod_Part
          ,p_Rvcinf.Cod_Mod
          ,p_Rvcinf.Serie
          ,p_Rvcinf.Nro_Nf
          ,p_Rvcinf.Nro_Item
          ,p_Inventory_Item_Id
          ,Null
          ,Null
          ,Null
          ,Null
          ,Null);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'VW_CSF_ITEMNF_COMPL_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                         ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      ---
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_ITEMNF_COMPL_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Itemnf_Compl_p;

  ---
  -------------------------------------------------------------------------
  ---- Procedure utilizada para inclusão de dados na Vw_Csf_Imp_Itemnf ----
  -------------------------------------------------------------------------
  Procedure Vw_Csf_Imp_Itemnf_p(p_Rvcinf                 Vw_Csf_Item_Nota_Fiscal%Rowtype
                               ,p_Customer_Trx_Line_Id   Number
                               ,p_Customer_Trx_Id        Number
                               ,p_Interface_Line_Context Varchar2
                               ,p_Cclass_Trib_Cbs        Varchar2
                               ,p_Cclass_Trib_Ibs        Varchar2
                               ,p_Rotina                 Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select Aux.Line_Number
            ,Aux.Interface_Line_Attribute6
            ,Aux.Cod_Imposto
            ,Aux.Dm_Tipo
            ,Aux.Cod_St
            ,Nvl(Abs(Sum(Nvl(Aux.Vl_Base_Calc, 0))), 0) Vl_Base_Calc
            ,Aux.Aliq_Apli
            ,Nvl(Abs(Sum(Nvl(Aux.Vl_Imp_Trib, 0))), 0) Vl_Imp_Trib
            ,Aux.Perc_Reduc
            ,Aux.Perc_Adic
            ,Aux.Qtde_Base_Calc_Prod
            ,Aux.Vl_Aliq_Prod
            ,Aux.Perc_Bc_Oper_Prop
            ,Aux.Ufst
            ,Aux.Vl_Bc_St_Ret
            ,Aux.Vl_Icmsst_Ret
            ,Aux.Vl_Bc_St_Dest
            ,Aux.Vl_Icmsst_Dest
            ,Aux.Cclass_Trib_Ibs
            ,Aux.Cclass_Trib_Cbs
        From (
              /*Imposto Item*/
              Select Rctla.Line_Number
                     ,Rctla.Interface_Line_Attribute6 Interface_Line_Attribute6
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS' Then
                         1
                        When Arvt.Global_Attribute10 = 'ICMS-ST' Then
                         2
                        When Arvt.Global_Attribute10 = 'IPI' Then
                         3
                        When Arvt.Global_Attribute10 = 'PIS' Then
                         4
                        When Arvt.Global_Attribute10 = 'COFINS' Then
                         5
                        When Arvt.Global_Attribute10 = 'ISS' Then
                         6
                        When Arvt.Global_Attribute10 = 'II' Then
                         7
                        When Arvt.Global_Attribute10 = 'PIS-ST' Then
                         8
                        When Arvt.Global_Attribute10 = 'COFINS-ST' Then
                         9
                        When Arvt.Global_Attribute10 = 'SN' Then
                         10
                        When Arvt.Global_Attribute10 = 'CSLL' Then
                         11
                      --When Arvt.Global_Attribute10 = 'IRRF' Then -- Carranza 17/09/2025
                        When Arvt.Global_Attribute10 In ('IRRF', 'IR-RET') Then
                         12
                        When Arvt.Global_Attribute10 = 'INSS' Then
                         13
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         28
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         29
                        When Arvt.Global_Attribute10 = 'IS' Then
                         30
                      End Cod_Imposto
                     ,Case
                        When Arvt.Global_Attribute11 = 'Y' Then
                         1
                        Else
                         0
                      End Dm_Tipo
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS' Then
                         Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7)
                        When Arvt.Global_Attribute10 = 'IPI'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Nvl(Lpad(Arvt.Global_Attribute4, 2, 0), Rctla.Global_Attribute6)
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Lpad(Arvt.Global_Attribute6, 2, 0)
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Lpad(Arvt.Global_Attribute7, 2, 0)
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         Lpad(Coalesce(Arvt.Global_Attribute19, p_Cclass_Trib_Ibs), 3, 0)
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         Lpad(Coalesce(Arvt.Global_Attribute19, p_Cclass_Trib_Cbs), 3, 0)
                        Else
                         Null
                      End Cod_St
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS'
                             And Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7) Not In
                            /*('30', '40', '41', '50', '60', '90') Then*/ -- Carranza 08/05/2020
                             ('30', '40', '41', '50', '51', '60', '90') Then -- Carranza 08/05/2020
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'ICMS-ST' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'IPI'
                             And Nvl(Lpad(Arvt.Global_Attribute4, 2, 0), Rctla.Global_Attribute6) Not In
                             ('02', '03', '04', '05', '52', '53', '54', '55') Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Nvl(Arvt.Global_Attribute11, 'N') = 'N'
                             And Lpad(Arvt.Global_Attribute6, 2, 0) Not In
                             ('04', '07', '08', '09', '71', '72', '74')
                             And Abs(Zl.Tax_Rate) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Arvt.Global_Attribute11 = 'Y' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Nvl(Arvt.Global_Attribute11, 'N') = 'N'
                             And Lpad(Arvt.Global_Attribute7, 2, 0) Not In
                             ('04', '07', '08', '09', '71', '72', '74')
                             And Abs(Zl.Tax_Rate) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Arvt.Global_Attribute11 = 'Y' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'ISS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'II'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS-ST'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS-ST'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Abs(Zl.Taxable_Amt)
                        When Arvt.Global_Attribute10 = 'SN'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'CSLL'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                      --When Arvt.Global_Attribute10 = 'IRRF' -- Carranza 17/09/2025
                        When Arvt.Global_Attribute10 In ('IRRF', 'IR-RET') -- Carranza 17/09/2025
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'INSS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 Like 'IBS%'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'CBS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'IS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        Else
                         0
                      End Vl_Base_Calc
                     ,Abs(Zl.Tax_Rate) Aliq_Apli
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) Vl_Imp_Trib
                      /*,Case
                        When Zl.Tax_Base_Modifier_Rate < 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Reduc*/ -- Carranza 02/04/2026
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS'
                             And Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7) In
                             ('51') Then
                         0
                        When Zl.Tax_Base_Modifier_Rate < 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Reduc -- Carranza 02/04/2026
                     ,Case
                        When Zl.Tax_Base_Modifier_Rate > 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Adic
                     ,Null Qtde_Base_Calc_Prod
                     ,Null Vl_Aliq_Prod
                     ,Null Perc_Bc_Oper_Prop
                     ,Null Ufst
                     ,Null Vl_Bc_St_Ret
                     ,Null Vl_Icmsst_Ret
                     ,Null Vl_Bc_St_Dest
                     ,Null Vl_Icmsst_Dest
                     ,Rctla.Customer_Trx_Line_Id Customer_Trx_Line_Id
                     ,Case
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         Substr(Coalesce(Arvt.Global_Attribute20, p_Cclass_Trib_Ibs), 1, 6)
                        Else
                         Null
                      End Cclass_Trib_Ibs
                     ,Case
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         Substr(Coalesce(Arvt.Global_Attribute20, p_Cclass_Trib_Cbs), 1, 6)
                        Else
                         Null
                      End Cclass_Trib_Cbs
                From Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') Not In
                    /*('Nulo', 'ICMS-FP', 'ICMS-ST-FP')*/ -- Carranza 21/08/2025
                     ('Nulo', 'ICMS-FP', 'ICMS-ST-FP', 'TTD', 'DIFAL-DEST', 'IBSMUN') -- Carranza 21/08/2025
                 And Arvt.Global_Attribute2 = 'Y'
                 And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
                 And (Rctla.Interface_Line_Attribute11 = 0 Or
                     Rctla.Interface_Line_Attribute11 Is Null)
                 And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null)
              -----
              Union
              -----
              /*Imposto Desconto (Deduz o valor de desconto no calculo do imposto do item)*/
              Select Rctla.Line_Number
                     ,Rctla.Interface_Line_Attribute6 Interface_Line_Attribute6
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS' Then
                         1
                        When Arvt.Global_Attribute10 = 'ICMS-ST' Then
                         2
                        When Arvt.Global_Attribute10 = 'IPI' Then
                         3
                        When Arvt.Global_Attribute10 = 'PIS' Then
                         4
                        When Arvt.Global_Attribute10 = 'COFINS' Then
                         5
                        When Arvt.Global_Attribute10 = 'ISS' Then
                         6
                        When Arvt.Global_Attribute10 = 'II' Then
                         7
                        When Arvt.Global_Attribute10 = 'PIS-ST' Then
                         8
                        When Arvt.Global_Attribute10 = 'COFINS-ST' Then
                         9
                        When Arvt.Global_Attribute10 = 'SN' Then
                         10
                        When Arvt.Global_Attribute10 = 'CSLL' Then
                         11
                      --When Arvt.Global_Attribute10 = 'IRRF' Then -- Carranza 17/09/2025
                        When Arvt.Global_Attribute10 In ('IRRF', 'IR-RET') Then
                         12
                        When Arvt.Global_Attribute10 = 'INSS' Then
                         13
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         28
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         29
                        When Arvt.Global_Attribute10 = 'IS' Then
                         30
                      End Cod_Imposto
                     ,Case
                        When Arvt.Global_Attribute11 = 'Y' Then
                         1
                        Else
                         0
                      End Dm_Tipo
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS' Then
                         Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7)
                        When Arvt.Global_Attribute10 = 'IPI'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Nvl(Lpad(Arvt.Global_Attribute4, 2, 0), Rctla.Global_Attribute6)
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Lpad(Arvt.Global_Attribute6, 2, 0)
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Lpad(Arvt.Global_Attribute7, 2, 0)
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         Lpad(Coalesce(Arvt.Global_Attribute19, p_Cclass_Trib_Ibs), 3, 0)
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         Lpad(Coalesce(Arvt.Global_Attribute19, p_Cclass_Trib_Cbs), 3, 0)
                        Else
                         Null
                      End Cod_St
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS'
                             And Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7) Not In
                             ('30', '40', '41', '50', '51', '60', '90') Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'ICMS-ST' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'IPI'
                             And Nvl(Lpad(Arvt.Global_Attribute4, 2, 0), Rctla.Global_Attribute6) Not In
                             ('02', '03', '04', '05', '52', '53', '54', '55') Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Nvl(Arvt.Global_Attribute11, 'N') = 'N'
                             And Lpad(Arvt.Global_Attribute6, 2, 0) Not In
                             ('04', '07', '08', '09', '71', '72', '74')
                             And Abs(Zl.Tax_Rate) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Arvt.Global_Attribute11 = 'Y' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Nvl(Arvt.Global_Attribute11, 'N') = 'N'
                             And Lpad(Arvt.Global_Attribute7, 2, 0) Not In
                             ('04', '07', '08', '09', '71', '72', '74')
                             And Abs(Zl.Tax_Rate) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Arvt.Global_Attribute11 = 'Y' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'ISS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'II'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS-ST'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS-ST'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'SN'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'CSLL'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                      --When Arvt.Global_Attribute10 = 'IRRF' -- Carranza 17/09/2025
                        When Arvt.Global_Attribute10 In ('IRRF', 'IR-RET') -- Carranza 17/09/2025
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'INSS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 Like 'IBS%'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'CBS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'IS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        Else
                         0
                      End Vl_Base_Calc
                     ,Abs(Zl.Tax_Rate) Aliq_Apli
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) Vl_Imp_Trib
                      /*,Case
                        When Zl.Tax_Base_Modifier_Rate < 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Reduc*/ -- Carranza 02/04/2026
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS'
                             And Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7) In
                             ('51') Then
                         0
                        When Zl.Tax_Base_Modifier_Rate < 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Reduc -- Carranza 02/04/2026
                     ,Case
                        When Zl.Tax_Base_Modifier_Rate > 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Adic
                     ,Null Qtde_Base_Calc_Prod
                     ,Null Vl_Aliq_Prod
                     ,Null Perc_Bc_Oper_Prop
                     ,Null Ufst
                     ,Null Vl_Bc_St_Ret
                     ,Null Vl_Icmsst_Ret
                     ,Null Vl_Bc_St_Dest
                     ,Null Vl_Icmsst_Dest
                     ,Rctla.Customer_Trx_Line_Id Customer_Trx_Line_Id
                     ,Case
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         Substr(Coalesce(Arvt.Global_Attribute20, p_Cclass_Trib_Ibs), 1, 6)
                        Else
                         Null
                      End Cclass_Trib_Ibs
                     ,Case
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         Substr(Coalesce(Arvt.Global_Attribute20, p_Cclass_Trib_Cbs), 1, 6)
                        Else
                         Null
                      End Cclass_Trib_Cbs
                From Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Ra_Customer_Trx_Lines_All Rctlad
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctlad.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctlad.Customer_Trx_Id
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') Not In
                    /*('Nulo', 'ICMS-FP', 'ICMS-ST-FP')*/ -- Carranza 21/08/2025
                     ('Nulo', 'ICMS-FP', 'ICMS-ST-FP', 'TTD', 'DIFAL-DEST', 'IBSMUN') -- Carranza 21/08/2025
                 And Arvt.Global_Attribute2 = 'Y'
                 And Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And (Rctla.Interface_Line_Attribute11 = '0' Or
                     Rctla.Interface_Line_Attribute11 Is Null)
                 And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null)
                 And Rctlad.Customer_Trx_Id = Rctla.Customer_Trx_Id
                 And Rctlad.Interface_Line_Attribute6 =
                     Rctla.Interface_Line_Attribute6
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Rctlad.Line_Type = 'LINE'
                 And Rctlad.Interface_Line_Attribute11 Is Not Null
              ----
              Union
              ----
              /*Imposto Frete (Acrescenta o valor do frete no calculo do imposto do item)*/
              Select Rctla2.Line_Number
                     ,Rctla2.Interface_Line_Attribute6 Interface_Line_Attribute6
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS' Then
                         1
                        When Arvt.Global_Attribute10 = 'ICMS-ST' Then
                         2
                        When Arvt.Global_Attribute10 = 'IPI' Then
                         3
                        When Arvt.Global_Attribute10 = 'PIS' Then
                         4
                        When Arvt.Global_Attribute10 = 'COFINS' Then
                         5
                        When Arvt.Global_Attribute10 = 'ISS' Then
                         6
                        When Arvt.Global_Attribute10 = 'II' Then
                         7
                        When Arvt.Global_Attribute10 = 'PIS-ST' Then
                         8
                        When Arvt.Global_Attribute10 = 'COFINS-ST' Then
                         9
                        When Arvt.Global_Attribute10 = 'SN' Then
                         10
                        When Arvt.Global_Attribute10 = 'CSLL' Then
                         11
                      --When Arvt.Global_Attribute10 = 'IRRF' Then -- Carranza 17/09/2025
                        When Arvt.Global_Attribute10 In ('IRRF', 'IR-RET') Then
                         12
                        When Arvt.Global_Attribute10 = 'INSS' Then
                         13
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         28
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         29
                        When Arvt.Global_Attribute10 = 'IS' Then
                         30
                      End Cod_Imposto
                     ,Case
                        When Arvt.Global_Attribute11 = 'Y' Then
                         1
                        Else
                         0
                      End Dm_Tipo
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS' Then
                         Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7)
                        When Arvt.Global_Attribute10 = 'IPI'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Nvl(Lpad(Arvt.Global_Attribute4, 2, 0), Rctla.Global_Attribute6)
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Lpad(Arvt.Global_Attribute6, 2, 0)
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Nvl(Arvt.Global_Attribute11, 'N') <> 'Y' Then
                         Lpad(Arvt.Global_Attribute7, 2, 0)
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         Lpad(Coalesce(Arvt.Global_Attribute19, p_Cclass_Trib_Ibs), 3, 0)
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         Lpad(Coalesce(Arvt.Global_Attribute19, p_Cclass_Trib_Cbs), 3, 0)
                        Else
                         Null
                      End Cod_St
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS'
                             And Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7) Not In
                             ('30', '40', '41', '50', '51', '60', '90') Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'ICMS-ST' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'IPI'
                             And Nvl(Lpad(Arvt.Global_Attribute4, 2, 0), Rctla.Global_Attribute6) Not In
                             ('02', '03', '04', '05', '52', '53', '54', '55') Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Nvl(Arvt.Global_Attribute11, 'N') = 'N'
                             And Lpad(Arvt.Global_Attribute6, 2, 0) Not In
                             ('04', '07', '08', '09', '71', '72', '74')
                             And Abs(Zl.Tax_Rate) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS'
                             And Arvt.Global_Attribute11 = 'Y' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Nvl(Arvt.Global_Attribute11, 'N') = 'N'
                             And Lpad(Arvt.Global_Attribute7, 2, 0) Not In
                             ('04', '07', '08', '09', '71', '72', '74')
                             And Abs(Zl.Tax_Rate) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS'
                             And Arvt.Global_Attribute11 = 'Y' Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'ISS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'II'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'PIS-ST'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'COFINS-ST'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Abs(Zl.Taxable_Amt)
                        When Arvt.Global_Attribute10 = 'SN'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'CSLL'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                      --When Arvt.Global_Attribute10 = 'IRRF' -- Carranza 17/09/2025
                        When Arvt.Global_Attribute10 In ('IRRF', 'IR-RET') -- Carranza 17/09/2025
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'INSS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 Like 'IBS%'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'CBS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        When Arvt.Global_Attribute10 = 'IS'
                             And Abs(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) > 0 Then
                         Zl.Taxable_Amt
                        Else
                         0
                      End Vl_Base_Calc
                     ,Abs(Zl.Tax_Rate) Aliq_Apli
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) Vl_Imp_Trib
                      /*,Case
                        When Zl.Tax_Base_Modifier_Rate < 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Reduc*/ -- Carranza 02/04/2026
                     ,Case
                        When Arvt.Global_Attribute10 = 'ICMS'
                             And Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7) In
                             ('51') Then
                         0
                        When Zl.Tax_Base_Modifier_Rate < 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Reduc -- Carranza 02/04/2026
                     ,Case
                        When Zl.Tax_Base_Modifier_Rate > 0 Then
                         Abs(Zl.Tax_Base_Modifier_Rate)
                        Else
                         Null
                      End Perc_Adic
                     ,Null Qtde_Base_Calc_Prod
                     ,Null Vl_Aliq_Prod
                     ,Null Perc_Bc_Oper_Prop
                     ,Null Ufst
                     ,Null Vl_Bc_St_Ret
                     ,Null Vl_Icmsst_Ret
                     ,Null Vl_Bc_St_Dest
                     ,Null Vl_Icmsst_Dest
                     ,Rctla.Customer_Trx_Line_Id Customer_Trx_Line_Id
                     ,Case
                        When Arvt.Global_Attribute10 Like 'IBS%' Then
                         Substr(Coalesce(Arvt.Global_Attribute20, p_Cclass_Trib_Ibs), 1, 6)
                        Else
                         Null
                      End Cclass_Trib_Ibs
                     ,Case
                        When Arvt.Global_Attribute10 = 'CBS' Then
                         Substr(Coalesce(Arvt.Global_Attribute20, p_Cclass_Trib_Cbs), 1, 6)
                        Else
                         Null
                      End Cclass_Trib_Cbs
                From Ra_Customer_Trx_Lines_All Rctla2
                     ,Apps.Oe_Price_Adjustments Opa
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Rctla2.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Rctla2.Line_Type = 'LINE'
                 And Rctla2.Interface_Line_Context = 'ORDER ENTRY'
                 And Opa.Line_Id = Rctla2.Interface_Line_Attribute6
                 And Opa.Charge_Type_Code = 'FREIGHT'
                 And Opa.Arithmetic_Operator = 'AMT'
                 And Rctla.Interface_Line_Attribute6 =
                     To_Char(Opa.Price_Adjustment_Id)
                 And Rctla.Sales_Order = Rctla2.Sales_Order
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Arvt.Vat_Tax_Id = Zl.Tax_Rate_Id
                 And Arvt.Org_Id = Zl.Internal_Organization_Id
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') Not In
                    /*('Nulo', 'ICMS-FP', 'ICMS-ST-FP')*/ -- Carranza 21/08/2025
                     ('Nulo', 'ICMS-FP', 'ICMS-ST-FP', 'TTD', 'DIFAL-DEST', 'IBSMUN') -- Carranza 21/08/2025
                 And Arvt.Global_Attribute2 = 'Y'
                 And Msib.Item_Type = 'FRT') Aux
       Group By Aux.Line_Number
               ,Aux.Interface_Line_Attribute6
               ,Aux.Cod_Imposto
               ,Aux.Dm_Tipo
               ,Aux.Cod_St
               ,Aux.Aliq_Apli
               ,Aux.Perc_Reduc
               ,Aux.Perc_Adic
               ,Aux.Qtde_Base_Calc_Prod
               ,Aux.Vl_Aliq_Prod
               ,Aux.Perc_Bc_Oper_Prop
               ,Aux.Ufst
               ,Aux.Vl_Bc_St_Ret
               ,Aux.Vl_Icmsst_Ret
               ,Aux.Vl_Bc_St_Dest
               ,Aux.Vl_Icmsst_Dest
               ,Aux.Cclass_Trib_Ibs
               ,Aux.Cclass_Trib_Cbs;
    R1 C1%Rowtype;
    --
    l_Rvcii Vw_Csf_Imp_Itemnf%Rowtype;
    --
    l_Ibs_Found Boolean := False; -- Carranza 08/09/2026
    l_Cbs_Found Boolean := False; -- Carranza 08/09/2026
    --
    /*Cursor para recuperar os dados de PIS e COFINS do RI pois essa informação não é enviada ao AR*/
    Cursor C2 Is
      Select Null Cod_Imposto
            ,0 Dm_Tipo
            ,'49' Cod_St_Pc /*Por se referir a uma operação de saída, a devolução de compra deve ser escriturada com o CST 49 (Guia Prático da EFD Contribuições ¿ Versão 1.22: Atualização em 31/07/2017)*/
            ,Case
               When Nvl(Cfil.Pis_Amount_Recover, 0) > 0 Then
                Round(Cfil.Pis_Base_Amount, 2)
               Else
                0
             End Vl_Base_Calc_Pis
            ,Case
               When Nvl(Cfil.Cofins_Amount_Recover, 0) > 0 Then
                Round(Cfil.Cofins_Base_Amount, 2)
               Else
                0
             End Vl_Base_Calc_Cofins
            ,Case
               When Nvl(Cfil.Pis_Amount_Recover, 0) > 0 Then
                Abs(Round(Cfil.Pis_Tax_Rate, 4))
               Else
                0
             End Aliq_Apli_Pis
            ,Case
               When Nvl(Cfil.Cofins_Amount_Recover, 0) > 0 Then
                Abs(Round(Cfil.Cofins_Tax_Rate, 4))
               Else
                0
             End Aliq_Apli_Cofins
            ,Abs(Nvl(Round(Cfil.Pis_Amount_Recover, 2), 0)) Vl_Imp_Trib_Pis
            ,Abs(Nvl(Round(Cfil.Cofins_Amount_Recover, 2), 0)) Vl_Imp_Trib_Cofins
            ,Case
               When Substr(Cfil.Tributary_Status_Code, 2) = '101' Then
                '00'
               When Substr(Cfil.Tributary_Status_Code, 2) = '102' Then
                '00'
               When Substr(Cfil.Tributary_Status_Code, 2) = '103' Then
                '40'
               When Substr(Cfil.Tributary_Status_Code, 2) = '400' Then
                '41'
               When Substr(Cfil.Tributary_Status_Code, 2) = '201' Then
                '10'
               When Substr(Cfil.Tributary_Status_Code, 2) = '202' Then
                '10'
               When Substr(Cfil.Tributary_Status_Code, 2) = '203' Then
                '40'
               When Substr(Cfil.Tributary_Status_Code, 2) = '500' Then
                '60'
               When Substr(Cfil.Tributary_Status_Code, 2) = '900' Then
                '90'
               Else
                Substr(Cfil.Tributary_Status_Code, 2)
             End Cod_St_Icms
            ,Nvl(Round(Cfil.Icms_Base, 2), 0) Vl_Base_Calc_Icms
            ,Nvl(Round(Cfil.Icms_Tax, 4), 0) Aliq_Apli_Icms
            ,Nvl(Round(Cfil.Icms_Amount, 2), 0) Vl_Imp_Trib_Icms
             /*,Null Perc_Reduc*/ -- Carranza 29/05/2019
            ,Cfil.Icms_Base_Reduc_Perc Perc_Reduc -- Carranza 29/05/2019
             /*,Null Perc_Adic*/ -- Carranza 20/11/2019
             /*,(Select Zl.Tax_Base_Modifier_Rate
              From Zx_Lines Zl
             Where 1 = 1
               And Zl.Trx_Id = Rctla.Customer_Trx_Id
               And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
               And Nvl(Zl.Tax_Base_Modifier_Rate, 0) > 0) Perc_Adic -- Carranza 20/11/2019*/ -- Carranza 31/08/2023
            ,Null Perc_Adic -- Carranza 31/08/2023
            ,Cfil.Ipi_Tributary_Code Cod_St_Ipi
            ,Case
               When Cfil.Ipi_Tax_Code In (2, 3) Then
                0
               When Cfil.Ipi_Tax_Code In (1) Then
                Nvl(Cfil.Ipi_Base_Amount, 0)
             End Vl_Base_Calc_Ipi
            ,Case
               When Cfil.Ipi_Tax_Code In (2, 3) Then
                0
               When Cfil.Ipi_Tax_Code In (1) Then
                Nvl(Cfil.Ipi_Tax, 0)
             End Aliq_Apli_Ipi
            ,Case
               When Cfil.Ipi_Tax_Code In (2, 3) Then
                0
               When Cfil.Ipi_Tax_Code In (1) Then
                Nvl(Cfil.Ipi_Amount, 0)
             End Vl_Imp_Trib_Ipi
             /*,Case
                When Cfil.Icms_St_Amount_Recover > 0 Then
                 Nvl(Round(Cfil.Icms_St_Base, 2), 0)
                Else
                 0
              End Vl_Base_Calc_Icms_St
             ,Case
                When Cfil.Icms_St_Amount_Recover > 0 Then
                 Round((Nvl(Cfil.Icms_St_Amount_Recover, 0) /
                       Nvl(Cfil.Icms_St_Base, 0) * 100), 4)
                Else
                 0
              End Aliq_Apli_Icms_St
             ,Nvl(Round(Cfil.Icms_St_Amount_Recover, 2), 0) Vl_Imp_Trib_Icms_St*/ -- Carranza 28/06/2019 -- Verificar regra
            ,Case
               When Substr(Cfil.Tributary_Status_Code, 2) In
                    (10, 30, 60, 70, 81) Then
                Nvl(Round(Cfil.Icms_St_Base, 2), 0)
               Else
                0
             End Vl_Base_Calc_Icms_St -- Carranza 28/06/2019 -- Verificar regra
            ,Case
               When Substr(Cfil.Tributary_Status_Code, 2) In
                    (10, 30, 60, 70, 81)
                    And Nvl(Cfil.Icms_St_Base, 0) > 0 Then
                Round((Nvl(Cfil.Icms_St_Amount, 0) / Nvl(Cfil.Icms_St_Base, 0) * 100), 4)
               Else
                0
             End Aliq_Apli_Icms_St -- Carranza 28/06/2019 -- Verificar regra
            ,Case
               When Substr(Cfil.Tributary_Status_Code, 2) In
                    (10, 30, 60, 70, 81) Then
                Nvl(Round(Cfil.Icms_St_Amount, 2), 0)
               Else
                0
             End Vl_Imp_Trib_Icms_St -- Carranza 28/06/2019 -- Verificar regra
            ,Null Qtde_Base_Calc_Prod
            ,Null Vl_Aliq_Prod
            ,Null Perc_Bc_Oper_Prop
            ,Null Ufst
            ,Null Vl_Bc_St_Ret
            ,Null Vl_Icmsst_Ret
            ,Null Vl_Bc_St_Dest
            ,Null Vl_Icmsst_Dest
        From Ra_Customer_Trx_Lines_All Rctla
            ,Cll_F189_Invoice_Lines    Cfil
       Where Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctla.Interface_Line_Context = 'CLL F189 INTEGRATED RCV'
         And Cfil.Invoice_Line_Id = Rctla.Interface_Line_Attribute4; /*Incluido para buscar todos os impostos do RI de Devolução*/
    R2 C2%Rowtype;
    --
    /*Cursor para recuperar o ICMS-ST de devolução 5411/6411 de empresa não contribuinte do ICMS-ST*/
    Cursor C3 Is
      Select Case
               When Arvt.Global_Attribute10 = 'ICMS-ST' Then
                2
             End Cod_Imposto
            ,Case
               When Arvt.Global_Attribute11 = 'Y' Then
                1
               Else
                0
             End Dm_Tipo
            ,Null Cod_St
            ,0 Vl_Base_Calc
            ,0 Aliq_Apli
            ,0 Vl_Imp_Trib
            ,Null Perc_Reduc
            ,Case
               When Zl.Tax_Base_Modifier_Rate > 0 Then
                Abs(Zl.Tax_Base_Modifier_Rate)
               Else
                Null
             End Perc_Adic
            ,Null Qtde_Base_Calc_Prod
            ,Null Vl_Aliq_Prod
            ,Null Perc_Bc_Oper_Prop
            ,Null Ufst
            ,Null Vl_Bc_St_Ret
            ,Null Vl_Icmsst_Ret
            ,Null Vl_Bc_St_Dest
            ,Null Vl_Icmsst_Dest
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Arvt.Global_Attribute10 = 'ICMS-ST'
         And Arvt.Global_Attribute2 = 'N'
         And Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0) > 0
         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id;
    R3 C3%Rowtype;
    --
    /*Cursor para recuperar IBS e CBS do RI quando nao existir no AR (Attribute2 <> 'Y' ou sem linha no Zx_Lines) para notas de devolucao -- Carranza 08/09/2026*/
    Cursor C4 Is
      Select Nvl(Round(Cfil.Ibs_Base_Amount, 2), 0)   Vl_Base_Calc_Ibs
            ,Nvl(Round(Cfil.Ibs_Uf_Tax, 4), 0)         Aliq_Apli_Ibs
            ,Abs(Nvl(Round(Cfil.Ibs_Uf_Amount, 2), 0)) Vl_Imp_Trib_Ibs
            ,Cfil.Ibs_Tributary_Code                   Cod_St_Ibs
            ,Nvl(Round(Cfil.Cbs_Base_Amount, 2), 0)    Vl_Base_Calc_Cbs
            ,Nvl(Round(Cfil.Cbs_Tax, 4), 0)            Aliq_Apli_Cbs
            ,Abs(Nvl(Round(Cfil.Cbs_Amount, 2), 0))    Vl_Imp_Trib_Cbs
            ,Cfil.Cbs_Tributary_Code                   Cod_St_Cbs
        From Ra_Customer_Trx_Lines_All Rctla
            ,Cll_F189_Invoice_Lines    Cfil
       Where Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctla.Interface_Line_Context = 'CLL F189 INTEGRATED RCV'
         And Cfil.Invoice_Line_Id = Rctla.Interface_Line_Attribute4;
    R4 C4%Rowtype;
    --
  Begin
    If Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Imp_Itemnf_f(p_Rvcinf => p_Rvcinf, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Interface_Line_Context => p_Interface_Line_Context, p_Rotina => 'Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Imp_Itemnf_f') = 0
    Then
      --
      Open C1;
      Loop
        Fetch C1
          Into R1;
        Exit When C1%Notfound;
        ---
        l_Rvcii.Cpf_Cnpj_Emit       := p_Rvcinf.Cpf_Cnpj_Emit;
        l_Rvcii.Dm_Ind_Emit         := p_Rvcinf.Dm_Ind_Emit;
        l_Rvcii.Dm_Ind_Oper         := p_Rvcinf.Dm_Ind_Oper;
        l_Rvcii.Cod_Part            := p_Rvcinf.Cod_Part;
        l_Rvcii.Cod_Mod             := p_Rvcinf.Cod_Mod;
        l_Rvcii.Serie               := p_Rvcinf.Serie;
        l_Rvcii.Nro_Nf              := p_Rvcinf.Nro_Nf;
        l_Rvcii.Nro_Item            := p_Rvcinf.Nro_Item;
        l_Rvcii.Cod_Imposto         := R1.Cod_Imposto;
        l_Rvcii.Dm_Tipo             := R1.Dm_Tipo;
        l_Rvcii.Cod_St              := R1.Cod_St;
        l_Rvcii.Vl_Base_Calc        := R1.Vl_Base_Calc;
        l_Rvcii.Aliq_Apli           := R1.Aliq_Apli;
        l_Rvcii.Vl_Imp_Trib         := R1.Vl_Imp_Trib;
        l_Rvcii.Perc_Reduc          := R1.Perc_Reduc;
        l_Rvcii.Perc_Adic           := R1.Perc_Adic;
        l_Rvcii.Qtde_Base_Calc_Prod := R1.Qtde_Base_Calc_Prod;
        l_Rvcii.Vl_Aliq_Prod        := R1.Vl_Aliq_Prod;
        l_Rvcii.Perc_Bc_Oper_Prop   := R1.Perc_Bc_Oper_Prop;
        l_Rvcii.Ufst                := R1.Ufst;
        l_Rvcii.Vl_Bc_St_Ret        := R1.Vl_Bc_St_Ret;
        l_Rvcii.Vl_Icmsst_Ret       := R1.Vl_Icmsst_Ret;
        l_Rvcii.Vl_Bc_St_Dest       := R1.Vl_Bc_St_Dest;
        l_Rvcii.Vl_Icmsst_Dest      := R1.Vl_Icmsst_Dest;
        --
        If R1.Cod_Imposto = 28 Then -- Carranza 08/09/2026
          l_Ibs_Found := True;
        Elsif R1.Cod_Imposto = 29 Then
          l_Cbs_Found := True;
        End If;
        --
        Begin
          Insert Into Vw_Csf_Imp_Itemnf
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Cod_St
            ,Vl_Base_Calc
            ,Aliq_Apli
            ,Vl_Imp_Trib
            ,Perc_Reduc
            ,Perc_Adic
            ,Qtde_Base_Calc_Prod
            ,Vl_Aliq_Prod
            ,Perc_Bc_Oper_Prop
            ,Ufst
            ,Vl_Bc_St_Ret
            ,Vl_Icmsst_Ret
            ,Vl_Bc_St_Dest
            ,Vl_Icmsst_Dest)
          Values
            (p_Rvcinf.Cpf_Cnpj_Emit
            ,p_Rvcinf.Dm_Ind_Emit
            ,p_Rvcinf.Dm_Ind_Oper
            ,p_Rvcinf.Cod_Part
            ,p_Rvcinf.Cod_Mod
            ,p_Rvcinf.Serie
            ,p_Rvcinf.Nro_Nf
            ,p_Rvcinf.Nro_Item
            ,R1.Cod_Imposto
            ,R1.Dm_Tipo
            ,R1.Cod_St
            ,R1.Vl_Base_Calc
            ,R1.Aliq_Apli
            ,R1.Vl_Imp_Trib
            ,R1.Perc_Reduc
            ,R1.Perc_Adic
            ,R1.Qtde_Base_Calc_Prod
            ,R1.Vl_Aliq_Prod
            ,R1.Perc_Bc_Oper_Prop
            ,R1.Ufst
            ,R1.Vl_Bc_St_Ret
            ,R1.Vl_Icmsst_Ret
            ,R1.Vl_Bc_St_Dest
            ,R1.Vl_Icmsst_Dest);
          --
          If R1.Cod_Imposto = 1
          Then
            Xxisv_Csf_Nfe_Pkg.Vw_Csf_Imp_Itemnf_Icms_Dest_p(p_Rvcii => l_Rvcii, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Cod_Imposto => R1.Cod_Imposto, p_Interface_Line_Context => p_Interface_Line_Context, p_Rotina => p_Rotina);
          End If;
          --
          If R1.Cod_Imposto = 1
             Or R1.Cod_Imposto = 2
             Or R1.Cod_Imposto = 28
             Or R1.Cod_Imposto = 29
          Then
            Xxisv_Csf_Nfe_Pkg.Vw_Csf_Imp_Itemnf_Ff_p(p_Rvcii => l_Rvcii, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Cod_Imposto => R1.Cod_Imposto, p_Cclass_Trib_Cbs => R1.Cclass_Trib_Cbs, p_Cclass_Trib_Ibs => R1.Cclass_Trib_Ibs, p_Rotina => p_Rotina);
          End If;
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                           ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                           p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                           R1.Cod_Imposto || ', Dm_Tipo: ' || R1.Dm_Tipo ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        ---
      End Loop;
      Close C1;
      --
      /*IBS/CBS: se nao veio do AR (Attribute2='Y'), busca no RI (Cll_F189_Invoice_Lines) para notas de devolucao -- Carranza 08/09/2026*/
      If Not l_Ibs_Found
         Or Not l_Cbs_Found
      Then
        --
        Open C4;
        Fetch C4
          Into R4;
        --
        If C4%Found
        Then
          --
          If Not l_Ibs_Found
             And Nvl(R4.Vl_Imp_Trib_Ibs, 0) > 0
          Then
            --
            l_Rvcii.Cpf_Cnpj_Emit       := p_Rvcinf.Cpf_Cnpj_Emit;
            l_Rvcii.Dm_Ind_Emit         := p_Rvcinf.Dm_Ind_Emit;
            l_Rvcii.Dm_Ind_Oper         := p_Rvcinf.Dm_Ind_Oper;
            l_Rvcii.Cod_Part            := p_Rvcinf.Cod_Part;
            l_Rvcii.Cod_Mod             := p_Rvcinf.Cod_Mod;
            l_Rvcii.Serie               := p_Rvcinf.Serie;
            l_Rvcii.Nro_Nf              := p_Rvcinf.Nro_Nf;
            l_Rvcii.Nro_Item            := p_Rvcinf.Nro_Item;
            l_Rvcii.Cod_Imposto         := 28;
            l_Rvcii.Dm_Tipo             := 0;
            l_Rvcii.Cod_St              := Lpad(Nvl(R4.Cod_St_Ibs, p_Cclass_Trib_Ibs), 3, 0);
            l_Rvcii.Vl_Base_Calc        := R4.Vl_Base_Calc_Ibs;
            l_Rvcii.Aliq_Apli           := R4.Aliq_Apli_Ibs;
            l_Rvcii.Vl_Imp_Trib         := R4.Vl_Imp_Trib_Ibs;
            l_Rvcii.Perc_Reduc          := Null;
            l_Rvcii.Perc_Adic           := Null;
            l_Rvcii.Qtde_Base_Calc_Prod := Null;
            l_Rvcii.Vl_Aliq_Prod        := Null;
            l_Rvcii.Perc_Bc_Oper_Prop   := Null;
            l_Rvcii.Ufst                := Null;
            l_Rvcii.Vl_Bc_St_Ret        := Null;
            l_Rvcii.Vl_Icmsst_Ret       := Null;
            l_Rvcii.Vl_Bc_St_Dest       := Null;
            l_Rvcii.Vl_Icmsst_Dest      := Null;
            --
            Begin
              Insert Into Vw_Csf_Imp_Itemnf
                (Cpf_Cnpj_Emit
                ,Dm_Ind_Emit
                ,Dm_Ind_Oper
                ,Cod_Part
                ,Cod_Mod
                ,Serie
                ,Nro_Nf
                ,Nro_Item
                ,Cod_Imposto
                ,Dm_Tipo
                ,Cod_St
                ,Vl_Base_Calc
                ,Aliq_Apli
                ,Vl_Imp_Trib
                ,Perc_Reduc
                ,Perc_Adic
                ,Qtde_Base_Calc_Prod
                ,Vl_Aliq_Prod
                ,Perc_Bc_Oper_Prop
                ,Ufst
                ,Vl_Bc_St_Ret
                ,Vl_Icmsst_Ret
                ,Vl_Bc_St_Dest
                ,Vl_Icmsst_Dest)
              Values
                (l_Rvcii.Cpf_Cnpj_Emit
                ,l_Rvcii.Dm_Ind_Emit
                ,l_Rvcii.Dm_Ind_Oper
                ,l_Rvcii.Cod_Part
                ,l_Rvcii.Cod_Mod
                ,l_Rvcii.Serie
                ,l_Rvcii.Nro_Nf
                ,l_Rvcii.Nro_Item
                ,l_Rvcii.Cod_Imposto
                ,l_Rvcii.Dm_Tipo
                ,l_Rvcii.Cod_St
                ,l_Rvcii.Vl_Base_Calc
                ,l_Rvcii.Aliq_Apli
                ,l_Rvcii.Vl_Imp_Trib
                ,l_Rvcii.Perc_Reduc
                ,l_Rvcii.Perc_Adic
                ,l_Rvcii.Qtde_Base_Calc_Prod
                ,l_Rvcii.Vl_Aliq_Prod
                ,l_Rvcii.Perc_Bc_Oper_Prop
                ,l_Rvcii.Ufst
                ,l_Rvcii.Vl_Bc_St_Ret
                ,l_Rvcii.Vl_Icmsst_Ret
                ,l_Rvcii.Vl_Bc_St_Dest
                ,l_Rvcii.Vl_Icmsst_Dest);
              --
              Xxisv_Csf_Nfe_Pkg.Vw_Csf_Imp_Itemnf_Ff_p(p_Rvcii => l_Rvcii, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Cod_Imposto => l_Rvcii.Cod_Imposto, p_Cclass_Trib_Cbs => Null, p_Cclass_Trib_Ibs => Substr(p_Cclass_Trib_Ibs, 1, 6), p_Rotina => p_Rotina);
              --
            Exception
              When Dup_Val_On_Index Then
                Null;
              When Others Then
                --
                g_Retcode   := 1;
                g_Erro      := Nvl(g_Erro, 0) + 1;
                l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P (IBS_RI) - ' || 'Cpf_Cnpj_Emit: ' ||
                               p_Rvcinf.Cpf_Cnpj_Emit || ', Cod_Mod: ' ||
                               p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                               ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                               p_Rvcinf.Nro_Item || ', Cod_Imposto: 28, Erro: ' ||
                               Sqlerrm;
                g_Erro_Msg  := l_Desc_Erro;
                --
                Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                --
            End;
            --
          End If;
          --
          If Not l_Cbs_Found
             And Nvl(R4.Vl_Imp_Trib_Cbs, 0) > 0
          Then
            --
            l_Rvcii.Cpf_Cnpj_Emit       := p_Rvcinf.Cpf_Cnpj_Emit;
            l_Rvcii.Dm_Ind_Emit         := p_Rvcinf.Dm_Ind_Emit;
            l_Rvcii.Dm_Ind_Oper         := p_Rvcinf.Dm_Ind_Oper;
            l_Rvcii.Cod_Part            := p_Rvcinf.Cod_Part;
            l_Rvcii.Cod_Mod             := p_Rvcinf.Cod_Mod;
            l_Rvcii.Serie               := p_Rvcinf.Serie;
            l_Rvcii.Nro_Nf              := p_Rvcinf.Nro_Nf;
            l_Rvcii.Nro_Item            := p_Rvcinf.Nro_Item;
            l_Rvcii.Cod_Imposto         := 29;
            l_Rvcii.Dm_Tipo             := 0;
            l_Rvcii.Cod_St              := Lpad(Nvl(R4.Cod_St_Cbs, p_Cclass_Trib_Cbs), 3, 0);
            l_Rvcii.Vl_Base_Calc        := R4.Vl_Base_Calc_Cbs;
            l_Rvcii.Aliq_Apli           := R4.Aliq_Apli_Cbs;
            l_Rvcii.Vl_Imp_Trib         := R4.Vl_Imp_Trib_Cbs;
            l_Rvcii.Perc_Reduc          := Null;
            l_Rvcii.Perc_Adic           := Null;
            l_Rvcii.Qtde_Base_Calc_Prod := Null;
            l_Rvcii.Vl_Aliq_Prod        := Null;
            l_Rvcii.Perc_Bc_Oper_Prop   := Null;
            l_Rvcii.Ufst                := Null;
            l_Rvcii.Vl_Bc_St_Ret        := Null;
            l_Rvcii.Vl_Icmsst_Ret       := Null;
            l_Rvcii.Vl_Bc_St_Dest       := Null;
            l_Rvcii.Vl_Icmsst_Dest      := Null;
            --
            Begin
              Insert Into Vw_Csf_Imp_Itemnf
                (Cpf_Cnpj_Emit
                ,Dm_Ind_Emit
                ,Dm_Ind_Oper
                ,Cod_Part
                ,Cod_Mod
                ,Serie
                ,Nro_Nf
                ,Nro_Item
                ,Cod_Imposto
                ,Dm_Tipo
                ,Cod_St
                ,Vl_Base_Calc
                ,Aliq_Apli
                ,Vl_Imp_Trib
                ,Perc_Reduc
                ,Perc_Adic
                ,Qtde_Base_Calc_Prod
                ,Vl_Aliq_Prod
                ,Perc_Bc_Oper_Prop
                ,Ufst
                ,Vl_Bc_St_Ret
                ,Vl_Icmsst_Ret
                ,Vl_Bc_St_Dest
                ,Vl_Icmsst_Dest)
              Values
                (l_Rvcii.Cpf_Cnpj_Emit
                ,l_Rvcii.Dm_Ind_Emit
                ,l_Rvcii.Dm_Ind_Oper
                ,l_Rvcii.Cod_Part
                ,l_Rvcii.Cod_Mod
                ,l_Rvcii.Serie
                ,l_Rvcii.Nro_Nf
                ,l_Rvcii.Nro_Item
                ,l_Rvcii.Cod_Imposto
                ,l_Rvcii.Dm_Tipo
                ,l_Rvcii.Cod_St
                ,l_Rvcii.Vl_Base_Calc
                ,l_Rvcii.Aliq_Apli
                ,l_Rvcii.Vl_Imp_Trib
                ,l_Rvcii.Perc_Reduc
                ,l_Rvcii.Perc_Adic
                ,l_Rvcii.Qtde_Base_Calc_Prod
                ,l_Rvcii.Vl_Aliq_Prod
                ,l_Rvcii.Perc_Bc_Oper_Prop
                ,l_Rvcii.Ufst
                ,l_Rvcii.Vl_Bc_St_Ret
                ,l_Rvcii.Vl_Icmsst_Ret
                ,l_Rvcii.Vl_Bc_St_Dest
                ,l_Rvcii.Vl_Icmsst_Dest);
              --
              Xxisv_Csf_Nfe_Pkg.Vw_Csf_Imp_Itemnf_Ff_p(p_Rvcii => l_Rvcii, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Cod_Imposto => l_Rvcii.Cod_Imposto, p_Cclass_Trib_Cbs => Substr(p_Cclass_Trib_Cbs, 1, 6), p_Cclass_Trib_Ibs => Null, p_Rotina => p_Rotina);
              --
            Exception
              When Dup_Val_On_Index Then
                Null;
              When Others Then
                --
                g_Retcode   := 1;
                g_Erro      := Nvl(g_Erro, 0) + 1;
                l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P (CBS_RI) - ' || 'Cpf_Cnpj_Emit: ' ||
                               p_Rvcinf.Cpf_Cnpj_Emit || ', Cod_Mod: ' ||
                               p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                               ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                               p_Rvcinf.Nro_Item || ', Cod_Imposto: 29, Erro: ' ||
                               Sqlerrm;
                g_Erro_Msg  := l_Desc_Erro;
                --
                Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                --
            End;
            --
          End If;
          --
        End If;
        --
        Close C4;
        --
      End If;
      --
      --
      Xxisv_Csf_Nfe_Pkg.Vw_Csf_Imp_Itemnf_Cust_p(p_Rvcinf => p_Rvcinf, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Interface_Line_Context => p_Interface_Line_Context, p_Cclass_Trib_Cbs => p_Cclass_Trib_Cbs, p_Cclass_Trib_Ibs => p_Cclass_Trib_Ibs, p_Rotina => p_Rotina);
      --
      --
      Open C2;
      Loop
        Fetch C2
          Into R2;
        Exit When C2%Notfound;
        ---
        Begin
          Insert Into Vw_Csf_Imp_Itemnf
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Cod_St
            ,Vl_Base_Calc
            ,Aliq_Apli
            ,Vl_Imp_Trib
            ,Perc_Reduc
            ,Perc_Adic
            ,Qtde_Base_Calc_Prod
            ,Vl_Aliq_Prod
            ,Perc_Bc_Oper_Prop
            ,Ufst
            ,Vl_Bc_St_Ret
            ,Vl_Icmsst_Ret
            ,Vl_Bc_St_Dest
            ,Vl_Icmsst_Dest)
          Values
            (p_Rvcinf.Cpf_Cnpj_Emit
            ,p_Rvcinf.Dm_Ind_Emit
            ,p_Rvcinf.Dm_Ind_Oper
            ,p_Rvcinf.Cod_Part
            ,p_Rvcinf.Cod_Mod
            ,p_Rvcinf.Serie
            ,p_Rvcinf.Nro_Nf
            ,p_Rvcinf.Nro_Item
            ,4 /*PIS_RI*/
            ,R2.Dm_Tipo
            ,R2.Cod_St_Pc
            ,R2.Vl_Base_Calc_Pis
            ,R2.Aliq_Apli_Pis
            ,R2.Vl_Imp_Trib_Pis
             /*,R2.Perc_Reduc*/ -- Carranza 29/05/2019
            ,Null
             /*,R2.Perc_Adic*/ -- Carranza 20/11/2019
            ,Null
            ,R2.Qtde_Base_Calc_Prod
            ,R2.Vl_Aliq_Prod
            ,R2.Perc_Bc_Oper_Prop
            ,R2.Ufst
            ,R2.Vl_Bc_St_Ret
            ,R2.Vl_Icmsst_Ret
            ,R2.Vl_Bc_St_Dest
            ,R2.Vl_Icmsst_Dest);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                           ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                           p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                           R2.Cod_Imposto || ', Dm_Tipo: ' || R2.Dm_Tipo ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
        Begin
          Insert Into Vw_Csf_Imp_Itemnf
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Cod_St
            ,Vl_Base_Calc
            ,Aliq_Apli
            ,Vl_Imp_Trib
            ,Perc_Reduc
            ,Perc_Adic
            ,Qtde_Base_Calc_Prod
            ,Vl_Aliq_Prod
            ,Perc_Bc_Oper_Prop
            ,Ufst
            ,Vl_Bc_St_Ret
            ,Vl_Icmsst_Ret
            ,Vl_Bc_St_Dest
            ,Vl_Icmsst_Dest)
          Values
            (p_Rvcinf.Cpf_Cnpj_Emit
            ,p_Rvcinf.Dm_Ind_Emit
            ,p_Rvcinf.Dm_Ind_Oper
            ,p_Rvcinf.Cod_Part
            ,p_Rvcinf.Cod_Mod
            ,p_Rvcinf.Serie
            ,p_Rvcinf.Nro_Nf
            ,p_Rvcinf.Nro_Item
            ,5 /*COFINS_RI*/
            ,R2.Dm_Tipo
            ,R2.Cod_St_Pc
            ,R2.Vl_Base_Calc_Cofins
            ,R2.Aliq_Apli_Cofins
            ,R2.Vl_Imp_Trib_Cofins
             /*,R2.Perc_Reduc*/ -- Carranza 29/05/2019
            ,Null
             /*,R2.Perc_Adic*/ -- Carranza 20/11/2019
            ,Null
            ,R2.Qtde_Base_Calc_Prod
            ,R2.Vl_Aliq_Prod
            ,R2.Perc_Bc_Oper_Prop
            ,R2.Ufst
            ,R2.Vl_Bc_St_Ret
            ,R2.Vl_Icmsst_Ret
            ,R2.Vl_Bc_St_Dest
            ,R2.Vl_Icmsst_Dest);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                           ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                           p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                           R2.Cod_Imposto || ', Dm_Tipo: ' || R2.Dm_Tipo ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
        Begin
          Insert Into Vw_Csf_Imp_Itemnf
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Cod_St
            ,Vl_Base_Calc
            ,Aliq_Apli
            ,Vl_Imp_Trib
            ,Perc_Reduc
            ,Perc_Adic
            ,Qtde_Base_Calc_Prod
            ,Vl_Aliq_Prod
            ,Perc_Bc_Oper_Prop
            ,Ufst
            ,Vl_Bc_St_Ret
            ,Vl_Icmsst_Ret
            ,Vl_Bc_St_Dest
            ,Vl_Icmsst_Dest)
          Values
            (p_Rvcinf.Cpf_Cnpj_Emit
            ,p_Rvcinf.Dm_Ind_Emit
            ,p_Rvcinf.Dm_Ind_Oper
            ,p_Rvcinf.Cod_Part
            ,p_Rvcinf.Cod_Mod
            ,p_Rvcinf.Serie
            ,p_Rvcinf.Nro_Nf
            ,p_Rvcinf.Nro_Item
            ,1 /*ICMS_RI*/
            ,R2.Dm_Tipo
            ,R2.Cod_St_Icms
            ,R2.Vl_Base_Calc_Icms
            ,R2.Aliq_Apli_Icms
            ,R2.Vl_Imp_Trib_Icms
            ,R2.Perc_Reduc
             /*,R2.Perc_Adic*/ -- Carranza 20/11/2019
            ,Null
            ,R2.Qtde_Base_Calc_Prod
            ,R2.Vl_Aliq_Prod
            ,R2.Perc_Bc_Oper_Prop
            ,R2.Ufst
            ,R2.Vl_Bc_St_Ret
            ,R2.Vl_Icmsst_Ret
            ,R2.Vl_Bc_St_Dest
            ,R2.Vl_Icmsst_Dest);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                           ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                           p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                           R2.Cod_Imposto || ', Dm_Tipo: ' || R2.Dm_Tipo ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
        Begin
          If R2.Vl_Imp_Trib_Ipi > 0
          Then
            --
            Begin
              Insert Into Vw_Csf_Imp_Itemnf
                (Cpf_Cnpj_Emit
                ,Dm_Ind_Emit
                ,Dm_Ind_Oper
                ,Cod_Part
                ,Cod_Mod
                ,Serie
                ,Nro_Nf
                ,Nro_Item
                ,Cod_Imposto
                ,Dm_Tipo
                ,Cod_St
                ,Vl_Base_Calc
                ,Aliq_Apli
                ,Vl_Imp_Trib
                ,Perc_Reduc
                ,Perc_Adic
                ,Qtde_Base_Calc_Prod
                ,Vl_Aliq_Prod
                ,Perc_Bc_Oper_Prop
                ,Ufst
                ,Vl_Bc_St_Ret
                ,Vl_Icmsst_Ret
                ,Vl_Bc_St_Dest
                ,Vl_Icmsst_Dest)
              Values
                (p_Rvcinf.Cpf_Cnpj_Emit
                ,p_Rvcinf.Dm_Ind_Emit
                ,p_Rvcinf.Dm_Ind_Oper
                ,p_Rvcinf.Cod_Part
                ,p_Rvcinf.Cod_Mod
                ,p_Rvcinf.Serie
                ,p_Rvcinf.Nro_Nf
                ,p_Rvcinf.Nro_Item
                ,3 /*IPI_RI*/
                ,R2.Dm_Tipo
                ,R2.Cod_St_Ipi
                ,R2.Vl_Base_Calc_Ipi
                ,R2.Aliq_Apli_Ipi
                ,R2.Vl_Imp_Trib_Ipi
                 /*,R2.Perc_Reduc*/ -- Carranza 29/05/2019
                ,Null
                 /*,R2.Perc_Adic*/ -- Carranza 20/11/2019
                ,Null
                ,R2.Qtde_Base_Calc_Prod
                ,R2.Vl_Aliq_Prod
                ,R2.Perc_Bc_Oper_Prop
                ,R2.Ufst
                ,R2.Vl_Bc_St_Ret
                ,R2.Vl_Icmsst_Ret
                ,R2.Vl_Bc_St_Dest
                ,R2.Vl_Icmsst_Dest);
              --
            Exception
              When Dup_Val_On_Index Then
                Null;
              When Others Then
                --
                g_Retcode   := 1;
                g_Erro      := Nvl(g_Erro, 0) + 1;
                l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                               p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                               p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                               p_Rvcinf.Cod_Mod || ', Serie: ' ||
                               p_Rvcinf.Serie || ', Nro_Nf: ' ||
                               p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                               p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                               R2.Cod_Imposto || ', Dm_Tipo: ' || R2.Dm_Tipo ||
                               ', Erro: ' || Sqlerrm;
                g_Erro_Msg  := l_Desc_Erro;
                --
                Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                --
            End;
            --
          End If;
          --
        End;
        --
        Begin
          If R2.Cod_St_Icms In
             ('10', '30', '60', '70', '81', '201', '202', '203', '500', '900')
          Then
            --
            Begin
              Insert Into Vw_Csf_Imp_Itemnf
                (Cpf_Cnpj_Emit
                ,Dm_Ind_Emit
                ,Dm_Ind_Oper
                ,Cod_Part
                ,Cod_Mod
                ,Serie
                ,Nro_Nf
                ,Nro_Item
                ,Cod_Imposto
                ,Dm_Tipo
                ,Cod_St
                ,Vl_Base_Calc
                ,Aliq_Apli
                ,Vl_Imp_Trib
                ,Perc_Reduc
                ,Perc_Adic
                ,Qtde_Base_Calc_Prod
                ,Vl_Aliq_Prod
                ,Perc_Bc_Oper_Prop
                ,Ufst
                ,Vl_Bc_St_Ret
                ,Vl_Icmsst_Ret
                ,Vl_Bc_St_Dest
                ,Vl_Icmsst_Dest)
              Values
                (p_Rvcinf.Cpf_Cnpj_Emit
                ,p_Rvcinf.Dm_Ind_Emit
                ,p_Rvcinf.Dm_Ind_Oper
                ,p_Rvcinf.Cod_Part
                ,p_Rvcinf.Cod_Mod
                ,p_Rvcinf.Serie
                ,p_Rvcinf.Nro_Nf
                ,p_Rvcinf.Nro_Item
                ,2 /*ICMS-ST_RI*/
                ,R2.Dm_Tipo
                ,Null
                ,R2.Vl_Base_Calc_Icms_St
                ,R2.Aliq_Apli_Icms_St
                ,R2.Vl_Imp_Trib_Icms_St
                 /*,R2.Perc_Reduc*/ -- Carranza 29/05/2019
                ,Null
                ,R2.Perc_Adic
                ,R2.Qtde_Base_Calc_Prod
                ,R2.Vl_Aliq_Prod
                ,R2.Perc_Bc_Oper_Prop
                ,R2.Ufst
                ,R2.Vl_Bc_St_Ret
                ,R2.Vl_Icmsst_Ret
                ,R2.Vl_Bc_St_Dest
                ,R2.Vl_Icmsst_Dest);
              --
            Exception
              When Dup_Val_On_Index Then
                Null;
              When Others Then
                --
                g_Retcode   := 1;
                g_Erro      := Nvl(g_Erro, 0) + 1;
                l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                               p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                               p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                               p_Rvcinf.Cod_Mod || ', Serie: ' ||
                               p_Rvcinf.Serie || ', Nro_Nf: ' ||
                               p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                               p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                               R2.Cod_Imposto || ', Dm_Tipo: ' || R2.Dm_Tipo ||
                               ', Erro: ' || Sqlerrm;
                g_Erro_Msg  := l_Desc_Erro;
                --
                Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                --
            End;
            --
          End If;
          --
        End;
        --
      End Loop;
      Close C2;
      --
      Open C3;
      Loop
        Fetch C3
          Into R3;
        Exit When C3%Notfound;
        ---
        Begin
          Insert Into Vw_Csf_Imp_Itemnf
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Cod_St
            ,Vl_Base_Calc
            ,Aliq_Apli
            ,Vl_Imp_Trib
            ,Perc_Reduc
            ,Perc_Adic
            ,Qtde_Base_Calc_Prod
            ,Vl_Aliq_Prod
            ,Perc_Bc_Oper_Prop
            ,Ufst
            ,Vl_Bc_St_Ret
            ,Vl_Icmsst_Ret
            ,Vl_Bc_St_Dest
            ,Vl_Icmsst_Dest)
          Values
            (p_Rvcinf.Cpf_Cnpj_Emit
            ,p_Rvcinf.Dm_Ind_Emit
            ,p_Rvcinf.Dm_Ind_Oper
            ,p_Rvcinf.Cod_Part
            ,p_Rvcinf.Cod_Mod
            ,p_Rvcinf.Serie
            ,p_Rvcinf.Nro_Nf
            ,p_Rvcinf.Nro_Item
            ,R3.Cod_Imposto
            ,R3.Dm_Tipo
            ,R3.Cod_St
            ,R3.Vl_Base_Calc
            ,R3.Aliq_Apli
            ,R3.Vl_Imp_Trib
            ,R3.Perc_Reduc
            ,R3.Perc_Adic
            ,R3.Qtde_Base_Calc_Prod
            ,R3.Vl_Aliq_Prod
            ,R3.Perc_Bc_Oper_Prop
            ,R3.Ufst
            ,R3.Vl_Bc_St_Ret
            ,R3.Vl_Icmsst_Ret
            ,R3.Vl_Bc_St_Dest
            ,R3.Vl_Icmsst_Dest);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                           ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                           p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                           R3.Cod_Imposto || ', Dm_Tipo: ' || R3.Dm_Tipo ||
                           ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
      End Loop;
      Close C3;
      --
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Imp_Itemnf_p;

  ---
  ---
  ------------------------------------------------------------------------------
  --- Procedure Custom utilizada para inclusão de dados na Vw_Csf_Imp_Itemnf ---
  ------------------------------------------------------------------------------ 
  Procedure Vw_Csf_Imp_Itemnf_Cust_p(p_Rvcinf                 Vw_Csf_Item_Nota_Fiscal%Rowtype
                                    ,p_Customer_Trx_Line_Id   Number
                                    ,p_Customer_Trx_Id        Number
                                    ,p_Interface_Line_Context Varchar2
                                    ,p_Cclass_Trib_Cbs        Varchar2
                                    ,p_Cclass_Trib_Ibs        Varchar2
                                    ,p_Rotina                 Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor Cvcii(p_Cod_Imposto Number) Is
      Select Vcii.*
        From Vw_Csf_Imp_Itemnf Vcii
       Where 1 = 1
         And Vcii.Cpf_Cnpj_Emit = p_Rvcinf.Cpf_Cnpj_Emit
         And Vcii.Dm_Ind_Emit = p_Rvcinf.Dm_Ind_Emit
         And Vcii.Dm_Ind_Oper = p_Rvcinf.Dm_Ind_Oper
         And Vcii.Cod_Part = p_Rvcinf.Cod_Part
         And Vcii.Cod_Mod = p_Rvcinf.Cod_Mod
         And Vcii.Serie = p_Rvcinf.Serie
         And Vcii.Nro_Nf = p_Rvcinf.Nro_Nf
         And Vcii.Nro_Item = p_Rvcinf.Nro_Item
         And Vcii.Cod_Imposto = p_Cod_Imposto;
    --
    l_Rvcii_1  Vw_Csf_Imp_Itemnf%Rowtype := Null; -- cod_imposto 1 - ICMS
    l_Rvcii_4  Vw_Csf_Imp_Itemnf%Rowtype := Null; -- cod_imposto 4 - PIS
    l_Rvcii_5  Vw_Csf_Imp_Itemnf%Rowtype := Null; -- cod_imposto 5 - COFINS
    l_Rvcii_28 Vw_Csf_Imp_Itemnf%Rowtype := Null; -- cod_imposto 28 - IBS
    l_Rvcii_29 Vw_Csf_Imp_Itemnf%Rowtype := Null; -- cod_imposto 29 - CBS
    l_Rvcii    Vw_Csf_Imp_Itemnf%Rowtype := Null;
    --
    Cursor Cc Is
      Select (Rctla.Quantity_Invoiced * Rctla.Unit_Selling_Price) Valor_Item
            ,Fnd_Number.Canonical_To_Number(Flv.Attribute1) Aliq_Cbs
            ,Fnd_Number.Canonical_To_Number(Flv.Attribute2) Aliq_Ibs
            ,Fnd_Number.Canonical_To_Number(Flv.Attribute3) Perc_Reduc_Aliq
            ,Fnd_Number.Canonical_To_Number(Flv.Attribute4) Aliq_Efet_Cbs
            ,Fnd_Number.Canonical_To_Number(Flv.Attribute5) Aliq_Efet_Ibs
            ,Fnd_Number.Canonical_To_Number(Flv.Attribute6) Percent_Difer_Uf
            ,Fnd_Number.Canonical_To_Number(Flv.Attribute7) Percent_Difer_Mun
            ,Rctt.Global_Attribute7
            ,Rctt.Global_Attribute8
            ,Rctt.Attribute6
            ,Coalesce(Rctt.Global_Attribute7, Rctt.Global_Attribute8, Rctt.Attribute6) Cclasstrib
            ,Lpad(Coalesce(Rctt.Global_Attribute7, Rctt.Global_Attribute8, Rctt.Attribute6), 3, 0) Cod_St
        From Ra_Customer_Trx_Lines_All Rctla
            ,Mtl_System_Items_b        Msib
            ,Ra_Customer_Trx_All       Rcta
            ,Ra_Cust_Trx_Types_All     Rctt
            ,Fnd_Lookup_Values         Flv
       Where 1 = 1
         And Rcta.Customer_Trx_Id = Rctla.Customer_Trx_Id
         And Rctt.Cust_Trx_Type_Id = Rcta.Cust_Trx_Type_Id
         And Flv.Lookup_Type = 'XXISV_CSF_ALQ_CBSIBS_CLASSTRIB'
         And Flv.Language = Userenv('LANG')
         And Flv.Lookup_Code = Nvl(Rctt.Global_Attribute7, Rctt.Attribute6)
         And Flv.Enabled_Flag = 'Y'
            --- 
         And Rcta.Trx_Date Between Flv.Start_Date_Active And
             Nvl(Flv.End_Date_Active, Sysdate)
            ---         And ((Flv.End_Date_Active Is Null) Or
            ---             (Flv.End_Date_Active Is Not Null And
            ---             Flv.End_Date_Active >= Trunc(Sysdate)))
         And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
         And Msib.Organization_Id = Rctla.Warehouse_Id
         And Rctla.Line_Type = 'LINE'
         And Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
             'CLL F189 INTEGRATED RCV' /*Não pegar impostos se a NFe for de origem do RI*/
         And Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And (Rctla.Interface_Line_Attribute11 = 0 Or
             Rctla.Interface_Line_Attribute11 Is Null)
         And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null);
    --
    Rr Cc%Rowtype;
    --
  Begin
    --
    Open Cvcii(28);
    Fetch Cvcii
      Into l_Rvcii_28;
    Close Cvcii;
    --
    Open Cvcii(29);
    Fetch Cvcii
      Into l_Rvcii_29;
    Close Cvcii;
    --
    If ((l_Rvcii_28.Cod_Imposto Is Null) Or (l_Rvcii_29.Cod_Imposto Is Null))
    Then
      --
      Open Cvcii(1);
      Fetch Cvcii
        Into l_Rvcii_1;
      Close Cvcii;
      --
      Open Cvcii(4);
      Fetch Cvcii
        Into l_Rvcii_4;
      Close Cvcii;
      --
      Open Cvcii(5);
      Fetch Cvcii
        Into l_Rvcii_5;
      Close Cvcii;
      --
      Open Cc;
      Fetch Cc
        Into Rr;
      Close Cc;
      --
      l_Rvcii               := Null;
      l_Rvcii.Cpf_Cnpj_Emit := p_Rvcinf.Cpf_Cnpj_Emit;
      l_Rvcii.Dm_Ind_Emit   := p_Rvcinf.Dm_Ind_Emit;
      l_Rvcii.Dm_Ind_Oper   := p_Rvcinf.Dm_Ind_Oper;
      l_Rvcii.Cod_Part      := p_Rvcinf.Cod_Part;
      l_Rvcii.Cod_Mod       := p_Rvcinf.Cod_Mod;
      l_Rvcii.Serie         := p_Rvcinf.Serie;
      l_Rvcii.Nro_Nf        := p_Rvcinf.Nro_Nf;
      l_Rvcii.Nro_Item      := p_Rvcinf.Nro_Item;
      --
      If Rr.Aliq_Cbs Is Not Null
      Then
        --quando for criar a informação dos impostos de IBS e CBS 
        --a base calculo desses impostos devera ser o valor do item 
        --e duzuzir os valores de (PIS + COFINS + ICMS).  cod_imposto 4 5 1
        --ai pega esse valor e multiplica pela aliquota da lookup
        l_Rvcii.Cod_Imposto  := 29;
        l_Rvcii.Dm_Tipo      := 0;
        l_Rvcii.Cod_St       := Rr.Cod_St;
        l_Rvcii.Vl_Base_Calc := Round((Rr.Valor_Item -
                                      (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                      Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                      Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2);
        l_Rvcii.Aliq_Apli    := Rr.Aliq_Cbs;
        If Rr.Cod_St = '515'
        Then
          --
          l_Rvcii.Vl_Imp_Trib := 0;
          --
        Else
          --
          If Nvl(Rr.Perc_Reduc_Aliq, 0) > 0
          Then
            --
            l_Rvcii.Vl_Imp_Trib := Round(((Round((Rr.Valor_Item -
                                                 (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                                 Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                                 Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2) *
                                         (Nvl(Rr.Aliq_Cbs, 0) * (1 -
                                         (Nvl(Rr.Perc_Reduc_Aliq, 0) / 100)))) / 100), 2); -- Ito 02/12/2025
            --= VL_BASE_CALC * (ALIQ_APLI * (1-(PER_REDALIQ_IBS_CBS/100))
            --                                        (Nvl(Rr.Aliq_Ibs, 0) - (Nvl(Rr.Perc_Reduc_Aliq,0)/100))) / 100), 2); -- Ito 02/12/2025
            --
            --                                      /*Nvl(Rr.Aliq_Efet_Ibs, Rr.Aliq_Ibs)) / 100), 2);*/ -- Carranza 01/12/2025
            --                                      Nvl(Rr.Aliq_Ibs, 0)) / 100), 2); -- Carranza 01/12/2025
          Else
            --
            l_Rvcii.Vl_Imp_Trib := Round(((Round((Rr.Valor_Item -
                                                 (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                                 Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                                 Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2) *
                                         Nvl(Rr.Aliq_Cbs, 0)) / 100), 2); -- Carranza 01/12/2025
            --
          End If;
        End If;
        --
        Begin
          Insert Into Vw_Csf_Imp_Itemnf
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Cod_St
            ,Vl_Base_Calc
            ,Aliq_Apli
            ,Vl_Imp_Trib
            ,Perc_Reduc
            ,Perc_Adic
            ,Qtde_Base_Calc_Prod
            ,Vl_Aliq_Prod
            ,Perc_Bc_Oper_Prop
            ,Ufst
            ,Vl_Bc_St_Ret
            ,Vl_Icmsst_Ret
            ,Vl_Bc_St_Dest
            ,Vl_Icmsst_Dest)
          Values
            (p_Rvcinf.Cpf_Cnpj_Emit
            ,p_Rvcinf.Dm_Ind_Emit
            ,p_Rvcinf.Dm_Ind_Oper
            ,p_Rvcinf.Cod_Part
            ,p_Rvcinf.Cod_Mod
            ,p_Rvcinf.Serie
            ,p_Rvcinf.Nro_Nf
            ,p_Rvcinf.Nro_Item
            ,l_Rvcii.Cod_Imposto
            ,l_Rvcii.Dm_Tipo
            ,l_Rvcii.Cod_St
            ,Case When l_Rvcii.Cod_St = '410' Then 0 Else
             l_Rvcii.Vl_Base_Calc End
            ,l_Rvcii.Aliq_Apli
            ,l_Rvcii.Vl_Imp_Trib
            ,l_Rvcii.Perc_Reduc
            ,l_Rvcii.Perc_Adic
            ,l_Rvcii.Qtde_Base_Calc_Prod
            ,l_Rvcii.Vl_Aliq_Prod
            ,l_Rvcii.Perc_Bc_Oper_Prop
            ,l_Rvcii.Ufst
            ,l_Rvcii.Vl_Bc_St_Ret
            ,l_Rvcii.Vl_Icmsst_Ret
            ,l_Rvcii.Vl_Bc_St_Dest
            ,l_Rvcii.Vl_Icmsst_Dest);
          --
          If l_Rvcii.Cod_Imposto = 29
          Then
            --
            Xxisv_Csf_Nfe_Pkg.Vw_Csf_Imp_Itemnf_Ff_p(p_Rvcii => l_Rvcii, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Cod_Imposto => l_Rvcii.Cod_Imposto, p_Cclass_Trib_Cbs => Rr.Cclasstrib, p_Cclass_Trib_Ibs => Rr.Cclasstrib, p_Rotina => p_Rotina);
            --
            /*If l_Rvcii.Cod_St = '200' Then*/ -- Carranza 02/12/2025
            If l_Rvcii.Cod_St In ('200', '515')
            Then
              -- Carranza 02/12/2025
              --
              If Rr.Perc_Reduc_Aliq Is Not Null
              Then
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'PER_REDALIQ_IBS_CBS'
                     /*,Rr.Perc_Reduc_Aliq*/ -- Carranza 01/12/2025
                    ,(Rr.Perc_Reduc_Aliq * 10000) -- Carranza 01/12/2025
                     );
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (PER_REDALIQ_IBS_CBS) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
              End If;
              --
              If Rr.Aliq_Efet_Cbs Is Not Null
              Then
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'ALIQ_EFET_IBS_CBS'
                     /*,Rr.Aliq_Efet_Cbs*/ -- Carranza 01/12/2025
                    ,(Rr.Aliq_Efet_Cbs * 10000) -- Carranza 01/12/2025
                     );
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (ALIQ_EFET_IBS_CBS) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
              End If;
              --
              If Rr.Percent_Difer_Uf Is Not Null
              Then
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'PERCENT_DIFER'
                    ,(Rr.Percent_Difer_Uf * 10000) -- 09/12/2025
                     );
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (PERCENT_DIFER) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
                --VL_IMP_DIFER_UF = (VL_BASE_CALC * (VL_ALIQ_APLI - (VL_ALIQ_APLI * PER_REDALIQ_IBS_CBS/100)))* PERCENT_DIFER
                Declare
                  l_Vl_Imp_Difer_Uf Number;
                Begin
                  If Nvl(Rr.Perc_Reduc_Aliq, 0) > 0
                  Then
                    --
                    l_Vl_Imp_Difer_Uf := Round(((Round((Rr.Valor_Item -
                                                       (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                                       Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                                       Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2) *
                                               (Nvl(Rr.Aliq_Cbs, 0) * (1 -
                                               (Nvl(Rr.Perc_Reduc_Aliq, 0) / 100)))) / 100) *
                                               (Rr.Percent_Difer_Uf / 100), 2);
                    --
                  Else
                    --
                    l_Vl_Imp_Difer_Uf := Round(((Round((Rr.Valor_Item -
                                                       (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                                       Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                                       Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2) *
                                               Nvl(Rr.Aliq_Cbs, 0)) / 100) *
                                               (Rr.Percent_Difer_Uf / 100), 2);
                    --
                  End If;
                  Begin
                    Insert Into Vw_Csf_Imp_Itemnf_Ff
                      (Cpf_Cnpj_Emit
                      ,Dm_Ind_Emit
                      ,Dm_Ind_Oper
                      ,Cod_Part
                      ,Cod_Mod
                      ,Serie
                      ,Nro_Nf
                      ,Nro_Item
                      ,Cod_Imposto
                      ,Dm_Tipo
                      ,Atributo
                      ,Valor)
                    Values
                      (l_Rvcii.Cpf_Cnpj_Emit
                      ,l_Rvcii.Dm_Ind_Emit
                      ,l_Rvcii.Dm_Ind_Oper
                      ,l_Rvcii.Cod_Part
                      ,l_Rvcii.Cod_Mod
                      ,l_Rvcii.Serie
                      ,l_Rvcii.Nro_Nf
                      ,l_Rvcii.Nro_Item
                      ,l_Rvcii.Cod_Imposto
                      ,l_Rvcii.Dm_Tipo
                      ,'VL_IMP_DIFER_UF'
                      ,(l_Vl_Imp_Difer_Uf * 100) -- 09/12/2025
                       );
                    --
                  Exception
                    When Dup_Val_On_Index Then
                      Null;
                    When Others Then
                      --
                      g_Retcode   := 1;
                      g_Erro      := Nvl(g_Erro, 0) + 1;
                      l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_IMP_DIFER_UF) - ' ||
                                     'Cpf_Cnpj_Emit: ' ||
                                     l_Rvcii.Cpf_Cnpj_Emit ||
                                     ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                     ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                     ', Serie: ' || l_Rvcii.Serie ||
                                     ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                     ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                     ', Erro: ' || Sqlerrm;
                      g_Erro_Msg  := l_Desc_Erro;
                      --
                      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                      --
                  End;
                End;
                --
              End If;
              --
            End If;
            --
          End If;
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                           ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                           p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                           l_Rvcii.Cod_Imposto || ', Dm_Tipo: ' ||
                           l_Rvcii.Dm_Tipo || ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
      End If;
      ---
      If Rr.Aliq_Ibs Is Not Null
      Then
        --quando for criar a informação dos impostos de IBS e CBS 
        --a base calculo desses impostos devera ser o valor do item 
        --e duzuzir os valores de (PIS + COFINS + ICMS).  cod_imposto 4 5 1
        --ai pega esse valor e multiplica pela aliquota da lookup
        l_Rvcii.Cod_Imposto  := 28;
        l_Rvcii.Dm_Tipo      := 0;
        l_Rvcii.Cod_St       := Rr.Cod_St;
        l_Rvcii.Vl_Base_Calc := Round((Rr.Valor_Item -
                                      (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                      Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                      Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2);
        l_Rvcii.Aliq_Apli    := Rr.Aliq_Ibs;
        If Rr.Cod_St = '515'
        Then
          --
          l_Rvcii.Vl_Imp_Trib := 0;
          --
        Else
          If Nvl(Rr.Perc_Reduc_Aliq, 0) > 0
          Then
            --
            l_Rvcii.Vl_Imp_Trib := Round(((Round((Rr.Valor_Item -
                                                 (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                                 Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                                 Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2) *
                                         (Nvl(Rr.Aliq_Ibs, 0) * (1 -
                                         (Nvl(Rr.Perc_Reduc_Aliq, 0) / 100)))) / 100), 2); -- Ito 02/12/2025
            --= VL_BASE_CALC * (ALIQ_APLI * (1-(PER_REDALIQ_IBS_CBS/100))
            --                                        (Nvl(Rr.Aliq_Ibs, 0) - (Nvl(Rr.Perc_Reduc_Aliq,0)/100))) / 100), 2); -- Ito 02/12/2025
            --
            --                                      /*Nvl(Rr.Aliq_Efet_Ibs, Rr.Aliq_Ibs)) / 100), 2);*/ -- Carranza 01/12/2025
            --                                      Nvl(Rr.Aliq_Ibs, 0)) / 100), 2); -- Carranza 01/12/2025
          Else
            l_Rvcii.Vl_Imp_Trib := Round(((Round((Rr.Valor_Item -
                                                 (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                                 Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                                 Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2) *
                                         Nvl(Rr.Aliq_Ibs, 0)) / 100), 2); -- Carranza 01/12/2025
          End If;
        End If;
        --
        Begin
          Insert Into Vw_Csf_Imp_Itemnf
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Cod_St
            ,Vl_Base_Calc
            ,Aliq_Apli
            ,Vl_Imp_Trib
            ,Perc_Reduc
            ,Perc_Adic
            ,Qtde_Base_Calc_Prod
            ,Vl_Aliq_Prod
            ,Perc_Bc_Oper_Prop
            ,Ufst
            ,Vl_Bc_St_Ret
            ,Vl_Icmsst_Ret
            ,Vl_Bc_St_Dest
            ,Vl_Icmsst_Dest)
          Values
            (p_Rvcinf.Cpf_Cnpj_Emit
            ,p_Rvcinf.Dm_Ind_Emit
            ,p_Rvcinf.Dm_Ind_Oper
            ,p_Rvcinf.Cod_Part
            ,p_Rvcinf.Cod_Mod
            ,p_Rvcinf.Serie
            ,p_Rvcinf.Nro_Nf
            ,p_Rvcinf.Nro_Item
            ,l_Rvcii.Cod_Imposto
            ,l_Rvcii.Dm_Tipo
            ,l_Rvcii.Cod_St
            ,Case When l_Rvcii.Cod_St = '410' Then 0 Else
             l_Rvcii.Vl_Base_Calc End
            ,l_Rvcii.Aliq_Apli
            ,l_Rvcii.Vl_Imp_Trib
            ,l_Rvcii.Perc_Reduc
            ,l_Rvcii.Perc_Adic
            ,l_Rvcii.Qtde_Base_Calc_Prod
            ,l_Rvcii.Vl_Aliq_Prod
            ,l_Rvcii.Perc_Bc_Oper_Prop
            ,l_Rvcii.Ufst
            ,l_Rvcii.Vl_Bc_St_Ret
            ,l_Rvcii.Vl_Icmsst_Ret
            ,l_Rvcii.Vl_Bc_St_Dest
            ,l_Rvcii.Vl_Icmsst_Dest);
          --
          If l_Rvcii.Cod_Imposto = 28
          Then
            --
            Xxisv_Csf_Nfe_Pkg.Vw_Csf_Imp_Itemnf_Ff_p(p_Rvcii => l_Rvcii, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Cod_Imposto => l_Rvcii.Cod_Imposto, p_Cclass_Trib_Cbs => Rr.Cclasstrib, p_Cclass_Trib_Ibs => Rr.Cclasstrib, p_Rotina => p_Rotina);
            --
            --ALIQ_APLIC_MUN
            --- igor informou que só deve enviar se for maior que zero - 02/12/2025
            ---                Begin
            ---                  Insert Into Vw_Csf_Imp_Itemnf_Ff
            ---                    (Cpf_Cnpj_Emit
            ---                    ,Dm_Ind_Emit
            ---                    ,Dm_Ind_Oper
            ---                    ,Cod_Part
            ---                    ,Cod_Mod
            ---                    ,Serie
            ---                    ,Nro_Nf
            ---                    ,Nro_Item
            ---                    ,Cod_Imposto
            ---                    ,Dm_Tipo
            ---                    ,Atributo
            ---                    ,Valor)
            ---                  Values
            ---                    (l_Rvcii.Cpf_Cnpj_Emit
            ---                    ,l_Rvcii.Dm_Ind_Emit
            ---                    ,l_Rvcii.Dm_Ind_Oper
            ---                    ,l_Rvcii.Cod_Part
            ---                    ,l_Rvcii.Cod_Mod
            ---                    ,l_Rvcii.Serie
            ---                    ,l_Rvcii.Nro_Nf
            ---                    ,l_Rvcii.Nro_Item
            ---                    ,l_Rvcii.Cod_Imposto
            ---                    ,l_Rvcii.Dm_Tipo
            ---                    ,'ALIQ_APLIC_MUN'
            ---                    ,'0');
            ---                End; 
            --VL_IMP_TRIB_MUN
            --- igor informou que só deve enviar se for maior que zero  - 02/12/2025
            ---                Begin
            ---                  Insert Into Vw_Csf_Imp_Itemnf_Ff
            ---                    (Cpf_Cnpj_Emit
            ---                    ,Dm_Ind_Emit
            ---                    ,Dm_Ind_Oper
            ---                    ,Cod_Part
            ---                    ,Cod_Mod
            ---                    ,Serie
            ---                    ,Nro_Nf
            ---                    ,Nro_Item
            ---                    ,Cod_Imposto
            ---                    ,Dm_Tipo
            ---                    ,Atributo
            ---                    ,Valor)
            ---                  Values
            ---                    (l_Rvcii.Cpf_Cnpj_Emit
            ---                    ,l_Rvcii.Dm_Ind_Emit
            ---                    ,l_Rvcii.Dm_Ind_Oper
            ---                    ,l_Rvcii.Cod_Part
            ---                    ,l_Rvcii.Cod_Mod
            ---                    ,l_Rvcii.Serie
            ---                    ,l_Rvcii.Nro_Nf
            ---                    ,l_Rvcii.Nro_Item
            ---                    ,l_Rvcii.Cod_Imposto
            ---                    ,l_Rvcii.Dm_Tipo
            ---                    ,'VL_IMP_TRIB_MUN'
            ---                    ,'0');
            ---                End; 
            /*If l_Rvcii.Cod_St = '200' Then*/ -- Carranza 02/12/2025
            If l_Rvcii.Cod_St In ('200', '515')
            Then
              -- Carranza 02/12/2025
              ---ALIQ_EFET_IBS_MUN 
              Begin
                Insert Into Vw_Csf_Imp_Itemnf_Ff
                  (Cpf_Cnpj_Emit
                  ,Dm_Ind_Emit
                  ,Dm_Ind_Oper
                  ,Cod_Part
                  ,Cod_Mod
                  ,Serie
                  ,Nro_Nf
                  ,Nro_Item
                  ,Cod_Imposto
                  ,Dm_Tipo
                  ,Atributo
                  ,Valor)
                Values
                  (l_Rvcii.Cpf_Cnpj_Emit
                  ,l_Rvcii.Dm_Ind_Emit
                  ,l_Rvcii.Dm_Ind_Oper
                  ,l_Rvcii.Cod_Part
                  ,l_Rvcii.Cod_Mod
                  ,l_Rvcii.Serie
                  ,l_Rvcii.Nro_Nf
                  ,l_Rvcii.Nro_Item
                  ,l_Rvcii.Cod_Imposto
                  ,l_Rvcii.Dm_Tipo
                  ,'ALIQ_EFET_IBS_MUN'
                  ,'0');
                --
              Exception
                When Dup_Val_On_Index Then
                  Null;
                When Others Then
                  --
                  g_Retcode   := 1;
                  g_Erro      := Nvl(g_Erro, 0) + 1;
                  l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (ALIQ_EFET_IBS_MUN) - ' ||
                                 'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                 ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                 ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                 ', Serie: ' || l_Rvcii.Serie || ', Nro_Nf: ' ||
                                 l_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                                 l_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
                  g_Erro_Msg  := l_Desc_Erro;
                  --
                  Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                  --
              End;
              --
              If Rr.Perc_Reduc_Aliq Is Not Null
              Then
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'PER_REDALIQ_IBS_CBS'
                     /*,Rr.Perc_Reduc_Aliq*/ -- Carranza 01/12/2025
                    ,(Rr.Perc_Reduc_Aliq * 10000) -- Carranza 01/12/2025
                     );
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (PER_REDALIQ_IBS_CBS) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
              End If;
              --
              If Rr.Perc_Reduc_Aliq Is Not Null
              Then
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'PER_REDALIQ_IBS_MUN'
                     /*,Rr.Perc_Reduc_Aliq*/ -- Carranza 01/12/2025
                    ,(Rr.Perc_Reduc_Aliq * 10000) -- Carranza 01/12/2025
                     );
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (PER_REDALIQ_IBS_MUN) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
              End If;
              --
              If Rr.Aliq_Efet_Ibs Is Not Null
              Then
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'ALIQ_EFET_IBS_CBS'
                     /*,Rr.Aliq_Efet_Ibs*/ -- Carranza 01/12/2025
                    ,(Rr.Aliq_Efet_Ibs * 10000) -- Carranza 01/12/2025
                     );
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (ALIQ_EFET_IBS_CBS) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
              End If;
              --
              --
              If Rr.Percent_Difer_Uf Is Not Null
              Then
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'PERCENT_DIFER'
                    ,(Rr.Percent_Difer_Uf * 10000) -- 09/12/2025
                     );
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (PERCENT_DIFER) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
                --VL_IMP_DIFER_UF = (VL_BASE_CALC * (VL_ALIQ_APLI - (VL_ALIQ_APLI * PER_REDALIQ_IBS_CBS/100)))* PERCENT_DIFER
                Declare
                  l_Vl_Imp_Difer_Uf Number;
                Begin
                  If Nvl(Rr.Perc_Reduc_Aliq, 0) > 0
                  Then
                    --
                    l_Vl_Imp_Difer_Uf := Round(((Round((Rr.Valor_Item -
                                                       (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                                       Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                                       Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2) *
                                               (Nvl(Rr.Aliq_Ibs, 0) * (1 -
                                               (Nvl(Rr.Perc_Reduc_Aliq, 0) / 100)))) / 100) *
                                               (Rr.Percent_Difer_Uf / 100), 2);
                    --
                  Else
                    --
                    l_Vl_Imp_Difer_Uf := Round(((Round((Rr.Valor_Item -
                                                       (Nvl(l_Rvcii_4.Vl_Imp_Trib, 0) +
                                                       Nvl(l_Rvcii_5.Vl_Imp_Trib, 0) +
                                                       Nvl(l_Rvcii_1.Vl_Imp_Trib, 0))), 2) *
                                               Nvl(Rr.Aliq_Ibs, 0)) / 100) *
                                               (Rr.Percent_Difer_Uf / 100), 2);
                    --
                  End If;
                  Begin
                    Insert Into Vw_Csf_Imp_Itemnf_Ff
                      (Cpf_Cnpj_Emit
                      ,Dm_Ind_Emit
                      ,Dm_Ind_Oper
                      ,Cod_Part
                      ,Cod_Mod
                      ,Serie
                      ,Nro_Nf
                      ,Nro_Item
                      ,Cod_Imposto
                      ,Dm_Tipo
                      ,Atributo
                      ,Valor)
                    Values
                      (l_Rvcii.Cpf_Cnpj_Emit
                      ,l_Rvcii.Dm_Ind_Emit
                      ,l_Rvcii.Dm_Ind_Oper
                      ,l_Rvcii.Cod_Part
                      ,l_Rvcii.Cod_Mod
                      ,l_Rvcii.Serie
                      ,l_Rvcii.Nro_Nf
                      ,l_Rvcii.Nro_Item
                      ,l_Rvcii.Cod_Imposto
                      ,l_Rvcii.Dm_Tipo
                      ,'VL_IMP_DIFER_UF'
                      ,(l_Vl_Imp_Difer_Uf * 100) -- 09/12/2025
                       );
                    --
                  Exception
                    When Dup_Val_On_Index Then
                      Null;
                    When Others Then
                      --
                      g_Retcode   := 1;
                      g_Erro      := Nvl(g_Erro, 0) + 1;
                      l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_IMP_DIFER_UF) - ' ||
                                     'Cpf_Cnpj_Emit: ' ||
                                     l_Rvcii.Cpf_Cnpj_Emit ||
                                     ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                     ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                     ', Serie: ' || l_Rvcii.Serie ||
                                     ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                     ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                     ', Erro: ' || Sqlerrm;
                      g_Erro_Msg  := l_Desc_Erro;
                      --
                      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                      --
                  End;
                End;
                --
              End If;
              --
              --
              If Rr.Percent_Difer_Mun Is Not Null
              Then
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'PERCENT_DIFER_MUN'
                    ,(Rr.Percent_Difer_Mun * 10000));
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (PERCENT_DIFER_MUN) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
                Begin
                  Insert Into Vw_Csf_Imp_Itemnf_Ff
                    (Cpf_Cnpj_Emit
                    ,Dm_Ind_Emit
                    ,Dm_Ind_Oper
                    ,Cod_Part
                    ,Cod_Mod
                    ,Serie
                    ,Nro_Nf
                    ,Nro_Item
                    ,Cod_Imposto
                    ,Dm_Tipo
                    ,Atributo
                    ,Valor)
                  Values
                    (l_Rvcii.Cpf_Cnpj_Emit
                    ,l_Rvcii.Dm_Ind_Emit
                    ,l_Rvcii.Dm_Ind_Oper
                    ,l_Rvcii.Cod_Part
                    ,l_Rvcii.Cod_Mod
                    ,l_Rvcii.Serie
                    ,l_Rvcii.Nro_Nf
                    ,l_Rvcii.Nro_Item
                    ,l_Rvcii.Cod_Imposto
                    ,l_Rvcii.Dm_Tipo
                    ,'VL_IMP_DIFER_MUN'
                    ,0);
                  --
                Exception
                  When Dup_Val_On_Index Then
                    Null;
                  When Others Then
                    --
                    g_Retcode   := 1;
                    g_Erro      := Nvl(g_Erro, 0) + 1;
                    l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_IMP_DIFER_MUN) - ' ||
                                   'Cpf_Cnpj_Emit: ' || l_Rvcii.Cpf_Cnpj_Emit ||
                                   ', Dm_Ind_Emit: ' || l_Rvcii.Dm_Ind_Emit ||
                                   ', Cod_Mod: ' || l_Rvcii.Cod_Mod ||
                                   ', Serie: ' || l_Rvcii.Serie ||
                                   ', Nro_Nf: ' || l_Rvcii.Nro_Nf ||
                                   ', Nro_Item: ' || l_Rvcii.Nro_Item ||
                                   ', Erro: ' || Sqlerrm;
                    g_Erro_Msg  := l_Desc_Erro;
                    --
                    Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
                    --
                End;
                --
              End If;
              --
              --
            End If;
            --
          End If;
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'VW_CSF_IMP_ITEMNF_P - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                           ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                           p_Rvcinf.Nro_Item || ', Cod_Imposto: ' ||
                           l_Rvcii.Cod_Imposto || ', Dm_Tipo: ' ||
                           l_Rvcii.Dm_Tipo || ', Erro: ' || Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
      End If;
    End If;
    --
  End Vw_Csf_Imp_Itemnf_Cust_p;

  ---
  ---
  --------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Imp_Itemnf_Ff ---
  --------------------------------------------------------------------------
  Procedure Vw_Csf_Imp_Itemnf_Ff_p(p_Rvcii                Vw_Csf_Imp_Itemnf%Rowtype
                                  ,p_Customer_Trx_Line_Id Number
                                  ,p_Cod_Imposto          Number
                                  ,p_Cclass_Trib_Cbs      Varchar2
                                  ,p_Cclass_Trib_Ibs      Varchar2
                                  ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro       Varchar2(4000);
    l_Naux            Number;
    l_Aliq_Mun_Ri     Number; -- Carranza 08/09/2026
    l_Vl_Mun_Ri       Number; -- Carranza 08/09/2026
    l_Vl_Trib_Dev_Mun Number; -- Carranza 08/09/2026
    --
    Cursor C1 Is
      Select Sum(Aux.Vl_Bc_Fcp) Vl_Bc_Fcp
            ,Aux.Aliq_Fcp Aliq_Fcp
            ,Abs(Sum(Aux.Vl_Fcp)) Vl_Fcp
        From (
              /*Imposto Item*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Fcp
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Fcp
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Fcp
                From Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') In ('ICMS-FP')
                 And Arvt.Global_Attribute2 = 'Y'
                 And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
                 And (Rctla.Interface_Line_Attribute11 = 0 Or
                     Rctla.Interface_Line_Attribute11 Is Null)
                 And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null)
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 1
              Union
              /*Imposto Desconto (Deduz o valor de desconto no calculo do imposto do item)*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Fcp
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Fcp
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Fcp
                From Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Ra_Customer_Trx_Lines_All Rctlad
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctlad.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctlad.Customer_Trx_Id
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') In ('ICMS-FP')
                 And Arvt.Global_Attribute2 = 'Y'
                 And Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And (Rctla.Interface_Line_Attribute11 = '0' Or
                     Rctla.Interface_Line_Attribute11 Is Null)
                 And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null)
                 And Rctlad.Customer_Trx_Id = Rctla.Customer_Trx_Id
                 And Rctlad.Interface_Line_Attribute6 =
                     Rctla.Interface_Line_Attribute6
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Rctlad.Line_Type = 'LINE'
                 And Rctlad.Interface_Line_Attribute11 Is Not Null
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 1
              Union
              /*Imposto Frete (Acrescenta o valor do frete no calculo do imposto do item)*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Fcp
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Fcp
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Fcp
                From Ra_Customer_Trx_Lines_All Rctla2
                     ,Apps.Oe_Price_Adjustments Opa
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Rctla2.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Rctla2.Line_Type = 'LINE'
                 And Rctla2.Interface_Line_Context = 'ORDER ENTRY'
                 And Opa.Line_Id = Rctla2.Interface_Line_Attribute6
                 And Opa.Charge_Type_Code = 'FREIGHT'
                 And Opa.Arithmetic_Operator = 'AMT'
                 And Rctla.Interface_Line_Attribute6 =
                     To_Char(Opa.Price_Adjustment_Id)
                 And Rctla.Sales_Order = Rctla2.Sales_Order
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Arvt.Vat_Tax_Id = Zl.Tax_Rate_Id
                 And Arvt.Org_Id = Zl.Internal_Organization_Id
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') In ('ICMS-FP')
                 And Arvt.Global_Attribute2 = 'Y'
                 And Msib.Item_Type = 'FRT'
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 1) Aux
       Group By Aux.Aliq_Fcp
      Union
      Select Sum(Aux.Vl_Bc_Fcp) Vl_Bc_Fcp
            ,Aux.Aliq_Fcp Aliq_Fcp
            ,Abs(Sum(Aux.Vl_Fcp)) Vl_Fcp
        From (
              /*Imposto Item*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Fcp
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Fcp
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Fcp
                From Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') In ('ICMS-ST-FP')
                 And Arvt.Global_Attribute2 = 'Y'
                 And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
                 And (Rctla.Interface_Line_Attribute11 = 0 Or
                     Rctla.Interface_Line_Attribute11 Is Null)
                 And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null)
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 2
              Union
              /*Imposto Desconto (Deduz o valor de desconto no calculo do imposto do item)*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Fcp
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Fcp
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Fcp
                From Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Ra_Customer_Trx_Lines_All Rctlad
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctlad.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctlad.Customer_Trx_Id
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') In ('ICMS-ST-FP')
                 And Arvt.Global_Attribute2 = 'Y'
                 And Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And (Rctla.Interface_Line_Attribute11 = '0' Or
                     Rctla.Interface_Line_Attribute11 Is Null)
                 And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null)
                 And Rctlad.Customer_Trx_Id = Rctla.Customer_Trx_Id
                 And Rctlad.Interface_Line_Attribute6 =
                     Rctla.Interface_Line_Attribute6
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Rctlad.Line_Type = 'LINE'
                 And Rctlad.Interface_Line_Attribute11 Is Not Null
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 2
              Union
              /*Imposto Frete (Acrescenta o valor do frete no calculo do imposto do item)*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Fcp
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Fcp
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Fcp
                From Ra_Customer_Trx_Lines_All Rctla2
                     ,Apps.Oe_Price_Adjustments Opa
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Rctla2.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Rctla2.Line_Type = 'LINE'
                 And Rctla2.Interface_Line_Context = 'ORDER ENTRY'
                 And Opa.Line_Id = Rctla2.Interface_Line_Attribute6
                 And Opa.Charge_Type_Code = 'FREIGHT'
                 And Opa.Arithmetic_Operator = 'AMT'
                 And Rctla.Interface_Line_Attribute6 =
                     To_Char(Opa.Price_Adjustment_Id)
                 And Rctla.Sales_Order = Rctla2.Sales_Order
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%'
                      Or Arvt.Global_Attribute10 = 'CBS') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Arvt.Vat_Tax_Id = Zl.Tax_Rate_Id
                 And Arvt.Org_Id = Zl.Internal_Organization_Id
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Nvl(Arvt.Global_Attribute10, 'Nulo') In ('ICMS-ST-FP')
                 And Arvt.Global_Attribute2 = 'Y'
                 And Msib.Item_Type = 'FRT'
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 2) Aux
       Group By Aux.Aliq_Fcp;
    R1 C1%Rowtype;
    --
    Cursor c_Icms_Deson Is
      Select (Jbctl.Deferred_Icms_Amount * 100) Vl_Icms_Deson
        From Zx_Lines                  Zl
            ,Ar_Vat_Tax_All            Arvt
            ,Jl_Br_Cust_Trx_Lines_Exts Jbctl
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Trx_Id = Jbctl.Customer_Trx_Id
         And Zl.Trx_Line_Id = Jbctl.Customer_Trx_Line_Id
         And Arvt.Global_Attribute10 = 'ICMS'
         And Arvt.Global_Attribute3 = 'ICMS_EXEMPT_REASON'
         And Arvt.Global_Attribute9 In
             ('20', '30', '40', '41', '50', '70', '90')
            /*And Nvl(Zl.Global_Attribute10, Legal_Justification_Text3) Is Not Null*/ -- Carranza 02/09/2019
         And Nvl(Jbctl.Deferred_Icms_Amount, 0) > 0
         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id;
    R2 c_Icms_Deson%Rowtype;
    --
    Cursor c_Icmsstdev Is
      Select Case
               When Arvt.Global_Attribute10 In ('ICMS-ST', 'ICMS-ST-FP') Then
                2
             End Cod_Imposto
            ,Case
               When Arvt.Global_Attribute11 = 'Y' Then
                1
               Else
                0
             End Dm_Tipo
            ,Sum(Zl.Taxable_Amt) Vl_Base_Outro
            ,Sum(Abs(Zl.Tax_Rate)) * 100 Aliq_Aplic_Outro
            ,Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt)) Vl_Imp_Outro
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Arvt.Global_Attribute10 In ('ICMS-ST', 'ICMS-ST-FP')
         And Arvt.Global_Attribute2 = 'N'
         And Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0) > 0
         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
       Group By Case
                  When Arvt.Global_Attribute10 In ('ICMS-ST', 'ICMS-ST-FP') Then
                   2
                End
               ,Case
                  When Arvt.Global_Attribute11 = 'Y' Then
                   1
                  Else
                   0
                End;
    R3 c_Icmsstdev%Rowtype;
    --
    Cursor c_Icmsbaseisenta Is
      Select Case
               When Arvt.Global_Attribute10 = 'ICMS'
                    And Nvl(p_Rvcii.Cod_St, Lpad(Arvt.Global_Attribute9, 2, 0)) In
                    ('30', '40', '41', '50', '51') Then
                (Zl.Taxable_Amt * 100)
             End Vl_Base_Isenta
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Arvt.Global_Attribute10 In ('ICMS')
         And Arvt.Global_Attribute2 = 'Y'
         And Nvl(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 0) = 0
         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
         And p_Cod_Imposto = 1;
    R4 c_Icmsbaseisenta%Rowtype;
    --
    Cursor c_Percentdifer Is
      Select (Arvt.Global_Attribute12 * 10000) Percent_Difer
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Arvt.Global_Attribute10 In ('ICMS')
            --And Arvt.Global_Attribute3 = 'ICMS_EXEMPT_REASON' -- Carranza 02/04/2026
         And Nvl(p_Rvcii.Cod_St, Arvt.Global_Attribute9) = '51'
         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
         And p_Cod_Imposto = 1;
    R5 c_Percentdifer%Rowtype;
    --
    Cursor c_Icms_Difer Is
      Select (Jbctl.Deferred_Icms_Amount * 100) Vl_Icms_Difer
        From Zx_Lines                  Zl
            ,Ar_Vat_Tax_All            Arvt
            ,Jl_Br_Cust_Trx_Lines_Exts Jbctl
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Trx_Id = Jbctl.Customer_Trx_Id
         And Zl.Trx_Line_Id = Jbctl.Customer_Trx_Line_Id
         And Arvt.Global_Attribute10 = 'ICMS'
         And Arvt.Global_Attribute3 = 'ICMS_EXEMPT_REASON'
         And Arvt.Global_Attribute9 In ('51')
         And Nvl(Jbctl.Deferred_Icms_Amount, 0) > 0
         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
         And p_Cod_Imposto = 1;
    R6 c_Icms_Difer%Rowtype;
    --
    /*Cursor para recuperar o IBS de competencia do Municipio (IBSMUN), que nao vem no AR como imposto proprio e precisa subir como atributo do IBS na FF -- Carranza 08/09/2026*/
    Cursor c_Ibsmun Is
      Select Sum(Aux.Vl_Bc_Mun) Vl_Bc_Mun
            ,Aux.Aliq_Mun Aliq_Mun
            ,Abs(Sum(Aux.Vl_Mun)) Vl_Mun
        From (
              /*Imposto Item*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Mun
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Mun
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Mun
                From Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Arvt.Global_Attribute10 = 'IBSMUN'
                 And Arvt.Global_Attribute2 = 'Y'
                 And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
                 And (Rctla.Interface_Line_Attribute11 = 0 Or
                     Rctla.Interface_Line_Attribute11 Is Null)
                 And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null)
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 28
              Union
              /*Imposto Desconto (Deduz o valor de desconto no calculo do imposto do item)*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Mun
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Mun
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Mun
                From Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Ra_Customer_Trx_Lines_All Rctlad
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctlad.Customer_Trx_Line_Id
                 And Zl.Trx_Id = Rctlad.Customer_Trx_Id
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Arvt.Global_Attribute10 = 'IBSMUN'
                 And Arvt.Global_Attribute2 = 'Y'
                 And Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And (Rctla.Interface_Line_Attribute11 = '0' Or
                     Rctla.Interface_Line_Attribute11 Is Null)
                 And (Msib.Item_Type <> 'FRT' Or Msib.Item_Type Is Null)
                 And Rctlad.Customer_Trx_Id = Rctla.Customer_Trx_Id
                 And Rctlad.Interface_Line_Attribute6 =
                     Rctla.Interface_Line_Attribute6
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Rctlad.Line_Type = 'LINE'
                 And Rctlad.Interface_Line_Attribute11 Is Not Null
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 28
              Union
              /*Imposto Frete (Acrescenta o valor do frete no calculo do imposto do item)*/
              Select (Zl.Taxable_Amt) * 100 Vl_Bc_Mun
                     ,Abs(Zl.Tax_Rate) * 10000 Aliq_Mun
                     ,Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt) * 100 Vl_Mun
                From Ra_Customer_Trx_Lines_All Rctla2
                     ,Apps.Oe_Price_Adjustments Opa
                     ,Ra_Customer_Trx_Lines_All Rctla
                     ,Zx_Lines                  Zl
                     ,Ar_Vat_Tax_All            Arvt
                     ,Mtl_System_Items_b        Msib
               Where 1 = 1
                 And Rctla2.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
                 And Rctla2.Line_Type = 'LINE'
                 And Rctla2.Interface_Line_Context = 'ORDER ENTRY'
                 And Opa.Line_Id = Rctla2.Interface_Line_Attribute6
                 And Opa.Charge_Type_Code = 'FREIGHT'
                 And Opa.Arithmetic_Operator = 'AMT'
                 And Rctla.Interface_Line_Attribute6 =
                     To_Char(Opa.Price_Adjustment_Id)
                 And Rctla.Sales_Order = Rctla2.Sales_Order
                 And Rctla.Line_Type = 'LINE'
                 And (Nvl(Rctla.Interface_Line_Context, 'Nulo') <>
                     'CLL F189 INTEGRATED RCV'
                      Or Arvt.Global_Attribute10 Like 'IBS%') /*Nao pegar impostos do AR se a NFe for de origem do RI, exceto IBS/CBS que seguem o Attribute2 -- Carranza 08/09/2026*/
                 And Zl.Trx_Id = Rctla.Customer_Trx_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Arvt.Vat_Tax_Id = Zl.Tax_Rate_Id
                 And Arvt.Org_Id = Zl.Internal_Organization_Id
                 And Msib.Inventory_Item_Id = Rctla.Inventory_Item_Id
                 And Msib.Organization_Id = Rctla.Warehouse_Id
                 And Arvt.Global_Attribute10 = 'IBSMUN'
                 And Arvt.Global_Attribute2 = 'Y'
                 And Msib.Item_Type = 'FRT'
                 And Abs(Zl.Tax_Rate) > 0
                 And p_Cod_Imposto = 28) Aux
       Group By Aux.Aliq_Mun;
    R7 c_Ibsmun%Rowtype;
    --
    Cursor c_PercentdiferIBSUF Is
      Select (Arvt.Global_Attribute14 * 10000) Percent_Difer
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Arvt.Global_Attribute2 = 'Y'
         And Arvt.Global_Attribute10 In ('IBSUF')
         And Nvl(null, Arvt.Global_Attribute19) = '515'
         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
         And p_Cod_Imposto = 28;
    R8 c_PercentdiferIBSUF%Rowtype;
    --
  Begin
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,p_Rvcii.Cod_Imposto
          ,p_Rvcii.Dm_Tipo
          ,'VL_BC_FCP'
          ,R1.Vl_Bc_Fcp);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcii.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcii.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcii.Cod_Mod || ', Serie: ' || p_Rvcii.Serie ||
                         ', Nro_Nf: ' || p_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,p_Rvcii.Cod_Imposto
          ,p_Rvcii.Dm_Tipo
          ,'ALIQ_FCP'
          ,R1.Aliq_Fcp);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcii.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcii.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcii.Cod_Mod || ', Serie: ' || p_Rvcii.Serie ||
                         ', Nro_Nf: ' || p_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,p_Rvcii.Cod_Imposto
          ,p_Rvcii.Dm_Tipo
          ,'VL_FCP'
          ,R1.Vl_Fcp);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcii.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcii.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcii.Cod_Mod || ', Serie: ' || p_Rvcii.Serie ||
                         ', Nro_Nf: ' || p_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
    /*IBSMUN: sobe como atributo do IBS (Cod_Imposto=28) na FF, conforme leiaute -- Carranza 08/09/2026*/
    Open c_Ibsmun;
    Loop
      Fetch c_Ibsmun
        Into R7;
      Exit When c_Ibsmun%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,p_Rvcii.Cod_Imposto
          ,p_Rvcii.Dm_Tipo
          ,'ALIQ_APLIC_MUN'
          ,R7.Aliq_Mun);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (ALIQ_APLIC_MUN) - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcii.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcii.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcii.Cod_Mod || ', Serie: ' || p_Rvcii.Serie ||
                         ', Nro_Nf: ' || p_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,p_Rvcii.Cod_Imposto
          ,p_Rvcii.Dm_Tipo
          ,'VL_IMP_TRIB_MUN'
          ,R7.Vl_Mun);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_IMP_TRIB_MUN) - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcii.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcii.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcii.Cod_Mod || ', Serie: ' || p_Rvcii.Serie ||
                         ', Nro_Nf: ' || p_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close c_Ibsmun;
    --
    /*IBSMUN: se nao veio do AR, busca no RI (Cll_F189_Invoice_Lines) para notas de devolucao -- Carranza 08/09/2026*/
    If p_Cod_Imposto = 28
    Then
      l_Naux := 0;
      Begin
        Select Count(1)
          Into l_Naux
          From Vw_Csf_Imp_Itemnf_Ff
         Where Cpf_Cnpj_Emit = p_Rvcii.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcii.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcii.Dm_Ind_Oper
           And Cod_Part = p_Rvcii.Cod_Part
           And Cod_Mod = p_Rvcii.Cod_Mod
           And Serie = p_Rvcii.Serie
           And Nro_Nf = p_Rvcii.Nro_Nf
           And Nro_Item = p_Rvcii.Nro_Item
           And Cod_Imposto = p_Rvcii.Cod_Imposto
           And Dm_Tipo = p_Rvcii.Dm_Tipo
           And Atributo = 'VL_IMP_TRIB_MUN';
      End;
      --
      If l_Naux = 0
      Then
        l_Aliq_Mun_Ri := Null;
        l_Vl_Mun_Ri   := Null;
        --
        Begin
          Select Abs(Nvl(Round(Cfil.Ibs_Mun_Tax, 4), 0)) * 10000
                ,Abs(Nvl(Round(Cfil.Ibs_Mun_Amount, 2), 0)) * 100
            Into l_Aliq_Mun_Ri, l_Vl_Mun_Ri
            From Ra_Customer_Trx_Lines_All Rctla
                ,Cll_F189_Invoice_Lines    Cfil
           Where Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
             And Rctla.Interface_Line_Context = 'CLL F189 INTEGRATED RCV'
             And Cfil.Invoice_Line_Id = Rctla.Interface_Line_Attribute4
             And Rownum = 1;
        Exception
          When Others Then
            l_Aliq_Mun_Ri := Null;
            l_Vl_Mun_Ri   := Null;
        End;
        --
        If Nvl(l_Vl_Mun_Ri, 0) > 0
        Then
          --
          Begin
            Insert Into Vw_Csf_Imp_Itemnf_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Nro_Item
              ,Cod_Imposto
              ,Dm_Tipo
              ,Atributo
              ,Valor)
            Values
              (p_Rvcii.Cpf_Cnpj_Emit
              ,p_Rvcii.Dm_Ind_Emit
              ,p_Rvcii.Dm_Ind_Oper
              ,p_Rvcii.Cod_Part
              ,p_Rvcii.Cod_Mod
              ,p_Rvcii.Serie
              ,p_Rvcii.Nro_Nf
              ,p_Rvcii.Nro_Item
              ,p_Rvcii.Cod_Imposto
              ,p_Rvcii.Dm_Tipo
              ,'ALIQ_APLIC_MUN'
              ,l_Aliq_Mun_Ri);
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (ALIQ_APLIC_MUN_RI) - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                             ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                             ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                             Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
          --
          Begin
            Insert Into Vw_Csf_Imp_Itemnf_Ff
              (Cpf_Cnpj_Emit
              ,Dm_Ind_Emit
              ,Dm_Ind_Oper
              ,Cod_Part
              ,Cod_Mod
              ,Serie
              ,Nro_Nf
              ,Nro_Item
              ,Cod_Imposto
              ,Dm_Tipo
              ,Atributo
              ,Valor)
            Values
              (p_Rvcii.Cpf_Cnpj_Emit
              ,p_Rvcii.Dm_Ind_Emit
              ,p_Rvcii.Dm_Ind_Oper
              ,p_Rvcii.Cod_Part
              ,p_Rvcii.Cod_Mod
              ,p_Rvcii.Serie
              ,p_Rvcii.Nro_Nf
              ,p_Rvcii.Nro_Item
              ,p_Rvcii.Cod_Imposto
              ,p_Rvcii.Dm_Tipo
              ,'VL_IMP_TRIB_MUN'
              ,l_Vl_Mun_Ri);
            --
          Exception
            When Dup_Val_On_Index Then
              Null;
            When Others Then
              --
              g_Retcode   := 1;
              g_Erro      := Nvl(g_Erro, 0) + 1;
              l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_IMP_TRIB_MUN_RI) - ' ||
                             'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                             ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                             ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                             Sqlerrm;
              g_Erro_Msg  := l_Desc_Erro;
              --
              Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
              --
          End;
          --
        End If;
      End If;
    End If;
    --
    /*VL_IMP_TRIB_DEV_MUN: tenta AR (IBSMUN com Attribute2='N', mesmo padrao do VL_IPI_DEVOL), senao tenta RI, senao ignora -- Carranza 08/09/2026*/
    If p_Cod_Imposto = 28
    Then
      l_Vl_Trib_Dev_Mun := Null;
      --
      Begin
        Select Abs(Nvl(Round(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt), 2), 0)) * 100
          Into l_Vl_Trib_Dev_Mun
          From Zx_Lines                  Zl
              ,Ar_Vat_Tax_All            Arvt
              ,Ra_Customer_Trx_Lines_All Rctla
         Where Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
           And Zl.Internal_Organization_Id = Arvt.Org_Id
           And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
           And Zl.Trx_Id = Rctla.Customer_Trx_Id
           And Rctla.Line_Type = 'LINE'
           And Arvt.Global_Attribute10 = 'IBSMUN'
           And Arvt.Global_Attribute2 = 'N'
           And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id
           And Rownum = 1;
      Exception
        When Others Then
          l_Vl_Trib_Dev_Mun := Null;
      End;
      --
      If Nvl(l_Vl_Trib_Dev_Mun, 0) = 0
      Then
        --
        Begin
          Select Abs(Nvl(Round(Cfil.Ibs_Mun_Amount, 2), 0)) * 100
            Into l_Vl_Trib_Dev_Mun
            From Ra_Customer_Trx_Lines_All Rctla
                ,Cll_F189_Invoice_Lines    Cfil
           Where Rctla.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
             And Rctla.Interface_Line_Context = 'CLL F189 INTEGRATED RCV'
             And Cfil.Invoice_Line_Id = Rctla.Interface_Line_Attribute4
             And Rownum = 1;
        Exception
          When Others Then
            l_Vl_Trib_Dev_Mun := Null;
        End;
        --
      End If;
      --
      If Nvl(l_Vl_Trib_Dev_Mun, 0) > 0
      Then
        --
        Begin
          Insert Into Vw_Csf_Imp_Itemnf_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Atributo
            ,Valor)
          Values
            (p_Rvcii.Cpf_Cnpj_Emit
            ,p_Rvcii.Dm_Ind_Emit
            ,p_Rvcii.Dm_Ind_Oper
            ,p_Rvcii.Cod_Part
            ,p_Rvcii.Cod_Mod
            ,p_Rvcii.Serie
            ,p_Rvcii.Nro_Nf
            ,p_Rvcii.Nro_Item
            ,p_Rvcii.Cod_Imposto
            ,p_Rvcii.Dm_Tipo
            ,'VL_IMP_TRIB_DEV_MUN'
            ,l_Vl_Trib_Dev_Mun);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_IMP_TRIB_DEV_MUN) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                           ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        --
      End If;
    End If;
    --
    Open c_Icms_Deson;
    Loop
      Fetch c_Icms_Deson
        Into R2;
      Exit When c_Icms_Deson%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,p_Rvcii.Cod_Imposto
          ,p_Rvcii.Dm_Tipo
          ,'VL_ICMS_DESON'
          ,R2.Vl_Icms_Deson);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_ICMS_DESON) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                         p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                         ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close c_Icms_Deson;
    --
    Open c_Icmsstdev;
    Loop
      Fetch c_Icmsstdev
        Into R3;
      Exit When c_Icmsstdev%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,R3.Cod_Imposto
          ,R3.Dm_Tipo
          ,'VL_BASE_OUTRO'
          ,R3.Vl_Base_Outro);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcii.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcii.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcii.Cod_Mod || ', Serie: ' || p_Rvcii.Serie ||
                         ', Nro_Nf: ' || p_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,R3.Cod_Imposto
          ,R3.Dm_Tipo
          ,'ALIQ_APLIC_OUTRO'
          ,R3.Aliq_Aplic_Outro);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcii.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcii.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcii.Cod_Mod || ', Serie: ' || p_Rvcii.Serie ||
                         ', Nro_Nf: ' || p_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,R3.Cod_Imposto
          ,R3.Dm_Tipo
          ,'VL_IMP_OUTRO'
          ,R3.Vl_Imp_Outro);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcii.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcii.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcii.Cod_Mod || ', Serie: ' || p_Rvcii.Serie ||
                         ', Nro_Nf: ' || p_Rvcii.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcii.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close c_Icmsstdev;
    --
    If p_Rvcii.Cod_St In ('30', '40', '41', '50', '51')
    Then
      Open c_Icmsbaseisenta;
      Loop
        Fetch c_Icmsbaseisenta
          Into R4;
        Exit When c_Icmsbaseisenta%Notfound;
        ---
        Begin
          Insert Into Vw_Csf_Imp_Itemnf_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Atributo
            ,Valor)
          Values
            (p_Rvcii.Cpf_Cnpj_Emit
            ,p_Rvcii.Dm_Ind_Emit
            ,p_Rvcii.Dm_Ind_Oper
            ,p_Rvcii.Cod_Part
            ,p_Rvcii.Cod_Mod
            ,p_Rvcii.Serie
            ,p_Rvcii.Nro_Nf
            ,p_Rvcii.Nro_Item
            ,p_Rvcii.Cod_Imposto
            ,p_Rvcii.Dm_Tipo
            ,'VL_BASE_ISENTA'
            ,R4.Vl_Base_Isenta);
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_BASE_ISENTA) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                           p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
          --
        End;
        ---
      End Loop;
      Close c_Icmsbaseisenta;
    End If;
    --
    If p_Rvcii.Cod_St In ('51')
    Then
      Open c_Percentdifer;
      Loop
        Fetch c_Percentdifer
          Into R5;
        Exit When c_Percentdifer%Notfound;
        ---
        Begin
          Insert Into Vw_Csf_Imp_Itemnf_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Atributo
            ,Valor)
          Values
            (p_Rvcii.Cpf_Cnpj_Emit
            ,p_Rvcii.Dm_Ind_Emit
            ,p_Rvcii.Dm_Ind_Oper
            ,p_Rvcii.Cod_Part
            ,p_Rvcii.Cod_Mod
            ,p_Rvcii.Serie
            ,p_Rvcii.Nro_Nf
            ,p_Rvcii.Nro_Item
            ,p_Rvcii.Cod_Imposto
            ,p_Rvcii.Dm_Tipo
            ,'PERCENT_DIFER'
            ,R5.Percent_Difer);
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (PERCENT_DIFER) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                           p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
          --
        End;
        ---
      End Loop;
      Close c_Percentdifer;
    End If;
    --
    If p_Rvcii.Cod_St In ('51')
    Then
      Open c_Icms_Difer;
      Loop
        Fetch c_Icms_Difer
          Into R6;
        Exit When c_Icms_Difer%Notfound;
        ---
        Begin
          Insert Into Vw_Csf_Imp_Itemnf_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Atributo
            ,Valor)
          Values
            (p_Rvcii.Cpf_Cnpj_Emit
            ,p_Rvcii.Dm_Ind_Emit
            ,p_Rvcii.Dm_Ind_Oper
            ,p_Rvcii.Cod_Part
            ,p_Rvcii.Cod_Mod
            ,p_Rvcii.Serie
            ,p_Rvcii.Nro_Nf
            ,p_Rvcii.Nro_Item
            ,p_Rvcii.Cod_Imposto
            ,p_Rvcii.Dm_Tipo
            ,'VL_ICMS_DIFER'
            ,R6.Vl_Icms_Difer);
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_ICMS_DIFER) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                           p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
          --
        End;
        ---
      End Loop;
      Close c_Icms_Difer;
    End If;
    --
    If p_Rvcii.Cod_Imposto In (1)
    Then
      ---
      Begin
        Insert Into Vw_Csf_Imp_Itemnf_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Cod_Imposto
          ,Dm_Tipo
          ,Atributo
          ,Valor)
        Values
          (p_Rvcii.Cpf_Cnpj_Emit
          ,p_Rvcii.Dm_Ind_Emit
          ,p_Rvcii.Dm_Ind_Oper
          ,p_Rvcii.Cod_Part
          ,p_Rvcii.Cod_Mod
          ,p_Rvcii.Serie
          ,p_Rvcii.Nro_Nf
          ,p_Rvcii.Nro_Item
          ,p_Rvcii.Cod_Imposto
          ,p_Rvcii.Dm_Tipo
          ,'VL_ICMS_OPER'
          ,p_Rvcii.Vl_Imp_Trib * 100);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (VL_ICMS_OPER) - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                         p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                         ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End If;
    --
    If p_Cclass_Trib_Ibs Is Not Null
    Then
      l_Naux := 0;
      Begin
        Select Count(1)
          Into l_Naux
          From Vw_Csf_Imp_Itemnf_Ff
         Where Cpf_Cnpj_Emit = p_Rvcii.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcii.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcii.Dm_Ind_Oper
           And Cod_Part = p_Rvcii.Cod_Part
           And Cod_Mod = p_Rvcii.Cod_Mod
           And Serie = p_Rvcii.Serie
           And Nro_Nf = p_Rvcii.Nro_Nf
           And Nro_Item = p_Rvcii.Nro_Item
           And Cod_Imposto = p_Rvcii.Cod_Imposto
           And Dm_Tipo = p_Rvcii.Dm_Tipo
           And Atributo = 'COD_CLASS_TRIB';
        --- And Atributo = 'CLASS_TRIB_IMP';
      End;
      ---
      If l_Naux = 0
      Then
        ---
        Begin
          Insert Into Vw_Csf_Imp_Itemnf_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Atributo
            ,Valor)
          Values
            (p_Rvcii.Cpf_Cnpj_Emit
            ,p_Rvcii.Dm_Ind_Emit
            ,p_Rvcii.Dm_Ind_Oper
            ,p_Rvcii.Cod_Part
            ,p_Rvcii.Cod_Mod
            ,p_Rvcii.Serie
            ,p_Rvcii.Nro_Nf
            ,p_Rvcii.Nro_Item
            ,p_Rvcii.Cod_Imposto
            ,p_Rvcii.Dm_Tipo
            ,'COD_CLASS_TRIB'
             ---,'CLASS_TRIB_IMP'
            ,p_Cclass_Trib_Ibs);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (COD_CLASS_TRIB) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                           p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        ---
      End If;
    End If;
    --
    If p_Cclass_Trib_Cbs Is Not Null
    Then
      l_Naux := 0;
      Begin
        Select Count(1)
          Into l_Naux
          From Vw_Csf_Imp_Itemnf_Ff
         Where Cpf_Cnpj_Emit = p_Rvcii.Cpf_Cnpj_Emit
           And Dm_Ind_Emit = p_Rvcii.Dm_Ind_Emit
           And Dm_Ind_Oper = p_Rvcii.Dm_Ind_Oper
           And Cod_Part = p_Rvcii.Cod_Part
           And Cod_Mod = p_Rvcii.Cod_Mod
           And Serie = p_Rvcii.Serie
           And Nro_Nf = p_Rvcii.Nro_Nf
           And Nro_Item = p_Rvcii.Nro_Item
           And Cod_Imposto = p_Rvcii.Cod_Imposto
           And Dm_Tipo = p_Rvcii.Dm_Tipo
           And Atributo = 'COD_CLASS_TRIB';
        --- And Atributo = 'CLASS_TRIB_IMP';
      End;
      ---
      If l_Naux = 0
      Then
        ---
        Begin
          Insert Into Vw_Csf_Imp_Itemnf_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Atributo
            ,Valor)
          Values
            (p_Rvcii.Cpf_Cnpj_Emit
            ,p_Rvcii.Dm_Ind_Emit
            ,p_Rvcii.Dm_Ind_Oper
            ,p_Rvcii.Cod_Part
            ,p_Rvcii.Cod_Mod
            ,p_Rvcii.Serie
            ,p_Rvcii.Nro_Nf
            ,p_Rvcii.Nro_Item
            ,p_Rvcii.Cod_Imposto
            ,p_Rvcii.Dm_Tipo
            ,'COD_CLASS_TRIB'
             ---,'CLASS_TRIB_IMP'
            ,p_Cclass_Trib_Cbs);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (COD_CLASS_TRIB) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                           p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
        ---
      End If;
    End If;
    --
    If p_Rvcii.Cod_St In ('515')
    Then
      Open c_PercentdiferIBSUF;
      Loop
        Fetch c_PercentdiferIBSUF
          Into R8;
        Exit When c_PercentdiferIBSUF%Notfound;
        ---
        Begin
          Insert Into Vw_Csf_Imp_Itemnf_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Atributo
            ,Valor)
          Values
            (p_Rvcii.Cpf_Cnpj_Emit
            ,p_Rvcii.Dm_Ind_Emit
            ,p_Rvcii.Dm_Ind_Oper
            ,p_Rvcii.Cod_Part
            ,p_Rvcii.Cod_Mod
            ,p_Rvcii.Serie
            ,p_Rvcii.Nro_Nf
            ,p_Rvcii.Nro_Item
            ,p_Rvcii.Cod_Imposto
            ,p_Rvcii.Dm_Tipo
            ,'PERCENT_DIFER'
            ,R5.Percent_Difer);
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p (PERCENT_DIFER) - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                           p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
          --
        End;
        ---
      End Loop;
      Close c_PercentdiferIBSUF;
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Ff_p - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Imp_Itemnf_Ff_p;

  ---
  ---------------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Imp_Itemnf_Icms_Dest ---
  ---------------------------------------------------------------------------------
  Procedure Vw_Csf_Imp_Itemnf_Icms_Dest_p(p_Rvcii                  Vw_Csf_Imp_Itemnf%Rowtype
                                         ,p_Customer_Trx_Line_Id   Number
                                         ,p_Customer_Trx_Id        Number
                                         ,p_Cod_Imposto            Number
                                         ,p_Interface_Line_Context Varchar2
                                         ,p_Rotina                 Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select Nvl(Jbctl.Icms_Dest_Taxable_Basis, 0) Vl_Bc_Uf_Dest
            ,Nvl((Select Abs(Zl.Tax_Rate)
                   From Zx_Lines       Zl
                       ,Ar_Vat_Tax_All Arvt
                  Where 1 = 1
                    And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                    And Zl.Internal_Organization_Id = Arvt.Org_Id
                    And Arvt.Tax_Code Like 'ICMS%INTD%C%'
                    And Zl.Trx_Line_Id = Jbctl.Customer_Trx_Line_Id
                    And Zl.Trx_Id = Jbctl.Customer_Trx_Id), 0) +
             Nvl((Select Abs(Zl.Tax_Rate)
                   From Zx_Lines       Zl
                       ,Ar_Vat_Tax_All Arvt
                  Where 1 = 1
                    And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                    And Zl.Internal_Organization_Id = Arvt.Org_Id
                    And Arvt.Global_Attribute10 = 'ICMS'
                    And Arvt.Global_Attribute2 = 'Y'
                    And Zl.Trx_Line_Id = Jbctl.Customer_Trx_Line_Id
                    And Zl.Trx_Id = Jbctl.Customer_Trx_Id), 0) Perc_Icms_Uf_Dest
            ,Case
               When Jbctl.Icms_Interstate_Rate = 0 Then
                (Select Zl.Tax_Rate
                   From Zx_Lines       Zl
                       ,Ar_Vat_Tax_All Arvt
                  Where 1 = 1
                    And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                    And Zl.Internal_Organization_Id = Arvt.Org_Id
                    And Arvt.Global_Attribute10 = 'ICMS'
                    And Arvt.Global_Attribute2 = 'Y'
                    And Zl.Trx_Line_Id = Jbctl.Customer_Trx_Line_Id
                    And Zl.Trx_Id = Jbctl.Customer_Trx_Id)
               Else
                Nvl(Jbctl.Icms_Interstate_Rate, 0)
             End Perc_Icms_Inter
            ,Nvl(Jbctl.Icms_Share_Percentage, 0) Perc_Icms_Inter_Part
            ,Nvl((Jbctl.Icms_Tax_Destnation - Jbctl.Icms_Poverty_Tax), 0) Vl_Icms_Uf_Dest
            ,Nvl(Jbctl.Icms_Tax_Origin, 0) Vl_Icms_Uf_Remet
            ,Nvl(Jbctl.Icms_Poverty_Rate, 0) Perc_Comb_Pobr_Uf_Dest
            ,Nvl(Jbctl.Icms_Poverty_Tax, 0) Vl_Comb_Pobr_Uf_Dest
        From Apps.Jl_Br_Cust_Trx_Lines_Exts Jbctl
       Where 1 = 1
         And Jbctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Jbctl.Customer_Trx_Id = p_Customer_Trx_Id
         And p_Cod_Imposto = 1
         And Jbctl.Icms_Dest_Taxable_Basis > 0
         And Jbctl.Icms_Internal_Rate > 0;
    R1 C1%Rowtype;
    --
    l_Rvciid Vw_Csf_Imp_Itemnf_Icms_Dest%Rowtype;
    --
  Begin
    --
    If Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Imp_Itemnf_Icms_Dest_f(p_Rvcii => p_Rvcii, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Cod_Imposto => p_Cod_Imposto, p_Interface_Line_Context => p_Interface_Line_Context, p_Rotina => 'Xxisv_Csf_Nfe_Custom_Pkg.Vw_Csf_Imp_Itemnf_Icms_Dest_f') = 0
    Then
      --
      Open C1;
      Loop
        Fetch C1
          Into R1;
        Exit When C1%Notfound;
        ---
        l_Rvciid.Cpf_Cnpj_Emit          := p_Rvcii.Cpf_Cnpj_Emit;
        l_Rvciid.Dm_Ind_Emit            := p_Rvcii.Dm_Ind_Emit;
        l_Rvciid.Dm_Ind_Oper            := p_Rvcii.Dm_Ind_Oper;
        l_Rvciid.Cod_Part               := p_Rvcii.Cod_Part;
        l_Rvciid.Cod_Mod                := p_Rvcii.Cod_Mod;
        l_Rvciid.Serie                  := p_Rvcii.Serie;
        l_Rvciid.Nro_Nf                 := p_Rvcii.Nro_Nf;
        l_Rvciid.Nro_Item               := p_Rvcii.Nro_Item;
        l_Rvciid.Cod_Imposto            := p_Rvcii.Cod_Imposto;
        l_Rvciid.Dm_Tipo                := p_Rvcii.Dm_Tipo;
        l_Rvciid.Vl_Bc_Uf_Dest          := R1.Vl_Bc_Uf_Dest;
        l_Rvciid.Perc_Icms_Uf_Dest      := R1.Perc_Icms_Uf_Dest;
        l_Rvciid.Perc_Icms_Inter        := R1.Perc_Icms_Inter;
        l_Rvciid.Perc_Icms_Inter_Part   := R1.Perc_Icms_Inter_Part;
        l_Rvciid.Vl_Icms_Uf_Dest        := R1.Vl_Icms_Uf_Dest;
        l_Rvciid.Vl_Icms_Uf_Remet       := R1.Vl_Icms_Uf_Remet;
        l_Rvciid.Perc_Comb_Pobr_Uf_Dest := R1.Perc_Comb_Pobr_Uf_Dest;
        l_Rvciid.Vl_Comb_Pobr_Uf_Dest   := R1.Vl_Comb_Pobr_Uf_Dest;
        --
        Begin
          Insert Into Vw_Csf_Imp_Itemnf_Icms_Dest
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Cod_Imposto
            ,Dm_Tipo
            ,Vl_Bc_Uf_Dest
            ,Perc_Icms_Uf_Dest
            ,Perc_Icms_Inter
            ,Perc_Icms_Inter_Part
            ,Vl_Icms_Uf_Dest
            ,Vl_Icms_Uf_Remet
            ,Perc_Comb_Pobr_Uf_Dest
            ,Vl_Comb_Pobr_Uf_Dest)
          Values
            (p_Rvcii.Cpf_Cnpj_Emit
            ,p_Rvcii.Dm_Ind_Emit
            ,p_Rvcii.Dm_Ind_Oper
            ,p_Rvcii.Cod_Part
            ,p_Rvcii.Cod_Mod
            ,p_Rvcii.Serie
            ,p_Rvcii.Nro_Nf
            ,p_Rvcii.Nro_Item
            ,p_Rvcii.Cod_Imposto
            ,p_Rvcii.Dm_Tipo
            ,R1.Vl_Bc_Uf_Dest
            ,R1.Perc_Icms_Uf_Dest
            ,R1.Perc_Icms_Inter
            ,R1.Perc_Icms_Inter_Part
            ,R1.Vl_Icms_Uf_Dest
            ,R1.Vl_Icms_Uf_Remet
            ,R1.Perc_Comb_Pobr_Uf_Dest
            ,R1.Vl_Comb_Pobr_Uf_Dest);
          --
          If R1.Vl_Bc_Uf_Dest > 0
          Then
            Xxisv_Csf_Nfe_Pkg.Vw_Csf_Impitemnf_Icmsdest_Ff_p(p_Rvciid => l_Rvciid, p_Rotina => p_Rotina);
          End If;
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Icms_Dest_P - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcii.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcii.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcii.Cod_Mod || ', Serie: ' ||
                           p_Rvcii.Serie || ', Nro_Nf: ' || p_Rvcii.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcii.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
          --
        End;
        ---
      End Loop;
      Close C1;
      --
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Imp_Itemnf_Icms_Dest_P - ' || ' Erro: ' ||
                     Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Imp_Itemnf_Icms_Dest_p;

  ---
  -----------------------------------------------------------------------------------
  -- Procedure utilizada para inclusão de dados na Vw_Csf_Imp_Itemnf_Icms_Dest_Ff ---
  -----------------------------------------------------------------------------------
  Procedure Vw_Csf_Impitemnf_Icmsdest_Ff_p(p_Rvciid Vw_Csf_Imp_Itemnf_Icms_Dest%Rowtype
                                          ,p_Rotina Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
  Begin
    --
    Begin
      Insert Into Vw_Csf_Imp_Itemnf_Icms_Dest_Ff
        (Cpf_Cnpj_Emit
        ,Dm_Ind_Emit
        ,Dm_Ind_Oper
        ,Cod_Part
        ,Cod_Mod
        ,Serie
        ,Nro_Nf
        ,Nro_Item
        ,Cod_Imposto
        ,Dm_Tipo
        ,Atributo
        ,Valor)
      Values
        (p_Rvciid.Cpf_Cnpj_Emit
        ,p_Rvciid.Dm_Ind_Emit
        ,p_Rvciid.Dm_Ind_Oper
        ,p_Rvciid.Cod_Part
        ,p_Rvciid.Cod_Mod
        ,p_Rvciid.Serie
        ,p_Rvciid.Nro_Nf
        ,p_Rvciid.Nro_Item
        ,p_Rvciid.Cod_Imposto
        ,p_Rvciid.Dm_Tipo
        ,'VL_BC_FCP_DEST'
        ,((p_Rvciid.Vl_Bc_Uf_Dest) * 100));
      --
    Exception
      When Dup_Val_On_Index Then
        Null;
      When Others Then
        --
        g_Retcode   := 1;
        g_Erro      := Nvl(g_Erro, 0) + 1;
        l_Desc_Erro := 'Vw_Csf_ImpItemnf_IcmsDest_Ff - ' || 'Cpf_Cnpj_Emit: ' ||
                       p_Rvciid.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                       p_Rvciid.Dm_Ind_Emit || ', Cod_Mod: ' ||
                       p_Rvciid.Cod_Mod || ', Serie: ' || p_Rvciid.Serie ||
                       ', Nro_Nf: ' || p_Rvciid.Nro_Nf || ', Erro: ' ||
                       Sqlerrm;
        g_Erro_Msg  := l_Desc_Erro;
        --
        Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
        --
    End;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_ImpItemnf_IcmsDest_Ff_p - ' || ' Erro: ' ||
                     Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Impitemnf_Icmsdest_Ff_p;

  ---
  --------------------------------------------------------------------------------
  ------- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnf_Comb -------
  --------------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnf_Comb_p(p_Rvcinf            Vw_Csf_Item_Nota_Fiscal%Rowtype
                                ,p_Inventory_Item_Id Number
                                ,p_Warehouse_Id      Number
                                ,p_Uf_Cons           Varchar2
                                ,p_Rotina            Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select Msib.Global_Attribute12 Codprodanp
            ,Null Codif
            ,Null Qtde_Temp
            ,Null Qtde_Bc_Cide
            ,Null Vl_Aliq_Prod_Cide
            ,Null Vl_Cide
            ,Null Vl_Base_Calc_Icms
            ,Null Vl_Icms
            ,Null Vl_Base_Calc_Icms_St
            ,Null Vl_Icms_St
            ,Null Vl_Bc_Icms_St_Dest
            ,Null Vl_Icms_St_Dest
            ,Null Vl_Bc_Icms_St_Cons
            ,Null Vl_Icms_St_Cons
            ,Substr(p_Uf_Cons, 1, 2) Uf_Cons
            ,Null Nro_Passe
        From Mtl_System_Items_b Msib
       Where Msib.Inventory_Item_Id = p_Inventory_Item_Id
         And Msib.Organization_Id = p_Warehouse_Id
         And Msib.Global_Attribute12 Is Not Null;
    R1 C1%Rowtype;
  Begin
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Itemnf_Comb
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Codprodanp
          ,Codif
          ,Qtde_Temp
          ,Qtde_Bc_Cide
          ,Vl_Aliq_Prod_Cide
          ,Vl_Cide
          ,Vl_Base_Calc_Icms
          ,Vl_Icms
          ,Vl_Base_Calc_Icms_St
          ,Vl_Icms_St
          ,Vl_Bc_Icms_St_Dest
          ,Vl_Icms_St_Dest
          ,Vl_Bc_Icms_St_Cons
          ,Vl_Icms_St_Cons
          ,Uf_Cons
          ,Nro_Passe)
        Values
          (p_Rvcinf.Cpf_Cnpj_Emit
          ,p_Rvcinf.Dm_Ind_Emit
          ,p_Rvcinf.Dm_Ind_Oper
          ,p_Rvcinf.Cod_Part
          ,p_Rvcinf.Cod_Mod
          ,p_Rvcinf.Serie
          ,p_Rvcinf.Nro_Nf
          ,p_Rvcinf.Nro_Item
          ,R1.Codprodanp
          ,R1.Codif
          ,R1.Qtde_Temp
          ,R1.Qtde_Bc_Cide
          ,R1.Vl_Aliq_Prod_Cide
          ,R1.Vl_Cide
          ,R1.Vl_Base_Calc_Icms
          ,R1.Vl_Icms
          ,R1.Vl_Base_Calc_Icms_St
          ,R1.Vl_Icms_St
          ,R1.Vl_Bc_Icms_St_Dest
          ,R1.Vl_Icms_St_Dest
          ,R1.Vl_Bc_Icms_St_Cons
          ,R1.Vl_Icms_St_Cons
          ,R1.Uf_Cons
          ,R1.Nro_Passe);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnf_Comb_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                         ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnf_Comb_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnf_Comb_p;

  ---
  -------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnf_Med ---
  -------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnf_Med_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                               ,p_Customer_Trx_Line_Id Number
                               ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select Substr(To_Char(Rctl.Attribute11), 1, 20) Nro_Lote -- Carranza 08/11/2018
             --Substr(To_Char(Replace(Replace(Replace(Trim(Rctl.Attribute11), '.', ''), '/', ''), '-', '')), 1, 20) Nro_Lote -- Carranza 08/11/2018
            ,2 Dm_Tp_Prod
            ,0 Dm_Ind_Med
            ,Nvl(Fnd_Number.Canonical_To_Number(Rctl.Attribute12), To_Number(Rctl.Quantity_Invoiced)) Qtde_Lote
             /*  Ito 16/09/2019 - Correcao erro ORA-01858: a non-numeric character was found where a numeric was expected */
             --  ,To_Date(Rctl.Attribute13, 'DD/MM/RRRR') Dt_Fabr -- Ito 16/09/2019
            ,To_Date(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Upper(Rctl.Attribute13), 'JAN', '01'), 'FEB', '02'), 'FEV', '02'), 'MAR', '03'), 'APR', '04'), 'ABR', '04'), 'MAY', '05'), 'MAI', '05'), 'JUN', '06'), 'JUL', '07'), 'AUG', '08'), 'AGO', '08'), 'SEP', '09'), 'SET', '09'), 'OCT', '10'), 'OUT', '10'), 'NOV', '11'), 'DEC', '12'), 'DEZ', '12'), 'DD/MM/YYYY') Dt_Fabr -- Ito 16/09/2019
             --  ,To_Date(Rctl.Attribute14, 'DD/MM/RRRR') Dt_Valid -- Ito 16/09/2019
            ,To_Date(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Upper(Rctl.Attribute14), 'JAN', '01'), 'FEB', '02'), 'FEV', '02'), 'MAR', '03'), 'APR', '04'), 'ABR', '04'), 'MAY', '05'), 'MAI', '05'), 'JUN', '06'), 'JUL', '07'), 'AUG', '08'), 'AGO', '08'), 'SEP', '09'), 'SET', '09'), 'OCT', '10'), 'OUT', '10'), 'NOV', '11'), 'DEC', '12'), 'DEZ', '12'), 'DD/MM/YYYY') Dt_Valid -- Ito 16/09/2019
             /*,Fnd_Number.Canonical_To_Number(Nvl(Rctl.Attribute9, '0')) Vl_Tab_Max*/ -- Carranza 09/09/2019
            ,Fnd_Number.Canonical_To_Number(Nvl(Rctl.Attribute9, 0)) Vl_Tab_Max -- Carranza 09/09/2019
        From Mtl_Parameters             Mp
            ,Mtl_System_Items_b         Msi
            ,Ra_Customer_Trx_Lines_All  Rctl
            ,Apps.Mtl_Item_Categories_v Mic
       Where 1 = 1
         And Rctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctl.Warehouse_Id = Mp.Organization_Id
         And Msi.Organization_Id = Mp.Master_Organization_Id
         And Msi.Inventory_Item_Id = Rctl.Inventory_Item_Id
         And Msi.Organization_Id = Mic.Organization_Id
         And Msi.Inventory_Item_Id = Mic.Inventory_Item_Id
         And Mic.Validate_Flag = 'Y'
         And Mic.Category_Set_Id = 1100000061
         And Upper(Mic.Category_Set_Name) = 'CATEGORIAS DE ITEM'
         And Upper(Mic.Segment8) = 'MEDICAMENTOS'
         And Substr(To_Char(Rctl.Attribute11), 1, 20) Is Not Null -- Carranza 04/09/2019 (Incluido para parar de dar advertencia no concorrente pois é uma informação obrigatória)
      ;
    R1      C1%Rowtype;
    l_Rvcim Vw_Csf_Itemnf_Med%Rowtype;
  Begin
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      l_Rvcim.Cpf_Cnpj_Emit := p_Rvcinf.Cpf_Cnpj_Emit;
      l_Rvcim.Dm_Ind_Emit   := p_Rvcinf.Dm_Ind_Emit;
      l_Rvcim.Dm_Ind_Oper   := p_Rvcinf.Dm_Ind_Oper;
      l_Rvcim.Cod_Part      := p_Rvcinf.Cod_Part;
      l_Rvcim.Cod_Mod       := p_Rvcinf.Cod_Mod;
      l_Rvcim.Serie         := p_Rvcinf.Serie;
      l_Rvcim.Nro_Nf        := p_Rvcinf.Nro_Nf;
      l_Rvcim.Nro_Item      := p_Rvcinf.Nro_Item;
      l_Rvcim.Nro_Lote      := R1.Nro_Lote;
      l_Rvcim.Dm_Tp_Prod    := R1.Dm_Tp_Prod;
      l_Rvcim.Dm_Ind_Med    := R1.Dm_Ind_Med;
      l_Rvcim.Qtde_Lote     := R1.Qtde_Lote;
      l_Rvcim.Dt_Fabr       := R1.Dt_Fabr;
      l_Rvcim.Dt_Valid      := R1.Dt_Valid;
      l_Rvcim.Vl_Tab_Max    := R1.Vl_Tab_Max;
      ---
      Begin
        Insert Into Vw_Csf_Itemnf_Med
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Nro_Lote
          ,Dm_Tp_Prod
          ,Dm_Ind_Med
          ,Qtde_Lote
          ,Dt_Fabr
          ,Dt_Valid
          ,Vl_Tab_Max)
        Values
          (p_Rvcinf.Cpf_Cnpj_Emit
          ,p_Rvcinf.Dm_Ind_Emit
          ,p_Rvcinf.Dm_Ind_Oper
          ,p_Rvcinf.Cod_Part
          ,p_Rvcinf.Cod_Mod
          ,p_Rvcinf.Serie
          ,p_Rvcinf.Nro_Nf
          ,p_Rvcinf.Nro_Item
          ,R1.Nro_Lote
          ,R1.Dm_Tp_Prod
          ,R1.Dm_Ind_Med
          ,R1.Qtde_Lote
          ,R1.Dt_Fabr
          ,R1.Dt_Valid
          ,R1.Vl_Tab_Max);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnf_Med_Ff_p(p_Rvcim => l_Rvcim, p_Customer_Trx_Line_Id => p_Customer_Trx_Line_Id, p_Rotina => p_Rotina);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnf_Med - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                         ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnf_Med_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnf_Med_p;

  ---
  -------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnf_Med ---
  -------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnf_Med_Ff_p(p_Rvcim                Vw_Csf_Itemnf_Med%Rowtype
                                  ,p_Customer_Trx_Line_Id Number
                                  ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select 'COD_ANVISA' Atributo
            ,Substr(To_Char(Nvl(Msi.Attribute6, 'ISENTO')), 1, 13) Valor
        From Mtl_Parameters             Mp
            ,Mtl_System_Items_b         Msi
            ,Ra_Customer_Trx_Lines_All  Rctl
            ,Apps.Mtl_Item_Categories_v Mic
       Where 1 = 1
         And Rctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctl.Warehouse_Id = Mp.Organization_Id
         And Msi.Organization_Id = Mp.Master_Organization_Id
         And Msi.Inventory_Item_Id = Rctl.Inventory_Item_Id
            /*And Length(Msi.Attribute6) = 13*/ -- Retirada condição devido existirem codigos Anvisa com 11 caracteres. Solicitado por Felipe me 11/01/2019
         And Msi.Organization_Id = Mic.Organization_Id
         And Msi.Inventory_Item_Id = Mic.Inventory_Item_Id
         And Mic.Validate_Flag = 'Y'
         And Mic.Category_Set_Id = 1100000061
         And Upper(Mic.Category_Set_Name) = 'CATEGORIAS DE ITEM'
         And Upper(Mic.Segment8) = 'MEDICAMENTOS'
      --
      Union /*Inclusão do Union de acordo com a NT2018.005*/ -- Carranza 06/06/2019
      --
      Select 'MOT_ISEN_ANVISA' Atributo
            ,Substr(To_Char(Msi.Attribute3), 1, 255) Valor
        From Mtl_Parameters             Mp
            ,Mtl_System_Items_b         Msi
            ,Ra_Customer_Trx_Lines_All  Rctl
            ,Apps.Mtl_Item_Categories_v Mic
       Where 1 = 1
         And Rctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctl.Warehouse_Id = Mp.Organization_Id
         And Msi.Organization_Id = Mp.Master_Organization_Id
         And Msi.Inventory_Item_Id = Rctl.Inventory_Item_Id
            /*And Length(Msi.Attribute6) = 13*/ -- Retirada condição devido existirem codigos Anvisa com 11 caracteres. Solicitado por Felipe me 11/01/2019
         And Msi.Organization_Id = Mic.Organization_Id
         And Msi.Inventory_Item_Id = Mic.Inventory_Item_Id
         And Mic.Validate_Flag = 'Y'
         And Mic.Category_Set_Id = 1100000061
         And Upper(Mic.Category_Set_Name) = 'CATEGORIAS DE ITEM'
         And Upper(Mic.Segment8) = 'MEDICAMENTOS'
         And Nvl(Upper(Msi.Attribute6), 'ISENTO') = 'ISENTO';
    R1 C1%Rowtype;
  Begin
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Itemnf_Med_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Nro_Lote
          ,Atributo
          ,Valor)
        Values
          (p_Rvcim.Cpf_Cnpj_Emit
          ,p_Rvcim.Dm_Ind_Emit
          ,p_Rvcim.Dm_Ind_Oper
          ,p_Rvcim.Cod_Part
          ,p_Rvcim.Cod_Mod
          ,p_Rvcim.Serie
          ,p_Rvcim.Nro_Nf
          ,p_Rvcim.Nro_Item
          ,p_Rvcim.Nro_Lote
          ,R1.Atributo
          ,R1.Valor);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnf_Med_Ff - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcim.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcim.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcim.Cod_Mod || ', Serie: ' || p_Rvcim.Serie ||
                         ', Nro_Nf: ' || p_Rvcim.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnf_Med_Ff_p - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnf_Med_Ff_p;

  ---
  ----------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnf_Rastreab ---
  ----------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnf_Rastreab_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                                    ,p_Customer_Trx_Line_Id Number
                                    ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select --Substr(To_Char(Replace(Replace(Replace(Trim(Rctl.Attribute11), '.', ''), '/', ''), '-', '')), 1, 20) Nro_Lote -- Carranza 08/11/2018
       Substr(To_Char(Rctl.Attribute11), 1, 20) Nro_Lote -- Carranza 08/11/2018
      ,Nvl(Fnd_Number.Canonical_To_Number(Rctl.Attribute12), To_Number(Rctl.Quantity_Invoiced)) Qtde_Lote
      ,To_Date(Rctl.Attribute13, 'DD/MM/RRRR') Dt_Fabr
      ,To_Date(Rctl.Attribute14, 'DD/MM/RRRR') Dt_Valid
      ,Null Cod_Agreg
        From Mtl_Parameters             Mp
            ,Mtl_System_Items_b         Msi
            ,Ra_Customer_Trx_Lines_All  Rctl
            ,Apps.Mtl_Item_Categories_v Mic
       Where 1 = 1
         And Rctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctl.Warehouse_Id = Mp.Organization_Id
         And Msi.Organization_Id = Mp.Master_Organization_Id
         And Msi.Inventory_Item_Id = Rctl.Inventory_Item_Id
         And Msi.Organization_Id = Mic.Organization_Id
         And Msi.Inventory_Item_Id = Mic.Inventory_Item_Id
         And Mic.Validate_Flag = 'Y'
         And Mic.Category_Set_Id = 1100000061
         And Upper(Mic.Category_Set_Name) = 'CATEGORIAS DE ITEM'
         And Upper(Mic.Segment8) = 'MEDICAMENTOS'
         And Substr(To_Char(Rctl.Attribute11), 1, 20) Is Not Null -- Carranza 04/09/2019 (Incluido para parar de dar advertencia no concorrente pois é uma informação obrigatória)
      ;
    R1 C1%Rowtype;
  Begin
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Itemnf_Rastreab
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Nro_Lote
          ,Qtde_Lote
          ,Dt_Fabr
          ,Dt_Valid
          ,Cod_Agreg)
        Values
          (p_Rvcinf.Cpf_Cnpj_Emit
          ,p_Rvcinf.Dm_Ind_Emit
          ,p_Rvcinf.Dm_Ind_Oper
          ,p_Rvcinf.Cod_Part
          ,p_Rvcinf.Cod_Mod
          ,p_Rvcinf.Serie
          ,p_Rvcinf.Nro_Nf
          ,p_Rvcinf.Nro_Item
          ,R1.Nro_Lote
          ,R1.Qtde_Lote
          ,R1.Dt_Fabr
          ,R1.Dt_Valid
          ,R1.Cod_Agreg);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnf_Rastreab - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                         ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnf_Rastreab_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnf_Rastreab_p;

  ---
  -----------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnf_Dec_Impor ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnf_Dec_Impor_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                                     ,p_Customer_Trx_Line_Id Number
                                     ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select Substr(Rctl.Attribute5, 1, 12) Nro_Di
            ,Fnd_Date.Canonical_To_Date(Rctl.Attribute6) Dt_Di
            ,Substr(Rctl.Attribute7, 1, 60) Local_Desemb
            ,Rctl.Attribute8 Uf_Desemb
            ,Fnd_Date.Canonical_To_Date(Rctl.Attribute9) Dt_Desemb
            ,p_Rvcinf.Cod_Part Cod_Part_Export
            ,Rctl.Attribute4 Dm_Cod_Doc_Imp
            ,Rctl.Customer_Trx_Id Customer_Trx_Id
            ,Rctl.Customer_Trx_Line_Id Customer_Trx_Line_Id
        From Ra_Customer_Trx_Lines_All Rctl
       Where 1 = 1
         And Rctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctl.Line_Type = 'LINE'
         And Upper(Rctl.Attribute_Category) = 'CSF - NF-E DE IMPORTAÇÃO';
    R1 C1%Rowtype;
    --
    l_Rvcidi Vw_Csf_Itemnf_Dec_Impor%Rowtype;
    --
  Begin
    --
    If p_Rvcinf.Cfop Like '3%'
    Then
      --
      Open C1;
      Loop
        Fetch C1
          Into R1;
        Exit When C1%Notfound;
        ---
        l_Rvcidi.Cpf_Cnpj_Emit   := p_Rvcinf.Cpf_Cnpj_Emit;
        l_Rvcidi.Dm_Ind_Emit     := p_Rvcinf.Dm_Ind_Emit;
        l_Rvcidi.Dm_Ind_Oper     := p_Rvcinf.Dm_Ind_Oper;
        l_Rvcidi.Cod_Part        := p_Rvcinf.Cod_Part;
        l_Rvcidi.Cod_Mod         := p_Rvcinf.Cod_Mod;
        l_Rvcidi.Serie           := p_Rvcinf.Serie;
        l_Rvcidi.Nro_Nf          := p_Rvcinf.Nro_Nf;
        l_Rvcidi.Nro_Item        := p_Rvcinf.Nro_Item;
        l_Rvcidi.Nro_Di          := R1.Nro_Di;
        l_Rvcidi.Dt_Di           := R1.Dt_Di;
        l_Rvcidi.Local_Desemb    := R1.Local_Desemb;
        l_Rvcidi.Uf_Desemb       := R1.Uf_Desemb;
        l_Rvcidi.Cod_Part_Export := R1.Cod_Part_Export;
        l_Rvcidi.Dm_Cod_Doc_Imp  := R1.Dm_Cod_Doc_Imp;
        --
        Begin
          Insert Into Vw_Csf_Itemnf_Dec_Impor
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Nro_Item
            ,Nro_Di
            ,Dt_Di
            ,Local_Desemb
            ,Uf_Desemb
            ,Dt_Desemb
            ,Cod_Part_Export
            ,Dm_Cod_Doc_Imp)
          Values
            (p_Rvcinf.Cpf_Cnpj_Emit
            ,p_Rvcinf.Dm_Ind_Emit
            ,p_Rvcinf.Dm_Ind_Oper
            ,p_Rvcinf.Cod_Part
            ,p_Rvcinf.Cod_Mod
            ,p_Rvcinf.Serie
            ,p_Rvcinf.Nro_Nf
            ,p_Rvcinf.Nro_Item
            ,R1.Nro_Di
            ,R1.Dt_Di
            ,R1.Local_Desemb
            ,R1.Uf_Desemb
            ,R1.Dt_Desemb
            ,p_Rvcinf.Cod_Part
            ,R1.Dm_Cod_Doc_Imp);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnf_Dec_Impor_Ff_p(p_Rvcidi => l_Rvcidi, p_Customer_Trx_Line_Id => R1.Customer_Trx_Line_Id, p_Customer_Trx_Id => R1.Customer_Trx_Id, p_Rotina => p_Rotina);
          --
          Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnfdi_Adic_p(p_Rvcidi => l_Rvcidi, p_Customer_Trx_Line_Id => R1.Customer_Trx_Line_Id, p_Rotina => p_Rotina);
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Itemnf_Dec_Impor_P - ' ||
                           'Cpf_Cnpj_Emit: ' || p_Rvcinf.Cpf_Cnpj_Emit ||
                           ', Dm_Ind_Emit: ' || p_Rvcinf.Dm_Ind_Emit ||
                           ', Cod_Mod: ' || p_Rvcinf.Cod_Mod || ', Serie: ' ||
                           p_Rvcinf.Serie || ', Nro_Nf: ' || p_Rvcinf.Nro_Nf ||
                           ', Nro_Item: ' || p_Rvcinf.Nro_Item || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
          --
        End;
        ---
      End Loop;
      Close C1;
      --
    End If;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnf_Dec_Impor_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnf_Dec_Impor_p;

  ---
  --------------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnf_Dec_Impor_Ff ---
  --------------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnf_Dec_Impor_Ff_p(p_Rvcidi               Vw_Csf_Itemnf_Dec_Impor%Rowtype
                                        ,p_Customer_Trx_Line_Id Number
                                        ,p_Customer_Trx_Id      Number
                                        ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select 'DM_TP_VIA_TRANSP' Atributo
            ,To_Char(Jbctle.Int_Ship_Method) Valor
        From Jl_Br_Cust_Trx_Lines_Exts Jbctle
       Where 1 = 1
         And Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
         And Jbctle.Int_Ship_Method Is Not Null
      Union
      Select 'VAFRMM' Atributo
            ,To_Char(Jbctle.Addit_Freight_Amt * 100) Valor
        From Jl_Br_Cust_Trx_Lines_Exts Jbctle
       Where 1 = 1
         And Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
         And Jbctle.Addit_Freight_Amt Is Not Null
      Union
      Select 'DM_TP_INTERMEDIO' Atributo
            ,To_Char(Jbctle.Import_Mode) Valor
        From Jl_Br_Cust_Trx_Lines_Exts Jbctle
       Where 1 = 1
         And Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
         And Jbctle.Import_Mode Is Not Null
      Union
      Select 'CNPJ' Atributo
            ,To_Char(Jbctle.End_Cons_Cnpj) Valor
        From Jl_Br_Cust_Trx_Lines_Exts Jbctle
       Where 1 = 1
         And Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
         And Jbctle.End_Cons_Cnpj Is Not Null
      Union
      Select 'UF_TERCEIRO' Atributo
            ,To_Char(Jbctle.End_Cons_State_Code) Valor
        From Jl_Br_Cust_Trx_Lines_Exts Jbctle
       Where 1 = 1
         And Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
         And Jbctle.End_Cons_State_Code Is Not Null;
    R1 C1%Rowtype;
  Begin
    --
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Itemnf_Dec_Impor_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Nro_Di
          ,Atributo
          ,Valor)
        Values
          (p_Rvcidi.Cpf_Cnpj_Emit
          ,p_Rvcidi.Dm_Ind_Emit
          ,p_Rvcidi.Dm_Ind_Oper
          ,p_Rvcidi.Cod_Part
          ,p_Rvcidi.Cod_Mod
          ,p_Rvcidi.Serie
          ,p_Rvcidi.Nro_Nf
          ,p_Rvcidi.Nro_Item
          ,p_Rvcidi.Nro_Di
          ,R1.Atributo
          ,R1.Valor);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnf_Dec_Impor_Ff_P - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcidi.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcidi.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcidi.Cod_Mod || ', Serie: ' ||
                         p_Rvcidi.Serie || ', Nro_Nf: ' || p_Rvcidi.Nro_Nf ||
                         ', Nro_Item: ' || p_Rvcidi.Nro_Item || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnf_Dec_Impor_Ff_P - ' || ' Erro: ' ||
                     Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnf_Dec_Impor_Ff_p;

  ---
  --------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnfdi_Adic ---
  --------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnfdi_Adic_p(p_Rvcidi               Vw_Csf_Itemnf_Dec_Impor%Rowtype
                                  ,p_Customer_Trx_Line_Id Number
                                  ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
    /*Subir Flexfields desenvolvidos para atender essas informações para o Compliance*/
      Select Fnd_Number.Canonical_To_Number(Rctl.Attribute10) Nro_Adicao
            ,Fnd_Number.Canonical_To_Number(Rctl.Attribute11) Nro_Seq_Adic
             /*,(Select Mm.Manufacturer_Name
              From Apps.Mtl_Manufacturers    Mm
                  ,Apps.Mtl_Mfg_Part_Numbers Mmpn
             Where 1 = 1
               And Mm.Manufacturer_Id = Mmpn.Manufacturer_Id
               And Mmpn.Inventory_Item_Id = Rctl.Inventory_Item_Id
               And Mmpn.Organization_Id = Rctl.Org_Id) Cod_Fabricante*/ -- Analisar campo *Carranza*
            ,Substr(Rctl.Attribute13, 1, 60) Cod_Fabricante
            ,0 Vl_Desc_Di
            ,Rctl.Customer_Trx_Id Customer_Trx_Id
            ,Rctl.Customer_Trx_Line_Id Customer_Trx_Line_Id
        From Ra_Customer_Trx_Lines_All Rctl
       Where 1 = 1
         And Rctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctl.Line_Type = 'LINE'
         And Upper(Rctl.Attribute_Category) = 'CSF - NF-E DE IMPORTAÇÃO';
    R1 C1%Rowtype;
    --
    l_Rvcia Vw_Csf_Itemnfdi_Adic%Rowtype;
    --
  Begin
    --
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      l_Rvcia.Cpf_Cnpj_Emit  := p_Rvcidi.Cpf_Cnpj_Emit;
      l_Rvcia.Dm_Ind_Emit    := p_Rvcidi.Dm_Ind_Emit;
      l_Rvcia.Dm_Ind_Oper    := p_Rvcidi.Dm_Ind_Oper;
      l_Rvcia.Cod_Part       := p_Rvcidi.Cod_Part;
      l_Rvcia.Cod_Mod        := p_Rvcidi.Cod_Mod;
      l_Rvcia.Serie          := p_Rvcidi.Serie;
      l_Rvcia.Nro_Nf         := p_Rvcidi.Nro_Nf;
      l_Rvcia.Nro_Item       := p_Rvcidi.Nro_Item;
      l_Rvcia.Nro_Di         := p_Rvcidi.Nro_Di;
      l_Rvcia.Nro_Adicao     := R1.Nro_Adicao;
      l_Rvcia.Nro_Seq_Adic   := R1.Nro_Seq_Adic;
      l_Rvcia.Cod_Fabricante := R1.Cod_Fabricante;
      l_Rvcia.Vl_Desc_Di     := R1.Vl_Desc_Di;
      --
      Begin
        Insert Into Vw_Csf_Itemnfdi_Adic
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Nro_Di
          ,Nro_Adicao
          ,Nro_Seq_Adic
          ,Cod_Fabricante
          ,Vl_Desc_Di)
        Values
          (p_Rvcidi.Cpf_Cnpj_Emit
          ,p_Rvcidi.Dm_Ind_Emit
          ,p_Rvcidi.Dm_Ind_Oper
          ,p_Rvcidi.Cod_Part
          ,p_Rvcidi.Cod_Mod
          ,p_Rvcidi.Serie
          ,p_Rvcidi.Nro_Nf
          ,p_Rvcidi.Nro_Item
          ,p_Rvcidi.Nro_Di
          ,R1.Nro_Adicao
          ,R1.Nro_Seq_Adic
          ,R1.Cod_Fabricante
          ,R1.Vl_Desc_Di);
        --
        Xxisv_Csf_Nfe_Pkg.Vw_Csf_Itemnfdi_Adic_Ff_p(p_Rvcia => l_Rvcia, p_Customer_Trx_Line_Id => R1.Customer_Trx_Line_Id, p_Customer_Trx_Id => R1.Customer_Trx_Id, p_Rotina => p_Rotina);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnfdi_Adic_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcidi.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcidi.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcidi.Cod_Mod || ', Serie: ' || p_Rvcidi.Serie ||
                         ', Nro_Nf: ' || p_Rvcidi.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcidi.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnfdi_Adic_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnfdi_Adic_p;

  ---
  -----------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnfdi_Adic_Ff ---
  -----------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnfdi_Adic_Ff_p(p_Rvcia                Vw_Csf_Itemnfdi_Adic%Rowtype
                                     ,p_Customer_Trx_Line_Id Number
                                     ,p_Customer_Trx_Id      Number
                                     ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select 'NUM_ACDRAW' Atributo
            ,To_Char(Jbctle.Import_Drawback_Number) Valor
        From Jl_Br_Cust_Trx_Lines_Exts Jbctle
       Where 1 = 1
         And Jbctle.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Jbctle.Customer_Trx_Id = p_Customer_Trx_Id
         And Jbctle.Import_Drawback_Number Is Not Null;
    R1 C1%Rowtype;
    --
  Begin
    --
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Itemnfdi_Adic_Ff
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Nro_Di
          ,Nro_Adicao
          ,Atributo
          ,Valor)
        Values
          (p_Rvcia.Cpf_Cnpj_Emit
          ,p_Rvcia.Dm_Ind_Emit
          ,p_Rvcia.Dm_Ind_Oper
          ,p_Rvcia.Cod_Part
          ,p_Rvcia.Cod_Mod
          ,p_Rvcia.Serie
          ,p_Rvcia.Nro_Nf
          ,p_Rvcia.Nro_Item
          ,p_Rvcia.Nro_Di
          ,p_Rvcia.Nro_Adicao
          ,R1.Atributo
          ,R1.Valor);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnfdi_Adic_Ff_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcia.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcia.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcia.Cod_Mod || ', Serie: ' || p_Rvcia.Serie ||
                         ', Nro_Nf: ' || p_Rvcia.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcia.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnfdi_Adic_Ff_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnfdi_Adic_Ff_p;

  ---
  --------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnf_Export ---
  --------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnf_Export_p(p_Rvcinf               Vw_Csf_Item_Nota_Fiscal%Rowtype
                                  ,p_Customer_Trx_Line_Id Number
                                  ,p_Customer_Trx_Id      Number
                                  ,p_Rotina               Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select Jbctl.Export_Drawback_Number Num_Acdraw
            ,Jbctl.Export_Registr_Number  Num_Reg_Export
            ,Jbctl.Export_Nfe_Access_Key  Chv_Nfe_Export
            ,p_Rvcinf.Qtde_Comerc         Qtde_Export
        From Jl_Br_Cust_Trx_Lines_Exts Jbctl
       Where 1 = 1
         And Jbctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Jbctl.Customer_Trx_Id = p_Customer_Trx_Id
         And Jbctl.Export_Drawback_Number Is Not Null;
    R1 C1%Rowtype;
  Begin
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Itemnf_Export
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Num_Acdraw
          ,Num_Reg_Export
          ,Chv_Nfe_Export
          ,Qtde_Export)
        Values
          (p_Rvcinf.Cpf_Cnpj_Emit
          ,p_Rvcinf.Dm_Ind_Emit
          ,p_Rvcinf.Dm_Ind_Oper
          ,p_Rvcinf.Cod_Part
          ,p_Rvcinf.Cod_Mod
          ,p_Rvcinf.Serie
          ,p_Rvcinf.Nro_Nf
          ,p_Rvcinf.Nro_Item
          ,R1.Num_Acdraw
          ,R1.Num_Reg_Export
          ,R1.Chv_Nfe_Export
          ,R1.Qtde_Export);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnf_Export_P - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcinf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcinf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcinf.Cod_Mod || ', Serie: ' || p_Rvcinf.Serie ||
                         ', Nro_Nf: ' || p_Rvcinf.Nro_Nf || ', Nro_Item: ' ||
                         p_Rvcinf.Nro_Item || ', Erro: ' || Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnf_Export_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnf_Export_p;

  ---
  -------------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Itemnfe_Compl_Serv ---
  -------------------------------------------------------------------------------
  Procedure Vw_Csf_Itemnfe_Compl_Serv_p(p_Rvcinf            Vw_Csf_Item_Nota_Fiscal%Rowtype
                                       ,p_Inventory_Item_Id Number
                                       ,p_Warehouse_Id      Number
                                       ,p_Rotina            Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C1 Is
      Select Null                   Vl_Deducao
            ,Null                   Vl_Outra_Ret
            ,Null                   Vl_Desc_Incondicionado
            ,Null                   Vl_Desc_Condicionado
            ,Msi.Global_Attribute11 Cod_Trib_Municipio
            ,Null                   Cod_Siscomex
            ,Null                   Nro_Proc
            ,2                      Dm_Ind_Incentivo
            ,Null                   Cod_Mun
        From Mtl_System_Items Msi
       Where 1 = 1
         And Msi.Inventory_Item_Id = p_Inventory_Item_Id
         And Msi.Organization_Id = p_Warehouse_Id
         And (p_Rvcinf.Cfop = '5933' Or p_Rvcinf.Cfop = '6933');
    R1 C1%Rowtype;
  Begin
    Open C1;
    Loop
      Fetch C1
        Into R1;
      Exit When C1%Notfound;
      ---
      Begin
        Insert Into Vw_Csf_Itemnfe_Compl_Serv
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Nro_Item
          ,Vl_Deducao
          ,Vl_Outra_Ret
          ,Vl_Desc_Incondicionado
          ,Vl_Desc_Condicionado
          ,Cod_Trib_Municipio
          ,Cod_Siscomex
          ,Nro_Proc
          ,Dm_Ind_Incentivo
          ,Cod_Mun)
        Values
          (p_Rvcinf.Cpf_Cnpj_Emit
          ,p_Rvcinf.Dm_Ind_Emit
          ,p_Rvcinf.Dm_Ind_Oper
          ,p_Rvcinf.Cod_Part
          ,p_Rvcinf.Cod_Mod
          ,p_Rvcinf.Serie
          ,p_Rvcinf.Nro_Nf
          ,p_Rvcinf.Nro_Item
          ,R1.Vl_Deducao
          ,R1.Vl_Outra_Ret
          ,R1.Vl_Desc_Incondicionado
          ,R1.Vl_Desc_Condicionado
          ,R1.Cod_Trib_Municipio
          ,R1.Cod_Siscomex
          ,R1.Nro_Proc
          ,R1.Dm_Ind_Incentivo
          ,R1.Cod_Mun);
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Itemnfe_Compl_Serv_P - ' ||
                         'Cpf_Cnpj_Emit: ' || p_Rvcinf.Cpf_Cnpj_Emit ||
                         ', Dm_Ind_Emit: ' || p_Rvcinf.Dm_Ind_Emit ||
                         ', Cod_Mod: ' || p_Rvcinf.Cod_Mod || ', Serie: ' ||
                         p_Rvcinf.Serie || ', Nro_Nf: ' || p_Rvcinf.Nro_Nf ||
                         ', Nro_Item: ' || p_Rvcinf.Nro_Item || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
        --
      End;
      ---
    End Loop;
    Close C1;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Itemnfe_Compl_Serv_P - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
    --
  End Vw_Csf_Itemnfe_Compl_Serv_p;

  ---
  --------------------------------------------------------------------------
  --- Procedure utilizada para inclusão de dados na Vw_Csf_Nf_Forma_Pgto ---
  --------------------------------------------------------------------------
  Procedure Vw_Csf_Nf_Forma_Pgto_p(p_Rvcnf           Vw_Csf_Nota_Fiscal%Rowtype
                                  ,p_Customer_Trx_Id Number
                                  ,p_Rotina          Varchar2) Is
    --
    l_Desc_Erro Varchar2(4000);
    --
    Cursor C6 Is
      Select Case
               When Nvl(Sum(Nvl(Apsa.Amount_Due_Original, 0)), 0) > 0
                    And Nvl(Rctt.Global_Attribute5, 'Nulo') Not In ('3', '4') Then
                Nvl(Jbcte.Payment_Method1, '99')
               Else
                '90'
             End Dm_Tp_Pag /*Forma de pagamento: 01=Dinheiro 02=Cheque 03=Cartão de Crédito 04=Cartão de Débito 05=Crédito Loja 10=Vale Alimentação 11=Vale Refeição 12=Vale Presente 13=Vale Combustível 14=Duplicata Mercantil 15=Boleto Bancário 90=Sem pagamento 99=Outros*/
            ,Case
               When Nvl(Sum(Nvl(Apsa.Amount_Due_Original, 0)), 0) > 0
                    And Rctt.Global_Attribute5 Not In ('3', '4') Then
                Xxisv_Csf_Nfe_Pkg.Get_Nfe_Vl_Total_Nf_f(Rcta.Customer_Trx_Id)
               Else
                0
             End Vl_Pgto
            ,Null Cnpj
            ,Null Dm_Tp_Band
            ,Null Nro_Aut
        From Ra_Customer_Trx_All      Rcta
            ,Ra_Cust_Trx_Types_All    Rctt
            ,Ar_Payment_Schedules_All Apsa
            ,Jl_Br_Customer_Trx_Exts  Jbcte
       Where 1 = 1
         And Rcta.Customer_Trx_Id = p_Customer_Trx_Id
         And Rctt.Cust_Trx_Type_Id = Rcta.Cust_Trx_Type_Id
         And Jbcte.Customer_Trx_Id = Rcta.Customer_Trx_Id
         And Jbcte.Customer_Trx_Id = Apsa.Customer_Trx_Id(+)
       Group By Rctt.Global_Attribute5
               ,Jbcte.Payment_Method1
               ,Rcta.Customer_Trx_Id;
    R6 C6%Rowtype;
    --
  Begin
    Open C6;
    Loop
      Fetch C6
        Into R6;
      Exit When C6%Notfound;
      --
      Begin
        Insert Into Vw_Csf_Nf_Forma_Pgto
          (Cpf_Cnpj_Emit
          ,Dm_Ind_Emit
          ,Dm_Ind_Oper
          ,Cod_Part
          ,Cod_Mod
          ,Serie
          ,Nro_Nf
          ,Dm_Tp_Pag
          ,Vl_Pgto
          ,Cnpj
          ,Dm_Tp_Band
          ,Nro_Aut)
        Values
          (p_Rvcnf.Cpf_Cnpj_Emit
          ,p_Rvcnf.Dm_Ind_Emit
          ,p_Rvcnf.Dm_Ind_Oper
          ,p_Rvcnf.Cod_Part
          ,p_Rvcnf.Cod_Mod
          ,p_Rvcnf.Serie
          ,p_Rvcnf.Nro_Nf
          ,R6.Dm_Tp_Pag
          ,R6.Vl_Pgto
          ,R6.Cnpj
          ,R6.Dm_Tp_Band
          ,R6.Nro_Aut);
        --
      Exception
        When Dup_Val_On_Index Then
          Null;
        When Others Then
          --
          g_Retcode   := 1;
          g_Erro      := Nvl(g_Erro, 0) + 1;
          l_Desc_Erro := 'Vw_Csf_Nf_Forma_Pgto_p - ' || 'Cpf_Cnpj_Emit: ' ||
                         p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                         p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                         p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                         ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                         Sqlerrm;
          g_Erro_Msg  := l_Desc_Erro;
          --
          Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
          --
      End;
      --
      If R6.Dm_Tp_Pag = '99'
      Then
        Begin
          Insert Into Vw_Csf_Nf_Forma_Pgto_Ff
            (Cpf_Cnpj_Emit
            ,Dm_Ind_Emit
            ,Dm_Ind_Oper
            ,Cod_Part
            ,Cod_Mod
            ,Serie
            ,Nro_Nf
            ,Dm_Tp_Pag
            ,Vl_Pgto
            ,Cnpj
            ,Dm_Tp_Band
            ,Nro_Aut
            ,Atributo
            ,Valor)
          Values
            (p_Rvcnf.Cpf_Cnpj_Emit
            ,p_Rvcnf.Dm_Ind_Emit
            ,p_Rvcnf.Dm_Ind_Oper
            ,p_Rvcnf.Cod_Part
            ,p_Rvcnf.Cod_Mod
            ,p_Rvcnf.Serie
            ,p_Rvcnf.Nro_Nf
            ,R6.Dm_Tp_Pag
            ,R6.Vl_Pgto
            ,R6.Cnpj
            ,R6.Dm_Tp_Band
            ,R6.Nro_Aut
            ,'DESCR_PAG'
            ,'OUTRO');
          --
        Exception
          When Dup_Val_On_Index Then
            Null;
          When Others Then
            --
            g_Retcode   := 1;
            g_Erro      := Nvl(g_Erro, 0) + 1;
            l_Desc_Erro := 'Vw_Csf_Nf_Forma_Pgto_p - ' || 'Cpf_Cnpj_Emit: ' ||
                           p_Rvcnf.Cpf_Cnpj_Emit || ', Dm_Ind_Emit: ' ||
                           p_Rvcnf.Dm_Ind_Emit || ', Cod_Mod: ' ||
                           p_Rvcnf.Cod_Mod || ', Serie: ' || p_Rvcnf.Serie ||
                           ', Nro_Nf: ' || p_Rvcnf.Nro_Nf || ', Erro: ' ||
                           Sqlerrm;
            g_Erro_Msg  := l_Desc_Erro;
            --
            Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
            --
        End;
      End If;
      --
    End Loop;
    Close C6;
    --
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Vw_Csf_Nf_Forma_Pgto_p - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      --
  End Vw_Csf_Nf_Forma_Pgto_p;

  ---
  ---
  ------------------------------------------------------------------------------------------------------------------------
  -- Atualiza tabela JL_BR_CUSTOMER_TRX_EXTS com o Status de Enviada ao Compliance                                                                           --
  ------------------------------------------------------------------------------------------------------------------------
  Procedure Atualiza_Jl_Br_p(p_Customer_Trx_Id Number) Is
    x_Return_Status Varchar2(10);
    x_Msg_Data      Varchar2(4000);
    --
  Begin
    If g_Erro = 0
    Then
      Jl_Br_Sped_Pub.Update_Attributes(p_Api_Version => 1.0, p_Commit => Apps.Fnd_Api.g_True, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Elect_Inv_Web_Address => Null, p_Elect_Inv_Status => '1', p_Elect_Inv_Access_Key => Null, p_Elect_Inv_Protocol => Null, x_Return_Status => x_Return_Status, x_Msg_Data => x_Msg_Data);
    Else
      Jl_Br_Sped_Pub.Update_Attributes(p_Api_Version => 1.0, p_Commit => Apps.Fnd_Api.g_True, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Elect_Inv_Web_Address => Null, p_Elect_Inv_Status => '3' ---Erro
                                      , p_Elect_Inv_Access_Key => Null, p_Elect_Inv_Protocol => Null, x_Return_Status => x_Return_Status, x_Msg_Data => x_Msg_Data);
      ------------------------------------------------------------------------------------------------------------------------
      -- Insere Log com o Status da NFe                                                                                     --
      -- Insere linha na tabela JL_BR_EILOG                                                                                 --
      ------------------------------------------------------------------------------------------------------------------------
      Jl_Br_Sped_Pub.Insert_Log(p_Api_Version => 1.0, p_Commit => Apps.Fnd_Api.g_True, p_Customer_Trx_Id => p_Customer_Trx_Id, p_Occurrence_Date => Sysdate, p_Elect_Inv_Status => '3', p_Message_Text => g_Erro_Msg, x_Return_Status => x_Return_Status, x_Msg_Data => x_Msg_Data);
    End If;
  End Atualiza_Jl_Br_p;

  --
  --------------------------------------------------------------------------
  ------------ Função para retornar o Warehouse_Id da Transacao ------------
  --------------------------------------------------------------------------
  Function Get_Nfe_Warehouse_Id_f(p_Customer_Trx_Id In Number) Return Number Is
    l_Nid Number;
  Begin
    Begin
      Select Unique Rctla.Warehouse_Id
        Into l_Nid
        From Ra_Customer_Trx_Lines_All Rctla
       Where Rctla.Customer_Trx_Id = p_Customer_Trx_Id
         And Rctla.Line_Type = 'LINE';
    Exception
      When Others Then
        l_Nid := Null;
    End;
    Return l_Nid;
  End Get_Nfe_Warehouse_Id_f;

  ---
  -----------------------------------------------------------------------------
  --------------- Função para retornar o CNPJ do Emitente no RI ---------------
  -----------------------------------------------------------------------------
  Function Get_Nfe_Cpf_Cnpj_Emit_f(p_Location_Id          Number
                                  ,p_Legal_Entity_Id      Number
                                  ,p_Legislative_Category Varchar2)
    Return Varchar2 Is
    p_Return          Varchar2(30);
    l_Document_Number Varchar2(30);
    --
    Cursor C1 Is
      Select Etb.Legal_Entity_Id
            ,Reg.Location_Id
            ,Hrl.Location_Code
            ,Hrl.Inventory_Organization_Id
            ,Reg.Registration_Id
            ,Reg.Registration_Number
            ,Jur.Legislative_Cat_Code Legislative_Category
        From Xle_Etb_Profiles     Etb
            ,Xle_Registrations    Reg
            ,Hr_Locations_All     Hrl
            ,Xle_Jurisdictions_Vl Jur
       Where Etb.Establishment_Id = Reg.Source_Id
         And Reg.Source_Table = 'XLE_ETB_PROFILES'
         And Hrl.Location_Id = Reg.Location_Id
         And Jur.Jurisdiction_Id = Reg.Jurisdiction_Id
         And Reg.Location_Id = p_Location_Id
         And Jur.Legislative_Cat_Code = p_Legislative_Category
         And Etb.Legal_Entity_Id = p_Legal_Entity_Id
         And Sysdate Between Nvl(Etb.Effective_From, Sysdate) And
             Nvl(Etb.Effective_To, Sysdate) --BUG 20470366
      Union --BUG 10231463
      Select Etb.Legal_Entity_Id
            ,Reg.Location_Id
            ,Hrl.Location_Code
            ,Hrl.Inventory_Organization_Id
            ,Reg.Registration_Id
            ,Reg.Registration_Number
            ,Jur.Legislative_Cat_Code Legislative_Category
        From Xle_Etb_Profiles     Etb
            ,Xle_Registrations    Reg
            ,Hr_Locations_All     Hrl
            ,Xle_Jurisdictions_Vl Jur
       Where Etb.Legal_Entity_Id = Reg.Source_Id
         And Reg.Source_Table = 'XLE_ENTITY_PROFILES'
         And Hrl.Location_Id = Reg.Location_Id
         And Jur.Jurisdiction_Id = Reg.Jurisdiction_Id
         And Reg.Location_Id = p_Location_Id
         And Jur.Legislative_Cat_Code = p_Legislative_Category
         And Etb.Legal_Entity_Id = p_Legal_Entity_Id
         And Sysdate Between Nvl(Etb.Effective_From, Sysdate) And
             Nvl(Etb.Effective_To, Sysdate); --BUG 20470366
    /*    UNION --BUG 12976691
    ------------------------------------------------------------------
    -- BUG 12540048
    -- Incluir na query os locais do modulo Oracle RI
    -- Patch de migracao R11i para R12 do Legal Entity nao permite
    -- associar locations antigos para locais legais
    ------------------------------------------------------------------
    SELECT NULL legal_entity_id,
           cffe.location_id,
           NULL location_code,
           cffe.organization_id inventory_organization_id,
           NULL registration_id,
           cffe.document_number registration_number,
           'FEDERAL_TAX' legislative_category
       FROM cll_f189_fiscal_entities_all cffe
      WHERE cffe.location_id = p_location_id
        AND entity_type_lookup_code = 'LOCATION'
        AND cffe.document_type = 'CNPJ';*/
  Begin
    For R1 In C1
    Loop
      If R1.Legislative_Category In
         ('FEDERAL_TAX', 'INCOME_TAX', 'COMPANY_LAW')
      Then
        p_Return := R1.Registration_Number;
      End If;
    End Loop;
    If p_Return Is Null
    Then
      --
      -- ER 16865331 - CLLUBEUB: CNPJ NUMBER SHARED BETWEEN ORGANIZATIONS
      --
      Begin
        --
        Select Xr.Registration_Number
          Into p_Return
          From Xle_Etb_Profiles            Etb
              ,Apps.Xle_Associations       Assoc
              ,Apps.Xle_Association_Types  Xat
              ,Apps.Xle_Assoc_Object_Types Xaot
              ,Xle_Registrations           Xr
              ,Xle_Jurisdictions_b         Xjb
              ,Hr_Locations_All            Hla
         Where Hla.Location_Id = p_Location_Id
           And Etb.Legal_Entity_Id = p_Legal_Entity_Id
           And Xjb.Legislative_Cat_Code = p_Legislative_Category
           And Xaot.Name = 'INVENTORY_ORGANIZATION'
           And Xr.Source_Table = 'XLE_ETB_PROFILES'
           And Etb.Establishment_Id = Xr.Source_Id
           And Assoc.Subject_Id = Etb.Establishment_Id
           And Assoc.Association_Type_Id = Xat.Association_Type_Id
           And Assoc.Object_Id = Hla.Inventory_Organization_Id
           And ((Assoc.Effective_From <= Sysdate) Or
               (Assoc.Effective_From Is Null))
           And ((Assoc.Effective_To >= Sysdate) Or
               (Assoc.Effective_To Is Null))
           And Xat.Object_Type_Id = Xaot.Object_Type_Id
           And Xr.Jurisdiction_Id = Xjb.Jurisdiction_Id;
      Exception
        When Others Then
          p_Return := Null;
          --
      End;
      --
      Return Regexp_Replace(p_Return, '[^0-9]');
      --
    Else
      Return Regexp_Replace(p_Return, '[^0-9]');
    End If;
  Exception
    When Others Then
      Return Null;
  End Get_Nfe_Cpf_Cnpj_Emit_f;

  ---
  -----------------------------------------------------------------------------
  --------------- Função para retornar o COD_PART do RI -----------------------
  -----------------------------------------------------------------------------
  Function Get_Nfe_Cod_Part_f(p_Site_Use_Id In Number) Return Varchar2 Is
    Cursor Ccc(Pp_Site_Use_Id Number) Is
      Select 'C' Party_Type
            ,Hcas.Global_Attribute2 Doc_Type
            ,Hcas.Global_Attribute3 Doc_Num
            ,Hcas.Global_Attribute4 Doc_Filial
            ,Hcas.Global_Attribute5 Doc_Dv
            ,Hcas.Cust_Account_Id Id
            ,Hcas.Party_Site_Id Site_Id
            ,Hcas.Org_Id Org_Id
        From Hz_Cust_Acct_Sites_All Hcas
            ,Hz_Cust_Accounts       Hca
            ,Hz_Cust_Site_Uses_All  Hcsu
            ,Hz_Party_Sites         Hps
            ,Hz_Locations           Loc
            ,Ar_Customers           Ac
       Where Ac.Customer_Id = Hcas.Cust_Account_Id
         And Hcas.Cust_Acct_Site_Id = Hcsu.Cust_Acct_Site_Id
         And Hca.Cust_Account_Id = Hcas.Cust_Account_Id
         And Hcas.Party_Site_Id = Hps.Party_Site_Id
         And Hps.Location_Id = Loc.Location_Id
         And Hcsu.Site_Use_Id = Pp_Site_Use_Id
         And Hcsu.Site_Use_Code = 'BILL_TO';
    Rrr        Ccc%Rowtype;
    v_Cod_Part Varchar2(255);
  Begin
    Open Ccc(p_Site_Use_Id);
    Loop
      Fetch Ccc
        Into Rrr;
      Exit When Ccc%Notfound;
      ---
      /*If Rrr.Doc_Type = '1'
      Then
        v_Cod_Part := Rrr.Party_Type || '.' ||
                      Substr(Lpad(Trim(Rrr.Doc_Num), 9, '0'), 1, 9) ||
                      Substr(Lpad(Trim(Rrr.Doc_Dv), 2, '0'), 1, 2) || '.' ||
                      Rrr.Id || '.' || Rrr.Site_Id || '.' || Rrr.Org_Id;
      Elsif Rrr.Doc_Type = '2'
      Then
        v_Cod_Part := Rrr.Party_Type || '.' ||
                      Substr(Lpad(Trim(Rrr.Doc_Num), 9, '0'), 2, 8) ||
                      Substr(Lpad(Trim(Rrr.Doc_Filial), 4, '0'), 1, 4) ||
                      Substr(Lpad(Trim(Rrr.Doc_Dv), 2, '0'), 1, 2) || '.' ||
                      Rrr.Id || '.' || Rrr.Site_Id || '.' || Rrr.Org_Id;
      Else
        v_Cod_Part := Rrr.Party_Type || '.' || Trim(Rrr.Doc_Num) ||
                      Trim(Rrr.Doc_Filial) || Trim(Rrr.Doc_Dv) || '.' ||
                      Rrr.Id || '.' || Rrr.Site_Id || '.' || Rrr.Org_Id;
      End If;*/ -- Carranza 24/10/2022
      ---
      v_Cod_Part := Xxisv_Csf_Cadastros_Pkg.Get_Cod_Part_f(p_Type => Rrr.Party_Type, p_Id => Rrr.Id, p_Site_Id => Rrr.Site_Id, p_Org_Id => Rrr.Org_Id); -- Carranza 24/10/2022
      ---
    End Loop;
    Close Ccc;
    Return Substr((v_Cod_Part), 1, 60);
  End Get_Nfe_Cod_Part_f;

  ---
  -------------------------------------------------------------------------------
  --------------- Função para retornar o Cidade IBGE Emit -----------------------
  -------------------------------------------------------------------------------
  Function Get_Nfe_Cidade_Ibge_Emit_f(p_Organization_Id In Number)
    Return Varchar2 Is
    l_Vcidade Varchar2(150);
  Begin
    Begin
      Select b.Etb_Information1
        Into l_Vcidade
        From Cll_F255_Establishment_v a
            ,Xle_Etb_Profiles         b
            ,Xle_Registrations        c
       Where 1 = 1
         And a.Inventory_Organization_Id = p_Organization_Id
         And a.Establishment_Id = b.Establishment_Id
         And a.Registration_Number = c.Registration_Number
         And a.Location_Id = c.Location_Id
         And c.Source_Id = b.Establishment_Id
         And c.Source_Table = 'XLE_ETB_PROFILES'
         And Nvl(c.Effective_To, Sysdate) >= Sysdate;
    Exception
      When Others Then
        l_Vcidade := '999999';
    End;
    Return l_Vcidade;
  End Get_Nfe_Cidade_Ibge_Emit_f;

  ---
  -------------------------------------------------------------------------
  --------------- Função para retornar UF IBGE Emit -----------------------
  -------------------------------------------------------------------------
  Function Get_Nfe_Uf_Ibge_Emit_f(p_Organization_Id In Number) Return Varchar2 Is
    l_Vuf Varchar2(150);
  Begin
    Begin
      Select Substr(b.Etb_Information1, 1, 2)
        Into l_Vuf
        From Cll_F255_Establishment_v a
            ,Xle_Etb_Profiles         b
            ,Xle_Registrations        c
       Where 1 = 1
         And a.Inventory_Organization_Id = p_Organization_Id
         And a.Establishment_Id = b.Establishment_Id
         And a.Registration_Number = c.Registration_Number
         And a.Location_Id = c.Location_Id
         And c.Source_Id = b.Establishment_Id
         And c.Source_Table = 'XLE_ETB_PROFILES'
         And Nvl(c.Effective_To, Sysdate) >= Sysdate;
    Exception
      When Others Then
        l_Vuf := 0;
    End;
    Return l_Vuf;
  End Get_Nfe_Uf_Ibge_Emit_f;

  ---
  ----------------------------------------------------------------------------
  --------------- Função para retornar o Cod pais IBGE -----------------------
  ----------------------------------------------------------------------------
  Function Get_Nfe_Cod_Pais_Ibge_f(p_Country In Varchar2) Return Varchar2 Is
    l_Cod Varchar2(30);
    Cursor C100 Is
      Select Substr(b.Identifier_Value, 1, 4) Cod
        From Hz_Geographies           a
            ,Hz_Geography_Identifiers b
       Where 1 = 1
         And a.Geography_Id = b.Geography_Id
         And a.Geography_Code = p_Country
         And a.Geography_Type = 'COUNTRY'
         And b.Identifier_Subtype = 'IBGE';
    R100 C100%Rowtype;
  Begin
    Open C100;
    Loop
      Fetch C100
        Into R100;
      Exit When C100%Notfound;
      l_Cod := R100.Cod;
    End Loop;
    Close C100;
    If l_Cod Is Null
       And p_Country = 'BR'
    Then
      Return '1058';
    Elsif l_Cod Is Null
          And p_Country != 'BR'
    Then
      Return '0000';
    Else
      Return l_Cod;
    End If;
  End Get_Nfe_Cod_Pais_Ibge_f;

  ---
  ---------------------------------------------------------------------------
  --------------- Função para retornar o nome do pais -----------------------
  ---------------------------------------------------------------------------
  Function Get_Nfe_Nome_Pais_f(p_Country In Varchar2) Return Varchar2 Is
    l_Nome Varchar2(150);
  Begin
    Begin
      Select Upper(a.Geography_Name)
        Into l_Nome
        From Hz_Geographies a
       Where 1 = 1
         And a.Geography_Code = p_Country
         And a.Geography_Type = 'COUNTRY';
    Exception
      When Others Then
        l_Nome := Null;
    End;
    If l_Nome Is Null
       And p_Country = 'BR'
    Then
      Return 'BRASIL';
    Elsif l_Nome Is Null
          And p_Country != 'BR'
    Then
      Return 'PAIS';
    Else
      Return l_Nome;
    End If;
  End Get_Nfe_Nome_Pais_f;

  ---
  --------------------------------------------------------------------------------------------
  --------------- Função para retornar cod cidade IBGE do destinatario -----------------------
  --------------------------------------------------------------------------------------------
  Function Get_Nfe_Cidade_Ibge_Dest_f(p_City  In Varchar2
                                     ,p_State In Varchar2) Return Varchar2 Is
    l_Vcidade Varchar2(30);
  Begin
    Begin
      Select Distinct c.Identifier_Value
        Into l_Vcidade
        From Hz_Geographies           b
            ,Hz_Geography_Identifiers c
       Where 1 = 1
         And p_City = b.Geography_Name
         And p_State = b.Geography_Element2
         And b.Geography_Id = c.Geography_Id
         And c.Identifier_Subtype = 'IBGE';
    Exception
      When Others Then
        l_Vcidade := '999999';
    End;
    Return l_Vcidade;
  End Get_Nfe_Cidade_Ibge_Dest_f;

  ---
  ----------------------------------------------------------------------
  --------------- Função para retornar MSG LEGAL -----------------------
  ----------------------------------------------------------------------
  Function Get_Nfe_Msg_Legal(p_Customer_Trx_Id In Number) Return Varchar2 As
    v_Msg       Varchar2(4000);
    l_Desc_Erro Varchar2(4000);
  Begin
    --
    For Cur_Msg In (Select Distinct Legal_Justification_Text2 Msg_Legal
                      From Zx_Lines_v
                     Where Trx_Id = p_Customer_Trx_Id
                       And Legal_Justification_Text2 Is Not Null
                    --
                    Union
                    --
                    Select Distinct Legal_Justification_Text1 Msg_Legal
                      From Zx_Lines_v
                     Where Trx_Id = p_Customer_Trx_Id
                       And Legal_Justification_Text1 Is Not Null)
    Loop
      If v_Msg Is Not Null
      Then
        v_Msg := v_Msg || '\n' || Cur_Msg.Msg_Legal;
      Else
        v_Msg := Cur_Msg.Msg_Legal;
      End If;
    End Loop;
    Return Nvl(v_Msg, ' ');
  Exception
    When Others Then
      --
      g_Retcode   := 1;
      g_Erro      := Nvl(g_Erro, 0) + 1;
      l_Desc_Erro := 'Get_Nfe_MSG_LEGAL - ' || ' Erro: ' || Sqlerrm;
      g_Erro_Msg  := l_Desc_Erro;
      --
      Fnd_File.Put_Line(Fnd_File.Log, l_Desc_Erro);
      Return ' ';
      --
  End Get_Nfe_Msg_Legal;

  ---
  ----------------------------------------------------------------------------------------
  --------------- Procedure para retornar Conteudo da NFInfor Adic -----------------------
  ----------------------------------------------------------------------------------------
  Procedure Get_Nfe_Nfinfor_Adic_p(p_Customer_Trx_Id          In Number
                                  ,p_Comments                 In Varchar2
                                  ,p_Legal_Process_Source_Ind In Varchar2
                                  ,p_Conteudo                 Out Varchar2) Is
    --
    l_Conteudo Varchar2(4000);
    --
    l_Cont_1 Varchar2(4000);
    l_Cont_2 Varchar2(4000);
    l_Cont_3 Varchar2(4000);
    l_Cont_4 Varchar2(4000);
    l_Cont_5 Varchar2(4000);
    --
    Cursor c_Msg1 Is
      Select Unique Trim(Rctla.Global_Attribute8) Message_1
        From Ra_Customer_Trx_Lines_All Rctla
       Where Rctla.Customer_Trx_Id = p_Customer_Trx_Id
         And Rctla.Global_Attribute8 Is Not Null;
    --
    Cursor c_Msg2 Is
      Select Unique Trim(Rctla.Global_Attribute9) Message_2
        From Ra_Customer_Trx_Lines_All Rctla
       Where Rctla.Customer_Trx_Id = p_Customer_Trx_Id
         And Rctla.Global_Attribute9 Is Not Null;
    --
    Cursor c_Msg3 Is
      Select Unique Trim(Rctla.Global_Attribute10) Message_3
        From Ra_Customer_Trx_Lines_All Rctla
       Where Rctla.Customer_Trx_Id = p_Customer_Trx_Id
         And Rctla.Global_Attribute10 Is Not Null;
    --
    r_Msg1 Varchar2(200);
    r_Msg2 Varchar2(200);
    r_Msg3 Varchar2(200);
    --
  Begin
    --
    l_Cont_1 := Trim(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Msg_Legal(p_Customer_Trx_Id));
    --
    Open c_Msg1;
    Loop
      Fetch c_Msg1
        Into r_Msg1;
      Exit When c_Msg1%Notfound;
      If l_Cont_2 Is Null
      Then
        l_Cont_2 := r_Msg1;
      Else
        l_Cont_2 := l_Cont_2 || '\n' || r_Msg1;
      End If;
    End Loop;
    Close c_Msg1;
    --
    Open c_Msg2;
    Loop
      Fetch c_Msg2
        Into r_Msg2;
      Exit When c_Msg2%Notfound;
      If l_Cont_3 Is Null
      Then
        l_Cont_3 := r_Msg2;
      Else
        l_Cont_3 := l_Cont_3 || '\n' || r_Msg2;
      End If;
    End Loop;
    Close c_Msg2;
    --
    Open c_Msg3;
    Loop
      Fetch c_Msg3
        Into r_Msg3;
      Exit When c_Msg3%Notfound;
      If l_Cont_4 Is Null
      Then
        l_Cont_4 := r_Msg3;
      Else
        l_Cont_4 := l_Cont_4 || '\n' || r_Msg3;
      End If;
    End Loop;
    Close c_Msg3;
    --
    l_Cont_5 := p_Comments;
    --
    Begin
      Select l_Cont_1 || Decode(Nvl(l_Cont_1, '#'), '#', Null, '\n') ||
              l_Cont_2 || Decode(Nvl(l_Cont_2, '#'), '#', Null, '\n') ||
              l_Cont_3 || Decode(Nvl(l_Cont_3, '#'), '#', Null, '\n') ||
              l_Cont_4 || Decode(Nvl(l_Cont_4, '#'), '#', Null, '\n') ||
             /*l_Cont_5*/ -- Carranza 16/07/2020
              Replace(Trim(l_Cont_5), Chr(10), ' ') -- Carranza 16/07/2020
        Into p_Conteudo
        From Dual;
    End;
    --
  End Get_Nfe_Nfinfor_Adic_p;

  ---
  ------------------------------------------------------------------------------------
  --------------- Funcao para retornar Site_Use_Id do Cod_Part -----------------------
  ------------------------------------------------------------------------------------
  Function Get_Nfe_Site_Use_Id_f(p_Cod_Part In Varchar2) Return Number Is
    --
    l_Pos1 Number;
    l_Pos2 Number;
    l_Pos3 Number;
    l_Pos4 Number;
    --
    l_Campo1 Varchar2(100);
    l_Campo2 Varchar2(100);
    l_Campo3 Varchar2(100);
    l_Campo4 Varchar2(100);
    l_Campo5 Varchar2(100);
    --
    l_Site_Use_Id Number;
    --
  Begin
    ---
    Begin
      Select Instr(p_Cod_Part, '.', 1, 1)
            ,Instr(p_Cod_Part, '.', 1, 2)
            ,Instr(p_Cod_Part, '.', 1, 3)
            ,Instr(p_Cod_Part, '.', 1, 4)
        Into l_Pos1
            ,l_Pos2
            ,l_Pos3
            ,l_Pos4
        From Dual;
    End;
    ---
    Begin
      Select Substr(p_Cod_Part, 1, (l_Pos1 - 1))
            ,Substr(p_Cod_Part, (l_Pos1 + 1), (l_Pos2 - l_Pos1 - 1))
            ,Substr(p_Cod_Part, (l_Pos2 + 1), (l_Pos3 - l_Pos2 - 1))
            ,Substr(p_Cod_Part, (l_Pos3 + 1), (l_Pos4 - l_Pos3 - 1))
            ,Substr(p_Cod_Part, (l_Pos4 + 1))
        Into l_Campo1
            ,l_Campo2
            ,l_Campo3
            ,l_Campo4
            ,l_Campo5
        From Dual;
    End;
    ---
    Begin
      Select Hcsu.Site_Use_Id
        Into l_Site_Use_Id
        From Hz_Cust_Acct_Sites_All Hcas
            ,Hz_Cust_Accounts       Hca
            ,Hz_Cust_Site_Uses_All  Hcsu
            ,Hz_Party_Sites         Hps
            ,Hz_Locations           Loc
            ,Ar_Customers           Ac
       Where Ac.Customer_Id = Hcas.Cust_Account_Id
         And Hcas.Cust_Acct_Site_Id = Hcsu.Cust_Acct_Site_Id
         And Hca.Cust_Account_Id = Hcas.Cust_Account_Id
         And Hcas.Party_Site_Id = Hps.Party_Site_Id
         And Hps.Location_Id = Loc.Location_Id
         And Hcsu.Site_Use_Code = 'BILL_TO'
         And ((Hcas.Global_Attribute3 || Hcas.Global_Attribute4 ||
             Hcas.Global_Attribute5 = Lpad(l_Campo2, 15, '0')) Or
             (Hcas.Global_Attribute3 || Hcas.Global_Attribute5 =
             Lpad(l_Campo2, 11, '0')))
         And Hcas.Cust_Account_Id = l_Campo3
         And Hcas.Party_Site_Id = l_Campo4
         And Hcas.Org_Id = l_Campo5;
    Exception
      When Others Then
        l_Site_Use_Id := Null;
    End;
    ---
    Return l_Site_Use_Id;
    ---
  End Get_Nfe_Site_Use_Id_f;

  --
  ------------------------------------------------------------------------------------
  -------------------- Funcao para Limpar Caracteres Especiais -----------------------
  ------------------------------------------------------------------------------------
  Function Get_Nfe_Converte_Char_f(p_Text In Varchar2) Return Varchar2 Is
    --
    l_Text Varchar2(4000);
    --
  Begin
    l_Text := Nvl(Ltrim(Rtrim(Translate(p_Text, '¿ÇçåÅâÂãÃáÁàÀäÄêÊéÉèÈëËîÎíÍìÌïÏôÔÕõóÓòÒöÖûÛúÚùÙüÜÿYýÝñÑÐ¿¿!¿*+=_{}[];|<>?ªº°§¹²³¿¿£¢¬¿`~^¿¢¿¥¿¿¿¿¿¿¿ ¡¿§·º¿¿¿''¿¿¿', '-CcaAaAaAaAaAaAeEeEeEeEiIiIiIiIoOOooOoOoOuUuUuUuUyYyYnND '))), ' ');
    l_Text := Replace(l_Text, Chr(183), '');
    l_Text := Replace(l_Text, '  ', ' ');
    --
    Return l_Text;
    --
  End Get_Nfe_Converte_Char_f;

  --
  ------------------------------------------------------------------------------------
  ------------------- Função para retornar a conta contabil do AR --------------------
  ------------------------------------------------------------------------------------
  --
  Procedure Get_Account_Segment_p Is
  Begin
    Begin
      /*Retornar Segmento referente a Conta Contabil*/
      Select Unique Application_Column_Name
        Into g_Vsegment
        From Apps.Fnd_Segment_Attribute_Values
       Where Application_Id = 101
         And Id_Flex_Code = 'GL#'
         And Id_Flex_Num = (Select Unique Chart_Of_Accounts_Id
                              From Cll_F255_Establishment_v
                             Where Country = 'BR')
         And Segment_Attribute_Type = 'GL_ACCOUNT'
         And Attribute_Value = 'Y';
    Exception
      When Others Then
        g_Vsegment := Null;
    End;
  End Get_Account_Segment_p;

  Function Get_Nfe_Cod_Cta_f(p_Customer_Trx_Line_Id In Number
                            ,p_Org_Id               In Number) Return Varchar2 Is
    l_Vgl_Account Varchar2(30);
    l_Tamanho     Number;
    l_Retorno     Varchar2(30);
  Begin
    If g_Vsegment Is Not Null
    Then
      Begin
        /*Conta Contabil Analitica*/
        Execute Immediate 'Select Unique ' || g_Vsegment ||
                          '  From cll_f255_ar_invoice_items_gl_v rctlgd ' ||
                          '     , Gl_Code_Combinations   Gcc ' ||
                          ' Where rctlgd.customer_trx_line_Id = :1' ||
                          '   And rctlgd.Line_Type = ''ITEM'' ' ||
                          '   And Gcc.Code_Combination_Id = rctlgd.Code_Combination_Id'
          Into l_Vgl_Account
          Using p_Customer_Trx_Line_Id;
      Exception
        When Others Then
          l_Vgl_Account := Null;
      End;
    End If;
    If l_Vgl_Account Is Not Null
    Then
      Begin
        l_Tamanho := Length(l_Vgl_Account);
        Begin
          /*Conta Contabil Sintetica*/
          Select Max(Cfgsvh.Value)
            Into l_Retorno
            From Cll_F255_Gl_Seg_Val_Hierarch_v Cfgsvh
                ,Cll_F255_Establishment_v       Cfe
           Where 1 = 1
             And Cfe.Chart_Of_Accounts_Id = Cfgsvh.Chart_Of_Accounts
             And Cfe.Master_Operating_Unit = p_Org_Id
             And Cfe.Main_Establishment_Flag = 'Y'
             And Cfgsvh.Ledger_Id = Cfe.Ledger_Id
             And l_Vgl_Account Between Cfgsvh.Child_Low And Cfgsvh.Child_High
             And Cfgsvh.Language_Code = 'PTB'
             And Cfgsvh.Application_Column_Name = g_Vsegment
             And Cfgsvh.Enabled_Flag = 'Y'
             And Cfgsvh.End_Date_Active Is Null
             And Upper(Cfgsvh.Value) = Lower(Cfgsvh.Value)
             And Substr(l_Vgl_Account, 1, 1) = Substr(Cfgsvh.Value, 1, 1);
        Exception
          When Others Then
            l_Retorno := Null;
        End;
      End;
    End If;
    Return l_Retorno;
  End Get_Nfe_Cod_Cta_f;

  --
  -----------------------------------------------------------------------------------------
  ------------ Função para retornar o Dm_Cod_Trib_Issqn do Item da Transação --------------
  -----------------------------------------------------------------------------------------
  Function Get_Nfe_Dm_Cod_Trib_Issqn_f(p_Customer_Trx_Id      In Number
                                      ,p_Customer_Trx_Line_Id In Number)
    Return Number Is
    l_Issqn Number;
  Begin
    Begin
      Select (Case
               When (Arvt.Global_Attribute10 = 'ISS' And
                    (Arvt.Global_Attribute11 Is Null Or
                    Arvt.Global_Attribute11 = 'N') And
                    Arvt.Global_Attribute3 Is Null) Then
                'N'
               When (Arvt.Global_Attribute10 = 'ISS' And
                    Arvt.Global_Attribute11 = 'Y') Then
                'R'
               When (Arvt.Global_Attribute10 = 'ISS' And
                    (Arvt.Global_Attribute11 Is Null Or
                    Arvt.Global_Attribute11 = 'N') And
                    Arvt.Global_Attribute3 = 'EXEMPTION') Then
                'I'
               Else
                Null
             End)
        Into l_Issqn
        From Ar_Vat_Tax_All            Arvt
            ,Ra_Customer_Trx_Lines_All Rctl
       Where 1 = 1
         And Rctl.Link_To_Cust_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctl.Customer_Trx_Id = p_Customer_Trx_Id
         And Rctl.Line_Type = 'TAX'
         And Arvt.Vat_Tax_Id = Rctl.Vat_Tax_Id
         And Arvt.Global_Attribute10 = 'ISS'
         And Arvt.Global_Attribute2 = 'Y';
    Exception
      When Others Then
        l_Issqn := Null;
    End;
    Return l_Issqn;
  End Get_Nfe_Dm_Cod_Trib_Issqn_f;

  ---
  -----------------------------------------------------------------------------------------
  ------------ Função para retornar o Dm_Mod_Base_Calc_St do Item da Transação --------------
  -----------------------------------------------------------------------------------------
  Function Get_Nfe_Dm_Mod_Base_Calc_St_f(p_Customer_Trx_Id      In Number
                                        ,p_Customer_Trx_Line_Id In Number)
    Return Number Is
    l_Mod_Bc_St Number;
  Begin
    Begin
      /*Select 4 Dm_Mod_Base_Calc_St
       Into l_Mod_Bc_St
       From Ar_Vat_Tax_All            Arvt
           ,Ra_Customer_Trx_Lines_All Rctl
      Where 1 = 1
        And Rctl.Link_To_Cust_Trx_Line_Id = p_Customer_Trx_Line_Id
        And Rctl.Customer_Trx_Id = p_Customer_Trx_Id
        And Rctl.Line_Type = 'TAX'
        And Arvt.Vat_Tax_Id = Rctl.Vat_Tax_Id
        And Arvt.Global_Attribute10 = 'ICMS-ST'
        And Arvt.Global_Attribute2 = 'Y';*/ -- Carranza 05/12/2019
      Select Case
               When Nvl(Zl.Tax_Base_Modifier_Rate, 0) > 0 Then
                '4'
               Else
                '0'
             End Dm_Mod_Base_Calc_St
        Into l_Mod_Bc_St
        From Ar_Vat_Tax_All            Arvt
            ,Ra_Customer_Trx_Lines_All Rctl
            ,Zx_Lines                  Zl
       Where 1 = 1
         And Rctl.Link_To_Cust_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Rctl.Customer_Trx_Id = p_Customer_Trx_Id
         And Rctl.Line_Type = 'TAX'
         And Arvt.Vat_Tax_Id = Rctl.Vat_Tax_Id
         And Arvt.Global_Attribute10 = 'ICMS-ST'
            /*And Arvt.Global_Attribute2 = 'Y'*/ -- Carranza 17/04/2020
         And Rctl.Tax_Line_Id = Zl.Tax_Line_Id; -- Carranza 05/12/2019
    Exception
      When Others Then
        l_Mod_Bc_St := Null;
    End;
    Return l_Mod_Bc_St;
  End Get_Nfe_Dm_Mod_Base_Calc_St_f;

  ---
  -----------------------------------------------------------------------------------------
  ------------ Função para retornar o valor total da Nota Fiscal Vl_Total_Nf --------------
  -----------------------------------------------------------------------------------------
  Function Get_Nfe_Vl_Total_Nf_f(p_Customer_Trx_Id In Number) Return Number Is
    l_Vl_Total_Nf Number;
  Begin
    Begin
      /*Select Sum(Aux.Valor) Vl_Total_Nf
       Into l_Vl_Total_Nf
       From (Select Nvl(Sum(Nvl(Rctla.Gross_Extended_Amount, Rctla.Extended_Amount)), 0) Valor
                   ,Rctla.Customer_Trx_Id
               From Ra_Customer_Trx_Lines_All Rctla
              Where Rctla.Line_Type = 'LINE'
                And (Select Count(1)
                       From Ra_Customer_Trx_Lines_All Rctla2
                      Where Rctla2.Customer_Trx_Id = Rctla.Customer_Trx_Id
                        And Rctla2.Line_Type = 'LINE'
                        And Rctla2.Global_Attribute1 Like '%933') > 0
                And (Select Count(1)
                       From Ra_Customer_Trx_Lines_All Rctla2
                      Where Rctla2.Customer_Trx_Id = Rctla.Customer_Trx_Id
                        And Rctla2.Line_Type = 'LINE'
                        And Rctla2.Global_Attribute1 Not Like '%933') = 0
              Group By Rctla.Customer_Trx_Id
             Union
             Select Nvl(Sum(Nvl(Cfaiig_Nf.Amount, 0)), 0)
                   ,Cfaiig_Nf.Customer_Trx_Id
               From Apps.Cll_F255_Ar_Invoice_Items_Gl_v Cfaiig_Nf
              Where Cfaiig_Nf.Line_Type = 'NF'
                And ((Select Count(1)
                        From Ra_Customer_Trx_Lines_All Rctla2
                       Where Rctla2.Customer_Trx_Id =
                             Cfaiig_Nf.Customer_Trx_Id
                         And Rctla2.Line_Type = 'LINE'
                         And Rctla2.Global_Attribute1 Not Like '%933') > 0)
              Group By Cfaiig_Nf.Customer_Trx_Id) Aux
      Where Aux.Customer_Trx_Id = p_Customer_Trx_Id;*/ -- Carranza 07/10/2022
      Select Nvl(Sum(Nvl(Cfaiig_Nf.Amount, 0)), 0)
        Into l_Vl_Total_Nf
        From Apps.Cll_F255_Ar_Invoice_Items_Gl_v Cfaiig_Nf
       Where 1 = 1
         And Cfaiig_Nf.Line_Type = 'NF'
         And Cfaiig_Nf.Customer_Trx_Id = p_Customer_Trx_Id; -- Carranza 07/10/2022
    Exception
      When Others Then
        l_Vl_Total_Nf := 0;
    End;
    Return l_Vl_Total_Nf;
  End Get_Nfe_Vl_Total_Nf_f;

  ---
  --------------------------------------------------------------------------------------------
  --------------- Função para retornar codido do pedido de compra do fornecedor --------------
  --------------------------------------------------------------------------------------------
  Function Get_Nfe_Pedido_Compra_f(p_Interface_Line_Attribute6 Number
                                  ,p_Org_Id                    Number)
    Return Varchar2 Is
    l_Vpedidocompra Varchar2(15);
  Begin
    Begin
      Select Nvl(Ool.Cust_Po_Number, Ool.Orig_Sys_Document_Ref) Pedido_Compra
        Into l_Vpedidocompra
        From Oe_Order_Lines_All Ool
       Where 1 = 1
         And Ool.Line_Id = p_Interface_Line_Attribute6
         And Ool.Org_Id = p_Org_Id;
    Exception
      When Others Then
        l_Vpedidocompra := Null;
    End;
    Return l_Vpedidocompra;
  End Get_Nfe_Pedido_Compra_f;

  ---
  --------------------------------------------------------------------------------------------
  --------------- Função para retornar codido do item pedido de compra do fornecedor -----------
  --------------------------------------------------------------------------------------------
  Function Get_Nfe_Item_Pedido_Compra_f(p_Interface_Line_Attribute6 Number
                                       ,p_Org_Id                    Number)
    Return Varchar2 Is
    l_Vitempedidocompra Varchar2(15);
  Begin
    Begin
      Select Nvl(Ool.Customer_Line_Number, Ool.Orig_Sys_Line_Ref) Item_Pedido_Compra
        Into l_Vitempedidocompra
        From Oe_Order_Lines_All Ool
       Where 1 = 1
         And Ool.Line_Id = p_Interface_Line_Attribute6
         And Ool.Org_Id = p_Org_Id;
    Exception
      When Others Then
        l_Vitempedidocompra := Null;
    End;
    Return l_Vitempedidocompra;
  End Get_Nfe_Item_Pedido_Compra_f;

  ---
  -----------------------------------------------------------------------------------------
  ------------ Função para retornar o Dm_Mot_Des_Icms do Item da Transação --------------
  -----------------------------------------------------------------------------------------
  Function Get_Nfe_Dm_Mot_Des_Icms_f(p_Customer_Trx_Id      In Number
                                    ,p_Customer_Trx_Line_Id In Number)
    Return Number Is
    l_Motdesoicms Number;
  Begin
    Begin
      Select Regexp_Replace(Substr(Nvl(Zl.Global_Attribute10, Legal_Justification_Text3), 1, 1), '[^0-9]+', '') Dm_Mot_Des_Icms
        Into l_Motdesoicms
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Arvt.Global_Attribute10 = 'ICMS'
         And Arvt.Global_Attribute3 = 'ICMS_EXEMPT_REASON'
         And Arvt.Global_Attribute9 In
             ('20', '30', '40', '41', '50', '70', '90')
         And Nvl(Zl.Global_Attribute10, Legal_Justification_Text3) Is Not Null
         And Zl.Trx_Id = p_Customer_Trx_Id
         And Zl.Trx_Line_Id = p_Customer_Trx_Line_Id;
    Exception
      When Others Then
        l_Motdesoicms := Null;
    End;
    Return l_Motdesoicms;
  End Get_Nfe_Dm_Mot_Des_Icms_f;

  ---
  -----------------------------------------------------------------------------------------
  ------------ Função para retornar o Cod_Ocor_Aj_Icms  do Item da Transação --------------
  -----------------------------------------------------------------------------------------
  Function Get_Nfe_Cod_Ocor_Aj_Icms_f(p_Customer_Trx_Line_Id In Number)
    Return Varchar2 Is
    l_Codocorajicms Varchar2(10);
  Begin
    Begin
      Return Null;
    Exception
      When Others Then
        l_Codocorajicms := Null;
    End;
    Return l_Codocorajicms;
  End Get_Nfe_Cod_Ocor_Aj_Icms_f;

  ---
  -----------------------------------------------------------------------------------------
  ------------ Função para retornar o DT_INI_INTEGRA data inicial integração EBS x CSF -----
  ------------------------------------------------------------------------------------------
  Function Get_Nfe_Dt_Ini_Integr_f Return Date Is
    l_Dt_Ini_Integr Date;
  Begin
    Begin
      Select Flv.Start_Date_Active
        Into l_Dt_Ini_Integr
        From Fnd_Lookup_Values Flv
       Where 1 = 1
         And Flv.Lookup_Type = 'XXISV_CSF_INTEGR_COMPLIANCE'
         And Flv.Lookup_Code = 'DT_INI_INTEGRACAO'
         And Flv.Language = Userenv('LANG');
    Exception
      When Others Then
        l_Dt_Ini_Integr := Null;
    End;
    Return l_Dt_Ini_Integr;
  End Get_Nfe_Dt_Ini_Integr_f;

  ---
  --------------------------------------------------------------------------
  ------------ Função para retornar o NCM do Item da Transacao -------------
  --------------------------------------------------------------------------
  Function Get_Nfe_Ncm_f(p_Customer_Trx_Id      In Number
                        ,p_Customer_Trx_Line_Id In Number) Return Varchar2 Is
    l_Ncm Varchar2(8);
  Begin
    Begin
      Select Substr(Zldf.Product_Fisc_Classification, 1, 8)
        Into l_Ncm
        From Apps.Zx_Lines_Det_Factors Zldf
       Where 1 = 1
         And Zldf.Trx_Id = p_Customer_Trx_Id
         And Zldf.Trx_Line_Id = p_Customer_Trx_Line_Id;
    Exception
      When Others Then
        l_Ncm := Null;
    End;
    Return l_Ncm;
  End Get_Nfe_Ncm_f;

  ---
  ----------------------------------------------------------------------------
  --------------- Função para retornar o Total Base de Calculo ISS -----------
  ----------------------------------------------------------------------------
  Function Get_Nfe_Total_Bc_Iss_f(p_Customer_Trx_Id In Number) Return Number Is
    l_Tot_Bc_Iss Number;
    Cursor c_Bc_Iss Is
      Select Abs(Sum(Zl.Taxable_Amt)) Bc_Iss
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Internal_Organization_Id = Arvt.Org_Id
         And Arvt.Global_Attribute10 = 'ISS'
         And Arvt.Global_Attribute2 = 'Y'
         And (Arvt.Global_Attribute11 = 'N' Or
             Arvt.Global_Attribute11 Is Null) /*ISS DEVIDO*/
         And Zl.Trx_Id = p_Customer_Trx_Id Having
       Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt))) > 0;
    r_Bc_Iss c_Bc_Iss%Rowtype;
    --
    Cursor c_Bc_Iss_Ret Is
      Select Abs(Sum(Zl.Taxable_Amt)) Bc_Iss
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Internal_Organization_Id = Arvt.Org_Id
         And Arvt.Global_Attribute10 = 'ISS'
         And Arvt.Global_Attribute2 = 'Y'
         And Arvt.Global_Attribute11 = 'Y' /*ISS RETIDO*/
         And Zl.Trx_Id = p_Customer_Trx_Id Having
       Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt))) > 0;
    r_Bc_Iss_Ret c_Bc_Iss_Ret%Rowtype;
    --
  Begin
    Open c_Bc_Iss;
    Loop
      Fetch c_Bc_Iss
        Into r_Bc_Iss;
      Exit When c_Bc_Iss%Notfound;
      l_Tot_Bc_Iss := r_Bc_Iss.Bc_Iss;
    End Loop;
    Close c_Bc_Iss;
    --
    If l_Tot_Bc_Iss Is Null
    Then
      Open c_Bc_Iss_Ret;
      Loop
        Fetch c_Bc_Iss_Ret
          Into r_Bc_Iss_Ret;
        Exit When c_Bc_Iss_Ret%Notfound;
        l_Tot_Bc_Iss := r_Bc_Iss_Ret.Bc_Iss;
      End Loop;
      Close c_Bc_Iss_Ret;
      --
    Else
      l_Tot_Bc_Iss := Nvl(l_Tot_Bc_Iss, 0);
    End If;
    --
    Return l_Tot_Bc_Iss;
    --
  End Get_Nfe_Total_Bc_Iss_f;

  --
  ----------------------------------------------------------------------------
  --------------- Função para retornar o Total Valor de ISS ------------------
  ----------------------------------------------------------------------------
  Function Get_Nfe_Total_Vl_Iss_f(p_Customer_Trx_Id In Number) Return Number Is
    l_Tot_Vl_Iss Number;
    Cursor c_Vl_Iss Is
      Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt))) Vl_Iss
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Internal_Organization_Id = Arvt.Org_Id
         And Arvt.Global_Attribute10 = 'ISS'
         And Arvt.Global_Attribute2 = 'Y'
         And (Arvt.Global_Attribute11 = 'N' Or
             Arvt.Global_Attribute11 Is Null)
         And Zl.Trx_Id = p_Customer_Trx_Id;
    r_Vl_Iss c_Vl_Iss%Rowtype;
    --
    Cursor c_Vl_Iss_Ret Is
      Select Abs(Sum(Nvl(Zl.Cal_Tax_Amt, Zl.Tax_Amt))) Vl_Iss
        From Zx_Lines       Zl
            ,Ar_Vat_Tax_All Arvt
       Where 1 = 1
         And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
         And Zl.Internal_Organization_Id = Arvt.Org_Id
         And Arvt.Global_Attribute10 = 'ISS'
         And Arvt.Global_Attribute2 = 'Y'
         And Arvt.Global_Attribute11 = 'Y'
         And Zl.Trx_Id = p_Customer_Trx_Id;
    r_Vl_Iss_Ret c_Vl_Iss_Ret%Rowtype;
    --
  Begin
    Open c_Vl_Iss;
    Loop
      Fetch c_Vl_Iss
        Into r_Vl_Iss;
      Exit When c_Vl_Iss%Notfound;
      l_Tot_Vl_Iss := r_Vl_Iss.Vl_Iss;
    End Loop;
    Close c_Vl_Iss;
    --
    If l_Tot_Vl_Iss Is Null
    Then
      Open c_Vl_Iss_Ret;
      Loop
        Fetch c_Vl_Iss_Ret
          Into r_Vl_Iss_Ret;
        Exit When c_Vl_Iss_Ret%Notfound;
        l_Tot_Vl_Iss := r_Vl_Iss_Ret.Vl_Iss;
      End Loop;
      Close c_Vl_Iss_Ret;
      --
    Else
      l_Tot_Vl_Iss := Nvl(l_Tot_Vl_Iss, 0);
    End If;
    --
    Return l_Tot_Vl_Iss;
    --
  End Get_Nfe_Total_Vl_Iss_f;

  ---
  -------------------------------------------------------------------------------------------
  -------- Função para retornar o valor total do Serviço da Nota Fiscal Vl_Total_Serv -------
  -------------------------------------------------------------------------------------------
  Function Get_Nfe_Vl_Total_Serv_f(p_Customer_Trx_Id In Number) Return Number Is
    l_Vl_Total_Serv Number;
  Begin
    Begin
      Select Sum(Cfaiig_Itn.Vl_Item) Vl_Total_Serv
        Into l_Vl_Total_Serv
        From Apps.Cll_F255_Ar_Invoice_Items_v Cfaiig_Itn
       Where 1 = 1
         And Cfaiig_Itn.Line_Type = 'LINE'
         And Cfaiig_Itn.Customer_Trx_Id = p_Customer_Trx_Id
         And Cfaiig_Itn.Code_Cfo In
             ('1933', '2933', '3933', '5933', '6933', '7933');
    Exception
      When Others Then
        l_Vl_Total_Serv := 0;
    End;
    Return l_Vl_Total_Serv;
  End Get_Nfe_Vl_Total_Serv_f;

  ---
  -----------------------------------------------------------------------------------------
  ------- Função para retornar o valor total Base de Calculo ICMS Vl_Base_Calc_Icms -------
  -----------------------------------------------------------------------------------------
  Function Get_Nfe_Total_Bc_Icms_f(p_Customer_Trx_Id In Number) Return Number Is
    l_Vl_Total_Bc_Icms Number;
  Begin
    Begin
      Select Nvl(Sum(Nvl(Aux.Valor, 0)), 0)
        Into l_Vl_Total_Bc_Icms
        From (Select Case
                       When Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7) Not In
                            ('30', '40', '41', '50', '51', '60', '90') Then
                        Abs(Sum(Zl.Taxable_Amt))
                       Else
                        0
                     End Valor
                From Zx_Lines                  Zl
                    ,Ar_Vat_Tax_All            Arvt
                    ,Ra_Customer_Trx_Lines_All Rctla
               Where 1 = 1
                 And Zl.Tax_Rate_Id = Arvt.Vat_Tax_Id
                 And Zl.Internal_Organization_Id = Arvt.Org_Id
                 And Zl.Trx_Line_Id = Rctla.Customer_Trx_Line_Id
                 And Rctla.Line_Type = 'LINE'
                 And Arvt.Global_Attribute10 = 'ICMS'
                 And Arvt.Global_Attribute2 = 'Y'
                 And Zl.Trx_Id = p_Customer_Trx_Id
               Group By Nvl(Lpad(Arvt.Global_Attribute9, 2, 0), Rctla.Global_Attribute7)) Aux;
    Exception
      When Others Then
        l_Vl_Total_Bc_Icms := 0;
    End;
    Return l_Vl_Total_Bc_Icms;
  End Get_Nfe_Total_Bc_Icms_f;

  ---
  --------------------------------------------------------------------------
  ------------ Função para retornar o Versão Objeto Interface --------------
  --------------------------------------------------------------------------
  Function Get_Nfe_Version_f Return Varchar2 Is
  Begin
    Return('Xxisv_Csf_Nfe_Pkg V88');
  End;

  ---
  -----------------------------------------------------------------------------------------
  ------------ Função para retornar a Razão Social do Emitente -----
  ------------------------------------------------------------------------------------------
  Function Get_Nfe_Razao_Social_f(p_Cnpj_Emit In Varchar2) Return Varchar2 Is
    l_Razao_Social Varchar2(60);
  Begin
    Begin
      Select Flv.Description
        Into l_Razao_Social
        From Fnd_Lookup_Values Flv
       Where 1 = 1
         And Flv.Lookup_Type = 'XXISV_CSF_INTEGRA_EMPRESA'
         And Flv.Lookup_Code = p_Cnpj_Emit
         And Nvl(Flv.End_Date_Active, Sysdate) <= Sysdate
         And Flv.Language = Userenv('LANG');
    Exception
      When Others Then
        l_Razao_Social := Null;
    End;
    Return l_Razao_Social;
  End Get_Nfe_Razao_Social_f;

  ---
  -----------------------------------------------------------------------------------------
  ------------ Função para retornar a Descrição do Item -----
  ------------------------------------------------------------------------------------------
  Function Get_Nfe_Descr_Item_f(p_Customer_Trx_Line_Id In Number)
    Return Varchar2 Is
    l_Descricao_Item Varchar2(800);
    l_Inf_Lote       Varchar2(1000); --- Ito 02-Jun-2025
    Cursor c_Lot Is --- Ito 02-Jun-2025 - Incluir informaçao de lote na descrição do item (solicitado por Cesar)
      Select Rcta.Customer_Trx_Line_Id
            ,Rcta.Quantity_Ordered
            ,Mtl.Transaction_Id
            ,Mtl.Lot_Number
            ,Mtl.Expiration_Date
            ,Abs(Mtl.Transaction_Quantity) Quantity
        From Ra_Customer_Trx_Lines_All Rcta
            ,Mtl_Material_Transactions Mmt
            ,Mtl_Transaction_Lot_Val_v Mtl
       Where Rcta.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id
         And Mmt.Source_Code = 'ORDER ENTRY'
         And Mmt.Source_Line_Id = Rcta.Interface_Line_Attribute6
         And Mmt.Trx_Source_Line_Id = Rcta.Interface_Line_Attribute6
         And Mmt.Transaction_Type_Id = 33
         And Mtl.Transaction_Id = Mmt.Transaction_Id;
    r_Lot c_Lot%Rowtype;
  Begin
    Begin
      Select Nvl(Trim(Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Rctl.Translated_Description)), Xxisv_Csf_Nfe_Pkg.Get_Nfe_Converte_Char_f(Rctl.Description))
        Into l_Descricao_Item
        From Ra_Customer_Trx_Lines_All Rctl
       Where 1 = 1
         And Rctl.Line_Type = 'LINE'
         And Rctl.Customer_Trx_Line_Id = p_Customer_Trx_Line_Id;
    Exception
      When Others Then
        l_Descricao_Item := Null;
    End;
    --- Ito 02-Jun-2025 inicio
    l_Inf_Lote := Null;
    Open c_Lot;
    Loop
      Fetch c_Lot
        Into r_Lot;
      Exit When c_Lot%Notfound;
      If l_Inf_Lote Is Null
      Then
        l_Inf_Lote := ' - Lote: ' || r_Lot.Lot_Number || ' Expira em: ' ||
                      To_Char(r_Lot.Expiration_Date, 'DD/MM/YYYY') ||
                      ' Quantidade: ' || r_Lot.Quantity;
      Else
        l_Inf_Lote := l_Inf_Lote || ' - Lote: ' || r_Lot.Lot_Number ||
                      ' Expira em: ' ||
                      To_Char(r_Lot.Expiration_Date, 'DD/MM/YYYY') ||
                      ' Quantidade: ' || r_Lot.Quantity;
      End If;
    End Loop;
    Close c_Lot;
    --- Ito 02-Jun-2025 fim
    If l_Inf_Lote Is Null
    Then
      Return l_Descricao_Item;
    Else
      Return l_Descricao_Item || l_Inf_Lote;
    End If;
    ---
  End Get_Nfe_Descr_Item_f;

  ---
  --------------------------------------------------------------------------------
  ------------------------ Função para retornar o CBENEF -------------------------
  --------------------------------------------------------------------------------
  Function Get_Nfe_Cbenef_f(p_Uf             In Varchar2
                           ,p_Tipo_Transacao In Varchar2
                           ,p_Cfop           In Varchar2
                           ,p_Cst            In Varchar2
                           ,p_Ncm            In Varchar2) Return Varchar2 Is
    l_Cbenef Varchar2(30);
    l_Count  Number;
    Procedure p_Valida_Duplicidade(p_Count In Number
                                  ,p_Nivel In Varchar2) Is
    Begin
      If p_Count > 1
      Then
        Raise_Application_Error(-20001, 'Ambiguidade na derivação do CBENEF. Mais de uma regra encontrada para [' ||
                                 p_Nivel || '] ' || 'UF=' ||
                                 Nvl(p_Uf, 'NULL') ||
                                 ' | TIPO_TRANSACAO=' ||
                                 Nvl(p_Tipo_Transacao, 'NULL') ||
                                 ' | CFOP=' || Nvl(p_Cfop, 'NULL') ||
                                 ' | CST=' || Nvl(p_Cst, 'NULL') ||
                                 ' | NCM=' || Nvl(p_Ncm, 'NULL'));
      End If;
    End p_Valida_Duplicidade;
  
  Begin
    ------------------------------------------------------------------
    -- NÍVEL 1
    -- UF + TIPO_TRANSACAO + CFOP + CST + NCM
    ------------------------------------------------------------------
    Select Count(*)
      Into l_Count
      From (Select Substr(Flv.Meaning || '|', 1, Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Uf
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 1) + 1, Instr(Flv.Meaning || '|', '|', 1, 2) -
                           Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Tipo_Transacao
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 2) + 1, Instr(Flv.Meaning || '|', '|', 1, 3) -
                           Instr(Flv.Meaning || '|', '|', 1, 2) - 1) As Cfop
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 3) + 1, Instr(Flv.Meaning || '|', '|', 1, 4) -
                           Instr(Flv.Meaning || '|', '|', 1, 3) - 1) As Cst
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 4) + 1, Instr(Flv.Meaning || '|', '|', 1, 5) -
                           Instr(Flv.Meaning || '|', '|', 1, 4) - 1) As Ncm
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 5) + 1, Instr(Flv.Meaning || '|', '|', 1, 6) -
                           Instr(Flv.Meaning || '|', '|', 1, 5) - 1) As Cbenef
              From Fnd_Lookup_Values Flv
             Where Flv.Lookup_Type = 'XXISV_CSF_CBENEF'
               And Flv.Enabled_Flag = 'Y'
               And Trunc(Sysdate) Between
                   Nvl(Flv.Start_Date_Active, Trunc(Sysdate)) And
                   Nvl(Flv.End_Date_Active, Trunc(Sysdate))
               And Flv.Language = Userenv('LANG')) x
     Where Trim(x.Uf) = Trim(p_Uf)
       And Upper(Trim(x.Tipo_Transacao)) = Upper(Trim(p_Tipo_Transacao))
       And Trim(x.Cfop) = Trim(p_Cfop)
       And Trim(x.Cst) = Trim(p_Cst)
       And Trim(x.Ncm) = Trim(p_Ncm);
    p_Valida_Duplicidade(l_Count, 'UF+TIPO_TRANSACAO+CFOP+CST+NCM');
    If l_Count = 1
    Then
      Select x.Cbenef
        Into l_Cbenef
        From (Select Substr(Flv.Meaning || '|', 1, Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Uf
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 1) + 1, Instr(Flv.Meaning || '|', '|', 1, 2) -
                             Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Tipo_Transacao
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 2) + 1, Instr(Flv.Meaning || '|', '|', 1, 3) -
                             Instr(Flv.Meaning || '|', '|', 1, 2) - 1) As Cfop
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 3) + 1, Instr(Flv.Meaning || '|', '|', 1, 4) -
                             Instr(Flv.Meaning || '|', '|', 1, 3) - 1) As Cst
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 4) + 1, Instr(Flv.Meaning || '|', '|', 1, 5) -
                             Instr(Flv.Meaning || '|', '|', 1, 4) - 1) As Ncm
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 5) + 1, Instr(Flv.Meaning || '|', '|', 1, 6) -
                             Instr(Flv.Meaning || '|', '|', 1, 5) - 1) As Cbenef
                From Fnd_Lookup_Values Flv
               Where Flv.Lookup_Type = 'XXISV_CSF_CBENEF'
                 And Flv.Enabled_Flag = 'Y'
                 And Trunc(Sysdate) Between
                     Nvl(Flv.Start_Date_Active, Trunc(Sysdate)) And
                     Nvl(Flv.End_Date_Active, Trunc(Sysdate))
                 And Flv.Language = Userenv('LANG')) x
       Where Trim(x.Uf) = Trim(p_Uf)
         And Upper(Trim(x.Tipo_Transacao)) = Upper(Trim(p_Tipo_Transacao))
         And Trim(x.Cfop) = Trim(p_Cfop)
         And Trim(x.Cst) = Trim(p_Cst)
         And Trim(x.Ncm) = Trim(p_Ncm)
         And Rownum = 1;
      Return l_Cbenef;
    End If;
    ------------------------------------------------------------------
    -- NÍVEL 2
    -- UF + TIPO_TRANSACAO + CFOP + CST
    -- NCM vazio na lookup
    ------------------------------------------------------------------
    Select Count(*)
      Into l_Count
      From (Select Substr(Flv.Meaning || '|', 1, Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Uf
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 1) + 1, Instr(Flv.Meaning || '|', '|', 1, 2) -
                           Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Tipo_Transacao
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 2) + 1, Instr(Flv.Meaning || '|', '|', 1, 3) -
                           Instr(Flv.Meaning || '|', '|', 1, 2) - 1) As Cfop
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 3) + 1, Instr(Flv.Meaning || '|', '|', 1, 4) -
                           Instr(Flv.Meaning || '|', '|', 1, 3) - 1) As Cst
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 4) + 1, Instr(Flv.Meaning || '|', '|', 1, 5) -
                           Instr(Flv.Meaning || '|', '|', 1, 4) - 1) As Ncm
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 5) + 1, Instr(Flv.Meaning || '|', '|', 1, 6) -
                           Instr(Flv.Meaning || '|', '|', 1, 5) - 1) As Cbenef
              From Fnd_Lookup_Values Flv
             Where Flv.Lookup_Type = 'XXISV_CSF_CBENEF'
               And Flv.Enabled_Flag = 'Y'
               And Trunc(Sysdate) Between
                   Nvl(Flv.Start_Date_Active, Trunc(Sysdate)) And
                   Nvl(Flv.End_Date_Active, Trunc(Sysdate))
               And Flv.Language = Userenv('LANG')) x
     Where Trim(x.Uf) = Trim(p_Uf)
       And Upper(Trim(x.Tipo_Transacao)) = Upper(Trim(p_Tipo_Transacao))
       And Trim(x.Cfop) = Trim(p_Cfop)
       And Trim(x.Cst) = Trim(p_Cst)
       And Nvl(Trim(x.Ncm), ' ') = ' ';
    p_Valida_Duplicidade(l_Count, 'UF+TIPO_TRANSACAO+CFOP+CST');
    If l_Count = 1
    Then
      Select x.Cbenef
        Into l_Cbenef
        From (Select Substr(Flv.Meaning || '|', 1, Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Uf
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 1) + 1, Instr(Flv.Meaning || '|', '|', 1, 2) -
                             Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Tipo_Transacao
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 2) + 1, Instr(Flv.Meaning || '|', '|', 1, 3) -
                             Instr(Flv.Meaning || '|', '|', 1, 2) - 1) As Cfop
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 3) + 1, Instr(Flv.Meaning || '|', '|', 1, 4) -
                             Instr(Flv.Meaning || '|', '|', 1, 3) - 1) As Cst
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 4) + 1, Instr(Flv.Meaning || '|', '|', 1, 5) -
                             Instr(Flv.Meaning || '|', '|', 1, 4) - 1) As Ncm
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 5) + 1, Instr(Flv.Meaning || '|', '|', 1, 6) -
                             Instr(Flv.Meaning || '|', '|', 1, 5) - 1) As Cbenef
                From Fnd_Lookup_Values Flv
               Where Flv.Lookup_Type = 'XXISV_CSF_CBENEF'
                 And Flv.Enabled_Flag = 'Y'
                 And Trunc(Sysdate) Between
                     Nvl(Flv.Start_Date_Active, Trunc(Sysdate)) And
                     Nvl(Flv.End_Date_Active, Trunc(Sysdate))
                 And Flv.Language = Userenv('LANG')) x
       Where Trim(x.Uf) = Trim(p_Uf)
         And Upper(Trim(x.Tipo_Transacao)) = Upper(Trim(p_Tipo_Transacao))
         And Trim(x.Cfop) = Trim(p_Cfop)
         And Trim(x.Cst) = Trim(p_Cst)
         And Nvl(Trim(x.Ncm), ' ') = ' '
         And Rownum = 1;
      Return l_Cbenef;
    End If;
    ------------------------------------------------------------------
    -- NÍVEL 3
    -- UF + CFOP + CST + NCM
    -- TIPO_TRANSACAO vazio na lookup
    ------------------------------------------------------------------
    Select Count(*)
      Into l_Count
      From (Select Substr(Flv.Meaning || '|', 1, Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Uf
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 1) + 1, Instr(Flv.Meaning || '|', '|', 1, 2) -
                           Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Tipo_Transacao
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 2) + 1, Instr(Flv.Meaning || '|', '|', 1, 3) -
                           Instr(Flv.Meaning || '|', '|', 1, 2) - 1) As Cfop
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 3) + 1, Instr(Flv.Meaning || '|', '|', 1, 4) -
                           Instr(Flv.Meaning || '|', '|', 1, 3) - 1) As Cst
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 4) + 1, Instr(Flv.Meaning || '|', '|', 1, 5) -
                           Instr(Flv.Meaning || '|', '|', 1, 4) - 1) As Ncm
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 5) + 1, Instr(Flv.Meaning || '|', '|', 1, 6) -
                           Instr(Flv.Meaning || '|', '|', 1, 5) - 1) As Cbenef
              From Fnd_Lookup_Values Flv
             Where Flv.Lookup_Type = 'XXISV_CSF_CBENEF'
               And Flv.Enabled_Flag = 'Y'
               And Trunc(Sysdate) Between
                   Nvl(Flv.Start_Date_Active, Trunc(Sysdate)) And
                   Nvl(Flv.End_Date_Active, Trunc(Sysdate))
               And Flv.Language = Userenv('LANG')) x
     Where Trim(x.Uf) = Trim(p_Uf)
       And Nvl(Trim(x.Tipo_Transacao), ' ') = ' '
       And Trim(x.Cfop) = Trim(p_Cfop)
       And Trim(x.Cst) = Trim(p_Cst)
       And Trim(x.Ncm) = Trim(p_Ncm);
    p_Valida_Duplicidade(l_Count, 'UF+CFOP+CST+NCM');
    If l_Count = 1
    Then
      Select x.Cbenef
        Into l_Cbenef
        From (Select Substr(Flv.Meaning || '|', 1, Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Uf
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 1) + 1, Instr(Flv.Meaning || '|', '|', 1, 2) -
                             Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Tipo_Transacao
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 2) + 1, Instr(Flv.Meaning || '|', '|', 1, 3) -
                             Instr(Flv.Meaning || '|', '|', 1, 2) - 1) As Cfop
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 3) + 1, Instr(Flv.Meaning || '|', '|', 1, 4) -
                             Instr(Flv.Meaning || '|', '|', 1, 3) - 1) As Cst
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 4) + 1, Instr(Flv.Meaning || '|', '|', 1, 5) -
                             Instr(Flv.Meaning || '|', '|', 1, 4) - 1) As Ncm
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 5) + 1, Instr(Flv.Meaning || '|', '|', 1, 6) -
                             Instr(Flv.Meaning || '|', '|', 1, 5) - 1) As Cbenef
                From Fnd_Lookup_Values Flv
               Where Flv.Lookup_Type = 'XXISV_CSF_CBENEF'
                 And Flv.Enabled_Flag = 'Y'
                 And Trunc(Sysdate) Between
                     Nvl(Flv.Start_Date_Active, Trunc(Sysdate)) And
                     Nvl(Flv.End_Date_Active, Trunc(Sysdate))
                 And Flv.Language = Userenv('LANG')) x
       Where Trim(x.Uf) = Trim(p_Uf)
         And Nvl(Trim(x.Tipo_Transacao), ' ') = ' '
         And Trim(x.Cfop) = Trim(p_Cfop)
         And Trim(x.Cst) = Trim(p_Cst)
         And Trim(x.Ncm) = Trim(p_Ncm)
         And Rownum = 1;
      Return l_Cbenef;
    End If;
    ------------------------------------------------------------------
    -- NÍVEL 4
    -- UF + CFOP + CST
    -- TIPO_TRANSACAO e NCM vazios na lookup
    ------------------------------------------------------------------
    Select Count(*)
      Into l_Count
      From (Select Substr(Flv.Meaning || '|', 1, Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Uf
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 1) + 1, Instr(Flv.Meaning || '|', '|', 1, 2) -
                           Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Tipo_Transacao
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 2) + 1, Instr(Flv.Meaning || '|', '|', 1, 3) -
                           Instr(Flv.Meaning || '|', '|', 1, 2) - 1) As Cfop
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 3) + 1, Instr(Flv.Meaning || '|', '|', 1, 4) -
                           Instr(Flv.Meaning || '|', '|', 1, 3) - 1) As Cst
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 4) + 1, Instr(Flv.Meaning || '|', '|', 1, 5) -
                           Instr(Flv.Meaning || '|', '|', 1, 4) - 1) As Ncm
                  ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 5) + 1, Instr(Flv.Meaning || '|', '|', 1, 6) -
                           Instr(Flv.Meaning || '|', '|', 1, 5) - 1) As Cbenef
              From Fnd_Lookup_Values Flv
             Where Flv.Lookup_Type = 'XXISV_CSF_CBENEF'
               And Flv.Enabled_Flag = 'Y'
               And Trunc(Sysdate) Between
                   Nvl(Flv.Start_Date_Active, Trunc(Sysdate)) And
                   Nvl(Flv.End_Date_Active, Trunc(Sysdate))
               And Flv.Language = Userenv('LANG')) x
     Where Trim(x.Uf) = Trim(p_Uf)
       And Nvl(Trim(x.Tipo_Transacao), ' ') = ' '
       And Trim(x.Cfop) = Trim(p_Cfop)
       And Trim(x.Cst) = Trim(p_Cst)
       And Nvl(Trim(x.Ncm), ' ') = ' ';
    p_Valida_Duplicidade(l_Count, 'UF+CFOP+CST');
    If l_Count = 1
    Then
      Select x.Cbenef
        Into l_Cbenef
        From (Select Substr(Flv.Meaning || '|', 1, Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Uf
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 1) + 1, Instr(Flv.Meaning || '|', '|', 1, 2) -
                             Instr(Flv.Meaning || '|', '|', 1, 1) - 1) As Tipo_Transacao
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 2) + 1, Instr(Flv.Meaning || '|', '|', 1, 3) -
                             Instr(Flv.Meaning || '|', '|', 1, 2) - 1) As Cfop
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 3) + 1, Instr(Flv.Meaning || '|', '|', 1, 4) -
                             Instr(Flv.Meaning || '|', '|', 1, 3) - 1) As Cst
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 4) + 1, Instr(Flv.Meaning || '|', '|', 1, 5) -
                             Instr(Flv.Meaning || '|', '|', 1, 4) - 1) As Ncm
                    ,Substr(Flv.Meaning || '|', Instr(Flv.Meaning || '|', '|', 1, 5) + 1, Instr(Flv.Meaning || '|', '|', 1, 6) -
                             Instr(Flv.Meaning || '|', '|', 1, 5) - 1) As Cbenef
                From Fnd_Lookup_Values Flv
               Where Flv.Lookup_Type = 'XXISV_CSF_CBENEF'
                 And Flv.Enabled_Flag = 'Y'
                 And Trunc(Sysdate) Between
                     Nvl(Flv.Start_Date_Active, Trunc(Sysdate)) And
                     Nvl(Flv.End_Date_Active, Trunc(Sysdate))
                 And Flv.Language = Userenv('LANG')) x
       Where Trim(x.Uf) = Trim(p_Uf)
         And Nvl(Trim(x.Tipo_Transacao), ' ') = ' '
         And Trim(x.Cfop) = Trim(p_Cfop)
         And Trim(x.Cst) = Trim(p_Cst)
         And Nvl(Trim(x.Ncm), ' ') = ' '
         And Rownum = 1;
      Return l_Cbenef;
    End If;
    Return Null;
  Exception
    When No_Data_Found Then
      Return Null;
    When Others Then
      Raise;
  End Get_Nfe_Cbenef_f;

  ---
  ----------------------------------------------------
  --- Procedure utilizada para integrações via ODI ---
  ----------------------------------------------------
  Procedure Odi_Nfe_p Is
    --
    Cursor C0 Is
      Select Distinct Min(Xcpi.Dt_Ini) Dt_Ini
                     ,Max(Xcpi.Dt_Fin) Dt_Fin
        From Xxisv.Xxisv_Csf_Periodo_Integr Xcpi
       Where 1 = 1
         And Xcpi.Obj_Integr_Cd = '6'; /*6 - Notas Fiscais Mercantis*/
    R0 C0%Rowtype;
    --
  Begin
    --
    Open C0;
    Loop
      Fetch C0
        Into R0;
      Exit When C0%Notfound;
      --
      ---      Xxisv_Csf_NFE_Pkg.Vw_Csf_Nota_Fiscal_p(p_Dt_Ini => R0.Dt_Ini, p_Dt_Fin => R0.Dt_Fin, p_Rotina => 'Xxisv_Csf_NFE_Pkg.Odi_NF_Mercantil_p');
      --
      Commit;
      --
    End Loop;
    Close C0;
    --
  End Odi_Nfe_p;

  ---
  ----------------------------------------------------
  --- Procedure utilizada para integrações via SIC ---
  ----------------------------------------------------
  Procedure Sic_Nfe_p(En_Agendintegrsic_Id   Number Default Null
                     ,Ed_Dt_Ini              Date
                     ,Ed_Dt_Fin              Date
                     ,Ev_Objintegrsic_Cd     Varchar2 Default Null
                     ,Ev_Tipoobjintegrsic_Cd Varchar2 Default Null) Is
    l_Errbuf  Varchar2(1000);
    l_Retcode Number;
  Begin
    --
    Xxisv_Csf_Nfe_Pkg.Main_p(Errbuf => l_Errbuf, Retcode => l_Retcode, p_Org_Id => Null, p_Mod_Fiscal => '55', p_Status_Nfe => Null, p_Batch_Source_Id => Null, p_Trx_Num_Ini => Null, p_Trx_Num_Fim => Null, p_Data_Ini => Fnd_Date.Date_To_Canonical(Ed_Dt_Ini), p_Data_Fim => Fnd_Date.Date_To_Canonical(Ed_Dt_Fin));
    --
    Commit;
    --
  End Sic_Nfe_p;

  ---
  ----------------------------------------------------
  --- Procedure utilizada para integrações via SIC ---
  ----------------------------------------------------
  Procedure Sic_Nfe_Online_p(Ev_Objintegrsic_Cd     Varchar2 Default Null
                            ,Ev_Tipoobjintegrsic_Cd Varchar2 Default Null) Is
    l_Errbuf  Varchar2(1000);
    l_Retcode Number;
  Begin
    --
    Null;
    --
    Commit;
    --
  End Sic_Nfe_Online_p;

---
End Xxisv_Csf_Nfe_Pkg;
/

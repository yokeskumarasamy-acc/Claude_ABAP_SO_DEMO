CLASS zcl_so_load_v2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_so_load_v2 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_header,
             client TYPE zcld_so_header_v2-client,
             vbeln  TYPE zcld_so_header_v2-vbeln,
             kunnr  TYPE zcld_so_header_v2-kunnr,
             auart  TYPE zcld_so_header_v2-auart,
             erdat  TYPE zcld_so_header_v2-erdat,
             vkorg  TYPE zcld_so_header_v2-vkorg,
             netwr  TYPE zcld_so_header_v2-netwr,
             waerk  TYPE zcld_so_header_v2-waerk,
           END OF ty_header.

    TYPES: BEGIN OF ty_item,
             client TYPE zcld_so_itm_v2-client,
             vbeln  TYPE zcld_so_itm_v2-vbeln,
             posnr  TYPE zcld_so_itm_v2-posnr,
             matnr  TYPE zcld_so_itm_v2-matnr,
             arktx  TYPE zcld_so_itm_v2-arktx,
             kwmeng TYPE zcld_so_itm_v2-kwmeng,
             vrkme  TYPE zcld_so_itm_v2-vrkme,
             netpr  TYPE zcld_so_itm_v2-netpr,
             netwr  TYPE zcld_so_itm_v2-netwr,
             werks  TYPE zcld_so_itm_v2-werks,
           END OF ty_item.

    TYPES: tt_header    TYPE STANDARD TABLE OF ty_header    WITH EMPTY KEY.
    TYPES: tt_item      TYPE STANDARD TABLE OF ty_item      WITH EMPTY KEY.
    TYPES: tt_matnr     TYPE STANDARD TABLE OF zcld_so_itm_v2-matnr   WITH EMPTY KEY.
    TYPES: tt_arktx     TYPE STANDARD TABLE OF zcld_so_itm_v2-arktx   WITH EMPTY KEY.
    TYPES: tt_werks     TYPE STANDARD TABLE OF zcld_so_itm_v2-werks   WITH EMPTY KEY.
    TYPES: tt_kunnr     TYPE STANDARD TABLE OF zcld_so_header_v2-kunnr WITH EMPTY KEY.
    TYPES: tt_vkorg     TYPE STANDARD TABLE OF zcld_so_header_v2-vkorg WITH EMPTY KEY.
    TYPES: tt_waerk     TYPE STANDARD TABLE OF zcld_so_header_v2-waerk WITH EMPTY KEY.
    TYPES: tt_auart     TYPE STANDARD TABLE OF zcld_so_header_v2-auart WITH EMPTY KEY.

    DATA: lt_headers    TYPE tt_header.
    DATA: lt_items      TYPE tt_item.
    DATA: lt_materials  TYPE tt_matnr.
    DATA: lt_descr      TYPE tt_arktx.
    DATA: lt_plants     TYPE tt_werks.
    DATA: lt_customers  TYPE tt_kunnr.
    DATA: lt_sorgs      TYPE tt_vkorg.
    DATA: lt_currencies TYPE tt_waerk.
    DATA: lt_ordertypes TYPE tt_auart.
    DATA: ls_header     TYPE ty_header.
    DATA: ls_item       TYPE ty_item.
    DATA: lv_netwr      TYPE zcld_so_header_v2-netwr.
    DATA: lv_vbeln      TYPE zcld_so_header_v2-vbeln.
    DATA: lv_idx        TYPE i.
    DATA: lv_pidx       TYPE i.
    DATA: lv_mat_idx    TYPE i.
    DATA: lv_plt_idx    TYPE i.
    DATA: lv_kwmeng     TYPE zcld_so_itm_v2-kwmeng.
    DATA: lv_netpr      TYPE zcld_so_itm_v2-netpr.
    DATA: lv_inetwr     TYPE zcld_so_itm_v2-netwr.
    DATA: lv_year_i     TYPE i.
    DATA: lv_month_i    TYPE i.
    DATA: lv_cnt_h      TYPE i.
    DATA: lv_cnt_i      TYPE i.

    lt_materials  = VALUE tt_matnr(  ( 'MAT-NOTEBOOK-01' )
                                     ( 'MAT-KEYBOARD-02' )
                                     ( 'MAT-USBHUB-003'  )
                                     ( 'MAT-MOUSE-0004'  )
                                     ( 'MAT-MONITOR-005' ) ).
    lt_descr      = VALUE tt_arktx(  ( 'Notebook Pro 15'    )
                                     ( 'Mechanical Keyboard' )
                                     ( 'USB-C Hub'           )
                                     ( 'Wireless Mouse'      )
                                     ( 'Monitor 27in'        ) ).
    lt_plants     = VALUE tt_werks(  ( '1000' ) ( '2000' ) ( '3000' ) ).
    lt_customers  = VALUE tt_kunnr(  ( '0000001000' ) ( '0000001001' )
                                     ( '0000001002' ) ( '0000001003' )
                                     ( '0000001004' ) ).
    lt_sorgs      = VALUE tt_vkorg(  ( '1000' ) ( '2000' ) ( '3000' ) ).
    lt_currencies = VALUE tt_waerk(  ( 'USD' ) ( 'EUR' ) ( 'GBP' ) ).
    lt_ordertypes = VALUE tt_auart(  ( 'OR' ) ( 'ZOR' ) ( 'RE' ) ).

    DO 105 TIMES.
      lv_idx   = sy-index.
      lv_vbeln = |{ lv_idx + 10000 WIDTH = 10 PAD = '0' }|.
      lv_netwr = 0.

      DO 2 TIMES.
        lv_pidx    = sy-index.
        lv_mat_idx = ( ( lv_idx - 1 ) * 2 + lv_pidx - 1 ) MOD 5 + 1.
        lv_plt_idx = ( lv_mat_idx - 1 ) MOD 3 + 1.
        lv_kwmeng  = CONV zcld_so_itm_v2-kwmeng( lv_idx * lv_pidx ).
        lv_netpr   = CONV zcld_so_itm_v2-netpr( lv_mat_idx * 100 + 50 ).
        lv_inetwr  = CONV zcld_so_itm_v2-netwr( lv_kwmeng * lv_netpr ).

        ls_item-client = sy-mandt.
        ls_item-vbeln  = lv_vbeln.
        ls_item-posnr  = |{ lv_pidx * 10 WIDTH = 6 PAD = '0' }|.
        ls_item-matnr  = lt_materials[ lv_mat_idx ].
        ls_item-arktx  = lt_descr[ lv_mat_idx ].
        ls_item-kwmeng = lv_kwmeng.
        ls_item-vrkme  = 'EA'.
        ls_item-netpr  = lv_netpr.
        ls_item-netwr  = lv_inetwr.
        ls_item-werks  = lt_plants[ lv_plt_idx ].
        APPEND ls_item TO lt_items.

        lv_netwr = lv_netwr + lv_inetwr.
      ENDDO.

      lv_year_i  = 2020 + ( lv_idx MOD 5 ).
      lv_month_i = ( lv_idx MOD 12 ) + 1.

      ls_header-client = sy-mandt.
      ls_header-vbeln  = lv_vbeln.
      ls_header-kunnr  = lt_customers[  ( lv_idx - 1 ) MOD 5 + 1 ].
      ls_header-auart  = lt_ordertypes[ ( lv_idx - 1 ) MOD 3 + 1 ].
      ls_header-erdat  = |{ lv_year_i }{ lv_month_i WIDTH = 2 PAD = '0' }01|.
      ls_header-vkorg  = lt_sorgs[      ( lv_idx - 1 ) MOD 3 + 1 ].
      ls_header-netwr  = lv_netwr.
      ls_header-waerk  = lt_currencies[ ( lv_idx - 1 ) MOD 3 + 1 ].
      APPEND ls_header TO lt_headers.
    ENDDO.

    DELETE FROM zcld_so_itm_v2.
    DELETE FROM zcld_so_header_v2.

    INSERT zcld_so_header_v2 FROM TABLE @lt_headers.
    INSERT zcld_so_itm_v2    FROM TABLE @lt_items.

    COMMIT WORK AND WAIT.

    SELECT COUNT(*) FROM zcld_so_header_v2 INTO @lv_cnt_h.
    SELECT COUNT(*) FROM zcld_so_itm_v2    INTO @lv_cnt_i.

    out->write( |{ lv_cnt_h } sales order headers loaded.| ).
    out->write( |{ lv_cnt_i } sales order items loaded.|   ).
    out->write( |Sales Order data load complete!|           ).

  ENDMETHOD.

ENDCLASS.

CLASS zcl_so_load_v2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: tt_hdr TYPE STANDARD TABLE OF zcld_so_hdr_v2 WITH EMPTY KEY,
           tt_itm TYPE STANDARD TABLE OF zcld_so_itm_v2 WITH EMPTY KEY.
ENDCLASS.



CLASS zcl_so_load_v2 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_hdr TYPE tt_hdr.
    DATA lt_itm TYPE tt_itm.

    " reference data used to vary the generated records
    DATA(lt_vkorg) = VALUE string_table( ( `1000` ) ( `2000` ) ( `3000` ) ).
    DATA(lt_waerk) = VALUE string_table( ( `USD` ) ( `EUR` ) ( `GBP` ) ).
    DATA(lt_matnr) = VALUE string_table(
      ( `MAT-1001` ) ( `MAT-1002` ) ( `MAT-1003` )
      ( `MAT-1004` ) ( `MAT-1005` ) ).

    DO 105 TIMES.
      DATA(lv_idx)   = sy-index.
      DATA(lv_vbeln) = |{ 10000 + lv_idx WIDTH = 10 PAD = '0' ALIGN = RIGHT }|.

      " deterministic but varied selections
      DATA(lv_v) = lt_vkorg[ ( lv_idx MOD 3 ) + 1 ].
      DATA(lv_w) = lt_waerk[ ( lv_idx MOD 3 ) + 1 ].

      DATA lv_hdr_netwr TYPE zcld_so_hdr_v2-netwr.
      lv_hdr_netwr = 0.

      DO 2 TIMES.
        DATA(lv_pos)   = sy-index.
        DATA(lv_matnr) = lt_matnr[ ( ( lv_idx + lv_pos ) MOD 5 ) + 1 ].

        DATA(lv_qty)   = CONV zcld_so_itm_v2-kwmeng( lv_pos * 10 ).
        DATA(lv_netpr) = CONV zcld_so_itm_v2-netpr( 100 + ( lv_idx MOD 50 ) ).
        DATA(lv_netwr) = CONV zcld_so_itm_v2-netwr( lv_qty * lv_netpr ).

        lt_itm = VALUE tt_itm( BASE lt_itm (
          vbeln  = lv_vbeln
          posnr  = |{ lv_pos * 10 WIDTH = 6 PAD = '0' ALIGN = RIGHT }|
          matnr  = lv_matnr
          arktx  = |Item { lv_pos } for order { lv_vbeln }|
          kwmeng = lv_qty
          vrkme  = 'EA'
          netpr  = lv_netpr
          netwr  = lv_netwr
          werks  = lv_v ) ).

        lv_hdr_netwr = lv_hdr_netwr + lv_netwr.
      ENDDO.

      lt_hdr = VALUE tt_hdr( BASE lt_hdr (
        vbeln = lv_vbeln
        kunnr = |{ 100000 + lv_idx WIDTH = 10 PAD = '0' ALIGN = RIGHT }|
        auart = 'OR'
        erdat = |{ sy-datum }|
        vkorg = lv_v
        netwr = lv_hdr_netwr
        waerk = lv_w ) ).
    ENDDO.

    DELETE FROM zcld_so_hdr_v2.
    DELETE FROM zcld_so_itm_v2.

    INSERT zcld_so_hdr_v2 FROM TABLE @lt_hdr.
    INSERT zcld_so_itm_v2 FROM TABLE @lt_itm.

    COMMIT WORK AND WAIT.

    out->write( |Sales order headers inserted: { lines( lt_hdr ) }| ).
    out->write( |Sales order items inserted:   { lines( lt_itm ) }| ).

  ENDMETHOD.

ENDCLASS.

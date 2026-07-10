@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SO Item - Interface V3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZClaude_I_SO_Item_V3
  as select from zcld_so_itm_v3
{
  key vbeln  as SalesOrder,
  key posnr  as Item,
      matnr  as Material,
      arktx  as Description,
      kwmeng as Quantity,
      vrkme  as Unit,
      netpr  as NetPrice,
      netwr  as NetValue,
      werks  as Plant
}

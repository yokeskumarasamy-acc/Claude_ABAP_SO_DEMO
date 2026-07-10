@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SO Header - Interface V3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZClaude_I_SO_Header_V3
  as select from zcld_so_hdr_v3
  association [0..*] to ZClaude_I_SO_Item_V3 as _Item
    on $projection.SalesOrder = _Item.SalesOrder
{
  key vbeln as SalesOrder,
      kunnr as Customer,
      auart as OrderType,
      erdat as CreatedDate,
      vkorg as SalesOrg,
      netwr as NetValue,
      waerk as Currency,
      _Item
}

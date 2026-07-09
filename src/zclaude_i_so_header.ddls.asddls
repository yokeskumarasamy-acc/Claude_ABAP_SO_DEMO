@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: Sales Order Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZClaude_I_SO_Header
  as select from zcld_so_header
  association [0..*] to ZClaude_I_SO_Item as _Item
    on $projection.SalesOrder = _Item.SalesOrder
{
  key vbeln  as SalesOrder,
      kunnr  as Customer,
      auart  as OrderType,
      erdat  as CreatedDate,
      vkorg  as SalesOrg,
      netwr  as NetValue,
      waerk  as Currency,
      _Item
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View: Sales Order Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZClaude_I_SO_Item
  as select from zcld_so_itm
{
  key vbeln   as SalesOrder,
  key posnr   as Item,
      matnr   as Material,
      arktx   as Description,
      kwmeng  as Quantity,
      vrkme   as Unit,
      netpr   as NetPrice,
      netwr   as NetValue,
      werks   as Plant
}

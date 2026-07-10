@Metadata.allowExtensions: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View: Sales Order Item V2'
define view entity ZClaude_C_SO_Item_V2
  as select from ZClaude_I_SO_Item_V2
{
  @UI.lineItem: [{ position: 10 }]
  key SalesOrder,
  @UI.lineItem: [{ position: 20 }]
  key Item,
  @UI.lineItem: [{ position: 30 }]
      Material,
  @UI.lineItem: [{ position: 40 }]
      Description,
  @UI.lineItem: [{ position: 50 }]
      Quantity,
  @UI.lineItem: [{ position: 60 }]
      Unit,
  @UI.lineItem: [{ position: 70 }]
      NetPrice,
  @UI.lineItem: [{ position: 80 }]
      NetValue,
  @UI.lineItem: [{ position: 90 }]
      Plant
}

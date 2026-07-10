@EndUserText.label: 'SO Item - Consumption V3'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZClaude_C_SO_Item_V3
  as select from ZClaude_I_SO_Item_V3
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

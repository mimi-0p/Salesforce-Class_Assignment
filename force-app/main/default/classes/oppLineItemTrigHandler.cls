public class oppLineItemTrigHandler {
    public static void befinsert(list<OpportunityLineItem> olin){
        List<OpportunityLineItem> itemsToUpdate = new List<OpportunityLineItem>();
        for(OpportunityLineItem oli : olin) {
            Decimal productPrice = oli.ListPrice;
            if(productPrice > 10008){
                itemsToUpdate.add(oli);
            } 
            else{
                oli.addError('Product price must be greater than 10008.');
            }
        }
    }
}
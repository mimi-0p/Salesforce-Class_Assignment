public class oppLineItemTrigHandler {
    /*Q9 Create a trigger such that when a product is added to the opportunity it should first check
	the price of the product, if it is &gt; 10008 then it should be inserted otherwise it should give an
	error.*/
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
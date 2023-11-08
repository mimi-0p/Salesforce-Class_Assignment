public class accountTriggerHandler {
    public static void onAfterInsert(List<Account> newvalues){
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        Set<Id> accountIds = new Set<Id>();
		for (Account acc : newvalues) {
            accountIds.add(acc.Id);
        }
    	List<Opportunity> existingOpportunities = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accountIds];
        Map<Id, Opportunity> accountIdToOpportunityMap = new Map<Id, Opportunity>();
        for(Opportunity opp : existingOpportunities) {
            accountIdToOpportunityMap.put(opp.AccountId, opp);
        }
    	for(Account acc : newvalues){
           if (!accountIdToOpportunityMap.containsKey(acc.id)){
               Opportunity newOpportunity = new Opportunity();
               newOpportunity.Name = 'First Opportunity with ' + acc.Name;
               newOpportunity.AccountId = acc.Id;
               newOpportunity.StageName = 'Prospecting'; 
               newOpportunity.CloseDate = Date.today().addDays(30); 
               opportunitiesToInsert.add(newOpportunity);
            }
        }
        insert opportunitiesToInsert;
    }
    public static void onBeforeDelete(List<Account> oldvalues){
        system.debug(oldvalues);
        set<id> accidwithopp = new set<id>();
        list<Opportunity> oppnew =[select id,AccountId,StageName from opportunity where AccountId in :oldvalues];
        system.debug(oppnew);
        for(Opportunity opp : oppnew){
            if (opp.StageName != 'Closed Won' && opp.StageName != 'Closed Lost') {
            accidwithopp.add(opp.AccountId);
        	}
      	}
        for (Account acc : oldvalues) {
            if(accidwithopp.contains(acc.id))
                acc.addError('Cannot delete account ' + acc.Name + ' as it has open opportunities.');
         }
     }
    //recursion trigger
    /*public static void insertAcc(){
        Account acc = new Account();
        acc.name='test1234';
        acc.MyExtID_c__c='12345678';
        insert acc;
    }*/
}
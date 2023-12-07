public class accountTriggerHandler {
    /*When an account is inserted or updated check whether any opportunity is linked to it or not if
	not then create one whose name is ‘First Opportunity <Account Name>*/
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
    /*Prevent deletion of account if it has any open opportunity related to it, along with an error
	message*/
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
    /*Create a trigger to store the backup of the deleted account&#39;s name and phone number in a
	custom object(Account_backup_c), only when accounts are merged*/
    public static void aftrdlt(){
        list<Account_Backup__c> bkupacc = new list<Account_Backup__c>();
        list<Account> acc =[select id,Name,Phone from Account where MasterRecordId != null and IsDeleted=true All ROWS];
        System.debug(acc);
        for(Account acc1 : acc){
            Account_Backup__c acc2 = new Account_Backup__c();
            acc2.Name = acc1.Name;
            acc2.Phone__c = acc1.Phone;
            bkupacc.add(acc2);
        }
        insert bkupacc;
    }
}
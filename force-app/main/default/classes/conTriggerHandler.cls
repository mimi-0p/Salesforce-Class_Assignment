public class conTriggerHandler {
    public static void countAcc(list<Contact> connew){
        system.debug(+connew);
    	set<Id> accountIdsToUpdate = new set<Id>();
		for (Contact cont : connew) {
            accountIdsToUpdate.add(cont.AccountId);
            system.debug(+accountIdsToUpdate);
        	}
        if (!accountIdsToUpdate.isEmpty()) {
        	List<Account> accountsToUpdate = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIdsToUpdate];
            system.debug(+accountsToUpdate);
			for (Account acct : accountsToUpdate) {
            	acct.Count__c = acct.Contacts.size();
                system.debug(+acct.Count__c);
        		}
			update accountsToUpdate;
    	}
	}
}
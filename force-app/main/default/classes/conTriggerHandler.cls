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
    public Static void conDupnocheck(list<Contact> connew){
        Map<String, Contact> phoneMap = new Map<String, Contact>();
    	Map<String, Contact> mobileMap = new Map<String, Contact>();
        list<Contact> extcon =[Select id,Phone,MobilePhone from Contact];
        for(Contact cont :extcon){
            if(cont.Phone != null) {
                phoneMap.put(cont.Phone, cont);
                }
            if(cont.MobilePhone != null) {
                 mobileMap.put(cont.MobilePhone, cont);
              }
        }
    	for(Contact con : connew) {
            if(con.Phone != null) {
                if(phoneMap.containsKey(con.Phone)) {
                    con.addError('Same number exists in the database. Duplicate number can’t be entered in the system.');
                }
                else if(mobileMap.containsKey(con.Phone)) {
                    con.addError('Same number exists in the database. Duplicate number can’t be entered in the system.');
                }
                else {
                    phoneMap.put(con.Phone, con);
                }
            }
            System.debug(phoneMap);
            if(con.MobilePhone != null) {
                if(mobileMap.containsKey(con.MobilePhone)) {
                    con.addError('Same number exists in the database. Duplicate number can’t be entered in the system.');
                }
                else if(phoneMap.containsKey(con.MobilePhone)) {
                    con.addError('Same number exists in the database. Duplicate number can’t be entered in the system.');
                }
                else {
                    mobileMap.put(con.MobilePhone, con);
                }
            }
            System.debug(mobileMap);
        }
    }
    public static void accCondes(list<Contact> connew){
        Map<Id, List<String>> accountContactMap = new Map<Id, List<String>>();
        for (Contact con : connew) {
            if (con.AccountId != null) {
                if (!accountContactMap.containsKey(con.AccountId)) {
                    accountContactMap.put(con.AccountId, new List<String>());
                }
                accountContactMap.get(con.AccountId).add(con.Description);
            }
        }
        Account acc = [SELECT Id, Description FROM Account WHERE Id = :accountContactMap.keySet()];
        System.debug(acc);
        List<Account> accountsToUpdate = new List<Account>();
        list<String> des = new list<String>();
        for (Id accountId : accountContactMap.keySet()) {
            List<String> contactDescriptions = accountContactMap.get(accountId);
            System.debug(contactDescriptions);
            String combinedDescription = String.join(contactDescriptions, ', ');
            des.add(acc.Description);
            des.add(combinedDescription);
            String comdes =String.join(des, ', ');
            System.debug(comdes);
            acc.Description = comdes;
            accountsToUpdate.add(acc);
        }
        System.debug(accountsToUpdate);
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
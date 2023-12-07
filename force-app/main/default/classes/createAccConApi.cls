@RestResource(urlMapping ='/createAccCon/')
global class createAccConApi {
     @httppost
    global static String myMethod(){
        RestRequest req = RestContext.request;
        String str = req.requestBody.toString();
        accConWrapperclass obj =accConWrapperclass.parse(str);
        System.debug(obj);
        List<Account> accountsToInsert = new List<Account>();
		List<Contact> contactsToInsert = new List<Contact>();
        for (accConWrapperclass.Accounts accData : obj.accounts) {
            Account acc = new Account(Name = accData.Name);
            accountsToInsert.add(acc);
        }
        System.debug(accountsToInsert);
        insert accountsToInsert;
        Map<String, Id> accountMap = new Map<String, Id>();
        for (Account acc : accountsToInsert) {
            accountMap.put(acc.Name, acc.Id);  
        }
        System.debug(accountMap);
        for (accConWrapperclass.Accounts accData : obj.accounts) {
            Id accId = accountMap.get(accData.Name);
            for (accConWrapperclass.Contacts conData : accData.Contacts) {
                Contact con = new Contact(
                    FirstName = conData.FirstName,
                    LastName = conData.LastName,
                    Email = conData.Email,
                    AccountId = accId 
                );
                contactsToInsert.add(con);
            }
        }
        System.debug(contactsToInsert);
		insert contactsToInsert;
       	return 'success';
    }
}
public class dmlAssignmentQ7 {
	public static void method1() {
        List<Account> insertedAccounts = new List<Account>();
        for(Integer i=0; i<5; i++) {
            Account newAccount = new Account();
            newAccount.Name = 'Account Test' + i;
            insertedAccounts.add(newAccount);
        }
        Database.SaveResult[] accountInsertResults = Database.insert(insertedAccounts);
        system.debug(accountInsertResults);
        List<Contact> insertedContacts = new List<Contact>();
        List<Opportunity> insertedOpportunities = new List<Opportunity>();
        List<OpportunityLineItem> insertedOpportunityProducts = new List<OpportunityLineItem>();

        for(Database.SaveResult sr : accountInsertResults) {
            if (sr.isSuccess()) {
                Account insertedAccount = insertedAccounts[accountInsertResults.indexOf(sr)];
                Contact newContact = new Contact();
                newContact.FirstName = 'Contact';
                newContact.LastName = 'Test';
                newContact.AccountId = insertedAccount.Id;
                insertedContacts.add(newContact);
                
                Opportunity newOpportunity = new Opportunity();
                newOpportunity.Name = 'Test Opportunity';
                newOpportunity.StageName = 'Prospecting';
                newOpportunity.CloseDate = Date.today() + 30;
                newOpportunity.AccountId = insertedAccount.Id;
                insertedOpportunities.add(newOpportunity);
            }
        }
        Database.SaveResult[] contactInsertResults = Database.insert(insertedContacts);
        system.debug(contactInsertResults);
        Database.SaveResult[] opportunityInsertResults = Database.insert(insertedOpportunities);
        system.debug(opportunityInsertResults);
          for (Opportunity opp : insertedOpportunities) {
            OpportunityLineItem newOpportunityProduct = new OpportunityLineItem();
            newOpportunityProduct.OpportunityId = opp.Id;
            newOpportunityProduct.Quantity = 1;
            newOpportunityProduct.UnitPrice = 100;
            newOpportunityProduct.PricebookEntryId = [SELECT Id FROM PricebookEntry LIMIT 1].Id;                 
            insertedOpportunityProducts.add(newOpportunityProduct);
        }

        Database.SaveResult[] opportunityProductInsertResults = Database.insert(insertedOpportunityProducts);
        system.debug(opportunityProductInsertResults);
    }
}
public with sharing class accountConOptController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, (SELECT Id, Name FROM Contacts), (SELECT Id, Name FROM Opportunities)
            FROM Account LIMIT 10 ];
    }

    @AuraEnabled
    public static void deleteOpportunity(Id opportunityId) {
        delete new Opportunity(Id = opportunityId);
    }

    @AuraEnabled
    public static void deleteContact(Id contactId) {
        delete new Contact(Id = contactId);
    }

    @AuraEnabled
    public static void deleteAccount(Id accountId) {
        delete new Account(Id = accountId);
    }
}
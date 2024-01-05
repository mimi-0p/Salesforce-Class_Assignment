public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccountContacts(String accountname) {
        system.debug('name'+accountname);
        list<Contact> con =[SELECT Id, FirstName, LastName, Email,Phone,Name  FROM Contact WHERE Account.Name = :accountname];
        system.debug('con list'+con);
        return con;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, Email, Phone FROM Contact];
    }
     @AuraEnabled(cacheable=true)
    public static Contact getContactDetails(String contactName) {
        return [SELECT Id, Name, Email, Phone,Account.Name FROM Contact WHERE Name LIKE :contactName LIMIT 1];
    }
}
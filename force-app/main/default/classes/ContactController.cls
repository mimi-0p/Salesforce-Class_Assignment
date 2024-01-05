public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccountContacts(String accountname) {
        system.debug('name'+accountname);
        list<Contact> con =[SELECT Id, FirstName, LastName, Email, Phone,Name  FROM Contact WHERE Account.Name = :accountname];
        system.debug('con list'+con);
        return con;
    }
}
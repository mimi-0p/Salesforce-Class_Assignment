public with sharing class OrderController {
    @AuraEnabled(cacheable=true)
    public static List<New_Order__c> getOrders() {
        
        return [select id,Name,Start_Date__c,End_Date__c,Description__c from New_Order__c LIMIT 10];
    }
}
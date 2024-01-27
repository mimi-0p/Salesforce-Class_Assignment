public with sharing class FeedbackFormController {
    @AuraEnabled(cacheable=true)
    public static List<Question__c> getQuestions() {
        return [SELECT Id, Question_Text__c,Text_area__c,Radio_button__c,Picklist__c,Checkbox__c,Available_Options__c FROM Question__c];
    }

    
}
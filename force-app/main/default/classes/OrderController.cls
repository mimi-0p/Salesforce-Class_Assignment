public with sharing class OrderController {
    @AuraEnabled(cacheable=true)
    public static List<New_Order__c> getOrders() {
        
        return [select id,Name,Start_Date__c,End_Date__c,Description__c from New_Order__c limit 10];
    }
  @AuraEnabled
    public static void updtName(String jsonstrng) {
        System.debug(jsonstrng);
        List<Object> recordsToUpdate = (List<Object>) JSON.deserializeUntyped(jsonstrng);
    	System.debug(recordsToUpdate);
        List<New_Order__c> ordersToUpdate = new List<New_Order__c>();
        for (Object obj : recordsToUpdate) {
        
        if (obj instanceof Map<String, Object>) {
            Map<String, Object> record = (Map<String, Object>) obj;
            String orderId = (String) record.get('Id');
            String newName = (String) record.get('Name');
            New_Order__c order = new New_Order__c() ;
                order.Name = newName;
            	order.Id = orderId ;
                ordersToUpdate.add(order);
            
        }
    }
        
        if (!ordersToUpdate.isEmpty()) {
            update ordersToUpdate;
        }
    }

}
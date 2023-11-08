trigger leadtrigger on Lead (after insert) {
	 if(Trigger.isBefore){
        if(Trigger.isInsert){
            
        }
        if(Trigger.isUpdate){
            
        }
        if(Trigger.isDelete){
            
        }
    }
     if(Trigger.isAfter){
        if(Trigger.isInsert){
            SendSMSTwilio.myMethod(Trigger.New[0].MobilePhone , Trigger.New[0].LastName);
            leadTriggerHandler.beforeandafterinsup(Trigger.new); 
        }
        if(Trigger.isUpdate){
            leadTriggerHandler.beforeandafterinsup(Trigger.new); 
        }
        if(Trigger.isDelete){
            
        }
    }
    
}
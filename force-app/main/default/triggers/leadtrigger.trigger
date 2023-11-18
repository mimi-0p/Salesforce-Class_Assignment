trigger leadtrigger on Lead (after insert,before Insert,Before Update) {
	 if(Trigger.isBefore){
        if(Trigger.isInsert){
            leadTriggerHandler.dupemail(Trigger.new);
        }
        if(Trigger.isUpdate){
            leadTriggerHandler.dupemail(Trigger.new);
        }
        if(Trigger.isDelete){
            
        }
    }
     if(Trigger.isAfter){
        if(Trigger.isInsert){
           // SendSMSTwilio.myMethod(Trigger.New[0].MobilePhone , Trigger.New[0].LastName);
            leadTriggerHandler.beforeandafterinsup(Trigger.new); 
        }
        if(Trigger.isUpdate){
            leadTriggerHandler.beforeandafterinsup(Trigger.new); 
        }
        if(Trigger.isDelete){
            
        }
    }
    
}
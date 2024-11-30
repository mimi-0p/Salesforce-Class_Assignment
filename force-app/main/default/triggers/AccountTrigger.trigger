trigger AccountTrigger on Account (before insert,after insert,after update,before delete,After Delete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            accountTriggerHandler.scenario1(trigger.new);
        }
        if(Trigger.isUpdate){
            accountTriggerHandler.scenario1(trigger.new);
        }
        if(Trigger.isDelete){
               system.debug('test');
            accountTriggerHandler.onBeforeDelete(trigger.old);
         }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            accountTriggerHandler.onAfterInsert(trigger.new);
            
            //accountTriggerHandler.insertAcc();
        }
        if(Trigger.isUpdate){
           accountTriggerHandler.onAfterInsert(trigger.new); 
           
        }
        if(Trigger.isDelete){
           accountTriggerHandler.aftrdlt(); 
        }
    }
}
trigger oppTrigger on Opportunity (before insert,After update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            oppTriggerHandler.beforeinserthandler(trigger.new);
            
            //oppTriggerHandler.beforeinsert(trigger.new);
        }
        if(Trigger.isUpdate){
            oppTriggerHandler.oppbeforeupdt(trigger.new,Trigger.oldMap);
        }
        if(Trigger.isDelete){
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
        }
        if(Trigger.isUpdate){
            oppTriggerHandler.backupOpp(Trigger.new,Trigger.oldMap);
            System.debug('pass');
        }
        if(Trigger.isDelete){
        }
    }
}
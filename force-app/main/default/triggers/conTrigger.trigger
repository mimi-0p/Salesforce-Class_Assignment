trigger conTrigger on Contact (after insert,after update,after delete,after undelete) {
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
           conTriggerHandler.countAcc(Trigger.new);
            
        }
        if(Trigger.isUpdate){
           conTriggerHandler.countAcc(Trigger.new);
        }
        if(Trigger.isDelete){
           conTriggerHandler.countAcc(Trigger.old);
        }
        if(Trigger.isUndelete){
           conTriggerHandler.countAcc(Trigger.new);
        }
    }

}
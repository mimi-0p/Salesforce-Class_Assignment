trigger conTrigger on Contact (before insert,before update,after insert,after update,after delete,after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            conTriggerHandler.conDupnocheck(Trigger.new);
        }
        if(Trigger.isUpdate){
            conTriggerHandler.conDupnocheck(Trigger.new);
        }
        if(Trigger.isDelete){
             
                   
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
           conTriggerHandler.countAcc(Trigger.new);
           conTriggerHandler.accCondes(Trigger.new);
        }
        if(Trigger.isUpdate){
           conTriggerHandler.countAcc(Trigger.new);
           conTriggerHandler.accCondes(Trigger.new);
        }
        if(Trigger.isDelete){
           conTriggerHandler.countAcc(Trigger.old);
        }
        if(Trigger.isUndelete){
           conTriggerHandler.countAcc(Trigger.new);
        }
    }

}
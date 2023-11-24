trigger oppLineItemtrig on OpportunityLineItem (before insert) {
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
            
            
        }
        if(Trigger.isUpdate){
          
        }
        if(Trigger.isDelete){
           
        }
    }

}
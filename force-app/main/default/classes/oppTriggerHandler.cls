public class oppTriggerHandler {
    /*When an opportunity is inserted check for its duplicity on the basis of its name and the
	account to which it is related i.e. If it has the same name and is linked to the same Account
	then append “Duplicate Opportunity” in the name*/
    public static void beforeinserthandler(list<Opportunity> newOpportunities){
        List<String> existingOpportunityNames = new list<String>();
        list<id> existingOpportunityAccid =new list<id>();
    	for (Opportunity opp : newOpportunities) {
            existingOpportunityNames.add(opp.Name);
            existingOpportunityAccid.add(opp.AccountId);
             system.debug(+existingOpportunityAccid);
            system.debug(+existingOpportunityNames);
        	}
    	List<Opportunity> existingOpportunities = [SELECT Id, Name, AccountId FROM Opportunity WHERE Name IN :existingOpportunityNames and AccountId IN :existingOpportunityAccid];
        system.debug(+existingOpportunities);
        Map<String, Opportunity> opportunityMap = new Map<String, Opportunity>();
        for (Opportunity opp : existingOpportunities) {
            opportunityMap.put(opp.Name + opp.AccountId, opp);
            system.debug(+opportunityMap);
        }
        for (Opportunity opp : newOpportunities) {
            String opportunityKey = opp.Name + opp.AccountId;
            if (opportunityMap.containsKey(opportunityKey)) {
                opp.Name = opp.Name + ' (Duplicate Opportunity)';
                system.debug(+opp.Name);
            }
        }
	}
    /*Write a trigger to stop a user from creating an opportunity if he has more than 2 open
	opportunities.*/
    public static void beforeinsert(list<Opportunity> newOpportunities){
        List<Id> accountIds = new List<Id>();
    	for (Opportunity opp : newOpportunities){
        	accountIds.add(opp.AccountId);
    	  }
        system.debug('accids'+accountIds);
		Map<Id, Integer> accountOpportunityCount = new Map<Id, Integer>();
    	list<AggregateResult> opp =[SELECT AccountId, COUNT(Id) FROM Opportunity WHERE AccountId IN :accountIds
                            		AND StageName != 'Closed Won'  AND StageName != 'Closed Lost' GROUP BY AccountId];
        System.debug(+opp);
        for (AggregateResult res : opp) {
        	Id accountI = (id)res.get('AccountId');
    		Integer cou = (integer)res.get('expr0');
            accountOpportunityCount.put(accountI,cou);
    		}
        system.debug('map'+accountOpportunityCount);
        for(Opportunity oppo : newOpportunities){
            if (accountOpportunityCount.containsKey(oppo.AccountId) && accountOpportunityCount.get(oppo.AccountId) >= 2) {
           		oppo.addError('You already have 2 Open opportuity');
        	}
        }
	}
    /*Save the previous details of the opportunity records to *&lt;Opp Name&gt; BackUp’ record
	whenever any changes are being made to any opportunity record.*/
    public static void backupOpp(list<Opportunity> newOpp,map<id,Opportunity> oldOpp){
        System.debug('new tri'+newOpp);
        System.debug('old tri'+oldOpp);
        list<Opportunity> opportunityBackups= new list<Opportunity>();
        for(Opportunity opp : newOpp){
            Opportunity oppold =oldOpp.get(opp.id);
            if(opp.Name !=oppold.Name || opp.StageName != oppold.StageName||opp.CloseDate !=oppold.CloseDate){
                Opportunity backUp =new Opportunity();
                backUp.Name =opp.Name +'Backup';
                backUp.StageName =opp.StageName;
                backUp.CloseDate =opp.CloseDate;
                opportunityBackups.add(backUp);
            }
        }
        insert opportunityBackups;
    }
    /*Whenever Opportunity "Stage" is modified to "Closed Won" then set 
	"Close Date" as "Today Date" and "Type" as "New Customer".*/
    public Static void oppbeforeupdt(list<Opportunity> newOpp,map<id,Opportunity> oldOpp){
        System.debug(newOpp);
        for(Opportunity opp : newOpp){
            if(opp.StageName == 'Closed Won' && oldOpp.get(opp.Id).StageName!='Closed Won'){
                opp.CloseDate =Date.today();
                opp.Type ='New Customer';
            }
        }
    }
    
    
}
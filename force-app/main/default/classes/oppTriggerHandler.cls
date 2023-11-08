public class oppTriggerHandler {
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
}
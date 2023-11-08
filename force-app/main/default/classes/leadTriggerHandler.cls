public class leadTriggerHandler {
    public static void beforeandafterinsup(list<Lead> newlead){
         List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
		
    for (Lead lead1 : newlead) {
        if (lead1.LeadSource == 'Phone Inquiry') {
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(lead1.Id);

            // Set the conversion information
            lc.setConvertedStatus('Closed - Converted');
            lc.setDoNotCreateOpportunity(true); 
            leadConverts.add(lc);
        	}
    	}
	List<Database.LeadConvertResult> lcr = Database.convertLead(leadConverts);
    }
}
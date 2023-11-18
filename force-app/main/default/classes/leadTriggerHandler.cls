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
    /*Write a trigger on lead to prevent duplicate records based on lead email,
	if a record already created with the same Email, Or record is Updated.
	The trigger should throw an error.*/
    public static void dupemail(list<Lead> newl){
        set<String> emailEx =new set<String>();
        List<Lead> duplicateLeads = new List<Lead>();
        for(Lead le : [Select id,Email,Name from Lead where Email !=null]){
            emailEx.add(le.Email);
            System.debug(emailEx);
        }
        for(Lead newLead : newl) {
        if (newLead.Email != null && newLead.Email != '') {
            if (emailEx.contains(newLead.Email)) {
                duplicateLeads.add(newLead);
            } else {
                emailEx.add(newLead.Email);
            }
        }
    }
    System.debug(duplicateLeads);
    if (!duplicateLeads.isEmpty()) {
        for (Lead duplicateLead : duplicateLeads) {
            duplicateLead.Email.addError('A lead with this email already exists. Duplicate leads are not allowed.');
        	}
    	}
   }
}
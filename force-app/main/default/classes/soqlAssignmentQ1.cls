public class soqlAssignmentQ1 {
    public static void method1(date date1,date date2){
        list<Opportunity> opp1 =[SELECT Id, Name, CloseDate FROM Opportunity WHERE 
                                CloseDate >=: date1 AND CloseDate <=: date2  AND Owner.Name = 'Richard D’souza’'];
        for(Opportunity opp2 : opp1){
        system.debug(+opp2);
   		}
  	}
}
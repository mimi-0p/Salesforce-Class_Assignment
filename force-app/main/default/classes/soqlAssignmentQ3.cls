public class soqlAssignmentQ3 {
    public static void method1(){
        map<id,list<Account>> allacc =new map<id,list<Account>>();
        list<Account> acc2 =[Select id,Name,AnnualRevenue from Account ];
        for(Account acc1 : acc2){
            allacc.put(acc1.id,new list<Account>());
            allacc.get(acc1.id).add(acc1);
        }
        System.debug(allacc);
    }

}
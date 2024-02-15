public with sharing  class AccountController {
    @AuraEnabled(cacheable=true)
     public static List<Account> getAccounts(){
         return [select id,Name,Phone from Account limit 10];
     }
}
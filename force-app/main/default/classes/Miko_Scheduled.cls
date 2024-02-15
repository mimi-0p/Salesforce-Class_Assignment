global class Miko_Scheduled Implements Schedulable
    {
        global void execute(SchedulableContext sc)
        {
            setToMiko();
        }

        public void setToMiko()
        {
            List<Account> listAccounts = new List<Account>();
            //listAccounts = [SELECT ID,Tenant_Name__C FROM Account WHERE Tenant_Name__C = null];

            for(Account acc : listAccounts)
            {
                //acc.Tenant_Name__C = 'Miko';
            }

            update listAccounts;
        }
    }
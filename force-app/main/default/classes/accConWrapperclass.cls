public class accConWrapperclass {
    public List<Accounts> accounts;

	public class Contacts {
		public String FirstName;
		public String LastName;
		public String Email;
	}

	public class Accounts {
		public String Name;
        public String extid;
		public List<Contacts> Contacts;
	}

	
	public static accConWrapperclass parse(String json) {
		return (accConWrapperclass) System.JSON.deserialize(json, accConWrapperclass.class);
	}

}
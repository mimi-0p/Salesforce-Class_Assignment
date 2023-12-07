public class studentWrappercls {
    public List<Student> student;

	public class Student {
		public String Name;
		public String Email;
	}

	
	public static studentWrappercls parse(String json) {
		return (studentWrappercls) System.JSON.deserialize(json, studentWrappercls.class);
	}

}
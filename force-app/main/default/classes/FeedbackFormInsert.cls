public class FeedbackFormInsert {
      public class MapData {
        public String key;
        public String value;
    }
	@AuraEnabled
    public static void insertData(String jsonString) {
    Decimal no = 1;
    List<Feedback__c> datins = new List<Feedback__c>();
    System.debug(jsonString);
    List<MapData> mapDataList = (List<MapData>)JSON.deserialize(jsonString, List<MapData>.class);
    
    for (MapData data : mapDataList) {
        System.debug('Key: ' + data.key);
        System.debug('Value: ' + data.value);
        Feedback__c fed = new Feedback__c();
        fed.Name = 'Question' + no;
        fed.Answer__c = data.value;
        fed.Question__c = data.key;
        datins.add(fed);
        no = no + 1;
    }

    System.debug(datins);
    insert datins;
}
    
}
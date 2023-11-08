public class SendSMSTwilio {
	@future(Callout=true)
    public static void myMethod(String phn,String lastName){
       	HTTPRequest req=new HTTPRequest();
        req.setEndPoint('https://api.twilio.com/2010-04-01/Accounts/AC93b5035d051a3f2ae5567ea53f7ac513/Messages.json');
        req.setMethod('POST');
        Blob b=Blob.valueOf('AC93b5035d051a3f2ae5567ea53f7ac513:350abafd2318acc395b1e30b823e892f');
        String token=EncodingUtil.base64Encode(b);
        req.setHeader('Authorization','Basic '+token);
        String str='From='+ EncodingUtil.UrlEncode('+12566454829','UTF-8') +'&To='+EncodingUtil.UrlEncode(phn,'UTF-8')+'&Body='+EncodingUtil.UrlEncode('Hello, '+lastName,'UTF-8');
        req.setBody(str);
        HTTPResponse res=new HTTPResponse();
        Http ht=new Http();
        res=ht.send(req);
        System.debug(res);    
    }
}
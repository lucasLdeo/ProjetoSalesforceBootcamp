@isTest
public class CalloutToMarvelTeste {
    
    @isTest
    public static void testaCalloutStatus(){
        List<Integer> TesteStatus = new List<Integer>{200,400,500};
            for (Integer status : TesteStatus){
                CalloutToMarvelMock mock = new CalloutToMarvelMock(status);
                Test.setMock(HttpCalloutMock.class, mock);        
                CalloutToMarvel.getPersonagens();
            }        
    }    
    @isTest
    public static void testaCalloutSucesso(){      
        CalloutToMarvelMock mock = new CalloutToMarvelMock(200);
        Test.setMock(HttpCalloutMock.class, mock);        
        CalloutToMarvel.getPersonagens();
        
    }
}
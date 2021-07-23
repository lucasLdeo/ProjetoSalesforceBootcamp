public class HabilidadeContatoTriggerHandler {    
    HabilidadeContatoTriggerHelper helper = new HabilidadeContatoTriggerHelper();
    public void onAfterInsert(List <HabilidadeContato__c> newRecords){       
       helper.atualizaRankingInsert(newRecords); 
    }     
    public void onAfterUpdate(List <HabilidadeContato__c> newRecords, Map<Id,HabilidadeContato__c> oldRecords){ 
       helper.atualizaRankingUpdate(newRecords, oldRecords);
    }
    public void onBeforeDelete(List<HabilidadeContato__c> oldRecords){ 
       helper.atualizaRankingDelete(oldRecords);
    } 

}
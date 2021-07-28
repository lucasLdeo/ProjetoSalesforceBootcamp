public with sharing class AlocacaoBatalhaController {    
    @AuraEnabled    
    public static List<BatalhaDoContato__c> getBatalhas(){
        return [SELECT Id,Contato__r.NomeDeGuerra__c, Contato__r.RecordType.Name, Batalha__r.Name  FROM BatalhaDoContato__c LIMIT 100];
    }
}

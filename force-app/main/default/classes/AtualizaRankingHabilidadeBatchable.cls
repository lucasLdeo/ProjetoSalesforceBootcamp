public with sharing class AtualizaRankingHabilidadeBatchable implements Database.Batchable<SObject> {
    public AtualizaRankingHabilidadeBatchable(){    
    }
    
    public AtualizaRankingHabilidadeBatchable(Integer minutes){
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Contato__c FROM HabilidadeContato__c ALL ROWS'
        );
    }

    public void execute(Database.BatchableContext bc, List<HabilidadeContato__c> records){
       Set<Id> idsContato = new Set<Id>(); 
       for(HabilidadeContato__c habilidadeContato : records){
       		idsContato.add(habilidadeContato.Contato__c);
       }       
       
       HabilidadeContatoBO.getInstance().atualizaRanking(idsContato); 
    }
    
    public void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        
        System.debug('>>>>>>> JOB: ' + job);
    }
}
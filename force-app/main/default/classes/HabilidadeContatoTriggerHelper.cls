public class HabilidadeContatoTriggerHelper {
	public void atualizaRankingUpdate(List <HabilidadeContato__c> newRecords, Map <Id,HabilidadeContato__c> oldRecords){
    	List <HabilidadeContato__c> abiliitysAtt = new List<HabilidadeContato__c>();
        
        System.debug('newRecords>>>>'+newRecords);
        System.debug('oldRecords>>>>'+oldRecords);
        for (HabilidadeContato__c abiliity : newRecords ){
             HabilidadeContato__c oldabiliity = oldRecords.get(abiliity.Id);

            if ( oldabiliity != null && abiliity.Level__c != oldabiliity.Level__c){
            	abiliitysAtt.add(abiliity);                                          
            }			            
        }
        if(! abiliitysAtt.isEmpty()){
            Set<Id> idContatosDaHabilidade = new Set<Id>();
            for (HabilidadeContato__c abili : abiliitysAtt){
                idContatosDaHabilidade.add(abili.Contato__c);              
            }
            HabilidadeContatoBO.getInstance().AtualizaRanking(idContatosDaHabilidade);
        }
    }
    
    public void atualizaRankingInsert(List <HabilidadeContato__c> newRecords){        
        Set<Id> idContatosDaHabilidade = new Set<Id>();
        for (HabilidadeContato__c abili : newRecords){
            idContatosDaHabilidade.add(abili.Contato__c);                
        }        
        if (!idContatosDaHabilidade.isEmpty()){
            HabilidadeContatoBO.getInstance().AtualizaRanking(idContatosDaHabilidade);
        }        
    }
    public void atualizaRankingDelete(List<HabilidadeContato__c> oldRecords){        
        Set<Id> idContatosDaHabilidade = new Set<Id>();
        for (HabilidadeContato__c abili : oldRecords){
            System.debug('oldRecords>>'+oldRecords);
            idContatosDaHabilidade.add(abili.Contato__c);                
        }        
        if (!idContatosDaHabilidade.isEmpty()){
            Map<Id,Contact> mapContatosDaHabilidade = new Map<Id,Contact>([SELECT Id, 
                                                                             		(SELECT Id, Name, Level__c 
                                                                              		 FROM HabilidadesContato__r 
                                                                                     WHERE Level__c != null AND Id NOT IN :oldRecords
                                                                                     ORDER BY Level__c DESC) 
                                                                             FROM Contact 
                                                                             WHERE Id in : idContatosDaHabilidade]);
            
            if (!mapContatosDaHabilidade.isEmpty()){
                List<HabilidadeContato__c> newRankinHabilidadeContato = new List<HabilidadeContato__c>();
                for(Contact contato : mapContatosDaHabilidade.values())
                {
                    if(!contato.HabilidadesContato__r.isEmpty())
                    {
                        Integer posicao = 1;
                        for(HabilidadeContato__c habilidadeContato : contato.HabilidadesContato__r)
                        {                            
                            habilidadeContato.Ranking__c = posicao++;
                            newRankinHabilidadeContato.add(habilidadeContato);
                        }
                    }
                }                            
                update newRankinHabilidadeContato; 
            }
        }
    }
}
public class HabilidadeContatoBO {
    

    private static final HabilidadeContatoBO instance = new HabilidadeContatoBO();

    private HabilidadeContatoBO(){

    }
    
    public static HabilidadeContatoBO getInstance(){
        return instance; 
    }

    public void AtualizaRanking(Set<Id> idContatosDaHabilidade){
  
            Map<Id,Contact> mapContatosDaHabilidade = new Map<Id,Contact>([SELECT Id, 
                                                                             		(SELECT Id, Name, Level__c 
                                                                              		 FROM HabilidadesContato__r 
                                                                                     WHERE Level__c != null 
                                                                                     ORDER BY Level__c DESC) 
                                                                             FROM Contact 
                                                                             WHERE Id in : idContatosDaHabilidade]);
            
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
public class ContactTriggerHelper {
    //Chamado pela trigger toda vez que é cadastrado um vilão.

    public static final Set<String> Status_Aceitavel_Do_candidado = new  Set<String>{'Aprovado Direto','Aprovado no Treinamento'};

    public static void criaTarefaParaEncontrarFraquezas(List<Contact> newRecords){
        List<Task> taskToInsert = new List<Task>();                
        for(Contact contato: newRecords ){
            if (contato.RecordTypeId == Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Vilao').getRecordTypeId()){
                Task tarefa = new Task();
                tarefa.Subject = 'Descobrir fraqueza do vilão';
                tarefa.OwnerId = contato.OwnerId;
                tarefa.WhoId = contato.Id;
                tarefa.Status = 'Open';
               taskToInsert.add(tarefa);
            }            
        }
         if (! taskToInsert.isEmpty()){
            insert taskToInsert;
        }
    }	
    public static void naoPermiteApagarQuandoExisteTaskEmAberto(List<Contact> oldRecords, Map<Id,Contact> oldMap){                
        System.debug('oldRecords >>>> '+oldRecords);
        for( Contact contato : oldRecords){
            System.debug('contato >>>> '+contato);
            oldMap.get( contato.Id ).addError('Não é possível deletar contatos com tarefas pendentes ');            
        }
    }
    public static void InsereDataDeAtualizacaoDoHeroi(List<Contact> newRecords, Map<Id,Contact> oldMap){                                        
        System.Debug('Atualizando os dados ');
        List<Contact> ContatosRelatorio = new List<Contact>();
        if(newRecords != null){
            for(Contact contato : newRecords){            
                Contact oldContato = oldMap.get(contato.Id);
                if ((oldContato != null || oldContato.StatusDoCandidato__c != contato.StatusDoCandidato__c ) && 
                Status_Aceitavel_Do_candidado.contains(contato.StatusDoCandidato__c)
                ){
                    contato.DataDaAprovacao__c = Datetime.Now();
                    Contato.ResponsavelAprovacao__c = UserInfo.getUserId();

                    if (contato.StatusDoCandidato__c == 'Aprovado Direto'){
                        contato.FeedbackTreinamento__c = 'Senhor Pica da Galáxias';
                    }

                }                
            }            
        }
    }
}
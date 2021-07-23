public class ContactTriggerHelper {
    
    public static void criaTarefaParaEncontrarFraquezas(List<Contact> newRecords){
        List<Task> taskToInsert = new List<Task>();        
        for(Contact contato: newRecords ){
            if (contato.RecordTypeId == Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Vilao').getRecordTypeId()){
                Task tarefa = new Task();
                tarefa.Subject = 'Descobri fraqueza do vilão';
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
        List< Task> tasks = [SELECT id, status, WhoiD FROM Task WHERE whoId IN :oldRecords and Status != 'Completed'];       
        for( Task tarefa : tasks){
             oldMap.get(tarefa.whoId).addError('Não é possível deletar contatos com tarefas em aberto!!');            
        }                   
    }
}
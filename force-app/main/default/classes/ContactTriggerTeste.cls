@isTest
public class ContactTriggerTeste {
	
    @testSetup
    public static void setup(){
        Contact Thanos = new Contact(LastName ='Test Thanos',RecordTypeId='0125e000000MsVAAA0' ,NomeDeGuerra__c='Test thanos', StatusDoCandidato__c = 'Em Análise');		
        insert Thanos;
    }
        
    @isTest
    public static void verificaTask(){
        List<Contact> contato = [Select Id FROM Contact WHERE LastName ='Test Thanos'];                        
		List<Task> tarefas = [Select Id FROM Task WHERE Subject = 'Descobri fraqueza do vilão' AND Status ='Open' ];           
        System.assertEquals(1,tarefas.size());        
        System.debug('contato depois '+contato);
        delete contato;         
        contato = [Select Id FROM Contact WHERE LastName ='Test Thanos'];  
        System.debug('contato depois '+contato);
        System.assertEquals(1,contato.size());
    }          
}
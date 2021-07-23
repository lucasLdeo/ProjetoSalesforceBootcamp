@istest
public class ContactCreatTaskTeste {
  
    @testSetup
    public static void setup(){    
     	Contact Hulk = new Contact(LastName ='Test hulk'  ,NomeDeGuerra__c='Test hulk', StatusDoCandidato__c = 'Em Análise');
        Contact Capita = new Contact(LastName ='Test capitã 2 ',NomeDeGuerra__c='Test capitã 2', StatusDoCandidato__c = 'Em Análise');  
       	List <Contact> contatos = new List<Contact>();
        contatos.add(Hulk);
        contatos.add(Capita);
        insert contatos;
        System.debug('contatos>>'+contatos);
        Habilidade__c forte = new Habilidade__c(Name ='Forte');
        Habilidade__c verde = new Habilidade__c(Name ='verde');
        List <Habilidade__c> habilidade = new List<Habilidade__c>(); 
        habilidade.add(forte);
        habilidade.add(verde);
        insert habilidade;
        System.debug('habilidade>>'+habilidade);
        
        
        HabilidadeContato__c hab1 = new HabilidadeContato__c();
        hab1.Contato__c = Hulk.Id;
        hab1.Habilidade__c = forte.Id;        
        HabilidadeContato__c hab2 = new HabilidadeContato__c();
        hab2.Contato__c = Hulk.Id;
        hab2.Habilidade__c = verde.Id;
        HabilidadeContato__c hab3 = new HabilidadeContato__c();
        hab3.Contato__c = Capita.Id;
        hab3.Habilidade__c = forte.Id;
        
        List<HabilidadeContato__c> habilidades = new List<HabilidadeContato__c>();
        habilidades.add(hab1);
        habilidades.add(hab2);
        habilidades.add(hab3);        
        insert habilidades;   
        System.debug('habilidades>>'+habilidades);
    }
	
    @isTest 
    public static void TestNewTaskForContact() {  
       
        List<Contact> contatos = [SELECT Id FROM Contact WHERE StatusDoCandidato__c = 'Em Análise'];
        
        for(Contact contato : contatos){
            contato.StatusDoCandidato__c = 'Aprovado direto';
        }
        
        update contatos;
        
        List <Task> tarefas = [SELECT Id,Subject,Description from Task]; 
        
        system.assertEquals(2, tarefas.size());
        system.assertEquals('Alocar contato em batalha', tarefas[0].Subject);
           

   		System.debug('Tarefas >>'+ tarefas);       	
    }
}
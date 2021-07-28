@istest
public class AtualizaRankigTriggerTest {	    
    @testSetup
     public static void setup(){    
         
         Contact Hulk = new Contact(LastName ='Test hulk'  ,NomeDeGuerra__c='Test hulk', StatusDoCandidato__c = 'Em Treinamento');
         Contact Capita = new Contact(LastName ='Test capitã 2 ',NomeDeGuerra__c='Test capitã 2', StatusDoCandidato__c = 'Em Treinamento');  
         List <Contact> contatos = new List<Contact>();
         contatos.add(Hulk);
         contatos.add(Capita);
         insert contatos;         
         Habilidade__c forte = new Habilidade__c(Name ='Forte');
         Habilidade__c verde = new Habilidade__c(Name ='verde');
         List <Habilidade__c> habilidade = new List<Habilidade__c>(); 
         habilidade.add(forte);
         habilidade.add(verde);
         insert habilidade;                      
         HabilidadeContato__c hab1 = new HabilidadeContato__c();
         hab1.Contato__c = Hulk.Id;
         hab1.Habilidade__c = forte.Id;
         hab1.Level__c = 80; 
         HabilidadeContato__c hab2 = new HabilidadeContato__c();
         hab2.Contato__c = Capita.Id;
         hab2.Habilidade__c = forte.Id;
         hab2.Level__c = 100; 
         HabilidadeContato__c hab3 = new HabilidadeContato__c();
         hab3.Contato__c = Hulk.Id;
         hab3.Habilidade__c = verde.Id;
         List<HabilidadeContato__c> habilidades = new List<HabilidadeContato__c>();
         habilidades.add(hab1);
         habilidades.add(hab2);
         habilidades.add(hab3); 
         insert habilidades;     	
     }
    @isTest 
    public static void TesteInserir() {  
        
        List<HabilidadeContato__c> habilidadesContato = [SELECT Id, NomeHabilidade__c, Ranking__c, Contato__r.NomeDeGuerra__c 
                                                         FROM  HabilidadeContato__c                                                          
                                                         WHERE Ranking__c != null];        
        for (HabilidadeContato__c habilidade : habilidadesContato){
        	system.assertEquals(1, habilidade.Ranking__c);    
        }
        system.assertEquals(2, habilidadesContato.size());                
    }
    
    
    @isTest
    public static void TesteUpdate() {  
        
        List<HabilidadeContato__c> habilidadesContato = [SELECT Id, NomeHabilidade__c, Ranking__c, Contato__r.NomeDeGuerra__c 
                                                         FROM  HabilidadeContato__c];
        
        List<Contact> hulk = [SELECT Id FROM Contact where NomeDeGuerra__c = 'Test hulk' LIMIT 1];
        for (HabilidadeContato__c habilidade : habilidadesContato){             
            if (habilidade.Contato__c == hulk[0].Id && habilidade.NomeHabilidade__c == 'verde'){                
                habilidade.Level__c = 100;
            }                
        }
        
        update habilidadesContato;
        
        List<HabilidadeContato__c> NewhabilidadesContato = [SELECT Id, NomeHabilidade__c, Ranking__c, Contato__r.NomeDeGuerra__c 
                                                         FROM  HabilidadeContato__c];
        system.assertEquals(3, habilidadesContato.size());
        for (HabilidadeContato__c habilidade : NewhabilidadesContato){
            if (habilidade.Contato__r.NomeDeGuerra__c == 'Test hulk' && habilidade.NomeHabilidade__c == 'verde'){
                system.assertEquals(1, habilidade.Ranking__c);
            }                
        }
    }
    
    @isTest
    public static void TesteDelete() {  
        
        List<HabilidadeContato__c> habilidadesContato = [SELECT Id, NomeHabilidade__c, Ranking__c, Contato__r.NomeDeGuerra__c                                                          FROM  HabilidadeContato__c];
        List<Contact> hulk = [SELECT Id FROM Contact where NomeDeGuerra__c = 'Test hulk' LIMIT 1];
        
        List<HabilidadeContato__c> habilidadesdel = new List<HabilidadeContato__c>();
        
        for (HabilidadeContato__c habilidade : habilidadesContato){                          
            if (habilidade.Contato__c == hulk[0].Id && habilidade.NomeHabilidade__c == 'verde'){                 
            	habilidadesdel.add(habilidade);               
            }                      
        }
        
        delete habilidadesdel;
               
        List<HabilidadeContato__c> NewhabilidadesContato = [SELECT Id, NomeHabilidade__c, Ranking__c, Contato__r.NomeDeGuerra__c 
                                                         FROM  HabilidadeContato__c];                
         for (HabilidadeContato__c Newhabilidade : NewhabilidadesContato){             
            if (Newhabilidade.Contato__r.NomeDeGuerra__c == 'Test hulk'){
                System.debug('Newhabilidade'+Newhabilidade);
                system.assertEquals(1, Newhabilidade.Ranking__c);
            }                
        }
    }
}
public class MostraCallout {
	
    
    public static void criaOuAtualizaLeads(){                   
        Lead lead = new Lead();
        lead.Company = 'Marvel API';	
        lead.NomeDeGuerra__c = 'Criado por mim';            
        lead.Description = 'Heroi';             
        lead.LastName = 'Nome do Heroi';
        insert lead;
                
        CalloutToMarvel.getPersonagens();
    }
    
}
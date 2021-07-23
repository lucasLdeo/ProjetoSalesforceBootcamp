public class EstudoSOQL {
	public static List<Contact> getAllContacts(){
        List<Contact> contatos = [SELECT Id, Name FROM Contact];
		return contatos;
				 
    }
    
    public static Contact getContactById(Id contactId){       
        
        List<Contact> contatos = [SELECT Id, Name, NomeDeGuerra__c, (SELECT Id, Habilidade__r.Name, Level__c FROM HabilidadesContato__r) FROM Contact WHERE Id = :contactId LIMIT 1];
        if(!contatos.isEmpty()){
            Contact contato = contatos.get(0);
            
            
            return contato;
        }else{
            return null;
        }
        
        
    }
    
    public static Map<String, Decimal> getAvgByContact(){
        AggregateResult[] results = [SELECT Contato__r.NomeDeGuerra__c NomeDeGuerra, AVG(Level__c) mediaLevel 
                                     FROM HabilidadeContato__c 
                                     GROUP BY Contato__r.NomeDeGuerra__c 
                                     HAVING AVG(Level__c) > 0 
                                     ORDER BY AVG(Level__c) DESC];
        
        Map<String, Decimal> mapa = new Map<String, Decimal>();
        
        for(AggregateResult agResult : results){
            String nomeGuerra = (String) agResult.get('NomeDeGuerra');
            Decimal mediaLevel = (Decimal) agResult.get('mediaLevel');
            mapa.put(nomeGuerra, mediaLevel);
        }
           
        return mapa;
    }
    
    
    public static List<HabilidadeContato__c> getHabilidadesPorContatoOrHabilidade(String nomeDeGuerra, String nomeHabilidade){               
        String query = 'SELECT Id, NomeHabilidade__c, Level__c, Contato__r.NomeDeGuerra__c FROM HabilidadeContato__c WHERE ';
        
        if(!String.isEmpty(nomeDeGuerra)){
            query += ' Contato__r.NomeDeGuerra__c = :nomeDeGuerra';
        }else{
            query += ' Habilidade__r.Name = :nomeHabilidade';
        }
        
        List<HabilidadeContato__c> habilidadesDoContato = Database.query(query);      
        return habilidadesDoContato;
    }
    
	//Para estudar, algumas ótimas funções de consulta 
    //SELECT Id, Contato__r.NomeDeGuerra__c, Habilidade__r.Name, Level__c FROM HabilidadeContato__c WHERE Contato__c in ('0035e00000AOIDeAAP', '0035e00000AOZPCAA5') 
    //SELECT Id, Habilidade__c, Habilidade__r.Name, Level__c FROM HabilidadeContato__c WHERE Contato__c = '0035e00000AOIDeAAP' 
    //SELECT Id, (SELECT Id, Habilidade__r.Name FROM HabilidadesContato__r) FROM Contact WHERE Id = '0035e00000AOIDeAAP'    
    //SOSL -> FIND {Clone OR Ler} IN ALL FIELDS RETURNING Contact(FirstName, NomeDeGuerra__c),Habilidade__c(Name) 
}
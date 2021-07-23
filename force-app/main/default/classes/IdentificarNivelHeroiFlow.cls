global class IdentificarNivelHeroiFlow {

    @InvocableMethod(label = 'Identifica Nivel do Heroi')
    public static List<Contact> identificaNivelHeroi(List<contactRequest> requests){
        
        List<Contact> contatos = new List<Contact>();
        
        for(contactRequest request : requests){
            Decimal media = 0;
            Decimal somaLevel = 0; 
            
            for(HabilidadeContato__c habilidadeContato : request.habilidadesContato){
                somaLevel += habilidadeContato.Level__c;
            }
            
            media = somaLevel/request.habilidadesContato.size();
            
            String nivel = '';
            if(media >= 80){
            	nivel = 'Sênior'; 	   
            }else if(media >= 40){
                nivel = 'Pleno';
            }else{
                nivel = 'Júnior';
            }                                 
            //contatos.add(new Contact(Id=request.contactId, nivelDoHeroi__c=nivel));
            
            request.contact.NivelDoHeroi__c = nivel;
            contatos.add(request.contact);
        }
        
        update contatos;
		return contatos;        
    }
    
    global class contactRequest{
        @InvocableVariable(required=true)
        global Contact contact;
        @InvocableVariable(required=true)
        global List<HabilidadeContato__c> habilidadesContato;
    }
    
}

//Para brincar no Anonymous window
//Buscar uma Lista de objetos e converter para Map

//List<Contact> contatos = [SELECT Id, Name, NomeDeGuerra__c FROM Contact];

//Primeira opção de converter uma lista de contatos para um map 
//Map<Id, Contact> mapContact = new Map<Id, Contact>();
//for(Contact contato : contatos){
   // mapContact.put(contato.Id, contato);
//}

//opção mais rápida/prática
//Map<Id, Contact> mapContact = new Map<Id, Contact>([SELECT Id, Name, NomeDeGuerra__c FROM Contact LIMIT 4]);
//system.debug('mapContact: ' + mapContact);
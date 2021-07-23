public class EstudoDML {
    public static void mainDML(){
        
        List <Contact> contatos = new List<Contact>();
        
        
        Contact contato1 = new Contact( 
        	firstName = 'Contato 1',
        	lastName = 'Marvel clone 0',
            NomeDeGuerra__c = 'CLONE ETAPA UPDATE 0'        
        );
        Contact contato2 = new Contact( 
        	firstName = 'Contato 2',
        	lastName = 'Marvel',
            NomeDeGuerra__c = 'Goku 3'
        
        );
        Contact contato3 = new Contact( 
        	firstName = 'Contato 3',
        	lastName = 'Marvel Mr Satan',
            NomeDeGuerra__c = 'Mr Satan'
        
        );
        
        contatos.add(contato1);
        contatos.add(contato2);
        contatos.add(contato3);
        
        //insertContact(contatos, True);  
        /*     
        List<Contact> contactsToday = [Select Id,NomeDeGuerra__c, firstname, lastname from Contact where createddate= today];
        System.debug('contatos'+contactsToday);
        for( Integer i=0; i<contactsToday.size(); i++ ){
            contactsToday[i].NomeDeGuerra__c = 'CLONE ETAPA UPDATE'+i;            
        }
		*/
        //updateContact(contactsToday, true);
        //upsertContact(contatos,false);
      	//deleteContact(contactsToDelete,False);
        List <Contact> contacts = [Select Id,NomeDeGuerra__c, firstname, lastname from Contact where createddate= today AND NomeDeGuerra__c LIKE 'Goku%'];
      	System.debug('>>>> contactsToDelete ::'+contacts);
        mergeContacts(contacts[0],contacts[1],true);
    }
    
    public static void mergeContacts(Contact ctt1, Contact ctt2, Boolean dbMethod ){
		  if (dbMethod){ //False -> parcial | Treu -> Geral
            Database.mergeResult results = Database.merge(ctt1,ctt2,false);
            System.debug ('>>> mergeContacts ::'+ results);
        }else{
        	merge ctt1 ctt2;            
        }
    
    }
    
    public static void undeleteContact(List<Contact> contatos, Boolean dbMethod){
        
        if (dbMethod){
            Database.UndeleteResult[] results = Database.undelete(contatos ,false);
            
        }else{
        	undelete contatos;
            System.debug ('>>> contatos ::'+ contatos);
        }
    }
    
    public static void deleteContact(List<Contact> contatos, Boolean dbMethod){
        
        if (dbMethod){
            Database.DeleteResult[] results = Database.delete(contatos,false);
            
        }else{
        	delete contatos;
            System.debug ('>>> contatos ::'+ contatos);
        }
    }
    
    public static void upsertContact(List<Contact> contatos, Boolean dbMethod){
        
        if (dbMethod){
            Database.UpsertResult[] results = Database.upsert(contatos,Contact.NomeDeGuerra__c, false);
            trataUpsertResult(results);
        }else{
        	upsert contatos Contact.NomeDeGuerra__c;
            System.debug ('>>> contatos ::'+ contatos);
        }
    }
    
    public static void insertContact(List<Contact> contatos, Boolean dbMethod){
        
        if (dbMethod){
            Database.SaveResult[] results = Database.insert(contatos, false);
            trataResult(results);
        }else{
        	insert contatos;
            System.debug ('>>> contatos ::'+ contatos);
        }
    }
    
    public static void updateContact(List<Contact> contatos, Boolean dbMethod){
        
        if (dbMethod){
            Database.SaveResult[] results = Database.update(contatos, false);
            trataResult(results);
        }else{
        	update contatos;
            System.debug ('>>> contatos ::'+ contatos);
        }
    }
    
    public static void trataResult(Database.SaveResult[] results){
        for (Database.SaveResult result : results){
            if (result.isSuccess()){
                System.debug('Sucesso Id do registro  '+result.getId());
            }else{
                for (Database.Error erro : result.getErrors()){
                    System.debug('Deu erro, erro foi:  ' +erro.getStatusCode() + ' : '+erro.getMessage());
                }
                
            }
        }
        
        
    }
    
    public static void trataUpsertResult(Database.upsertResult[] results){
        for (Database.upsertResult result : results){
            if (result.isSuccess()){
                System.debug('Sucesso Id do registro  '+result.getId());
            }else{
                for (Database.Error erro : result.getErrors()){
                    System.debug('Deu erro, erro foi:  ' +erro.getStatusCode() + ' : '+erro.getMessage());
                }
                
            }
        }                
    }
}
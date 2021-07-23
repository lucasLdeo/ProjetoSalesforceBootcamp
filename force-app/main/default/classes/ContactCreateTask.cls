global class ContactCreateTask {
    
    @InvocableMethod(label = 'Cria Tarefa para o Contato')
    public static void ContactCreateTask( List<CreateTaskRequest> requests ){
        
        List<Id> lstContactIds = new List<Id>();
        for( CreateTaskRequest request : requests )
            lstContactIds.add(request.contactId);
        
        System.debug('>>> lstContactIds'+lstContactIds);
        List<HabilidadeContato__c> lstHabContatos = [select Id, Contato__c, Habilidade__r.Name from HabilidadeContato__c WHERE Contato__c IN :lstContactIds ];
        
		System.debug('>>> lstContactIds'+lstContactIds);        
        
        Map<Id, List<String>> mapContatoHabilidades = new Map<Id, List<String>>(); 
        
        for( HabilidadeContato__c habilidadeContato : lstHabContatos ){    
            System.debug('>>> habilidadeContato'+habilidadeContato);               
            if( mapContatoHabilidades.containsKey( habilidadeContato.Contato__c ) ){
                mapContatoHabilidades.get( habilidadeContato.Contato__c ).add( habilidadeContato.Habilidade__r.Name );
            }else{
                mapContatoHabilidades.put( habilidadeContato.Contato__c, new List<String>{ habilidadeContato.Habilidade__r.Name } );
            }
            System.debug('>>> mapContatoHabilidades Dentro'+mapContatoHabilidades);   
        }
        System.debug('>>> mapContatoHabilidades Fora'+mapContatoHabilidades);   
        if( !requests.isEmpty() )
        	createTasks( requests, mapContatoHabilidades );        
    }
    
    public static void createTasks( List<CreateTaskRequest> requests, Map<Id,List<String>> mapContatoHabilidades ){
        List<Task> tasksToInsert = new List<Task>();        
        for( CreateTaskRequest request : requests ){            
            system.debug('REQUEST: ' + request);
            system.debug('HABILIDADES: ' + mapContatoHabilidades.get(request.contactId));
            Task tarefa = new Task();
            	tarefa.Description 	= 'Favor realizar a avaliação do Herói. Suas habilidades são: '+ String.valueOf(mapContatoHabilidades.get(request.contactId));	
            	tarefa.Subject 		= request.subject;
            	tarefa.WhoId   		= request.contactId;
            	tarefa.OwnerId 		= request.ownerId;
            	tarefa.Status  		= 'Open';			            	
            tasksToInsert.add(tarefa);
        }  
        
        if(!tasksToInsert.isEmpty())            
            insert tasksToInsert;
    }
    
    global class CreateTaskRequest {
        @InvocableVariable(required=true)
        global String contactId;
        @InvocableVariable(required=true)
        global String ownerId;
        @InvocableVariable(required=true)
        global String subject;
    }

}
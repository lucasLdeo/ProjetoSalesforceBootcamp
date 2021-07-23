public class CalloutToMarvel {
	public static final string apikey = '9162d33a4df55119a86162fe54ae4487';
    public static final string hash = '210d6cdd21bce8089527726197f8b9f5';
	
	@future(callout=True)    
    public static void getPersonagens(){
        // monta a url da API obs: Tem que autorizar no salesforce
        final String endpoint = 'http://gateway.marvel.com/v1/public/events/310/characters?apikey='+apikey+'&hash='+hash+'&ts=1';
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            //faz a requisição 
            System.debug('>>> request::'+request );
            //Pega a resposta
            HttpResponse response = http.send(request);
            
            System.debug('>>> response::'+response );
            //Estatus da resposta            
            if (response.getStatusCode() == 200){
                
                //Manipulação dos dados
                System.debug('response body >>'+response.getBody());                
                Map <String,object> dataResults = (Map<String,object>) JSON.deserializeUntyped(response.getBody());                
                Map <String,object> data = (Map <String,object>) dataResults.get('data');                 
                System.debug('data>>'+ data);
                List<Object> results = (List<Object>) data.get('results');
                System.debug('results>>'+ results);                        
                
                if (!results.isEmpty())
                upsertPersonagens(results);
                
                
            }else{
                System.debug('>>> statusCode::'+response.getStatusCode());
            }
        }catch(Exception e){
            System.debug('>>>> ERROR'+ e.getMessage());
        }
        
    }
    private static void upsertPersonagens(List<Object> results){
        List<Lead> leadsToUpsert = new List<Lead>();
        
        for (Object personagem :results){
            system.debug('personagem'+personagem);
            Map<String,object> mapPersonagem = (Map<String,object>) personagem;
            system.debug('mapPersonagem'+mapPersonagem);
        	Lead lead = new Lead();
            lead.Company = 'Marvel API';
            lead.Planeta__c = 'Mundo Marvel';
            lead.NomeDeGuerra__c = String.valueOf(mapPersonagem.get('name'));            
            lead.NomeDeGuerra__c = String.valueOf(mapPersonagem.get('id'));  
            lead.Description = String.valueOf(mapPersonagem.get('description'));             
            lead.LastName = String.valueOf(mapPersonagem.get('name'));
            lead.LeadSource = 'Marvel API';
          	leadsToUpsert.add(lead);           
            System.debug('>>>> Nome do personagem '+mapPersonagem.get('name'));
        }
        
        System.debug('leadsToUpsert>>'+leadsToUpsert);
        if (!leadsToUpsert.isEmpty()){
            upsert leadsToUpsert NomeDeGuerra__c;
            System.debug('apos leadsToUpsert>>'+leadsToUpsert);
        }
        
    }
    
}
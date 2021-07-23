/* Listar todos os herois que não estão alocados em batalhas e 
 * ter opção de buscar todos/por habilidade/ por nível do heroi
 */
@RestResource(urlMapping='/marvel/availableHeroes/*')
global class GetAvailableHeroesIs {
	
    @HttpGet
    global static AvailableHeroes doGet(){     
        
        Map<String,Hero> mapHerois = new Map<String,Hero>();
        List<HabilidadeContato__c> lstHabContatos = new  List<HabilidadeContato__c>();
        String habilidadeParam = RestContext.request.params.get('Habilidade');
        
        String nivelParam = RestContext.request.params.get('Nivel');
        
        String dynamicQuery = 'SELECT Id, Contato__r.NomeDeGuerra__c, Habilidade__r.Name, Contato__r.NivelDoHeroi__c, Level__c FROM HabilidadeContato__c where Contato__r.RecordType.DeveloperName = \'Heroi\' and Contato__c NOT IN (SELECT Contato__c  FROM BatalhaDoContato__c)';                   	               
        
        if (!String.isBlank(habilidadeParam)){
            List<String> HabilidadesParam = habilidadeParam.split(',');
            dynamicQuery += ' and Habilidade__r.Name IN :HabilidadesParam';
        }
        if (!String.isBlank(nivelParam)){
            List<String> niveisParam = nivelParam.split(',');
            dynamicQuery += ' and Contato__r.NivelDoHeroi__c IN :niveisParam';
        }
       	
        lstHabContatos = Database.query(dynamicQuery);
                
        for (HabilidadeContato__c habilidadeContato: lstHabContatos){
            
            Skill habilidade = new Skill(habilidadeContato.Habilidade__r.Name,String.valueOf(habilidadeContato.Level__c));
            
            Hero heroi;
            
            if (mapHerois.containsKey(habilidadeContato.Contato__r.NomeDeGuerra__c)){
                heroi = mapHerois.get(habilidadeContato.Contato__r.NomeDeGuerra__c);
                heroi.habilidades.add(habilidade);
            }else{
                heroi = new Hero();
                heroi.nome  = habilidadeContato.Contato__r.NomeDeGuerra__c;
                heroi.nivel  = habilidadeContato.Contato__r.NivelDoHeroi__c;
                heroi.habilidades = new List<Skill>{habilidade};                
            }
            mapHerois.put(habilidadeContato.Contato__r.NomeDeGuerra__c, heroi);
        }		
        //return 'Funcionou';
        //return String.valueOf(lstHabContatos);        
        return new AvailableHeroes(mapHerois.values());
    }        
    global class AvailableHeroes{
        
        public List<Hero> Herois;
        public Integer total;
        
        AvailableHeroes(List<Hero> herois){
            this.Herois = herois;
            this.total = herois.size();
            
        }
    }
    
    global class Hero{
        
        public String nome;
        public String nivel;
        public List<Skill> habilidades;
        
    }
    global class Skill{
        
        public String nome;
        public String nivel;
        
        Skill(String nome, String nivel){
            this.nome = nome;
            this.nivel = nivel;
        }
        
    }    
}
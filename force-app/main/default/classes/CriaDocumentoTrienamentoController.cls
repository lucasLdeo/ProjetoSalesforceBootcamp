public with sharing class CriaDocumentoTrienamentoController {
    
    public Contact contato {get;set;}    
    public CriaDocumentoTrienamentoController() {		

        Id contatoId = ApexPages.currentPage().getParameters().get('Id');
        this.contato = [SELECT Id, Firstname, NomeDeGuerra__c,FeedbackTreinamento__c, ResponsavelAprovacao__c, StatusDoCandidato__c, DataDaAprovacao__c, 
        (SELECT Habilidade__r.Name, Level__c from HabilidadesContato__r ORDER BY Level__c DESC) 
        FROM Contact WHERE Id = :contatoId];
    }
         
}
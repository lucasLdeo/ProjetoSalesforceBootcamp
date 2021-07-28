public class HeroiPDFApexControler {

    public Contact contato {get;set;}
    
    public HeroiPDFApexControler(){
        id contactId = ApexPages.currentPage().getParameters().get('id');
        
        this.contato = [SELECT Id, NomeDeGuerra__c,FirstName, LastName, StatusDoCandidato__c FROM Contact WHERE Id =:contactId];

    } 

}
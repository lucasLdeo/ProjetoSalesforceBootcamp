public with sharing class EditHabilidadeContatoControllerExtension {
    private Contact contato;
    public List<HabilidadeContato__c> habilidades {get; private set;}
    public EditHabilidadeContatoControllerExtension(ApexPages.StandardController controller) {
        this.contato =(Contact) controller.getRecord();
        this.habilidades = [SELECT id, habilidade__r.Name, Level__c from HabilidadeContato__c where Contato__c = :this.contato.Id ];
    }

    public PageReference cancelar(){
        PageReference pg = new PageReference('/'+this.contato.Id);
        pg.setRedirect(true);
        return pg;
    }
    public void salvar(){
       try{
        update this.contato;
        update this.habilidades;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM,'Os registros foram atualizados'));
       }catch(Exception e){

           System.debug('Erro >>> '+ e.getMessage());
           ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM,'Não foi possível salvar, verifique com o suporte'));
       }
    }
}
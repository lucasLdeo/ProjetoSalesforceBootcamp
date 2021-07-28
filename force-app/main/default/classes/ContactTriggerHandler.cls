public class ContactTriggerHandler { 
    public void onBeforeInsert(List <Contact> newRecords,Map<Id,Contact> oldmap){ 
        System.debug('>>> onBeforeinsert<<<');
        ContactTriggerHelper.InsereDataDeAtualizacaoDoHeroi(newRecords,oldmap);   
    } 
    public void onAfterInsert(List <Contact> newRecords){ 
        System.debug('>>> onAfterInsert<<<'); 
        ContactTriggerHelper.criaTarefaParaEncontrarFraquezas(newRecords); 
    } 
    public void onBeforeUpdate(List <Contact> newRecords, Map<Id,Contact> oldmap){ 
        System.debug('>>> onBeforeUpdate<<<'); 
        ContactTriggerHelper.InsereDataDeAtualizacaoDoHeroi(newRecords,oldmap);       
    } 
    public void onAfterUpdate(List <Contact> newRecords, Map<Id,Contact> oldmap){ 
        System.debug('>>> onAfterUpdate<<<');                 
    } 
    public void onBeforeDelete(List <Contact> oldRecords, Map<Id,Contact> oldMap){ 
        ContactTriggerHelper.naoPermiteApagarQuandoExisteTaskEmAberto(oldRecords,oldMap); 
    } 
}
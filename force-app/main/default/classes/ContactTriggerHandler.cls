public class ContactTriggerHandler { 
    public void onBeforeInsert(List <Contact> newRecords){ 
        System.debug('>>> onBeforeinsert<<<'); 
    } 
    public void onAfterInsert(List <Contact> newRecords){ 
        System.debug('>>> onAfterInsert<<<'); 
        ContactTriggerHelper.criaTarefaParaEncontrarFraquezas(newRecords); 
    } 
    public void onBeforeUpdate(List <Contact> newRecords, Map<Id,Contact> oldmap){ 
        System.debug('>>> onBeforeUpdate<<<'); 
        for (Contact contato : newRecords){ 
            System.debug('>>>>>BEFORE Contato NEW LastModified ::'+contato.LastModifiedDate); 
            System.debug('>>>>>BEFORE Contato NEW ::'+contato); 
            System.debug('>>>>>BEFORE Contato OLD ::'+ oldmap.get(contato.Id)); 
        } 
    } 
    public void onAfterUpdate(List <Contact> newRecords, Map<Id,Contact> oldmap){ 
        System.debug('>>> onAfterUpdate<<<'); 
        for (Contact contato : newRecords){ 
            System.debug('>>>>> AFTER Contato NEW LastModified ::'+contato.LastModifiedDate); 
            System.debug('>>>>> AFTER Contato NEW ::'+contato); 
            System.debug('>>>>> AFTER Contato OLD ::'+ oldmap.get(contato.Id)); 
        } 
    } 
    public void onBeforeDelete(List <Contact> oldRecords, Map<Id,Contact> oldMap){ 
        ContactTriggerHelper.naoPermiteApagarQuandoExisteTaskEmAberto(oldRecords,oldMap); 
    } 
}
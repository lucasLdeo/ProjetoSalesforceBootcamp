trigger HabilidadeContatoTrigger on HabilidadeContato__c (after insert, after update, before delete) {
    HabilidadeContatoTriggerHandler  handler = new HabilidadeContatoTriggerHandler();
    
	switch on Trigger.operationType{       
        when AFTER_INSERT{
            handler.onAfterInsert(Trigger.new);
        }
        when AFTER_UPDATE{
            System.debug('Atualizei');
            handler.onAfterUpdate(Trigger.new,Trigger.oldMap);
        }
        when BEFORE_DELETE{            
            handler.onBeforeDelete(Trigger.old);
        }
	}
}
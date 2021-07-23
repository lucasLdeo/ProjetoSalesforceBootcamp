trigger HabilidadeContatoTrigger on HabilidadeContato__c (after insert, after update, before delete) {
    HabilidadeContatoTriggerHandler  handler = new HabilidadeContatoTriggerHandler();
    
	switch on Trigger.operationType{       
        when AFTER_INSERT{
            handler.onAfterInsert(Trigger.new);
        }
        when AFTER_UPDATE{
            handler.onAfterUpdate(Trigger.new,Trigger.oldMap);
        }
        when BEFORE_DELETE{
            System.debug('chegou');
            handler.onBeforeDelete(Trigger.old);
        }
	}
}
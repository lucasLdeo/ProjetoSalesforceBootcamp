trigger Contact on Contact (before insert, after insert , before update, after update) {
	// BEFORE -> antes de salvar no banco 
	// AFTER -> DEPOIS DE SALVAR NO BANCO
	// OLD -> VERSÃO ANTERIOR AO UPDATE
	// NEW -> VERSÃO POSTERIO AO UPDATE
     ContactTriggerHandler handler = new ContactTriggerHandler();
    
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            handler.onBeforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE{
            handler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when AFTER_INSERT{
            handler.onAfterInsert(Trigger.new);
        }
        when AFTER_UPDATE{
            handler.onAfterUpdate(Trigger.new,Trigger.oldMap);
        }
        when BEFORE_DELETE{
            handler.onBeforeDelete(Trigger.old, Trigger.oldMap);
        }
    }
}
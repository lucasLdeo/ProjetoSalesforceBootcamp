public class CriaDocumentoTrienamentoScheduler implements Schedulable,Database.Batchable<SObject> {
    
    public Integer minutes;
    public Boolean runOnlyOnce;
    
    public CriaDocumentoTrienamentoScheduler(){
        this.minutes = 60; //default value - it runs every hour
        this.runOnlyOnce = false;
    }
    
    public CriaDocumentoTrienamentoScheduler(Integer minutes, Boolean runOnlyOnce){
        this.minutes = minutes;
        this.runOnlyOnce = runOnlyOnce;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        Datetime hora = System.now().addMinutes(-60);
        return Database.getQueryLocator(
           'SELECT Id,NomeDeGuerra__c FROM Contact WHERE DataDaAprovacao__c > :hora'
        );
    }
    public void execute (Database.BatchableContext bc, List<Contact> records){    
        if (!records.isEmpty()){     
            List<Attachment> anexos = new List<Attachment>();
            for(Contact contato : records){                           
                System.debug('IdcontatoPdf >>>> '+ contato.Id);
                PageReference pr = new PageReference('/apex/DocumentoTreinamentoHeroi?Id='+contato.Id);
                Attachment a = new Attachment(parentid=contato.Id, Name = 'RelatórioDe_'+contato.NomeDeGuerra__c+'_Treino.pdf' , Body = pr.getContentAsPDF());
                anexos.add(a);
            }        
            insert anexos;
        }                
    }

    public void reeschedule() {
        Datetime nextMinute = System.now().addMinutes(minutes);

        Integer year = nextMinute.year();
        Integer month = nextMinute.month();
        Integer day = nextMinute.day();
        Integer hour = nextMinute.hour();
        Integer min = nextMinute.minute(); 
        Integer ss = nextMinute.second();
        
        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' ' + day + ' ' + month + ' ? ' + year;
        
        CriaDocumentoTrienamentoScheduler scheduler = new CriaDocumentoTrienamentoScheduler(minutes, runOnlyOnce); 
        
        String jobId = '';
        
        if(runOnlyOnce){
            System.schedule('Documento Trienamento' + String.valueOf(Datetime.now()), nextFireTime, scheduler);
        }else{
            System.schedule('Documento Trienamento '+minutes+' minute(s)', nextFireTime, scheduler);            
        }
    }

    public static void startJob(Integer minutes, Boolean runOnlyOnce){
        new CriaDocumentoTrienamentoScheduler(minutes, runOnlyOnce).reeschedule();
    }

    public void finish(Database.BatchableContext bc){            
        System.debug('>>>>>>> ERRO NO JOB');
    }
      
    public void execute(SchedulableContext sc) {                                      
        Id batchId = Database.executeBatch(this); 
        system.debug('BATCH ID: ' + batchId);
    }    
}
@RestResource(urlMapping = '/api/v1/interviews/*')
global with sharing class InterviewUpdateRestController {
   
    @HttpPut
    global static Interview__c updateInterviews(Decimal duration , Datetime interviewTime , Boolean toHire){

        Interview__c interviewToUpdate = new Interview__c() ;

        Map<string, string> paramsMap = RestContext.request.params;
    
        string interviewId = paramsMap.get('Id');

        if (interviewId == null) {throw new IdNotFoundException('specify an interview Id');}
        
        interviewToUpdate = [Select Id, Interview_time__c, Duration__c , Hire__c From Interview__c Where Id =: interviewId];

        if(interviewToUpdate == null) {throw new NotFoundException('interview not found');}

        interviewToUpdate.Interview_time__c = interviewTime != null ? interviewTime : interviewToUpdate.Interview_time__c ;
        interviewToUpdate.Hire__c = toHire != null ? toHire : interviewToUpdate.Hire__c ;
        interviewToUpdate.Duration__c = duration != null ? duration : interviewToUpdate.Duration__c  ;

        try {
            update interviewToUpdate;
            }
        catch(Exception e) {
            System.debug('error while updating interview ' + e);
            }

        return interviewToUpdate;
    }  
}
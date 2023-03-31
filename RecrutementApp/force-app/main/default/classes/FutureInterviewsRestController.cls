@RestResource(urlMapping = '/api/v1/interviews/future')
global with sharing class FutureInterviewsRestController {
    
    @HttpGet
    global static List<Interview__c> getFutureInterviews(){
        datetime currentDateTime = datetime.now(); 
        List<Interview__c> futureInterviews  = [Select id , Interview_time__c , Duration__c , Position__r.Name , Candidate__r.Last_Name__c , Candidate__r.First_Name__c FROM interview__c
         where Interview_time__c > :currentDateTime
         WITH SECURITY_ENFORCED
         ORDER BY Interview_time__c ASC
        ];

        return futureInterviews;
    }
}
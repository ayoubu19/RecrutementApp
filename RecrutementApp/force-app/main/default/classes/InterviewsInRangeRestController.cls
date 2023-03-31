
@RestResource(urlMapping = '/api/v1/interviews/range')
global with sharing class InterviewsInRangeRestController {
    
    @HttpGet
    global static List<Interview__c> getInterviews(){
        List<Interview__c> interviews = new List<Interview__c>();

        Map<string, string> paramsMap = RestContext.request.params;

        datetime minDateTime = paramsMap.get('minDateTime') != null ? (DateTime)JSON.deserialize('"' + paramsMap.get('minDateTime') + '"', DateTime.class) : null;
        datetime maxDateTime = paramsMap.get('maxDateTime') != null ? (DateTime)JSON.deserialize('"' + paramsMap.get('maxDateTime') + '"', DateTime.class) : null;

        if(minDateTime != null && maxDateTime != null) {

            interviews = [ Select id , Interview_time__c , Duration__c , Position__r.Name , Candidate__r.Last_Name__c , Candidate__r.First_Name__c FROM interview__c
                            where Interview_time__c >= :minDateTime  And Interview_time__c <= :maxDateTime
                            WITH SECURITY_ENFORCED
                            ORDER BY Interview_time__c ASC ];

        } else if (minDateTime != null && maxDateTime == null) {

            interviews = [ Select id , Interview_time__c , Duration__c , Position__r.Name , Candidate__r.Last_Name__c , Candidate__r.First_Name__c FROM interview__c
                            where Interview_time__c >= :minDateTime  
                            WITH SECURITY_ENFORCED
                            ORDER BY Interview_time__c ASC ];

        } else if (minDateTime == null && maxDateTime != null) {

            interviews = [ Select id , Interview_time__c , Duration__c , Position__r.Name , Candidate__r.Last_Name__c , Candidate__r.First_Name__c FROM interview__c
                            where Interview_time__c <= :maxDateTime 
                            WITH SECURITY_ENFORCED
                            ORDER BY Interview_time__c ASC ];

        } else {

            interviews = [ Select id , Interview_time__c , Duration__c , Position__r.Name , Candidate__r.Last_Name__c , Candidate__r.First_Name__c FROM interview__c
                            WITH SECURITY_ENFORCED
                            ORDER BY Interview_time__c ASC ];

        }

        return interviews;

    }
}
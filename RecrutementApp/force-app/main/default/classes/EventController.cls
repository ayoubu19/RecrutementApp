public with sharing class EventController {
    
    @AuraEnabled(Cacheable=true scope='global')
    public static List<Event__c> getEvents() {
        return [SELECT subject__c , start_date__c , end_date__c FROM Event__c WITH SECURITY_ENFORCED ORDER BY start_date__c ];
    }

}
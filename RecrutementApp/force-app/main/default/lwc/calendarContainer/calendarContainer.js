import { LightningElement, wire } from 'lwc';
import getEvents from '@salesforce/apex/EventController.getEvents'

export default class CalendarContainer extends LightningElement {
    events = [];
    @wire(getEvents)
    wiredEvents({ data, error }) {
        if (data) {
            console.log(JSON.parse(JSON.stringify(data)));
            this.events = data.map(event => ({
                start: event.start_date__c,
                end: event.end_date__c,
                title: '' + event.subject__c 
            }));

            //this.events = JSON.parse(JSON.stringify(records));
            console.log(this.events[0].title);
        } else if (error) {
            console.error(error);
        }
    }



}
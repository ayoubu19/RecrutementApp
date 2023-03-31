import { LightningElement , api} from 'lwc';
import FullCalendarJS from '@salesforce/resourceUrl/fullcalendarv3';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CalendarLwc extends LightningElement {

    jsInitialised = false;

    _events = [] ;

    @api
    get events() {
        return this._events;
    }
    set events(value) {
        this._events=[...value];
    }
   
   
    renderedCallback() {

        // Performs this operation only on first render
        if (this.jsInitialised) {
            return;
        }

        Promise.all([
            loadScript(this, FullCalendarJS + '/FullCalenderV3/jquery.min.js'),
            loadScript(this, FullCalendarJS + '/FullCalenderV3/moment.min.js'),
            loadScript(this, FullCalendarJS + '/FullCalenderV3/fullcalendar.min.js'),
            loadStyle(this, FullCalendarJS + '/FullCalenderV3/fullcalendar.min.css')
        ]).then(() => {
                console.log('initialized');

                //TODO: fix this bug otherwise (events not shown in first render)
                setTimeout(() =>  this.initialiseCalendarJs() , "500");
                this.jsInitialised = true;
            })
            .catch(error => {
                alert(error);
                new ShowToastEvent({
                    title: 'Error!',
                    message: error,
                    variant: 'error'
                })
            })
    }

    initialiseCalendarJs() {
        var that = this;
        const ele = this.template.querySelector('div.fullcalendarjs');
        //Use jQuery to instantiate fullcalender JS
        $(ele).fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,basicWeek,basicDay'
            },
            defaultDate: new Date(),
            navLinks: true,
            editable: false,
            eventLimit: true,
            events: this.events,
            dragScroll: true,
            droppable: true,
            weekNumbers: true,
            selectable: true
        });
    }


}
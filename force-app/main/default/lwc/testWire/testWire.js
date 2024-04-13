import {LightningElement, wire} from 'lwc';
import getNumberOfContacts from '@salesforce/apex/checkContacts.getNumberOfContacts';

export default class TestWire extends LightningElement {
    //columns = COLUMNS;
    @wire(getNumberOfContacts, {i: 5})
    getNumberOfContacts(outcome){
        console.log('inside result');
        console.log(outcome.data);
        
    }
}
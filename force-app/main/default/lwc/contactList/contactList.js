import { LightningElement, wire } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const COLUMNS = [
    { label: 'Contact FirstName', fieldName: FirstName.fieldApiName, type: 'text' },
    { label: 'Contact LastName', fieldName: LastName.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: EMAIL_FIELD.fieldApiName, type: 'Email' }
];
export default class ContactList extends LightningElement {
    @wire(getContacts)
    contacts;
    get errors() {
        return (this.contacts.error) ?
            reduceErrors(this.contacts.error) : [];
    }
}
import {LightningElement, api, wire} from 'lwc';
import getNumberOfContacts from '@salesforce/apex/checkContacts.getNumberOfContacts';
import updateDatatable from '@salesforce/apex/checkContacts.updateDatatable';
import { publish, MessageContext } from 'lightning/messageService';
import accountContactsChannel from '@salesforce/messageChannel/accountContactsChannel__c';
import { refreshApex } from '@salesforce/apex';
const COLUMNS = [
    { label: 'Name', fieldName: 'Name', editable: true},
    { label: 'Email', fieldName: 'Email', editable: true},
    { label: 'Phone', fieldName: 'Phone', editable: true},
    { label: 'Action', type: 'button', typeAttributes: {label:'View Contact', name:'View Contacts',title:'View Contacts', value :'View_Contacts'}},
];
export default class AccountSearchResult extends LightningElement {
    @api searchText;
    columns = COLUMNS;
    saveDraftValues = [];
    contactslist = [];
    @wire(getNumberOfContacts, {
    i: '$searchText'
    })
    outcome;
    @wire(MessageContext)
    messageContext;  
        
    handleonRowAction(event) {
        if(event.detail.action.value == 'View_Contacts'){
        const payload = { accountId: event.detail.row.Id ,accountName: event.detail.row.Name};
        publish(this.messageContext, accountContactsChannel, payload);    
        }
    }
    
    async handleSave(event) {
        const updatedFields = event.detail.draftValues;
        const update = await updateDatatable( { data: updatedFields } );
        this.saveDraftValues = [];
        console.log('Returned Result >>>>:',update);
        this.refresh();
    }

        async refresh() {
        await refreshApex(this.outcome);
    }
}
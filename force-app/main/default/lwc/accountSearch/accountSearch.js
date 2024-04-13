import {
    LightningElement
} from 'lwc';

export default class AccountSearch extends LightningElement {
    searchText = '';
    retrieveContactsHandler(event) {
        this.searchText = event.detail;
        console.log('inside retrieveContactsHandler', event.detail);
    }
}
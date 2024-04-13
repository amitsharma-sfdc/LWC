import {
    LightningElement
} from 'lwc';

export default class AccountSearchForm extends LightningElement {
    searchText = '';
    accountChangeHandler(event) {
        this.searchText = event.target.value;
        console.log('inside accountChangeHandler');
    }
    handleclick() {
        console.log(this.searchText);
        this.template.querySelector("lightning-input").value = '';
        const event = new CustomEvent('retrievecontacts', {
            detail: this.searchText
        });
        console.log('After Triggering custom event:', this.searchText);
        this.dispatchEvent(event);
    }
}
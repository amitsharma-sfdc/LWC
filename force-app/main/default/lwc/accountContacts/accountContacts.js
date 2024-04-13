import { LightningElement,wire,api,track} from 'lwc';
import getAccountsfromContact from '@salesforce/apex/checkContacts.getAccountsfromContact';
import updateRecord from '@salesforce/apex/checkContacts.updateRecord';
import deleteRecord from '@salesforce/apex/checkContacts.deleteRecord';
import insertRecord from '@salesforce/apex/checkContacts.insertRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext
} from 'lightning/messageService';
import LightningModal from 'lightning/modal';
import accountContactsChannel from '@salesforce/messageChannel/accountContactsChannel__c';
import ToastContainer from 'lightning/toastContainer';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name'},
    { label: 'Phone', fieldName: 'Phone'},
    { label: 'Email', fieldName: 'Email'},
    { type: 'button-icon', typeAttributes:
    {
        iconName: 'utility:delete',
        name: 'delete',
        iconClass: 'slds-icon-text-error',
        value: 'Delete'
    }},
    { type: 'button-icon', typeAttributes:
    {
        iconName: 'utility:edit',
        name: 'edit',
        iconClass: 'slds-icon-text-warning',
        value: 'Edit'
    }},
];
export default class AccountContacts extends LightningElement {
    subscription = null;
    accountId ='';
    accName ='';
    title ='Contacts';
    contacts=[];
    @wire(MessageContext)
    messageContext;
    columns = COLUMNS;
    updateId ='';
    updateName ='';
    updateFName ='';
    updateLName ='';
    updatePhone ='';
    updateEmail ='';
    @api content;
    @track isModalOpen = false;
    @track isDeleteModalOpen = false;
    @track loaded = true;
    @track isCreate = false;
    @track modalHeader ='';

    connectedCallBack(){
        const tc = ToastContainer.instance();
        tc.toastPosition = 'bottom-left';
    }
    async getContact(){
        const data = await getAccountsfromContact({recordId:this.accountId});
        this.contacts = data;
    }
    
    get isAccountSelected(){
        return this.accountId?true:false;
    }
    get hasContacts(){
        return this.contacts.length>0?true:false;
    }
    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }

     subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                accountContactsChannel,
                (data) => this.handleMessage(data),
                { scope: APPLICATION_SCOPE }
            );
        }
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

        handleMessage(data) {
        this.accountId = data.accountId;
        this.accName = data.accountName;
        this.title = `${data.accountName}'s contacts`;
        this.getContact();
    }
    handleonRowAction(event) {
        if(event.detail.action.value == 'Delete'){
        console.log('Delete button clicked',JSON.stringify(event));
        this.handleDelete(event.detail.row);
        }else if(event.detail.action.value == 'Edit'){
        console.log('Edit button clicked');
        this.handleEdit(event.detail.row);
        }
    }

    handleDelete(data){
        this.updateId = data.Id;
        this.updateName = data.Name;
         this.isDeleteModalOpen = true;

    }
    deleteRecord(){
        this.loaded = false;
        this.deleteRecord();
    }
        
        async deleteRecord(){
        const data = await deleteRecord({recordId : this.updateId});
        this.resp = data;
        console.log(this.resp);
        this.getContact();
        this.loaded = true;
        this.closeDeleteModal();
        if(data === 'success'){
            this.showSuccessToast('Record Has Been Deleted.');
        }else{
            this.showErrorToast(data);
        }
    }

    handleEdit(data){
        console.log(data.Id,data.Name,data.Email,data.Phone);
        this.updateId = data.Id;
        this.updateName = data.Name;
        this.updateFName = data.FirstName;
        this.updateLName = data.LastName;
        this.updateEmail = data.Email;
        this.updatePhone = data.Phone;
        this.modalHeader = 'Edit Contact : '+ this.accName;
        this.isModalOpen = true;        
    }
    handleUpdate() {
        if((this.updateFName === '' && this.updateLName === '' && this.updateEmail === '' && this.updatePhone === '')){  //
            this.showErrorToast('Field Values Required !');
        }else if((this.updateLName === '')){
            this.showErrorToast('Last Name Required !');
        }else{
            this.loaded = false;
            this.recordUpdate();
        }
    }
    closeModal() {
        this.isModalOpen = false;
        this.updateFName ='';
        this.updateLName ='';
        this.updatePhone ='';
        this.updateEmail ='';
        this.isCreate = false;
    }
    closeDeleteModal(){
        this.isDeleteModalOpen = false;
    }
        async recordUpdate(){
        const data = await updateRecord({recordId:this.updateId,
        fname: this.updateFName,
        lname: this.updateLName,
        cphone: this.updatePhone,
        cemail: this.updateEmail});
        if(data === 'success'){
            this.showSuccessToast('Record Has Been Updated.');
        }else{
            this.showErrorToast(data);
        }
        
        console.log(this.resp);
        this.getContact();
        this.loaded = true;
        this.closeModal();
    }
    fnameChngeHandler(event){
        this.updateFName = event.target.value;
    }
    lnameChngeHandler(event){
        this.updateLName = event.target.value;
    }
    emailChngeHandler(event){
        this.updateEmail = event.target.value;
    }
    phoneChngeHandler(event){
        this.updatePhone = event.target.value;
    }
    handleAddContact(){
        console.log('Inside handleAddContact');
        this.isCreate = true;
        this.modalHeader = 'Create Contact For Account : '+this.accName;
        this.isModalOpen = true;
    }
    createContact(){
        if((this.updateFName === '' && this.updateLName === '' && this.updateEmail === '' && this.updatePhone === '')){ //
            this.showErrorToast('Field Values Required !');
        }else if((this.updateLName === '')){
            this.showErrorToast('Last Name Required !');
        }else{
            this.loaded = false;
            this.insertContact();
        }
    }

    showSuccessToast(data) {
    const event = new ShowToastEvent({
        //title: 'Toast message',
        message: data,
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(event);
}
showErrorToast(data) {
    const event = new ShowToastEvent({
        //title: 'Toast message',
        message: data,
        variant: 'error',
        mode: 'dismissable'
    });
    this.dispatchEvent(event);
}

async insertContact(){
        const data = await insertRecord({accId: this.accountId,
        fname: this.updateFName,
        lname: this.updateLName,
        cphone: this.updatePhone,
        cemail: this.updateEmail});
        if(data === 'success'){
            this.showSuccessToast('Record Has Been Created.');
        }else{
            this.showErrorToast(data);
        }
        this.getContact();
        this.loaded = true;
        this.closeModal();
    }
}
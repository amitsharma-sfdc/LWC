import { LightningElement,track,wire } from 'lwc';
import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import getDetails from '@salesforce/apex/RetrieveVehicle.getDetails';
import trackOwnerShip from '@salesforce/apex/accountHistoryTracking.trackOwnerShip';
const HIDDENCOLUMNS = [
    { label: 'Name',   fieldName: 'Name'},
    { label: 'Model',  fieldName: 'Model__c'},
    { label: 'VIN',    fieldName: 'VIN_Number__c'}
];
const COLUMNS = [
    { label: 'Changed By',   fieldName: 'changedBy'},
    { label: 'From',  fieldName: 'OldValue'},
    { label: 'To',    fieldName: 'NewValue'},
    { label: 'Date',    fieldName: 'CreatedDate'},
];
export default class LwcModal extends LightningModal {
    @api recdid = '0012v00002TtzN0AAJ';
    @track vehicles=[];
    @track history=[];
    columns = COLUMNS;
    title ='Vehicles';
    handleOkay() {
        this.close('okay');
    }

    async connectedCallback(){
    console.log('This Record Id : ', this.recdid);
    await this.getvehicle();
    await this.getOwnerHistory();
    }
    async getvehicle(){
        const data = await getDetails({});
        this.vehicles = data;
    }
    async getOwnerHistory(){
        const data = await trackOwnerShip({accId : this.recdid});
        this.history = data;
        console.log(data);
    }
}
import { LightningElement,track,wire } from 'lwc';
import getDetails from '@salesforce/apex/RetrieveVehicle.getDetails';
import retrieveVehicleDetails from '@salesforce/apex/RetrieveVehicleHelper.retrieveVehicleDetails';

const COLUMNS = [
    { label: 'Name',   fieldName: 'Name'},
    { label: 'Model',  fieldName: 'Model__c'},
    { label: 'VIN',    fieldName: 'VIN_Number__c'}
];

export default class SharingSettings extends LightningElement {
    @track vehicles=[];
    columns = COLUMNS;
    title ='Vehicles';
    async connectedCallback(){
    await this.getvehicle();
    }
    async getvehicle(){
        const data = await getDetails({});
        this.vehicles = data;
    }
}
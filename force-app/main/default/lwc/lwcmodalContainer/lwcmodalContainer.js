import { LightningElement,api } from 'lwc';
import LwcModal from 'c/lwcModal';
export default class LwcmodalContainer extends LightningElement {
    @api recordId;
        openModal() {
        LwcModal.open();
    }
}
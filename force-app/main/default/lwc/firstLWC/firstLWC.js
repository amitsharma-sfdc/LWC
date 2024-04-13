import { LightningElement } from 'lwc';

export default class FirstLWC extends LightningElement {
    clickedButtonLabel;
    handleClick(event) {
        this.clickedButtonLabel = event.target.label;
    }
}
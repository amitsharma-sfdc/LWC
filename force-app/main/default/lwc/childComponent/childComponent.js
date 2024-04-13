import {
    LightningElement
} from 'lwc';

export default class ChildComponent extends LightningElement {
    constructor() {
        super();
        console.log('This is ChildComponent constructor');
    }

    connectedCallback() {
        console.log('This is ChildComponent connectedCallback');
    }

    renderedCallback() {
        console.log('This is ChildComponent renderedCallback');
    }

    disconnectedCallback() {
        console.log('This is ChildComponent disconnctedCallback');
    }
}
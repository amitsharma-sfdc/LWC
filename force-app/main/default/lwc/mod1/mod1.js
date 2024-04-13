import {
    LightningElement
} from 'lwc';

export default class Mod1 extends LightningElement {
    checklist = "Build Property"
    employee = {
        Name: 'Amit Sharma',
        EmpID: '0042PC',
        Designation: 'Senior Developer',
        Company: 'IBM',
        City: 'Kolkata',
        Salary: 7
    }
    employeeList = [{
            Name: 'Amit Sharma',
            EmpID: '0042PC',
            Designation: 'Senior Developer',
            Company: 'IBM',
            City: 'Kolkata',
            Salary: 7
        },

        {
            Name: 'Reema Sharma',
            EmpID: '123456',
            Designation: 'Senior Developer',
            Company: 'Medeline',
            City: 'Kolkata',
            Salary: 5
        },

        {
            Name: 'Payel Chatterjee',
            EmpID: '889403',
            Designation: 'Senior Accountant',
            Company: 'Capgemini',
            City: 'Bangalore',
            Salary: 5
        }
    ]

    get getBand() {
        const band = this.employee.Salary <= 5 ? '5' : this.employee.Salary <= 6 ? '6' : '7';
        return band;
    }

    constructor() {
        super();
        console.log('This is constructor');
    }

    connectedCallback() {
        console.log('This is connectedCallback');
    }

    renderedCallback() {
        console.log('This is renderedCallback');
    }

    disconnectedCallback() {
        console.log('This is disconnctedCallback');
    }

}
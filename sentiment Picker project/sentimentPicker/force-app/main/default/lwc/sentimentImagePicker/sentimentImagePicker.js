import { LightningElement, api } from 'lwc';
import HAPPY_FACE from '@salesforce/resourceUrl/happyface';
import SAD_FACE from '@salesforce/resourceUrl/sadface';
import NEUTRAL_FACE from '@salesforce/resourceUrl/neutralface';

export default class SentimentImagePicker extends LightningElement {

    @api
    reaction = "none";

    happyface = HAPPY_FACE;
    sadface = SAD_FACE;
    neutralface = NEUTRAL_FACE;

    handleClick(event){
        this.reaction=event.target.value;
    }
}
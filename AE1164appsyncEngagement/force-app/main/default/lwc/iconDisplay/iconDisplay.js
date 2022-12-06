import { LightningElement , api } from 'lwc';

export default class IconDisplay extends LightningElement {
    @api iconType;
    @api iconName;
    @api foregroundColor;
    @api backgroundColor;

    get iconTypeName(){
        return this.iconType + ":" + this.iconName;
    }

    get myIconClass(){
        return !this.foregroundColor || !this.backgroundColor ? '' : 'my-icon'
    }
    //both foregroundColor and backgroundColor are required to set custom color. 

    renderedCallback() { 
        this.initCSSVariables();
    }

    initCSSVariables() {
        var css = this.template.host.style;
        css.setProperty('--backgroundColor', this.backgroundColor);
        css.setProperty('--foregroundColor', this.foregroundColor);
    }
    // https://forcepanda.wordpress.com/2021/07/27/how-to-dynamically-set-custom-css-properties-in-lwc/
}
import { CapacitorPortOne } from 'capacitor-portone';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    CapacitorPortOne.echo({ value: inputValue })
}

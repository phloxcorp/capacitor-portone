package io.phloxcorp.capacitor_portone;

import com.getcapacitor.Logger;

public class CapacitorPortOne {

    public String echo(String value) {
        Logger.info("Echo", value);
        return value;
    }
}

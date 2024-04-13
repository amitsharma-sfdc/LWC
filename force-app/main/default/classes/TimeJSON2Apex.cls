public class TimeJSON2Apex {
    
    public Integer year {get;set;} 
    public Integer month {get;set;} 
    public Integer day {get;set;} 
    public Integer hour {get;set;} 
    public Integer minute {get;set;} 
    public Integer seconds {get;set;} 
    public Integer milliSeconds {get;set;} 
    public String dateTime_Z {get;set;} // in json: dateTime
    public String date_Z {get;set;} // in json: date
    public String time_Z {get;set;} // in json: time
    public String timeZone {get;set;} 
    public String dayOfWeek {get;set;} 
    public Boolean dstActive {get;set;} 
    
    public TimeJSON2Apex(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'year') {
                        year = parser.getIntegerValue();
                    } else if (text == 'month') {
                        month = parser.getIntegerValue();
                    } else if (text == 'day') {
                        day = parser.getIntegerValue();
                    } else if (text == 'hour') {
                        hour = parser.getIntegerValue();
                    } else if (text == 'minute') {
                        minute = parser.getIntegerValue();
                    } else if (text == 'seconds') {
                        seconds = parser.getIntegerValue();
                    } else if (text == 'milliSeconds') {
                        milliSeconds = parser.getIntegerValue();
                    } else if (text == 'dateTime') {
                        dateTime_Z = parser.getText();
                    } else if (text == 'date') {
                        date_Z = parser.getText();
                    } else if (text == 'time') {
                        time_Z = parser.getText();
                    } else if (text == 'timeZone') {
                        timeZone = parser.getText();
                    } else if (text == 'dayOfWeek') {
                        dayOfWeek = parser.getText();
                    } else if (text == 'dstActive') {
                        dstActive = parser.getBooleanValue();
                    } else {
                        System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    
    public static TimeJSON2Apex parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new TimeJSON2Apex(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                    depth++;
                } else if (curr == System.JSONToken.END_OBJECT ||
                           curr == System.JSONToken.END_ARRAY) {
                               depth--;
                           }
        } while (depth > 0 && parser.nextToken() != null);
    }
}
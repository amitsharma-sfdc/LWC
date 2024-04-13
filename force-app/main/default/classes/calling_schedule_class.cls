public class calling_schedule_class {

    scheduleapex sa = new scheduleapex();
String sch = '00 58 20 18 9 4 ?'; //Seconds, Mins, Hours, Day, month, week day,yr
String jobID = system.schedule('This is Scheduled', sch, sa);
}
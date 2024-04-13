public class TriggerDispatcher {
    public static void run(TriggerInterface handler, System.TriggerOperation operationType){
        Switch On operationType{
            WHEN BEFORE_INSERT{
                handler.beforeInsert(Trigger.New);
            }
            WHEN BEFORE_UPDATE{
                handler.beforeUpdate(Trigger.NewMap, Trigger.OldMap);
            }
            WHEN AFTER_INSERT{
                handler.afterInsert(Trigger.New, Trigger.NewMap);
            }
            WHEN AFTER_UPDATE{
                handler.afterUndelete(Trigger.New, Trigger.NewMap);
            }
            WHEN BEFORE_DELETE{
                handler.beforeDelete(Trigger.Old, Trigger.OldMap);
            }
            WHEN AFTER_DELETE{
                handler.afterDelete(Trigger.OldMap);
            }
            WHEN AFTER_UNDELETE{
                handler.afterUndelete(Trigger.New, Trigger.NewMap);
            }
        }
    }
}
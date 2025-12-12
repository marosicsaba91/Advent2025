import 'package:advent/main.dart';

class DoorMap
{

  static List<String> getLockerTask(User user) => switch (user) {
    User.zsuzsiKicsim => ["⭐", "⛄", "🌲"],
    User.kataBalazs => ["🌏", "🎀", "🐑"],
    User.mariMatyi => ["🔔", "📜", "🕯️"],
    User.dorkaMate => ["🍞", "📖", "❄️"],
  };

  static (String, int) dayUserToTaskClueTable(int day, User? user) => switch ((day, user)) {
    (1, User.zsuzsiKicsim) => ("🌏", 1),
    (1, User.kataBalazs) => ("🔔", 1),
    (1, User.mariMatyi) => ("🔔", 2),
    (1, User.dorkaMate) => ("⭐", 1),

    (2, User.zsuzsiKicsim) => ("🔔", 3),
    (2, User.kataBalazs) => ("⭐", 2),
    (2, User.mariMatyi) => ("🌏", 2),
    (2, User.dorkaMate) => ("🍞", 1),

    (3, User.zsuzsiKicsim) => ("⭐", 3),
    (3, User.kataBalazs) => ("🌏", 3),
    (3, User.mariMatyi) => ("🔔", 4),
    (3, User.dorkaMate) => ("🔔", 5),

    (4, User.zsuzsiKicsim) => ("🔔", 6),
    (4, User.kataBalazs) => ("⭐", 4),
    (4, User.mariMatyi) => ("🍞", 2),
    (4, User.dorkaMate) => ("🌏", 4),

    (5, User.zsuzsiKicsim) => ("🌏", 5),
    (5, User.kataBalazs) => ("🌏", 6),   //🔑
    (5, User.mariMatyi) => ("⭐", 5),
    (5, User.dorkaMate) => ("🔔", 7),

    (6, User.zsuzsiKicsim) => ("🍞", 3),
    (6, User.kataBalazs) => ("🔔", 8),
    (6, User.mariMatyi) => ("🔔", 9),   //🔑
    (6, User.dorkaMate) => ("⭐", 6),



    (7, User.zsuzsiKicsim) => ("⭐", 7),
    (7, User.kataBalazs) => ("⭐", 8),
    (7, User.mariMatyi) => ("🍞", 4),
    (7, User.dorkaMate) => ("⛄", 1),
    
    (8, User.zsuzsiKicsim) => ("⭐", 9),  //🔑
    (8, User.kataBalazs) => ("🍞", 5),
    (8, User.mariMatyi) => ("⛄", 2),
    (8, User.dorkaMate) => ("🎀", 1),

    (9, User.zsuzsiKicsim) => ("⛄", 3),
    (9, User.kataBalazs) => ("🎀", 2),
    (9, User.mariMatyi) => ("📖", 1),
    (9, User.dorkaMate) => ("🍞", 6),   //🔑
    
    (10, User.zsuzsiKicsim) => ("📖", 2),
    (10, User.kataBalazs) => ("⛄", 4),
    (10, User.mariMatyi) => ("🎀", 3),
    (10, User.dorkaMate) => ("📜", 1),

    ///////// ------------

    (11, User.zsuzsiKicsim) => ("🎀", 4),
    (11, User.kataBalazs) => ("📜", 2),
    (11, User.mariMatyi) => ("📜", 3),
    (11, User.dorkaMate) => ("⛄", 5),

    (12, User.zsuzsiKicsim) => ("📜", 4),         // !!!
    (12, User.kataBalazs) => ("⛄", 6),
    (12, User.mariMatyi) => ("🎀", 5),
    (12, User.dorkaMate) => ("📖", 3),            

    (13, User.zsuzsiKicsim) => ("📖", 4),         // !!!
    (13, User.kataBalazs) => ("🎀", 6),
    (13, User.mariMatyi) => ("⛄", 8),
    (13, User.dorkaMate) => ("🎀", 7),

    (14, User.zsuzsiKicsim) => ("⛄", 7),
    (14, User.kataBalazs) => ("📖", 5),            // !!!
    (14, User.mariMatyi) => ("📖", 6),
    (14, User.dorkaMate) => ("📜", 5),

    (15, User.zsuzsiKicsim) => ("📜", 6),
    (15, User.kataBalazs) => ("🌲", 1),
    (15, User.mariMatyi) => ("📜", 7),   //🔑
    (15, User.dorkaMate) => ("⛄", 9),
 
    (16, User.zsuzsiKicsim) => ("🎀", 8),
    (16, User.kataBalazs) => ("🎀", 9),   //🔑
    (16, User.mariMatyi) => ("🕯️", 1),
    (16, User.dorkaMate) => ("🐑", 1),

    (17, User.zsuzsiKicsim) => ("⛄", 10),   //🔑
    (17, User.kataBalazs) => ("❄️", 1),                   
    (17, User.mariMatyi) => ("🐑", 2),
    (17, User.dorkaMate) => ("📖", 7),   //🔑

    (18, User.zsuzsiKicsim) => ("🌲", 2),
    (18, User.kataBalazs) => ("🕯️", 2),
    (18, User.mariMatyi) => ("🌲", 3),
    (18, User.dorkaMate) => ("❄️", 2), 

    (19, User.zsuzsiKicsim) => ("🐑", 3),
    (19, User.kataBalazs) => ("🐑", 4),
    (19, User.mariMatyi) => ("🕯️", 3),
    (19, User.dorkaMate) => ("🌲", 4), 

    (20, User.zsuzsiKicsim) => ("❄️", 3),
    (20, User.kataBalazs) => ("🕯️", 4),
    (20, User.mariMatyi) => ("🌲", 5),
    (20, User.dorkaMate) => ("🐑", 5),

    (21, User.zsuzsiKicsim) => ("🌲", 6),
    (21, User.kataBalazs) => ("❄️", 4),
    (21, User.mariMatyi) => ("🐑", 6),
    (21, User.dorkaMate) => ("🕯️", 5), 

    (22, User.zsuzsiKicsim) => ("🕯️", 6),
    (22, User.kataBalazs) => ("🌲", 7),
    (22, User.mariMatyi) => ("❄️", 5),
    (22, User.dorkaMate) => ("🐑", 7), 

    (23, User.zsuzsiKicsim) => ("🌲", 8),   //🔑
    (23, User.kataBalazs) => ("🐑", 8),   //🔑
    (23, User.mariMatyi) => ("🕯️", 7),   //🔑
    (23, User.dorkaMate) => ("❄️", 6),    //🔑


    (24, User.zsuzsiKicsim) => ("🎁", 1),
    (24, User.kataBalazs) => ("🎁", 2),
    (24, User.mariMatyi) => ("🎁", 3),
    (24, User.dorkaMate) => ("🎁", 4),

    _ => ("🌏", 0),
  };


}
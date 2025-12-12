import 'package:advent/clue_bell.dart';
import 'package:advent/clue_elements.dart';
import 'package:advent/task.dart';
import 'package:advent/time.dart';
import 'package:flutter/material.dart';

class TaskDefinitions {
  static List<String> allTaskIDs = ["🌏", "⭐", "🔔", "🍞", "🎀", "📜", "⛄", "📖", "❄️", "🕯️", "🐑", "🌲", "🎁"];

  static Task? getTask(String taskId) => switch (taskId) {
    "🌏" => Task(
      // Task 1:  Zászlók és fővárosok
      icon: taskId, //  Földrajzi nyomok
      clues: [
        ClueImage("Flags1.png"),
        ClueImage("Flags2.png"),
        ClueImage("Flags3.png"),
        ClueImage("Flags4.png"),
        ClueColumn([
          ClueText(
            "Nem egyszerű. Kell hozzá némi ész,\n"
            "hogy a részekből legyen négy egész.\n"
            "A fővárosnál jelölj! Nem máshol, de pont ott!\n"
            "Emlékezz, van úgy hogy …",
          ),
          ClueImage("Indiana.png"),
        ]),
        ClueText("Bár nem az első ki, rávetette szemét, de ő az kitől kapta ünnepi nevét?"),
      ],
      correctSolutions: ["William Mynors", "WilliamMynors"],
    ),

    // Task 2:  Napkeleti bölcsek
    "⭐" => Task(
      icon: taskId,
      clues: [
        ClueImage("StarClue-ThreeWiseMan.png"),
        ClueTimeLock("Star-Sirius.png", "U", Time(06, 45, 09), color: Color.fromARGB(255, 255, 162, 23)),
        ClueTimeLock("Star-Mars.png", "I", Time(17, 15, 36), color: Color.fromARGB(255, 48, 23, 16)),
        ClueTimeLock("Star-Pluto.png", "E", Time(20, 20, 21), color: Color.fromARGB(255, 71, 109, 153)),
        ClueTimeLock("Star-Saturn.png", "R", Time(23, 46, 00), color: Color.fromARGB(255, 117, 30, 30)),
        ClueTimeLock("Star-AlphaCentauri.png", "C", Time(14, 39, 36)),
        ClueTimeLock("Star-Alnilam.png", "L", Time(05, 36, 13), color: Color.fromARGB(255, 62, 93, 107)),
        ClueTimeLock("Star-Andromeda.png", "F", Time(00, 42, 44), color: Color.fromARGB(255, 62, 63, 95)),
        ClueText("Mit szemléltek, ha leszáll az éj?\n A feladványban ez a rejtély."), // !!!
      ],
      correctSolutions: ["Vénusz", "Venus"],
    ),

    // Task 3:  Harangok
    "🔔" => Task(
      icon: taskId,
      clues: [
        ClueBell("Bell6.png", "Bell 6-F.mp3"),
        ClueBell("Bell4.png", "Bell 4-E.mp3"),
        ClueBell("Bell9.png", "Bell 9-D-.mp3"),
        ClueBell("Bell7.png", "Bell 7-B.mp3"),
        ClueBell("Bell8.png", "Bell 8-G.mp3"),
        ClueBell("Bell3.png", "Bell 3-D.mp3"),
        ClueBell("Bell5.png", "Bell 5-A.mp3"),
        ClueText("5 - 6 - 5 - 6 - 3 - 5 - 7 - 3 - 8 - 6 - 5 - 9 - 6 - 4"),
        ClueText("Ki lehet az, ki lehet ő,\na méltán híres zeneszerző?"),
      ],
      correctSolutions: ["John Williams", "JohnWilliams"],
    ),

    // Task 4:   Utolsó vacsora matek
    "🍞" => Task(
      icon: taskId,
      clues: [
        ClueImage("Apostols 1.png"),
        ClueImage("Apostols 2.png"),
        ClueImage("Supper.png"),
        ClueImage("Apostols 3.png"),
        ClueImage("Leonardo.png"),
        ClueColumn([
          ClueImage("Apostols 4.png"),
          ClueText("A kiszámolt megoldást alább betűzd,\nde ne számokat használj hanem betűzd!"),
        ]),
      ],
      correctSolutions: ["Huszonhét"],
    ),

    // ---------------------------------------------------------------------------------------

    // Task 5:  Képek a városból
    "🎀" => Task(
      icon: taskId,
      clues: [
        ClueImage("CityA2.png"),
        ClueImage("CityA1.png"),
        ClueImage("CityB2.png"),
        ClueImage("CityB1.png"),
        ClueImage("CityC2.png"),
        ClueImage("CityC1.png"),
        ClueImage("CityD2.png"),
        ClueImage("CityD1.png"),
        ClueText("Ha megvan a karácsonyfa minden dísze,\ntaláld ki mi köti őket össze?"),
      ],
      correctSolutions: ["Vörös"],
    ),

    // Task 6:  Évszám matek
    "📜" => Task(
      icon: taskId,
      clues: [
        ClueImage("HistorySecondTemple.png"),
        ClueImage("HistoryMohács.png"),
        ClueImage("HistoryMuhammad.png"),
        ClueImage("History1948.png"),
        ClueImage("HistoryCharlamene.png"),
        ClueText("2A - B - 3C + D + 3E = ???"),
        ClueText("Zengnek a harangok, készül a lakoma.\nKinek van ma a legjobb karácsonya?"),
      ],
      correctSolutions: [
        "Hódító Vilmos",
        "HódítóVilmos",
        "Első Vilmos",
        "ElsőVilmos",
        "I. Vilmos",
        "I.Vilmos",
        "Fattyú Vilmos",
        "FattyúVilmos",
        "William the Conqueror",
        "WilliamTheConqueror",
        "WilliamTheFirst",
        "William I",
        "WilliamI",
        "William the Bastard",
        "WilliamTheBastard",
      ],
    ),

    // Task 7:  Karácsonyi filmes halmazelmélet
    "⛄" => Task(
      icon: taskId,
      clues: [
        ClueImage("Snowman.png"),
        ClueImage("Snowman 1.png"),
        ClueImage("Snowman 2.png"),
        ClueImage("Snowman 3.png"),
        ClueImage("Snowman 4.png"),
        ClueImage("Snowman 5.png"),
        ClueImage("Snowman 6.png"),
        ClueImage("Snowman 7.png"),
        ClueImage("Snowman 8.png"),
        ClueText("Találd ki, kit rejt a hóember fej és\nmár meg is van a megfejtés."),
      ],
      correctSolutions: ["Timothy Spall", "TimothySpall"],
    ),

    // Task 8:  Irodalom
    "📖" => Task(
      icon: taskId,
      clues: [
        ClueImage("Literature0.png"),
        ClueImage("Literature1.png"),
        ClueImage("Literature2.png"),
        ClueImage("Literature3.png"),
        ClueImage("Literature4.png"),
        ClueImage("Literature5.png"),
        ClueText("Mindenki a fejét azon törje,\nhogy ki a novella főszerepője!"),
      ],
      correctSolutions: ["János mester", "Jánosmester"],
    ),

    // ---------------------------------------------------------------------------------------

    // Task 9:  Karácsonyi színező
    "❄️" => Task(
      icon: taskId,
      clues: [
        ClueImage("Snowflake0.png"), 
        ClueImage("Snowflake1.png"), 
        ClueImage("Snowflake2.png"), 
        ClueImage("Snowflake3.png"), 
        ClueImage("Snowflake4.png"), 
        ClueText("Találd ki a kifejezést!\nÍrd be a befejezést!"),
      ],
      correctSolutions: ["Domini"],
    ),

    // Task 10: Twelve days of math-mass
    "🕯️" => Task(
      icon: taskId,
      clues: [
        ClueImage("Math1.png"),
        ClueImage("Math5.png"),
        ClueImage("Math3.png"),
        ClueImage("Math2.png"),
        ClueImage("Math4.png"),
        ClueImage("Math0.png"),
        ClueText("A megoldás vajon ki lehet? Írd be azt, hogy hol született!"),
      ],
      correctSolutions: ["Patara"],
    ),

    // Task 11:   Karácsonyi Kriptográfia
    "🐑" => Task(
      icon: taskId,
      clues: [
        ClueImage("Crypto1.png"),
        ClueImage("Crypto2.png"),
        ClueImage("Crypto3.png"),
        ClueImage("Crypto4.png"),
        ClueImage("Crypto5.png"),
        ClueImage("Crypto6.png"),
        ClueImage("Crypto7.png"),
        ClueText("Akinek a megoldás zenél,\naz érti meg, mi az uticél."),
      ],
      correctSolutions: ["Betlehem"],
    ),

    // Task 12:  Városliget térkép és koordináták
    "🌲" => Task(
      icon: taskId,
      clues: [
        ClueImage("StatuesGabriel.png"),
        ClueImage("StatuesX.png"),
        ClueImage("StatuesY.png"),
        ClueText("Beszédes szobor 1:\n(0,443; 0,610)"),
        ClueText("Beszédes szobor 2:\n(0,743; 0,522)"),
        ClueText("Beszédes szobor 3:\n(0,768; 0,912)"),
        ClueText("Beszédes szobor 4:\n(1,319; 1,017)"),
        ClueText(
          " Nincs más dolgod, mindössze \n születési éveiket add össze \n azoknak a személyeknek,\n kikről a szobrok beszélnek. ",
        ),
      ],
      correctSolutions: ["7473", "7 473", "7.473"],
    ),

    // ---------------------------------------------------------------------------------------

    // Cryptex Task
    "🎁" => Task(
      icon: taskId,
      clues: [
        ClueImage("Chabetto.png"),
        ClueImage("Chabetto.png"),
        ClueImage("Chabetto.png"),
        ClueImage("Chabetto.png"),
      ],
      correctSolutions: [], // No solution needed
    ),

    _ => null,
  };
}

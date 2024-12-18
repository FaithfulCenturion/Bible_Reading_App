import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/bible_service.dart';

final bibleProvider = Provider<BibleProvider>((ref) => BibleProvider());

class BibleProvider {
  final BibleService _bibleService = BibleService();

   List<String> get oldTestamentChapters => [
  "genesis-1", "genesis-2", "genesis-3", "genesis-4", "genesis-5", "genesis-6", "genesis-7", "genesis-8", "genesis-9", "genesis-10",
  "genesis-11", "genesis-12", "genesis-13", "genesis-14", "genesis-15", "genesis-16", "genesis-17", "genesis-18", "genesis-19", "genesis-20",
  "genesis-21", "genesis-22", "genesis-23", "genesis-24", "genesis-25", "genesis-26", "genesis-27", "genesis-28", "genesis-29", "genesis-30",
  "genesis-31", "genesis-32", "genesis-33", "genesis-34", "genesis-35", "genesis-36", "genesis-37", "genesis-38", "genesis-39", "genesis-40",
  "genesis-41", "genesis-42", "genesis-43", "genesis-44", "genesis-45", "genesis-46", "genesis-47", "genesis-48", "genesis-49", "genesis-50",
  
  "exodus-1", "exodus-2", "exodus-3", "exodus-4", "exodus-5", "exodus-6", "exodus-7", "exodus-8", "exodus-9", "exodus-10",
  "exodus-11", "exodus-12", "exodus-13", "exodus-14", "exodus-15", "exodus-16", "exodus-17", "exodus-18", "exodus-19", "exodus-20",
  "exodus-21", "exodus-22", "exodus-23", "exodus-24", "exodus-25", "exodus-26", "exodus-27", "exodus-28", "exodus-29", "exodus-30",
  "exodus-31", "exodus-32", "exodus-33", "exodus-34", "exodus-35", "exodus-36", "exodus-37", "exodus-38", "exodus-39", "exodus-40",
  
  "leviticus-1", "leviticus-2", "leviticus-3", "leviticus-4", "leviticus-5", "leviticus-6", "leviticus-7", "leviticus-8", "leviticus-9", "leviticus-10",
  "leviticus-11", "leviticus-12", "leviticus-13", "leviticus-14", "leviticus-15", "leviticus-16", "leviticus-17", "leviticus-18", "leviticus-19", "leviticus-20",
  "leviticus-21", "leviticus-22", "leviticus-23", "leviticus-24", "leviticus-25", "leviticus-26", "leviticus-27",
  
  "numbers-1", "numbers-2", "numbers-3", "numbers-4", "numbers-5", "numbers-6", "numbers-7", "numbers-8", "numbers-9", "numbers-10",
  "numbers-11", "numbers-12", "numbers-13", "numbers-14", "numbers-15", "numbers-16", "numbers-17", "numbers-18", "numbers-19", "numbers-20",
  "numbers-21", "numbers-22", "numbers-23", "numbers-24", "numbers-25", "numbers-26", "numbers-27", "numbers-28", "numbers-29", "numbers-30",
  "numbers-31", "numbers-32", "numbers-33", "numbers-34", "numbers-35", "numbers-36",
  
  "deuteronomy-1", "deuteronomy-2", "deuteronomy-3", "deuteronomy-4", "deuteronomy-5", "deuteronomy-6", "deuteronomy-7", "deuteronomy-8", "deuteronomy-9", "deuteronomy-10",
  "deuteronomy-11", "deuteronomy-12", "deuteronomy-13", "deuteronomy-14", "deuteronomy-15", "deuteronomy-16", "deuteronomy-17", "deuteronomy-18", "deuteronomy-19", "deuteronomy-20",
  "deuteronomy-21", "deuteronomy-22", "deuteronomy-23", "deuteronomy-24", "deuteronomy-25", "deuteronomy-26", "deuteronomy-27", "deuteronomy-28", "deuteronomy-29", "deuteronomy-30",
  "deuteronomy-31", "deuteronomy-32", "deuteronomy-33", "deuteronomy-34",
  
  "joshua-1", "joshua-2", "joshua-3", "joshua-4", "joshua-5", "joshua-6", "joshua-7", "joshua-8", "joshua-9", "joshua-10",
  "joshua-11", "joshua-12", "joshua-13", "joshua-14", "joshua-15", "joshua-16", "joshua-17", "joshua-18", "joshua-19", "joshua-20",
  "joshua-21", "joshua-22", "joshua-23", "joshua-24",
  
  "judges-1", "judges-2", "judges-3", "judges-4", "judges-5", "judges-6", "judges-7", "judges-8", "judges-9", "judges-10",
  "judges-11", "judges-12", "judges-13", "judges-14", "judges-15", "judges-16", "judges-17", "judges-18", "judges-19", "judges-20",
  "judges-21",
  
  "ruth-1", "ruth-2", "ruth-3", "ruth-4",
  
  "1-samuel-1", "1-samuel-2", "1-samuel-3", "1-samuel-4", "1-samuel-5", "1-samuel-6", "1-samuel-7", "1-samuel-8", "1-samuel-9", "1-samuel-10",
  "1-samuel-11", "1-samuel-12", "1-samuel-13", "1-samuel-14", "1-samuel-15", "1-samuel-16", "1-samuel-17", "1-samuel-18", "1-samuel-19", "1-samuel-20",
  "1-samuel-21", "1-samuel-22", "1-samuel-23", "1-samuel-24", "1-samuel-25", "1-samuel-26", "1-samuel-27", "1-samuel-28", "1-samuel-29", "1-samuel-30",
  "1-samuel-31",
  
  "2-samuel-1", "2-samuel-2", "2-samuel-3", "2-samuel-4", "2-samuel-5", "2-samuel-6", "2-samuel-7", "2-samuel-8", "2-samuel-9", "2-samuel-10",
  "2-samuel-11", "2-samuel-12", "2-samuel-13", "2-samuel-14", "2-samuel-15", "2-samuel-16", "2-samuel-17", "2-samuel-18", "2-samuel-19", "2-samuel-20",
  "2-samuel-21", "2-samuel-22", "2-samuel-23", "2-samuel-24",
  
  "1-kings-1", "1-kings-2", "1-kings-3", "1-kings-4", "1-kings-5", "1-kings-6", "1-kings-7", "1-kings-8", "1-kings-9", "1-kings-10",
  "1-kings-11", "1-kings-12", "1-kings-13", "1-kings-14", "1-kings-15", "1-kings-16", "1-kings-17", "1-kings-18", "1-kings-19", "1-kings-20",
  "1-kings-21", "1-kings-22",
  
  "2-kings-1", "2-kings-2", "2-kings-3", "2-kings-4", "2-kings-5", "2-kings-6", "2-kings-7", "2-kings-8", "2-kings-9", "2-kings-10",
  "2-kings-11", "2-kings-12", "2-kings-13", "2-kings-14", "2-kings-15", "2-kings-16", "2-kings-17", "2-kings-18", "2-kings-19", "2-kings-20",
  "2-kings-21", "2-kings-22", "2-kings-23", "2-kings-24", "2-kings-25",
  
  "1-chronicles-1", "1-chronicles-2", "1-chronicles-3", "1-chronicles-4", "1-chronicles-5", "1-chronicles-6", "1-chronicles-7", "1-chronicles-8", "1-chronicles-9", "1-chronicles-10",
  "1-chronicles-11", "1-chronicles-12", "1-chronicles-13", "1-chronicles-14", "1-chronicles-15", "1-chronicles-16", "1-chronicles-17", "1-chronicles-18", "1-chronicles-19", "1-chronicles-20",
  "1-chronicles-21", "1-chronicles-22", "1-chronicles-23", "1-chronicles-24", "1-chronicles-25", "1-chronicles-26", "1-chronicles-27", "1-chronicles-28", "1-chronicles-29",
  
  "2-chronicles-1", "2-chronicles-2", "2-chronicles-3", "2-chronicles-4", "2-chronicles-5", "2-chronicles-6", "2-chronicles-7", "2-chronicles-8", "2-chronicles-9", "2-chronicles-10",
  "2-chronicles-11", "2-chronicles-12", "2-chronicles-13", "2-chronicles-14", "2-chronicles-15", "2-chronicles-16", "2-chronicles-17", "2-chronicles-18", "2-chronicles-19", "2-chronicles-20",
  "2-chronicles-21", "2-chronicles-22", "2-chronicles-23", "2-chronicles-24", "2-chronicles-25", "2-chronicles-26", "2-chronicles-27", "2-chronicles-28", "2-chronicles-29",
  "2-chronicles-30", "2-chronicles-31", "2-chronicles-32", "2-chronicles-33", "2-chronicles-34", "2-chronicles-35", "2-chronicles-36",
  
  "ezra-1", "ezra-2", "ezra-3", "ezra-4", "ezra-5", "ezra-6", "ezra-7", "ezra-8", "ezra-9", "ezra-10",
  
  "nehemiah-1", "nehemiah-2", "nehemiah-3", "nehemiah-4", "nehemiah-5", "nehemiah-6", "nehemiah-7", "nehemiah-8", "nehemiah-9", "nehemiah-10",
  "nehemiah-11", "nehemiah-12", "nehemiah-13",
  
  "esther-1", "esther-2", "esther-3", "esther-4", "esther-5", "esther-6", "esther-7", "esther-8", "esther-9", "esther-10",
  
  "job-1", "job-2", "job-3", "job-4", "job-5", "job-6", "job-7", "job-8", "job-9", "job-10",
  "job-11", "job-12", "job-13", "job-14", "job-15", "job-16", "job-17", "job-18", "job-19", "job-20",
  "job-21", "job-22", "job-23", "job-24", "job-25", "job-26", "job-27", "job-28", "job-29", "job-30",
  "job-31", "job-32", "job-33", "job-34", "job-35", "job-36", "job-37", "job-38", "job-39", "job-40",
  "job-41", "job-42",
  
  "psalms-1", "psalms-2", "psalms-3", "psalms-4", "psalms-5", "psalms-6", "psalms-7", "psalms-8", "psalms-9", "psalms-10",
  "psalms-11", "psalms-12", "psalms-13", "psalms-14", "psalms-15", "psalms-16", "psalms-17", "psalms-18", "psalms-19", "psalms-20",
  "psalms-21", "psalms-22", "psalms-23", "psalms-24", "psalms-25", "psalms-26", "psalms-27", "psalms-28", "psalms-29", "psalms-30",
  "psalms-31", "psalms-32", "psalms-33", "psalms-34", "psalms-35", "psalms-36", "psalms-37", "psalms-38", "psalms-39", "psalms-40",
  "psalms-41", "psalms-42", "psalms-43", "psalms-44", "psalms-45", "psalms-46", "psalms-47", "psalms-48", "psalms-49", "psalms-50",
  "psalms-51", "psalms-52", "psalms-53", "psalms-54", "psalms-55", "psalms-56", "psalms-57", "psalms-58", "psalms-59", "psalms-60",
  "psalms-61", "psalms-62", "psalms-63", "psalms-64", "psalms-65", "psalms-66", "psalms-67", "psalms-68", "psalms-69", "psalms-70",
  "psalms-71", "psalms-72", "psalms-73", "psalms-74", "psalms-75", "psalms-76", "psalms-77", "psalms-78", "psalms-79", "psalms-80",
  "psalms-81", "psalms-82", "psalms-83", "psalms-84", "psalms-85", "psalms-86", "psalms-87", "psalms-88", "psalms-89", "psalms-90",
  "psalms-91", "psalms-92", "psalms-93", "psalms-94", "psalms-95", "psalms-96", "psalms-97", "psalms-98", "psalms-99", "psalms-100",
  "psalms-101", "psalms-102", "psalms-103", "psalms-104", "psalms-105", "psalms-106", "psalms-107", "psalms-108", "psalms-109", "psalms-110",
  "psalms-111", "psalms-112", "psalms-113", "psalms-114", "psalms-115", "psalms-116", "psalms-117", "psalms-118", "psalms-119", "psalms-120",
  "psalms-121", "psalms-122", "psalms-123", "psalms-124", "psalms-125", "psalms-126", "psalms-127", "psalms-128", "psalms-129", "psalms-130",
  "psalms-131", "psalms-132", "psalms-133", "psalms-134", "psalms-135", "psalms-136", "psalms-137", "psalms-138", "psalms-139", "psalms-140",
  "psalms-141", "psalms-142", "psalms-143", "psalms-144", "psalms-145", "psalms-146", "psalms-147", "psalms-148", "psalms-149", "psalms-150",
  
  "proverbs-1", "proverbs-2", "proverbs-3", "proverbs-4", "proverbs-5", "proverbs-6", "proverbs-7", "proverbs-8", "proverbs-9", "proverbs-10",
  "proverbs-11", "proverbs-12", "proverbs-13", "proverbs-14", "proverbs-15", "proverbs-16", "proverbs-17", "proverbs-18", "proverbs-19", "proverbs-20",
  "proverbs-21", "proverbs-22", "proverbs-23", "proverbs-24", "proverbs-25", "proverbs-26", "proverbs-27", "proverbs-28", "proverbs-29", "proverbs-30",
  "proverbs-31",
  
  "ecclesiastes-1", "ecclesiastes-2", "ecclesiastes-3", "ecclesiastes-4", "ecclesiastes-5", "ecclesiastes-6", "ecclesiastes-7", "ecclesiastes-8", "ecclesiastes-9", "ecclesiastes-10",
  "ecclesiastes-11", "ecclesiastes-12",
  
  "song-of-solomon-1", "song-of-solomon-2", "song-of-solomon-3", "song-of-solomon-4", "song-of-solomon-5", "song-of-solomon-6", "song-of-solomon-7", "song-of-solomon-8",
 
 "isaiah-1", "isaiah-2", "isaiah-3", "isaiah-4", "isaiah-5", "isaiah-6", "isaiah-7", "isaiah-8", "isaiah-9", "isaiah-10",
  "isaiah-11", "isaiah-12", "isaiah-13", "isaiah-14", "isaiah-15", "isaiah-16", "isaiah-17", "isaiah-18", "isaiah-19", "isaiah-20",
  "isaiah-21", "isaiah-22", "isaiah-23", "isaiah-24", "isaiah-25", "isaiah-26", "isaiah-27", "isaiah-28", "isaiah-29", "isaiah-30",
  "isaiah-31", "isaiah-32", "isaiah-33", "isaiah-34", "isaiah-35", "isaiah-36", "isaiah-37", "isaiah-38", "isaiah-39", "isaiah-40",
  "isaiah-41", "isaiah-42", "isaiah-43", "isaiah-44", "isaiah-45", "isaiah-46", "isaiah-47", "isaiah-48", "isaiah-49", "isaiah-50",
  "isaiah-51", "isaiah-52", "isaiah-53", "isaiah-54", "isaiah-55", "isaiah-56", "isaiah-57", "isaiah-58", "isaiah-59", "isaiah-60",
  "isaiah-61", "isaiah-62", "isaiah-63", "isaiah-64", "isaiah-65", "isaiah-66",
  
  "jeremiah-1", "jeremiah-2", "jeremiah-3", "jeremiah-4", "jeremiah-5", "jeremiah-6", "jeremiah-7", "jeremiah-8", "jeremiah-9", "jeremiah-10",
  "jeremiah-11", "jeremiah-12", "jeremiah-13", "jeremiah-14", "jeremiah-15", "jeremiah-16", "jeremiah-17", "jeremiah-18", "jeremiah-19", "jeremiah-20",
  "jeremiah-21", "jeremiah-22", "jeremiah-23", "jeremiah-24", "jeremiah-25", "jeremiah-26", "jeremiah-27", "jeremiah-28", "jeremiah-29",
  "jeremiah-30", "jeremiah-31", "jeremiah-32", "jeremiah-33", "jeremiah-34", "jeremiah-35", "jeremiah-36", "jeremiah-37", "jeremiah-38",
  "jeremiah-39", "jeremiah-40", "jeremiah-41", "jeremiah-42", "jeremiah-43", "jeremiah-44", "jeremiah-45", "jeremiah-46", "jeremiah-47",
  "jeremiah-48", "jeremiah-49", "jeremiah-50", "jeremiah-51", "jeremiah-52",
  
  "lamentations-1", "lamentations-2", "lamentations-3", "lamentations-4", "lamentations-5",
  
  "ezekiel-1", "ezekiel-2", "ezekiel-3", "ezekiel-4", "ezekiel-5", "ezekiel-6", "ezekiel-7", "ezekiel-8", "ezekiel-9", "ezekiel-10",
  "ezekiel-11", "ezekiel-12", "ezekiel-13", "ezekiel-14", "ezekiel-15", "ezekiel-16", "ezekiel-17", "ezekiel-18", "ezekiel-19", "ezekiel-20",
  "ezekiel-21", "ezekiel-22", "ezekiel-23", "ezekiel-24", "ezekiel-25", "ezekiel-26", "ezekiel-27", "ezekiel-28", "ezekiel-29",
  "ezekiel-30", "ezekiel-31", "ezekiel-32", "ezekiel-33", "ezekiel-34", "ezekiel-35", "ezekiel-36", "ezekiel-37", "ezekiel-38",
  "ezekiel-39", "ezekiel-40", "ezekiel-41", "ezekiel-42", "ezekiel-43", "ezekiel-44", "ezekiel-45", "ezekiel-46", "ezekiel-47",
  "ezekiel-48",
  
  "daniel-1", "daniel-2", "daniel-3", "daniel-4", "daniel-5", "daniel-6", "daniel-7", "daniel-8", "daniel-9", "daniel-10",
  "daniel-11", "daniel-12",
  
  "hosea-1", "hosea-2", "hosea-3", "hosea-4", "hosea-5", "hosea-6", "hosea-7", "hosea-8", "hosea-9", "hosea-10",
  "hosea-11", "hosea-12", "hosea-13", "hosea-14",
  
  "joel-1", "joel-2", "joel-3",
  
  "amos-1", "amos-2", "amos-3", "amos-4", "amos-5", "amos-6", "amos-7", "amos-8", "amos-9",
  
  "obadiah-1",
  
  "jonah-1", "jonah-2", "jonah-3", "jonah-4",
  
  "micah-1", "micah-2", "micah-3", "micah-4", "micah-5", "micah-6", "micah-7",
  
  "nahum-1", "nahum-2", "nahum-3",
  
  "habakkuk-1", "habakkuk-2", "habakkuk-3",
  
  "zephaniah-1", "zephaniah-2", "zephaniah-3",
  
  "haggai-1", "haggai-2",
  
  "zechariah-1", "zechariah-2", "zechariah-3", "zechariah-4", "zechariah-5", "zechariah-6", "zechariah-7", "zechariah-8", "zechariah-9",
  "zechariah-10", "zechariah-11", "zechariah-12", "zechariah-13", "zechariah-14",
  
  "malachi-1", "malachi-2", "malachi-3", "malachi-4"
];

List<String> get apocryphaChapters => [
  '1-maccabees-1', '1-maccabees-2', '1-maccabees-3', '1-maccabees-4', '1-maccabees-5', '1-maccabees-6', '1-maccabees-7', '1-maccabees-8', '1-maccabees-9', '1-maccabees-10', 
  '1-maccabees-11', '1-maccabees-12', '1-maccabees-13', '1-maccabees-14', '1-maccabees-15', '1-maccabees-16',
  '2-maccabees-1', '2-maccabees-2', '2-maccabees-3', '2-maccabees-4', '2-maccabees-5', '2-maccabees-6', '2-maccabees-7', '2-maccabees-8', '2-maccabees-9', '2-maccabees-10', 
  '2-maccabees-11', '2-maccabees-12', '2-maccabees-13', '2-maccabees-14', '2-maccabees-15', '2-maccabees-16', 
  'tobit-1', 'tobit-2', 'tobit-3', 'tobit-4', 'tobit-5', 'tobit-6', 'tobit-7', 'tobit-8', 'tobit-9', 'tobit-10', 
  'tobit-11', 'tobit-12', 'tobit-13', 'tobit-14',
  'judith-1', 'judith-2', 'judith-3', 'judith-4', 'judith-5', 'judith-6', 'judith-7', 'judith-8', 'judith-9', 'judith-10', 
  'judith-11', 'judith-12', 'judith-13', 'judith-14', 'judith-15', 
  'wisdom-1', 'wisdom-2', 'wisdom-3', 'wisdom-4', 'wisdom-5', 'wisdom-6', 'wisdom-7', 'wisdom-8', 'wisdom-9', 'wisdom-10', 
  'wisdom-11', 'wisdom-12', 'wisdom-13', 'wisdom-14', 'wisdom-15', 'wisdom-16', 'wisdom-17', 'wisdom-18',
  'sirach-1', 'sirach-2', 'sirach-3', 'sirach-4', 'sirach-5', 'sirach-6', 'sirach-7', 'sirach-8', 'sirach-9', 'sirach-10', 
  'sirach-11', 'sirach-12', 'sirach-13', 'sirach-14', 'sirach-15', 'sirach-16', 'sirach-17', 'sirach-18', 'sirach-19', 
  'sirach-20', 'sirach-21', 'sirach-22', 'sirach-23', 'sirach-24', 'sirach-25', 'sirach-26', 'sirach-27', 'sirach-28', 
  'sirach-29', 'sirach-30', 'sirach-31', 'sirach-32', 'sirach-33', 'sirach-34', 'sirach-35', 'sirach-36', 'sirach-37',
  'baruch-1', 'baruch-2', 'baruch-3', 'baruch-4', 'baruch-5', 'baruch-6', 
  'letter-of-jeremiah-1', 
  'prayer-of-azariah-1', 'prayer-of-manasseh-1',
  '1-esdras-1', '1-esdras-2', '1-esdras-3', '1-esdras-4', '1-esdras-5', '1-esdras-6', '1-esdras-7', '1-esdras-8', 
  '1-esdras-9', '1-esdras-10',
  '2-esdras-1', '2-esdras-2', '2-esdras-3', '2-esdras-4', '2-esdras-5', '2-esdras-6', '2-esdras-7', '2-esdras-8', 
  '2-esdras-9', '2-esdras-10', '2-esdras-11', '2-esdras-12', '2-esdras-13', '2-esdras-14',
  'additions-to-daniel-1', 'additions-to-daniel-2', 'additions-to-daniel-3',
  'prayer-of-manasseh-1'
];

List<String> get newTestamentChapters => [
   'matthew-1', 'matthew-2', 'matthew-3', 'matthew-4', 'matthew-5', 'matthew-6', 'matthew-7', 'matthew-8', 'matthew-9', 'matthew-10',
  'matthew-11', 'matthew-12', 'matthew-13', 'matthew-14', 'matthew-15', 'matthew-16', 'matthew-17', 'matthew-18', 'matthew-19', 'matthew-20',
  'matthew-21', 'matthew-22', 'matthew-23', 'matthew-24', 'matthew-25', 'matthew-26', 'matthew-27', 'matthew-28',
  'mark-1', 'mark-2', 'mark-3', 'mark-4', 'mark-5', 'mark-6', 'mark-7', 'mark-8', 'mark-9', 'mark-10',
  'mark-11', 'mark-12', 'mark-13', 'mark-14', 'mark-15', 'mark-16',
  'luke-1', 'luke-2', 'luke-3', 'luke-4', 'luke-5', 'luke-6', 'luke-7', 'luke-8', 'luke-9', 'luke-10',
  'luke-11', 'luke-12', 'luke-13', 'luke-14', 'luke-15', 'luke-16', 'luke-17', 'luke-18', 'luke-19', 'luke-20',
  'luke-21', 'luke-22', 'luke-23', 'luke-24',
  'john-1', 'john-2', 'john-3', 'john-4', 'john-5', 'john-6', 'john-7', 'john-8', 'john-9', 'john-10',
  'john-11', 'john-12', 'john-13', 'john-14', 'john-15', 'john-16', 'john-17', 'john-18', 'john-19', 'john-20',
  'john-21',
  'acts-1', 'acts-2', 'acts-3', 'acts-4', 'acts-5', 'acts-6', 'acts-7', 'acts-8', 'acts-9', 'acts-10',
  'acts-11', 'acts-12', 'acts-13', 'acts-14', 'acts-15', 'acts-16', 'acts-17', 'acts-18', 'acts-19', 'acts-20',
  'acts-21', 'acts-22', 'acts-23', 'acts-24', 'acts-25', 'acts-26', 'acts-27', 'acts-28',
  'romans-1', 'romans-2', 'romans-3', 'romans-4', 'romans-5', 'romans-6', 'romans-7', 'romans-8', 'romans-9', 'romans-10',
  'romans-11', 'romans-12', 'romans-13', 'romans-14', 'romans-15', 'romans-16',
  '1-corinthians-1', '1-corinthians-2', '1-corinthians-3', '1-corinthians-4', '1-corinthians-5', '1-corinthians-6', '1-corinthians-7', '1-corinthians-8', '1-corinthians-9', '1-corinthians-10',
  '1-corinthians-11', '1-corinthians-12', '1-corinthians-13', '1-corinthians-14', '1-corinthians-15', '1-corinthians-16',
  '2-corinthians-1', '2-corinthians-2', '2-corinthians-3', '2-corinthians-4', '2-corinthians-5', '2-corinthians-6', '2-corinthians-7', '2-corinthians-8', '2-corinthians-9', '2-corinthians-10',
  '2-corinthians-11', '2-corinthians-12', '2-corinthians-13',
  'galatians-1', 'galatians-2', 'galatians-3', 'galatians-4', 'galatians-5', 'galatians-6',
  'ephesians-1', 'ephesians-2', 'ephesians-3', 'ephesians-4', 'ephesians-5', 'ephesians-6',
  'philippians-1', 'philippians-2', 'philippians-3', 'philippians-4',
  'colossians-1', 'colossians-2', 'colossians-3', 'colossians-4',
  '1-thessalonians-1', '1-thessalonians-2', '1-thessalonians-3', '1-thessalonians-4', '1-thessalonians-5',
  '2-thessalonians-1', '2-thessalonians-2', '2-thessalonians-3',
  '1-timothy-1', '1-timothy-2', '1-timothy-3', '1-timothy-4', '1-timothy-5', '1-timothy-6',
  '2-timothy-1', '2-timothy-2', '2-timothy-3', '2-timothy-4',
  'titus-1', 'titus-2', 'titus-3',
  'philemon-1',
  'hebrews-1', 'hebrews-2', 'hebrews-3', 'hebrews-4', 'hebrews-5', 'hebrews-6', 'hebrews-7', 'hebrews-8', 'hebrews-9', 'hebrews-10',
  'hebrews-11', 'hebrews-12', 'hebrews-13',
  'james-1', 'james-2', 'james-3', 'james-4', 'james-5',
  '1-peter-1', '1-peter-2', '1-peter-3', '1-peter-4', '1-peter-5',
  '2-peter-1', '2-peter-2', '2-peter-3',
  '1-john-1', '1-john-2', '1-john-3', '1-john-4', '1-john-5',
  '2-john-1',
  '3-john-1',
  'jude-1',
  'revelation-1', 'revelation-2', 'revelation-3', 'revelation-4', 'revelation-5', 'revelation-6', 'revelation-7', 'revelation-8', 'revelation-9', 'revelation-10',
  'revelation-11', 'revelation-12', 'revelation-13', 'revelation-14', 'revelation-15', 'revelation-16', 'revelation-17', 'revelation-18', 'revelation-19', 'revelation-20',
  'revelation-21', 'revelation-22'
];



  Future<List<String>> loadVerses(List<String> chapters) async {
    List<String> versesList = [];
    for (var chapterId in chapters) {
      final verses = await _bibleService.fetchText(chapterId);
      for (var verse in verses) {
        versesList.add(verse['text']);
      }
    }
    return versesList;
  }
}

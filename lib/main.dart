import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const DystopianCalendarApp());
}

class DystopianCalendarApp extends StatelessWidget {
  const DystopianCalendarApp({super.key}); // Using super.key as suggested

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dystopian Calendar',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // Dark background
        primaryColor: Colors.white, // White accents
        fontFamily: 'VT323', // A futuristic pixelated font for a glitchy look
        textTheme: const TextTheme(
          headlineLarge: TextStyle( // Changed from headline1
            color: Colors.white,
            fontSize: 32.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 4.0,
          ),
          bodyLarge: TextStyle( // Changed from bodyText1
            color: Colors.white70,
            fontSize: 16.0,
            letterSpacing: 2.0,
          ),
        ),
      ),
      home: const CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key}); // Updated here

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MEMENTO MORI',
          style: Theme.of(context).textTheme.headlineLarge, // Updated
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.white12, // Faint white glow for dystopian feel
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildGlitchingText("Calendar Matrix"),
            const SizedBox(height: 20.0),
            _buildDecayedContainer(
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                  defaultTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlitchingText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        color: Colors.white,
        letterSpacing: 3.0,
        fontWeight: FontWeight.w900,
        shadows: [
          Shadow(offset: Offset(2, 2), blurRadius: 10, color: Colors.white10),
        ],
      ),
    );
  }

  Widget _buildDecayedContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.white24,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}

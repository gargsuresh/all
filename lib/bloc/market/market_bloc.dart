import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:all/repository/models/market_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'market_event.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  MarketBloc() : super(MarketInitial()) {
    on<FetchMarkets>((event, emit) async {
      emit(MarketLoading());
      try {
        final response = await http.get(Uri.parse("https://www.atozmatka.com/api/get_markets.php"));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final marketsJson = data["markets"] as List;
          final List<Market> fetchedMarkets = marketsJson.map((e) => Market.fromJson(e)).toList();

          // Sort by open time
          fetchedMarkets.sort((a, b) {
            DateTime parseTime(String time) {
              final inputFormat = RegExp(r"(\d{1,2}):(\d{2})\s?(AM|PM)", caseSensitive: false);
              final match = inputFormat.firstMatch(time);
              if (match != null) {
                int hour = int.parse(match.group(1)!);
                int minute = int.parse(match.group(2)!);
                String period = match.group(3)!.toUpperCase();
                if (period == "PM" && hour != 12) hour += 12;
                if (period == "AM" && hour == 12) hour = 0;
                return DateTime.now().copyWith(hour: hour, minute: minute);
              }
              return DateTime.now();
            }

            return parseTime(a.opent).compareTo(parseTime(b.opent));
          });

          emit(MarketLoaded(markets: fetchedMarkets));
        } else {
          emit(MarketError(message: "Failed to load markets"));
        }
      } catch (e) {
        emit(MarketError(message: e.toString()));
      }
    });
  }
}

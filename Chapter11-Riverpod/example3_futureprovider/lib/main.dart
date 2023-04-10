import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Riverpod Course',
      home: HomePage(),
    );
  }
}

enum City {
  stockholm,
  paris,
  tokyo,
  london,
}

final weathers = {
  City.stockholm: '⛱️',
  City.paris: '🌬️',
  City.tokyo: '❄️',
  City.london: '🌪️',
};

const unknownWeatherEmoji = '😊';

typedef WeatherEmoji = String;

Future<String> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => weathers[city]!,
  );
}

// UI reads and writes to this
final currentCityProvider = StateProvider<City?>((ref) {
  return null;
});

// UI reads this
final currentWeatherProvider = FutureProvider<WeatherEmoji>((ref) async {
  final city = ref.watch(currentCityProvider);
  if (city == null) {
    return Future.value(unknownWeatherEmoji);
  } else {
    return getWeather(city);
  }
});

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<WeatherEmoji> weather = ref.watch(currentWeatherProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FuturePrivider Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 120,
              child: Center(
                child: weather.when(
                  data: (data) => Text(
                    data,
                    style: const TextStyle(fontSize: 60),
                  ),
                  error: (e, _) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final city = City.values[index];
                // final isSelected = city == ref.watch(cityProvider);
                // return ListTile(
                //   title: Text(city.name),
                //   trailing: isSelected ? const Icon(Icons.check) : null,
                //   onTap: () {
                //     ref.read(cityProvider.notifier).state = city;
                //   },
                // );
                return RadioListTile<City>(
                  title: Text(city.name),
                  value: city,
                  groupValue: ref.read(currentCityProvider),
                  onChanged: (City? value) {
                    ref.read(currentCityProvider.notifier).state = value;
                  },
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: City.values.length,
            ),
          ),
        ],
      ),
    );
  }
}

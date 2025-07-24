import 'package:cadenceandwattscalc/features/info/components/infotext.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: const [
            Text(
              'CDA',
              style: TextStyle(fontSize: 30),
            ),
            InfoText(text: 'A typical range for a cyclists CdA (coefficient of drag area) value would be between 0.25 and 0.35, with a very good time trialist potentially reaching as low as 0.20, while a recreational rider in a less aerodynamic position might be closer to 0.35; essentially, the lower the CdA, the more aerodynamic the rider is.'),
            SizedBox(height: 5,),
            InfoText(text: 'CdA values based on riding position:'),
            InfoText(text: 'Riding on the tops: > 0.4'),
            InfoText(text: 'Riding on the hoods: around 0.32'),
            InfoText(text: 'Riding on the drops: around 0.30'),
            InfoText(text: 'Riding on aero bars (optimized): around 0.26'),
            SizedBox(height: 12),
            Text('Rolling Resistance', style: TextStyle(fontSize: 30),),
            InfoText(text: 'A typical rolling resistance coefficient (Crr) for a high-quality road bike tire is around 0.0025 to 0.005; meaning for every kilogram of weight on the wheel, the rolling resistance force is between 2.5 and 5 grams.'),
            InfoText(text: 'Key points about rolling resistance values in cycling:'),
            InfoText(text: 'Lower is better:'),
            InfoText(text: 'A lower Crr value indicates less resistance, making it easier to roll the tire and saving energy.'),
            InfoText(text: 'Tire type matters:'),
            InfoText(text: 'High-performance road tires will have significantly lower Crr values compared to wider, more comfortable tires designed for off-road use.'),
            InfoText(text: 'Factors affecting Crr:'),
            InfoText(text: 'Inflation pressure, road surface condition, tire tread pattern, and temperature can all influence rolling resistance.'),
            SizedBox(height: 5),
            InfoText(text: 'Example scenarios:'),
            InfoText(text: 'High-end road race tire: Crr of 0.002'),
            InfoText(text: 'Mid-range road tire: Crr of 0.003'),
            InfoText(text: 'Gravel bike tire: Crr around 0.004'),
            SizedBox(height: 12),
            Text('Drivetrain Efficiency',
              style: TextStyle(fontSize: 30),
            ),
            InfoText(text: 'A typical cycling drivetrain efficiency for a well-maintained, high-end setup can range between 95% and 98%, meaning that for every 100 watts of power put into the pedals, around 95-98 watts are delivered to the wheels; however, this can vary depending on factors like chain wear, lubrication, gear selection, and power output, with lower power outputs generally resulting in slightly lower efficiency.'),
            SizedBox(height: 5),
            InfoText(text: 'efficiency values based on drivetrain type: '),
            InfoText(text: 'High-end road bike drivetrain: 97-99% '),
            InfoText(text: 'Mid-range road bike drivetrain 95-97% '),
            InfoText(text: 'Mountain bike drivetrain: 92-95% '),
            Text('Wheel Diameter',
              style: TextStyle(fontSize: 30),
            ),
            InfoText(text: 'Measure your wheel diameter including tire size'),
            InfoText(text: 'Wheel diameter is preset to 680mm (My Bike)'),
          ],
        ),
      ),
    );
  }
}

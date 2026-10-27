import 'package:flutter_test/flutter_test.dart';
import 'package:koinkard/ui/views/home/home_viewmodel.dart';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewModel -', () {
    test('exposes the expected greeting and profile summary', () {
      final model = getModel();

      expect(model.greeting, 'Good morning!');
      expect(model.userName, 'Adebanji');
      expect(model.balanceLabel, 'Total Balance');
      expect(model.balance, '₦56,893.30');
    });

    test('provides three quick actions and four crypto shortcuts', () {
      final model = getModel();

      expect(model.quickActions.length, 3);
      expect(model.quickActions.first.label, 'Deposit');
      expect(
        model.cryptoShortcuts.map((shortcut) => shortcut.title),
        ['Bitcoin', 'Ethereum', 'USDT', 'USDC'],
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:koinkard/ui/views/receipts/receipts_viewmodel.dart';

void main() {
  group('ReceiptsViewModel -', () {
    test('provides recent transactions with completed status', () {
      final model = ReceiptsViewModel();

      expect(model.recentTransactions, isNotEmpty);
      expect(
        model.recentTransactions.every(
          (transaction) => transaction.status == 'Completed',
        ),
        isTrue,
      );
    });
  });
}

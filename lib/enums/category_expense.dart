enum CategoryExpense {
  an(0, "Ăn uống"),
  dien(1, "Điện"),
  nuoc(2, "Nước"),
  dichVu(3, "Dịch vụ"),
  xe(4, "Xe");

  final int value;
  final String label;

  const CategoryExpense(this.value, this.label);

  /// Lấy enum từ value
  static CategoryExpense? fromValue(int value) {
    try {
      return CategoryExpense.values.firstWhere((e) => e.value == value);
    } catch (_) {
      return null;
    }
  }

  /// Lấy label từ value
  static String labelFromValue(int value) {
    final category = fromValue(value);
    if (category == null) {
      return 'Không xác định';
    }
    return category.label;
  }
}

class Budget {
  final String id;
  final String category;
  final String icon;
  final double budgeted;
  final double spent;

  const Budget({
    required this.id,
    required this.category,
    required this.icon,
    required this.budgeted,
    required this.spent,
  });
}
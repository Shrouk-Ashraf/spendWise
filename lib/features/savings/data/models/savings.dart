class SavingsGoal {
  final String id;
  final String name;
  final String icon;
  final double target;
  final double saved;

  const SavingsGoal({
    required this.id,
    required this.name,
    required this.icon,
    required this.target,
    required this.saved,
  });
}

final List<SavingsGoal> savingsGoals = [
  const SavingsGoal(id: '1', name: 'Emergency Fund',  icon: 'shield', target: 5000, saved: 5000),
  const SavingsGoal(id: '2', name: 'Vacation',         icon: 'plane',  target: 3000, saved: 1200),
  const SavingsGoal(id: '3', name: 'New Laptop',       icon: 'laptop', target: 1500, saved: 900),
  const SavingsGoal(id: '4', name: 'New Car',          icon: 'car',    target: 20000, saved: 4500),
];
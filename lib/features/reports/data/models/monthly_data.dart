class MonthlyData {
  final String month;
  final double income;
  final double expenses;
  const MonthlyData(this.month, this.income, this.expenses);
}
final monthlyChartData = [
  const MonthlyData('Jan', 2400, 1800),
  const MonthlyData('Feb', 2200, 1600),
  const MonthlyData('Mar', 2800, 2100),
  const MonthlyData('Apr', 2600, 1900),
  const MonthlyData('May', 3000, 2200),
  const MonthlyData('Jun', 2650, 1800),
];

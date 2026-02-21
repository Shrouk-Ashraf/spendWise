
import 'dart:ui';

class CategoryData {
  final String name;
  final double value;
  final Color color;
  const CategoryData(this.name, this.value, this.color);
}


final categoryPieData = [
  const CategoryData('Food',          320, Color(0xFF4CAF50)),
  const CategoryData('Shopping',      410, Color(0xFF2196F3)),
  const CategoryData('Transport',     150, Color(0xFFFF9800)),
  const CategoryData('Bills',         400, Color(0xFF9C27B0)),
  const CategoryData('Entertainment',  60, Color(0xFFFF5722)),
];
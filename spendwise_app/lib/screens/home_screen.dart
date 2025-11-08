import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // để hiển thị ngày tháng đẹp

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('dd/MM/yyyy').format(now);

    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: const Text(
          "SpendWise",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                currentDate,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSummaryCard(),
            const SizedBox(height: 10),
            _buildQuickActions(),
            const SizedBox(height: 20),
            _buildRecentTransactions(),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF9F9F9),
    );
  }

  // ------------------ Drawer (thanh điều hướng bên trái) ------------------
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text(
              "SpendWise",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Trang chủ"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text("Giao dịch"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.pie_chart_outline),
            title: const Text("Báo cáo"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.savings),
            title: const Text("Ngân sách"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Cài đặt"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ------------------ Card tổng quan thu chi ------------------
  Widget _buildSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tháng 11 / 2025",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Thu nhập: 12,000,000₫", style: TextStyle(color: Colors.green)),
                    Text("Chi tiêu: 5,200,000₫", style: TextStyle(color: Colors.red)),
                    Text("Còn lại: 6,800,000₫", style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                Icon(Icons.pie_chart_outline_rounded, size: 50, color: Colors.green),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ------------------ Quick Actions ------------------
  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildAction(Icons.remove_circle_outline, "Chi tiêu"),
          _buildAction(Icons.add_circle_outline, "Thu nhập"),
          _buildAction(Icons.bar_chart_rounded, "Báo cáo"),
          _buildAction(Icons.savings_outlined, "Ngân sách"),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green[50],
          child: Icon(icon, color: Colors.green),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // ------------------ Danh sách giao dịch gần đây ------------------
  Widget _buildRecentTransactions() {
    final transactions = [
      {"title": "🍜 Ăn uống", "amount": "-80,000₫", "time": "14:00"},
      {"title": "⛽ Xăng xe", "amount": "-50,000₫", "time": "10:30"},
      {"title": "💼 Lương tháng 11", "amount": "+12,000,000₫", "time": "09:00"},
      {"title": "🏠 Tiền trọ", "amount": "-1,000,000₫", "time": "07:30"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Giao dịch gần đây",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(onPressed: () {}, child: const Text("Xem tất cả")),
            ],
          ),
          ...transactions.map((t) => _transactionItem(
                t["title"]!,
                t["amount"]!,
                t["time"]!,
              )),
        ],
      ),
    );
  }

  Widget _transactionItem(String title, String amount, String time) {
    final isIncome = amount.startsWith('+');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amount,
                style: TextStyle(
                    color: isIncome ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500)),
            Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

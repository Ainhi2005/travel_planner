import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:travel_planner/core/database/database_provider.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('DatabaseProvider should be initialized', () async {
    final dbProvider = DatabaseProvider();
    final db = await dbProvider.database;
    expect(db, isNotNull);
    await dbProvider.close();
  });

  test('All tables should be created', () async {
    final dbProvider = DatabaseProvider();
    final db = await dbProvider.database;
    
    // Kiểm tra các bảng đã được tạo
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table'"
    );
    
    final tableNames = result.map((row) => row['name'] as String).toList();
    
    expect(tableNames.contains('users'), true);
    expect(tableNames.contains('trips'), true);
    expect(tableNames.contains('members'), true);
    expect(tableNames.contains('schedules'), true);
    expect(tableNames.contains('expenses'), true);
    expect(tableNames.contains('checklists'), true);
    expect(tableNames.contains('memories'), true);
    expect(tableNames.contains('notifications'), true);
    
    await dbProvider.close();
  });

  test('Should insert and query user', () async {
    final dbProvider = DatabaseProvider();
    final db = await dbProvider.database;
    
    // Insert test user
    final now = DateTime.now().toIso8601String();
    final userId = await db.insert('users', {
      'full_name': 'Test User',
      'email': 'test@example.com',
      'password': 'hashed_password',
      'avatar': null,
      'created_at': now,
    });
    
    expect(userId, greaterThan(0));
    
    // Query user
    final users = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: ['test@example.com'],
    );
    
    expect(users.length, 1);
    expect(users.first['full_name'], 'Test User');
    
    // Clean up
    await db.delete('users', where: 'user_id = ?', whereArgs: [userId]);
    await dbProvider.close();
  });
}
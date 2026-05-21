import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  factory DatabaseProvider() => _instance;
  DatabaseProvider._internal();

  static Database? _database;

  // Tên database
  static const String _databaseName = 'travel_planner.db';
  static const int _databaseVersion = 1;

  // Tên các bảng
  static const String tableUsers = 'users';
  static const String tableTrips = 'trips';
  static const String tableMembers = 'members';
  static const String tableSchedules = 'schedules';
  static const String tableExpenses = 'expenses';
  static const String tableChecklists = 'checklists';
  static const String tableMemories = 'memories';
  static const String tableNotifications = 'notifications';

  // Lấy instance database (singleton)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Khởi tạo database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Tạo bảng lần đầu
  Future<void> _onCreate(Database db, int version) async {
    await _createUsersTable(db);
    await _createTripsTable(db);
    await _createMembersTable(db);
    await _createSchedulesTable(db);
    await _createExpensesTable(db);
    await _createChecklistsTable(db);
    await _createMemoriesTable(db);
    await _createNotificationsTable(db);

    // Tạo indexes để tăng performance
    await _createIndexes(db);
  }

  // Tạo bảng users
  Future<void> _createUsersTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableUsers (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        avatar TEXT,
        created_at TEXT NOT NULL
      )
    ''');
  }

  // Tạo bảng trips
  Future<void> _createTripsTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableTrips (
        trip_id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_name TEXT NOT NULL,
        destination TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        budget REAL NOT NULL,
        cover_image TEXT,
        status TEXT NOT NULL CHECK(status IN ('planning', 'preparing', 'traveling', 'completed')),
        leader_id INTEGER NOT NULL,
        FOREIGN KEY (leader_id) REFERENCES $tableUsers(user_id) ON DELETE CASCADE
      )
    ''');
  }

  // Tạo bảng members (quan hệ nhiều-nhiều giữa users và trips)
  Future<void> _createMembersTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableMembers (
        member_id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        role TEXT NOT NULL CHECK(role IN ('leader', 'member')),
        contribution_amount REAL DEFAULT 0,
        payment_status TEXT NOT NULL DEFAULT 'pending' CHECK(payment_status IN ('pending', 'paid')),
        FOREIGN KEY (trip_id) REFERENCES $tableTrips(trip_id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES $tableUsers(user_id) ON DELETE CASCADE,
        UNIQUE(trip_id, user_id)
      )
    ''');
  }

  // Tạo bảng schedules
  Future<void> _createSchedulesTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableSchedules (
        schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER NOT NULL,
        day INTEGER NOT NULL CHECK(day >= 1),
        time TEXT,
        place TEXT NOT NULL,
        note TEXT,
        FOREIGN KEY (trip_id) REFERENCES $tableTrips(trip_id) ON DELETE CASCADE
      )
    ''');
  }

  // Tạo bảng expenses
  Future<void> _createExpensesTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableExpenses (
        expense_id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        amount REAL NOT NULL CHECK(amount > 0),
        category TEXT NOT NULL CHECK(category IN ('food', 'transport', 'accommodation', 'entertainment', 'other')),
        payer INTEGER NOT NULL,
        receipt TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (trip_id) REFERENCES $tableTrips(trip_id) ON DELETE CASCADE,
        FOREIGN KEY (payer) REFERENCES $tableUsers(user_id) ON DELETE CASCADE
      )
    ''');
  }

  // Tạo bảng checklists
  Future<void> _createChecklistsTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableChecklists (
        checklist_id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'todo' CHECK(status IN ('todo', 'done')),
        owner INTEGER NOT NULL,
        FOREIGN KEY (trip_id) REFERENCES $tableTrips(trip_id) ON DELETE CASCADE,
        FOREIGN KEY (owner) REFERENCES $tableUsers(user_id) ON DELETE CASCADE
      )
    ''');
  }

  // Tạo bảng memories
  Future<void> _createMemoriesTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableMemories (
        memory_id INTEGER PRIMARY KEY AUTOINCREMENT,
        trip_id INTEGER NOT NULL,
        image TEXT NOT NULL,
        caption TEXT,
        uploader INTEGER NOT NULL,
        like_count INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        FOREIGN KEY (trip_id) REFERENCES $tableTrips(trip_id) ON DELETE CASCADE,
        FOREIGN KEY (uploader) REFERENCES $tableUsers(user_id) ON DELETE CASCADE
      )
    ''');
  }

  // Tạo bảng notifications
  Future<void> _createNotificationsTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableNotifications (
        notification_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        content TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'unread' CHECK(status IN ('unread', 'read')),
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES $tableUsers(user_id) ON DELETE CASCADE
      )
    ''');
  }

  // Tạo indexes để tăng tốc truy vấn
  Future<void> _createIndexes(Database db) async {
    await db.execute('CREATE INDEX idx_trips_status ON $tableTrips(status)');
    await db.execute('CREATE INDEX idx_trips_leader ON $tableTrips(leader_id)');
    await db.execute(
      'CREATE INDEX idx_trips_dates ON $tableTrips(start_date, end_date)',
    );

    await db.execute('CREATE INDEX idx_members_trip ON $tableMembers(trip_id)');
    await db.execute('CREATE INDEX idx_members_user ON $tableMembers(user_id)');
    await db.execute('CREATE INDEX idx_members_role ON $tableMembers(role)');

    await db.execute(
      'CREATE INDEX idx_schedules_trip ON $tableSchedules(trip_id)',
    );
    await db.execute('CREATE INDEX idx_schedules_day ON $tableSchedules(day)');

    await db.execute(
      'CREATE INDEX idx_expenses_trip ON $tableExpenses(trip_id)',
    );
    await db.execute(
      'CREATE INDEX idx_expenses_payer ON $tableExpenses(payer)',
    );
    await db.execute(
      'CREATE INDEX idx_expenses_category ON $tableExpenses(category)',
    );
    await db.execute(
      'CREATE INDEX idx_expenses_date ON $tableExpenses(created_at)',
    );

    await db.execute(
      'CREATE INDEX idx_checklists_trip ON $tableChecklists(trip_id)',
    );
    await db.execute(
      'CREATE INDEX idx_checklists_owner ON $tableChecklists(owner)',
    );
    await db.execute(
      'CREATE INDEX idx_checklists_status ON $tableChecklists(status)',
    );

    await db.execute(
      'CREATE INDEX idx_memories_trip ON $tableMemories(trip_id)',
    );
    await db.execute(
      'CREATE INDEX idx_memories_uploader ON $tableMemories(uploader)',
    );

    await db.execute(
      'CREATE INDEX idx_notifications_user ON $tableNotifications(user_id)',
    );
    await db.execute(
      'CREATE INDEX idx_notifications_status ON $tableNotifications(status)',
    );
    await db.execute(
      'CREATE INDEX idx_notifications_date ON $tableNotifications(created_at)',
    );
  }

  // Xử lý nâng cấp database (khi thay đổi schema)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Thêm các migration sau này
      // await db.execute('ALTER TABLE ...');
    }
  }

  // Đóng database
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}

// Provider để dùng chung trong toàn app
final databaseProviderProvider = Provider((ref) => DatabaseProvider());

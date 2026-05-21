class DbConstants {
  // Table names
  static const String tableUsers = 'users';
  static const String tableTrips = 'trips';
  static const String tableMembers = 'members';
  static const String tableSchedules = 'schedules';
  static const String tableExpenses = 'expenses';
  static const String tableChecklists = 'checklists';
  static const String tableMemories = 'memories';
  static const String tableNotifications = 'notifications';
  
  // Column names - Users table
  static const String colUserId = 'user_id';
  static const String colFullName = 'full_name';
  static const String colEmail = 'email';
  static const String colPassword = 'password';
  static const String colAvatar = 'avatar';
  static const String colCreatedAt = 'created_at';
  
  // Column names - Trips table
  static const String colTripId = 'trip_id';
  static const String colTripName = 'trip_name';
  static const String colDestination = 'destination';
  static const String colStartDate = 'start_date';
  static const String colEndDate = 'end_date';
  static const String colBudget = 'budget';
  static const String colCoverImage = 'cover_image';
  static const String colStatus = 'status';
  static const String colLeaderId = 'leader_id';
  
  // Column names - Members table
  static const String colMemberId = 'member_id';
  static const String colRole = 'role';
  static const String colContributionAmount = 'contribution_amount';
  static const String colPaymentStatus = 'payment_status';
  
  // Column names - Schedules table
  static const String colScheduleId = 'schedule_id';
  static const String colDay = 'day';
  static const String colTime = 'time';
  static const String colPlace = 'place';
  static const String colNote = 'note';
  
  // Column names - Expenses table
  static const String colExpenseId = 'expense_id';
  static const String colName = 'name';
  static const String colAmount = 'amount';
  static const String colCategory = 'category';
  static const String colPayer = 'payer';
  static const String colReceipt = 'receipt';
  
  // Column names - Checklists table
  static const String colChecklistId = 'checklist_id';
  static const String colTitle = 'title';
  
  // Column names - Memories table
  static const String colMemoryId = 'memory_id';
  static const String colImage = 'image';
  static const String colCaption = 'caption';
  static const String colUploader = 'uploader';
  static const String colLikeCount = 'like_count';
  
  // Column names - Notifications table
  static const String colNotificationId = 'notification_id';
  static const String colContent = 'content';
}

// Enum values
class TripStatusValues {
  static const String planning = 'planning';
  static const String preparing = 'preparing';
  static const String traveling = 'traveling';
  static const String completed = 'completed';
}

class MemberRoleValues {
  static const String leader = 'leader';
  static const String member = 'member';
}

class PaymentStatusValues {
  static const String pending = 'pending';
  static const String paid = 'paid';
}

class ChecklistStatusValues {
  static const String todo = 'todo';
  static const String done = 'done';
}

class ExpenseCategoryValues {
  static const String food = 'food';
  static const String transport = 'transport';
  static const String accommodation = 'accommodation';
  static const String entertainment = 'entertainment';
  static const String other = 'other';
}

class NotificationStatusValues {
  static const String unread = 'unread';
  static const String read = 'read';
}
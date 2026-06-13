class ErrorMessages {
  ErrorMessages._(); // Ngăn không cho khởi tạo class này

  // --- 1. LỖI XÁC THỰC ĐẦU VÀO (VALIDATION) ---
  static const String phoneEmpty = 'Số điện thoại không được để trống';
  static const String phoneInvalid =
      'Số điện thoại không hợp lệ (tối thiểu 10 số)';
  static const String passwordEmpty = 'Mật khẩu không được để trống';
  static const String passwordTooShort = 'Mật khẩu phải có ít nhất 6 ký tự';
  static const String usernameEmpty = 'Tên đăng nhập không được để trống';
  static const String confirmPasswordEmpty = 'Vui lòng xác nhận lại mật khẩu';
  static const String passwordMismatch = 'Mật khẩu xác nhận không trùng khớp';

  // --- 2. LỖI KẾT NỐI MẠNG (NETWORK) ---
  static const String connectionTimeout =
      'Kết nối quá hạn, vui lòng kiểm tra lại mạng của bạn';
  static const String connectionError =
      'Không thể kết nối tới máy chủ. Vui lòng kiểm tra internet';
  static const String requestCancelled = 'Yêu cầu kết nối đã bị hủy';
  static const String serverMaintenance =
      'Lỗi kết nối internet hoặc máy chủ đang bảo trì';
  static const String unknown = 'Đã có lỗi xảy ra. Vui lòng thử lại sau';

  // --- 3. LỖI NGHIỆP VỤ HỆ THỐNG / API (BUSINESS LOGIC) ---
  static const String unauthorized =
      'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại';
  static const String loginFailed =
      'Số điện thoại hoặc mật khẩu không chính xác';
  static const String phoneAlreadyExists = 'Số điện thoại này đã được đăng ký';
  static const String genericServerError = 'Lỗi hệ thống từ máy chủ';
}

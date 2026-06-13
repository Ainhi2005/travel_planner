import 'package:travel_planner/features/auth/domain/entities/user.dart';

class AuthState {
  // 1. CÁC THUỘC TÍNH (PROPERTIES) CHỨA TRẠNG THÁI
  final bool isLoading; // Đang tải dữ liệu (Hiện vòng xoay xoay trên UI)
  final User? user; // Thông tin người dùng (Bằng null nếu chưa đăng nhập)
  final String? errorMessage; // Chuỗi chứa thông tin lỗi nếu API thất bại
  final bool
  isAuthenticated; // Cờ xác nhận: true = Đã đăng nhập, false = Chưa đăng nhập

  // 2. HÀM KHỞI TẠO (CONSTRUCTOR) VỚI GIÁ TRỊ MẶC ĐỊNH
  AuthState({
    this.isLoading = false, // Mặc định ban đầu vào app là không loading
    this.user, // Mặc định là null (chưa có user)
    this.errorMessage, // Mặc định là null (chưa có lỗi gì)
    this.isAuthenticated = false, // Mặc định ban đầu là chưa đăng nhập
  });

  // 3. HÀM COPYWITH (TẠO BẢN SAO ĐỂ CẬP NHẬT TRẠNG THÁI BẤT BIẾN)
  AuthState copyWith({
    bool? isLoading,
    User? user,
    String? errorMessage,
    bool? isAuthenticated,
  }) {
    return AuthState(
      // Dấu ?? nghĩa là: Nếu truyền vào giá trị mới thì lấy cái mới,
      // nếu không truyền gì (null) thì giữ nguyên giá trị cũ (this.xxx)
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
/*Cơ chế hoạt động của hàm copyWith (Quan trọng nhất)
Trong Riverpod, quy tắc tối cao là không được sửa trực tiếp biến của State.

❌ Cấm viết: state.isLoading = true; (Riverpod sẽ không nhận biết được để vẽ lại giao diện đâu, và code sẽ bị lỗi).

✔️ Bắt buộc viết: state = state.copyWith(isLoading: true);

Hàm copyWith giống như một cái máy photocopy thông minh. Nó copy lại nguyên vẹn cái AuthState hiện tại, nhưng nó cho phép bạn sửa đổi một vài thông số bạn muốn.

Ví dụ thực tế luồng chạy:

Khi vừa mở App, State mặc định là:
{isLoading: false, user: null, errorMessage: null, isAuthenticated: false}

Khi người dùng bấm nút Đăng nhập, bạn gọi: state = state.copyWith(isLoading: true);

Cái máy photocopy sẽ nhìn vào lệnh của bạn, nó giữ nguyên user (null), errorMessage (null), isAuthenticated (false), và chỉ đổi đúng biến isLoading từ false thành true.

Giao diện UI thấy isLoading biến thành true liền lập tức hiển thị vòng xoay tải dữ liệu lên màn hình. */
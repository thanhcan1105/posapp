const commonLabels = {
  'all': 'Tất cả',
  'close': 'Đóng',
  'continue': 'Tiếp tục',
  'please_contact_manager': 'Vui lòng liên hệ với ban quản lý toà nhà để được cấp tài khoản cư dân',
  'announcement': 'Thông báo',
  'try_again': 'Thử lại',
  'empty_data': 'Không có dữ liệu',
  'devoid': 'Không có',
  'delete': 'Xoá',
  'agree': 'Đồng ý',
  'received': 'Đã nhận',
  'processing': 'Đang xử lý',
  'success': 'Thành công',
  'failure': 'Thất bại',
  'login_success': 'Đăng nhập thành công',
  'finish': 'Hoàn thành',
  'latest_announcement_updated': 'Đã nhập nhật thông báo mới nhất',
  'detail': 'Chi tiết',
  'status': 'Trạng thái',
  'all_status': 'Tất cả trạng thái',
  'all_announcement': 'Tất cả thông báo',
  'require': 'Yêu cầu điền thông tin',
  'seconds': 'giây',
  'request_error': 'Lỗi kết nối',
  'server_error': 'Không nhận được phản hồi từ máy chủ, vui lòng thử lại',
  'confirm': 'Xác nhận',
  'role': 'Vai trò',
  'optional': 'nếu có',
  'customer': 'Khách hàng',
  'customer_support': 'Hỗ trợ khách hàng',
  'new_customer': 'Khách hàng mới',
  'name_customer': 'Tên khách hàng',
  'employee': 'Nhân viên',
  'search_employee': 'Tìm nhân viên',
  'add_employee': 'Thêm nhân viên',
  'name_employee': 'Tên nhân viên',
  'no_transactions': 'Chưa có giao dịch',
  'password': 'Mật khẩu',
  'building_info': 'Thông tin toà nhà',
  'payment': 'Thanh toán',
  'need_payment': 'Cần thanh toán',
  'transaction_history': 'Lịch sử thanh toán',
  'fee_month': 'Phí tháng',
  'apartment': 'Căn hộ',
  'owner': 'Chủ sở hữu',
  'management_fee_month': 'Phí quản lí',
  'acreage': 'Diện tích',
  'unit_price': 'Đơn giá',
  'total_price': 'Tổng tiền',
  'parking_fee': 'Phí xe',
  'water_fee': 'Phí nước',
  'inhabitants_shall_be_given_norms': 'Số NK được cấp định mức',
  'old_figure': 'Chỉ số cũ',
  'new_figure': 'Chỉ số mới',
  'used_quanity': 'Sử dụng',
  'consumption': 'Định mức',
  'amount_price': 'Thành tiền',
  'exceed': 'Ngoài định mức',
  'enviroment_fee': 'Phí môi trường',
  'lastest_updated': 'Đã cập nhật mới nhất',
  'submit': 'Gửi',
  'update': 'Cập nhật',
  'refresh_success': 'Làm mới thành công',
  'note': 'Ghi chú',
  'add_note': 'Thêm ghi chú',
  'delete_cart': 'Xoá giỏ hàng',
  'payment_date': 'Ngày thanh toán',
  'cash': 'Tiền mặt',
  'transfer': 'Chuyển khoản',
  'close_app': 'Đóng ứng dụng',
  'phone': 'Số điện thoại',
  'email': 'Email',
  'address': 'Địa chỉ',
  'website': 'Website',
  'settings': 'Cài đặt',
  'info_company': 'Tìm hiểu về iRes',
  'undefined': 'Chưa xác định',
  'image': 'Hình ảnh',
  'loading_image': 'Đang tải ảnh...',
  'loading_data': 'Đang tải dữ liệu...',
  'receiver': 'Người nhận',
  'sender': 'Người gửi',
  'upload_image_failed': 'Không thể tải hình ảnh của bạn lên máy chủ, vui lòng báo bộ phận IT để kiểm tra',
  'version': 'Phiên bản',
  'free': 'Miễn phí',
  'item': 'Món',
  'from': 'từ',
  'type_order': 'Loại đơn',
  'type': 'Loại',
  'to': 'đến',
  'description': 'Mô tả',
  'save': 'Lưu',
  'save_order': 'Lưu đơn',
  'add_note_order': "Thêm ghi chú đơn hàng",
  'delete_order': 'Xoá đơn hàng',
  'total': 'Tổng',
  'empty': 'Không có dữ liệu',
  'slide_down_to_back': 'Vuốt xuống để quay lại',
  'common_setting': 'Cài đặt chung',
  'export': 'Xuất báo cáo',
  'add': 'Thêm mới',
  'anauthorized': 'Hết thời gian đăng nhập, mời đăng nhập lại',
  'an_error_occurred': 'Có lỗi xẩy ra, vui lòng thử lại',
  'double_tap_to_exit': 'Chạm 2 lần để thoát',
  'application_exit_warning': 'Cảnh báo thoát ứng dụng',
  'is_not_empty': ' không được trống',
  'your_name': 'Tên của bạn',
  'apply': 'Áp dụng',
  'welcome_to_edge': 'Chào mừng đến với Edge',
  'login_failed': 'Đăng nhập thất bại, vui lòng thử lại',
  'enter_full_info': 'Vui lòng điền đầy đủ thông tin',
  'register_success': 'Đăng ký thành công, mời đăng nhập',
  'register_failed': 'Đăng ký thất bại, mời thử lại',
  'verify_your_phone_number': 'Xác minh số điện thoại',
  'enter_code': 'Điền mã được gửi đến số',
  'verification_is_successful': 'Xác minh thành công!',
  'resend': 'Gửi lại',
  'did_not_receive_the_code?': 'Bạn không nhận được mã?',
  'verification_code_is_incorrect': 'Mã xác minh không đúng',
  'veryfication': 'Xác minh',
  'discount': 'Giảm giá',
  'scan_the_code': 'Quét mã',
  'welcome_to_popos': 'Chào mừng bạn đến với PoPos',
  'application_management': 'Ứng dựng quản lý nhà hàng, quán ăn, cà phê vô cùng tiện lợi.',
  'remote_manager': 'Quản lý hoạt động kinh doanh từ xa',
  'store_load_data_is_notified_and_updated_immediately': 'Dữ liệu tải cửa hàng được thông báo và cập nhật ngay lập tức.',
  'detailed_report': 'Báo cáo chi tiết',
  'report_control_inventory_control_raw_materials': 'Báo cáo, đối soát, kiểm kho, nguyên vật liệu,...',
  'edit': 'Sửa',
  'pending': 'Chờ xác nhận',
  'total_order': 'Tổng đơn hàng',
  'amount_received': 'Số tiền nhận',
  'refound': 'Hoàn lại',
  'remainder': 'Còn thiếu',
  'change': 'Tiền thừa',
  'see_the_bill': 'Xem hoá đơn',
  'create_a_new_bill': 'Tạo hoá đơn mới',
  'search_product': 'Tìm sản phẩm',
  'use_in_place': 'Dùng tại chỗ',
  'take_out': 'Đã lên món',
  'ship': 'Giao hàng',
  'debit': 'Ghi nợ',
  'wait_for_confirmation': 'Chờ xác nhận',
  'confirmed': 'Đã xác nhận',
  'doing': 'Đang chế biến',
  'ready': 'Sẵn sàng',
  'take_away_form': 'Mang về',
  'select_one_or_more': 'Chọn một hoặc nhiều',
  'order_code': 'Mã đơn',
  'paid': 'Đã thanh toán',
  'enter_elpoyee_name': 'Vui lòng điền tên nhân viên',
  'add_employee_done': 'Thêm nhân viên thành công',
  'add_employee_failed': 'Thêm nhân viên thất bại, vui lòng thử lại',
  'delete_customer_done': 'Xoá khách hàng thành công',
  'cashier': 'Thu ngân',
  'logo_store': 'Logo cửa hàng',
  'language': 'Ngôn ngữ',
  'added_to_order': 'Đã thêm vào đơn hàng',
  'payment_success': 'Thanh toán thành công',
  'select_image_item': 'Vui lòng chọn ảnh cho món mới',
  'choose_name_item': 'Vui lòng đặt tên cho mớn mới',
  'add_product_success': 'Thêm sản phẩm thành công',
  'add_product_failed': 'Thêm sản phẩm thất bại, vui lòng thử lại',
  'choose_color_product': 'Chọn màu cho sản phẩm',
  'shoot': 'Chụp ảnh',
  'select_from_gallery': 'Chọn ảnh từ thư viện',
};
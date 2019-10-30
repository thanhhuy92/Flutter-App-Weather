# APP WEATHER

## Giới Thiệu

* App được xây dựng bằng framework flutter (ngôn ngữ dart) và app chạy được cả Android và IOS.

* App thiết kế đơn giản với một số thông tin như nhiệt độ, độ ẩm, gió, sức ép.

* App có chức năng cho người dùng biết được thông tin thời tiết hiện tại ở nơi mình đang sống hoặc ở bất kì một nước nào đó trên trái đất chỉ cần GPS định vị được.

## Thiết Lập Dự Án

* Mở Android Studio và tạo flutter mới với tên flutter-appweather.

<img src= "Images/img-weather1.jpg" />

* Sau khi hoàn tất tạo mới thì đã có sẵn một demo flutter.

<img src= "Images/img-weather2.jpg" />

## Lấy Dữ Liệu Weather Từ API

* Vào trang https://openweathermap.org.

* Tạo tài khoản, sau khi tạo xong nó sẽ cấp cho tài khoản đó một API.

<img src= "Images/img-weather3.jpg" />

* Click vào API trên thanh menu, sau đó click vào API doc tại "Current weather data".

<img src= "Images/img-weather4.jpg" />

* Ở đây mình chọn API "By geographic coordinates" tức là lấy dữ liệu thời tiết thông qua tọa độ (lat, lon) và click vào dòng chữ được đánh khung.

<img src= "Images/img-weather5.jpg" />

* Ta sẽ thay đổi thanh địa chỉ tại vị trí được khoanh

<img src= "Images/img-weather6.jpg" />

* Thay đổi ở phần trước.

<img src= "Images/img-weather7.jpg" />

* Ở phần sau ta lấy API ở tài khoản gán vào phần sau thanh địa chỉ.

<img src= "Images/img-weather8.jpg" />

* Và ta có kết quả.

<img src= "Images/img-weather9.jpg" />

* Copy hết nội dung bên dưới, vào trang http://json2csharp.com/, paste vào "Enter JSON or a URL to JSON" và click vào "Generate".

<img src= "Images/img-weather10.jpg" />

* Được kết quả như hình dưới.

<img src= "Images/img-weather11.jpg" />

## Đưa Dữ Liệu API vào Android Studio

* Quay lại Android Studio, ta tạo một package tên Models (chuột phải vào lib -> New -> Package).

* Tạo một file dart tên WeatherModels trong Models (chuột phải Models -> New -> Dart File).

<img src= "Images/img-weather12.jpg" />

* Bên Json2csharp, ta copy class Coord và Weather gán vào trong file dart WeatherModels.

<img src= "Images/img-weather13.jpg" />

* Thay public -> final, thay { get; set;} -> ;.

* Thêm constructor cho class và tạo lớp mô hình theo json_serializable.

* json_serializable có thể nghiên cứu tại trang này https://flutter.dev/docs/development/data-and-backend/json

<img src= "Images/img-weather14.jpg" />

* Tương tự với class Main, Wind, Clounds và Sys.

* Riêng class RootObject đổi tên thành WeatherModel.

* Lớp mô hình theo json_serializable của class WeatherModel.

<img src= "Images/img-weather15.jpg" />

## Lấy Dữ Liệu API qua HTTP

* Trước tiên, cài plugin http vào file pubspec.yaml (Tệp pubspec quản lý nội dung và dependencies cho ứng dụng Flutter, nghiên cứu thêm https://dart.dev/tools/pub/pubspec).

* Vào trang https://pub.dev là nới chứa các Dart Packages, search http.

* Tab Readme cho ta biết phiên bản mới nhất của plugin http, http là gì và cách dùng http.

<img src= "Images/img-weather16.jpg" />

* Tab Example cho ta biết rõ hơn về cách dùng.

<img src= "Images/img-weather17.jpg" />

* Tab Versions là các phiên bản của plugin http.

<img src= "Images/img-weather18.jpg" />

* Tab Installing copy vùng khoanh.

<img src= "Images/img-weather19.jpg" />

* Gán vào file pubspec.yaml, nhấn vào "Packages get".

<img src= "Images/img-weather20.jpg" />

* Sau khi hoàn tất việc gán plugin http, chuyển sang file main.dart.

* Xóa hết nội dung chỉ để lại dòng import trên cùng.

* Và tạo lại main.dart mới.

<img src= "Images/img-weather21.jpg" />

* Dùng hàm bất đồng bộ (Future<void> main() async {}) để lấy dữ liệu API (http) đưa vào main.

* Và gán import.

<img src= "Images/img-weather22.jpg" />

## Thiết Kế Giao Diện

* Add code đưa dữ liệu API.

* Và chuyển đổi sang mô hình dữ liệu và hiển thị tên địa điểm trên màn hình.

<img src= "Images/img-weather23.jpg" />

* Cách xây dựng FutureBuilder xem tại đây https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html

* Run và ta có tên địa điểm.

<img src= "Images/img-weather25.jpg" />

* Hiện một vài thông tin ở địa điểm đó.

* Để hiện thời gian thì phải có plugin intl (cách thực hiện như plugin http mà ta đã làm ở trên) và import intl.

<img src= "Images/img-weather24.jpg" />

* Tên địa điểm, nhiệt độ.

* Và Hình ảnh được lấy trên trang https://openweathermap.org và dùng lệnh weather[0].icon để hình ảnh được thay đổi theo thời gian.

<img src= "Images/img-weather26.jpg" />

* Thời gian.

<img src= "Images/img-weather27.jpg" />

* Tốc độ gió và sức ép.

<img src= "Images/img-weather28.jpg" />

* Độ ẩm và tọa độ.

<img src= "Images/img-weather29.jpg" />

* Run và ta có kết quả.

<img src= "Images/img-weather30.jpg" />

* Trang trí lại giao diện.

* Tạo nút thoát dùng chức năng AlertDialog để thông báo người dùng.

<img src= "Images/img-weather31.jpg" />   <img src= "Images/img-weather32.jpg" />

## Những Lỗi Đang Gặp

* Khi lấy lấy file từ github về và chạy.

<img src= "Images/img-weather33.jpg" />

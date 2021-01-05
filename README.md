# README
Các bước thực hiện:
* Cài ruby(version: 2.7.0) và rails(version: 6.0.3.2): https://www.matthewhoelter.com/2019/05/10/setup-and-install-multiple-versions-of-ruby-and-rails-with-rvm.html

* Cài mysql, ghi nhớ password

* Cài workbench, ô tạo mới 1 database tên "abc", -> file config/database.yml sử tên database thành "abc"

* Trong workbench tạo database trống tên là: project_3

* Vào file /project_3/config/database.yml đổi dòng password thành password khi cài mysql

* cd vào project_3, chạy `bundle`
* chạy `rails s` và vào đường dẫn `localhost:3000`

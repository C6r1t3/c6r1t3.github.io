\# Quy tắc cho blog Hugo này



\- Hugo 0.169 + theme PaperMod ở themes/PaperMod (git submodule): KHÔNG sửa, KHÔNG xóa gì trong thư mục này. Tùy biến chỉ đặt ở hugo.toml, layouts/\_partials/, assets/css/extended/, static/, content/.

\- Dùng cú pháp cấu hình mới của Hugo (locale, không dùng languageCode).

\- Chỉ sửa đúng phần tôi yêu cầu. Không viết lại hay thay nội dung bài trong content/posts, không tải nội dung từ internet, không chạy curl hoặc wget.

\- Khi tôi nói "sửa rồi push", làm đúng quy trình này:

&#x20; 1. Chạy git status. Nếu có thay đổi chưa commit từ trước, dừng lại và hỏi tôi.

&#x20; 2. Sửa theo yêu cầu.

&#x20; 3. Chạy hugo --gc --minify. Nếu lỗi thì sửa tiếp, không push.

&#x20; 4. Chạy git diff --stat và liệt kê file đã đổi. Nếu có file ngoài phạm vi yêu cầu, hoặc bài viết bị xóa nhiều dòng bất thường, DỪNG và báo tôi, không commit.

&#x20; 5. Nếu ổn: git add -A, git commit -m "<mô tả ngắn, không dấu>", git push.

\- Không bao giờ dùng git push --force, git reset --hard hay xóa nhánh.

\- Không commit file lớn hơn 5 MB, và không commit khóa hay mật khẩu.


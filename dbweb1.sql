-- Bảng người dùng
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) DEFAULT 'reader',  -- reader, staff, admin
    created_at TIMESTAMP DEFAULT NOW()
);

-- Bảng sách
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    publisher VARCHAR(100),
    year_published INT,
    genre VARCHAR(50),
    quantity INT DEFAULT 1,
    available INT DEFAULT 1,  -- số lượng còn sẵn
    created_at TIMESTAMP DEFAULT NOW()
);

-- Bảng mượn/trả sách
CREATE TABLE Borrowings (
    borrow_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    book_id INT NOT NULL REFERENCES Books(book_id) ON DELETE CASCADE,
    borrow_date DATE DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20) DEFAULT 'borrowed'  -- borrowed, returned, overdue
);

-- Bảng đặt trước sách
CREATE TABLE Reservations (
    reservation_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    book_id INT NOT NULL REFERENCES Books(book_id) ON DELETE CASCADE,
    reservation_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'waiting'  -- waiting, ready, canceled
);

-- Bảng wishlist (danh sách yêu thích)
CREATE TABLE Wishlist (
    wishlist_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    book_id INT NOT NULL REFERENCES Books(book_id) ON DELETE CASCADE,
    added_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(user_id, book_id)
);

-- Optional: Tạo một số index để tìm kiếm nhanh
CREATE INDEX idx_books_title ON Books(title);
CREATE INDEX idx_books_author ON Books(author);
CREATE INDEX idx_borrowings_user ON Borrowings(user_id);
CREATE INDEX idx_reservations_user ON Reservations(user_id);

INSERT INTO Users (username, password_hash, full_name, email, role) VALUES
('user1', 'hash1', 'Nguyen Van A', 'a@example.com', 'reader'),
('user2', 'hash2', 'Tran Thi B', 'b@example.com', 'reader'),
('user3', 'hash3', 'Le Van C', 'c@example.com', 'reader'),
('user4', 'hash4', 'Nguyen Tien D', 'd@example.com', 'reader'),
('user5', 'hash5', 'Tran Thai E', 'e@example.com', 'reader'),
('user6', 'hash6', 'Ngo Van F', 'f@example.com', 'reader'),
('user7', 'hash7', 'Do Thi H', 'h@example.com', 'reader'),
('user8', 'hash8', 'Tran Van G', 'g@example.com', 'reader'),
('user9', 'hash9', 'Pham Van Q', 'q@example.com', 'reader'),
('admin1', 'adminHao', 'Nguyễn Nhựt Hào', 'adminHao@gmail.com', 'admin'),
('admin2', 'adminSon', 'Lê Hoàng Sơn', 'adminSon@gmail', 'admin'),
('admin3', 'adminCong', 'Lưu Lý Công', 'adminCong@gmail', 'admin'),
('librarian1', 'hashstaff1', 'Nguyen Thi Q', 'q@librarian.com', 'staff'),
('librarian2', 'hashstaff2', 'Tran Thi L', 'l@librarian.com', 'staff');
-- Thêm sách
INSERT INTO Books (title, author, publisher, year_published, genre, quantity, available) VALUES
('Lập trình C#', 'Nguyen Van A', 'NXB Tech', 2020, 'CNTT', 3, 3),
('Học Python', 'Tran Thi B', 'NXB Tech', 2019, 'CNTT', 2, 2),
('Java cơ bản', 'Le Van C', 'NXB Tech', 2021, 'CNTT', 5, 5),
('Thiết kế web', 'Nguyen Van A', 'NXB Web', 2018, 'CNTT', 2, 2),
('Cấu trúc dữ liệu', 'Tran Thi B', 'NXB Tech', 2017, 'CNTT', 4, 4),
('Thuật toán nâng cao', 'Le Van C', 'NXB Tech', 2016, 'CNTT', 3, 3),
('Lập trình JavaScript', 'Nguyen Van A', 'NXB Web', 2021, 'CNTT', 5, 5),
('HTML & CSS', 'Tran Thi B', 'NXB Web', 2019, 'CNTT', 2, 2),
('SQL cơ bản', 'Le Van C', 'NXB Tech', 2020, 'CNTT', 3, 3),
('Quản trị mạng', 'Nguyen Van A', 'NXB Tech', 2015, 'CNTT', 2, 2),
('Học ReactJS', 'Tran Thi B', 'NXB Web', 2022, 'CNTT', 4, 4),
('NodeJS nâng cao', 'Le Van C', 'NXB Web', 2021, 'CNTT', 3, 3),
('Machine Learning', 'Nguyen Van A', 'NXB AI', 2020, 'CNTT', 2, 2),
('AI cơ bản', 'Tran Thi B', 'NXB AI', 2021, 'CNTT', 3, 3),
('Deep Learning', 'Le Van C', 'NXB AI', 2022, 'CNTT', 4, 4),
('Data Science', 'Nguyen Van A', 'NXB AI', 2019, 'CNTT', 2, 2),
('Học R', 'Tran Thi B', 'NXB Tech', 2018, 'CNTT', 2, 2),
('Big Data', 'Le Van C', 'NXB Tech', 2020, 'CNTT', 3, 3),
('Phân tích dữ liệu', 'Nguyen Van A', 'NXB Tech', 2021, 'CNTT', 3, 3),
('Học Docker', 'Tran Thi B', 'NXB DevOps', 2022, 'CNTT', 2, 2),
('DevOps cơ bản', 'Le Van C', 'NXB DevOps', 2020, 'CNTT', 2, 2),
('Truyện Kiều', 'Nguyễn Du', 'NXB Văn học', 1820, 'Văn học', 3, 3),
('Số đỏ', 'Vũ Trọng Phụng', 'NXB Văn học', 1936, 'Văn học', 2, 2),
('Lịch sử Việt Nam', 'Ngô Sĩ Liên', 'NXB Lịch sử', 2010, 'Lịch sử', 4, 4),
('Vũ trụ học cơ bản', 'Stephen Hawking', 'NXB Khoa học', 1988, 'Khoa học', 2, 2),
('Đi tìm thời gian đã mất', 'Marcel Proust', 'NXB Văn học', 1913, 'Văn học', 3, 3),
('Nghệ thuật Phục hưng', 'Gombrich', 'NXB Nghệ thuật', 1950, 'Nghệ thuật', 2, 2),
('Tôn Tử binh pháp', 'Tôn Tử', 'NXB Lịch sử', -500, 'Chiến lược', 2, 2),
('Những nguyên lý thể thao', 'John Smith', 'NXB Thể thao', 2015, 'Thể thao', 3, 3),
('Hóa học cơ bản', 'Marie Curie', 'NXB Khoa học', 1903, 'Khoa học', 2, 2),
('Thơ Xuân Diệu', 'Xuân Diệu', 'NXB Văn học', 1940, 'Văn học', 3, 3);
-- Thêm các lần mượn sách (giả sử 5 lượt mượn)
INSERT INTO Borrowings (user_id, book_id, borrow_date, due_date, return_date, status) VALUES
(1, 1, '2025-09-01', '2025-09-10', NULL, 'borrowed'),
(1, 2, '2025-09-02', '2025-09-12', NULL, 'borrowed'),
(2, 3, '2025-09-03', '2025-09-13', NULL, 'borrowed'),
(3, 4, '2025-09-04', '2025-09-14', NULL, 'borrowed'),
(2, 5, '2025-09-05', '2025-09-15', NULL, 'borrowed'),
(4, 6, '2025-09-06', '2025-09-16', NULL, 'borrowed'),
(5, 7, '2025-09-07', '2025-09-17', NULL, 'borrowed'),
(6, 8, '2025-09-08', '2025-09-18', NULL, 'borrowed'),
(7, 9, '2025-09-09', '2025-09-19', NULL, 'borrowed'),
(8, 10, '2025-09-10', '2025-09-20', NULL, 'borrowed'),
(9, 11, '2025-09-11', '2025-09-21', NULL, 'borrowed');
-- Thêm đặt trước sách
INSERT INTO Reservations (user_id, book_id, reservation_date, status) VALUES
(1, 3, '2025-09-06', 'waiting'),
(3, 2, '2025-09-07', 'waiting'),
(4, 12, '2025-09-08', 'waiting'),
(5, 13, '2025-09-09', 'waiting'),
(6, 14, '2025-09-10', 'waiting'),
(7, 15, '2025-09-11', 'waiting'),
(8, 16, '2025-09-12', 'waiting');
-- Thêm wishlist
INSERT INTO Wishlist (user_id, book_id, added_date) VALUES
(1, 5, '2025-09-01'),
(2, 1, '2025-09-02'),
(3, 6, '2025-09-03'),
(4, 17, '2025-09-05'),
(5, 18, '2025-09-06'),
(6, 19, '2025-09-07'),
(7, 20, '2025-09-08'),
(8, 21, '2025-09-09'),
(1, 22, '2025-09-10'),
(2, 23, '2025-09-11'),
(3, 24, '2025-09-12'),
(4, 25, '2025-09-13'),
(5, 26, '2025-09-14');
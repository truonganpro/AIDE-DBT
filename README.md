### DBT
(tải dữ liệu từ link sau: https://drive.google.com/drive/folders/10T8S0Ri-av7BoXyT-YGSC7_BwNPokNYv?usp=drive_link)

# Hướng Dẫn Cài Đặt và Chạy Dự Án

Dự án này sử dụng **PostgreSQL** và **DBT** để xử lý và trực quan hóa dữ liệu. Hãy làm theo các bước sau để thiết lập và chạy dự án.

## Yêu Cầu

- Docker và Docker Compose
- Python và pip
- DBT (Data Build Tool)

---

## 1. Khởi động PostgreSQL Container với Docker

Chạy lệnh sau để khởi động container PostgreSQL:
```bash
docker-compose up -d
```

Lệnh này sẽ khởi động các dịch vụ được cấu hình trong `docker-compose.yml`, bao gồm container PostgreSQL `de_psql`.

---

## 2. Khởi động lại môi trường với Make

Chạy lệnh sau để khởi động lại môi trường:
```bash
make restart
```

Lệnh này sẽ thực thi mục tiêu `restart` trong file `Makefile` và đảm bảo mọi thứ khởi động đúng cách.

---

## 3. Kiểm tra các container đang chạy

Đảm bảo container PostgreSQL đang chạy bằng lệnh:
```bash
docker ps
```

---

## 4. Sao chép dữ liệu CSV vào container

Chạy lệnh sau để sao chép thư mục dữ liệu vào container:
```bash
docker cp brazilian-ecommerce/ de_psql:/tmp/
```

Thư mục `brazilian-ecommerce` chứa các file CSV sẽ được chuyển vào thư mục `/tmp/` trong container `de_psql`.

---

## 5. Sao chép file SQL schema vào container

Chạy lệnh sau để sao chép file SQL schema:
```bash
docker cp psql_schemas.sql de_psql:/tmp/
```

File `psql_schemas.sql` chứa các câu lệnh SQL để tạo bảng trong cơ sở dữ liệu.

---

## 6. Tạo bảng trong PostgreSQL

Thực thi file SQL schema để tạo bảng:
```bash
docker exec de_psql psql postgres://admin:admin123@localhost:5432/brazillian_ecommerce -f /tmp/psql_schemas.sql
```

Lệnh này sẽ chạy script SQL `psql_schemas.sql` và tạo các bảng trong cơ sở dữ liệu `brazillian_ecommerce`.

---

## 7. Truy cập PostgreSQL trong container

Để truy cập vào PostgreSQL trong container:
```bash
docker exec -ti de_psql psql postgres://admin:admin123@localhost:5432/brazillian_ecommerce
```

---

## 8. Nạp dữ liệu CSV vào PostgreSQL

Thực hiện các lệnh dưới đây để nạp dữ liệu từ CSV vào các bảng trong PostgreSQL:
```sql
COPY olist_order_items_dataset FROM '/tmp/brazilian-ecommerce/olist_order_items_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_order_payments_dataset FROM '/tmp/brazilian-ecommerce/olist_order_payments_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_orders_dataset FROM '/tmp/brazilian-ecommerce/olist_orders_dataset.csv' DELIMITER ',' CSV HEADER;
COPY olist_products_dataset FROM '/tmp/brazilian-ecommerce/olist_products_dataset.csv' DELIMITER ',' CSV HEADER;
```

---

## 9. Kiểm tra dữ liệu trong bảng

Chạy các câu lệnh sau để kiểm tra dữ liệu:
```sql
SELECT * FROM olist_order_items_dataset LIMIT 10;
SELECT * FROM olist_order_payments_dataset LIMIT 10;
SELECT * FROM olist_orders_dataset LIMIT 10;
SELECT * FROM olist_products_dataset LIMIT 10;
```

---

## 10. Cài đặt DBT và khởi tạo dự án DBT

Cài đặt DBT và các package cần thiết:
```bash
pip install dbt-core==1.3.0 dbt-postgres==1.3.0 pytz==2022.7.1
```

Khởi tạo dự án DBT:
```bash
dbt init brazillian_ecom
```

---

## 11. Thiết lập biến môi trường cho DBT

Tải các biến môi trường từ file `.env`:
```bash
export $(grep -v '^#' env | xargs)
echo $POSTGRES_HOST
```

---

## 12. Chạy các mô hình DBT

Thực thi các mô hình DBT:
```bash
dbt run --profiles-dir ./ --project-dir brazillian_ecom
```

---

## 13. Tạo tài liệu và phục vụ giao diện dòng lineage của DBT

Tạo tài liệu và khởi động máy chủ để xem dòng lineage:
```bash
dbt docs generate --profiles-dir ./ --project-dir brazillian_ecom
dbt docs serve --profiles-dir ./ --project-dir brazillian_ecom
```

Truy cập `http://localhost:8080` trên trình duyệt để xem sơ đồ lineage của DBT.

--- 

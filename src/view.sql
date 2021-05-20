create database material;
use material;

create table material(
                         material_id int not null auto_increment primary key ,
                         material_code int unique not null ,
                         material_name varchar(50) unique not null ,
                         unit varchar(20) ,
                         price int
);



create table inventory(
                          inventory_id int not null primary key auto_increment,
                          id_material int ,
                          number int,
                          totalAmountEntered int,
                          totalExportQuantity int,
                          foreign key (id_material) references material(material_id)
);

create table supplier(
                         supplier_id int not null primary key auto_increment,
                         supplier_code int unique ,
                         supplier_name varchar(50) unique ,
                         supplier_address varchar(100),
                         supplier_phone varchar(10) unique
);

create table theOrder(
                         order_id int not null auto_increment primary key ,
                         order_code int unique ,
                         orderDate date,
                         id_supplier int,
                         foreign key (id_supplier) references supplier(supplier_id)
);

create table importTicket(
                             import_id int not null auto_increment primary key ,
                             import_code int unique ,
                             import_date date,
                             id_order int,
                             foreign key (id_order) references theOrder(order_id)
);

create table exportTicket(
                             export_id int not null primary key auto_increment,
                             export_code int unique ,
                             export_date date,
                             customer_name varchar(20) unique
);

create table OrderDetails(
                             OrderDetails_id int not null primary key auto_increment,
                             id_theOrder int,
                             id_material int ,
                             oder_quantity int,
                             foreign key (id_theOrder) references theOrder(order_id),
                             foreign key (id_material) references material(material_id)
);

create table DetailsOfEntry(
                               DetailsOfEntry_id int not null auto_increment primary key ,
                               id_import int,
                               id_material int,
                               import_quantity int,
                               importUnitPrice varchar(20),
                               note varchar(100),
                               foreign key (id_import) references importTicket(import_id),
                               foreign key (id_material) references material(material_id)
);

create table DetailsOfTheRelease(
                                    DetailsOfTheRelease_id int not null auto_increment primary key ,
                                    id_export int,
                                    id_material int,
                                    export_quantity int,
                                    exportUnitPrice varchar(20),
                                    note varchar(100),
                                    foreign key (id_export) references exportTicket(export_id),
                                    foreign key (id_material) references material(material_id)
);

insert material(material_code, material_name, unit, price) VALUES
    (111,'Xi Măng','Tấn',1000000),
    (222,'Cát','Khối',200000),
    (333,'Sắt','Tấn',10000000),
    (444,'Gạch Hoa','Mét vuông',100000),
    (555,'Sơn nước','Thùng',500000);

insert inventory(id_material, number, totalAmountEntered, totalExportQuantity) values
    (1, 50,100, 40),
    (2, 50,100, 40),
    (3, 50,100, 40),
    (4, 50,100, 40),
    (5, 50,100, 40),
    (1, 50,100, 40),
    (2, 50,100, 40),
    (3, 50,100, 40),
    (4, 50,100, 40),
    (5, 50,100, 40);

insert supplier(supplier_code, supplier_name, supplier_address, supplier_phone) VALUES
    (8001, 'Nhà máy xi măng Nghi Sơn', 'TX Nghi Sơn - Thanh Hóa', '0333321112'),
    (8002, 'Nhà máy thép Hòa Phát', 'Thái Nguyên', '0333321115'),
    (8003, 'Nhà máy abc', 'Hà Nam', '0333321118');

insert theOrder(order_code, orderDate, id_supplier) VALUES
    (101, '2021-05-19',1),
    (102, '2021-04-18',2),
    (103, '2021-03-17',3);

insert importTicket(import_code, import_date, id_order) VALUES
    (3001,'2021-05-02',1),
    (3002,'2021-04-15',2),
    (3003,'2021-03-01',3);

insert exportTicket(export_code, export_date, customer_name) VALUES
    (546151,'2021-03-05','Nguyen Văn Anh'),
    (546152,'2021-02-06','Nguyen Văn Trung'),
    (546153,'2021-01-03','Nguyen Văn Khang');

insert OrderDetails(id_theOrder, id_material, oder_quantity) VALUES
    (1,1,10),
    (2,1,15),
    (3,2,8),
    (1,2,10),
    (2,3,10),
    (1,4,10);

insert detailsofentry(detailsofentry_id, id_import, id_material, import_quantity, importunitprice, note) VALUES
    (1,1,1,100,1000000,'null'),
    (2,2,2,150,200000,'null'),
    (3,3,3,200,10000000,'null'),
    (4,1,4,100,100000,'null'),
    (5,2,5,80,500000,'null'),
    (6,3,1,140,1000000,'null');

insert detailsoftherelease(detailsoftherelease_id, id_export, id_material, export_quantity, exportunitprice, note) VALUES
    (1,1,1,80,1200000,'Ban hàng'),
    (2,2,2,80,250000,'Ban hàng'),
    (3,3,3,80,11000000,'Ban hàng'),
    (4,1,4,80,110000,'Ban hàng'),
    (5,2,5,80,550000,'Ban hàng'),
    (6,3,1,80,1200000,'Ban hàng');



# Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các thông tin sau: số phiếu nhập hàng,
#     mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

create view view_CTPNHAP as
select import_id,material_code,import_quantity,importUnitPrice, (import_quantity*importUnitPrice) as 'Thành tiền'
from DetailsOfEntry
         join material m on m.material_id = DetailsOfEntry.id_material
         join importTicket iT on iT.import_id = DetailsOfEntry.id_import;



# Câu 2. Tạo view có tên vw_CTPNHAP_VT bao gồm các thông tin sau: số phiếu nhập hàng,
# mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

create view view_CTPNHAP_VT as
select import_id,material_code,material_name,import_quantity,importUnitPrice,
       (import_quantity*importUnitPrice) as 'Thành tiền' from detailsofentry
                                                                  join importTicket iT on iT.import_id = DetailsOfEntry.id_import
                                                                  join material m on m.material_id = DetailsOfEntry.id_material;



# Câu 3. Tạo view có tên vw_CTPNHAP_VT_PN bao gồm các thông tin sau: số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng,
# mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

create view view_CTPNHAP_VT_PN as
select import_id, date(import_date),order_id, material_code, material_name,import_quantity,importUnitPrice,
    (import_quantity*importUnitPrice) as 'Thành tiền' from detailsofentry
    join importTicket iT on iT.import_id = DetailsOfEntry.id_import
    join theOrder t on t.order_id = iT.id_order
    join material m on m.material_id = DetailsOfEntry.id_material;






# Câu 4. Tạo view có tên vw_CTPNHAP_VT_PN_DH bao gồm các thông tin sau: số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng,
# mã nhà cung cấp, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

create view vw_CTPNHAP_VT_PN_DH as
select import_id, date(import_date), order_id, supplier_code,material_code,material_name,import_quantity,importUnitPrice,
    (import_quantity*importUnitPrice) as 'Thành tiền' from detailsofentry
    join importTicket iT on iT.import_id = DetailsOfEntry.id_import
    join theOrder t on t.order_id = iT.id_order
    join supplier s on s.supplier_id = t.id_supplier
    join material m on m.material_id = DetailsOfEntry.id_material;





# Câu 5. Tạo view có tên vw_CTPNHAP_loc  bao gồm các thông tin sau: số phiếu nhập hàng, mã vật tư, số lượng nhập,
# đơn giá nhập, thành tiền nhập. Và chỉ liệt kê các chi tiết nhập có số lượng nhập > 100.

create view view_CTPNHAP_loc as
select import_id, material_code, import_quantity,  importUnitPrice, (import_quantity*importUnitPrice) as 'Thành tiền'
from detailsofentry
         join importTicket iT on iT.import_id = DetailsOfEntry.id_import
         join material m on m.material_id = DetailsOfEntry.id_material
where import_quantity > 100;





# Câu 6. Tạo view có tên vw_CTPNHAP_VT_loc bao gồm các thông tin sau: số phiếu nhập hàng, mã vật tư, tên vật tư,
# số lượng nhập, đơn giá nhập, thành tiền nhập. Và chỉ liệt kê các chi tiết nhập vật tư có đơn vị tính là tấn.

create view  view_CTPNHAP_VT_loc as
select import_id, material_code, material_name, import_quantity,importUnitPrice,
       (import_quantity*importUnitPrice) as 'Thành tiền' from detailsofentry
                                                                  join importTicket iT on iT.import_id = DetailsOfEntry.id_import
                                                                  join material m on m.material_id = DetailsOfEntry.id_material
where unit = 'tấn';




# Câu 7. Tạo view có tên vw_CTPXUAT bao gồm các thông tin sau: số phiếu xuất hàng, mã vật tư,
# số lượng xuất, đơn giá xuất, thành tiền xuất.

create view   view_CTPXUAT as
select export_id, material_code, export_quantity, exportunitprice,
       (export_quantity*DetailsOfTheRelease.exportUnitPrice) as 'Thành tiền' from detailsoftherelease
                                                                                      join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
                                                                                      join material m on m.material_id = DetailsOfTheRelease.id_material;




# Câu 8. Tạo view có tên vw_CTPXUAT_VT bao gồm các thông tin sau: số phiếu xuất hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.

create view  view_CTPXUAT_VT as
select export_id, material_code, material_name,export_quantity, exportunitprice from detailsoftherelease
                                                                                         join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
                                                                                         join material m on m.material_id = DetailsOfTheRelease.id_material;



# Câu 9. Tạo view có tên vw_CTPXUAT_VT_PX bao gồm các thông tin sau: số phiếu xuất hàng, tên khách hàng, mã vật tư,
# tên vật tư, số lượng xuất, đơn giá xuất.

create view view_CTPXUAT_VT_PX as
select export_id, customer_name, material_code, material_name,export_quantity, exportunitprice from detailsoftherelease
                                                                                                        join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
                                                                                                        join material m on m.material_id = DetailsOfTheRelease.id_material;



# Tạo Stored procedure (SP) cho biết tổng số lượng cuối của vật tư với mã vật tư là tham số vào.

create procedure Total(in material_code1 int)
begin
select ((import_quantity - export_quantity)) as 'Tổng số lượng còn lại'
from detailsoftherelease
         join detailsofentry d on DetailsOfTheRelease.id_material = d.id_material
         join material m on m.material_id = DetailsOfTheRelease.id_material
where material_code = material_code1;
end;

call Total(333);


# Tạo SP cho biết tổng tiền xuất của vật tư với mã vật tư là tham số vào.

create procedure TotalAmount_Export (in materialCode int)
begin
select DetailsOfTheRelease_id as 'Số đơn chi tiết xuất hàng',  (export_quantity*exportUnitPrice) as 'Tổng tiền xuất'
from detailsoftherelease
         join material m on m.material_id = DetailsOfTheRelease.id_material
         join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export

where material_code = materialCode;
end;
call TotalAmount_Export(111);



# Tạo SP cho biết tổng số lượng đặt theo số đơn hàng với số đơn hàng là tham số vào.

create procedure totalAmountOder(in order_code int)
begin
select  OrderDetails_id as 'Mã số chi tiết đơn đặt hàng',oder_quantity as 'Số lượng'
from OrderDetails
where id_theOrder = order_code;
end;

call totalAmountOder(1);



# Tạo SP dùng để thêm một đơn đặt hàng.
create procedure addNewOrder(in code int, in date date, in id_supplier1 int)
begin
    insert theOrder(order_code, orderDate, id_supplier) VALUES
                    (code,date,id_supplier1);
end;
call addNewOrder(104,'2020-08-08',3);



# Tạo SP dùng để thêm một chi tiết đơn đặt hàng.
create procedure addNew_orderDetail(in orderID int, materialID int, quantity int)
begin
    insert orderdetails(id_theOrder, id_material, oder_quantity) VALUES
                          (orderID, materialID, quantity);
end;

call addNew_orderDetail(4,5,30);




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
    (111,'Xi M??ng','T???n',1000000),
    (222,'C??t','Kh???i',200000),
    (333,'S???t','T???n',10000000),
    (444,'G???ch Hoa','M??t vu??ng',100000),
    (555,'S??n n?????c','Th??ng',500000);

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
    (8001, 'Nh?? m??y xi m??ng Nghi S??n', 'TX Nghi S??n - Thanh H??a', '0333321112'),
    (8002, 'Nh?? m??y th??p H??a Ph??t', 'Th??i Nguy??n', '0333321115'),
    (8003, 'Nh?? m??y abc', 'H?? Nam', '0333321118');

insert theOrder(order_code, orderDate, id_supplier) VALUES
    (101, '2021-05-19',1),
    (102, '2021-04-18',2),
    (103, '2021-03-17',3);

insert importTicket(import_code, import_date, id_order) VALUES
    (3001,'2021-05-02',1),
    (3002,'2021-04-15',2),
    (3003,'2021-03-01',3);

insert exportTicket(export_code, export_date, customer_name) VALUES
    (546151,'2021-03-05','Nguyen V??n Anh'),
    (546152,'2021-02-06','Nguyen V??n Trung'),
    (546153,'2021-01-03','Nguyen V??n Khang');

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
    (1,1,1,80,1200000,'Ban h??ng'),
    (2,2,2,80,250000,'Ban h??ng'),
    (3,3,3,80,11000000,'Ban h??ng'),
    (4,1,4,80,110000,'Ban h??ng'),
    (5,2,5,80,550000,'Ban h??ng'),
    (6,3,1,80,1200000,'Ban h??ng');



# C??u 1. T???o view c?? t??n vw_CTPNHAP bao g???m c??c th??ng tin sau: s??? phi???u nh???p h??ng,
#     m?? v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

create view view_CTPNHAP as
    select import_id,material_code,import_quantity,importUnitPrice, (import_quantity*importUnitPrice) as 'Th??nh ti???n'
from DetailsOfEntry
join material m on m.material_id = DetailsOfEntry.id_material
join importTicket iT on iT.import_id = DetailsOfEntry.id_import;



# C??u 2. T???o view c?? t??n vw_CTPNHAP_VT bao g???m c??c th??ng tin sau: s??? phi???u nh???p h??ng,
# m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

create view view_CTPNHAP_VT as
    select import_id,material_code,material_name,import_quantity,importUnitPrice,
           (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
    join importTicket iT on iT.import_id = DetailsOfEntry.id_import
join material m on m.material_id = DetailsOfEntry.id_material;



# C??u 3. T???o view c?? t??n vw_CTPNHAP_VT_PN bao g???m c??c th??ng tin sau: s??? phi???u nh???p h??ng, ng??y nh???p h??ng, s??? ????n ?????t h??ng,
# m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

create view view_CTPNHAP_VT_PN as
    select import_id, date(import_date),order_id, material_code, material_name,import_quantity,importUnitPrice,
         (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
    join importTicket iT on iT.import_id = DetailsOfEntry.id_import
    join theOrder t on t.order_id = iT.id_order
    join material m on m.material_id = DetailsOfEntry.id_material;






# C??u 4. T???o view c?? t??n vw_CTPNHAP_VT_PN_DH bao g???m c??c th??ng tin sau: s??? phi???u nh???p h??ng, ng??y nh???p h??ng, s??? ????n ?????t h??ng,
# m?? nh?? cung c???p, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

create view vw_CTPNHAP_VT_PN_DH as
    select import_id, date(import_date), order_id, supplier_code,material_code,material_name,import_quantity,importUnitPrice,
           (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
    join importTicket iT on iT.import_id = DetailsOfEntry.id_import
    join theOrder t on t.order_id = iT.id_order
    join supplier s on s.supplier_id = t.id_supplier
    join material m on m.material_id = DetailsOfEntry.id_material;





# C??u 5. T???o view c?? t??n vw_CTPNHAP_loc  bao g???m c??c th??ng tin sau: s??? phi???u nh???p h??ng, m?? v???t t??, s??? l?????ng nh???p,
# ????n gi?? nh???p, th??nh ti???n nh???p. V?? ch??? li???t k?? c??c chi ti???t nh???p c?? s??? l?????ng nh???p > 100.

create view view_CTPNHAP_loc as
    select import_id, material_code, import_quantity,  importUnitPrice, (import_quantity*importUnitPrice) as 'Th??nh ti???n'
    from detailsofentry
    join importTicket iT on iT.import_id = DetailsOfEntry.id_import
    join material m on m.material_id = DetailsOfEntry.id_material
    where import_quantity > 100;





# C??u 6. T???o view c?? t??n vw_CTPNHAP_VT_loc bao g???m c??c th??ng tin sau: s??? phi???u nh???p h??ng, m?? v???t t??, t??n v???t t??,
# s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p. V?? ch??? li???t k?? c??c chi ti???t nh???p v???t t?? c?? ????n v??? t??nh l?? t???n.

create view  view_CTPNHAP_VT_loc as
   select import_id, material_code, material_name, import_quantity,importUnitPrice,
         (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
    join importTicket iT on iT.import_id = DetailsOfEntry.id_import
    join material m on m.material_id = DetailsOfEntry.id_material
    where unit = 't???n';




# C??u 7. T???o view c?? t??n vw_CTPXUAT bao g???m c??c th??ng tin sau: s??? phi???u xu???t h??ng, m?? v???t t??,
# s??? l?????ng xu???t, ????n gi?? xu???t, th??nh ti???n xu???t.

create view   view_CTPXUAT as
    select export_id, material_code, export_quantity, exportunitprice,
           (export_quantity*DetailsOfTheRelease.exportUnitPrice) as 'Th??nh ti???n' from detailsoftherelease
    join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
    join material m on m.material_id = DetailsOfTheRelease.id_material;




# C??u 8. T???o view c?? t??n vw_CTPXUAT_VT bao g???m c??c th??ng tin sau: s??? phi???u xu???t h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.

create view  view_CTPXUAT_VT as
    select export_id, material_code, material_name,export_quantity, exportunitprice from detailsoftherelease
    join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
    join material m on m.material_id = DetailsOfTheRelease.id_material;



# C??u 9. T???o view c?? t??n vw_CTPXUAT_VT_PX bao g???m c??c th??ng tin sau: s??? phi???u xu???t h??ng, t??n kh??ch h??ng, m?? v???t t??,
# t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.

create view view_CTPXUAT_VT_PX as
    select export_id, customer_name, material_code, material_name,export_quantity, exportunitprice from detailsoftherelease
    join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
    join material m on m.material_id = DetailsOfTheRelease.id_material;



# T???o Stored procedure (SP) cho bi???t t???ng s??? l?????ng cu???i c???a v???t t?? v???i m?? v???t t?? l?? tham s??? v??o.

create procedure Total(in material_code1 int)
    begin
        select ((number + totalAmountEntered - totalExportQuantity)) as 'S???'
        from inventory
                 join material m on m.material_id = inventory.id_material
        where material_code = material_code1;

    end;
call Total(333);







# T???o SP cho bi???t t???ng ti???n xu???t c???a v???t t?? v???i m?? v???t t?? l?? tham s??? v??o.

create procedure TotalAmount_Export (in materialCode int)
    begin
        select DetailsOfTheRelease_id as 'S??? ????n chi ti???t xu???t h??ng',  (export_quantity*exportUnitPrice) as 'T???ng ti???n xu???t'
        from detailsoftherelease
                 join material m on m.material_id = DetailsOfTheRelease.id_material
                 join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export

        where material_code = materialCode;
    end;
call TotalAmount_Export(111);



# T???o SP cho bi???t t???ng s??? l?????ng ?????t theo s??? ????n h??ng v???i s??? ????n h??ng l?? tham s??? v??o.

create procedure totalAmountOder(in order_code int)
    begin
        select  OrderDetails_id as 'M?? s??? chi ti???t ????n ?????t h??ng',oder_quantity as 'S??? l?????ng'
        from OrderDetails
            where id_theOrder = order_code;
    end;

call totalAmountOder(1);



# T???o SP d??ng ????? th??m m???t ????n ?????t h??ng.
create procedure addNewOrder(in code int, in date date, in id_supplier1 int)
begin
    insert theOrder(order_code, orderDate, id_supplier) VALUES
                    (code,date,id_supplier1);
end;
call addNewOrder(104,'2020-08-08',3);



# T???o SP d??ng ????? th??m m???t chi ti???t ????n ?????t h??ng.
create procedure addNew_orderDetail(in orderID int, materialID int, quantity int)
begin
    insert orderdetails(id_theOrder, id_material, oder_quantity) VALUES
                          (orderID, materialID, quantity);
end;

call addNew_orderDetail(4,5,30);







# 1.s??? phi???u nh???p h??ng, m?? v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n.

 select import_id,material_code, import_quantity, importUnitPrice from detailsofentry
 join material m on m.material_id = DetailsOfEntry.id_material
 join importTicket iT on iT.import_id = DetailsOfEntry.id_import;



 # 2.s??? phi???u nh???p h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

 select import_id, material_code,material_name,import_quantity,importUnitPrice,
        (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
 join importTicket iT on DetailsOfEntry.id_import = iT.import_id
 join material m on m.material_id = DetailsOfEntry.id_material;


# 3.s??? phi???u nh???p h??ng, ng??y nh???p h??ng, s??? ????n ?????t h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p,
# ????n gi?? nh???p, th??nh ti???n nh???p.
# --
select import_id, day(import_date), order_id, material_code, material_name,import_quantity,importUnitPrice,
       (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
join importTicket iT on iT.import_id = DetailsOfEntry.id_import
           join theOrder t on t.order_id = iT.id_order
join material m on m.material_id = DetailsOfEntry.id_material;



# 4.  s??? phi???u nh???p h??ng, ng??y nh???p h??ng, s??? ????n ?????t h??ng, m?? nh?? cung c???p,
# m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.
# --
select import_id, day(import_date), order_id, supplier_code,material_code,material_name,import_quantity,importUnitPrice,
       (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
join importTicket iT on iT.import_id = DetailsOfEntry.id_import
join material m on m.material_id = DetailsOfEntry.id_material
join theOrder t on iT.id_order = t.order_id
join supplier s on s.supplier_id = t.id_supplier;
# --
# --
# --
# 5.s??? phi???u nh???p h??ng, m?? v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.
# V?? ch??? li???t k?? c??c chi ti???t nh???p c?? s??? l?????ng nh???p > 100.
# --
select import_id, material_code, import_quantity,  importUnitPrice, (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
  join importTicket iT on iT.import_id = DetailsOfEntry.id_import
  join theOrder t on t.order_id = iT.id_order
  join material m on m.material_id = DetailsOfEntry.id_material
where import_quantity > 100;
# --
# --
# 6.s??? phi???u nh???p h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.
# V?? ch??? li???t k?? c??c chi ti???t nh???p v???t t?? c?? ????n v??? t??nh l?? T???n.
# --
select import_id, material_code, material_name, import_quantity,importUnitPrice,
       (import_quantity*importUnitPrice) as 'Th??nh ti???n' from detailsofentry
join importTicket iT on iT.import_id = DetailsOfEntry.id_import
join material m on m.material_id = DetailsOfEntry.id_material
where unit = 't???n';
# --
# --
# 7.s??? phi???u xu???t h??ng, m?? v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t, th??nh ti???n xu???t.
# --
select export_id, material_code, export_quantity, exportunitprice,
       (export_quantity*DetailsOfTheRelease.exportUnitPrice) as 'Th??nh ti???n' from detailsoftherelease
join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
join material m on m.material_id = DetailsOfTheRelease.id_material;
# --
# --
# 8.s??? phi???u xu???t h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.
# --
select export_id, material_code, material_name,export_quantity, exportunitprice from detailsoftherelease
join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
join material m on m.material_id = DetailsOfTheRelease.id_material;
# --
# --
# 9.s??? phi???u xu???t h??ng, t??n kh??ch h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.
# --
select export_id, customer_name, material_code, material_name,export_quantity, exportunitprice from detailsoftherelease
join exportTicket eT on eT.export_id = DetailsOfTheRelease.id_export
join material m on m.material_id = DetailsOfTheRelease.id_material;



















use aly;
INSERT INTO customer(username, firstName, lastName, Email, password, phoneNumber, Address, payment_details)
VALUES
('l2wc1d', 'Stephen', 'Abenoja', 's.abenoja04@gmail.com', 'seriansp1', '09012345678', '123 Main St, Manila, Philippines', '09151342212')
, ('l3wc1d', 'Stephen', 'Abenoja', 's.abenoja04@gmail.com', 'seriansp1', '09012345678', '123 Main St, Manila, Philippines', '09151342212')
-- , 
;
commit;

INSERT INTO ADMIN(username, firstName, lastName, email, password)
VALUES
('l1wc1d', 'Stephen', 'Admin', 's.abenoja05@gmail.com', 'seriansp1')

;


INSERT INTO services(serviceType)
VALUES
('Laundry-Regular Clothes'),
('Laundry-Comforters'),
('Laundry-Linens'),
('Beddings & Towels'),
('Shoe Cleaning'),
('Dry Clean-Pants'),
('Dry Clean-Dress (S)'),
('Dry Clean-Dress (M)'),
('Dry Clean-Dress (L)'),
('Dry Clean-Dress (XL)')
;

INSERT INTO merchant(merchant_id, name, email, password, phoneNumber, address, paymentDetails)
VALUES
('merchant1', 'merchant1', 'email@email.com', '12qwaszx', '09151342212', '123123123 aisdjaosdij', '09151342212'),
('merchant2', 'merchant2', 'email@email.com', '12qwaszx', '09151342212', '123123123 aisdjaosdij', '09151342212'),
('merchant3', 'merchant3', 'email@email.com', '12qwaszx', '09151342212', '123123123 aisdjaosdij', '09151342212')
;

INSERT INTO merchantservices(merchant_id, serviceType)
VALUES
('merchant1', 'Laundry-Regular Clothes'),
('merchant1', 'Laundry-Comforters'),
('merchant1', 'Dry Clean-Pants'),
('merchant1', 'Beddings & Towels'),
('merchant2', 'Dry Clean-Dress (S)'),
('merchant2', 'Dry Clean-Pants'),
('merchant2', 'Shoe Cleaning'),
('merchant2', 'Dry Clean-Dress (M)'),
('merchant3', 'Dry Clean-Dress (L)'),
('merchant3', 'Laundry-Linens'),
('merchant3', 'Shoe Cleaning'),
('merchant3', 'Beddings & Towels')
;





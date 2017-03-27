DROP
  TABLE booking CASCADE CONSTRAINTS ;

DROP
  TABLE booking_room_guests CASCADE CONSTRAINTS ;

DROP
  TABLE customer CASCADE CONSTRAINTS ;

DROP
  TABLE facilities CASCADE CONSTRAINTS ;

DROP
  TABLE guest CASCADE CONSTRAINTS ;

DROP
  TABLE hotel CASCADE CONSTRAINTS ;

DROP
  TABLE menbership CASCADE CONSTRAINTS ;

DROP
  TABLE payment CASCADE CONSTRAINTS ;

DROP
  TABLE room CASCADE CONSTRAINTS ;

DROP
  TABLE room_facilities CASCADE CONSTRAINTS ;

CREATE
  TABLE booking
  (
    booking_id     CHAR (8 CHAR) NOT NULL ,
    customer_id    CHAR (5 CHAR) NOT NULL ,
    check_in_date  DATE ,
    check_out_date DATE ,
    contect_person VARCHAR2 (50 CHAR) NOT NULL ,
    contect_email  VARCHAR2 (50 CHAR) ,
    total_amount   NUMBER NOT NULL ,
    payment_status VARCHAR2 (10) NOT NULL
  ) ;
ALTER TABLE booking ADD CONSTRAINT check_out_date_check CHECK ( check_out_date
> check_in_date) ;
ALTER TABLE booking ADD CONSTRAINT payment_status_check CHECK ( payment_status
IN ('paid','unpaid','pending')) ;
ALTER TABLE booking ADD CONSTRAINT booking_PK PRIMARY KEY ( booking_id ) ;


CREATE
  TABLE booking_room_guests
  (
    booking_id CHAR (8 CHAR) NOT NULL ,
    hotel_id   CHAR (5 CHAR) NOT NULL ,
    room_num   CHAR (4 CHAR) NOT NULL ,
    guest_id   CHAR (5 CHAR) NOT NULL
  ) ;
ALTER TABLE booking_room_guests ADD CONSTRAINT booking_room_guests_PK PRIMARY
KEY ( booking_id, hotel_id, room_num, guest_id ) ;


CREATE
  TABLE customer
  (
    customer_id     CHAR (5 CHAR) NOT NULL ,
    title           VARCHAR2 (6 CHAR) NOT NULL ,
    first_name      VARCHAR2 (20 CHAR) NOT NULL ,
    last_name       VARCHAR2 (20 CHAR) NOT NULL ,
    DOB             DATE NOT NULL ,
    country         VARCHAR2 (15 CHAR) NOT NULL ,
    city            VARCHAR2 (20 CHAR) NOT NULL ,
    street          VARCHAR2 (100 CHAR) NOT NULL ,
    postcode        VARCHAR2 (10 CHAR) NOT NULL ,
    membership_tier VARCHAR2 (10 CHAR) NOT NULL ,
    phone_number    VARCHAR2 (10 CHAR) NOT NULL ,
    email           VARCHAR2 (50 CHAR) NOT NULL
  ) ;
ALTER TABLE customer ADD CONSTRAINT title_check CHECK ( title IN ('Mr', 'Mrs',
'Miss', 'Others')) ;
ALTER TABLE customer ADD CONSTRAINT customer_PK PRIMARY KEY ( customer_id ) ;


CREATE
  TABLE facilities
  (
    facility_id          CHAR (5 CHAR) NOT NULL ,
    facility_description VARCHAR2 (20) NOT NULL
  ) ;
ALTER TABLE facilities ADD CONSTRAINT facilities_PK PRIMARY KEY ( facility_id )
;


CREATE
  TABLE guest
  (
    guest_id     CHAR (5 CHAR) NOT NULL ,
    title        VARCHAR2 (6 CHAR) NOT NULL ,
    first_name   VARCHAR2 (20 CHAR) NOT NULL ,
    last_name    VARCHAR2 (20 CHAR) NOT NULL ,
    DOB          DATE NOT NULL ,
    country      VARCHAR2 (15 CHAR) NOT NULL ,
    city         VARCHAR2 (20 CHAR) NOT NULL ,
    street       VARCHAR2 (100 CHAR) NOT NULL ,
    postcode     VARCHAR2 (10 CHAR) NOT NULL ,
    phone_number VARCHAR2 (10 CHAR) NOT NULL ,
    email        VARCHAR2 (50 CHAR) NOT NULL
  ) ;
ALTER TABLE guest ADD CONSTRAINT gtitle_check CHECK ( title IN ('Mr', 'Mrs',
'Miss', 'Others')) ;
ALTER TABLE guest ADD CONSTRAINT guest_PK PRIMARY KEY ( guest_id ) ;


CREATE
  TABLE hotel
  (
    hotel_id          CHAR (5 CHAR) NOT NULL ,
    hotel_name        VARCHAR2 (50 CHAR) NOT NULL ,
    hotel_type        VARCHAR2 (7) NOT NULL ,
    construction_year NUMBER NOT NULL ,
    country           VARCHAR2 (15 CHAR) NOT NULL ,
    city              VARCHAR2 (20 CHAR) NOT NULL ,
    address           VARCHAR2 (100 CHAR) NOT NULL ,
    contect_number    VARCHAR2 (15 CHAR) NOT NULL ,
    email             VARCHAR2 (50 CHAR) NOT NULL
  ) ;
ALTER TABLE hotel ADD CONSTRAINT hotel_type_check CHECK ( hotel_type IN (
'1 star', '2 stars', '3 stars', '4 stars', '5 stars')) ;
ALTER TABLE hotel ADD CONSTRAINT hotel_PK PRIMARY KEY ( hotel_id ) ;


CREATE
  TABLE menbership
  (
    membership_tier VARCHAR2 (10 CHAR) NOT NULL ,
    tier_credits    NUMBER NOT NULL ,
    discount        NUMBER NOT NULL ,
    other_Redwards  VARCHAR2 (20 CHAR)
  ) ;
ALTER TABLE menbership ADD CONSTRAINT membership_tier_check CHECK (
membership_tier IN ('Bronze', 'Silver', 'Gold', 'Platinum')) ;
ALTER TABLE menbership ADD CONSTRAINT discount_check CHECK ( discount >= 0) ;
ALTER TABLE menbership ADD CONSTRAINT menbership_PK PRIMARY KEY (
membership_tier ) ;


CREATE
  TABLE payment
  (
    payment_id     CHAR (6 CHAR) NOT NULL ,
    booking_id     CHAR (8 CHAR) NOT NULL ,
    payment_date   DATE NOT NULL ,
    payment_method VARCHAR2 (10 CHAR) NOT NULL ,
    payment_amount NUMBER NOT NULL
  ) ;
ALTER TABLE payment ADD CONSTRAINT payment_method_check CHECK ( payment_method
IN ('Cash', 'Credit', 'BPay', 'PayPal', 'Others')) ;
ALTER TABLE payment ADD CONSTRAINT payment_amount_noneg CHECK ( payment_amount
>= 0) ;
ALTER TABLE payment ADD CONSTRAINT payment_PK PRIMARY KEY ( payment_id ) ;


CREATE
  TABLE room
  (
    room_number CHAR (4 CHAR) NOT NULL ,
    hotel_id    CHAR (5 CHAR) NOT NULL ,
    room_type   VARCHAR2 (10 CHAR) NOT NULL ,
    room_occ    NUMBER NOT NULL ,
    price       NUMBER NOT NULL ,
    description VARCHAR2 (50)
  ) ;
ALTER TABLE room ADD CONSTRAINT room_type_check CHECK ( room_type IN ('single',
'double', 'studio', 'suite', 'others')) ;
ALTER TABLE room ADD CONSTRAINT room_occupation_check CHECK ( room_occ >= 0) ;
ALTER TABLE room ADD CONSTRAINT price_check CHECK ( price               > 0) ;
ALTER TABLE room ADD CONSTRAINT room_PK PRIMARY KEY ( room_number, hotel_id ) ;


CREATE
  TABLE room_facilities
  (
    room_number         CHAR (4 CHAR) NOT NULL ,
    hotel_id            CHAR (5 CHAR) NOT NULL ,
    facilities_id       CHAR (5 CHAR) NOT NULL ,
    facilities_quantity NUMBER NOT NULL
  ) ;
ALTER TABLE room_facilities ADD CONSTRAINT facilities_quantity_check CHECK (
facilities_quantity >= 0) ;
ALTER TABLE room_facilities ADD CONSTRAINT room_facilities_PK PRIMARY KEY (
facilities_id, room_number, hotel_id ) ;


ALTER TABLE booking ADD CONSTRAINT booking_customer_FK FOREIGN KEY (
customer_id ) REFERENCES customer ( customer_id ) ;

ALTER TABLE booking_room_guests ADD CONSTRAINT booking_room_guests_booking_FK
FOREIGN KEY ( booking_id ) REFERENCES booking ( booking_id ) ON
DELETE CASCADE ;

ALTER TABLE booking_room_guests ADD CONSTRAINT booking_room_guests_guest_FK
FOREIGN KEY ( guest_id ) REFERENCES guest ( guest_id ) ON
DELETE CASCADE ;

ALTER TABLE booking_room_guests ADD CONSTRAINT booking_room_guests_room_FK
FOREIGN KEY ( room_num, hotel_id ) REFERENCES room ( room_number, hotel_id ) ;

ALTER TABLE customer ADD CONSTRAINT customer_menbership_FK FOREIGN KEY (
membership_tier ) REFERENCES menbership ( membership_tier ) ON
DELETE CASCADE ;

ALTER TABLE payment ADD CONSTRAINT payment_booking_FK FOREIGN KEY ( booking_id
) REFERENCES booking ( booking_id ) ;

ALTER TABLE room_facilities ADD CONSTRAINT room_facilities_facilities_FK
FOREIGN KEY ( facilities_id ) REFERENCES facilities ( facility_id ) ON
DELETE CASCADE ;

ALTER TABLE room_facilities ADD CONSTRAINT room_facilities_room_FK FOREIGN KEY
( room_number, hotel_id ) REFERENCES room ( room_number, hotel_id ) ON
DELETE CASCADE ;

ALTER TABLE room ADD CONSTRAINT room_hotel_FK FOREIGN KEY ( hotel_id )
REFERENCES hotel ( hotel_id ) ON
DELETE CASCADE ;
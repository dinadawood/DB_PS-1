--CISC437-010: PS1

--Order: Customer, Orders, Product_Status, Product, Orders_Line

DROP TABLE IF EXISTS orders_line;

DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS product;

DROP TABLE IF EXISTS product_status;

DROP TABLE IF EXISTS customer;


--TABLE: CUSTOMER
CREATE TABLE customer (
    customer_id            VARCHAR2(38 BYTE) NOT NULL,
    customer_first_name    VARCHAR2(30 BYTE) NOT NULL,
    customer_middle_name   VARCHAR2(30 BYTE),
    customer_last_name     VARCHAR2(30 BYTE) NOT NULL,
    customer_date_of_birth DATE,
    customer_gender        VARCHAR2(10 BYTE),
    customer_crtd_id       VARCHAR2(40 BYTE) NOT NULL,
    customer_crtd_dt       DATE NOT NULL,
    customer_updt_id       VARCHAR2(40 BYTE) NOT NULL,
    customer_updt_dt       DATE NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY ( customer_id )
        USING INDEX (
            CREATE UNIQUE INDEX customer_pk ON
                customer (
                    customer_id
                ASC )
                    LOGGING TABLESPACE users PCTFREE 10 INITRANS 2
                        STORAGE ( BUFFER_POOL DEFAULT )
                        NOPARALLEL
        )
    ENABLE
)
LOGGING TABLESPACE users PCTFREE 10 INITRANS 1
    STORAGE ( BUFFER_POOL DEFAULT )
NOCOMPRESS NO INMEMORY
    NOPARALLEL;


--TABLE: ORDERS
CREATE TABLE orders (
    orders_id          VARCHAR2(38 BYTE) NOT NULL,
    orders_date        TIMESTAMP(6) NOT NULL,
    orders_customer_id VARCHAR2(32 BYTE) NOT NULL,
    orders_crtd_id     VARCHAR2(40 BYTE) NOT NULL,
    orders_crtd_dt     DATE NOT NULL,
    orders_updt_id     VARCHAR2(40 BYTE) NOT NULL,
    orders_updt_dt     DATE NOT NULL,
    CONSTRAINT orders_pk PRIMARY KEY ( orders_id )
        USING INDEX (
            CREATE UNIQUE INDEX "BIN$d0lh1fXZRtyKtvcj1BsgIg==$0" ON
                orders (
                    orders_id
                ASC )
                    LOGGING TABLESPACE users PCTFREE 10 INITRANS 2
                        STORAGE ( BUFFER_POOL DEFAULT )
                        NOPARALLEL
        )
    ENABLE
)
LOGGING TABLESPACE users PCTFREE 10 INITRANS 1
    STORAGE ( BUFFER_POOL DEFAULT )
NOCOMPRESS NO INMEMORY
    NOPARALLEL;

ALTER TABLE orders
    ADD CONSTRAINT orders_fk1 FOREIGN KEY ( orders_customer_id )
        REFERENCES customer ( customer_id )
    ENABLE;



--TABLE: PRODUCT_STATUS
CREATE TABLE product_status (
    product_status_id      VARCHAR2(38 BYTE) NOT NULL,
    product_status_desc    VARCHAR2(32 BYTE) NOT NULL,
    product_status_crtd_id VARCHAR2(40 BYTE) NOT NULL,
    product_status_crtd_dt DATE NOT NULL,
    product_status_updt_id VARCHAR2(40 BYTE) NOT NULL,
    product_status_updt_dt DATE NOT NULL,
    CONSTRAINT product_status_pk PRIMARY KEY ( product_status_id )
        USING INDEX (
            CREATE UNIQUE INDEX product_status_pk ON
                product_status (
                    product_status_id
                ASC )
                    LOGGING TABLESPACE users PCTFREE 10 INITRANS 2
                        STORAGE ( BUFFER_POOL DEFAULT )
                        NOPARALLEL
        )
    ENABLE
)
LOGGING TABLESPACE users PCTFREE 10 INITRANS 1
    STORAGE ( BUFFER_POOL DEFAULT )
NOCOMPRESS NO INMEMORY
    NOPARALLEL;


--TABLE: PRODUCT
CREATE TABLE product (
    product_id                VARCHAR2(38 BYTE) NOT NULL,
    product_name              VARCHAR2(200 BYTE) NOT NULL,
    product_desc              VARCHAR2(2000 BYTE) NOT NULL,
    product_product_status_id VARCHAR2(38 BYTE) NOT NULL,
    product_crtd_id           VARCHAR2(40 BYTE) NOT NULL,
    product_crtd_dt           DATE NOT NULL,
    product_updt_id           VARCHAR2(40 BYTE) NOT NULL,
    product_updt_dt           DATE NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY ( product_id )
        USING INDEX (
            CREATE UNIQUE INDEX product_pk ON
                product (
                    product_id
                ASC )
                    LOGGING TABLESPACE users PCTFREE 10 INITRANS 2
                        STORAGE ( BUFFER_POOL DEFAULT )
                        NOPARALLEL
        )
    ENABLE
)
LOGGING TABLESPACE users PCTFREE 10 INITRANS 1
    STORAGE ( BUFFER_POOL DEFAULT )
NOCOMPRESS NO INMEMORY
    NOPARALLEL;

ALTER TABLE product
    ADD CONSTRAINT product_fk1 FOREIGN KEY ( product_product_status_id )
        REFERENCES product_status ( product_status_id )
    ENABLE;


--TABLE: ORDERS_LINE
CREATE TABLE orders_line (
    orders_line_id         VARCHAR2(38 BYTE) NOT NULL,
    orders_line_orders_id  VARCHAR2(38 BYTE) NOT NULL,
    orders_line_product_id VARCHAR2(38 BYTE) NOT NULL,
    orders_line_qty        NUMBER (4, 0) NOT NULL,
    orders_line_price      NUMBER (9, 0) NOT NULL,
    orders_line_crtd_id    VARCHAR2(40 BYTE) NOT NULL,
    orders_line_crtd_dt    DATE NOT NULL,
    orders_line_updt_id    VARCHAR2(40 BYTE) NOT NULL,
    orders_line_updt_dt    DATE NOT NULL,
    CONSTRAINT orders_line_pk PRIMARY KEY ( orders_line_id )
        USING INDEX (
            CREATE UNIQUE INDEX orders_line_pk ON
                orders_line (
                    orders_line_id
                ASC )
                    LOGGING TABLESPACE users PCTFREE 10 INITRANS 2
                        STORAGE ( BUFFER_POOL DEFAULT )
                        NOPARALLEL
        )
    ENABLE
)
LOGGING TABLESPACE users PCTFREE 10 INITRANS 1
    STORAGE ( BUFFER_POOL DEFAULT )
NOCOMPRESS NO INMEMORY
    NOPARALLEL;

ALTER TABLE orders_line
    ADD CONSTRAINT orders_line_fk1 FOREIGN KEY ( orders_line_orders_id )
        REFERENCES orders ( orders_id )
    ENABLE;

ALTER TABLE orders_line
    ADD CONSTRAINT orders_line_fk2 FOREIGN KEY ( orders_line_product_id )
        REFERENCES product ( product_id )
    ENABLE;
    
BEGIN
    CHECK_ME(1);
END;
/
CREATE DATABASE aly;
USE aly;


CREATE TABLE Customer (
    username    		VARCHAR (100)   	NOT NULL
    , firstName   		VARCHAR(20)     	
    , lastName	   		VARCHAR(20) 	     		
    , email	    		VARCHAR(50)             	
    , password         	VARCHAR (30)   		NOT NULL	
    , phoneNumber		VARCHAR(11)
    , address			Varchar(200)
    , paymentDetails	VARCHAR(100)
    , CONSTRAINT 	 	PRIMARY KEY (username)
);

-- ALTER TABLE Customer
-- MODIFY firstName VARCHAR(20) NULL
-- ;

CREATE TABLE Admin (
    username    		VARCHAR (100)   	NOT NULL
    , firstName   		VARCHAR(20)     	
    , lastName	   		VARCHAR(20) 	     		
    , email	    		VARCHAR(50)             	
    , password         	VARCHAR (30)    NOT NULL 		
    , CONSTRAINT 	 	PRIMARY KEY (username)
);

CREATE TABLE Rider (
    username    		VARCHAR (100)   	NOT NULL
    , firstName   		VARCHAR(20)     	
    , lastName	   		VARCHAR(20) 	     		
    , email	    		VARCHAR(50)             	
    , password         	VARCHAR(30)     	
    , phoneNumber		VARCHAR(11)
    , address			Varchar(200)
    , paymentDetails	VARCHAR(100)
    , CONSTRAINT 	 	PRIMARY KEY (username)
);

-- DROP TABLE Merchant;
CREATE TABLE Merchant (
    merchantID    			VARCHAR(100)   	NOT NULL
    , shopName	   			VARCHAR(50)     	
    , email	    			VARCHAR(50)             	
    , password         		VARCHAR(30)     	
    , phoneNumber			VARCHAR(11)
    , address				Varchar(200)
    , paymentDetails		VARCHAR(100)
    , CONSTRAINT 	 		PRIMARY KEY (merchantID)
);
ALTER TABLE Customer
MODIFY phoneNumber			VARCHAR(11)
;

CREATE TABLE Services (
    serviceType			VARCHAR(100)		NOT NULL
    , CONSTRAINT 	 	PRIMARY KEY (serviceType)
);


-- DROP TABLE MerchantServices;
CREATE TABLE MerchantServices (
    merchantID        VARCHAR(100)    NOT NULL,
    serviceType        VARCHAR(100)    NOT NULL,
    CONSTRAINT fk_merchant FOREIGN KEY (merchantID) REFERENCES Merchant(merchantID),
    CONSTRAINT fk_service FOREIGN KEY (serviceType) REFERENCES Services(serviceType),
    CONSTRAINT pk_merchant_services PRIMARY KEY (merchantID, serviceType)
);
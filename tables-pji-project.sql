-- DATABASE PJI Backend Schema (MySQL/MariaDB) --

/*
XAMPP
cd..
cd..
cd xampp
cd mysql
cd bin
mysql -u root -h localhost -p
*/

/* 
WampServer
cd C:\wamp64\bin\mysql\mysql9.1.0\bin
mysql -u root
cd C:\wamp64\bin\mariadb\mariadb11.5.2\bin
mysql -u root
*/

CREATE DATABASE portal_pji_project;
USE portal_pji_project;

/* ===================================== CUSTOMER ========================= */
CREATE TABLE customer (                                              -- Crea la tabla llamada `customer
  customer_id    CHAR(36)      NOT NULL,                             -- Identificador primario del cliente en formato UUID textual (36 chars).
  name           VARCHAR(200)  NOT NULL,                             -- Nombre del cliente, hasta 200 carácteres.
  email          VARCHAR(254)  NOT NULL,                             -- Email del cliente, hasta 254 carácteres es el máximo típico según estándares.
  phone          VARCHAR(25)   NOT NULL,                             -- Teléfono, hasta 25 carácteres (incluye +, extensiones, espacios).       
  address        VARCHAR(255)  NOT NULL,                             -- Dirección del cliente, asta 255 caracteres.                
  active         TINYINT(1)    NOT NULL DEFAULT 1,                    
  created_at     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,   -- Marca de tiempo de creación. Se llena automáticamente al insertar.   
  updated_at     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,    -- Marca de tiempo de última actualización. Se llena al insertar
                               
  PRIMARY KEY (customer_id)     
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/* ======================================================================= */


/* ========================== SERVICE ========================== */
CREATE TABLE service (
  service_id     CHAR(36)       NOT NULL, 
  customer_id    CHAR(36)       NOT NULL,                 
  name           VARCHAR(150)   NOT NULL,                             
  description    VARCHAR(255)   NOT NULL,                                                      
  active         TINYINT(1)     NOT NULL DEFAULT 1,                  
  created_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (service_id),
  CONSTRAINT fk_customer_service
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/* ============================================================== */

/* ======================================= SESSION ======================================== */
CREATE TABLE session (
  session_id     CHAR(36)       NOT NULL,                 
  customer_id    CHAR(36)       NOT NULL,                                                                   
  user_agent     VARCHAR(255)   NOT NULL,                                       
  status         VARCHAR(20)    NOT NULL DEFAULT 'active',           
  started_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,  
  ended_at       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,                                          
  created_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  updated_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (session_id), 
  CONSTRAINT fk_customer_session
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/* ======================================================================================= */


/* =========================== PAYMENT ========================= */
CREATE TABLE payment (
  payment_id     CHAR(36)       NOT NULL,                 
  customer_id    CHAR(36)       NOT NULL,                                                                     
  amount         DECIMAL(12,2)  NOT NULL CHECK (amount >= 0),        
  currency       CHAR(3)        NOT NULL DEFAULT 'MXN',             
  method         VARCHAR(30)    NOT NULL,                            
  status         VARCHAR(20)    NOT NULL DEFAULT 'pending',          
  external_ref   VARCHAR(100)   NOT NULL,                                       
  paid_at        DATETIME       NOT NULL,                                          
  created_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (payment_id), 
  CONSTRAINT fk_customer_payment
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/* =============================================================== */


/* ====================================== VERIFICATION =================================== */
CREATE TABLE verification (
  verification_id CHAR(36)      NOT NULL,                 
  customer_id     CHAR(36)      NOT NULL,                             
  session_id      CHAR(36)      NOT NULL, 
  payment_id      CHAR(35)      NOT NULL,                                         
  type            VARCHAR(50)   NOT NULL,                            
  status          VARCHAR(50)   NOT NULL DEFAULT 'pending',       
  attempts        INT           NOT NULL DEFAULT 0,                  
  expires_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,                            
  verified_at     DATETIME      NULL,                                          
  created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  updated_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (verification_id),  

  CONSTRAINT fk_payment_verification
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id),

  CONSTRAINT fk_customer_verification
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),

  CONSTRAINT fk_session_verification
    FOREIGN KEY (session_id) REFERENCES session(session_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX idx_verification_customer_status ON verification (customer_id, status);
/* ========================================================================================= */


/* ====================== SERVICE_PRICE_RANGE ====================== */
CREATE TABLE service_price_range (
  range_id         CHAR(36)      NOT NULL,
  service_id       CHAR(36)      NOT NULL,
  min_monthly_rent DECIMAL(12,2) NOT NULL,             
  max_monthly_rent DECIMAL(12,2) NOT NULL,                       
  annual_price     DECIMAL(12,2) NOT NULL,              
  currency         CHAR(3)       NOT NULL DEFAULT 'MXN',
  description      VARCHAR(255)  NOT NULL,                      
  created_at       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (range_id),
  CONSTRAINT fk_range_service
    FOREIGN KEY (service_id) REFERENCES service(service_id),
  CONSTRAINT chk_rent_interval CHECK (min_monthly_rent >= 0 AND (max_monthly_rent IS NULL OR max_monthly_rent > min_monthly_rent))
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Índices útiles para búsqueda por renta
CREATE INDEX idx_range_service_bounds
  ON service_price_range (service_id, min_monthly_rent, max_monthly_rent);
/* ========================================================================================= */
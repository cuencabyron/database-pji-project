<h1 align="center">Descripción de la base de datos <em>portal_pji_project</em></h1>

---

1. **Tabla `CUSTOMER`:** Representa a la persona/empresa que usa la plataforma.
    - **`customer_id`:** Identificador único (UUID) del cliente, estable para exponer en APIs. 
        - PK
        - CHAR(36) 
        - NOT NULL 
    - **`name`:** Nombre completo o razón social. 
        - VARCHAR(150) 
        - NOT NULL 
    - **`email`:** Correo de contacto; único para evitar duplicados.    
        - UNIQUE 
        - VARCHAR(254)
        - NOT NULL 
    - **`phone`:** Teléfono del cliente. 
        - VARCHAR(30) 
        - NOT NULL 
    - **`address`:** Dirección del cliente. 
        - VARCHAR(120)
        - NOT NULL 
    - **`active`:** Activo/inactivo (soft-disable). 
        - TINYINT(1) 
        - NOT NULL DEFAULT 1 
    - **`created_at`:** Alta del registro. 
        - DATETIME 
        - NOT NULL DEFAULT CURRENT_TIMESTAMP 
    - **`updated_at`:** Última modificación.
        - DATETIME 
        - NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 

2) **Tabla `SERVICE`:** Catálogo de servicios (p. ej., Póliza Jurídica Digital, Investigación Digital, Protección Total, etc.) con tarifa.
    - **`service_id`:** Identificador único (UUID) del servicio. 
        - PK
        - CHAR(36) 
        - NOT NULL 
    - **`name`:** Nombre del servicio/póliza. 
        - VARCHAR(150) 
        - NOT NULL 
    - **`description`:** Descripción del servicio/póliza. 
        - VARCHAR(200) 
        - NOT NULL 
    - **`active`:** Activo/inactivo en catálogo. 
        - TINYINT(1) 
        - NOT NULL DEFAULT 1 
    - **`created_at`:** Alta del registro. 
        - DATETIME 
        - NOT NULL DEFAULT CURRENT_TIMESTAMP 
    - **`updated_at`:** Última modificación. 
        - DATETIME 
        - NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

3) **Tabla `SESSION`:** Sesiones de autenticación/uso (seguridad y auditoría).
    - **`session_id`:** Identificador único (UUID) de sesión.
        - PK
        - CHAR(36)
        - NOT NULL
    - **`customer_id`:** Dueño de la sessión.
        - FK
        - CHAR(36)
        - NOT NULL
    - **`user_agent`:** Navegador/dispositivo.
        - VARCHAR(100)
        - NOT NULL
    - **`status`:** 
    - **`started_at`:** Inicio de la sesión.
        - DATETIME
        - NOT NULL DEFAULT CURRENT_TIMESTAMP
    - **`ended_at`:** Fin de la sesión (al cerrar o expirar).
        - DATETIME
        - NOT NULL DEFAULT CURRENT_TIMESTAMP
    - **`created_at`:** Alta del registro.
        - DATETIME
        - NOT NULL DEFAULT CURRENT_TIMESTAMP
    - **`updated_at`:** Última modificación.
        - NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 

4) **Tabla `VERIFICATION`:** Flujo de verificación/validación (OTP/2FA, KYC, biometría).
    - **`verification_id`:** Identificador único (UUID) de verificación. 
        - PK
        - CHAR(36)
        - NOT NULL
    - **`customer_id`:** Cliente asociado.
        - FK
        - CHAR(36)
        - NOY NULL
    - **`session_id`:**  Seesión asociada.
        - FK
        - CHAR(36)
        - NOT NULL
    - **`session_id`:**  Seesión asociada.
        - FK
        - CHAR(36)
        - NOT NULL
    - 
5) **Tabla `PAYMENT`:** Transacciones monetarias realizadas por un cliente.


6) **Tabla `SERVICE_PRICE_RANGE`:**
    - **`range_id`:**  
    - **`service_id`:** 
    - **`min_monthly_rent`:**
    - **`max_monthly_rent`:** 
    - **`annual_price`:** 
    - **`currency`:** 
    - **`service_id`:** 
    - **`service_id`:** 
    - **`service_id`:** 
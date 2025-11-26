


/* ==================================================== CUSTOMER ======================================================== */
INSERT INTO customer (customer_id, name, email, phone, address, active, created_at, updated_at) VALUES
('cus_001', 'Juan Pérez',   'juan.perez@correo.mx',   '5512345678', 'U.H Piedra Blanca, Cuautla, Mor',  1, NOW(), NOW()),
('cus_002', 'María López',  'maria.lopez@correo.mx',  '5523456789', 'Av. Reforma 200, CDMX',            1, NOW(), NOW()),
('cus_003', 'Carlos Díaz',  'carlos.diaz@correo.mx',  '5534567890', 'Calle Sur 45, Guadalajara, Jal',   1, NOW(), NOW()),
('cus_004', 'Ana Torres',   'ana.torres@correo.mx',   '5545678901', 'Montejo 123, Mérida, Yuc',         0, NOW(), NOW()),
('cus_005', 'Laura Gómez',  'laura.gomez@correo.mx',  '5556789012', 'Obrera 12, Monterrey, NL',         1, NOW(), NOW());
/* ===================================================================================================================== */


/* ==================================================== SERVICE ======================================================== */
INSERT INTO service (service_id, name, description, active, created_at, updated_at) VALUES
  ('esencial', 'Póliza Jurídica Digital', 'Protección esencial para tu arrendamiento con cobertura legal básica.', 1, NOW(), NOW()),
  ('premium',  'Investigación Digital',  'Cobertura ampliada con investigación y negociación de contrato.', 1, NOW(), NOW()),
  ('total',    'Protección Total','Maxima protección legal y financiera con cobertura integral.', 1, NOW(), NOW());
/* ===================================================================================================================== */


/* ====================================================== SESSION ======================================================================== */
INSERT INTO session (session_id, customer_id, user_agent, status, started_at, ended_at, created_at, updated_at) VALUES
('ses_001', 'cus_001', 'Chrome/119 Win10',      'active',  NOW() - INTERVAL 2 DAY, NULL,                  NOW() - INTERVAL 2 DAY, NOW()),
('ses_002', 'cus_001', 'Safari/17 iOS',         'ended',   NOW() - INTERVAL 10 DAY, NOW() - INTERVAL 9 DAY, NOW() - INTERVAL 10 DAY, NOW()),
('ses_101', 'cus_002', 'Firefox/120 Ubuntu',    'active',  NOW() - INTERVAL 1 DAY,  NULL,                  NOW() - INTERVAL 1 DAY,  NOW()),
('ses_201', 'cus_003', 'Edge/119 Win11',        'ended',   NOW() - INTERVAL 7 DAY,  NOW() - INTERVAL 6 DAY, NOW() - INTERVAL 7 DAY,  NOW()),
('ses_301', 'cus_004', 'Chrome/119 Win10',      'active',  NOW() - INTERVAL 3 DAY,  NULL,                  NOW() - INTERVAL 3 DAY,  NOW()), 
('ses_401', 'cus_005', 'Safari/17 macOS',       'active',  NOW() - INTERVAL 5 HOUR, NULL,                  NOW() - INTERVAL 5 HOUR, NOW());
/* ====================================================================================================================================== */


/* ==================================================== VERIFICATION ======================================================== */




/* ========================================================================================================================== */


/* ==================================================== PAYMENT ======================================================== */




/* ========================================================================================================================== */


/* ====================================================== SERVICE_PRICE_RANGE ======================================================================== */
-- Esencial: desde $3,500/año para rentas bajas (ej. hasta 10,000/mes)
INSERT INTO service_price_range (service_id, min_monthly_rent, max_monthly_rent, annual_price, currency, note)
VALUES ('esencial', 0.00, 10000.00, 3500.00, 'MXN', 'Precio calculado según renta mensual');

-- Premium: desde $4,950/año para rentas bajas (ej. hasta 10,000/mes)
INSERT INTO service_price_range (service_id, min_monthly_rent, max_monthly_rent, annual_price, currency, note)
VALUES ('premium', 0.00, 10000.00, 4950.00, 'MXN', 'Precio calculado según renta mensual');

-- Total: desde $9,950/año para rentas bajas (ej. hasta 10,000/mes)
INSERT INTO service_price_range (service_id, min_monthly_rent, max_monthly_rent, annual_price, currency, note)
VALUES ('total', 0.00, 10000.00, 9950.00, 'MXN', 'Precio calculado según renta mensual');
/* ================================================================================================================================================== */

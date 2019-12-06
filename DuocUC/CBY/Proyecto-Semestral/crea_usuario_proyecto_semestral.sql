-- USER SQL
CREATE USER PROY_CBY IDENTIFIED BY duoc 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER PROY_CBY QUOTA UNLIMITED ON USERS;

-- ROLES
GRANT "CONNECT" TO PROY_CBY;
GRANT "RESOURCE" TO PROY_CBY;
ALTER USER PROY_CBY DEFAULT ROLE "CONNECT","RESOURCE";

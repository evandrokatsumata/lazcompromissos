CREATE TABLE [compromisso] (
 [oid] INTEGER CONSTRAINT "pk_oidcomproisso" NOT NULL PRIMARY KEY AUTOINCREMENT,
 [descricao] VARCHAR (1000) NOT NULL,
 [data] DATE NOT NULL);
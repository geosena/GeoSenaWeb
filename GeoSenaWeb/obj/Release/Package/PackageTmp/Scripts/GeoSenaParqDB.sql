USE [master]
GO
/****** Object:  Database [GeoSenaDB]    Script Date: 2/11/2016 20:22:55 ******/
CREATE DATABASE [GeoSenaDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GeoSenaDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\GeoSenaDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GeoSenaDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\GeoSenaDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [GeoSenaDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GeoSenaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GeoSenaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GeoSenaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GeoSenaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GeoSenaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GeoSenaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [GeoSenaDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GeoSenaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GeoSenaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GeoSenaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GeoSenaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GeoSenaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GeoSenaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GeoSenaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GeoSenaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GeoSenaDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GeoSenaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GeoSenaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GeoSenaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GeoSenaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GeoSenaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GeoSenaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GeoSenaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GeoSenaDB] SET RECOVERY FULL 
GO
ALTER DATABASE [GeoSenaDB] SET  MULTI_USER 
GO
ALTER DATABASE [GeoSenaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GeoSenaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GeoSenaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GeoSenaDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GeoSenaDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'GeoSenaDB', N'ON'
GO
ALTER DATABASE [GeoSenaDB] SET QUERY_STORE = OFF
GO
USE [GeoSenaDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [GeoSenaDB]
GO
/****** Object:  Table [dbo].[Administrador]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrador](
	[IdAdministrador] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellidos] [varchar](50) NOT NULL,
	[Correo] [varchar](50) NOT NULL,
	[Identificacion] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[IdAdministrador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CentroFormacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentroFormacion](
	[IdCentroFormacion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](150) NOT NULL,
	[Url] [varchar](150) NULL,
 CONSTRAINT [PK_TipoSede] PRIMARY KEY CLUSTERED 
(
	[IdCentroFormacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parqueadero]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parqueadero](
	[IdParqueadero] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Cupo] [float] NOT NULL,
	[IdUbicacion] [int] NOT NULL,
	[IdSede] [int] NOT NULL,
 CONSTRAINT [PK_Parqueadero] PRIMARY KEY CLUSTERED 
(
	[IdParqueadero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sede]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sede](
	[IdSede] [int] IDENTITY(1,1) NOT NULL,
	[IdCentroFormacion] [int] NOT NULL,
	[Descripcion] [varchar](150) NOT NULL,
	[IdUbicacion] [int] NOT NULL,
 CONSTRAINT [PK_Sede] PRIMARY KEY CLUSTERED 
(
	[IdSede] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Telefono]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Telefono](
	[IdTelefono] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoTelefono] [int] NOT NULL,
	[IdUbicacion] [int] NOT NULL,
	[Telefono] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Telefono] PRIMARY KEY CLUSTERED 
(
	[IdTelefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoTelefono]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoTelefono](
	[IdTipoTelefono] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoTelefono] PRIMARY KEY CLUSTERED 
(
	[IdTipoTelefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ubicacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ubicacion](
	[IdUbicacion] [int] IDENTITY(1,1) NOT NULL,
	[Direccion] [varchar](50) NOT NULL,
	[Latitud] [float] NOT NULL,
	[Longuitud] [float] NOT NULL,
	[Horario] [varchar](300) NOT NULL,
 CONSTRAINT [PK_Ubicacion] PRIMARY KEY CLUSTERED 
(
	[IdUbicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Apellidos] [varchar](50) NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[Identificacion] [int] NOT NULL,
	[Nick] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[IdCentroFormacion] [int] NOT NULL,
	[FechaModificacionClave] [date] NOT NULL,
	[Imagen] [nvarchar](max) NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Index [IX_TipoDocumento_Documento]    Script Date: 2/11/2016 20:22:56 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TipoDocumento_Documento] ON [dbo].[Usuario]
(
	[IdUsuario] ASC,
	[Identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Parqueadero]  WITH CHECK ADD  CONSTRAINT [FK_Parqueadero_Sede] FOREIGN KEY([IdSede])
REFERENCES [dbo].[Sede] ([IdSede])
GO
ALTER TABLE [dbo].[Parqueadero] CHECK CONSTRAINT [FK_Parqueadero_Sede]
GO
ALTER TABLE [dbo].[Parqueadero]  WITH CHECK ADD  CONSTRAINT [FK_Parqueadero_Ubicacion] FOREIGN KEY([IdUbicacion])
REFERENCES [dbo].[Ubicacion] ([IdUbicacion])
GO
ALTER TABLE [dbo].[Parqueadero] CHECK CONSTRAINT [FK_Parqueadero_Ubicacion]
GO
ALTER TABLE [dbo].[Sede]  WITH CHECK ADD  CONSTRAINT [FK_Sede_CentroFormacion] FOREIGN KEY([IdCentroFormacion])
REFERENCES [dbo].[CentroFormacion] ([IdCentroFormacion])
GO
ALTER TABLE [dbo].[Sede] CHECK CONSTRAINT [FK_Sede_CentroFormacion]
GO
ALTER TABLE [dbo].[Sede]  WITH CHECK ADD  CONSTRAINT [FK_Sede_Ubicacion] FOREIGN KEY([IdUbicacion])
REFERENCES [dbo].[Ubicacion] ([IdUbicacion])
GO
ALTER TABLE [dbo].[Sede] CHECK CONSTRAINT [FK_Sede_Ubicacion]
GO
ALTER TABLE [dbo].[Telefono]  WITH CHECK ADD  CONSTRAINT [FK_Telefono_TipoTelefono] FOREIGN KEY([IdTipoTelefono])
REFERENCES [dbo].[TipoTelefono] ([IdTipoTelefono])
GO
ALTER TABLE [dbo].[Telefono] CHECK CONSTRAINT [FK_Telefono_TipoTelefono]
GO
ALTER TABLE [dbo].[Telefono]  WITH CHECK ADD  CONSTRAINT [FK_Telefono_Ubicacion] FOREIGN KEY([IdUbicacion])
REFERENCES [dbo].[Ubicacion] ([IdUbicacion])
GO
ALTER TABLE [dbo].[Telefono] CHECK CONSTRAINT [FK_Telefono_Ubicacion]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_CentroFormacion] FOREIGN KEY([IdCentroFormacion])
REFERENCES [dbo].[CentroFormacion] ([IdCentroFormacion])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_CentroFormacion]
GO
/****** Object:  StoredProcedure [dbo].[CambioClave]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CambioClave]
(
	@Password varchar(50),
	@FechaModificacionClave date,
	@IdUsuario int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Usuario] 
SET [Password] = @Password, [FechaModificacionClave] = @FechaModificacionClave 
WHERE [IdUsuario] = @IdUsuario
GO
/****** Object:  StoredProcedure [dbo].[CambioClaveAdmin]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CambioClaveAdmin]
(
	@Password varchar(50),
	@IdAdministrador int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Administrador] 
SET [Password] = @Password 
WHERE [IdAdministrador] = @IdAdministrador
GO
/****** Object:  StoredProcedure [dbo].[DeleteAdministrador]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAdministrador]
(
	@IdAdministrador int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Administrador] 
WHERE [IdAdministrador] = @IdAdministrador
GO
/****** Object:  StoredProcedure [dbo].[DeleteCentro]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCentro]
(
	@IdCentroFormacion int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[CentroFormacion] 
WHERE [IdCentroFormacion] = @IdCentroFormacion
GO
/****** Object:  StoredProcedure [dbo].[DeleteParqueadero]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteParqueadero]
(
	@IdParqueadero int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Parqueadero] 
WHERE [IdParqueadero] = @IdParqueadero
GO
/****** Object:  StoredProcedure [dbo].[DeleteSede]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteSede]
(
	@IdSede int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Sede] 
WHERE [IdSede] = @IdSede
GO
/****** Object:  StoredProcedure [dbo].[DeleteTelefono]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteTelefono]
(
	@IdTelefono int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Telefono] 
WHERE [IdTelefono] = @IdTelefono
GO
/****** Object:  StoredProcedure [dbo].[DeleteUbicacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUbicacion]
(
	@IdUbicacion int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Ubicacion] 
WHERE [IdUbicacion] = @IdUbicacion
GO
/****** Object:  StoredProcedure [dbo].[DeleteUsuario]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUsuario]
(
	@IdUsuario int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [dbo].[Usuario] 
WHERE [IdUsuario] = @IdUsuario
GO
/****** Object:  StoredProcedure [dbo].[ExisteAdministrador]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExisteAdministrador]
(
	@Identificacion varchar(50),
	@Password varchar(50)
)
AS
	SET NOCOUNT ON;
SELECT        (1)
FROM            Administrador
WHERE Identificacion = @Identificacion AND Password = @Password
GO
/****** Object:  StoredProcedure [dbo].[ExisteCentro]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExisteCentro]
(
	@IdCentroFormacion int
)
AS
	SET NOCOUNT ON;
SELECT        (1)
FROM            CentroFormacion
WHERE IdCentroFormacion = @IdCentroFormacion
GO
/****** Object:  StoredProcedure [dbo].[ExisteParqueadero]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExisteParqueadero]
(
	@IdParqueadero int
)
AS
	SET NOCOUNT ON;
SELECT        (1)
FROM            Parqueadero
WHERE IdParqueadero = @IdParqueadero
GO
/****** Object:  StoredProcedure [dbo].[ExisteSede]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExisteSede]
(
	@IdSede int
)
AS
	SET NOCOUNT ON;
SELECT        (1)
FROM            Sede
WHERE IdSede = @IdSede
GO
/****** Object:  StoredProcedure [dbo].[ExisteUsuario]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExisteUsuario]
(
	@Nick varchar(50),
	@Password varchar(50)
)
AS
	SET NOCOUNT ON;
SELECT        (1)
FROM            Usuario
WHERE Nick = @Nick AND Password = @Password
GO
/****** Object:  StoredProcedure [dbo].[ExisteUsuarioByIdentificacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExisteUsuarioByIdentificacion]
(
	@Identificacion int
)
AS
	SET NOCOUNT ON;
SELECT        (1)
FROM            Usuario
WHERE Identificacion = @Identificacion
GO
/****** Object:  StoredProcedure [dbo].[ExsteAdministradorByIdAdministrador]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExsteAdministradorByIdAdministrador]
(
	@IdAdministrador int
)
AS
	SET NOCOUNT ON;
SELECT        (1)
FROM            Administrador
WHERE IdAdministrador = @IdAdministrador
GO
/****** Object:  StoredProcedure [dbo].[GetAdministradorByIdentificacionAndPassword]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAdministradorByIdentificacionAndPassword]
(
	@Identificacion varchar(50),
	@Password varchar(50)
)
AS
	SET NOCOUNT ON;
SELECT IdAdministrador, Nombre, Apellidos, Correo, Identificacion, Password 
FROM dbo.Administrador
WHERE Identificacion = @Identificacion and Password = @Password
GO
/****** Object:  StoredProcedure [dbo].[GetCentroByIdCentroFormacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCentroByIdCentroFormacion]
(
	@IdCentroFormacion int
)
AS
	SET NOCOUNT ON;
SELECT IdCentroFormacion, Descripcion, Url 
FROM dbo.CentroFormacion
WHERE IdCentroFormacion = @IdCentroFormacion
GO
/****** Object:  StoredProcedure [dbo].[GetDataByIdAdministrador]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDataByIdAdministrador]
(
	@IdAdministrador int
)
AS
	SET NOCOUNT ON;
SELECT IdAdministrador, Nombre, Apellidos, Correo, Identificacion, Password 
FROM dbo.Administrador
WHERE IdAdministrador = @IdAdministrador
GO
/****** Object:  StoredProcedure [dbo].[GetUsuarioByIdCentroFormacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUsuarioByIdCentroFormacion]
(
	@IdCentroFormacion int
)
AS
	SET NOCOUNT ON;
SELECT IdUsuario, Apellidos, Nombres, Identificacion, Nick, Password, Correo, IdCentroFormacion, FechaModificacionClave, Imagen 
FROM dbo.Usuario
WHERE  IdCentroFormacion = @IdCentroFormacion
GO
/****** Object:  StoredProcedure [dbo].[GetUsuarioByIdentificacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUsuarioByIdentificacion]
(
	@Identificacion int
)
AS
	SET NOCOUNT ON;
SELECT IdUsuario, Apellidos, Nombres, Identificacion, Nick, Password, Correo, IdCentroFormacion, FechaModificacionClave, Imagen
FROM dbo.Usuario
WHERE Identificacion = @Identificacion
GO
/****** Object:  StoredProcedure [dbo].[GetUsuarioByNickAndPassword]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUsuarioByNickAndPassword]
(
	@Nick varchar(50),
	@Password varchar(50)
)
AS
	SET NOCOUNT ON;
SELECT IdUsuario, Apellidos, Nombres, Identificacion, Nick, Password, Correo, IdCentroFormacion, FechaModificacionClave, Imagen 
FROM dbo.Usuario
WHERE Nick = @Nick AND Password = @Password
GO
/****** Object:  StoredProcedure [dbo].[InicializarDB]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InicializarDB] 
AS

DELETE FROM Sede
DELETE FROM Ubicacion
DELETE FROM Parqueadero
DELETE FROM Telefono
DELETE FROM TipoTelefono

DBCC CHECKIDENT (Sede, RESEED,0)
DBCC CHECKIDENT (Ubicacion, RESEED,0)
DBCC CHECKIDENT (Parqueadero, RESEED,0)
DBCC CHECKIDENT (Telefono, RESEED,0)
DBCC CHECKIDENT (TipoTelefono, RESEED,0)

GO
/****** Object:  StoredProcedure [dbo].[InsertAdministrador]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAdministrador]
(
	@Nombre varchar(50),
	@Apellidos varchar(50),
	@Correo varchar(50),
	@Identificacion varchar(50),
	@Password varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Administrador] 
([Nombre], [Apellidos], [Correo], [Identificacion], [Password]) 
VALUES (@Nombre, @Apellidos, @Correo, @Identificacion, @Password);
	

GO
/****** Object:  StoredProcedure [dbo].[InsertCentro]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCentro]
(
	@Descripcion varchar(150),
	@Url varchar(150)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[CentroFormacion] ([Descripcion], [Url]) 
VALUES (@Descripcion, @Url);
	

GO
/****** Object:  StoredProcedure [dbo].[InsertParqueadero]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertParqueadero]
(
	@Descripcion varchar(50),
	@Cupo float,
	@IdUbicacion int,
	@IdSede int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Parqueadero] 
([Descripcion], [Cupo], [IdUbicacion], [IdSede]) 
VALUES (@Descripcion, @Cupo, @IdUbicacion, @IdSede)
GO
/****** Object:  StoredProcedure [dbo].[InsertSede]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertSede]
(
	@IdCentroFormacion int,
	@Descripcion varchar(150),
	@IdUbicacion int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Sede] 
([IdCentroFormacion], [Descripcion], [IdUbicacion]) 
VALUES (@IdCentroFormacion, @Descripcion, @IdUbicacion);
	

GO
/****** Object:  StoredProcedure [dbo].[InsertTelefono]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTelefono]
(
	@IdTipoTelefono int,
	@IdUbicacion int,
	@Telefono varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Telefono] 
([IdTipoTelefono], [IdUbicacion], [Telefono]) 
VALUES (@IdTipoTelefono, @IdUbicacion, @Telefono)
GO
/****** Object:  StoredProcedure [dbo].[InsertUbicacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUbicacion]
(
	@Direccion varchar(50),
	@Latitud float,
	@Longuitud float,
	@Horario varchar(300)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Ubicacion] ([Direccion], [Latitud], [Longuitud], [Horario]) VALUES (@Direccion, @Latitud, @Longuitud, @Horario);
SELECT IdUbicacion FROM Ubicacion WHERE (IdUbicacion = SCOPE_IDENTITY())

GO
/****** Object:  StoredProcedure [dbo].[InsertUsuario]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUsuario]
(
	@Apellidos varchar(50),
	@Nombres varchar(50),
	@Identificacion int,
	@Nick varchar(50),
	@Password varchar(50),
	@Correo varchar(100),
	@IdCentroFormacion int,
	@FechaModificacionClave date
)
AS
	SET NOCOUNT OFF;
INSERT INTO [dbo].[Usuario] 
([Apellidos], [Nombres], [Identificacion], [Nick], [Password], [Correo], [IdCentroFormacion], [FechaModificacionClave]) 
VALUES (@Apellidos, @Nombres, @Identificacion, @Nick, @Password, @Correo, @IdCentroFormacion, @FechaModificacionClave)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAdministrador]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAdministrador]
(
	@Nombre varchar(50),
	@Apellidos varchar(50),
	@Correo varchar(50),
	@Identificacion varchar(50),
	@IdAdministrador int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Administrador] 
SET [Nombre] = @Nombre, [Apellidos] = @Apellidos, [Correo] = @Correo, [Identificacion] = @Identificacion  
WHERE [IdAdministrador] = @IdAdministrador
GO
/****** Object:  StoredProcedure [dbo].[UpdateCentro]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCentro]
(
	@Descripcion varchar(150),
	@Url varchar(150),
	@IdCentroFormacion int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[CentroFormacion] 
SET 
[Descripcion] = @Descripcion, 
[Url] = @Url 
WHERE [IdCentroFormacion] = @IdCentroFormacion
GO
/****** Object:  StoredProcedure [dbo].[UpdateImagen]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateImagen]
(
	@Imagen nvarchar(MAX),
	@IdUsuario int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Usuario] 
SET [Imagen] = @Imagen 
WHERE [IdUsuario] = @IdUsuario
GO
/****** Object:  StoredProcedure [dbo].[UpdateParqueadero]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateParqueadero]
(
	@Descripcion varchar(50),
	@Cupo float,
	@IdUbicacion int,
	@IdSede int,
	@IdParqueadero int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Parqueadero] 
SET [Descripcion] = @Descripcion, [Cupo] = @Cupo, [IdUbicacion] = @IdUbicacion, [IdSede] = @IdSede 
WHERE [IdParqueadero] = @IdParqueadero
GO
/****** Object:  StoredProcedure [dbo].[UpdateSede]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSede]
(
	@IdCentroFormacion int,
	@Descripcion varchar(150),
	@IdUbicacion int,
	@IdSede int
)
AS
	SET NOCOUNT OFF;
UPDATE       Sede
SET                IdCentroFormacion = @IdCentroFormacion, Descripcion = @Descripcion, IdUbicacion = @IdUbicacion
WHERE        (IdSede = @IdSede)
GO
/****** Object:  StoredProcedure [dbo].[UpdateTelefono]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateTelefono]
(
	@IdTipoTelefono int,
	@IdUbicacion int,
	@Telefono varchar(50),
	@IdTelefono int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Telefono] 
SET [IdTipoTelefono] = @IdTipoTelefono, 
[IdUbicacion] = @IdUbicacion, 
[Telefono] = @Telefono 
WHERE [IdTelefono] = @IdTelefono
GO
/****** Object:  StoredProcedure [dbo].[UpdateUbicacion]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUbicacion]
(
	@Direccion varchar(50),
	@Latitud float,
	@Longuitud float,
	@Horario varchar(300),
	@IdUbicacion int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Ubicacion] 
SET [Direccion] = @Direccion, 
[Latitud] = @Latitud, 
[Longuitud] = @Longuitud, 
[Horario] = @Horario 
WHERE 
[IdUbicacion] = @IdUbicacion
GO
/****** Object:  StoredProcedure [dbo].[UpdateUsuario]    Script Date: 2/11/2016 20:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUsuario]
(
	@Apellidos varchar(50),
	@Nombres varchar(50),
	@Identificacion int,
	@Nick varchar(50),
	@Correo varchar(100),
	@IdCentroFormacion int,
	@FechaModificacionClave date,
	@IdUsuario int
)
AS
	SET NOCOUNT OFF;
UPDATE [dbo].[Usuario] 
SET [Apellidos] = @Apellidos, [Nombres] = @Nombres, [Identificacion] = @Identificacion, [Nick] = @Nick, [Correo] = @Correo, [IdCentroFormacion] = @IdCentroFormacion, [FechaModificacionClave] = @FechaModificacionClave 
WHERE [IdUsuario] = @IdUsuario
GO
USE [master]
GO
ALTER DATABASE [GeoSenaDB] SET  READ_WRITE 
GO

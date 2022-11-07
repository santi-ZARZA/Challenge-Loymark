/****** Object:  Database [loymark-challenge]    Script Date: 7/11/2022 09:10:00 ******/
CREATE DATABASE [loymark-challenge]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'loymark-challenge', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\loymark-challenge.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'loymark-challenge_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\loymark-challenge_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [loymark-challenge] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [loymark-challenge].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [loymark-challenge] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [loymark-challenge] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [loymark-challenge] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [loymark-challenge] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [loymark-challenge] SET ARITHABORT OFF 
GO
ALTER DATABASE [loymark-challenge] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [loymark-challenge] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [loymark-challenge] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [loymark-challenge] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [loymark-challenge] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [loymark-challenge] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [loymark-challenge] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [loymark-challenge] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [loymark-challenge] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [loymark-challenge] SET  DISABLE_BROKER 
GO
ALTER DATABASE [loymark-challenge] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [loymark-challenge] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [loymark-challenge] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [loymark-challenge] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [loymark-challenge] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [loymark-challenge] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [loymark-challenge] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [loymark-challenge] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [loymark-challenge] SET  MULTI_USER 
GO
ALTER DATABASE [loymark-challenge] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [loymark-challenge] SET DB_CHAINING OFF 
GO
ALTER DATABASE [loymark-challenge] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [loymark-challenge] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [loymark-challenge] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [loymark-challenge] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [loymark-challenge] SET QUERY_STORE = OFF
GO
USE [loymark-challenge]
GO
/****** Object:  Table [dbo].[actividad]    Script Date: 7/11/2022 09:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[actividad](
	[idActividad] [bigint] IDENTITY(1,1) NOT NULL,
	[fechaCreacion] [datetime] NOT NULL,
	[idUsuario] [bigint] NOT NULL,
	[actividad] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idActividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 7/11/2022 09:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[idUsuario] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[apellido] [varchar](100) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[telefono] [int] NULL,
	[fechaNacimiento] [datetime] NOT NULL,
	[paisResidente] [varchar](20) NOT NULL,
	[notificacion] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteUsuarioById]    Script Date: 7/11/2022 09:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[DeleteUsuarioById]
(
	@IdUsuario bigint
)
as begin
DELETE FROM [dbo].[usuario]
      WHERE IdUsuario = @IdUsuario

insert into actividad
([fechaCreacion], [idUsuario], [actividad])
values
(getdate(),@IdUsuario,'Se elimino el Usuario')
end


GO
/****** Object:  StoredProcedure [dbo].[GetActividades]    Script Date: 7/11/2022 09:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetActividades]
as begin

SELECT [idActividad]
      ,[fechaCreacion]
	  ,u.idUsuario
      , u.nombre + ' ' + u.apellido as nombreCompleto
      ,[actividad]
  FROM [dbo].[actividad] a
  inner join usuario u on a.idUsuario = u.idUsuario
  order by a.fechaCreacion desc

end
GO
/****** Object:  StoredProcedure [dbo].[GetUsuarios]    Script Date: 7/11/2022 09:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetUsuarios]
(
	@nombre varchar(100) = null,
	@apellido varchar(100) = null,
	@email varchar(50) = null,
	@telefono int = null,
	@fechaNacimiento datetime = null,
	@paisResidente varchar(20) = null
)as begin
SELECT [idUsuario]
      ,[nombre]
      ,[apellido]
      ,[email]
      ,[telefono]
      ,[fechaNacimiento]
      ,[paisResidente]
      ,[notificacion]
  FROM [dbo].[usuario]
  where (@nombre is null or nombre like '%'+@nombre+'%')
	AND (@apellido is null or apellido like '%'+@apellido+'%')
	AND (@email is null or email like '%'+@email+'%')
	AND (@telefono is null or telefono = @telefono)	
	AND (@fechaNacimiento is null or fechaNacimiento = @fechaNacimiento)
	AND (@paisResidente is null or paisResidente like '%'+@paisResidente+'%')

end


GO
/****** Object:  StoredProcedure [dbo].[InsertUsuario]    Script Date: 7/11/2022 09:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[InsertUsuario]
(
	@nombre varchar(100),
	@apellido varchar(100),
	@email varchar(50),
	@telefono int,
	@fechaNacimineto datetime,
	@paisResidente varchar(20),
	@notificacion bit
)
as begin

declare @idUsuario bigint;

INSERT INTO [dbo].[usuario]
           ([nombre]
           ,[apellido]
           ,[email]
           ,[telefono]
           ,[fechaNacimiento]
           ,[paisResidente]
           ,[notificacion])
     VALUES
           (@nombre
           ,@apellido
           ,@email
           ,@telefono
           ,@fechaNacimineto
           ,@paisResidente
           ,@notificacion)

	set @idUsuario = scope_identity()

	insert into actividad
	([fechaCreacion], [idUsuario], [actividad])
	values
	(getdate(),@idUsuario,'Se Creo el Usuario')

	return @idUsuario
end


GO
/****** Object:  StoredProcedure [dbo].[UpdateUsuario]    Script Date: 7/11/2022 09:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateUsuario](
	@IdUsuario bigint,
	@nombre varchar(100),
	@apellido varchar(100),
	@email varchar(50),
	@telefono int,
	@fechaNacimineto datetime,
	@paisResidente varchar(20),
	@notificacion bit
	)
as begin
UPDATE [dbo].[usuario]
   SET [nombre] = @nombre
      ,[apellido] = @apellido
      ,[email] = @email
      ,[telefono] = @telefono
      ,[fechaNacimiento] = @fechaNacimineto
      ,[paisResidente] = @paisResidente
      ,[notificacion] = @notificacion
 WHERE idUsuario = @IdUsuario

 	insert into actividad
	([fechaCreacion], [idUsuario], [actividad])
	values
	(getdate(),@IdUsuario,'Se modifico el Usuario')
end


GO

ALTER DATABASE [loymark-challenge] SET  READ_WRITE 
GO

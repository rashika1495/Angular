USE [master]
GO
/****** Object:  Database [WebApp]    Script Date: 12/27/2018 11:31:32 AM ******/
CREATE DATABASE [WebApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebApp', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WebApp.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WebApp_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WebApp_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WebApp] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebApp] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [WebApp] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [WebApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebApp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WebApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebApp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WebApp] SET  MULTI_USER 
GO
ALTER DATABASE [WebApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebApp] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [WebApp]
GO
/****** Object:  StoredProcedure [dbo].[Usp_get_user]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Usp_get_user]
	@PageNumber INT=1,
	@PageSize INT=10,
	@SearchText NVARCHAR(100)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @SearchText=null OR @SearchText=''
	 SELECT Id,AspnetUserId,Email,Password,FirstName,LastName,PhoneNumber FROM [dbo].[User] 
	ORDER by FirstName  OFFSET @PageSize * (@PageNumber - 1) ROWS  FETCH NEXT @PageSize ROWS ONLY;  
	ELSE
    SELECT Id,AspnetUserId,Email,Password,FirstName,LastName,PhoneNumber FROM [dbo].[User] 
	WHERE FirstName LIKE '%'+@SearchText+'%' ORDER by FirstName  OFFSET @PageSize * (@PageNumber - 1) ROWS  FETCH NEXT @PageSize ROWS ONLY;      
END

GO
/****** Object:  StoredProcedure [dbo].[Usp_InsertUser]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Usp_InsertUser]
	@AspnetUserId nvarchar(200),
	@Email nvarchar(150),
	@FirstName nvarchar(150),
	@LastName nvarchar(150),
	@PhoneNumber nvarchar(20),
	@Password nvarchar(50)
AS
BEGIN
	INSERT INTO [dbo].[User]
           ([AspnetUserId]
           ,[Email]
		   ,[Password]
           ,[FirstName]
           ,[LastName]
           ,[PhoneNumber]
		   )
     VALUES
           (@AspnetUserId
		   ,@Email
		   ,@Password
		   ,@FirstName
		   ,@LastName
		   ,@PhoneNumber
		   )

	SELECT * from [dbo].[User] where Email=@Email
END

GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 12/27/2018 11:31:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AspnetUserId] [nvarchar](200) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](150) NOT NULL,
	[LastName] [nvarchar](150) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'0c89da63-864c-4250-afab-61ebecca65a0', N'sdf00709890770@gmail.com', N'SDF00709890770@GMAIL.COM', N'sdf00709890770@gmail.com', N'SDF00709890770@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEO2Jnqs+z8QOKtY6MW7AeX1nYRLatHOnkoZaU+PF5UZ6zMexaSsxLoF9vL6/KvY21A==', N'NWXIGASHOKOK7A4RDUOY5W7KO7IUKTPC', N'5a873545-8fe3-410d-b87d-3f374acf3382', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'0e01666c-248e-4c31-99e1-87c140b80c32', N'sdf0070987@gmail.com', N'SDF0070987@GMAIL.COM', N'sdf0070987@gmail.com', N'SDF0070987@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEE+ZYR0dZnN1VkvXgHqfBi3UOhvggtWrx824mkVykbisSyR0ItjQRTSXKVpqFX1dVg==', N'E6QXMKVZWJBHEZ3DKJUWPCNFPSMRBPU6', N'dc608bc3-2ef3-43a6-9fa9-a5043e04f822', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'1d93d705-c4bc-40de-90ea-b0dc28bc6070', N'testuser@test.com', N'TESTUSER@TEST.COM', N'testuser@test.com', N'TESTUSER@TEST.COM', 0, N'AQAAAAEAACcQAAAAEDlPp6i+2ecutFEbvyqYyOCuTUCeLuPyU8ruTqKI5w2NSUPjaAekPTdwZlx23SzOCw==', N'NBHRGBYZOR32UQLQLNJCK7W4KAWZTJIH', N'5368863e-ca90-4a7c-a250-8ed5a8ee85e2', N'123456789', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'2780c5f2-22a6-4936-9897-905c7f35c0cc', N'sdf007098907700@gmail.com', N'SDF007098907700@GMAIL.COM', N'sdf007098907700@gmail.com', N'SDF007098907700@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEOOpOr6DvtEdqk1dJ4PJ3lnQKzMWxfkk0xfgbQ7d6IhiAPCM9EcIPERWXMr+eDwbUw==', N'IDFDOXBO4FBZZPFJLP3A6XGZ4UW5SQIR', N'6dce17ac-56f8-4e64-9c3e-c52afc8a31de', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'35179880-8fa7-499a-8def-1bb0341ee7d6', N'sdf007098907@gmail.com', N'SDF007098907@GMAIL.COM', N'sdf007098907@gmail.com', N'SDF007098907@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEAin0RDEeIaDy2xWC7nRdfJGEXEPK23Xq598CTFlDl4AmBFhZX2011Kun1g93quwiQ==', N'7J5QATUQOHQHNDLPXOAWR4YRPJUUVMY7', N'a8c59ec1-deec-4457-816a-67d863b767b8', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'488cdffd-f1f8-4b08-badb-d2e23847c7c3', N'sdf0070989077@gmail.com', N'SDF0070989077@GMAIL.COM', N'sdf0070989077@gmail.com', N'SDF0070989077@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEA0CMEhZbloP1ecqOAvJ3khjXrGrTnP2u4pB/BlvbuoeRtwIMQZdfjlXjpIBGSVstg==', N'446SCMRYD75P2RZFAZPENFBZMRSF5BJP', N'be016ca1-25bc-402b-93ab-415007ca53a8', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'4a4f5127-5428-4e9e-a4bf-b104739cd268', N'sdf0078@gmail.com', N'SDF0078@GMAIL.COM', N'sdf0078@gmail.com', N'SDF0078@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEFyhcp7lj+L8LI4SLS9ULTddFkWw9n0c2brs0GirqSS7W3X3SxAeX9MId9/Tbeuwpg==', N'4A6ECIDPBUAIJOJJ4TPYQ4KKVH5BKDBZ', N'79718d5c-397f-4c53-8a16-07e41fa183ec', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5749c57b-fa72-4638-bc6e-f6a9b76c9785', N'sdf007098@gmail.com', N'SDF007098@GMAIL.COM', N'sdf007098@gmail.com', N'SDF007098@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEB8+XUl2LWD1+/I2NgZHerL+U/d0dhBYO6lpoaFw5dku5lGEYJdm+ni0/NVPBLELtg==', N'ABREQO7IVHVAA5MLBPWKGYP2UX5YYUVP', N'f17afab7-9a4f-4d89-afbc-3f15ad20e2aa', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'724dec53-833d-4398-9357-1b2618a34189', N'sdf0070989077800@gmail.com', N'SDF0070989077800@GMAIL.COM', N'sdf0070989077800@gmail.com', N'SDF0070989077800@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAECHmzss9LQWTHAuhQ9/52pj7iiB/28E75I1QVoRFXhjXEX5P5O8+GlOMg0eBdXwz7g==', N'3JGQFUGCKA6R32FMDW4NASY4OM6GJWZF', N'4a3e95ad-7611-431c-bbe3-7716071041b3', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'774d553c-6e65-4970-b3a6-b9cb8198f883', N'sdf00708@gmail.com', N'SDF00708@GMAIL.COM', N'sdf00708@gmail.com', N'SDF00708@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEDzCrOcrk8Wan6NYY1vD9vQyw7CEyzCasH5sR1EcCwdyaPsebwVWCjxdclQs5TE91w==', N'I77N5KTLTISLMWFOGTUHIY7VOYUT3G3O', N'6dce869f-92c6-4f4a-abd3-cc530b23adc0', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7823d18b-b46f-4590-a5a9-c065a7577181', N'sdf00@gmail.com', N'SDF00@GMAIL.COM', N'sdf00@gmail.com', N'SDF00@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAENqo7GE6DXlOUoveCCanDtamYrF1vnkS1B8IHBBrj7QyFRk13YQe0MUUcuRt3oAc4Q==', N'QDEVVPT3MIM3FKSDKIJIVVDYZIANEBGQ', N'3599dab5-cf4e-41f4-ae80-2497c30ccf10', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'7964440a-d416-426d-9309-740735a5802b', N'sdf134@gmail.com', N'SDF134@GMAIL.COM', N'sdf134@gmail.com', N'SDF134@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEDZOYF5gJBF+QOSuN2XXwskkS2KEUhuj05KVLwO4iJ3IDFziZAOFLU6VU4XYPkPKIw==', N'M6B2RKUDTX7OIAH6FSG7YP4PVZSWBQIT', N'f0b3b8f7-82b9-473e-9bf1-682af3af4845', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'907389d2-89c6-427a-8d5f-13057323900c', N'sdf00709897@gmail.com', N'SDF00709897@GMAIL.COM', N'sdf00709897@gmail.com', N'SDF00709897@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEKu6gqDcx6nKbD1Np8impAGDtGRHCkqpA81h+/M/NM7nD2Wpi1Xmb/LeuApz94BPwA==', N'74ZDRG2NZ5QO7Y4DED6XO3XW6LQSMZWW', N'a4e15d4f-ab4f-4523-9180-a2ac484dbd24', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'a43535cb-c78c-45e0-ac4c-c700dbe03394', N'sdf007@gmail.com', N'SDF007@GMAIL.COM', N'sdf007@gmail.com', N'SDF007@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEJYVb+9UOvi109sEcxhADgnJPTWg3TcxJV7jCOHFoOsjcR+cit/jekgUFDA2KwCSNQ==', N'S7CEXBBY7QSN4BKMUOFKWFFI2WHMZZSE', N'8d33dc29-d069-4faa-b079-fcc33450698b', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'a9967095-813a-4bb8-b74e-8cdb1d5b4675', N'sdf@gmail.com', N'SDF@GMAIL.COM', N'sdf@gmail.com', N'SDF@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEKyprZV/rebHkfDXIIwYu8Xlx02qeJT1vWLZ8Zrhmg8UxJ1PYizNsDZUpBeS55PatA==', N'CDS23B6IBBKDHEF4DTEF3CTUYSDAB7RB', N'7b91866e-4c50-4d85-b474-a48235cbbafa', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ae09ae37-5a35-4257-a097-b0229345b907', N'sdf13@gmail.com', N'SDF13@GMAIL.COM', N'sdf13@gmail.com', N'SDF13@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEEM0KuRBoQUqhdUXljvFzsevOb5S0dxfzsgwMH+KBLRUvVlzqexKUqKwe4DMyDYyVQ==', N'LEXNCUULSCRUKPOSXCOE4Q64R2R6IF2L', N'3d04b2ca-76f5-425a-bed9-84c87fac9425', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'b04780a2-2e5b-4ab2-88b1-b9970a5eee27', N'admin@test.com', N'ADMIN@TEST.COM', N'admin@test.com', N'ADMIN@TEST.COM', 0, N'AQAAAAEAACcQAAAAEBGJo6oQdZ26uN/mJSwgDVqkY62iI65tCW68NHOQauNWFcjBOCra2rOo88b35ZJHNg==', N'25BAUWTDFJOVZ77NJL5KCKYKFJ2AQFBJ', N'9203f89a-ec89-467d-8f7c-c69b95db0e4f', N'123456789', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'ce365470-fd12-4173-8fa6-d8a2f25038d1', N'sdf1347@gmail.com', N'SDF1347@GMAIL.COM', N'sdf1347@gmail.com', N'SDF1347@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEJZJxvixdzV8LdGgAiC5x6/2FpkK9pEpdoQeO/csI3Lm2ezq0/HKRxm8+mEnm8sfng==', N'5TOTU6DHW4FRI7M3JXBSHGZDRDJQISVJ', N'18b6f42a-193e-40d6-8ec1-41a78f6412e4', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'e0188415-65e6-444f-9d6e-d73e7fca0f2e', N'sdf1@gmail.com', N'SDF1@GMAIL.COM', N'sdf1@gmail.com', N'SDF1@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEIyHQU3O+lrdFFVenShsL8vXPinvS6eIoo8ca8H3AzpUc4gGv02NIM9rxN4+CFQb0Q==', N'TECP3Q4CUDHXE4NR36QGTVU6AV2FX2GM', N'e76e3429-61bd-45fc-8997-d5a22d174f21', N'1233', 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'fc276725-7a6f-455e-9735-4712a8e5b713', N'sdf00709890770800@gmail.com', N'SDF00709890770800@GMAIL.COM', N'sdf00709890770800@gmail.com', N'SDF00709890770800@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEKYG1Sf5s90PhDJLu+rfQB2EzAdZOa6agv4ozkzLn05dlz5CHF9odQrDbUTB/ZrpCQ==', N'SWRVZCL6XZR3ZQY6AVMXY4S47WMZZ5VP', N'1750606f-f0b0-4e3b-8f5b-16514e8445c5', N'1233', 0, 0, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (1, N'b04780a2-2e5b-4ab2-88b1-b9970a5eee27', N'admin@test.com', N'Test@123', N'Admin', N'User', N'123456789')
INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (2, N'1d93d705-c4bc-40de-90ea-b0dc28bc6070', N'testuser@test.com', N'Test@123', N'test', N'abc', N'123456789')
INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (7, N'5749c57b-fa72-4638-bc6e-f6a9b76c9785', N'sdf007098@gmail.com', N'Asd@12345', N'Asd', N'SSS', N'1233')
INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (8, N'0e01666c-248e-4c31-99e1-87c140b80c32', N'sdf0070987@gmail.com', N'Asd@12345', N'Asd', N'SSS', N'1233')
INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (9, N'488cdffd-f1f8-4b08-badb-d2e23847c7c3', N'sdf0070989077@gmail.com', N'Asd@12345', N'Asd', N'SSS', N'1233')
INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (10, N'0c89da63-864c-4250-afab-61ebecca65a0', N'sdf00709890770@gmail.com', N'Asd@12345', N'Asd', N'SSS', N'1233')
INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (11, N'2780c5f2-22a6-4936-9897-905c7f35c0cc', N'sdf007098907700@gmail.com', N'Asd@12345', N'Asd', N'SSS', N'1233')
INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (12, N'724dec53-833d-4398-9357-1b2618a34189', N'sdf0070989077800@gmail.com', N'Asd@12345', N'Asd', N'SSS', N'1233')
INSERT [dbo].[User] ([Id], [AspnetUserId], [Email], [Password], [FirstName], [LastName], [PhoneNumber]) VALUES (13, N'fc276725-7a6f-455e-9735-4712a8e5b713', N'sdf00709890770800@gmail.com', N'Asd@12345', N'Asd', N'SSS', N'1233')
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
USE [master]
GO
ALTER DATABASE [WebApp] SET  READ_WRITE 
GO

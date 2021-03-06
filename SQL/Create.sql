USE [master]
GO
/****** Object:  Database [RMI]    Script Date: 05/08/2016 10:28:32 ******/
CREATE DATABASE [RMI] ON  PRIMARY 
( NAME = N'RMI_Data', FILENAME = N'E:\data\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\RMI_Data.mdf' , SIZE = 14976KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'RMI_Log', FILENAME = N'E:\data\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\RMI_Log.ldf' , SIZE = 23552KB , MAXSIZE = 2048GB , FILEGROWTH = 1024KB )
 COLLATE Chinese_PRC_CI_AS
GO
ALTER DATABASE [RMI] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RMI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RMI] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [RMI] SET ANSI_NULLS OFF
GO
ALTER DATABASE [RMI] SET ANSI_PADDING OFF
GO
ALTER DATABASE [RMI] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [RMI] SET ARITHABORT OFF
GO
ALTER DATABASE [RMI] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [RMI] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [RMI] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [RMI] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [RMI] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [RMI] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [RMI] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [RMI] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [RMI] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [RMI] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [RMI] SET  DISABLE_BROKER
GO
ALTER DATABASE [RMI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [RMI] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [RMI] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [RMI] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [RMI] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [RMI] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [RMI] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [RMI] SET  READ_WRITE
GO
ALTER DATABASE [RMI] SET RECOVERY FULL
GO
ALTER DATABASE [RMI] SET  MULTI_USER
GO
ALTER DATABASE [RMI] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [RMI] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'RMI', N'ON'
GO
USE [RMI]
GO
/****** Object:  Table [dbo].[RMI_TABLE_CONFIG]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_TABLE_CONFIG](
	[MaterialID] [uniqueidentifier] NOT NULL,
	[JavaScriptConfig] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[ID] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_TABLE_CONFIG] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TABLE_CONFIG', @level2type=N'COLUMN',@level2name=N'MaterialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'前端对应配置代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TABLE_CONFIG', @level2type=N'COLUMN',@level2name=N'JavaScriptConfig'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'代理主键' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TABLE_CONFIG', @level2type=N'COLUMN',@level2name=N'ID'
GO
/****** Object:  Table [dbo].[RMI_SUPPLIER]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_SUPPLIER](
	[SupplierCode] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SupplierName] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[Description] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[LastModifiedUser] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LastModifiedTime] [datetime] NULL,
	[SupplierID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RMI_SUPPLIER] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'SupplierCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'SupplierName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'LastModifiedUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_SUPPLIER', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
/****** Object:  Table [dbo].[RMI_STEP]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_STEP](
	[StepID] [uniqueidentifier] NOT NULL,
	[StepName] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CreateTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
	[UserID] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[note] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_STEP] PRIMARY KEY CLUSTERED 
(
	[StepID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'步骤ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'StepID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'步骤名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'StepName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_STEP', @level2type=N'COLUMN',@level2name=N'note'
GO
/****** Object:  Table [dbo].[RMI_QUESTION]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_QUESTION](
	[questionName] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[questionID] [uniqueidentifier] NOT NULL,
	[questionClass] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_QUESTION] PRIMARY KEY CLUSTERED 
(
	[questionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'疵点名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_QUESTION', @level2type=N'COLUMN',@level2name=N'questionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'疵点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_QUESTION', @level2type=N'COLUMN',@level2name=N'questionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'疵点所属种类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_QUESTION', @level2type=N'COLUMN',@level2name=N'questionClass'
GO
/****** Object:  Table [dbo].[RMI_PROCESS_TYPE]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_PROCESS_TYPE](
	[Id] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Class] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Name] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Description] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验表格类型ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_TYPE', @level2type=N'COLUMN',@level2name=N'Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验材料的类型（主料、辅料等）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_TYPE', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验材料名称（表格名称）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_TYPE', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相关说明和描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_TYPE', @level2type=N'COLUMN',@level2name=N'Description'
GO
/****** Object:  Table [dbo].[RMI_PROCESS_STEP]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_PROCESS_STEP](
	[ProcessID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StepID] [uniqueidentifier] NOT NULL,
	[StepSeq] [int] NOT NULL,
 CONSTRAINT [PK_RMI_PROCESS_SETP] PRIMARY KEY CLUSTERED 
(
	[ProcessID] ASC,
	[StepID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'步骤顺序，该值越大，顺序越前' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'StepSeq'
GO
/****** Object:  Table [dbo].[RMI_MATERIAL_TYPE]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_MATERIAL_TYPE](
	[MaterialTypeID] [uniqueidentifier] NOT NULL,
	[MaterialTypeName] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[LastModifiedUser] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_RMI_MATERIAL_TYPE] PRIMARY KEY CLUSTERED 
(
	[MaterialTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料种类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_TYPE', @level2type=N'COLUMN',@level2name=N'MaterialTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料种类名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_TYPE', @level2type=N'COLUMN',@level2name=N'MaterialTypeName'
GO
/****** Object:  Table [dbo].[RMI_MATERIAL_NAME]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_MATERIAL_NAME](
	[MaterialID] [uniqueidentifier] NOT NULL,
	[MaterialName] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[LastModifiedUser] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LastModifiedTime] [datetime] NULL,
	[MaterialTypeID] [uniqueidentifier] NULL,
	[WorkTime] [float] NULL,
 CONSTRAINT [PK_RMI_MATERIAL_NAME] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料名称ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_NAME', @level2type=N'COLUMN',@level2name=N'MaterialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_NAME', @level2type=N'COLUMN',@level2name=N'MaterialName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验工时' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_MATERIAL_NAME', @level2type=N'COLUMN',@level2name=N'WorkTime'
GO
/****** Object:  Table [dbo].[RMI_JOB_PERMISSION]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_JOB_PERMISSION](
	[JobID] [uniqueidentifier] NULL,
	[Permission] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工身份类型ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_JOB_PERMISSION', @level2type=N'COLUMN',@level2name=N'JobID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限的JSON形式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_JOB_PERMISSION', @level2type=N'COLUMN',@level2name=N'Permission'
GO
/****** Object:  Table [dbo].[RMI_JOB]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_JOB](
	[JobID] [uniqueidentifier] NOT NULL,
	[Job] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Classification] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_JOB] PRIMARY KEY CLUSTERED 
(
	[JobID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_FLOW_PROCESS]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_FLOW_PROCESS](
	[FlowID] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
 CONSTRAINT [PK_RMI_FLOW_PROCESS] PRIMARY KEY CLUSTERED 
(
	[FlowID] ASC,
	[ProcessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流程ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_FLOW_PROCESS', @level2type=N'COLUMN',@level2name=N'FlowID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理表单类型的ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_FLOW_PROCESS', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
/****** Object:  Table [dbo].[RMI_FEEDBACK]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_FEEDBACK](
	[Id] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Content] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[Subject] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SubmitTime] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SubmitUserId] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SubmitUserName] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SubmitIP] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F10_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F10_DATA](
	[TiaoJianShenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PingPai] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GongYiQueRenRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TieHeQiTa] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WenTiDian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CanShuXiaMoWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MoYaTiaoJianBeiZhu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CanShuShenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YongTu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MoYaCanShuBeiZhu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GongYiYuan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GongYiQueRen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JiShuCanShuXiaMoWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiYaHouQueRenRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JiShuCanShuBeiZhu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiYaHouQueRen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CanShuShiJian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiYangRenRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TiaoJianShangMoWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ZhuLiao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SongJianRenRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiYangRen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CanShuShangMoWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SongJianRen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiGouBuMenQueRen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TiaoJianShiJian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TieHeYaLi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TiaoJianXiaMoWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiYongMuJu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YongTuBeiZhu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TieHeWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiGouBuMenShenHe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiLiaoChengFen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JiShuCanShuShangMoWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JiShuCanShuShiJian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GongYiYuanRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiGouBuMenQueRenRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TieHeJiaoShui] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiGouBuMenShenHeRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JiShuCanShuShenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GangHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JuanHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TieHeSuDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JieLun] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F09_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F09_DATA](
	[BeiZhu] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[HuaXingBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JieLunBeiZhu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KaiDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[AnLunShiYan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HouDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShaXiang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShouGan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ZhengFanMian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BiaoZhunSeKa] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JieLun] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasBiaoZhunSeKa] [bit] NULL,
	[XiangMuFlag] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[CiDian] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[HuaXingShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ChanPinZhongLei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LeiBie] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HouDuShiCe] [int] NULL,
	[ShuLiangPiBiao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiangPiBiao1] [int] NULL,
	[ShuLiang] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[HouDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KeZhongBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiLiaoMingCheng] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KaiDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KaiDuShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeShiCe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeShiCe3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeShiCe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiLiaoCiDianZhuYaoWenTi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDuDanWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDuShiCe] [int] NULL,
	[JianYanShu] [int] NULL,
	[ShuLiangShiCe1] [int] NULL,
	[KeZhongBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiangShiCe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GuiGeOrKuanDuDanWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GongYingShang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GuiGeOrKuanDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DengJiPanDing] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuaXingBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GangHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuiXi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiLiaoFengYang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiWeiBeiZhu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JuanHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KeZhongShiCe] [int] NULL,
	[hasCaiLiaoFengYang] [bit] NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiHuaGaoBiaoZhun] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiHuaGaoShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiHuaKuanBiaoZhun] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiHuaKuanShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TiaoShuOrJieTou] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JianBianSeCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JiDianOrJiFen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DiShui] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK__RMI_F09___3214EC0722751F6C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F08_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F08_DATA](
	[BeiZhu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BiaoZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TongHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JieGuo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ZaZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YiWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiBaoZhuang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YanSe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiCeShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BiaoZhiShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GongHuoShang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PanDing] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SongHuoDanHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F07_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F07_DATA](
	[SaoMiaoJieGuo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiKong] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GuiGeBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MiDuShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiMoYa] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MiDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JieGuo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SeZe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GuiGeBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShouGan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JuanHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiaCi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MiDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GuiGeShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DaoLiaoShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GongHuoShang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ChouYanShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PinMingHuoHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_F07_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F06_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F06_DATA](
	[RenZaoXianWeiCiShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasMianMaZhiWu] [bit] NULL,
	[JingXiZhiWuWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuaiSuXiZhuanShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YanSe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasYangMaoOrShouXi] [bit] NULL,
	[YanSe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[RenZaoXianWeiHongGan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiYaoQiu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MianMaZhiWuHongGan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YangMaoOrShouXiZhuanShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasJingXiZhiWu] [bit] NULL,
	[KuanHao3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MianMaZhiWuWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MianMaZhiWuZhuanShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[RenZaoXianWeiWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JingXiZhiWuHongGan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YanSe3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenMiaoShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanHao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenMuDi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YangMaoOrShouXiWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[RenZaoXianWeiZhuanShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasRenZaoXianWei] [bit] NULL,
	[JieGuo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JingXiZhiWuCiShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanHao1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YangMaoOrShouXiHongGan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuiXiHouShiYangMiaoShu3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuiXiHouShiYangMiaoShu2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuaiSuXiHongGan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YangMaoOrShouXiCiShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasKuaiSuXi] [bit] NULL,
	[KuaiSuXiCiShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JingXiZhiWuZhuanShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShenQingBuMenOrRen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiang2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiang3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MianMaZhiWuCiShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiang1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuiXiHouShiYangMiaoShu1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShenQingRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuaiSuXiWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiJi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_F06_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F05_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F05_DATA](
	[YanSe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BaoKou2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BaoKou3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BaoKou4] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MoBeiBeiXing] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BaoKou1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiCiShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasQiZhouQiMao] [bit] NULL,
	[hasBaoKou] [bit] NULL,
	[QiTaYaoQiu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasTuoJiaoQiPao] [bit] NULL,
	[MoYaTiaoJianShiJian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TuoJiaoQiPao4] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShenQingBuMen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TieHeTiaoJianShiJian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TuoJiaoQiPao1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TuoJiaoQiPao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TuoJiaoQiPao3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TieHeTiaoJianWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuiWen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShenQingRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HongGan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiJi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MoYaTiaoJianWenDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiZhouQiMao4] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiZhouQiMao1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ZhuanSu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiZhouQiMao3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiZhouQiMao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SerialNo] [uniqueidentifier] NULL,
 CONSTRAINT [PK_RMI_F05_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F04_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F04_DATA](
	[ZhuangKuangMiaoShu1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ZhuangKuangMiaoShu2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ZhuangKuangMiaoShu3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CiShu1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CiShu2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CiShu3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YanSe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YanSe3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YanSe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JuLi3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JuLi2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JuLi1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanHao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanHao1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanHao3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenMiaoShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenMuDi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JieGuo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShenQingBuMenOrRen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiang2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiang3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiang1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShenQingRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_F04_DATA] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F03_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F03_DATA](
	[SiLieQiangDuZuiDaSiLieLiZhiBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiLieQiangDuZuiDaSiLieLiZhiBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaiYangQingKuang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TanXingShenChangLvJingXiang1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TanXingShenChangLvJingXiang2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PH1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiHanZiSeLaoDuBianSe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiHouNiuDuBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiHouNiuDuBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasBoLiQiangLi] [bit] NULL,
	[TanXingShenChangLv] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JianCeXingZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KangHuangBianBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KangHuangBianBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BoLiQiangLi2JieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasSiPoQiangLi] [bit] NULL,
	[YuYangJiLu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiShuiXiSeLaoDuZhanSe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiShuiXiSeLaoDuZhanSe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YaXianYingDuBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YaXianYingDuBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TanXingShenChangLvWeiXiangBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiLieQiangDuZuiDaSiLieLiZhi1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiLieQiangDuSiLieQiangDuBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShenQingBuMen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasDuanLieShenChangLv] [bit] NULL,
	[SiLieQiangDuSiLieQiangDuBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiReSeLaoDuBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiPoQiangLiJingXiangBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiPoQiangLiJingXiangBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiReSeLaoDuBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieQiangLiJianCeJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieQiangLiJianCeJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianGongYingShang2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianGongYingShang1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BoLiQiangLi2JieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiZaoXiBianSeBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiPoQiangLiWeiXiangJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DingPoQiangLiBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MiDuJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiPoQiangLiWeiXiangJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiShuiXiSeLaoDuBianSeBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiShuiXiSeLaoDuBianSeBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasDingPoQiangLi] [bit] NULL,
	[ShiMo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiMo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuiTanLvBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuiTanLvBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TanXingShenChangLvJingXiangBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiShuiXiSeLaoDuBianSe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CanKaoBiaoZhun] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TanXingShenChangLvWeiXiang1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PingDing] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasPH] [bit] NULL,
	[NaiShuiXiSeLaoDuBianSe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YangPinMingChen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TanXingShenChangLvWeiXiang2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenQiangDuLaShenQiangDuBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenQiangDuLaShenQiangDuBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiSuoShuiLvWeiXiang1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiZaoXiBianSeBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianPiCiGangHao1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiMoBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShiMoBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianPiCiGangHao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BoLiQiangLi1JieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasSiLieQiangDu] [bit] NULL,
	[SongJianRen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PHBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PHBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiHanZiSeLaoDuBianSeBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiSuoShuiLvWeiXiang2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiHanZiSeLaoDuBianSeBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ZhengChangOrJiaJi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiPoQiangLiWeiXiangBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiPoQiangLiWeiXiangBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiSuoShuiLvJingXiangBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiSuoShuiLvJingXiangBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiLieQiangDuZuiDaSiLieLiZhi2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiHouNiuDu1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BoLiQiangLi1JieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasYaXianYingDu] [bit] NULL,
	[hasMiDu] [bit] NULL,
	[WaiJianCaiLiaoMingChen2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[FenHuangBian1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[FenHuangBian2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MiDuJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieShenChangLvJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieShenChangLvJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GanMo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasDuanLieQiangLi] [bit] NULL,
	[NaiHanZiSeLaoDuZhanSeBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiHanZiSeLaoDuZhanSeBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiReSeLaoDu1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiReSeLaoDu2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieBiaoJuBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieBiaoJuBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenQiangDuZuiDaLiZhiBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieBiaoJuJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieBiaoJuJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenQiangDuZuiDaLiZhiBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BoLiQiangLi2BiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BoLiQiangLi2BiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasNaiShuiXiSeLaoDu] [bit] NULL,
	[hasXiDiSuoShuiLv] [bit] NULL,
	[HuiTanGaoDuBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiShuiXiSeLaoDuZhanSeBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasNaiZaoXiSeLaoDu] [bit] NULL,
	[hasXiHouNiuDu] [bit] NULL,
	[JiaQuan1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiSuoShuiLvJingXiang2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JiaQuan2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiHanZiSeLaoDuZhanSe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiHanZiSeLaoDuZhanSe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuiTanGaoDuBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiZaoXiSeLaoDuZhanSe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiZaoXiSeLaoDuZhanSe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TanXingShenChangLvJingXiangBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasFenHuangBian] [bit] NULL,
	[XiHouNiuDu2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DingPoQiangLiJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DingPoQiangLiJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiLieQiangDuSiLieQiangDu1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiPoQiangLiJingXiangJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiPoQiangLiJingXiangJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SiLieQiangDuSiLieQiangDu2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YaXianYingDuJianCeJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GanMoBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GanMoBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YaXianYingDuJianCeJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WeiWaiXiangMu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiShuiXiSeLaoDuZhanSeBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MiDuBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[MiDuBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasJiaQuan] [bit] NULL,
	[hasTanXingShenChangLv] [bit] NULL,
	[TanXingShenChangLvWeiXiangBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieShenChangLvBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieShenChangLvBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasNaiMoCaSeLaoDu] [bit] NULL,
	[CaiLiaoXingZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GanMo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiSuoShuiLvJingXiang1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaoZuoGongYi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuiTanLvJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuiTanLvJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianCaiLiaoMingChen1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasHuiTanXing] [bit] NULL,
	[HuiTanGaoDuJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuiTanGaoDuJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiSuoShuiLvWeiXiangBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiDiSuoShuiLvWeiXiangBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasLaShenQiangDu] [bit] NULL,
	[NaiZaoXiBianSe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiZaoXiBianSe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DingPoQiangLiBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BuHeGeChuLi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenQiangDuZuiDaLiZhi1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenQiangDuZuiDaLiZhi2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieQiangLiBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuanLieQiangLiBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiHanZiSeLaoDuBianSe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianHuoHao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasKangHuangBian] [bit] NULL,
	[FenHuangBianBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[PiCiAndGangHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[FenHuangBianBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KangHuangBianJieGuo2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KangHuangBianJieGuo1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasNaiReSeLaoDu] [bit] NULL,
	[JiaQuanBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JiaQuanBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiZaoXiSeLaoDuZhanSeBiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[NaiZaoXiSeLaoDuZhanSeBiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenQiangDuLaShenQiangDu2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LaShenQiangDuLaShenQiangDu1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BoLiQiangLi1BiaoZhun1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BoLiQiangLi1BiaoZhun2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianSeHao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiTaYaoQiu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianHuoHao1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[WaiJianSeHao1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasNaiHanZiSeLaoDu] [bit] NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F02_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F02_DATA](
	[BeiZhu] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[CiDianJiFen] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GangTuoBeiZhu] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[ChangDuShiCe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ChangDuShiCe3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ChangDuShiCe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HouDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShaXiang] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[ShouGan] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ZhengFanMian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[XiangMuFlag] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[BiaoZhunSeKa] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[JieLun] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasBiaoZhunSeKa] [bit] NULL,
	[KuanDuShiCe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuShiCe3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuShiCe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuaXingBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiang] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[AnLunShiYan] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YanZhenJieGuo] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LeiBie] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HouDuShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiangPiBiao2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[YinBiaoWeiZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiangPiBiao1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JieLunBeiZhu] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[KaiDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DengJiPanDing] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiLiaoCiDianZhuYaoWenTi] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[ZiRanHuiSuoLv] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CiDianJiDian] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CaiLiaoFengYang] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KaiDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KaiDuShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuaXingShiCe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeShiCe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeShiCe3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuOrGuiGeShiCe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KuanDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDuDanWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDuShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ChangDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ChangDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KeZhongBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JianYanShu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiWeiBeiZhu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiangShiCe1] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KeZhongBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[QiWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShuLiangShiCe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DuiChenXingOrWanQuDuBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GuiGeOrKuanDuDanWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[check3] [bit] NULL,
	[GuiGeOrKuanDu] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HouDuBiaoZhunPianCha] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuaXingBiaoZhunZhi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GangHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShouRouHuiSuoLv] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[hasCaiLiaoFengYang] [bit] NULL,
	[check2] [bit] NULL,
	[JuanHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KeZhongShiCe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[check1] [bit] NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[SerialNo] [uniqueidentifier] NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[KeZhongDanWei] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuaXingShiCe2] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[HuaXingShiCe3] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RMI_F01_DATA]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_F01_DATA](
	[SerialNo] [uniqueidentifier] NOT NULL,
	[GuiGe] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[BiaoZhiShu] [int] NULL,
	[ShiCeShu] [int] NULL,
	[HeGeShu] [int] NULL,
	[WaiGuan] [bit] NULL,
	[JianYanHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[TouChanShu] [int] NULL,
	[DingDanShu] [int] NULL,
	[QiTa] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[ID] [uniqueidentifier] NOT NULL,
	[InspectorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[isZhuDiaoPai] [bit] NULL,
	[JianYanShu] [float] NULL,
	[SaoMiaoJieGuo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[DingDanHao] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ShengChanRiQi] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[JingZhong] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[KeZhong] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_F01_DATA_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'GuiGe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标识数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'BiaoZhiShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实测数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'ShiCeShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'合格数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'HeGeShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外观' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'WaiGuan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'JianYanHao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'投产数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'TouChanShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'DingDanShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'其他' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'QiTa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'填写该数据的检验员' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'InspectorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是主吊牌的标记，1为主吊牌，0不是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'isZhuDiaoPai'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'JianYanShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扫描结果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'SaoMiaoJieGuo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'DingDanHao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生产日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'ShengChanRiQi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'净重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'JingZhong'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'克重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_F01_DATA', @level2type=N'COLUMN',@level2name=N'KeZhong'
GO
/****** Object:  Table [dbo].[RMI_DEPARTMENT]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_DEPARTMENT](
	[DepartmentID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Department] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Classification] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_DEPARTMENT] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_DEPARTMENT', @level2type=N'COLUMN',@level2name=N'DepartmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_DEPARTMENT', @level2type=N'COLUMN',@level2name=N'Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门类别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_DEPARTMENT', @level2type=N'COLUMN',@level2name=N'Classification'
GO
/****** Object:  Table [dbo].[RMI_ACCOUNT_USER]    Script Date: 05/08/2016 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_ACCOUNT_USER](
	[ID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Name] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Password] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[DepartmentID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[JobID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Permission] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
	[CreateTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_RMI_ACCOUNT_USER] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'DepartmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'JobID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限JSON' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'Permission'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修订时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_ACCOUNT_USER', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
/****** Object:  StoredProcedure [dbo].[sys_Page_v2]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sys_Page_v2]
@PCount int output,    --总页数输出
@RCount int output,    --总记录数输出
@sys_Table nvarchar(100),    --查询表名
@sys_Key varchar(50),        --主键
@sys_Fields nvarchar(500),    --查询字段
@sys_Where nvarchar(3000),    --查询条件
@sys_Order nvarchar(100),    --排序字段
@sys_Begin int,        --开始位置
@sys_PageIndex int,        --当前页数
@sys_PageSize int        --页大小
AS

SET NOCOUNT ON
SET ANSI_WARNINGS ON

IF @sys_PageSize < 0 OR @sys_PageIndex < 0
BEGIN        
RETURN
END

DECLARE @new_where1 NVARCHAR(3000)
DECLARE @new_order1 NVARCHAR(100)
DECLARE @new_order2 NVARCHAR(100)
DECLARE @Sql NVARCHAR(4000)
DECLARE @SqlCount NVARCHAR(4000)

DECLARE @Top int

if(@sys_Begin <=0)
    set @sys_Begin=0
else
    set @sys_Begin=@sys_Begin-1

IF ISNULL(@sys_Where,'') = ''
    SET @new_where1 = ' '
ELSE
    SET @new_where1 = ' WHERE ' + @sys_Where 

IF ISNULL(@sys_Order,'') <> '' 
BEGIN
    SET @new_order1 = ' ORDER BY ' + Replace(@sys_Order,'desc','')
    SET @new_order1 = Replace(@new_order1,'asc','desc')

    SET @new_order2 = ' ORDER BY ' + @sys_Order
END
ELSE
BEGIN
    SET @new_order1 = ' ORDER BY ID DESC'
    SET @new_order2 = ' ORDER BY ID ASC'
END

SET @SqlCount = 'SELECT @RCount=COUNT(1),@PCount=CEILING((COUNT(1)+0.0)/'
            + CAST(@sys_PageSize AS NVARCHAR)+') FROM ' + @sys_Table + @new_where1

EXEC SP_EXECUTESQL @SqlCount,N'@RCount INT OUTPUT,@PCount INT OUTPUT',
               @RCount OUTPUT,@PCount OUTPUT

IF @sys_PageIndex > CEILING((@RCount+0.0)/@sys_PageSize)    --如果输入的当前页数大于实际总页数,则把实际总页数赋值给当前页数
BEGIN
    SET @sys_PageIndex =  CEILING((@RCount+0.0)/@sys_PageSize)
END

set @sql = 'select '+ @sys_fields +' from ' + @sys_Table + ' w1 '
    + ' where '+ @sys_Key +' in ('
        +'select top '+ ltrim(str(@sys_PageSize)) +' ' + @sys_Key + ' from '
        +'('
            +'select top ' + ltrim(STR(@sys_PageSize * @sys_PageIndex + @sys_Begin)) + ' ' + @sys_Key + ' FROM ' 
        + @sys_Table + @new_where1 + @new_order2 
        +') w ' + @new_order1
    +') ' + @new_order2

print(@sql)

Exec(@sql)
GO
/****** Object:  Table [dbo].[auth_user_user_permissions]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_user_permissions](
	[id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user_groups]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user_groups](
	[id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[group_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_user]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_user](
	[id] [int] NOT NULL,
	[username] [nvarchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[first_name] [nvarchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[last_name] [nvarchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[email] [nvarchar](75) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[password] [nvarchar](128) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[is_staff] [bit] NOT NULL,
	[is_active] [bit] NOT NULL,
	[is_superuser] [bit] NOT NULL,
	[last_login] [datetime] NOT NULL,
	[date_joined] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_permission]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_permission](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[content_type_id] [int] NOT NULL,
	[codename] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_group_permissions]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group_permissions](
	[id] [int] NOT NULL,
	[group_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth_group]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth_group](
	[id] [int] NOT NULL,
	[name] [nvarchar](80) COLLATE Chinese_PRC_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_site]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_site](
	[id] [int] NOT NULL,
	[domain] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[name] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_session]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_session](
	[session_key] [nvarchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[session_data] [nvarchar](max) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[expire_date] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[django_content_type]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[django_content_type](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[app_label] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[model] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RMI_WORK_FLOW]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_WORK_FLOW](
	[FlowID] [uniqueidentifier] NOT NULL,
	[FlowName] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[UserID] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CreateTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_RMI_WORKFLOW] PRIMARY KEY CLUSTERED 
(
	[FlowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'FlowID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流程名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'FlowName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_WORK_FLOW', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
/****** Object:  Table [dbo].[RMI_UNIT]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_UNIT](
	[UnitID] [uniqueidentifier] NOT NULL,
	[UnitName] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LastModifiedUser] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_RMI_UNIT] PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_UNIT', @level2type=N'COLUMN',@level2name=N'UnitID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_UNIT', @level2type=N'COLUMN',@level2name=N'UnitName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_UNIT', @level2type=N'COLUMN',@level2name=N'LastModifiedUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_UNIT', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
/****** Object:  Table [dbo].[RMI_TASK_PROCESS_STEP]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_TASK_PROCESS_STEP](
	[SerialNo] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StepID] [uniqueidentifier] NOT NULL,
	[Finished] [tinyint] NULL,
	[FinishTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
	[note] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_TASK_PROCESS_STEP] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC,
	[ProcessID] ASC,
	[StepID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'SerialNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表单步骤ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'StepID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表单步骤完成状态，0未完成，1已完成,2表示正在编辑' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'Finished'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'完成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'FinishTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最近一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS_STEP', @level2type=N'COLUMN',@level2name=N'note'
GO
/****** Object:  UserDefinedFunction [dbo].[taskJudgement]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[taskJudgement](@serialNo uniqueidentifier)
-------0：不合格 1：合格 2：不做判定
RETURNS INT
AS
BEGIN
DECLARE @judgeResult INT, @F09Res varchar(50), @F10Res varchar(50), @F03Res varchar(50);
SELECT @F09Res = JieLun FROM RMI_F09_DATA WHERE SerialNo = @serialNo;
SELECT @F10Res = JieLun FROM RMI_F10_DATA WHERE SerialNo = @serialNo;
SELECT @F03Res = PingDing FROM RMI_F03_DATA WHERE SerialNo = @serialNo;
IF ( @F09Res = 'BuHeGe' ) OR ( @F10Res = 'BuHeGe' ) OR ( @F03Res = 'BuHeGe' )
BEGIN
	SET @judgeResult = 0;
END
ELSE
BEGIN
	IF ( @F09Res = 'HeGe' ) OR ( @F10Res = 'HeGe' ) OR ( @F03Res = 'HeGe' )
	BEGIN
		SET @judgeResult = 1;
	END
	ELSE
	BEGIN
		SET @judgeResult = 2;
	END
END
RETURN @judgeResult;
END
GO
/****** Object:  Table [dbo].[RMI_TASK_PROCESS]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_TASK_PROCESS](
	[Serialno] [uniqueidentifier] NOT NULL,
	[ProcessID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[LastModifiedTime] [datetime] NULL,
	[LastModifiedUser] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[AssessTime] [datetime] NULL,
	[Assessor] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_TASK_PROCESS] PRIMARY KEY CLUSTERED 
(
	[Serialno] ASC,
	[ProcessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS', @level2type=N'COLUMN',@level2name=N'Serialno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表单类型ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK_PROCESS', @level2type=N'COLUMN',@level2name=N'ProcessID'
GO
/****** Object:  StoredProcedure [dbo].[createNewProcess]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[createNewProcess]
@processID varchar(50),
 @processName varchar(50), 
 @processClass varchar(50),
  @processDescription varchar(50)
AS
BEGIN
DECLARE @flowID uniqueidentifier;
INSERT INTO RMI_PROCESS_TYPE(ID, NAME, CLASS, DESCRIPTION) VALUES( @processID, @processName, @processClass, @processDescription );
SELECT @flowID = flowID FROM RMI_WORK_FLOW WHERE FlowName = '所有表单';
INSERT INTO RMI_FLOW_PROCESS(FLOWID, PROCESSID) VALUES(@flowID, @processID);
INSERT INTO RMI_PROCESS_STEP(PROCESSID, STEPID, STEPSEQ) VALUES(@processID,'4b652f7e-846e-419c-818e-544e1d00e6a5', 1);
INSERT INTO RMI_PROCESS_STEP(PROCESSID, STEPID, STEPSEQ) VALUES(@processID,'36929b8a-8c15-4068-8c0a-6da2060aa172', 0);
END
GO
/****** Object:  UserDefinedFunction [dbo].[getCurrentFinishedStep]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getCurrentFinishedStep](@serialno uniqueidentifier, @process varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @step uniqueidentifier,@finish int, @stepName varchar(50);
SELECT TOP 1 @step = a.StepID, @finish = Finished FROM RMI_TASK_PROCESS_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
ON a.StepID = b.StepID AND a.ProcessID = b.ProcessID WHERE SerialNo = @serialno AND a.ProcessID = @process
ORDER BY a.Finished DESC , b.StepSeq;
IF @finish != 1
	SELECT TOP 1 @stepName = StepName FROM RMI_STEP a WITH(NOLOCK) JOIN RMI_PROCESS_STEP b WITH(NOLOCK)
	 ON a.StepID = b.StepID
	 WHERE ProcessID = @process
	 ORDER BY StepSeq DESC;
ELSE
	SELECT @stepName = StepName FROM RMI_STEP WITH(NOLOCK) WHERE StepID = @step;
RETURN @stepName;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getConfigByProcessIDAndMaterialID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getConfigByProcessIDAndMaterialID](@MaterialID uniqueidentifier, @ProcessID varchar(50))
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @config varchar(MAX);
SELECT TOP 1 @config = JavaScriptConfig FROM RMI_TABLE_CONFIG WHERE MaterialID = @MaterialID AND ProcessID = @ProcessID;
IF @config IS NULL
	SET @config = '';
RETURN @config;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getUserNameByUserID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getUserNameByUserID](@UserID varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(50);
SELECT TOP 1 @name = name FROM RMI_ACCOUNT_USER WITH(NOLOCK) WHERE ID = @UserID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getUnitNameByID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getUnitNameByID](@UnitID uniqueidentifier)
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(MAX);
IF @UnitID IS NOT NULL
	SELECT TOP 1 @name = UnitName FROM RMI_UNIT WHERE UnitID = @UnitID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getSupplierNameByID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getSupplierNameByID](@SupplierID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = SupplierName FROM RMI_SUPPLIER WHERE SupplierID = @SupplierID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getSupplierCodeByID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getSupplierCodeByID](@SupplierID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @code varchar(MAX);
SELECT TOP 1 @code = SupplierCode FROM RMI_SUPPLIER WHERE SupplierID = @SupplierID;
IF @code IS NULL
	SET @code = '';
RETURN @code;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getMaterialWorkTime]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getMaterialWorkTime](@MaterialID uniqueidentifier)
RETURNS float
AS
BEGIN
DECLARE @WorkTime float;
SELECT TOP 1 @WorkTime = WorkTime FROM RMI_MATERIAL_NAME WHERE MaterialID = @MaterialID;
IF @WorkTime IS NULL
	SET @WorkTime = 0;
RETURN @WorkTime;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getMaterialTypeNameByID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getMaterialTypeNameByID](@materialTypeID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = MaterialTypeName FROM RMI_MATERIAL_TYPE WHERE MaterialTypeID = @materialTypeID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getMaterialTypeIDByMaterialTypeName]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getMaterialTypeIDByMaterialTypeName](@MaterialTypeName varchar(50))
RETURNS uniqueidentifier
AS
BEGIN
DECLARE @MaterialTypeID uniqueidentifier;
SELECT TOP 1 @MaterialTypeID = MaterialTypeID FROM RMI_MATERIAL_TYPE WHERE MaterialTypeName = @MaterialTypeName;
RETURN @MaterialTypeID;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[getMaterialTypeIDByMaterialID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getMaterialTypeIDByMaterialID](@materialID uniqueidentifier)
RETURNS uniqueidentifier
AS
BEGIN
DECLARE @ID uniqueidentifier;
SELECT TOP 1 @ID = MaterialTypeID FROM RMI_MATERIAL_NAME WHERE MaterialID = @materialID;
RETURN @ID;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getMaterialNameByID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getMaterialNameByID](@materialID uniqueidentifier)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @name varchar(MAX);
SELECT TOP 1 @name = MaterialName FROM RMI_MATERIAL_NAME WHERE MaterialID = @materialID;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getLastModifiedUserNameByProcessID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getLastModifiedUserNameByProcessID](@serialno uniqueidentifier, @process varchar(50))
RETURNS varchar(50)
AS
BEGIN
DECLARE @name varchar(50);
SELECT TOP 1 @name = name FROM RMI_TASK_PROCESS a WITH(NOLOCK)JOIN RMI_ACCOUNT_USER b WITH(NOLOCK)
ON a.LastModifiedUser = b.ID WHERE SerialNo = @serialno AND ProcessID = @process;
RETURN @name;
END
GO
/****** Object:  UserDefinedFunction [dbo].[getLastModifiedTimeByProcessID]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getLastModifiedTimeByProcessID](@serialno uniqueidentifier, @process varchar(50))
RETURNS datetime
AS
BEGIN
DECLARE @lastModifiedTime datetime;
SELECT TOP 1 @lastModifiedTime = lastModifiedTime FROM RMI_TASK_PROCESS WITH(NOLOCK)WHERE SerialNo = @serialno AND ProcessID = @process;
RETURN @lastModifiedTime;
END
GO
/****** Object:  Table [dbo].[RMI_TASK]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RMI_TASK](
	[SerialNo] [uniqueidentifier] NOT NULL,
	[CreateTime] [datetime] NULL,
	[LastModifiedTime] [datetime] NULL,
	[ProductNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ColorNo] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[ArriveTime] [datetime] NULL,
	[UserID] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[FlowID] [uniqueidentifier] NOT NULL,
	[State] [int] NOT NULL,
	[SupplierID] [uniqueidentifier] NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[DaoLiaoZongShu] [float] NULL,
	[UnitID] [uniqueidentifier] NULL,
	[DaoLiaoZongShu2] [float] NULL,
	[UnitID2] [uniqueidentifier] NULL,
	[InspectTotalNumber] [float] NULL,
	[Inspectors] [varchar](max) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_RMI_TASK] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'SerialNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后一次修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'LastModifiedTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'ProductNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'色号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'ColorNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'ArriveTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'工作流程ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'FlowID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'任务状态：2：填写中， 1：审批通过，0：提交完成 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'供应商ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'SupplierID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'材料名称ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'MaterialID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'DaoLiaoZongShu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料总数单位ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'UnitID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料总数多余项填写（如卷）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'DaoLiaoZongShu2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'到料总数多余项的单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'UnitID2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验总数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'InspectTotalNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'检验员的工号，以@字符分隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RMI_TASK', @level2type=N'COLUMN',@level2name=N'Inspectors'
GO
/****** Object:  Trigger [update_rmi_task_process_step_when_rmi_task_process_insert]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[update_rmi_task_process_step_when_rmi_task_process_insert]
ON [dbo].[RMI_TASK_PROCESS]
FOR INSERT
AS
DECLARE @step uniqueidentifier, @serial uniqueidentifier, @process varchar(50);
DECLARE CUR_INS_RMI_TASK_PROCESS CURSOR SCROLL FOR SELECT ProcessID, Serialno FROM INSERTED;
OPEN CUR_INS_RMI_TASK_PROCESS;
FETCH FIRST FROM CUR_INS_RMI_TASK_PROCESS INTO @process, @serial;
WHILE( @@fetch_status=0 ) 
BEGIN 
	DECLARE CUR_SEL_RMI_PROCESS_STEP CURSOR SCROLL FOR SELECT StepID FROM RMI_PROCESS_STEP WHERE ProcessID = @process;
	OPEN CUR_SEL_RMI_PROCESS_STEP;
	FETCH FIRST FROM CUR_SEL_RMI_PROCESS_STEP INTO @step;
	WHILE( @@fetch_status=0 ) 
	BEGIN 
		INSERT INTO RMI_TASK_PROCESS_STEP(Serialno, ProcessID, StepID, Finished, LastModifiedTime)
		 VALUES(@serial, @process, @step, 0, GETDATE());
		FETCH NEXT FROM CUR_SEL_RMI_PROCESS_STEP INTO @step;
	END
	CLOSE CUR_SEL_RMI_PROCESS_STEP;
	DEALLOCATE CUR_SEL_RMI_PROCESS_STEP;
	FETCH NEXT FROM CUR_INS_RMI_TASK_PROCESS INTO @process, @serial;
END
CLOSE CUR_INS_RMI_TASK_PROCESS;
DEALLOCATE CUR_INS_RMI_TASK_PROCESS;
GO
/****** Object:  Trigger [update_rmi_task_process_when_rmi_task_insert]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[update_rmi_task_process_when_rmi_task_insert]
ON [dbo].[RMI_TASK]
FOR INSERT
AS
DECLARE @flow uniqueidentifier, @serial uniqueidentifier, @process varchar(50), @userID varchar(50);
DECLARE CUR_INS CURSOR SCROLL FOR SELECT FlowID, Serialno, UserID FROM INSERTED;
OPEN CUR_INS;
FETCH FIRST FROM CUR_INS INTO @flow, @serial, @userID;
WHILE( @@fetch_status=0 ) 
BEGIN 
	DECLARE CUR_SEL CURSOR SCROLL FOR SELECT ProcessID FROM RMI_FLOW_PROCESS WHERE FlowID = @flow;
	OPEN CUR_SEL;
	FETCH FIRST FROM CUR_SEL INTO @process;
	WHILE( @@fetch_status=0 ) 
	BEGIN 
		INSERT INTO RMI_TASK_PROCESS(Serialno, ProcessID, LastModifiedUser, LastModifiedTime) VALUES(@serial, @process, @userID, GETDATE());
		FETCH NEXT FROM CUR_SEL INTO @process;
	END
	CLOSE CUR_SEL;
	DEALLOCATE CUR_SEL;
	FETCH NEXT FROM CUR_INS INTO @flow, @serial, @userID;
END
CLOSE CUR_INS;
DEALLOCATE CUR_INS;
GO
/****** Object:  Trigger [update_other_tables_when_delete_rmi_task]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[update_other_tables_when_delete_rmi_task]
ON [dbo].[RMI_TASK]
FOR DELETE
AS
DECLARE @serial uniqueidentifier;
DECLARE CUR_DEL_IN_RMI_TASK CURSOR SCROLL FOR SELECT Serialno FROM DELETED;
OPEN CUR_DEL_IN_RMI_TASK;
FETCH FIRST FROM CUR_DEL_IN_RMI_TASK INTO @serial;
WHILE( @@fetch_status=0 ) 
BEGIN 
	DELETE FROM RMI_TASK_PROCESS WHERE Serialno = @serial;
	DELETE FROM RMI_TASK_PROCESS_STEP WHERE SerialNo = @serial;
	DELETE FROM RMI_F01_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F02_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F03_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F04_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F05_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F06_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F07_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F08_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F09_DATA WHERE SerialNo = @serial;
	DELETE FROM RMI_F10_DATA WHERE SerialNo = @serial;
	FETCH NEXT FROM CUR_DEL_IN_RMI_TASK INTO @serial;
END
CLOSE CUR_DEL_IN_RMI_TASK;
DEALLOCATE CUR_DEL_IN_RMI_TASK;
GO
/****** Object:  View [dbo].[SupplierInfoAnalysis]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SupplierInfoAnalysis] /*创建视图*/
  AS
    SELECT GongYingShangBianMa=dbo.getSupplierCodeByID(SupplierID),
		   GongYingShangMingCheng=dbo.getSupplierNameByID(SupplierID),
		   GongHuoShuLiang = SUM(DaoLiaoZongShu),  TongJiQiNeiDaoHuoPiCi=COUNT(*),
           BuHeGePiCi=(SELECT COUNT(*) FROM RMI_TASK A
						WHERE DATEDIFF(DAY,A.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
						AND dbo.taskJudgement(SerialNo) = 0 AND A.SupplierID = B.SupplierID AND A.UnitID = B.UnitID),
		   BuHeGeShuLiang=(SELECT ISNULL(SUM(C.DaoLiaoZongShu), 0) FROM RMI_TASK C
						   WHERE DATEDIFF(DAY,C.CREATETIME,CONVERT(varchar(10), Createtime , 21)) = 0
						   AND dbo.taskJudgement(SerialNo) = 0
						   AND C.SupplierID = B.SupplierID AND C.UnitID = B.UnitID),
			RiQi=CONVERT(varchar(10), Createtime , 21),
			DaoHuoShuLiangDanWei=(SELECT dbo.getUnitNameByID(B.UnitID))
			FROM RMI_TASK B
			WHERE dbo.getSupplierCodeByID(SupplierID) != ''
            GROUP BY SupplierID, UnitID, CONVERT(varchar(10), Createtime , 21)
GO
/****** Object:  View [dbo].[RMI_TASK_DIVIDE_INSPECTOR]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[RMI_TASK_DIVIDE_INSPECTOR]
as
SELECT SerialNo, CONVERT(VARCHAR(16), a.CreateTime, 20) CreateTime, CONVERT(VARCHAR(16), a.LastModifiedTime, 20) LastModifiedTime,
	           ProductNo, ColorNo, CONVERT(VARCHAR(10), a.ArriveTime, 20) ArriveTime, dbo.getUserNameByUserID(UserID) Name, dbo.getSupplierCodeByID(SupplierID) SupplierCode,
	           dbo.getSupplierNameByID(SupplierID) SupplierName, MaterialID, dbo.getMaterialNameByID(MaterialID) MaterialName,
	           dbo.getMaterialTypeNameByID(dbo.getMaterialTypeIDByMaterialID(MaterialID)) MaterialTypeName, DaoLiaoZongShu, UnitID,
	           dbo.getUnitNameByID(UnitID) UnitName, DaoLiaoZongShu2, UnitID2, dbo.getUnitNameByID(UnitID2) AS DanWei2, UserID, InspectTotalNumber,
	           Inspectors=substring(a.Inspectors,b.number,charindex('@',a.Inspectors+'@',b.number)-b.number)
	           FROM RMI_TASK a WITH(NOLOCK) JOIN master..spt_values b WITH(NOLOCK) ON b.type = 'P'
	           WHERE charindex('@','@'+a.Inspectors,b.number)=b.number
GO
/****** Object:  UserDefinedFunction [dbo].[getDaoLiaoZongShuAndUnit]    Script Date: 05/08/2016 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getDaoLiaoZongShuAndUnit](@SerialNo uniqueidentifier)
RETURNS varchar(100)
AS
BEGIN
DECLARE @DaoLiaoZongShuAndUnit VARCHAR(100),@DaoLiaoZongShu varchar(100), @DaoLiaoZongShu2 varchar(100);
SELECT @DaoLiaoZongShu = CONVERT(VARCHAR(20),DaoLiaoZongShu)+dbo.getUnitNameByID(UnitID),
	   @DaoLiaoZongShu2 = CONVERT(VARCHAR(20),ISNULL(DaoLiaoZongShu2, ''))+ISNULL(dbo.getUnitNameByID(UnitID2),'')
	   FROM RMI_TASK WHERE SerialNo = @SerialNo;
IF @DaoLiaoZongShu2 <> '0'
	SELECT @DaoLiaoZongShuAndUnit = @DaoLiaoZongShu + '/' + @DaoLiaoZongShu2;
ELSE
	SELECT @DaoLiaoZongShuAndUnit = @DaoLiaoZongShu;
RETURN @DaoLiaoZongShuAndUnit;
END
GO
/****** Object:  Default [DF_RMI_TABLE_CONFIG_ID]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_TABLE_CONFIG] ADD  CONSTRAINT [DF_RMI_TABLE_CONFIG_ID]  DEFAULT (newsequentialid()) FOR [ID]
GO
/****** Object:  Default [DF_RMI_SUPPLIER_SupplierID]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_SUPPLIER] ADD  CONSTRAINT [DF_RMI_SUPPLIER_SupplierID]  DEFAULT (newsequentialid()) FOR [SupplierID]
GO
/****** Object:  Default [DF_RMI_STEP_StepID]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_STEP] ADD  CONSTRAINT [DF_RMI_STEP_StepID]  DEFAULT (newsequentialid()) FOR [StepID]
GO
/****** Object:  Default [DF_RMI_QUESTION_questionID]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_QUESTION] ADD  CONSTRAINT [DF_RMI_QUESTION_questionID]  DEFAULT (newsequentialid()) FOR [questionID]
GO
/****** Object:  Default [DF_RMI_MATERIAL_TYPE_MaterialTypeID]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_MATERIAL_TYPE] ADD  CONSTRAINT [DF_RMI_MATERIAL_TYPE_MaterialTypeID]  DEFAULT (newsequentialid()) FOR [MaterialTypeID]
GO
/****** Object:  Default [DF_RMI_MATERIAL_NAME_MaterialID]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_MATERIAL_NAME] ADD  CONSTRAINT [DF_RMI_MATERIAL_NAME_MaterialID]  DEFAULT (newsequentialid()) FOR [MaterialID]
GO
/****** Object:  Default [DF_RMI_JOB_JobID]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_JOB] ADD  CONSTRAINT [DF_RMI_JOB_JobID]  DEFAULT (newsequentialid()) FOR [JobID]
GO
/****** Object:  Default [DF__RMI_F10_DATA__Id__5BAD9CC8]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F10_DATA] ADD  CONSTRAINT [DF__RMI_F10_DATA__Id__5BAD9CC8]  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF__RMI_F09_DATA__Id__245D67DE]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F09_DATA] ADD  CONSTRAINT [DF__RMI_F09_DATA__Id__245D67DE]  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF__RMI_F08_DATA__id__1EA48E88]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F08_DATA] ADD  CONSTRAINT [DF__RMI_F08_DATA__id__1EA48E88]  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F07_DATA_Id]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F07_DATA] ADD  CONSTRAINT [DF_RMI_F07_DATA_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F06_DATA_Id]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F06_DATA] ADD  CONSTRAINT [DF_RMI_F06_DATA_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F05_DATA_Id]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F05_DATA] ADD  CONSTRAINT [DF_RMI_F05_DATA_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F04_DATA_Id]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F04_DATA] ADD  CONSTRAINT [DF_RMI_F04_DATA_Id]  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF__RMI_F03_DATA__Id__3CF40B7E]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F03_DATA] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF__RMI_F02_DATA__Id__589C25F3]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F02_DATA] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
/****** Object:  Default [DF_RMI_F01_DATA_ID]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F01_DATA] ADD  CONSTRAINT [DF_RMI_F01_DATA_ID]  DEFAULT (newsequentialid()) FOR [ID]
GO
/****** Object:  Default [DF_RMI_F01_DATA_ZhuDiaoPai]    Script Date: 05/08/2016 10:28:32 ******/
ALTER TABLE [dbo].[RMI_F01_DATA] ADD  CONSTRAINT [DF_RMI_F01_DATA_ZhuDiaoPai]  DEFAULT ((0)) FOR [isZhuDiaoPai]
GO
/****** Object:  Default [DF_RMI_WORKFLOW_FlowID]    Script Date: 05/08/2016 10:28:33 ******/
ALTER TABLE [dbo].[RMI_WORK_FLOW] ADD  CONSTRAINT [DF_RMI_WORKFLOW_FlowID]  DEFAULT (newsequentialid()) FOR [FlowID]
GO
/****** Object:  Default [DF_RMI_WORK_FLOW_LastModifiedTime]    Script Date: 05/08/2016 10:28:33 ******/
ALTER TABLE [dbo].[RMI_WORK_FLOW] ADD  CONSTRAINT [DF_RMI_WORK_FLOW_LastModifiedTime]  DEFAULT (getdate()) FOR [LastModifiedTime]
GO
/****** Object:  Default [DF_RMI_UNIT_UnitID]    Script Date: 05/08/2016 10:28:33 ******/
ALTER TABLE [dbo].[RMI_UNIT] ADD  CONSTRAINT [DF_RMI_UNIT_UnitID]  DEFAULT (newsequentialid()) FOR [UnitID]
GO
/****** Object:  Default [DF_RMI_TASK_SerialNo]    Script Date: 05/08/2016 10:28:33 ******/
ALTER TABLE [dbo].[RMI_TASK] ADD  CONSTRAINT [DF_RMI_TASK_SerialNo]  DEFAULT (newsequentialid()) FOR [SerialNo]
GO
/****** Object:  Default [DF_RMI_TASK_State]    Script Date: 05/08/2016 10:28:33 ******/
ALTER TABLE [dbo].[RMI_TASK] ADD  CONSTRAINT [DF_RMI_TASK_State]  DEFAULT ((2)) FOR [State]
GO

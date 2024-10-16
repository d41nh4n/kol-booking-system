USE [master]
GO
/****** Object:  Database [SWP391]    Script Date: 12/7/2024 12:28:23 AM ******/
CREATE DATABASE [SWP391]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SWP391', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\SWP391.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SWP391_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\SWP391_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SWP391] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP391].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP391] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP391] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP391] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP391] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP391] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP391] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP391] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP391] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP391] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP391] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP391] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SWP391] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP391] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP391] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP391] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP391] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP391] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP391] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP391] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP391] SET  MULTI_USER 
GO
ALTER DATABASE [SWP391] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP391] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP391] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP391] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SWP391] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SWP391] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP391', N'ON'
GO
ALTER DATABASE [SWP391] SET QUERY_STORE = ON
GO
ALTER DATABASE [SWP391] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SWP391]
GO
/****** Object:  Table [dbo].[categoriesinfo]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoriesinfo](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[comment_id] [int] IDENTITY(1,1) NOT NULL,
	[commenter_id] [int] NOT NULL,
	[is_violation] [bit] NOT NULL,
	[rating_value] [int] NULL,
	[receiver_id] [int] NULL,
	[created_at] [datetimeoffset](6) NOT NULL,
	[comment_content] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[commentviolation]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[commentviolation](
	[comment_id] [int] NOT NULL,
	[comment_violation_id] [int] IDENTITY(1,1) NOT NULL,
	[violation_level] [int] NOT NULL,
	[word_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[comment_violation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[day_request]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[day_request](
	[request_id] [int] NOT NULL,
	[day_request] [datetime2](6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[media_profile]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[media_profile](
	[profile_id] [int] NULL,
	[create_at] [datetimeoffset](6) NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NOT NULL,
	[url] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[notification]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notification](
	[user_id] [int] NOT NULL,
	[create_at] [datetimeoffset](6) NULL,
	[notification_id] [bigint] IDENTITY(1,1) NOT NULL,
	[content] [nvarchar](100) NULL,
	[reference_id] [varchar](255) NULL,
	[type] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile](
	[money] [float] NULL,
	[rating] [float] NULL,
	[user_id] [int] NOT NULL,
	[birthday] [datetime2](6) NULL,
	[priceapost] [bigint] NOT NULL,
	[priceato_hireaday] [bigint] NOT NULL,
	[priceavideo] [bigint] NOT NULL,
	[representative_price] [bigint] NOT NULL,
	[location] [nvarchar](155) NULL,
	[full_name] [nvarchar](max) NULL,
	[avatar_url] [varchar](500) NULL,
	[bio] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile_categories]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile_categories](
	[category_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report](
	[comment_id] [int] NOT NULL,
	[report_id] [int] IDENTITY(1,1) NOT NULL,
	[report_user] [int] NULL,
	[reported_user] [int] NULL,
	[create_date] [datetime2](6) NULL,
	[description] [varchar](50) NOT NULL,
	[reason] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request_categories]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request_categories](
	[category_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[request_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request_representatives]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request_representatives](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[months] [int] NOT NULL,
	[request_id] [int] NULL,
	[end_date] [datetime2](6) NULL,
	[start_date] [datetime2](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request_wait_list]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request_wait_list](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[request_id] [int] NOT NULL,
	[responder_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[requests]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[requests](
	[is_public] [bit] NULL,
	[payment] [float] NULL,
	[request_id] [int] IDENTITY(1,1) NOT NULL,
	[request_status] [smallint] NULL,
	[requester_confirm] [bit] NULL,
	[requester_id] [int] NULL,
	[responder_id] [int] NULL,
	[responer_confirm] [bit] NULL,
	[request_date] [datetime2](6) NULL,
	[request_date_end] [datetime2](6) NULL,
	[request_location] [nvarchar](155) NULL,
	[request_description] [nvarchar](max) NULL,
	[request_type] [varchar](255) NULL,
	[result_link] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[schedule]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[schedule](
	[request_id] [int] NULL,
	[schedule_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[request_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_conversation]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_conversation](
	[created_at] [datetimeoffset](6) NULL,
	[updated_at] [datetimeoffset](6) NULL,
	[id] [varchar](255) NOT NULL,
	[last_message] [varchar](255) NULL,
	[type] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_message]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_message](
	[is_read] [bit] NOT NULL,
	[recipient_id] [int] NOT NULL,
	[sender_id] [int] NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[timestamp] [datetimeoffset](6) NOT NULL,
	[content] [ntext] NOT NULL,
	[conversation_id] [varchar](255) NOT NULL,
	[type] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_verifycode]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_verifycode](
	[number_of_attempts] [int] NULL,
	[userid] [int] NULL,
	[expiry_date_time] [datetime2](6) NULL,
	[code] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[id] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactionhistory]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactionhistory](
	[receiver_id] [int] NULL,
	[request_id] [int] NULL,
	[sender_id] [int] NULL,
	[trans_id] [int] IDENTITY(1,1) NOT NULL,
	[trans_payment] [float] NOT NULL,
	[trans_status] [bit] NULL,
	[trans_time] [datetime2](6) NULL,
	[transaction_id] [varchar](255) NULL,
	[type] [varchar](255) NULL,
	[system-income] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[trans_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_conversation]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_conversation](
	[user_id] [int] NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[conversation_id] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[account_balance] [float] NULL,
	[is_locked] [bit] NULL,
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[gender] [varchar](6) NULL,
	[create_at] [datetime2](6) NULL,
	[what_role] [varchar](20) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[email] [varchar](100) NULL,
	[password_hash] [varchar](255) NOT NULL,
	[reset_password_token] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[violationwords]    Script Date: 12/7/2024 12:28:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[violationwords](
	[violation_level] [int] NOT NULL,
	[word_id] [int] IDENTITY(1,1) NOT NULL,
	[word] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[word_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[categoriesinfo] ON 

INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (1, N'Fashion', N'Category related to fashion influencers')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (2, N'Technology', N'Category for tech reviewers and experts')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (3, N'Fitness', N'Category for fitness trainers and health experts')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (4, N'Travel', N'Category for travel bloggers and adventurers')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (5, N'Food', N'Category for food critics and chefs')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (7, N'Lifestyle', N'Category for lifestyle coaches and personal development')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (8, N'Gaming', N'Category for gaming streamers and reviewers')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (9, N'Education', N'Category for educational content creators')
INSERT [dbo].[categoriesinfo] ([category_id], [category_name], [description]) VALUES (10, N'Music', N'Category for entertainers, comedians, and performers')
SET IDENTITY_INSERT [dbo].[categoriesinfo] OFF
GO
SET IDENTITY_INSERT [dbo].[comment] ON 

INSERT [dbo].[comment] ([comment_id], [commenter_id], [is_violation], [rating_value], [receiver_id], [created_at], [comment_content]) VALUES (1, 1, 0, 5, 2, CAST(N'2024-07-08T10:30:27.8339870+07:00' AS DateTimeOffset), N'-10 điểm về sự nhiệt tình ')
SET IDENTITY_INSERT [dbo].[comment] OFF
GO
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-29T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-28T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-27T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-20T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-21T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-22T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-23T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-24T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-25T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (1, CAST(N'2024-07-26T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (3, CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (3, CAST(N'2024-07-29T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (3, CAST(N'2024-07-28T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (3, CAST(N'2024-07-27T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (4, CAST(N'2024-07-27T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (4, CAST(N'2024-07-28T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (4, CAST(N'2024-07-29T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (4, CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (6, CAST(N'2024-07-27T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (6, CAST(N'2024-07-28T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (6, CAST(N'2024-07-29T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[day_request] ([request_id], [day_request]) VALUES (6, CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2))
GO
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (0, 1, 1, NULL, 0, 0, 0, 0, N'', N'Đại Nhân', N'', N'')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 5, 2, CAST(N'2024-07-08T01:05:36.8827180' AS DateTime2), 100000, 200000, 150000, 120000, N'Kon Tum', N'Châu Bùi ', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTD6VjiXR6Q_J_2DRmebDUaLxOAISoL4hlQDQ&s', N'Nhắc đến giới Fashionista, Châu Bùi chắc chắn sẽ là cái tên không thể không nhắc đến. Mặc dù có chiều cao khiêm tốn nhưng cô người mẫu lookbook cá tính này đã xuất hiện và gây ấn tượng trong nhiều tuần lễ thời trang trong và ngoài nước. Là người dẫn đầu xu hướng, tạo cảm hứng thời trang cho giới trẻ, Châu Bùi xuất sắc giành giải thưởng Top Fashion Influencer of the Year at Influence Asia được tổ chức tại Malaysia năm 2017. Ba năm sau đó, cô nàng tiếp tục vinh dự nằm trong danh sách 10 Influencer có tầm ảnh hưởng nhất trong mảng thời trang cao cấp do tạp chí Forbes Pháp bình chọn. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 3, CAST(N'2024-07-08T01:05:36.8827180' AS DateTime2), 100000, 200000, 150000, 120000, N'Gia Lai', N'Quỳnh Anh Shyn', N'https://cdn.tuoitre.vn/471584752817336320/2023/2/1/screenshot-2023-02-01-172211-16752470959221305064600.png', N'Được biết đến như một cô nàng hot girl bánh bèo với ngoại hình xinh xắn và trong trẻo, Quỳnh Anh Shyn đã có một cú lột xác ngoạn mục đối với làng mốt Việt. Từng gây tranh nhiều tranh cãi khi thay đổi hình ảnh, Quỳnh Anh Shyn vẫn đam mê theo đuổi phong cách mới, vượt khỏi “vùng an toàn” và hiện nay đã trở thành một trong những influencer Việt Nam có sức ảnh hưởng lớn trong ngành thời trang.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 4, CAST(N'2024-07-08T01:05:36.8837100' AS DateTime2), 100000, 200000, 150000, 120000, N'Kiên Giang', N'Hồ Ngọc Hà ', N'https://images2.thanhnien.vn/528068263637045248/2023/4/14/3299834301650258729995193996044775334103941n-16814587812381136942447.jpg', N'Thời trang tuổi 40 của Hồ Ngọc Hà được "phủ sóng" bởi những bộ cánh mang tông màu trắng làm chủ đạo. Kiểu trang phục này rất phù hợp với mùa hè bị độ dịu dàng, nhẹ mát. Ngoài ra, trang phục màu trắng còn đem đến hiệu quả "hack" tuổi nhưng không làm giảm đi sự thanh lịch. Tham khảo những bộ trang phục mang tông màu trắng của Hồ Ngọc Hà, các quý cô trên 40 tuổi sẽ tìm thấy nhiều ý tưởng mặc đẹp.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 5, CAST(N'2024-07-08T01:05:36.8837100' AS DateTime2), 100000, 200000, 150000, 120000, N'H?i Duong', N'Hannah Nguyễn', N'https://thanhnien.mediacdn.vn/uploaded/quochung.qc/2021_05_14/hannaholala/dsc06965a_KAFG.jpg?width=500', N'Hannah Nguyễn được biết đến là một doanh nhân, beauty blogger Việt kiều nổi tiếng với gần 600 nghìn người theo dõi trên mạng xã hội. Được biết, Hannah Nguyễn lớn lên tại Mỹ và có nhiều năm điều hành nhiều thương hiệu mỹ phẩm quốc tế.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 6, CAST(N'2024-07-08T01:05:36.8847080' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c Ninh', N'KIENPHAM', N'https://yt3.googleusercontent.com/L6BqW9FPDQjgQ-LZNKhtgpJKRSHNUv48PLWX3O2GzLKs1gyJQ7glfgm4A9QploXl8eMrfSYK=s900-c-k-c0x00ffffff-no-rj', N'"Thời trang không có giới hạn", và tiktoker KIENPHAM là minh chứng rõ nhất cho câu nói này. Với nhiều người, váy hay một số item nữ tính chỉ dành cho phụ nữ, nhưng với fashion blogger này, mọi món đồ thời trang đều không có quy chuẩn hay giới hạn, chỉ cần chúng phù hợp với phong cách và cá nhân bạn. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 7, CAST(N'2024-07-08T01:05:36.8847080' AS DateTime2), 100000, 200000, 150000, 120000, N'Hoà Bình', N'Kelbin Lei', N'https://nguoinoitieng.tv/images/nnt/0/4/g5.jpg', N'Là một stylist chuyên nghiệp và đã từng hợp tác với rất nhiều nghệ sĩ lớn, Kelbin Lei có gu thời trang rất riêng và độc đáo, anh chàng luôn bị thu hút bởi những gam màu nổi bật như đỏ, đen, cam,.... Cũng chính vì vậy mà đa số các bộ trang phục của anh đều được kết hợp từ những gam màu nóng vô cùng ấn tượng và cuốn hút. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 8, CAST(N'2024-07-08T01:05:36.8857030' AS DateTime2), 100000, 200000, 150000, 120000, N'Long An', N'Wren Evans', N'https://cdn.tuoitre.vn/zoom/700_525/471584752817336320/2023/12/14/wren-evans-1702520303571225982134-72-0-752-1299-crop-17025203532331958787679.jpg', N'Mọi người thường biết đến anh chàng ca sĩ Wren Evans với bài hát Thích em hơi nhiều. Thế nhưng bên cạnh đó, trong lĩnh vực thời trang, Wren cũng tạo được nhiều dấu ấn trong lòng các bạn trẻ nhờ gu ăn mặc vô cùng ấn tượng và nổi bật. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 9, CAST(N'2024-07-08T01:05:36.8857030' AS DateTime2), 100000, 200000, 150000, 120000, N'Long An', N'Phạm Bảo Luận', N'https://dosi-in.com/images/news_content/18411/2020/12/04/stylist-pham-bao-luan-nguoi-thoi-hon-cho-ve-ngoai-lung-linh-cua-loat-sao-hang-a_2020_12_04_4.jpg', N'Mặc dù khá âm thầm mà lặng lẽ, không quá rầm rộ trên các trang mạng xã hội, thế nhưng Phạm Bảo Luận vẫn là cái tên quá đỗi quen thuộc trong cộng đồng giới trẻ yêu thời trang, bởi lẽ anh chàng chính là người mang đến vẻ ngoài ấn tượng và lung linh cho rất nhiều nghệ sĩ nổi tiếng trong showbiz.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 10, CAST(N'2024-07-08T01:05:36.8867020' AS DateTime2), 100000, 200000, 150000, 120000, N'Long An', N'Thomas Chu  ', N'https://www.elleman.vn/wp-content/uploads/2021/10/22/204999/tai-khoan-tiktok_thomas-chu-5_elle-man_1021.jpg', N'Thomas Chu là một fashion influencer cực kỳ nổi tiếng trong cộng đồng giới trẻ Việt, đồng thời, hiện anh chàng cũng là người mẫu thời trang cả Đức. Trong các video tiktok, Thomas Chu chủ yếu chia sẻ về kiến thức thời trang, các mẹo phối đồ và các cách tạo dáng khi chụp ảnh. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 11, CAST(N'2024-07-08T01:05:36.8877000' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c Liêu', N'Nam Phung', N'https://cdn.tuoitre.vn/471584752817336320/2023/9/13/hoa1-169457356651056706621.jpg', N'Nam Phùng là một fashion influencer nam cực kỳ biết “chơi đùa” màu sắc khi sử dụng những gam màu rực rỡ, nổi bật đánh thẳng vào thị giác. Có những item có màu sắc nhìn tưởng chừng không liên quan gì tới nhau nhưng khi vào tay Nam Phùng để lại trông vô cùng hợp lý và nổi bật. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 12, CAST(N'2024-07-08T01:05:36.8877000' AS DateTime2), 100000, 200000, 150000, 120000, N'Ð?ng Tháp', N'Khánh Linh', N'https://thanhnien.mediacdn.vn/Uploaded/hienth/2021_10_08/tiktok-fashup-2021-fashionista-khanh-linh-1763.png', N'Đối với những fashionholic, Cô em Trendy là một cái tên không hề xa lạ, đây là một trong những kênh youtube này có sức ảnh hưởng lớn với thời trang Việt Nam. Khoảng 1.420.000 kết quả cho 0,34 giây tìm kiếm cụm từ “Cô em Trendy” đủ để thấy rõ sức nóng và độ phủ sóng truyền thông của Khánh Linh như thế nào.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 13, CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), 100000, 200000, 150000, 120000, N'H?i Phòng', N'Julia Doan', N'https://media.viez.vn/prod/2022/7/1/image_a1364aa72a.png', N'Julia Đoàn là một trong những gương mặt thời trang nổi tiếng với “đặc điểm nhận dạng” là đường eyeliner mắt mèo sắc sảo và đặc biệt là phong cách thời trang trung thành với hai màu trắng - đen.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 14, CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), 100000, 200000, 150000, 120000, N'Bình Duong', N'Helly Tống', N'https://cdn1.tuoitre.vn/zoom/600_315/2022/9/3/helly-tong-2-1662191830818963386734-crop-16621919148001079411589.jpg', N'Nổi bật với gu thời trang đơn giản, thanh lịch pha với nét yêu kiều đặc trưng của người phụ nữ Á Đông, Helly Tống được biết đến với một hình tượng thời trang trưởng thành dù nhẹ nhàng nhưng vẫn cuốn hút. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 15, CAST(N'2024-07-08T01:05:36.8896930' AS DateTime2), 100000, 200000, 150000, 120000, N'Bà R?a - Vung Tàu', N'Duy Thẩm', N'https://static-images.vnncdn.net/files/publish/2022/7/26/duy-tham-2-fixed-61.jpg', NULL)
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 16, CAST(N'2024-07-08T01:05:36.8896930' AS DateTime2), 100000, 200000, 150000, 120000, N'Hung Yên', N'Vinh Vật Vờ', N'https://vnn-imgs-f.vgcloud.vn/2021/02/23/12/vinh-vat-vo-2.jpg', N'Thực đơn Influencer
5 Influencer – Reviewer Công Nghệ Uy Tín Hàng Đầu Việt Nam

REVU Việt Nam
Influencer Marketing Agency & Platform
 Copy link
influencer reviewer công nghệ
Reviewer công nghệ giới thiệu cho khán giả những sản phẩm công nghệ hữu ích, giúp người xem kiểm tra, sàng lọc độ uy tín của sản phẩm, chính vì vậy, reviewer công nghệ là một điểm đến quan trọng khi khách hàng muốn mua sản phẩm công nghệ.

Cùng REVU điểm qua Danh sách 5 Influencer Công Nghệ uy tín hàng đầu Việt Nam nhé.

Đọc thêm: REVU: Tổng hợp 5 KOL Lifestyle nổi tiếng tại Việt Nam
Nội dung
Duy Thẩm
Vinh Vật Vờ
Tân Một Cú
Tony Phùng
Hưng Khúc
Danh sách KOL – Influencer – Reviewer Công Nghệ phù hợp với doanh nghiệp bạn
Duy Thẩm
reviewer công nghệ duy thẩm

Họ và tên

Ngô Đức Duy

TikTok

duyyy.real.channel | 7.5M followers

Facebook

Duy Thẩm | 1M followers

Youtube

Duy Thẩm | 2.1M subscribers

Instagram

duythamchannel | 95K followers

Kênh của cô thu hút người xem với những đánh giá món ăn đa dạng từ ẩm thực đường phố đến nhà hàng sang trọng. Cô gây ấn tượng với người xem không chỉ bằng những món ăn ngon mà còn với cách diễn đạt hài hước, tự nhiên. Điều đặc biệt là cách cô ấy đánh giá một cách khách quan, chân thật và trung thực.

Với Tiểu màn thầu, food blogger không chỉ là một nghề kiếm tiền, mà giúp cô thỏa mãn niềm đam mê với ẩm thực. Ngoài ra còn giúp cô mở rộng kiến thức về xã hội và kết nối với nhiều người trong ngành.

Nội dung chính trên kênh của Duy Thẩm bao gồm:

Review trải nghiệm các món đồ công nghệ
Chia sẻ cuộc sống hạnh phúc cùng vợ 
Những khoảnh khắc trong cuộc sống hẳng ngày
Các ngành nên book: 

Công nghệ
Ứng dụng
Ngân hàng
FMCG
F&B
Du lịch
Xe
Top video viral:



logo
Khám phá cách REVU giúp thương hiệu tăng độ nhận diện & uy tín
Nền tảng kết nối Creator - hàng ngàn người review sản phẩm, hỗ trợ viral thương hiệu

Chiến dịch Influencer Marketing tổng thể - từ A-Z chiến dịch Influencer Marketing được tư vấn, triển khai bởi chuyên gia

CreatorAds - tăng hiệu quả quảng cáo với nội dung chất lượng từ creator

NHẬN TƯ VẤN
Vinh Vật Vờ
reviewer công nghệ vinh vật vờ

Họ và tên

Trần Xuân Vinh

TikTok

vinhvatvofake | 409K followers

Facebook

Vinh Xô | 67K followers

Youtube

Vinh Xô | 306K subscribers

Instagram

vatvo69 | 45K followers

Với hệ thống các kênh Youtube, diễn đàn công nghệ lớn như: Relab, Vinh Xô,… Tiếng nói của Influencer công nghệ này cũng dần có sức nặng nhât định trong giới công nghệ.

Vinh hiện vẫn đang hoạt động tại Vật Vờ Studio song song với kênh Youtube cá nhân Vinh Xô – sắp đạt mốc 100.000 subcribers. Vinh Vật Vờ từng hợp tác với các nhãn hàng công nghệ lớn như: Samsung, Apple, LG, Asus, Acer…')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 17, CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), 100000, 200000, 150000, 120000, N'Bà R?a - Vung Tàu', N'Tân Một Cú', N'https://kenh14cdn.com/2020/7/16/dsc2559-1594910881122665902834-crop-1594910928608668430787.jpg', N'Tân Một Cú hay Phạm Ngọc Tân là cái tên không hề xa lạ với các tín đồ công nghệ Việt Nam. Xuất phát là một Reviewer tại Schannel, sau gần 10 năm gắn bó, Influencer công nghệ này dần được khán giả yêu thích, qua các video review công nghệ hóm hỉnh.

Các video trên kênh Tân Một Cú thường xoay quanh các sản phẩm công nghệ.. Tân từng hợp tác với các nhãn hàng công nghệ lớn như: Samsung, LG, Asus, Acer…')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 18, CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), 100000, 200000, 150000, 120000, N'H? Chí Minh', N'Tony Phùng', N'https://cdn.24h.com.vn/upload/3-2022/images/2022-07-05/11-1656984838-779-width660height660.jpg', N'Tony Phùng hay Phùng Tuấn Anh, là một Youtuber công nghệ. Các video review của Tony mang phong cách mộc mạc, dễ hiểu. Điều này giúp người xem nắm nhanh vấn đề của các sản phẩm được review.

Influencer này rất chăm chỉ đăng video. Bằng chứng là kênh Tony Phùng Studio đã đạt hơn 600 nghìn subcribers với tần suất trung bình 1 video/ ngày. Tuấn Anh từng hợp tác với các nhãn hàng công nghệ lớn như: Samsung, LG, Xiaomi…')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 19, CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), 100000, 200000, 150000, 120000, N'B?n Tre', N'Hưng Khúc', N'https://yt3.googleusercontent.com/pcKAyYeHolzcyum-xBLgUvpMOodN8AGlg-c1SWVc4Cgirk7ut9W_0EnoX2lvfgRafiWWB40kF4c=s900-c-k-c0x00ffffff-no-rj', N'Hưng Khúc là reviewer “ruột” của Thinkview, Aphone từ những ngày đầu tiên. Youtuber tạo ấn tượng với ngữ điệu rành mạch, content chi tiết nhanh chóng tạo được ấn tượng với khán giả.

Hưng Khúc vẫn đang hoạt động cùng team Thinkview, Aphone với gần 300.000 subcribers. Các nhãn hàng từng hợp tác cùng Hưng Khúc: MSI, Samsung, Huawei…')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 20, CAST(N'2024-07-08T01:05:36.8916900' AS DateTime2), 100000, 200000, 150000, 120000, N'Nam Ð?nh', N'Hannah Giang Anh', N'https://afamilycdn.com/150157425591193600/2020/4/21/hana5-1587456520940527885302.jpg', N'Hana Giang Anh tên thật là Nguyễn Đặng Hương Giang, sinh năm 1993 và là cựu sinh viên Đại học Kinh tế quốc dân. Cô là chủ sở hữu kênh Youtube hơn 620K người theo dõi cùng hàng trăm clip hướng dẫn tập gym chuyên nghiệp, Hana đã đem lại nguồn cảm hứng to lớn cho các cô gái có mong muốn cải thiện vóc dáng bản thân. Những chủ đề trong các video trên kênh của cô không chỉ xoay quanh chủ đề fitness, tập gym mà còn cả về làm đẹp, lifestyle và cả những vấn đề “khó nói” của phụ nữ. Làm video clip về những chủ đề không ai dám làm cũng là một trong những nguyên nhân đem đến cho cô lượng người theo dõi cực khủng trên Youtube. Hana Giang Anh cũng từng là một trong 4 đại diện tại Việt Nam có tên trong danh sách đề cử Asia Health/Fitness Influencer năm 2017. Cô “phủ sóng” hầu hết trong mọi bài báo lớn nhỏ về lĩnh vực làm đẹp và fitness tại Việt Nam, không hề ngoa khi khẳng định cô chính là một trong những nữ gymer nổi tiếng nhất tại Việt Nam.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 21, CAST(N'2024-07-08T01:05:36.8916900' AS DateTime2), 100000, 200000, 150000, 120000, N'Hoà Bình', N'Minh Tú', N'https://kenh14cdn.com/203336854389633024/2023/3/17/335631648-593337456147189-190025-8787-16790431822161435666880.jpg', N'Nói về người mẫu đang hot nhất hiện nay không thể không nhắc đến Minh Tú, cô người mẫu chuyên nghiệp có số đo 3 vòng cực chuẩn cùng làn da nâu khỏe khoắn. Minh Tú từng là Á Quân cuộc thi Asia’s Next Top Model mùa 5 và là mentor chương trình The Face Việt Nam 2017 cùng nhiều giải thưởng danh giá khác trong lĩnh vực người mẫu. Để đạt được thành công như hôm nay, ngoài gương mặt xinh đẹp, sắc sảo, Minh Tú đã phải cố gắng luyện tập mỗi ngày để giữ gìn vóc dáng và có được thân hình săn chắc, đầy quyến rũ. Sự nỗ lực không ngừng của cô chính là tấm gương lớn cho các bạn trẻ, đây cũng chính là điểm giúp cô thu hút được hơn 400K followers trên trang facebook cá nhân của mình. Nếu bạn đang tìm đại sứ hình ảnh cho thương hiệu/sản phẩm về thể thao,sức khỏe thì Minh Tú với phong cách đầy cá tính, mạnh mẽ là lựa chọn không thể phù hợp hơn.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 22, CAST(N'2024-07-08T01:05:36.8926870' AS DateTime2), 100000, 200000, 150000, 120000, N'An Giang', N'Linn Nguyen', N'https://img.vietcetera.com/wp-content/uploads/2019/07/Linn-Nguyen-3-683x1024.jpg', N'Linn Nguyen (Nguyễn Linh) là cái tên khá quen thuộc nếu bạn là một người thường xuyên theo dõi các vấn đề về fitness. Từng sở hữu thân hình “mình hạc xương mai” với cân nặng khoảng 38 kg, chiều cao 1,58 m, Linh quyết định tìm hiểu việc tập luyện và ăn uống khoa học để cải thiện vóc dáng và sức khỏe của mình. Cô trở nên nổi tiếng nhờ vào loạt bài về tăng cân và dần trở thành một người có sức ảnh hướng trong các vấn đề về sức khỏe và fitness, đem đến nguồn động lực lớn cho giới trẻ, đặc biệt là các bạn nữ. Không chỉ dừng ở đó, Linn Nguyễn còn khẳng định chuyên môn của bản thân khi từng là huấn luyện viên cá nhân trực tuyến tư vấn tập luyện cho Á hậu Huyền My trước kỳ thi Miss World 2017. Đặc biệt, Linn Nguyễn chính là người Việt Nam đầu tiên dành chiến thắng tại hạng mục Health/Fitness tại lễ trao giải Influencer Asia danh giá được tổ chức tại Kuala Lumpur cuối năm 2017.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 23, CAST(N'2024-07-08T01:05:36.8926870' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c K?n', N'Quang Đăng', N'https://yt3.googleusercontent.com/JEXSgOZxbrJQCFJE1NPdU4M0lhTtSLasfIwNFSsiXNQ527ti26VtLs9Zm1YNrKOn-NRhIk_A=s900-c-k-c0x00ffffff-no-rj', N'Chàng vũ công có “nụ cười tỏa nắng” này tên đầy đủ là Đỗ Quang Đăng, anh là một dancer đầy tài năng và được nhiều khán giả yêu mến. Tên tuổi Quang Đăng đã hot lại càng hot hơn kể từ sau chương trình So You Think You Can Dance mùa đầu tiên. Anh từng đạt được hạng nổi tiếng thứ 200 trên thế giới và đứng thứ 2 trong danh sách Vũ công nổi tiếng tại Việt Nam. Quang Đăng cũng là người con trai duy nhất có mặt trong danh sách đề cử Asia Health/Fitness Influencer năm 2017. Nụ cười tỏa nắng, gương mặt điển trai, đời tư minh bạch, tài năng và hình ảnh đầy năng động, mạnh mẽ của Quang Đăng chính là vũ khí giúp anh chàng này thu hút được một lượng fan không hề nhỏ.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 24, CAST(N'2024-07-08T01:05:36.8936850' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Tinh', N'Bùi Thạch Thảo', N'https://afamilycdn.com/k:thumb_w/600/Lew0w3pIoyh272KqgZVKzcqDLR91OE/Image/2016/01/Thach-Thao-3-2d7fa/thach-thao.jpg', N'Bùi Thạch Thảo, chủ nhân của trang huấn luyện viên thể hình cá nhân online nổi tiếng Lucy Luv Fitness. Cô cũng chính là cái tên còn lại trong danh sách 4 người được đề cử cho giải thưởng Asia Health/Fitness Influencer năm 2017 cùng với Giang Anh, Linh Nguyễn và Quang Đăng. Cô từng là huấn luyện viên chuyên nghiệp tại chuỗi phòng tập California Yoga & Fitness. Hiện tại, Thạch Thảo tiếp tục hợp tác với một chuỗi phòng gym chuyên nghiệp tên tuổi khác là Citigym, nơi quay hình chương trình The Face mùa vừa rồi. Cô nàng sở hữu thân hình săn chắc, quyến rũ, khỏe mạnh mà nhiều cô gái mơ ước nhờ chế độ luyện tập cùng chế độ ăn đúng và đầy dinh dưỡng.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 25, CAST(N'2024-07-08T01:05:36.8936850' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c K?n', N'Ashley Dinh', N'https://nguoinoitieng.tv/images/nnt/100/0/be4g.jpg', N'Ashley Dinh hay Đinh Thị Phương Thảo là cô gái trẻ đẹp, có thân hình gợi cảm, khỏe khoắn và săn chắc. Hiện tại, Phương Thảo đang là huấn luyện viên thể hình online tại Thành phố Hồ Chí Minh. Bên cạnh đó, Phương Thảo còn là chuyên gia tư vấn dinh dưỡng cho các đầu báo nổi tiếng như khoedep.vn, saostar.vn đưa tin về hành trình lột xác khó tin nhờ gym của mình. Câu chuyện “Hành trình lột xác nhờ tập gym của chân ngắn 9x” đã giúp cái tên Ashley Đinh ngày một trở nên hot hơn trong giới gymer. Quá trình giảm cân của Phương Thảo trở thành "huyền thoại" của các cô nàng nấm lùn, nhờ việc này mà cô đã thành công lan truyền tích cực tới rất nhiều người khác.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 26, CAST(N'2024-07-08T01:05:36.8946820' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Giang', N'Tracy Lê ', N'https://i.vietgiaitri.com/2020/4/24/bi-kip-so-huu-vong-3-gan-1-met-va-body-nong-bong-cua-hot-girl-phong-gym-tracy-le-da1-4875724.jpg', N'Trang hiện đang làm huấn luyện viên cá nhân tại Scitec Việt Nam - trung tâm tập gym, rèn luyện thể chất tại Hà Nội. Ngoài ra, cô cũng đang kinh doanh thực phẩm chức năng để hỗ trợ trong quá trình luyện tập. Trang luôn cập nhật thường xuyên các video hướng dẫn luyện tập và tích cực chia sẻ những bài tập của mình lên mạng xã hội cũng như các trang cộng đồng tập gym. Để có được chỗ đứng vững chắc cũng như đạt được mức ảnh hưởng như hôm nay, Trang Lê đã từng phải ‘chiến đấu’ không ngừng với cơn ác mộng mang tên skinny fat (gầy nhưng mập ở các phần cơ thể như bụng, đùi, bắp tay). Và giờ đây, cô đã được cộng đồng mạng ưu ái gọi với cái tên “Bà hoàng phòng gym”.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 27, CAST(N'2024-07-08T01:05:36.8946820' AS DateTime2), 100000, 200000, 150000, 120000, N'Bà R?a - Vung Tàu', N'Trần Bích Hạnh', N'https://cdn.24h.com.vn/upload/3-2021/images/2021-09-27/Hot-gymer-que-Nam-dinh-243246464_545703870067336_2725957455927430235_n-1632718734-880-width1242height1286.jpg', N'Trần Bích Hạnh, cô gái trẻ xinh đẹp với thân hình đầy quyến rũ, cô là người sáng lập trung tâm thể dục thể thao iGymer.vn - Thế giới Gymer và huấn luyện viên đào tạo thể dục/tư vấn dinh dưỡng trực tuyến. Nữ gymer này từng có thân hình “quá khổ” với cân nặng đạt ngưỡng 70 kg trong quá khứ. Nhờ vào những nỗ lực của bản thân, Bích Hạnh trở nên nổi tiếng với bài viết giảm cân 27kg thành công, trở thành thần tượng hình thể đáng ngưỡng mộ với số đo 3 vòng 88-57-95.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 28, CAST(N'2024-07-08T01:05:36.8956790' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Nam', N'Hạ Uyên', N'https://kenh14cdn.com/2016/nghieng-nga-voi-than-hinh-san-chac-cua-quy-co-phong-gym-hinh-5-1464596940636.jpg', N'Hạ Uyên - cô gái đồng sở hữu chanel IUF với 120K người theo dõi trên Youtube, chuyên chia sẻ về các video hướng dẫn tập gym cho người mới, những kiến thức, bài tập cơ bản và dễ hiểu cho các bạn có cùng đam mê tập gym. Bên cạnh đó, Uyên cũng thường xuyên chia sẻ những bài tập lên trang cá nhân của mình để truyền lửa cho những người muốn thay đổi bản thân, hướng đến nét đẹp khỏe khắn, hiện đại. Cô cùng người yêu (Harley) cũng chính là cặp đôi nổi đình nổi đám giới gymer nhờ loạt báo về các cặp đôi tập gym hot nhất Việt Nam.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 29, CAST(N'2024-07-08T01:05:36.8956790' AS DateTime2), 100000, 200000, 150000, 120000, N'Cao B?ng', N'Trang Miu', N'https://static.khoedep.vn/2017/07/trang-miu-tap-gym1.jpg', N'Tuy sở hữu chiều cao 1m70 chuẩn người mẫu cực lý tưởng nhưng trước khi trở nên nổi tiếng thì Trang Miu từng luôn tự ti về ngoại hình với vẻ ngoài gầy gò, cao “lêu nghêu” của mình. Nhờ chăm chỉ, nỗ lực tập gym kết hợp cùng chế độ dinh dưỡng lành mạnh, hiện tại cô đã đạt được số đo 3 vòng lý tưởng 82-60-92 và là hình mẫu, tấm gương cho biết bao cô gái có mong ước thay đổi bản thân.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 30, CAST(N'2024-07-08T01:05:36.8966750' AS DateTime2), 100000, 200000, 150000, 120000, N'Ð?ng Nai', N'Khoai Lang Thang', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHN8Pbm8gquL7B2cydQZK2b8Lh0qxZTgrBfg&s', N'Anh chàng Vlog điển trai Khoai Lang Thang chắc hẳn không còn xa lạ đối với những bạn trẻ mê “xê dịch”. Xuất thân từ một sinh viên ngành Kỹ thuật công trình xây dựng, Hoài Phương không tiếp tục phát triển ngành học của mình mà rẽ sang hướng đi là một Vlog về Food và Travel. Khác với Lê Hà Trúc, các video của Khoai Lang Thang chủ yếu tập trung về những chuyến trải nghiệm du lịch, ẩm thực trong nước. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 31, CAST(N'2024-07-08T01:05:36.8976730' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c Ninh', N'Quang Vinh', N'https://vcdn1-giaitri.vnecdn.net/2022/05/19/quangvinhtop1-1652943517-3542-1652946956.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=2hWsXvpZWf-cVHmWX-JcWQ', N'Sau một thời gian dài vắng bóng trên thị trường âm nhạc, Quang Vinh dần chuyển hướng sang con đường Travel Blogger và mang về nhiều thành quả. Các video của anh thường làm về những chuyến du lịch nước ngoài “sang chảnh” với sự đầu tư về hình ảnh vô cùng đẹp mắt, chỉn chu. 

Hoàng tử Sơn Ca sở hữu trang fanpage Facebook với 302K người theo dõi, lượng tương tác đạt trung bình 3353 Interaction/post. Đối tượng khán giả chủ yếu của kênh là từ 18-24 tuổi, trong đó có hơn 82% là nữ, tập trung tại hai thành phố lớn là TP HCM và Hà Nội. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 32, CAST(N'2024-07-08T01:05:36.8976730' AS DateTime2), 100000, 200000, 150000, 120000, N'H?i Duong', N'Trần Quang Đại', N'https://giadinh.mediacdn.vn/2019/8/15/6883302011354841633281146228224456381169664n-15658665921031275565668.jpg', N'Chàng người mẫu 1992 sở hữu gương mặt điển trai, chất giọng ngọt ngào và cách dẫn dắt vô cùng thông minh qua các video du lịch. Hiện tại, Quang Đại sở hữu trang Instagram lung linh với 744K người theo dõi, lượng tương tác đạt trung bình 7258 Interaction/post. Trang fanpage Facebook của anh cũng đạt lượng người theo dõi khổng lồ (806K người) với độ tương tác trung bình là 4331 Interaction/post. ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 33, CAST(N'2024-07-08T01:05:36.8986700' AS DateTime2), 100000, 200000, 150000, 120000, N'B?c Giang', N'Nhị Đặng', N'https://cdn.tcdulichtphcm.vn/upload/4-2021/images/2021-10-20/h--nh-1-nh---------ng-c-----am-m---v---i-nhi---p----nh-1634665255-994-width1664height1664.jpg', N'Nhị Đặng là một Travel Blogger rất quen thuộc đối với những bạn trẻ đam mê du lịch đó đây. Cô tốt nghiệp ngành Marketing nhưng lại sớm rẽ hướng sang con đường Travel Blogger sau một thời gian làm việc văn phòng. Từng đảm nhận công việc Motion Graphic & Video Editing nên những hình ảnh, video của Nhị Đặng luôn đạt chất lượng cao và nhận về vô số lời khen từ người xem. Các video của cô mang hơi hướng trải nghiệm những vùng đất bí ẩn, nhiều trải nghiệm, khám phá và đòi hỏi sức bền cao như: Myanmar, Ai Cập, Ấn Độ, Indonesia… ')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 34, CAST(N'2024-07-08T01:05:36.8986700' AS DateTime2), 100000, 200000, 150000, 120000, N'Nam Ð?nh', N'Lý Thành Cơ', N'https://media.viez.vn/prod/2022/8/19/large_288692944_2085187705240816_8219281950938696108_n_7ded4e1909.jpg', N'Từng được biết đến với thành tích đặt chân đến 30 quốc gia khi chỉ mới 25 tuổi, Lý Thành Cơ sớm trở nên nổi bật trong trong giới Travel Blogger. Anh còn là tác giả của hai quyển sách chia sẻ về trải nghiệm du lịch: “Tuổi trẻ trong ví bạn mua được gì” và cuốn “Thế giới rộng lớn đừng đi một mình”.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 35, CAST(N'2024-07-08T01:05:36.8996860' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Giang', N'Rosie Nguyễn', N'https://bizweb.dktcdn.net/100/363/455/articles/a-nh-chu-p-ma-n-hi-nh-2023-10-13-lu-c-14-58-00.png?v=1697183930690', N'Rosie Nguyễn được xem là hình mẫu về một Travel Blogger trẻ tuổi gắn liền với niềm đam mê đọc sách. Cô nổi tiếng với thành tích đọc 60 quyển sách/năm. Nữ Blogger cũng là tác giả của hai tác phẩm sách nổi tiếng “Ta ba lô trên đất Á”, “Tuổi trẻ đáng giá bao nhiêu?” và thường xuyên đạt “nghìn like” qua những bài chia sẻ về du lịch, cuộc sống trên Facebook.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 36, CAST(N'2024-07-08T01:05:36.8996860' AS DateTime2), 100000, 200000, 150000, 120000, N'H?u Giang', N'Ngô Trần Hải An', N'https://vcdn1-dulich.vnecdn.net/2019/03/05/475795461015677816321475711618-2734-4847-1551797132.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=JIiPBp8lShxP5t-UIp-t4Q', N'Ngô Trần Hải An được mệnh danh là “Quỷ Cốc Tử” với những hành trình khám phá xuyên Việt và đặt chân đến những địa danh nổi tiếng trên khắp thế giới. Anh hiện là một nhà báo, một Travel Blogger và Photographer chuyên nghiệp')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 37, CAST(N'2024-07-08T01:05:36.9006640' AS DateTime2), 100000, 200000, 150000, 120000, N'Hung Yên', N'Trần Đặng Đăng Khoa', N'https://nld.mediacdn.vn/291774122806476800/2022/2/6/16003100102101692803668562895611824525028452n-1644128843620673323353.jpg', N'Cái tên Trần Đặng Đăng Khoa ghi dấu ấn trong làng Travel Blogger với hành trình hơn 1000 ngày “phượt” xe máy đến 65 quốc gia. Khác với những Travel Blogger hiện nay, Đăng Khoa thu hút người xem qua những khung hình chân thật, không qua nhiều công cụ hỗ trợ để giữ được sự tự nhiên nhất cho hành trình của mình')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 38, CAST(N'2024-07-08T01:05:36.9006640' AS DateTime2), 100000, 200000, 150000, 120000, N'Nghệ An', N'Ninh Titô', N'https://marketingai.mediacdn.vn/wp-content/uploads/2019/08/ninhtito.jpeg', N' Là một người Hà Nội chính gốc, nên hầu hết các món ăn anh review đều mang đậm dấu ấn ẩm thực miền Bắc. Sở hữu nhiều tài lẻ, cùng lối dẫn chuyện hài hước, lôi cuốn, không bất ngờ khi Ninh luôn ở sở hữu lượng fan đông đảo trên mạng xã hội. Một điểm nổi bật nữa của Ninh khi so sánh với các Food Blogger khác đó là phong cách thời trang cực chất và trẻ trung.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 39, CAST(N'2024-07-08T01:05:36.9016660' AS DateTime2), 100000, 200000, 150000, 120000, N'Khánh Hòa', N'Ăn sập Sài Gòn', N'https://media.viez.vn/prod/2021/11/3/1635906535711_d1755bcb73.jpeg', N'Danh hiệu “reviewer tâm lý nhất” chắc chắn không thoát khỏi tay của Ăn Sập Sài Gòn. ​Chủ nhân của thương hiệu đình đám này là anh chàng Nguyễn Hoàng Long, hay còn được gọi bằng một cái tên dễ thương khác là Sập. Không những review món ăn như những food blogger thông thường khác, “Sập con’ còn làm hẳn một “food trip” cho từng quận ở TP HCM trên instagram với những hashtag của mình .Ví dụ, chỉ cần search #ansapquan1, kết quả tìm kiếm sẽ xuất hiện hàng ngàn bài viết liên quan. Đây cũng chính là những hashtag phổ biến nhất trên instagram cho lĩnh vực ăn uống.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 40, CAST(N'2024-07-08T01:05:36.9016660' AS DateTime2), 100000, 200000, 150000, 120000, N'Long An', N'The Panda’s Favor', N'https://image.tienphong.vn/w890/uploads/2018/11/5bdbbff289f5f-avatar-600x450.jpg', N'Tại Việt Nam, The Panda’s Favor được coi là ông tổ của nghề food blogger khi anh chính là người đã có công đưa khái niệm “food blogger” trở thành xu thế mới của giới trẻ. Xuất thân là một dân nghiên cứu chính sách cơ - một nghề tưởng chừng như không liên quan tới ẩm thực, tuy nhiên Lê Trung Kiên - “cha đẻ” của The Panda’s Favor lại được biết đến nhiều hơn là một food blogger tinh tế và một food photographer tài năng. Đây cũng chính là lợi thế của anh chàng so với những đồng nghiệp khác khi sở hữu những shoot ảnh “nhìn vào đã thấy thèm”.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (1000, 1, 41, CAST(N'2024-07-08T01:05:36.9026590' AS DateTime2), 100000, 200000, 150000, 120000, N'Hà Tinh', N'No Food Phobia', N'https://nofoodphobia.com/wp-content/uploads/2021/07/210359807_4240322769336270_1460110364997652266_n.jpg', N'Nếu là một tín đồ của streetfood, chắc chắn bạn không nên bỏ qua cô nàng này. Đây chính là một trong những food blogger đời đầu, khi mà những bài viết review đồ ăn đầu tiên của cô đã xuất hiện từ … năm 2015. Cũng giống như Ninh Titô, Vũ Mỹ Linh (tên thật của cô nàng) là người Hà Nội chính gốc, vì thế cô bạn luôn có đam mê với những món ăn truyền thống của Thủ Đô. Khảo sát cũng cho thấy, có đến 87.14% fan của cô nàng đến từ Hà Nội.')
INSERT [dbo].[profile] ([money], [rating], [user_id], [birthday], [priceapost], [priceato_hireaday], [priceavideo], [representative_price], [location], [full_name], [avatar_url], [bio]) VALUES (0, 0, 42, NULL, 12312, 123123, 123123, 123123, N'Cà Mau', N'Ho Tuan Vu', N'https://png.pngtree.com/element_our/20200610/ourlarge/pngtree-default-avatar-image_2237213.jpg', N'123123')
GO
SET IDENTITY_INSERT [dbo].[profile_categories] ON 

INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 1, 2)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (2, 2, 15)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 5, 3)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 7, 4)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 8, 5)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 9, 6)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 10, 7)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 11, 8)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 12, 9)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 13, 10)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 14, 11)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 15, 12)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 16, 13)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (1, 17, 14)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (2, 18, 16)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (2, 19, 17)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (2, 20, 18)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (2, 21, 19)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 22, 20)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 23, 21)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 24, 22)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 25, 23)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 26, 24)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 27, 25)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 28, 26)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 29, 27)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 30, 28)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (3, 31, 29)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 32, 14)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 33, 30)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 34, 31)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 35, 32)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 36, 33)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 37, 34)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 38, 35)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 39, 36)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (4, 40, 37)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (5, 41, 38)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (5, 42, 39)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (5, 43, 40)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (5, 44, 30)
INSERT [dbo].[profile_categories] ([category_id], [id], [user_id]) VALUES (5, 45, 41)
SET IDENTITY_INSERT [dbo].[profile_categories] OFF
GO
SET IDENTITY_INSERT [dbo].[request_representatives] ON 

INSERT [dbo].[request_representatives] ([id], [months], [request_id], [end_date], [start_date]) VALUES (1, 3, 2, CAST(N'2024-11-09T17:00:00.0000000' AS DateTime2), CAST(N'2024-08-09T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[request_representatives] ([id], [months], [request_id], [end_date], [start_date]) VALUES (2, 3, 5, CAST(N'2024-11-09T17:00:00.0000000' AS DateTime2), CAST(N'2024-08-09T17:00:00.0000000' AS DateTime2))
INSERT [dbo].[request_representatives] ([id], [months], [request_id], [end_date], [start_date]) VALUES (3, 3, 7, CAST(N'2024-11-01T17:00:00.0000000' AS DateTime2), CAST(N'2024-08-01T17:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[request_representatives] OFF
GO
SET IDENTITY_INSERT [dbo].[requests] ON 

INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 2200000, 1, 2, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), NULL, N'Đà Nẵng', N'- Làm PG quán nhậu trong mấy ngày trên', N'HIREBYDAY', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 120000, 2, 2, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), N'An Giang', N'- Làm đại sứ thương hiệu cho mĩ phẫm blabla', N'REPRESENTATIVE', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 800000, 3, 2, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), NULL, N'An Giang', N'-123123123', N'HIREBYDAY', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 800000, 4, 0, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2), N'An Giang', N'sadasdasd', N'HIREBYDAY', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (0, 120000, 5, 0, 0, 1, 2, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-11-09T17:00:00.0000000' AS DateTime2), N'An Giang', N'sdfsdf', N'REPRESENTATIVE', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (1, 11, 6, 0, 0, 1, NULL, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-07-30T17:00:00.0000000' AS DateTime2), N'An Giang', N'asdfaf', N'HIREBYDAY', NULL)
INSERT [dbo].[requests] ([is_public], [payment], [request_id], [request_status], [requester_confirm], [requester_id], [responder_id], [responer_confirm], [request_date], [request_date_end], [request_location], [request_description], [request_type], [result_link]) VALUES (1, 11, 7, 0, 0, 1, NULL, 0, CAST(N'2024-07-07T17:00:00.0000000' AS DateTime2), CAST(N'2024-11-01T17:00:00.0000000' AS DateTime2), N'An Giang', N'sdfsdf', N'REPRESENTATIVE', NULL)
SET IDENTITY_INSERT [dbo].[requests] OFF
GO
SET IDENTITY_INSERT [dbo].[transactionhistory] ON 

INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type], [system-income]) VALUES (1, NULL, NULL, 1, 10000000, 1, CAST(N'2024-07-08T02:16:40.0000000' AS DateTime2), N'14498672', N'PAY_IN', NULL)
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type], [system-income]) VALUES (2, 1, 1, 2, 2200000, 1, CAST(N'2024-07-08T02:42:16.2680000' AS DateTime2), NULL, N'PAY_FOR', NULL)
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type], [system-income]) VALUES (2, 2, 1, 3, 120000, 1, CAST(N'2024-07-08T03:41:27.8720000' AS DateTime2), NULL, N'PAY_FOR', NULL)
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type], [system-income]) VALUES (2, 3, 1, 6, 800000, 1, CAST(N'2024-07-08T02:57:26.0430000' AS DateTime2), NULL, N'PAY_FOR', NULL)
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type], [system-income]) VALUES (2, 4, 1, 7, 800000, 0, CAST(N'2024-07-08T03:24:07.4610000' AS DateTime2), NULL, N'PAY_FOR', NULL)
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type], [system-income]) VALUES (2, 5, 1, 8, 120000, 0, CAST(N'2024-07-08T03:24:25.9120000' AS DateTime2), NULL, N'PAY_FOR', NULL)
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type], [system-income]) VALUES (NULL, 6, 1, 9, 11, 0, CAST(N'2024-07-08T04:00:14.1800000' AS DateTime2), NULL, N'PAY_FOR', NULL)
INSERT [dbo].[transactionhistory] ([receiver_id], [request_id], [sender_id], [trans_id], [trans_payment], [trans_status], [trans_time], [transaction_id], [type], [system-income]) VALUES (NULL, 7, 1, 10, 11, 0, CAST(N'2024-07-08T04:00:39.4910000' AS DateTime2), NULL, N'PAY_FOR', NULL)
SET IDENTITY_INSERT [dbo].[transactionhistory] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1559978, 0, 1, N'OTHER', CAST(N'2024-07-07T18:01:27.9050000' AS DateTime2), N'USER', N'user', NULL, N'111111', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (7521000, 0, 2, N'FEMALE', CAST(N'2024-07-08T01:05:36.8817140' AS DateTime2), N'KOL', N'user1', N'user1@example.com', N'123123', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 3, N'MALE', CAST(N'2024-07-08T01:05:36.8827180' AS DateTime2), N'KOL', N'user2', N'user2@example.com', N'1', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 4, N'FEMALE', CAST(N'2024-07-08T01:05:36.8837100' AS DateTime2), N'KOL', N'user3', N'user3@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 5, N'MALE', CAST(N'2024-07-08T01:05:36.8837100' AS DateTime2), N'KOL', N'user4', N'user4@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 6, N'FEMALE', CAST(N'2024-07-08T01:05:36.8847080' AS DateTime2), N'KOL', N'user5', N'user5@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 7, N'MALE', CAST(N'2024-07-08T01:05:36.8847080' AS DateTime2), N'KOL', N'user6', N'user6@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 8, N'FEMALE', CAST(N'2024-07-08T01:05:36.8857030' AS DateTime2), N'KOL', N'user7', N'user7@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 9, N'MALE', CAST(N'2024-07-08T01:05:36.8857030' AS DateTime2), N'KOL', N'user8', N'user8@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 10, N'FEMALE', CAST(N'2024-07-08T01:05:36.8867020' AS DateTime2), N'KOL', N'user9', N'user9@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 11, N'MALE', CAST(N'2024-07-08T01:05:36.8867020' AS DateTime2), N'KOL', N'user10', N'user10@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 12, N'FEMALE', CAST(N'2024-07-08T01:05:36.8877000' AS DateTime2), N'KOL', N'user11', N'user11@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 13, N'MALE', CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), N'KOL', N'user12', N'user12@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 14, N'FEMALE', CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), N'KOL', N'user13', N'user13@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 15, N'MALE', CAST(N'2024-07-08T01:05:36.8886970' AS DateTime2), N'KOL', N'user14', N'user14@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 16, N'FEMALE', CAST(N'2024-07-08T01:05:36.8896930' AS DateTime2), N'KOL', N'user15', N'user15@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 17, N'MALE', CAST(N'2024-07-08T01:05:36.8896930' AS DateTime2), N'KOL', N'user16', N'user16@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 18, N'FEMALE', CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), N'KOL', N'user17', N'user17@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 19, N'MALE', CAST(N'2024-07-08T01:05:36.8906900' AS DateTime2), N'KOL', N'user18', N'user18@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 20, N'FEMALE', CAST(N'2024-07-08T01:05:36.8916900' AS DateTime2), N'KOL', N'user19', N'user19@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 21, N'MALE', CAST(N'2024-07-08T01:05:36.8916900' AS DateTime2), N'KOL', N'user20', N'user20@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 22, N'FEMALE', CAST(N'2024-07-08T01:05:36.8926870' AS DateTime2), N'KOL', N'user21', N'user21@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 23, N'MALE', CAST(N'2024-07-08T01:05:36.8926870' AS DateTime2), N'KOL', N'user22', N'user22@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 24, N'FEMALE', CAST(N'2024-07-08T01:05:36.8936850' AS DateTime2), N'KOL', N'user23', N'user23@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 25, N'MALE', CAST(N'2024-07-08T01:05:36.8936850' AS DateTime2), N'KOL', N'user24', N'user24@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 26, N'FEMALE', CAST(N'2024-07-08T01:05:36.8946820' AS DateTime2), N'KOL', N'user25', N'user25@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 27, N'MALE', CAST(N'2024-07-08T01:05:36.8946820' AS DateTime2), N'KOL', N'user26', N'user26@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 28, N'FEMALE', CAST(N'2024-07-08T01:05:36.8956790' AS DateTime2), N'KOL', N'user27', N'user27@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 29, N'MALE', CAST(N'2024-07-08T01:05:36.8956790' AS DateTime2), N'KOL', N'user28', N'user28@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 30, N'FEMALE', CAST(N'2024-07-08T01:05:36.8966750' AS DateTime2), N'KOL', N'user29', N'user29@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 31, N'MALE', CAST(N'2024-07-08T01:05:36.8966750' AS DateTime2), N'KOL', N'user30', N'user30@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 32, N'FEMALE', CAST(N'2024-07-08T01:05:36.8976730' AS DateTime2), N'KOL', N'user31', N'user31@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 33, N'MALE', CAST(N'2024-07-08T01:05:36.8986700' AS DateTime2), N'KOL', N'user32', N'user32@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 34, N'FEMALE', CAST(N'2024-07-08T01:05:36.8986700' AS DateTime2), N'KOL', N'user33', N'user33@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 35, N'MALE', CAST(N'2024-07-08T01:05:36.8996860' AS DateTime2), N'KOL', N'user34', N'user34@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 36, N'FEMALE', CAST(N'2024-07-08T01:05:36.8996860' AS DateTime2), N'KOL', N'user35', N'user35@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 37, N'MALE', CAST(N'2024-07-08T01:05:36.9006640' AS DateTime2), N'KOL', N'user36', N'user36@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 38, N'FEMALE', CAST(N'2024-07-08T01:05:36.9006640' AS DateTime2), N'KOL', N'user37', N'user37@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 39, N'MALE', CAST(N'2024-07-08T01:05:36.9016660' AS DateTime2), N'KOL', N'user38', N'user38@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 40, N'FEMALE', CAST(N'2024-07-08T01:05:36.9016660' AS DateTime2), N'KOL', N'user39', N'user39@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (1000, 0, 41, N'MALE', CAST(N'2024-07-08T01:05:36.9026590' AS DateTime2), N'KOL', N'user40', N'user40@example.com', N'$2a$10$26/42gUtbxTA0UnK4C5GIu1bsYLdMcKz2MEBugr3Pslm0asJJRSLq', NULL)
INSERT [dbo].[users] ([account_balance], [is_locked], [user_id], [gender], [create_at], [what_role], [username], [email], [password_hash], [reset_password_token]) VALUES (0, 0, 42, N'MALE', CAST(N'2024-07-11T11:27:20.0120000' AS DateTime2), N'USER', N'Htv22122004@gmail.com', NULL, N'$2a$10$BqCGFzCnfyVrU9VDxbP/Lejxg2/KfWba0uFdcl5SVUnU9RpEv6hIW', NULL)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
/****** Object:  Index [UK_pmrngec2vywy21t6i3y64i0pv]    Script Date: 12/7/2024 12:28:24 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_pmrngec2vywy21t6i3y64i0pv] ON [dbo].[request_representatives]
(
	[request_id] ASC
)
WHERE ([request_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_ftaruaeajpk9sdcbipf9y57em]    Script Date: 12/7/2024 12:28:24 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_ftaruaeajpk9sdcbipf9y57em] ON [dbo].[transactionhistory]
(
	[transaction_id] ASC
)
WHERE ([transaction_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_qwdhbpj6th5m3kmaldn6mcnor]    Script Date: 12/7/2024 12:28:24 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_qwdhbpj6th5m3kmaldn6mcnor] ON [dbo].[transactionhistory]
(
	[request_id] ASC
)
WHERE ([request_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_r43af9ap4edm43mmtq01oddj6]    Script Date: 12/7/2024 12:28:24 AM ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [UK_r43af9ap4edm43mmtq01oddj6] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_6dotkott2kjsp8vw4d0m25fb7]    Script Date: 12/7/2024 12:28:24 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_6dotkott2kjsp8vw4d0m25fb7] ON [dbo].[users]
(
	[email] ASC
)
WHERE ([email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FKawn9hd2qnh51bbt1ss1fonejl] FOREIGN KEY([receiver_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FKawn9hd2qnh51bbt1ss1fonejl]
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD  CONSTRAINT [FKgaxm9ywyh7xh7qvsjfjwe9s5f] FOREIGN KEY([commenter_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[comment] CHECK CONSTRAINT [FKgaxm9ywyh7xh7qvsjfjwe9s5f]
GO
ALTER TABLE [dbo].[commentviolation]  WITH CHECK ADD  CONSTRAINT [FK1512dftkac1r5b6i4o1yl82gl] FOREIGN KEY([comment_id])
REFERENCES [dbo].[comment] ([comment_id])
GO
ALTER TABLE [dbo].[commentviolation] CHECK CONSTRAINT [FK1512dftkac1r5b6i4o1yl82gl]
GO
ALTER TABLE [dbo].[commentviolation]  WITH CHECK ADD  CONSTRAINT [FKm26fqehse4g7rel1vdro1nxfv] FOREIGN KEY([word_id])
REFERENCES [dbo].[violationwords] ([word_id])
GO
ALTER TABLE [dbo].[commentviolation] CHECK CONSTRAINT [FKm26fqehse4g7rel1vdro1nxfv]
GO
ALTER TABLE [dbo].[day_request]  WITH CHECK ADD  CONSTRAINT [FKnjlvfr93jqftab5rrdv3ktu9u] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[day_request] CHECK CONSTRAINT [FKnjlvfr93jqftab5rrdv3ktu9u]
GO
ALTER TABLE [dbo].[media_profile]  WITH CHECK ADD  CONSTRAINT [FK3xru5lnhu6gdtn5u9xfi02o5s] FOREIGN KEY([profile_id])
REFERENCES [dbo].[profile] ([user_id])
GO
ALTER TABLE [dbo].[media_profile] CHECK CONSTRAINT [FK3xru5lnhu6gdtn5u9xfi02o5s]
GO
ALTER TABLE [dbo].[notification]  WITH CHECK ADD  CONSTRAINT [FKnk4ftb5am9ubmkv1661h15ds9] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[notification] CHECK CONSTRAINT [FKnk4ftb5am9ubmkv1661h15ds9]
GO
ALTER TABLE [dbo].[profile]  WITH CHECK ADD  CONSTRAINT [FKs14jvsf9tqrcnly0afsv0ngwv] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[profile] CHECK CONSTRAINT [FKs14jvsf9tqrcnly0afsv0ngwv]
GO
ALTER TABLE [dbo].[profile_categories]  WITH CHECK ADD  CONSTRAINT [FKfaeiqns6dbmacis0ly2s5o6ia] FOREIGN KEY([user_id])
REFERENCES [dbo].[profile] ([user_id])
GO
ALTER TABLE [dbo].[profile_categories] CHECK CONSTRAINT [FKfaeiqns6dbmacis0ly2s5o6ia]
GO
ALTER TABLE [dbo].[profile_categories]  WITH CHECK ADD  CONSTRAINT [FKi15awrec4bbbjej2fbaan3o1h] FOREIGN KEY([category_id])
REFERENCES [dbo].[categoriesinfo] ([category_id])
GO
ALTER TABLE [dbo].[profile_categories] CHECK CONSTRAINT [FKi15awrec4bbbjej2fbaan3o1h]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FK1dw2gwqqspkllnye2ylaiabqx] FOREIGN KEY([comment_id])
REFERENCES [dbo].[comment] ([comment_id])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FK1dw2gwqqspkllnye2ylaiabqx]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FK88cok9gyod0nrsbwg18mi66v6] FOREIGN KEY([report_user])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FK88cok9gyod0nrsbwg18mi66v6]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FKhxlcmvsqq4b3jawr0mtplwads] FOREIGN KEY([reported_user])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FKhxlcmvsqq4b3jawr0mtplwads]
GO
ALTER TABLE [dbo].[request_categories]  WITH CHECK ADD  CONSTRAINT [FK5cxp1dglvxvjc9o5ppafb4wn7] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[request_categories] CHECK CONSTRAINT [FK5cxp1dglvxvjc9o5ppafb4wn7]
GO
ALTER TABLE [dbo].[request_categories]  WITH CHECK ADD  CONSTRAINT [FKl1thwnslpbm7q5wvxkh41rdb] FOREIGN KEY([category_id])
REFERENCES [dbo].[categoriesinfo] ([category_id])
GO
ALTER TABLE [dbo].[request_categories] CHECK CONSTRAINT [FKl1thwnslpbm7q5wvxkh41rdb]
GO
ALTER TABLE [dbo].[request_representatives]  WITH CHECK ADD  CONSTRAINT [FKmvgcq5h6429ow0tuwrdkf8djs] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[request_representatives] CHECK CONSTRAINT [FKmvgcq5h6429ow0tuwrdkf8djs]
GO
ALTER TABLE [dbo].[request_wait_list]  WITH CHECK ADD  CONSTRAINT [FKixedg52nfrc6dyhtvgik1ii9] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[request_wait_list] CHECK CONSTRAINT [FKixedg52nfrc6dyhtvgik1ii9]
GO
ALTER TABLE [dbo].[request_wait_list]  WITH CHECK ADD  CONSTRAINT [FKt7jq5crr6hhm57jt56a0yd482] FOREIGN KEY([responder_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[request_wait_list] CHECK CONSTRAINT [FKt7jq5crr6hhm57jt56a0yd482]
GO
ALTER TABLE [dbo].[requests]  WITH CHECK ADD  CONSTRAINT [FK61tiajfpj7rnd6vfffouni3ia] FOREIGN KEY([responder_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[requests] CHECK CONSTRAINT [FK61tiajfpj7rnd6vfffouni3ia]
GO
ALTER TABLE [dbo].[requests]  WITH CHECK ADD  CONSTRAINT [FKeoax2t4j9i61p9lmon3009tr4] FOREIGN KEY([requester_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[requests] CHECK CONSTRAINT [FKeoax2t4j9i61p9lmon3009tr4]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FKdn5svbxyacce1gpfiawk7iqtc] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FKdn5svbxyacce1gpfiawk7iqtc]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FKph5lnau95vs8pq7o11kutc9p9] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FKph5lnau95vs8pq7o11kutc9p9]
GO
ALTER TABLE [dbo].[tb_message]  WITH CHECK ADD  CONSTRAINT [FKel1jtd3x1iohuxaqfi5x1do4e] FOREIGN KEY([sender_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[tb_message] CHECK CONSTRAINT [FKel1jtd3x1iohuxaqfi5x1do4e]
GO
ALTER TABLE [dbo].[tb_message]  WITH CHECK ADD  CONSTRAINT [FKmc1gpglhvtqepa1nwgdggkbew] FOREIGN KEY([conversation_id])
REFERENCES [dbo].[tb_conversation] ([id])
GO
ALTER TABLE [dbo].[tb_message] CHECK CONSTRAINT [FKmc1gpglhvtqepa1nwgdggkbew]
GO
ALTER TABLE [dbo].[tb_message]  WITH CHECK ADD  CONSTRAINT [FKr6x5njynwtyqw7p2slacvr6af] FOREIGN KEY([recipient_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[tb_message] CHECK CONSTRAINT [FKr6x5njynwtyqw7p2slacvr6af]
GO
ALTER TABLE [dbo].[transactionhistory]  WITH CHECK ADD  CONSTRAINT [FK3k6vj5im7dye9gjxwaais1av4] FOREIGN KEY([receiver_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[transactionhistory] CHECK CONSTRAINT [FK3k6vj5im7dye9gjxwaais1av4]
GO
ALTER TABLE [dbo].[transactionhistory]  WITH CHECK ADD  CONSTRAINT [FK45q09bwlpjs04ay8bm0i1sqq3] FOREIGN KEY([request_id])
REFERENCES [dbo].[requests] ([request_id])
GO
ALTER TABLE [dbo].[transactionhistory] CHECK CONSTRAINT [FK45q09bwlpjs04ay8bm0i1sqq3]
GO
ALTER TABLE [dbo].[transactionhistory]  WITH CHECK ADD  CONSTRAINT [FKikp5febooy027fkrg8fttk3w4] FOREIGN KEY([sender_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[transactionhistory] CHECK CONSTRAINT [FKikp5febooy027fkrg8fttk3w4]
GO
ALTER TABLE [dbo].[user_conversation]  WITH CHECK ADD  CONSTRAINT [FK1ku1u4d2bmps059vypee7c702] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_conversation] CHECK CONSTRAINT [FK1ku1u4d2bmps059vypee7c702]
GO
ALTER TABLE [dbo].[user_conversation]  WITH CHECK ADD  CONSTRAINT [FKlmaq6skixvxsqglg8b2osni5x] FOREIGN KEY([conversation_id])
REFERENCES [dbo].[tb_conversation] ([id])
GO
ALTER TABLE [dbo].[user_conversation] CHECK CONSTRAINT [FKlmaq6skixvxsqglg8b2osni5x]
GO
ALTER TABLE [dbo].[notification]  WITH CHECK ADD CHECK  (([type]='SUBMIT' OR [type]='REQUEST' OR [type]='ACCEPT_REQUEST' OR [type]='JOIN_REQUEST' OR [type]='MONEY' OR [type]='ACCOUNT'))
GO
ALTER TABLE [dbo].[requests]  WITH CHECK ADD CHECK  (([request_status]>=(0) AND [request_status]<=(3)))
GO
ALTER TABLE [dbo].[tb_conversation]  WITH CHECK ADD CHECK  (([type]='GROUP' OR [type]='PRIVATE'))
GO
ALTER TABLE [dbo].[transactionhistory]  WITH CHECK ADD CHECK  (([type]='PAY_FOR' OR [type]='PAY_IN'))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([gender]='OTHER' OR [gender]='FEMALE' OR [gender]='MALE'))
GO
USE [master]
GO
ALTER DATABASE [SWP391] SET  READ_WRITE 
GO

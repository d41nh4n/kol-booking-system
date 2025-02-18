USE [master]
GO
/****** Object:  Database [SWP391]    Script Date: 7/8/2024 12:46:17 AM ******/
CREATE DATABASE [SWP391]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SWP391', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SWP391.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SWP391_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SWP391_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[categoriesinfo]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[comment]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[commentviolation]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[day_request]    Script Date: 7/8/2024 12:46:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[day_request](
	[request_id] [int] NOT NULL,
	[day_request] [datetime2](6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[media_profile]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[notification]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[profile]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[profile_categories]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[report]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[request_categories]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[request_representatives]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[request_wait_list]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[requests]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[schedule]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[tb_conversation]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[tb_message]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[tb_verifycode]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[transactionhistory]    Script Date: 7/8/2024 12:46:17 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[trans_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_conversation]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 7/8/2024 12:46:17 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_r43af9ap4edm43mmtq01oddj6] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[violationwords]    Script Date: 7/8/2024 12:46:17 AM ******/
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
/****** Object:  Index [UK_pmrngec2vywy21t6i3y64i0pv]    Script Date: 7/8/2024 12:46:17 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_pmrngec2vywy21t6i3y64i0pv] ON [dbo].[request_representatives]
(
	[request_id] ASC
)
WHERE ([request_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_ftaruaeajpk9sdcbipf9y57em]    Script Date: 7/8/2024 12:46:17 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_ftaruaeajpk9sdcbipf9y57em] ON [dbo].[transactionhistory]
(
	[transaction_id] ASC
)
WHERE ([transaction_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_qwdhbpj6th5m3kmaldn6mcnor]    Script Date: 7/8/2024 12:46:17 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_qwdhbpj6th5m3kmaldn6mcnor] ON [dbo].[transactionhistory]
(
	[request_id] ASC
)
WHERE ([request_id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_6dotkott2kjsp8vw4d0m25fb7]    Script Date: 7/8/2024 12:46:17 AM ******/
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

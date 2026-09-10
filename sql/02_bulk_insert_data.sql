-- ============================================================
-- Bulk Insert Olist CSVs into their matching tables
-- Update the file path below to match your local folder
-- ============================================================

USE EcommerceAnalysis;
GO

BULK INSERT olist_customers_dataset
FROM 'C:\YOUR\FOLDER\PATH\olist_customers_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

BULK INSERT olist_orders_dataset
FROM 'C:\YOUR\FOLDER\PATH\olist_orders_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

BULK INSERT olist_order_items_dataset
FROM 'C:\YOUR\FOLDER\PATH\olist_order_items_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

BULK INSERT olist_order_payments_dataset
FROM 'C:\YOUR\FOLDER\PATH\olist_order_payments_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

BULK INSERT olist_products_dataset
FROM 'C:\YOUR\FOLDER\PATH\olist_products_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

BULK INSERT olist_sellers_dataset
FROM 'C:\YOUR\FOLDER\PATH\olist_sellers_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

BULK INSERT olist_geolocation_dataset
FROM 'C:\YOUR\FOLDER\PATH\olist_geolocation_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

BULK INSERT product_category_name_translation
FROM 'C:\YOUR\FOLDER\PATH\product_category_name_translation.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

-- Note: olist_order_reviews_dataset was excluded from this project due to
-- multi-line text in the review_comment_message column, which is incompatible
-- with standard BULK INSERT. See README for details.

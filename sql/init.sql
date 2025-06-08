DELETE 
FROM
      top_br_youtubers_2024;

BULK INSERT top_br_youtubers_2024
FROM 'updated_youtube_data_BR.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001' -- Para UTF-8, se necessário
);
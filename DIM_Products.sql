-- Cleansed Dim_Product Table --
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] as ProductItemCode, 
  --[ProductSubcategoryKey], 
  --[WeightUnitMeasureCode], 
 -- [SizeUnitMeasureCode], 
  p.[EnglishProductName] as ProductName, 
  ps.EnglishProductSubcategoryName as SubCategory,
  pc.EnglishProductCategoryName as [Product Category],
 -- [SpanishProductName], 
  --[FrenchProductName], 
  --[StandardCost], 
  --[FinishedGoodsFlag], 
  p.[Color] as [Product Color], 
  --[SafetyStockLevel], 
 -- [ReorderPoint], 
  --[ListPrice], 
  p.[Size] as [Product Size], 
  --[SizeRange], 
  --[Weight], 
  --[DaysToManufacture], 
  p.[ProductLine] as [Product Line], 
 -- [DealerPrice], 
 -- [Class], 
  --[Style], 
  p.[ModelName] as [Product Model Name], 
 -- [LargePhoto], 
  p.[EnglishDescription] as [Product Description],  
  --[FrenchDescription], 
  --[ChineseDescription], 
  --[ArabicDescription], 
  --[HebrewDescription], 
  --[ThaiDescription], 
--  [GermanDescription], 
 -- [JapaneseDescription], 
 -- [TurkishDescription], 
 -- [StartDate], 
  --[EndDate], 
  ISNULL(p.status, 'Outdated') as [Product Status]
FROM 
  [AdventureWorksDW2019].[dbo].[DimProduct] as p
  LEFT JOIN dbo.DimProductSubcategory as ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory as pc 
	ON ps.ProductCategoryKey = pc.ProductCategoryKey

ORDER BY ProductKey 

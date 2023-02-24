-- Cleansed Dim_Customer Table --
SELECT 
[CustomerKey], 
--[GeographyKey], 
--[CustomerAlternateKey], 
--[Title], 
c.firstname as [FirstName], 
--[MiddleName], 
c.lastname as [LastName], 
c.FirstName + ' ' + c.LastName as [Fullname],
--[NameStyle], 
--[BirthDate], 
--[MaritalStatus], 
--[Suffix], 
CASE c.gender 
	WHEN 'M' THEN 'Male'
	WHEN 'F' THEN 'FEMALE'
	END AS [Gender], 
--[EmailAddress], 
--[YearlyIncome], 
--[TotalChildren], 
--[NumberChildrenAtHome], 
--[EnglishEducation], 
--[SpanishEducation], 
--[FrenchEducation], 
--[EnglishOccupation], 
--[SpanishOccupation], 
--[FrenchOccupation], 
--[HouseOwnerFlag], 
--[NumberCarsOwned], 
--[AddressLine1], 
--[AddressLine2], 
--[Phone], 
c.DateFirstPurchase as DateFirstPurchase,
--[CommuteDistance] 
g.city as CustomerCity
FROM 
  [AdventureWorksDW2019].[dbo].[DimCustomer] as c
  LEFT JOIN dbo.DimGeography as g
  ON c.GeographyKey = g.GeographyKey
  Order by CustomerKey ASC


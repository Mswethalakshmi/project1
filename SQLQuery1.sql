SELECT *
FROM supply_chain_data

--Revenue
SELECT  CAST(SUM("Revenue_generated") 
	    AS DECIMAL(8,2))Revenue 
FROM supply_chain_data;
	
	
--Revenue generated by product
SELECT "product_type", CAST(SUM("Revenue_generated") 
        AS DECIMAL(8,2))Revenue 
FROM supply_chain_data
GROUP BY "product_type"

--Revenue By Location
SELECT 
	location, 
	CAST(SUM("Revenue_generated") 
	AS DECIMAL(8,2))Revenue 
FROM supply_chain_data
GROUP BY location

--Revenue Contribution Percentage
SELECT 
      location, 
	  CAST(SUM("Revenue_generated") 
	  AS DECIMAL (8,2))"Revenue",
	  CAST(SUM("Revenue_generated")*100/(SELECT SUM("Revenue_generated") FROM supply_chain_data) 
	  AS DECIMAL(4,2))'%Revenue Contribution'
FROM supply_chain_data
GROUP BY location

--Calculating Total Quantity 
SELECT 
	SUM([Order_quantities]) as Quantity
FROM supply_chain_data


--Quantity By Location
SELECT 
      location, 
      SUM("Order_quantities") as "Order Quantities"
FROM supply_chain_data
GROUP BY location


--Quantity Sold by Product Type
SELECT 
      "product_type", 
      SUM("Order_quantities") as "product Quantities"
FROM supply_chain_data
GROUP BY product_type

--Stock Levels & lead Times
SELECT 
      SUM("stock_levels")as "Stock Levels", 
      SUM("Lead_Times")as "Lead Times" 
FROM supply_chain_data


--Most Common Routes Used 
SELECT 
      MAX("Routes")as "Route"
FROM supply_chain_data


SELECT TRY_CONVERT(float,[Costs]) as costs
FROM supply_chain_data

SELECT "product_type",
	CAST(SUM("Revenue_generated")
      AS DECIMAL(8,2))Total_Revenue,
	CAST(SUM(TRY_CONVERT(float,[Costs])) 
		  AS DECIMAL(7,2))costs
FROM supply_chain_data
GROUP by "product_type"


--Average Leadtime
SELECT
	  "Product_type",
      CAST((SUM("Lead_times")/COUNT("Lead_times")) 
      AS DECIMAL(4,2))"Average_Leadtime"
FROM supply_chain_data
GROUP BY "product_type"


--How Leadtime Affects Stock Levels and Availability 
 SELECT 
       SUM("Lead_Times")"Lead Times", 
       SUM("Stock_levels")"Stock Levels",
	   SUM("Availability")"Availability" 
FROM supply_chain_data

--Most Common Transport Modes Used 
SELECT 
      MAX("Transportation_modes")"Transportation Modes"
FROM supply_chain_data

--Correlation Between Inspection Result and Defect Rate */ 
SELECT 
      "Inspection_results",
      CAST(SUM("Defect_rates") 
      AS DECIMAL(4,2))"Defect Rates", 
      CAST(SUM("Defect_rates")*100/(SELECT SUM("Defect_rates") FROM supply_chain_data) 
      AS DECIMAL(4,2)) "%Of Defect Rate",
      CAST(SUM("Defect_rates")/count("Defect_rates") 
      AS DECIMAL(3,2))"Average Defect Rate"
FROM supply_chain_data
GROUP BY "Inspection_results"


--Impact of Different Routes on Costs and Lead Times 
SELECT 
      "Routes", 
      SUM("Lead_times")"Lead Times", 
      CAST(SUM(TRY_CONVERT(float,[Costs]))AS
      DECIMAL(8,2))"Cost"
FROM supply_chain_data
GROUP BY "Routes"


--Average Defect Rate For Each Product */
SELECT 
      "product_type", 
      CAST(SUM("Defect_rates")/COUNT("Defect_rates") 
      AS DECIMAL (3,2))"Average Defect Rate" 
FROM supply_chain_data
GROUP BY "product_type"


--Correlation of Inspection Result and Manufacturing Cost */ 
SELECT 
     "Inspection_results", 
      CAST(SUM("Manufacturing_costs") 
      AS DECIMAL(6,2))"Manufacturing Costs", 
      CAST((SUM("Manufacturing_costs")*100/(SELECT SUM("Manufacturing_costs") FROM supply_chain_data))
      AS DECIMAL(4,2))"%Manufacturing Costs" 
FROM supply_chain_data
GROUP BY "Inspection_results"

--Percentage of Production Volumes Alinged With Market Demands 
SELECT 
      "Location", 
      SUM("Production_volumes")"Production Volume",
	  (SUM("Production_volumes")*100/(SELECT SUM("Production_volumes")FROM supply_chain_data))"%ProductionVolume"
FROM supply_chain_data
GROUP BY "Location"

--Current Stock Levels
SELECT "product_type",
	SUM("Stock_levels") AS Current_Stock 
FROM supply_chain_data 
GROUP BY "product_type"

SELECT "product_type", 
	(SUM([Number_of_products_sold]) / AVG("Stock_levels")) AS Stock_Turnover_Rate 
FROM  supply_chain_data
GROUP BY "product_type"

-- reorder point 
SELECT "product_type", 
	MIN([Stock_levels]) AS Reorder_Point 
FROM supply_chain_data 
WHERE [Stock_levels]< 50 
GROUP BY "product_type"

--Safety Stock
SELECT "product_type", 
	AVG([Stock_levels]) * 0.1 AS Safety_Stock
FROM supply_chain_data
GROUP BY "product_type"

--Total Shipping Costs
SELECT SUM([Shipping_costs]) AS Total_Shipping_Cost 
FROM supply_chain_data


SELECT [Location],
	SUM([Shipping_costs])Total_Shipping_Cost 
FROM supply_chain_data 
GROUP BY [Location]

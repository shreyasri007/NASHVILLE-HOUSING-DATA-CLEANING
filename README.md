 #   NASHVILLE HOUSING :  DATA CLEANING & ANALYSIS 

![midtown-nashville-real-estate](https://github.com/shreyasri007/Nashville-Housing-Data-Cleaning/assets/132162991/2c168002-ac37-4e81-81c0-2489785b3a9a)



## INTRODUCTION
In this project, I worked with Nashville Housing Data, a dataset containing statistics about landuse and properties in **Nashville,** the capital city of the U.S. state of Tennessee.
It is a data cleaning and transformation project on the Nashville Housing data using Microsoft SQL Management Server Studio.

##  UNDERSTANDING THE DATA
The dataset contains 19 columns and 56,477 rows of the Nashville Housing Data which are as follows -
-   UniqueID — id number attributed to a buyer.
-   ParcelID — code attributed to a land.
-   LandUse — shows the different uses of land.
-   SalesPrice — cost of land
-   LegalReference — citation is the practice of crediting and referring to authoritative documents and sources.
-   OwnerName --- name of land owner
-   Acreage — the size of an area of land in acres
-   LandValue — the worth of the land
-   Building Value — worth of a building
-   Total Value — Landvalue + building value
-   YearBuilt — year the building was built
-   FullBath —  a bathroom that includes a shower, a bathtub, a sink, and a toilet.
-   HalfBath — a half bathroom only contains a sink and a toilet
-   Sale_Date — date when the land was sold
-   SaleAddress — address of land sold
-   City — location of land
-   Owner_Address — owners house address
-   OwnerCity — city where owner lives
-   OwnerState — state where owner is located

## FUNCTIONS & KEYWORDS USED
- JOIN
- PARSENAME
- CTE
- CASE
- SUBSTRING
- UPDATE & ALTER


## PROBLEM STATEMENT
-   The SaleDate Column was not in the standard format.
-   Some rows in the Property Address  Column were missing.
-   The Property Address and the Owner Address column have the city names, house address and the state name mentioned in the same column.
-   Some Values in the Sold As Vacant column have Y and N instead of Yes or No.
-    Duplicate rows and non-essential columns from the dataset that are not useful for our streamlined analysis should be deleted.

## IMPORTING DATA

The dataset of houses in Nashville city was in xlsx format. I imported the dataset into Microsoft SQL Server and created a database named **Housing**, then further created a table for the dataset which I named  **NashvilleHousing**  in **Microsoft SQL Management Server Studio**.

## STEPS TAKEN 

1.  **Change Date Format:** The original datetime format of the "SaleDate" column was converted to a Standard date format using the CONVERT function and then was updated in the NashvilleHousing  table . 


![Screenshot 2024-01-07 020835](https://github.com/shreyasri007/Nashville-Housing-Data-Cleaning/assets/132162991/f055aa9a-fc2c-46d4-8a10-8dd648039a99)





2.  **Populate Property Address:** Missing values in the "PropertyAddress" column were updated using the ISNULL function and duplicates were identified and removed by joining the table and comparing the values of the "ParcelID" and "PropertyAddress" columns.

![Screenshot 2024-01-07 021458](https://github.com/shreyasri007/Nashville-Housing-Data-Cleaning/assets/132162991/dfb04d60-ed19-41ec-b3ee-41707554936c)



3.  **Break out the Property Address:** The "PropertyAddress" column has values of both city name and house address so, I split it out into two separate columns "PropertySplitAddress" and "PropertySplitCity", using the SUBSTRING function of SQL.

![Screenshot 2024-01-07 021516](https://github.com/shreyasri007/Nashville-Housing-Data-Cleaning/assets/132162991/e6f76a2b-992d-4dab-af1a-2fe22d5b5c03)



4.  **Break out the Owner's Address:** Similarly, the "OwnerAddress" column has values of both city, State name as well as house address so, I split it out into three separate columns "OwnerSplitAddress", "OwnerSplitCity", and "OwnerSplitState" using the PARSENAME function for our better analysis.


![Screenshot 2024-01-07 021554](https://github.com/shreyasri007/Nashville-Housing-Data-Cleaning/assets/132162991/28122bec-346f-4a54-90f9-c2b012c20f61)



5.  **Updating 'Y 'and 'N' values:**  The "SoldAsVacant" column contains values of Yes and No' along with some Y' and 'N' values which I  updated into 'Yes' or 'No' using a CASE statement.

![Screenshot 2024-01-07 021616](https://github.com/shreyasri007/Nashville-Housing-Data-Cleaning/assets/132162991/d942d957-c016-4085-9a60-ae3e331cefb9)



6.  **Remove duplicates:** Duplicate values from the table were removed from the data using a Common Table Expression (CTE) and the ROW_NUMBER function. The duplicates were identified based on the values in the "ParcelID", "PropertyAddress",  and "SalePrice". The columns which are not useful for our analysis  I have deleted those columns i.e PropertyAddress, OwnerAddress, TaxDistrict .
![Screenshot 2024-01-07 021645](https://github.com/shreyasri007/Nashville-Housing-Data-Cleaning/assets/132162991/0f352c09-3d29-4791-bb15-bb2aaa59c449)



## CONCLUSION
The data cleaning project of Nashville City Housing was very fruitful for me. I learned so much in Microsoft SQL Server, employing SQL functions and keywords like JOIN, PARSENAME, CTE, CASE, UPDATE, ALTER, and SUBSTRING which has significantly improved the quality and consistency of housing and property data. The project not only addressed data inconsistencies but also laid the foundation for improved data analysis and decision-making for the Nashville city.

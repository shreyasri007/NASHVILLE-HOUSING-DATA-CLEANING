--CLEANING DATA OF NASHVILLE HOUSING 

Select * from Housing.dbo.NashvilleHousing

-- Standardize Date Format

Select SaleDate, CONVERT(Date,SaleDate)
From Housing.dbo.NashvilleHousing

Update Housing.dbo.NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)

Select SaleDate from Housing.dbo.NashvilleHousing

--Convert Acreage Format to decimal

ALTER TABLE Housing..NashvilleHousing
ALTER COLUMN Acreage  decimal(5,2)


--Populate Property address Data 

Select * from Housing.dbo.NashvilleHousing
where PropertyAddress is null
order by ParcelID

Select a.ParcelID , a.PropertyAddress , b.ParcelID , b.PropertyAddress , ISNULL(a.PropertyAddress, b.PropertyAddress)
from Housing.dbo.NashvilleHousing a
Join Housing.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

Update a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from Housing.dbo.NashvilleHousing a
Join Housing.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


-- Breaking out Address into Individual Columns (Address,city,state)

Select PropertyAddress
from Housing.dbo.NashvilleHousing

Select SUBSTRING(PropertyAddress, 1 , CHARINDEX(',',PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,Len(PropertyAddress)) as Address
from Housing.dbo.NashvilleHousing

Alter table Housing.dbo.NashvilleHousing
ADD PropertySplitAddress Nvarchar(250)

Update Housing.dbo.NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1 , CHARINDEX(',',PropertyAddress)-1)

Alter table Housing.dbo.NashvilleHousing
ADD PropertySplitCity Nvarchar(250)

Update Housing.dbo.NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,Len(PropertyAddress))


--Breaking OwnerAddress

Select OwnerAddress
from Housing.dbo.NashvilleHousing

Select PARSENAME(Replace(OwnerAddress,',','.'),3)
,PARSENAME(Replace(OwnerAddress,',','.'),2)
,PARSENAME(Replace(OwnerAddress,',','.'),1)
from Housing.dbo.NashvilleHousing

Alter table Housing.dbo.NashvilleHousing
ADD OwnerSplitAddress Nvarchar(250)

Update Housing.dbo.NashvilleHousing
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'),3)

Alter table Housing.dbo.NashvilleHousing
ADD OwnerSplitCity Nvarchar(250)

Update Housing.dbo.NashvilleHousing
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'),2)

Alter table Housing.dbo.NashvilleHousing
ADD OwnerSplitState Nvarchar(250)

Update Housing.dbo.NashvilleHousing
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1)


Select*
from Housing.dbo.NashvilleHousing



-- Changing Y and N to Yes And No in SoldASVacant column

Select Distinct(SoldASVacant), count (SoldASVacant)
from Housing.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2

SELECT SoldAsVacant ,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
from Housing.dbo.NashvilleHousing

Update Housing.dbo.NashvilleHousing
Set SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END



-- Removing Duplicates

With RowNumCTE as(
Select *,
ROW_NUMBER() over (Partition by
ParcelID,
PropertyAddress,
SaleDate,
SalePrice,
LegalReference
order by UniqueID ) row_num
from  Housing.dbo.NashvilleHousing
--order by ParcelID 
)

Delete from RowNumCTE
where row_num>1

Select* from Housing..NashvilleHousing



--Delete Unused Columns

Alter table Housing.dbo.NashvilleHousing 
Drop Column PropertyAddress , OwnerAddress, TaxDistrict

Select* from Housing..NashvilleHousing

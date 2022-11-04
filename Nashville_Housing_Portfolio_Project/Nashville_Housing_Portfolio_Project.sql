-- Cleaning data using SQL queries

select * 
from PortfolioProject..NashvilleHousing 

-- 1) Standardize SaleDate format

select SaleDateConverted, CONVERT(date,SaleDate)
from PortfolioProject..NashvilleHousing 

update NashvilleHousing
set SaleDate = CONVERT(date,SaleDate)

-- if it doesn't update properly

alter table NashvilleHousing
add SaleDateConverted date

update NashvilleHousing
set SaleDateConverted = CONVERT(date,SaleDate)

-- 2) Populate Property Address data

select * 
from PortfolioProject..NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, 
ISNULL(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]

update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]

-- 3) Breaking out Address into individual columns (address, city, state) 

select PropertyAddress 
from PortfolioProject..NashvilleHousing

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress)) as City

from PortfolioProject..NashvilleHousing

ALTER TABLE PortfolioProject..NashvilleHousing
Add PropertySplitAddress Nvarchar(255)

UPDATE PortfolioProject..NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1 )

ALTER TABLE PortfolioProject..NashvilleHousing
Add PropertySplitCity Nvarchar(255)

UPDATE PortfolioProject..NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress))

select * 
from PortfolioProject..NashvilleHousing

select OwnerAddress
from PortfolioProject..NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress,',','.') , 3 ),
PARSENAME(REPLACE(OwnerAddress,',','.') , 2 ),
PARSENAME(REPLACE(OwnerAddress,',','.') , 1 )

from PortfolioProject..NashvilleHousing

ALTER TABLE PortfolioProject..NashvilleHousing
Add OwnerSplitAddress Nvarchar(255)

UPDATE PortfolioProject..NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.') , 3 )

ALTER TABLE PortfolioProject..NashvilleHousing
Add OwnerSplitCity Nvarchar(255)

UPDATE PortfolioProject..NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.') , 2 )

ALTER TABLE PortfolioProject..NashvilleHousing
Add OwnerSplitState Nvarchar(255)

UPDATE PortfolioProject..NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.') , 1 )

-- 4) Change Y and N to Yes and No in SoldAsVacant 

select distinct SoldAsVacant, COUNT(SoldAsVacant)
from PortfolioProject..NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
	CASE When SoldAsVacant = 'Y' THEN 'Yes'
		 When SoldAsVacant = 'N' THEN 'No' 
		 ELSE SoldAsVacant
		 END
from PortfolioProject..NashvilleHousing

UPDATE PortfolioProject..NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
						When SoldAsVacant = 'N' THEN 'No' 
						ELSE SoldAsVacant
						END

-- 5) Remove duplicates

WITH RowNumCTE AS (
select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
					UniqueID
					  ) row_num

from PortfolioProject..NashvilleHousing
-- order by ParcelID
)
-- DELETE
select *
from RowNumCTE
where row_num > 1
--order by PropertyAddress


-- 6) Delete unused columns

select *
from PortfolioProject..NashvilleHousing

alter table PortfolioProject..NashvilleHousing
drop column PropertyAddress, OwnerAddress, TaxDistrict, SaleDate


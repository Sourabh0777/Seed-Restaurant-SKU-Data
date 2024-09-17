-- CreateEnum
CREATE TYPE "Category" AS ENUM ('foodtrial', 'spoilage');

-- CreateEnum
CREATE TYPE "DocumentCategory" AS ENUM ('petpooja', 'expense', 'hr');

-- CreateEnum
CREATE TYPE "ExpenseCategoryEnums" AS ENUM ('cam_charges', 'electricity_charges', 'rent', 'rent_revenue_share', 'store_rent', 'water_charges', 'daily_incentives', 'employer_contribution_EPF', 'employer_contribution_ESIC', 'food_deduction', 'medical_expenses', 'salary_and_wages', 'service_and_incentives_expenses', 'staff_welfare_expenses', 'house_keeping_expenses_others', 'kitchen_consumables', 'crockery_and_cutlery', 'laundry_expenses', 'other_consumables', 'printing_and_stationary', 'repair_and_maintainance', 'repair_and_maintainance_material', 'consultancy_fee', 'nereby_commission_expenses', 'professional_fees', 'tp_fees_on_liquor', 'yes_bank_comission_expenses', 'food_testing_charges', 'member_ship_fee', 'miscellaneous_expenses', 'conveyance_and_travelling', 'bank_charges', 'business_promotions', 'donation_expenses', 'freight_and_cartage_expenses', 'local_conveyance_expenses', 'pest_control_charges', 'postage_and_telegram', 'telephone_and_internet_expenses', 'paytm_comission_expenses', 'harjit_kaur_banga_salary', 'jasmeet_singh_banga_salary', 'salary_expenses_promotions', 'corporate_general_expenses');

-- CreateEnum
CREATE TYPE "ExpenseVendorEnum" AS ENUM ('cash', 'others');

-- CreateEnum
CREATE TYPE "OrderSourceEnum" AS ENUM ('zomato', 'swiggy');

-- CreateEnum
CREATE TYPE "OrderTypeEnum" AS ENUM ('dine_in', 'delivery', 'pickup');

-- CreateTable
CREATE TABLE "FoodTrialSpoilage" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "category" "Category" NOT NULL,
    "itemName" TEXT NOT NULL,
    "restaurantSKUItemId" TEXT NOT NULL,
    "rate" DOUBLE PRECISION NOT NULL,
    "quantity" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "trialBy" TEXT NOT NULL,
    "remark" TEXT,
    "reason" TEXT,
    "vendorName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "FoodTrialSpoilage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" SERIAL NOT NULL,
    "restaurantID" INTEGER NOT NULL,
    "invoiceID" INTEGER NOT NULL,
    "paymentTypeID" INTEGER NOT NULL,
    "orderTypeID" INTEGER NOT NULL,
    "paymentStatus" TEXT NOT NULL,
    "cancelReason" TEXT,
    "orderAmount" DOUBLE PRECISION,
    "discount" DOUBLE PRECISION,
    "netAmountAfterDiscount" DOUBLE PRECISION,
    "containerCharges" DOUBLE PRECISION,
    "deliveryCharges" DOUBLE PRECISION,
    "serviceCharges" DOUBLE PRECISION,
    "totalTax" DOUBLE PRECISION,
    "totalAmount" DOUBLE PRECISION,
    "nonTaxableAmount" DOUBLE PRECISION,
    "CGST" DOUBLE PRECISION,
    "SGST" DOUBLE PRECISION,
    "VAT" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderItem" (
    "id" SERIAL NOT NULL,
    "orderID" INTEGER NOT NULL,
    "quantity" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "NCFlag" BOOLEAN NOT NULL DEFAULT false,
    "item_id" TEXT,
    "original_price" DOUBLE PRECISION,
    "price" DOUBLE PRECISION,
    "total" DOUBLE PRECISION,
    "total_discount" DOUBLE PRECISION DEFAULT 0,
    "total_tax" DOUBLE PRECISION,
    "restaurantID" INTEGER NOT NULL,

    CONSTRAINT "OrderItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin_permissions" (
    "id" TEXT NOT NULL,
    "accessPermissionName" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "admin_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin_roles" (
    "id" TEXT NOT NULL,
    "roleName" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "admin_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin_users" (
    "id" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "addressLine1" TEXT,
    "addressLine2" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "zipCode" INTEGER,
    "countryCode" TEXT,
    "gender" TEXT,
    "dateOfBirth" TIMESTAMP(3),
    "userName" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userImageLink" TEXT,
    "admin_rolesId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "userType" TEXT NOT NULL DEFAULT 'admin',
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "admin_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "discount_coupons" (
    "id" TEXT NOT NULL,
    "couponName" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "discount_coupons_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "discount_orders_summary" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "createdDate" TEXT NOT NULL,
    "invoiceNo" TEXT NOT NULL,
    "coupon" TEXT NOT NULL,
    "discountType" TEXT,
    "reason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "discount_couponsID" TEXT,
    "orderType" TEXT,

    CONSTRAINT "discount_orders_summary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_uploads_tracking_table" (
    "id" TEXT NOT NULL,
    "restaurantUserID" TEXT,
    "adminUserID" TEXT,
    "documentCategory" "DocumentCategory" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "restaurantID" TEXT,
    "AllFilesDataIsUploaded" BOOLEAN NOT NULL DEFAULT false,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "document_uploads_tracking_table_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "expense_tally_data_categories" (
    "id" TEXT NOT NULL,
    "categoryName" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "expense_tally_data_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fileTrackingTables" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "fileName" TEXT NOT NULL,
    "fileURL" TEXT NOT NULL,
    "mainTableUpdated" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "fileTrackingTables_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gas_readings" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "LPG" INTEGER NOT NULL,
    "Amount" INTEGER NOT NULL,
    "openingReading" INTEGER NOT NULL,
    "closingReading" INTEGER NOT NULL,
    "netReading" INTEGER NOT NULL,
    "totalAmount" INTEGER NOT NULL,
    "covers" INTEGER NOT NULL,
    "PPC" INTEGER NOT NULL,
    "restaurantUserID" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "monthIndex" INTEGER,
    "year" INTEGER,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "gas_readings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "hr_payroll_data" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "restaurantID" TEXT,
    "employeeCode" TEXT NOT NULL,
    "basicSalary" INTEGER NOT NULL,
    "incentives" INTEGER NOT NULL DEFAULT 0,
    "foodDeduction" INTEGER NOT NULL DEFAULT 0,
    "grossSalary" INTEGER NOT NULL,
    "totalDeductions" INTEGER NOT NULL DEFAULT 0,
    "netSalary" INTEGER NOT NULL,
    "employerPF" INTEGER NOT NULL DEFAULT 0,
    "employerCTC" INTEGER NOT NULL DEFAULT 0,
    "monthOfSalary" TEXT NOT NULL,
    "yearOfSalary" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "employerAPRF" INTEGER NOT NULL,
    "employerESI" INTEGER NOT NULL DEFAULT 0,
    "houseRentAllowance" INTEGER NOT NULL,
    "otherAllowances" INTEGER NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "hr_payroll_data_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "non_cahrgable_items" (
    "id" TEXT NOT NULL,
    "SKUItemVariantID" TEXT NOT NULL,
    "restaurantUserID" TEXT,
    "NonChargableItemDescription" TEXT,
    "NonChargableItemQuantity" INTEGER,
    "NonChargableItemRate" INTEGER,
    "NonChargableItemAmount" INTEGER,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "non_cahrgable_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "non_chargable_category" (
    "id" TEXT NOT NULL,
    "nonChargableCategoryName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "non_chargable_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "non_chargeable_sale_categories" (
    "id" TEXT NOT NULL,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "nonChargeableSaleCategoryName" TEXT NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "non_chargeable_sale_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "non_chargeable_sales" (
    "id" TEXT NOT NULL,
    "nonChargeableSaleCategoryID" TEXT NOT NULL,
    "restaurantSKUItemVariantID" TEXT,
    "storeSKUItemVarintID" TEXT,
    "quantity" INTEGER NOT NULL,
    "monthIndex" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "restaurantID" TEXT,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "non_chargeable_sales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "non_chargeable_sales_entries" (
    "id" TEXT NOT NULL,
    "ncItemSalesID" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "trailedByUser" TEXT,
    "reason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "amount" INTEGER NOT NULL DEFAULT 0,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "non_chargeable_sales_entries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_audit_item_wise" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "invoiceNo" TEXT NOT NULL,
    "itemModifiedDate" TEXT NOT NULL,
    "byUser" TEXT,
    "oldValue" INTEGER NOT NULL,
    "newValue" INTEGER NOT NULL,
    "itemStataus" TEXT NOT NULL,
    "when" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderType" TEXT,

    CONSTRAINT "order_audit_item_wise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_modifiction_reports" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "invoiceNo" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "changeLog" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "order_modifiction_reports_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_reports_payment_wise" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "invoiceNo" TEXT NOT NULL,
    "cash" INTEGER NOT NULL DEFAULT 0,
    "card" INTEGER NOT NULL DEFAULT 0,
    "duePayment" INTEGER NOT NULL DEFAULT 0,
    "other" INTEGER NOT NULL DEFAULT 0,
    "wallet" INTEGER NOT NULL DEFAULT 0,
    "online" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderType" TEXT,

    CONSTRAINT "order_reports_payment_wise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_type" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderType" "OrderTypeEnum" NOT NULL,

    CONSTRAINT "order_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permanent_item_report_with_customer_order" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "invoiceNo" INTEGER NOT NULL,
    "itemName" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    "subTotal" INTEGER NOT NULL,
    "discount" INTEGER NOT NULL DEFAULT 0,
    "tax" INTEGER NOT NULL DEFAULT 0,
    "finalTotal" INTEGER NOT NULL,
    "tableNo" INTEGER,
    "serverName" TEXT,
    "covers" TEXT,
    "variation" TEXT,
    "category" TEXT NOT NULL,
    "HSN" TEXT,
    "nonTaxable" INTEGER NOT NULL DEFAULT 0,
    "cgstRate" INTEGER NOT NULL DEFAULT 0,
    "cgstAmount" INTEGER NOT NULL DEFAULT 0,
    "sgstRate" INTEGER NOT NULL DEFAULT 0,
    "sgstAmount" INTEGER NOT NULL DEFAULT 0,
    "vatRate" INTEGER NOT NULL DEFAULT 0,
    "vatAmount" INTEGER NOT NULL DEFAULT 0,
    "restaurantSKUItemVairantID" TEXT,
    "restaurantSKUCategoryID" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderType" TEXT,

    CONSTRAINT "permanent_item_report_with_customer_order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permanent_order_master" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "invoiceNo" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "biller" TEXT NOT NULL,
    "paymentType" TEXT NOT NULL,
    "orderType" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "subOrderType" TEXT NOT NULL,
    "groupName" TEXT,
    "GSTIN" TEXT,
    "orderCancelReason" TEXT,
    "myAmount" INTEGER NOT NULL DEFAULT 0,
    "discount" INTEGER NOT NULL DEFAULT 0,
    "netSales" INTEGER NOT NULL DEFAULT 0,
    "deliveryCharge" INTEGER NOT NULL DEFAULT 0,
    "containerCharge" INTEGER NOT NULL DEFAULT 0,
    "serviceCharge" INTEGER NOT NULL DEFAULT 0,
    "totalTax" INTEGER NOT NULL DEFAULT 0,
    "roundOff" INTEGER NOT NULL DEFAULT 0,
    "waivedOff" INTEGER NOT NULL DEFAULT 0,
    "total" INTEGER NOT NULL DEFAULT 0,
    "onlineTaxCalculated" INTEGER NOT NULL DEFAULT 0,
    "gstPaidByMerchant" INTEGER NOT NULL DEFAULT 0,
    "gstPaidByEcommerce" INTEGER NOT NULL DEFAULT 0,
    "tip" INTEGER NOT NULL DEFAULT 0,
    "nonTaxable" INTEGER NOT NULL DEFAULT 0,
    "cgstAmount" INTEGER NOT NULL DEFAULT 0,
    "cgst" INTEGER NOT NULL DEFAULT 0,
    "sgstAmount" INTEGER NOT NULL DEFAULT 0,
    "sgst" INTEGER NOT NULL DEFAULT 0,
    "vatAmount" INTEGER NOT NULL DEFAULT 0,
    "vat" INTEGER NOT NULL DEFAULT 0,
    "itemModifiedDate" TEXT,
    "modifiedByUser" TEXT,
    "oldValue" INTEGER,
    "newValue" INTEGER,
    "itemModificationStatus" TEXT,
    "whenModified" TEXT,
    "modificationReason" TEXT,
    "changeLog" TEXT,
    "cash" INTEGER DEFAULT 0,
    "card" INTEGER DEFAULT 0,
    "duePayment" INTEGER DEFAULT 0,
    "other" INTEGER DEFAULT 0,
    "wallet" INTEGER DEFAULT 0,
    "online" INTEGER,
    "discountCouponID" TEXT,
    "discountType" TEXT,
    "discountReason" TEXT,
    "onlinePlatformClientOrderNo" TEXT,
    "orderFromOnlinePlatform" TEXT,
    "onlinePlatformVirtualBrandName" TEXT,
    "onlinePlatformTotal" INTEGER,
    "onlinePlatformOrderID" TEXT,
    "onlinePlatformOrderStatus" TEXT,
    "onlineOrderReceivedTime" TEXT,
    "onlineOrderAcceptedTime" TEXT,
    "onlineOrderMarkReadyTime" TEXT,
    "onlineOrderRiderArrivalTime" TEXT,
    "onlinseOrderPickedUpTime" TEXT,
    "onlineOrderDeliveredTime" TEXT,
    "onlineOrderCancelledTime" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "permanent_order_master_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant" (
    "id" TEXT NOT NULL,
    "restaurantName" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "zipCode" INTEGER NOT NULL,
    "countryCode" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdBy" TEXT,
    "updatedBy" TEXT,
    "chefID" TEXT,
    "restaurantCode" TEXT NOT NULL,
    "storeID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_SKU_category" (
    "id" TEXT NOT NULL,
    "SKUCategoryName" TEXT NOT NULL,
    "isVeg" BOOLEAN NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_SKU_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_SKU_groups" (
    "id" TEXT NOT NULL,
    "restaurantSKUGroupName" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_SKU_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_SKU_item_variants" (
    "id" TEXT NOT NULL,
    "isNCItem" BOOLEAN NOT NULL DEFAULT false,
    "SKUItemID" TEXT NOT NULL,
    "SKUItemVariantName" TEXT NOT NULL,
    "SKUItemVariantQuantity" INTEGER NOT NULL,
    "SKUItemVariantRate" INTEGER NOT NULL,
    "SKUItemVariantExpirationDate" TIMESTAMP(3),
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_SKU_item_variants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_SKU_items" (
    "id" TEXT NOT NULL,
    "SKUItemName" TEXT NOT NULL,
    "SKUItemMeasurementUnit" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "restaurantSKUCategoryID" TEXT NOT NULL,
    "restaurantSKUGroupID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_SKU_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_expense_category" (
    "id" TEXT NOT NULL,
    "restaurantExpenseCategoryName" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_expense_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_expenses" (
    "id" TEXT NOT NULL,
    "restaurantExpenseCategoryID" TEXT NOT NULL,
    "restaurantExpenseDescription" TEXT NOT NULL,
    "restaurantExpenseAmount" INTEGER NOT NULL,
    "restaurantExpensePaymentMode" TEXT,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "restaurantID" TEXT NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_expenses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_issued_items" (
    "id" TEXT NOT NULL,
    "restaurantRecquisitionItemID" TEXT NOT NULL,
    "quantityIssued" INTEGER NOT NULL,
    "remarks" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "restaurant_issuesId" TEXT,
    "issueDate" TEXT NOT NULL,
    "purchaseId" TEXT,
    "storeSKUSectionID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_issued_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_issues" (
    "id" TEXT NOT NULL,
    "restaurantRecquisitionID" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_issues_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_new_SKU_group" (
    "group_category_id" BIGINT NOT NULL,
    "g_name" TEXT NOT NULL,
    "restaurant_id" INTEGER NOT NULL,
    "id" TEXT NOT NULL,

    CONSTRAINT "restaurant_new_SKU_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_new_SKU_category" (
    "c_id" BIGINT NOT NULL,
    "c_name" TEXT NOT NULL,
    "restaurant_id" INTEGER NOT NULL,
    "isBuffet" TEXT,
    "id" TEXT NOT NULL,
    "meal_type" TEXT,
    "buffetTypeId" TEXT,
    "mealTypeId" TEXT,

    CONSTRAINT "restaurant_new_SKU_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_new_SKU_variants" (
    "v_id" BIGINT NOT NULL,
    "v_name" TEXT,
    "id" TEXT NOT NULL,

    CONSTRAINT "restaurant_new_SKU_variants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_new_SKU_items" (
    "item_id" BIGINT NOT NULL,
    "price" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "old_item_id" BIGINT,
    "i_s_name" TEXT,
    "c_id" TEXT,
    "group_category_id" TEXT,
    "v_id" TEXT,
    "restaurant_id" INTEGER NOT NULL,
    "isAdult" TEXT,
    "isVeg" TEXT,
    "id" TEXT NOT NULL,

    CONSTRAINT "restaurant_new_SKU_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_permissions" (
    "id" TEXT NOT NULL,
    "accessPermissionName" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_recquisition_items" (
    "id" TEXT NOT NULL,
    "srNo" INTEGER NOT NULL,
    "SKUItemVariantID" TEXT,
    "stockInHand" INTEGER,
    "requiredQuantity" INTEGER NOT NULL,
    "alreadyIssuedQuantity" INTEGER,
    "remarks" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "restaurantRecquisitionID" TEXT NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_recquisition_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_recquisitions" (
    "id" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_recquisitions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_roles" (
    "id" TEXT NOT NULL,
    "roleName" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurant_users" (
    "id" TEXT NOT NULL,
    "restaurantID" TEXT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "addressLine1" TEXT,
    "addressLine2" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "zipCode" INTEGER,
    "countryCode" TEXT,
    "gender" TEXT,
    "dateOfBirth" TIMESTAMP(3),
    "userName" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "restaurant_rolesId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdBy" TEXT,
    "updatedBy" TEXT,
    "userType" TEXT NOT NULL DEFAULT 'restaurant',
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "restaurant_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_SKU_category" (
    "id" TEXT NOT NULL,
    "SKUCategoryName" TEXT NOT NULL,
    "isVeg" BOOLEAN NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isPerishable" BOOLEAN NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "store_SKU_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_SKU_item_variants" (
    "id" TEXT NOT NULL,
    "isNCItem" BOOLEAN NOT NULL DEFAULT false,
    "SKUItemID" TEXT NOT NULL,
    "SKUItemVariantName" TEXT NOT NULL,
    "SKUItemVariantQuantity" INTEGER NOT NULL,
    "SKUItemVariantRate" INTEGER,
    "SKUItemVariantExpirationDate" TIMESTAMP(3),
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "store_SKU_item_variants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_SKU_item_variants_purchase_rates" (
    "id" TEXT NOT NULL,
    "SKUItemVariantID" TEXT NOT NULL,
    "SKUItemVariantNewRate" INTEGER NOT NULL,
    "SKUItemVariantOldRate" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "remarks" TEXT,
    "vendorID" TEXT NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "store_SKU_item_variants_purchase_rates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_SKU_items" (
    "id" TEXT NOT NULL,
    "SKUItemName" TEXT NOT NULL,
    "SKUItemMeasurementUnit" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "storeSKUSectionID" TEXT NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "store_SKU_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_SKU_sections" (
    "id" TEXT NOT NULL,
    "storeSKUSectionName" TEXT NOT NULL,
    "storeSKUCategoryID" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "store_SKU_sections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_inventory" (
    "id" TEXT NOT NULL,
    "restaurandUserID" TEXT,
    "storeInventoryQuantity" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "SKUItemVariantID" TEXT NOT NULL,
    "restaurantId" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "store_inventory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_inventory_details" (
    "id" TEXT NOT NULL,
    "storeInventoryId" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "openingQuantity" INTEGER NOT NULL,
    "purchasedQuantity" INTEGER NOT NULL,
    "issuedQuantity" INTEGER NOT NULL,
    "wastedQuantity" INTEGER NOT NULL,
    "closingQuantity" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "store_inventory_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_purchase" (
    "id" TEXT NOT NULL,
    "restaurantID" TEXT,
    "vendorID" TEXT NOT NULL,
    "storeSKUItemVariantsID" TEXT NOT NULL,
    "storePurchaseRate" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "restaurantUserID" TEXT,
    "availableStock" INTEGER,
    "monthIndex" INTEGER NOT NULL,
    "totalIssues" INTEGER,
    "totalPurchases" INTEGER,
    "year" INTEGER NOT NULL,
    "openingQuantity" INTEGER NOT NULL DEFAULT 0,
    "storePurchaseAmount" INTEGER NOT NULL,
    "storePurchaseQuantity" INTEGER NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "totalWasted" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "store_purchase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "store_purchase_entries" (
    "id" TEXT NOT NULL,
    "purchaseId" TEXT NOT NULL,
    "purchaseDate" TEXT NOT NULL,
    "storePurchaseQuantity" INTEGER NOT NULL,
    "storePurchaseAmount" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "store_purchase_entries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "swiggy" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "area" TEXT,
    "date" TEXT NOT NULL,
    "invoiceNo" TEXT NOT NULL,
    "name" TEXT,
    "orderCancelReason" TEXT,
    "status" TEXT,
    "orderType" TEXT,

    CONSTRAINT "swiggy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "temporary_item_report_with_customer_order" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "invoiceNo" TEXT NOT NULL,
    "itemName" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    "subTotal" INTEGER NOT NULL,
    "discount" INTEGER NOT NULL DEFAULT 0,
    "tax" INTEGER NOT NULL DEFAULT 0,
    "finalTotal" INTEGER NOT NULL,
    "tableNo" INTEGER,
    "serverName" TEXT,
    "covers" TEXT,
    "variation" TEXT,
    "category" TEXT NOT NULL,
    "nonTaxable" INTEGER NOT NULL DEFAULT 0,
    "cgstRate" INTEGER NOT NULL DEFAULT 0,
    "cgstAmount" INTEGER NOT NULL DEFAULT 0,
    "sgstRate" INTEGER NOT NULL DEFAULT 0,
    "sgstAmount" INTEGER NOT NULL DEFAULT 0,
    "vatRate" INTEGER NOT NULL DEFAULT 0,
    "vatAmount" INTEGER NOT NULL DEFAULT 0,
    "restaurantSKUItemVairantID" TEXT,
    "restaurantSKUCategoryID" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "orderType" TEXT,

    CONSTRAINT "temporary_item_report_with_customer_order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "temporary_order_master" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "date" TEXT NOT NULL,
    "biller" TEXT,
    "paymentType" TEXT,
    "orderType" TEXT,
    "status" TEXT,
    "area" TEXT,
    "subOrderType" TEXT,
    "groupName" TEXT,
    "GSTIN" TEXT,
    "orderCancelReason" TEXT,
    "myAmount" INTEGER NOT NULL DEFAULT 0,
    "discount" INTEGER NOT NULL DEFAULT 0,
    "netSales" INTEGER NOT NULL DEFAULT 0,
    "deliveryCharge" INTEGER NOT NULL DEFAULT 0,
    "containerCharge" INTEGER NOT NULL DEFAULT 0,
    "serviceCharge" INTEGER NOT NULL DEFAULT 0,
    "totalTax" INTEGER NOT NULL DEFAULT 0,
    "roundOff" INTEGER NOT NULL DEFAULT 0,
    "waivedOff" INTEGER NOT NULL DEFAULT 0,
    "total" INTEGER NOT NULL DEFAULT 0,
    "onlineTaxCalculated" INTEGER NOT NULL DEFAULT 0,
    "gstPaidByMerchant" INTEGER NOT NULL DEFAULT 0,
    "gstPaidByEcommerce" INTEGER NOT NULL DEFAULT 0,
    "tip" INTEGER NOT NULL DEFAULT 0,
    "nonTaxable" INTEGER NOT NULL DEFAULT 0,
    "cgstAmount" INTEGER NOT NULL DEFAULT 0,
    "cgst" INTEGER NOT NULL DEFAULT 0,
    "sgstAmount" INTEGER NOT NULL DEFAULT 0,
    "sgst" INTEGER NOT NULL DEFAULT 0,
    "vatAmount" INTEGER NOT NULL DEFAULT 0,
    "vat" INTEGER NOT NULL DEFAULT 0,
    "itemModifiedDate" TEXT,
    "modifiedByUser" TEXT,
    "oldValue" INTEGER,
    "newValue" INTEGER,
    "itemModificationStatus" TEXT,
    "whenModified" TEXT,
    "modificationReason" TEXT,
    "changeLog" TEXT,
    "cash" INTEGER DEFAULT 0,
    "card" INTEGER DEFAULT 0,
    "duePayment" INTEGER DEFAULT 0,
    "other" INTEGER DEFAULT 0,
    "wallet" INTEGER DEFAULT 0,
    "online" INTEGER,
    "discountCouponID" TEXT,
    "discountType" TEXT,
    "discountReason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "invoiceNo" TEXT NOT NULL,

    CONSTRAINT "temporary_order_master_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "unit_expenses_tally_data" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "restaurantID" TEXT,
    "expenseCategoryID" TEXT NOT NULL,
    "expenseVendor" TEXT NOT NULL,
    "expenseParticularDescription" TEXT,
    "expenseAmount" INTEGER NOT NULL DEFAULT 0,
    "expenseDate" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "expenseType" TEXT NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "unit_expenses_tally_data_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendor_categories" (
    "id" TEXT NOT NULL,
    "vendorCategoryName" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "vendor_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendors" (
    "id" TEXT NOT NULL,
    "vendorName" TEXT NOT NULL,
    "addressLine1" TEXT NOT NULL,
    "addressLine2" TEXT,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "zipCode" INTEGER NOT NULL,
    "vendorCatgeoryID" TEXT NOT NULL,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "restaurantID" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "vendors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "waste_management_category" (
    "id" TEXT NOT NULL,
    "wasteManagementCategoryName" TEXT NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "waste_management_category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "waste_management_items" (
    "id" TEXT NOT NULL,
    "restaurantUserID" TEXT NOT NULL,
    "storeSKUItemVariantID" TEXT,
    "restaurantSKUItemVariantID" TEXT,
    "wastedItemQuantity" INTEGER NOT NULL,
    "approvalStatus" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "categoryID" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "waste_management_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zomato" (
    "id" TEXT NOT NULL,
    "documentUploadTrackingTableID" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "area" TEXT,
    "date" TEXT NOT NULL,
    "invoiceNo" TEXT NOT NULL,
    "name" TEXT,
    "orderCancelReason" TEXT,
    "status" TEXT,
    "orderType" TEXT,

    CONSTRAINT "zomato_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "non_chargeable_sales_entries_v2" (
    "id" TEXT NOT NULL,
    "ncItemSalesID" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "trailedByUser" TEXT,
    "reason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "amount" INTEGER NOT NULL DEFAULT 0,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "restaurantSKUItemID" TEXT,
    "restaurant_new_SKU_categoryC_id" TEXT,
    "storeSKUItemVarintID" TEXT,
    "rate" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "non_chargeable_sales_entries_v2_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "non_chargeable_sales_v2" (
    "id" TEXT NOT NULL,
    "nonChargeableSaleCategoryID" TEXT NOT NULL,
    "restaurantSKUItemID" TEXT,
    "storeSKUItemVarintID" TEXT,
    "quantity" INTEGER NOT NULL,
    "monthIndex" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "restaurantID" TEXT,
    "createdByUserID" TEXT,
    "updatedByUserID" TEXT,
    "approvedByUserID" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "restaurant_new_SKU_categoryC_id" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "non_chargeable_sales_v2_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "new_restaurant" (
    "restaurant_id" INTEGER NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "new_restaurant_pkey" PRIMARY KEY ("restaurant_id")
);

-- CreateTable
CREATE TABLE "buffetType" (
    "id" TEXT NOT NULL,
    "buffetTypeName" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL,

    CONSTRAINT "buffetType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customerType" (
    "id" TEXT NOT NULL,
    "customerTypeName" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL,

    CONSTRAINT "customerType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mealType" (
    "id" TEXT NOT NULL,
    "mealTypeName" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL,

    CONSTRAINT "mealType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vegetarianMark" (
    "id" TEXT NOT NULL,
    "vegetarianMarkType" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL,

    CONSTRAINT "vegetarianMark_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_admin_permissionsToadmin_roles" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_restaurant_permissionsTorestaurant_roles" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE INDEX "FoodTrialSpoilage_date_idx" ON "FoodTrialSpoilage"("date");

-- CreateIndex
CREATE INDEX "FoodTrialSpoilage_itemName_idx" ON "FoodTrialSpoilage"("itemName");

-- CreateIndex
CREATE INDEX "FoodTrialSpoilage_restaurantSKUItemId_idx" ON "FoodTrialSpoilage"("restaurantSKUItemId");

-- CreateIndex
CREATE INDEX "FoodTrialSpoilage_vendorName_idx" ON "FoodTrialSpoilage"("vendorName");

-- CreateIndex
CREATE UNIQUE INDEX "Order_id_key" ON "Order"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Order_invoiceID_key" ON "Order"("invoiceID");

-- CreateIndex
CREATE UNIQUE INDEX "OrderItem_id_key" ON "OrderItem"("id");

-- CreateIndex
CREATE UNIQUE INDEX "admin_permissions_accessPermissionName_key" ON "admin_permissions"("accessPermissionName");

-- CreateIndex
CREATE UNIQUE INDEX "admin_permissions_slug_key" ON "admin_permissions"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "admin_roles_roleName_key" ON "admin_roles"("roleName");

-- CreateIndex
CREATE UNIQUE INDEX "admin_roles_slug_key" ON "admin_roles"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "admin_users_email_key" ON "admin_users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "admin_users_phoneNumber_key" ON "admin_users"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "admin_users_userName_key" ON "admin_users"("userName");

-- CreateIndex
CREATE UNIQUE INDEX "discount_coupons_couponName_key" ON "discount_coupons"("couponName");

-- CreateIndex
CREATE UNIQUE INDEX "expense_tally_data_categories_slug_key" ON "expense_tally_data_categories"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "non_cahrgable_items_SKUItemVariantID_key" ON "non_cahrgable_items"("SKUItemVariantID");

-- CreateIndex
CREATE UNIQUE INDEX "non_cahrgable_items_restaurantUserID_key" ON "non_cahrgable_items"("restaurantUserID");

-- CreateIndex
CREATE UNIQUE INDEX "non_chargable_category_nonChargableCategoryName_key" ON "non_chargable_category"("nonChargableCategoryName");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_restaurantCode_key" ON "restaurant"("restaurantCode");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_SKU_category_SKUCategoryName_key" ON "restaurant_SKU_category"("SKUCategoryName");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_SKU_groups_restaurantSKUGroupName_key" ON "restaurant_SKU_groups"("restaurantSKUGroupName");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_SKU_items_SKUItemName_key" ON "restaurant_SKU_items"("SKUItemName");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_expense_category_restaurantExpenseCategoryName_key" ON "restaurant_expense_category"("restaurantExpenseCategoryName");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_permissions_accessPermissionName_key" ON "restaurant_permissions"("accessPermissionName");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_permissions_slug_key" ON "restaurant_permissions"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_roles_roleName_key" ON "restaurant_roles"("roleName");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_roles_slug_key" ON "restaurant_roles"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_users_email_key" ON "restaurant_users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_users_phoneNumber_key" ON "restaurant_users"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "restaurant_users_userName_key" ON "restaurant_users"("userName");

-- CreateIndex
CREATE UNIQUE INDEX "store_SKU_category_SKUCategoryName_key" ON "store_SKU_category"("SKUCategoryName");

-- CreateIndex
CREATE UNIQUE INDEX "store_SKU_items_SKUItemName_key" ON "store_SKU_items"("SKUItemName");

-- CreateIndex
CREATE UNIQUE INDEX "store_SKU_sections_storeSKUSectionName_key" ON "store_SKU_sections"("storeSKUSectionName");

-- CreateIndex
CREATE UNIQUE INDEX "store_inventory_SKUItemVariantID_key" ON "store_inventory"("SKUItemVariantID");

-- CreateIndex
CREATE UNIQUE INDEX "temporary_order_master_invoiceNo_key" ON "temporary_order_master"("invoiceNo");

-- CreateIndex
CREATE UNIQUE INDEX "vendor_categories_vendorCategoryName_key" ON "vendor_categories"("vendorCategoryName");

-- CreateIndex
CREATE UNIQUE INDEX "vendors_vendorName_key" ON "vendors"("vendorName");

-- CreateIndex
CREATE UNIQUE INDEX "waste_management_category_wasteManagementCategoryName_key" ON "waste_management_category"("wasteManagementCategoryName");

-- CreateIndex
CREATE UNIQUE INDEX "new_restaurant_restaurant_id_key" ON "new_restaurant"("restaurant_id");

-- CreateIndex
CREATE UNIQUE INDEX "_admin_permissionsToadmin_roles_AB_unique" ON "_admin_permissionsToadmin_roles"("A", "B");

-- CreateIndex
CREATE INDEX "_admin_permissionsToadmin_roles_B_index" ON "_admin_permissionsToadmin_roles"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_restaurant_permissionsTorestaurant_roles_AB_unique" ON "_restaurant_permissionsTorestaurant_roles"("A", "B");

-- CreateIndex
CREATE INDEX "_restaurant_permissionsTorestaurant_roles_B_index" ON "_restaurant_permissionsTorestaurant_roles"("B");

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_restaurantID_fkey" FOREIGN KEY ("restaurantID") REFERENCES "new_restaurant"("restaurant_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "restaurant_new_SKU_items"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_orderID_fkey" FOREIGN KEY ("orderID") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderItem" ADD CONSTRAINT "OrderItem_restaurantID_fkey" FOREIGN KEY ("restaurantID") REFERENCES "new_restaurant"("restaurant_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "admin_users" ADD CONSTRAINT "admin_users_admin_rolesId_fkey" FOREIGN KEY ("admin_rolesId") REFERENCES "admin_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "discount_orders_summary" ADD CONSTRAINT "discount_orders_summary_discount_couponsID_fkey" FOREIGN KEY ("discount_couponsID") REFERENCES "discount_coupons"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "discount_orders_summary" ADD CONSTRAINT "discount_orders_summary_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_uploads_tracking_table" ADD CONSTRAINT "document_uploads_tracking_table_adminUserID_fkey" FOREIGN KEY ("adminUserID") REFERENCES "admin_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_uploads_tracking_table" ADD CONSTRAINT "document_uploads_tracking_table_restaurantID_fkey" FOREIGN KEY ("restaurantID") REFERENCES "restaurant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_uploads_tracking_table" ADD CONSTRAINT "document_uploads_tracking_table_restaurantUserID_fkey" FOREIGN KEY ("restaurantUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "expense_tally_data_categories" ADD CONSTRAINT "expense_tally_data_categories_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "admin_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fileTrackingTables" ADD CONSTRAINT "fileTrackingTables_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gas_readings" ADD CONSTRAINT "gas_readings_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gas_readings" ADD CONSTRAINT "gas_readings_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gas_readings" ADD CONSTRAINT "gas_readings_restaurantUserID_fkey" FOREIGN KEY ("restaurantUserID") REFERENCES "restaurant_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gas_readings" ADD CONSTRAINT "gas_readings_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "hr_payroll_data" ADD CONSTRAINT "hr_payroll_data_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "hr_payroll_data" ADD CONSTRAINT "hr_payroll_data_restaurantID_fkey" FOREIGN KEY ("restaurantID") REFERENCES "restaurant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_cahrgable_items" ADD CONSTRAINT "non_cahrgable_items_SKUItemVariantID_fkey" FOREIGN KEY ("SKUItemVariantID") REFERENCES "restaurant_SKU_item_variants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_cahrgable_items" ADD CONSTRAINT "non_cahrgable_items_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_cahrgable_items" ADD CONSTRAINT "non_cahrgable_items_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_cahrgable_items" ADD CONSTRAINT "non_cahrgable_items_restaurantUserID_fkey" FOREIGN KEY ("restaurantUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_cahrgable_items" ADD CONSTRAINT "non_cahrgable_items_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargable_category" ADD CONSTRAINT "non_chargable_category_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargable_category" ADD CONSTRAINT "non_chargable_category_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargable_category" ADD CONSTRAINT "non_chargable_category_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sale_categories" ADD CONSTRAINT "non_chargeable_sale_categories_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sale_categories" ADD CONSTRAINT "non_chargeable_sale_categories_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sale_categories" ADD CONSTRAINT "non_chargeable_sale_categories_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales" ADD CONSTRAINT "non_chargeable_sales_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales" ADD CONSTRAINT "non_chargeable_sales_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales" ADD CONSTRAINT "non_chargeable_sales_nonChargeableSaleCategoryID_fkey" FOREIGN KEY ("nonChargeableSaleCategoryID") REFERENCES "non_chargeable_sale_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales" ADD CONSTRAINT "non_chargeable_sales_restaurantSKUItemVariantID_fkey" FOREIGN KEY ("restaurantSKUItemVariantID") REFERENCES "restaurant_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales" ADD CONSTRAINT "non_chargeable_sales_storeSKUItemVarintID_fkey" FOREIGN KEY ("storeSKUItemVarintID") REFERENCES "store_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales" ADD CONSTRAINT "non_chargeable_sales_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries" ADD CONSTRAINT "non_chargeable_sales_entries_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries" ADD CONSTRAINT "non_chargeable_sales_entries_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries" ADD CONSTRAINT "non_chargeable_sales_entries_ncItemSalesID_fkey" FOREIGN KEY ("ncItemSalesID") REFERENCES "non_chargeable_sales"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries" ADD CONSTRAINT "non_chargeable_sales_entries_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_audit_item_wise" ADD CONSTRAINT "order_audit_item_wise_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_modifiction_reports" ADD CONSTRAINT "order_modifiction_reports_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_reports_payment_wise" ADD CONSTRAINT "order_reports_payment_wise_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permanent_item_report_with_customer_order" ADD CONSTRAINT "permanent_item_report_with_customer_order_documentUploadTr_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permanent_item_report_with_customer_order" ADD CONSTRAINT "permanent_item_report_with_customer_order_restaurantSKUCat_fkey" FOREIGN KEY ("restaurantSKUCategoryID") REFERENCES "restaurant_SKU_category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permanent_item_report_with_customer_order" ADD CONSTRAINT "permanent_item_report_with_customer_order_restaurantSKUIte_fkey" FOREIGN KEY ("restaurantSKUItemVairantID") REFERENCES "restaurant_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permanent_order_master" ADD CONSTRAINT "permanent_order_master_discountCouponID_fkey" FOREIGN KEY ("discountCouponID") REFERENCES "discount_coupons"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permanent_order_master" ADD CONSTRAINT "permanent_order_master_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant" ADD CONSTRAINT "restaurant_chefID_fkey" FOREIGN KEY ("chefID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant" ADD CONSTRAINT "restaurant_storeID_fkey" FOREIGN KEY ("storeID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_category" ADD CONSTRAINT "restaurant_SKU_category_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_category" ADD CONSTRAINT "restaurant_SKU_category_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_category" ADD CONSTRAINT "restaurant_SKU_category_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_groups" ADD CONSTRAINT "restaurant_SKU_groups_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_groups" ADD CONSTRAINT "restaurant_SKU_groups_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_groups" ADD CONSTRAINT "restaurant_SKU_groups_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_item_variants" ADD CONSTRAINT "restaurant_SKU_item_variants_SKUItemID_fkey" FOREIGN KEY ("SKUItemID") REFERENCES "restaurant_SKU_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_item_variants" ADD CONSTRAINT "restaurant_SKU_item_variants_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_item_variants" ADD CONSTRAINT "restaurant_SKU_item_variants_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_item_variants" ADD CONSTRAINT "restaurant_SKU_item_variants_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_items" ADD CONSTRAINT "restaurant_SKU_items_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_items" ADD CONSTRAINT "restaurant_SKU_items_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_items" ADD CONSTRAINT "restaurant_SKU_items_restaurantSKUCategoryID_fkey" FOREIGN KEY ("restaurantSKUCategoryID") REFERENCES "restaurant_SKU_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_items" ADD CONSTRAINT "restaurant_SKU_items_restaurantSKUGroupID_fkey" FOREIGN KEY ("restaurantSKUGroupID") REFERENCES "restaurant_SKU_groups"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_SKU_items" ADD CONSTRAINT "restaurant_SKU_items_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_expense_category" ADD CONSTRAINT "restaurant_expense_category_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_expense_category" ADD CONSTRAINT "restaurant_expense_category_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_expense_category" ADD CONSTRAINT "restaurant_expense_category_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_expenses" ADD CONSTRAINT "restaurant_expenses_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_expenses" ADD CONSTRAINT "restaurant_expenses_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_expenses" ADD CONSTRAINT "restaurant_expenses_restaurantExpenseCategoryID_fkey" FOREIGN KEY ("restaurantExpenseCategoryID") REFERENCES "restaurant_expense_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_expenses" ADD CONSTRAINT "restaurant_expenses_restaurantID_fkey" FOREIGN KEY ("restaurantID") REFERENCES "restaurant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_expenses" ADD CONSTRAINT "restaurant_expenses_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_issued_items" ADD CONSTRAINT "restaurant_issued_items_purchaseId_fkey" FOREIGN KEY ("purchaseId") REFERENCES "store_purchase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_issued_items" ADD CONSTRAINT "restaurant_issued_items_restaurantRecquisitionItemID_fkey" FOREIGN KEY ("restaurantRecquisitionItemID") REFERENCES "restaurant_recquisition_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_issued_items" ADD CONSTRAINT "restaurant_issued_items_restaurant_issuesId_fkey" FOREIGN KEY ("restaurant_issuesId") REFERENCES "restaurant_issues"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_issued_items" ADD CONSTRAINT "restaurant_issued_items_storeSKUSectionID_fkey" FOREIGN KEY ("storeSKUSectionID") REFERENCES "store_SKU_sections"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_issues" ADD CONSTRAINT "restaurant_issues_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_issues" ADD CONSTRAINT "restaurant_issues_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_issues" ADD CONSTRAINT "restaurant_issues_restaurantRecquisitionID_fkey" FOREIGN KEY ("restaurantRecquisitionID") REFERENCES "restaurant_recquisitions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_issues" ADD CONSTRAINT "restaurant_issues_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_group" ADD CONSTRAINT "restaurant_new_SKU_group_restaurant_id_fkey" FOREIGN KEY ("restaurant_id") REFERENCES "new_restaurant"("restaurant_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_category" ADD CONSTRAINT "restaurant_new_SKU_category_buffetTypeId_fkey" FOREIGN KEY ("buffetTypeId") REFERENCES "buffetType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_category" ADD CONSTRAINT "restaurant_new_SKU_category_mealTypeId_fkey" FOREIGN KEY ("mealTypeId") REFERENCES "mealType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_category" ADD CONSTRAINT "restaurant_new_SKU_category_restaurant_id_fkey" FOREIGN KEY ("restaurant_id") REFERENCES "new_restaurant"("restaurant_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_items" ADD CONSTRAINT "restaurant_new_SKU_items_c_id_fkey" FOREIGN KEY ("c_id") REFERENCES "restaurant_new_SKU_category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_items" ADD CONSTRAINT "restaurant_new_SKU_items_group_category_id_fkey" FOREIGN KEY ("group_category_id") REFERENCES "restaurant_new_SKU_group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_items" ADD CONSTRAINT "restaurant_new_SKU_items_isAdult_fkey" FOREIGN KEY ("isAdult") REFERENCES "customerType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_items" ADD CONSTRAINT "restaurant_new_SKU_items_isVeg_fkey" FOREIGN KEY ("isVeg") REFERENCES "vegetarianMark"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_items" ADD CONSTRAINT "restaurant_new_SKU_items_restaurant_id_fkey" FOREIGN KEY ("restaurant_id") REFERENCES "new_restaurant"("restaurant_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_new_SKU_items" ADD CONSTRAINT "restaurant_new_SKU_items_v_id_fkey" FOREIGN KEY ("v_id") REFERENCES "restaurant_new_SKU_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_recquisition_items" ADD CONSTRAINT "restaurant_recquisition_items_SKUItemVariantID_fkey" FOREIGN KEY ("SKUItemVariantID") REFERENCES "store_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_recquisition_items" ADD CONSTRAINT "restaurant_recquisition_items_restaurantRecquisitionID_fkey" FOREIGN KEY ("restaurantRecquisitionID") REFERENCES "restaurant_recquisitions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_recquisitions" ADD CONSTRAINT "restaurant_recquisitions_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_recquisitions" ADD CONSTRAINT "restaurant_recquisitions_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_recquisitions" ADD CONSTRAINT "restaurant_recquisitions_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_users" ADD CONSTRAINT "restaurant_users_restaurantID_fkey" FOREIGN KEY ("restaurantID") REFERENCES "restaurant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "restaurant_users" ADD CONSTRAINT "restaurant_users_restaurant_rolesId_fkey" FOREIGN KEY ("restaurant_rolesId") REFERENCES "restaurant_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_category" ADD CONSTRAINT "store_SKU_category_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_category" ADD CONSTRAINT "store_SKU_category_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_category" ADD CONSTRAINT "store_SKU_category_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_item_variants" ADD CONSTRAINT "store_SKU_item_variants_SKUItemID_fkey" FOREIGN KEY ("SKUItemID") REFERENCES "store_SKU_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_item_variants" ADD CONSTRAINT "store_SKU_item_variants_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_item_variants" ADD CONSTRAINT "store_SKU_item_variants_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_item_variants" ADD CONSTRAINT "store_SKU_item_variants_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_item_variants_purchase_rates" ADD CONSTRAINT "store_SKU_item_variants_purchase_rates_SKUItemVariantID_fkey" FOREIGN KEY ("SKUItemVariantID") REFERENCES "store_SKU_item_variants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_item_variants_purchase_rates" ADD CONSTRAINT "store_SKU_item_variants_purchase_rates_vendorID_fkey" FOREIGN KEY ("vendorID") REFERENCES "vendors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_items" ADD CONSTRAINT "store_SKU_items_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_items" ADD CONSTRAINT "store_SKU_items_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_items" ADD CONSTRAINT "store_SKU_items_storeSKUSectionID_fkey" FOREIGN KEY ("storeSKUSectionID") REFERENCES "store_SKU_sections"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_items" ADD CONSTRAINT "store_SKU_items_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_sections" ADD CONSTRAINT "store_SKU_sections_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_sections" ADD CONSTRAINT "store_SKU_sections_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_sections" ADD CONSTRAINT "store_SKU_sections_storeSKUCategoryID_fkey" FOREIGN KEY ("storeSKUCategoryID") REFERENCES "store_SKU_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_SKU_sections" ADD CONSTRAINT "store_SKU_sections_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_inventory" ADD CONSTRAINT "store_inventory_SKUItemVariantID_fkey" FOREIGN KEY ("SKUItemVariantID") REFERENCES "store_SKU_item_variants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_inventory" ADD CONSTRAINT "store_inventory_restaurandUserID_fkey" FOREIGN KEY ("restaurandUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_inventory" ADD CONSTRAINT "store_inventory_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "restaurant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_inventory_details" ADD CONSTRAINT "store_inventory_details_storeInventoryId_fkey" FOREIGN KEY ("storeInventoryId") REFERENCES "store_inventory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_purchase" ADD CONSTRAINT "store_purchase_restaurantUserID_fkey" FOREIGN KEY ("restaurantUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_purchase" ADD CONSTRAINT "store_purchase_storeSKUItemVariantsID_fkey" FOREIGN KEY ("storeSKUItemVariantsID") REFERENCES "store_SKU_item_variants"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_purchase" ADD CONSTRAINT "store_purchase_vendorID_fkey" FOREIGN KEY ("vendorID") REFERENCES "vendors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store_purchase_entries" ADD CONSTRAINT "store_purchase_entries_purchaseId_fkey" FOREIGN KEY ("purchaseId") REFERENCES "store_purchase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "swiggy" ADD CONSTRAINT "swiggy_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "temporary_item_report_with_customer_order" ADD CONSTRAINT "temporary_item_report_with_customer_order_documentUploadTr_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "temporary_item_report_with_customer_order" ADD CONSTRAINT "temporary_item_report_with_customer_order_restaurantSKUCat_fkey" FOREIGN KEY ("restaurantSKUCategoryID") REFERENCES "restaurant_SKU_category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "temporary_item_report_with_customer_order" ADD CONSTRAINT "temporary_item_report_with_customer_order_restaurantSKUIte_fkey" FOREIGN KEY ("restaurantSKUItemVairantID") REFERENCES "restaurant_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "temporary_order_master" ADD CONSTRAINT "temporary_order_master_discountCouponID_fkey" FOREIGN KEY ("discountCouponID") REFERENCES "discount_coupons"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "temporary_order_master" ADD CONSTRAINT "temporary_order_master_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "unit_expenses_tally_data" ADD CONSTRAINT "unit_expenses_tally_data_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "unit_expenses_tally_data" ADD CONSTRAINT "unit_expenses_tally_data_expenseCategoryID_fkey" FOREIGN KEY ("expenseCategoryID") REFERENCES "expense_tally_data_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "unit_expenses_tally_data" ADD CONSTRAINT "unit_expenses_tally_data_restaurantID_fkey" FOREIGN KEY ("restaurantID") REFERENCES "restaurant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_categories" ADD CONSTRAINT "vendor_categories_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_categories" ADD CONSTRAINT "vendor_categories_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_categories" ADD CONSTRAINT "vendor_categories_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendors" ADD CONSTRAINT "vendors_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendors" ADD CONSTRAINT "vendors_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendors" ADD CONSTRAINT "vendors_restaurantID_fkey" FOREIGN KEY ("restaurantID") REFERENCES "restaurant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendors" ADD CONSTRAINT "vendors_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendors" ADD CONSTRAINT "vendors_vendorCatgeoryID_fkey" FOREIGN KEY ("vendorCatgeoryID") REFERENCES "vendor_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_category" ADD CONSTRAINT "waste_management_category_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_category" ADD CONSTRAINT "waste_management_category_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_category" ADD CONSTRAINT "waste_management_category_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_items" ADD CONSTRAINT "waste_management_items_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_items" ADD CONSTRAINT "waste_management_items_categoryID_fkey" FOREIGN KEY ("categoryID") REFERENCES "waste_management_category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_items" ADD CONSTRAINT "waste_management_items_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_items" ADD CONSTRAINT "waste_management_items_restaurantSKUItemVariantID_fkey" FOREIGN KEY ("restaurantSKUItemVariantID") REFERENCES "restaurant_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_items" ADD CONSTRAINT "waste_management_items_restaurantUserID_fkey" FOREIGN KEY ("restaurantUserID") REFERENCES "restaurant_users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_items" ADD CONSTRAINT "waste_management_items_storeSKUItemVariantID_fkey" FOREIGN KEY ("storeSKUItemVariantID") REFERENCES "store_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "waste_management_items" ADD CONSTRAINT "waste_management_items_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "zomato" ADD CONSTRAINT "zomato_documentUploadTrackingTableID_fkey" FOREIGN KEY ("documentUploadTrackingTableID") REFERENCES "document_uploads_tracking_table"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries_v2" ADD CONSTRAINT "non_chargeable_sales_entries_v2_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries_v2" ADD CONSTRAINT "non_chargeable_sales_entries_v2_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries_v2" ADD CONSTRAINT "non_chargeable_sales_entries_v2_ncItemSalesID_fkey" FOREIGN KEY ("ncItemSalesID") REFERENCES "non_chargeable_sales_v2"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries_v2" ADD CONSTRAINT "non_chargeable_sales_entries_v2_restaurantSKUItemID_fkey" FOREIGN KEY ("restaurantSKUItemID") REFERENCES "restaurant_new_SKU_items"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries_v2" ADD CONSTRAINT "non_chargeable_sales_entries_v2_restaurant_new_SKU_categor_fkey" FOREIGN KEY ("restaurant_new_SKU_categoryC_id") REFERENCES "restaurant_new_SKU_category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries_v2" ADD CONSTRAINT "non_chargeable_sales_entries_v2_storeSKUItemVarintID_fkey" FOREIGN KEY ("storeSKUItemVarintID") REFERENCES "store_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_entries_v2" ADD CONSTRAINT "non_chargeable_sales_entries_v2_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_v2" ADD CONSTRAINT "non_chargeable_sales_v2_approvedByUserID_fkey" FOREIGN KEY ("approvedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_v2" ADD CONSTRAINT "non_chargeable_sales_v2_createdByUserID_fkey" FOREIGN KEY ("createdByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_v2" ADD CONSTRAINT "non_chargeable_sales_v2_nonChargeableSaleCategoryID_fkey" FOREIGN KEY ("nonChargeableSaleCategoryID") REFERENCES "non_chargeable_sale_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_v2" ADD CONSTRAINT "non_chargeable_sales_v2_restaurantSKUItemID_fkey" FOREIGN KEY ("restaurantSKUItemID") REFERENCES "restaurant_new_SKU_items"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_v2" ADD CONSTRAINT "non_chargeable_sales_v2_restaurant_new_SKU_categoryC_id_fkey" FOREIGN KEY ("restaurant_new_SKU_categoryC_id") REFERENCES "restaurant_new_SKU_category"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_v2" ADD CONSTRAINT "non_chargeable_sales_v2_storeSKUItemVarintID_fkey" FOREIGN KEY ("storeSKUItemVarintID") REFERENCES "store_SKU_item_variants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "non_chargeable_sales_v2" ADD CONSTRAINT "non_chargeable_sales_v2_updatedByUserID_fkey" FOREIGN KEY ("updatedByUserID") REFERENCES "restaurant_users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_admin_permissionsToadmin_roles" ADD CONSTRAINT "_admin_permissionsToadmin_roles_A_fkey" FOREIGN KEY ("A") REFERENCES "admin_permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_admin_permissionsToadmin_roles" ADD CONSTRAINT "_admin_permissionsToadmin_roles_B_fkey" FOREIGN KEY ("B") REFERENCES "admin_roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_restaurant_permissionsTorestaurant_roles" ADD CONSTRAINT "_restaurant_permissionsTorestaurant_roles_A_fkey" FOREIGN KEY ("A") REFERENCES "restaurant_permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_restaurant_permissionsTorestaurant_roles" ADD CONSTRAINT "_restaurant_permissionsTorestaurant_roles_B_fkey" FOREIGN KEY ("B") REFERENCES "restaurant_roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

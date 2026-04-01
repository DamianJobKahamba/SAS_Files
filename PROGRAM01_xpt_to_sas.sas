/* ============================================================
   PROGRAM 01 — CONVERTING NHANES .XPT FILES TO SAS DATASETS
   ============================================================
   Purpose  : Convert all NHANES transport (.XPT) files to native
              SAS datasets (.sas7bdat) stored in the Buxbaum library.
   Input    : NHANES .XPT files (44 total: 11 domains × 4 cycles)
   Output   : Native SAS datasets in the Buxbaum library
   Next Step: Run PROGRAM02_rename_datasets.sas
   ============================================================

   INSTRUCTIONS:
   1. Update the libname path below to point to your SAS library folder.
   2. Update all XPT file paths to match where you saved your NHANES files.
   3. Run the entire program — it must complete without errors before
      proceeding to Program 2.

   NOTE: The libname DAMIAN is reassigned before each PROC COPY.
   This is intentional — SAS overwrites the library reference each time,
   pointing it to a new .XPT file. This is the correct approach.
   ============================================================ */

/* ── SET YOUR LIBRARY PATH HERE ── */
libname Buxbaum '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/SAS DATA';
/* Change the path above to match your own directory */


/* ============================================================
   SURVEY CYCLE: 2011-2012
   NHANES File Suffix: _G
   ============================================================ */

/* 1. ALCOHOL (ALQ_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/ALCOHOL_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 2. BMI / BODY MEASUREMENTS (BMX_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/BMI_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 3. DEMOGRAPHICS (DEMO_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DEMO_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 4. DIABETES (DIQ_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DIABETES_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 5. DIETARY RECALL DAY 1 TOTALS (DR1TOT_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DIET_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 6. HbA1c / GLYCATED HAEMOGLOBIN (GHB_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/HBA1C_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 7. HEART / MEDICAL CONDITIONS (MCQ_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/HEART_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 8. KIDNEY CONDITIONS (KIQ_U_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/KIDNEY_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 9. PHYSICAL ACTIVITY (PAQ_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/PHYSICAL_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 10. SLEEP DISORDERS (SLQ_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/SLEEP_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

/* 11. SMOKING (SMQ_G) */
libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/SMOKE_2011.xpt';
proc copy in=DAMIAN out=Buxbaum; run;


/* ============================================================
   SURVEY CYCLE: 2013-2014
   NHANES File Suffix: _H
   ============================================================ */

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/ALCOHOL_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/BMI_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DEMO_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DIABETES_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DIET_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/HBA1C_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/HEART_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/KIDNEY_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/PHYSICAL_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/SLEEP_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/SMOKE_2013.xpt';
proc copy in=DAMIAN out=Buxbaum; run;


/* ============================================================
   SURVEY CYCLE: 2015-2016
   NHANES File Suffix: _I
   ============================================================ */

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/ALCOHOL_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/BMI_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DEMO_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DIABETES_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DIET_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/HBA1C_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/HEART_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/KIDNEY_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/PHYSICAL_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/SLEEP_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/SMOKE_2015.xpt';
proc copy in=DAMIAN out=Buxbaum; run;


/* ============================================================
   SURVEY CYCLE: 2017-2018
   NHANES File Suffix: _J
   ============================================================ */

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/ALCOHOL_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/BMI_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DEMO_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DIABETES_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/DIET_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/HBA1C_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/HEART_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/KIDNEY_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/PHYSICAL_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/SLEEP_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;

libname DAMIAN xport '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/XPT DATA FILES/SMOKE_2017.xpt';
proc copy in=DAMIAN out=Buxbaum; run;


/* ============================================================
   QUALITY CONTROL
   After running, verify 44 datasets now exist in your Buxbaum library.
   ============================================================ */
proc datasets library=Buxbaum; run; quit;
/* You should see datasets like alq_g, alq_h, alq_i, alq_j,
   bmx_g, bmx_h, bmx_i, bmx_j, demo_g, demo_h, etc. */

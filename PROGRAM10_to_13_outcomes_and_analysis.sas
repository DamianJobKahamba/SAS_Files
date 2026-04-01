/* ============================================================
   PROGRAM 10 — CREATE CVD COMPOSITE OUTCOME VARIABLE
   ============================================================
   Purpose : Create the binary dependent variable CVD from five
             individual NHANES cardiovascular condition items.
   Input   : Buxbaum.combined12
   Output  : Buxbaum.combined13

   CVD = "Yes"  if any of CHF, CHD, Angina, Heart_Attack, Stroke = 1
   CVD = "No"   if ALL five conditions = 2 (No)
   CVD = "Missing" for any other combination

   NHANES CODING:
   1 = Yes (condition confirmed)
   2 = No  (condition denied)
   ============================================================ */

libname Buxbaum '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/SAS DATA';

data Buxbaum.combined13;
  set Buxbaum.combined12;
  length CVD $30;
  if   (CHF=1 or CHD=1 or Heart_Attack=1 or Stroke=1 or Angina=1)
                                              then CVD='Yes';
  else if (CHF=2 and CHD=2 and Heart_Attack=2 and Stroke=2 and Angina=2)
                                              then CVD='No';
  else CVD='Missing';
run;

/* ── QUALITY CONTROL ── */
proc freq data=buxbaum.combined13;
  tables CVD / missing;
run;

/* Cross-check against raw variables */
proc sql;
  select
    count(*) as N_total,
    sum(CHF=1 or CHD=1 or Heart_Attack=1 or Stroke=1 or Angina=1) as Yes,
    sum(CHF=2 and CHD=2 and Heart_Attack=2 and Stroke=2 and Angina=2) as No,
    sum(
      not(CHF=1 or CHD=1 or Heart_Attack=1 or Stroke=1 or Angina=1)
      and
      not(CHF=2 and CHD=2 and Heart_Attack=2 and Stroke=2 and Angina=2)
    ) as Missing
  from buxbaum.combined12;
quit;
/* VERIFY: PROC FREQ counts and PROC SQL counts must match */


/* ============================================================
   PROGRAM 11 — CREATE REMAINING CATEGORICAL VARIABLES
   ============================================================
   Purpose : Create labelled categorical variables for Gender,
             Race/Ethnicity, Diabetes, Kidney, and Sleep Disorder
             from raw NHANES numeric codes.
   Input   : Buxbaum.combined13
   Output  : Buxbaum.combined18 (via 14, 15, 16, 17)
   ============================================================ */

/* ── GENDER ──
   RIAGENDR: 1=Male, 2=Female */
data Buxbaum.combined14;
  set Buxbaum.combined13;
  length Gender1 $30;
  if      Gender=1 then Gender1='Male';
  else if Gender=2 then Gender1='Female';
  else Gender1='Missing';
run;

/* QC */
proc freq data=buxbaum.combined14; tables Gender1 / missing; run;
proc sql;
  select count(*) as N_total,
    sum(Gender=1) as Male,
    sum(Gender=2) as Female,
    sum(not(Gender=1) and not(Gender=2)) as Missing
  from buxbaum.combined13;
quit;


/* ── RACE / ETHNICITY ──
   RIDRETH1: 1=Mexican American, 2=Other Hispanic,
             3=Non-Hispanic White, 4=Non-Hispanic Black,
             5=Other Race Including Multi-Racial */
data Buxbaum.combined15;
  set Buxbaum.combined14;
  length Race1 $40;
  if      Race=1 then Race1='Mexican American';
  else if Race=2 then Race1='Other Hispanic';
  else if Race=3 then Race1='Non-Hispanic White';
  else if Race=4 then Race1='Non-Hispanic Black';
  else if Race=5 then Race1='Other Race - Including Multi-Racial';
  else Race1='Missing';
run;

/* QC */
proc freq data=buxbaum.combined15; tables Race1 / missing; run;
proc sql;
  select count(*) as N_total,
    sum(Race=1) as Mexican_American,
    sum(Race=2) as Other_Hispanic,
    sum(Race=3) as NH_White,
    sum(Race=4) as NH_Black,
    sum(Race=5) as Other_Race,
    sum(not(Race in (1,2,3,4,5))) as Missing
  from buxbaum.combined14;
quit;


/* ── DIABETES ──
   DIQ010: 1=Yes (diagnosed), 2=No, 3=Borderline/Pre-Diabetes */
data Buxbaum.combined16;
  set Buxbaum.combined15;
  length Diabetes1 $30;
  if      Diabetes=1 then Diabetes1='Yes';
  else if Diabetes=2 then Diabetes1='No';
  else if Diabetes=3 then Diabetes1='Borderline';
  else Diabetes1='Missing';
run;

/* QC */
proc freq data=buxbaum.combined16; tables Diabetes1 / missing; run;
proc sql;
  select count(*) as N_total,
    sum(Diabetes=1) as Yes,
    sum(Diabetes=2) as No,
    sum(Diabetes=3) as Borderline,
    sum(not(Diabetes in (1,2,3))) as Missing
  from buxbaum.combined15;
quit;


/* ── KIDNEY DISEASE ──
   KIQ022: 1=Yes (weak/failing kidneys), 2=No */
data Buxbaum.combined17;
  set Buxbaum.combined16;
  length Kidney_Issue $30;
  if      Kidney=1 then Kidney_Issue='Yes';
  else if Kidney=2 then Kidney_Issue='No';
  else Kidney_Issue='Missing';
run;

/* QC */
proc freq data=buxbaum.combined17; tables Kidney_Issue / missing; run;
proc sql;
  select count(*) as N_total,
    sum(Kidney=1) as Yes,
    sum(Kidney=2) as No,
    sum(not(Kidney in (1,2))) as Missing
  from buxbaum.combined16;
quit;


/* ── SLEEP DISORDER ──
   SLQ050: 1=Yes (told have sleep disorder), 2=No */
data Buxbaum.combined18;
  set Buxbaum.combined17;
  length Sleep_Disorder1 $30;
  if      Sleep_Disorder=1 then Sleep_Disorder1='Yes';
  else if Sleep_Disorder=2 then Sleep_Disorder1='No';
  else Sleep_Disorder1='Missing';
run;

/* QC */
proc freq data=buxbaum.combined18; tables Sleep_Disorder1 / missing; run;
proc sql;
  select count(*) as N_total,
    sum(Sleep_Disorder=1) as Yes,
    sum(Sleep_Disorder=2) as No,
    sum(not(Sleep_Disorder in (1,2))) as Missing
  from buxbaum.combined17;
quit;


/* ============================================================
   PROGRAM 12 — CREATE DIETARY NUTRIENT DENSITY RATIOS
   ============================================================
   Purpose : Express all dietary variables as nutrient density
             ratios (amount per kilocalorie) to adjust for
             total energy intake differences between participants.
             This is the standard nutritional epidemiology approach
             (Willett, 1997 energy adjustment method).
   Input   : Buxbaum.combined18
   Output  : Buxbaum.combined19

   RATIOS CREATED:
   Sodium_Ratio           = Sodium (mg)          / Energy (kcal)
   Cholesterol_Ratio      = Cholesterol (mg)      / Energy (kcal)
   Saturated_Fats_Ratio   = Saturated Fats (g)    / Energy (kcal)
   Unsaturated_Fats_Ratio = Unsaturated Fats3 (g) / Energy (kcal)
   Fiber_Ratio            = Fiber (g)             / Energy (kcal)
   ============================================================ */

data Buxbaum.COMBINED19;
  set Buxbaum.COMBINED18;

  /* Check for missing values before division to prevent errors */
  if missing(Sodium)           or missing(Energy) then Sodium_Ratio=.;
  else Sodium_Ratio           = Sodium           / Energy;

  if missing(Cholesterol)      or missing(Energy) then Cholesterol_Ratio=.;
  else Cholesterol_Ratio      = Cholesterol      / Energy;

  if missing(Saturated_Fats)   or missing(Energy) then Saturated_Fats_Ratio=.;
  else Saturated_Fats_Ratio   = Saturated_Fats   / Energy;

  if missing(Unsaturated_Fats3) or missing(Energy) then Unsaturated_Fats_Ratio=.;
  else Unsaturated_Fats_Ratio = Unsaturated_Fats3 / Energy;

  if missing(Fiber)            or missing(Energy) then Fiber_Ratio=.;
  else Fiber_Ratio            = Fiber            / Energy;
run;

/* QC — Check all ratios computed correctly */
proc means data=buxbaum.combined19 n nmiss mean min max;
  var Sodium_Ratio Cholesterol_Ratio Saturated_Fats_Ratio
      Unsaturated_Fats_Ratio Fiber_Ratio;
run;

/* Verify Fiber_Ratio = Fiber/Energy for all non-missing rows */
proc sql;
  select count(*) as Matching_Rows
  from Buxbaum.COMBINED19
  where not missing(Fiber_ratio)
    and abs(Fiber_Ratio - (Fiber/Energy)) < 0.00001;
quit;

/* Check dataset contents */
proc contents data=Buxbaum.combined19; run;


/* ============================================================
   PROGRAM 13 — DOMAIN DEFINITION AND COMPLETE SURVEY ANALYSIS
   ============================================================
   Purpose : (1) Define the analytical domain (adults aged 20-40
                 with non-missing CVD status)
             (2) Run all descriptive, hypothesis testing, and
                 regression analyses
   Input   : Buxbaum.combined19
   Output  : Buxbaum.combined20 + analytical results

   CRITICAL IMPORTANT NOTE:
   In complex survey analysis, subpopulation analysis must ALWAYS
   use a domain variable with WHERE inside PROC SURVEY procedures.
   NEVER subset the dataset before running survey procedures.
   Subsetting removes observations needed for valid variance
   estimation and produces incorrect standard errors.
   ============================================================ */


/* ══════════════════════════════════════════════════════════
   STEP 1: CREATE DOMAIN VARIABLE
   ══════════════════════════════════════════════════════════
   Domain = "Yes" : Study subpopulation (Age 20-40, CVD not missing)
   Domain = "No"  : Outside age range
   Domain = ""    : Missing age
   ══════════════════════════════════════════════════════════ */

data BUXBAUM.COMBINED20;
  set BUXBAUM.COMBINED19;
  length Domain $3;
  if missing(Age)                         then Domain='';
  else if 20<=Age<=40 and CVD='Yes'       then Domain='Yes';
  else if 20<=Age<=40 and CVD='No'        then Domain='Yes';
  else Domain='No';
run;

/* ── DOMAIN QUALITY CONTROL ── */
/* 1. Verify Age range in full dataset */
proc means data=BUXBAUM.COMBINED20;
  var Age;
run;

/* 2. Verify Age range in domain only (should be min=20, max=40) */
proc means data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  var Age;
run;

/* 3. Confirm no CVD='Missing' participants in domain (should be 0) */
proc sql;
  select count(*) as Count_Missing_CVD_in_Domain
  from BUXBAUM.COMBINED20
  where CVD='Missing' and Domain='Yes';
quit;

/* 4. Check CVD distribution in domain */
proc freq data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  tables CVD / missing;
run;


/* ══════════════════════════════════════════════════════════
   STEP 2: DESCRIPTIVE ANALYSIS — CONTINUOUS VARIABLES
   Using PROC SURVEYMEANS with complex survey design
   ══════════════════════════════════════════════════════════ */

proc surveymeans data=BUXBAUM.COMBINED20 mean stderr clm;
  where Domain='Yes';
  cluster  SDMVPSU;
  strata   SDMVSTRA;
  weight   WEIGHT;
  var Age Sodium_Ratio Cholesterol_Ratio Saturated_Fats_Ratio
      Unsaturated_Fats_Ratio Fiber_Ratio Hba1c;
run;


/* ══════════════════════════════════════════════════════════
   STEP 3: DESCRIPTIVE ANALYSIS — CATEGORICAL VARIABLES
   Using PROC SURVEYFREQ with complex survey design
   ══════════════════════════════════════════════════════════ */

proc surveyfreq data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU;
  strata  SDMVSTRA;
  weight  WEIGHT;
  tables Alcohol3 Physical_Activity4 Smoke3 BMI1 CVD
         Gender1 Race1 Diabetes1 Kidney_Issue Sleep_Disorder1;
run;


/* ══════════════════════════════════════════════════════════
   STEP 4: HYPOTHESIS TESTING — CONTINUOUS VARIABLES
   PROC SURVEYREG tests whether each continuous variable
   differs between CVD=Yes and CVD=No groups.
   F-statistic p-value < 0.05 = significant difference.
   ══════════════════════════════════════════════════════════ */

/* Age vs CVD */
proc surveyreg data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU; strata SDMVSTRA; weight WEIGHT;
  class CVD (ref='Yes');
  model Age = CVD;
run;

/* Sodium Ratio vs CVD */
proc surveyreg data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU; strata SDMVSTRA; weight WEIGHT;
  class CVD (ref='Yes');
  model Sodium_Ratio = CVD;
run;

/* Cholesterol Ratio vs CVD */
proc surveyreg data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU; strata SDMVSTRA; weight WEIGHT;
  class CVD (ref='Yes');
  model Cholesterol_Ratio = CVD;
run;

/* Saturated Fats Ratio vs CVD */
proc surveyreg data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU; strata SDMVSTRA; weight WEIGHT;
  class CVD (ref='Yes');
  model Saturated_Fats_Ratio = CVD;
run;

/* Unsaturated Fats Ratio vs CVD */
proc surveyreg data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU; strata SDMVSTRA; weight WEIGHT;
  class CVD (ref='Yes');
  model Unsaturated_Fats_Ratio = CVD;
run;

/* Fiber Ratio vs CVD */
proc surveyreg data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU; strata SDMVSTRA; weight WEIGHT;
  class CVD (ref='Yes');
  model Fiber_Ratio = CVD;
run;

/* HbA1c vs CVD */
proc surveyreg data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU; strata SDMVSTRA; weight WEIGHT;
  class CVD (ref='Yes');
  model Hba1c = CVD;
run;


/* ══════════════════════════════════════════════════════════
   STEP 5: CHI-SQUARE TESTS — CATEGORICAL VARIABLES
   Rao-Scott chi-square is the design-corrected test appropriate
   for complex survey data (NOT standard Pearson chi-square).
   ══════════════════════════════════════════════════════════ */

proc surveyfreq data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU;
  strata  SDMVSTRA;
  weight  WEIGHT;
  tables (Alcohol3 Physical_Activity4 Smoke3 BMI1 Gender1
          Race1 Diabetes1 Kidney_Issue Sleep_Disorder1) * CVD / chisq;
run;


/* ══════════════════════════════════════════════════════════
   STEP 6A: FULL MODEL — BINARY LOGISTIC REGRESSION
   All 16 candidate predictors included.
   Uses effects coding (SAS default for class variables).
   ══════════════════════════════════════════════════════════ */

proc surveylogistic data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU;
  strata  SDMVSTRA;
  weight  WEIGHT;
  class Alcohol3          (ref='Non-Drinker')
        Physical_Activity4 (ref='Sufficient_Activity')
        Smoke3             (ref='Non_Smoker')
        BMI1               (ref='Normal_Weight')
        Gender1            (ref='Male')
        Race1              (ref='Non-Hispanic White')
        Diabetes1          (ref='No')
        Kidney_Issue       (ref='No')
        Sleep_Disorder1    (ref='No');
  model CVD(event='Yes') = Age
        Sodium_Ratio Cholesterol_Ratio Saturated_Fats_Ratio
        Unsaturated_Fats_Ratio Fiber_Ratio Hba1c
        Alcohol3 Physical_Activity4 Smoke3 BMI1
        Gender1 Race1 Diabetes1 Kidney_Issue Sleep_Disorder1;
run;


/* ══════════════════════════════════════════════════════════
   STEP 6B: REDUCED MODEL — BINARY LOGISTIC REGRESSION
   Variables selected based on:
   (1) Statistical significance in full model (p<0.10)
   (2) Biological plausibility
   (3) Standard epidemiological confounder control practice

   Retained:    Age, Cholesterol_Ratio, Fiber_Ratio (dietary/continuous)
                Smoke3, Diabetes1, Kidney_Issue, Sleep_Disorder1 (clinical)
                Gender1, Race1 (demographic confounders)

   Removed:     Sodium_Ratio, Saturated_Fats_Ratio, Unsaturated_Fats_Ratio,
                Hba1c, Alcohol3, Physical_Activity4, BMI1

   This model is used as the basis for the CVD risk calculator.
   c-statistic = 0.753 (vs 0.752 for full model — virtually identical)
   Uses 293 more observations (no HbA1c missingness)
   ══════════════════════════════════════════════════════════ */

proc surveylogistic data=BUXBAUM.COMBINED20;
  where Domain='Yes';
  cluster SDMVPSU;
  strata  SDMVSTRA;
  weight  WEIGHT;
  class Smoke3          (ref='Non_Smoker')
        Gender1          (ref='Male')
        Race1            (ref='Non-Hispanic White')
        Diabetes1        (ref='No')
        Kidney_Issue     (ref='No')
        Sleep_Disorder1  (ref='No');
  model CVD(event='Yes') = Age
        Cholesterol_Ratio Fiber_Ratio
        Smoke3 Gender1 Race1 Diabetes1 Kidney_Issue Sleep_Disorder1;
run;

/*
   ═══════════════════════════════════════════════════════
   EXPECTED KEY RESULTS FROM REDUCED MODEL:
   ═══════════════════════════════════════════════════════
   Observations used:   6,902
   CVD=Yes cases:       101
   c-statistic:         0.753
   % Concordant:        73.0%

   Significant predictors (Type 3 p-value):
   Age                    p = 0.0103
   Fiber Ratio            p = 0.0051
   Smoking Status         p < 0.0001
   Diabetes Status        p < 0.0001
   Kidney Issue           p < 0.0001
   Sleep Disorder         p = 0.0282
   Cholesterol Ratio      p = 0.0735 (borderline)

   Key Odds Ratios:
   Age (per year):          OR = 1.056 (1.013-1.100)
   Current Smoker vs Non:   OR = 1.913 (1.051-3.481)
   Diabetes Yes vs No:      OR = 4.694 (2.110-10.444)
   Diabetes Border vs No:   OR = 4.728 (1.081-20.684)
   Kidney Yes vs No:        OR = 3.142 (1.150-8.584)
   Sleep Disorder Yes vs No:OR = 1.907 (1.074-3.387)
   ═══════════════════════════════════════════════════════
*/

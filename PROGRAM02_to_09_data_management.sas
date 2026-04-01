/* ============================================================
   PROGRAM 02 — RENAME DATASETS TO MEANINGFUL NAMES
   ============================================================
   Purpose : Rename NHANES abbreviated dataset names (e.g., alq_g)
             to descriptive names (e.g., Alcohol2011) for clarity.
   Input   : Native SAS datasets from Program 01
   Output  : Renamed datasets (44 total)
   ============================================================ */

libname Buxbaum '/home/u64323474/DAMIAN/BUXBAUM FINAL PROJECT/SAS DATA';

/* ── 2011–2012 ── */
data Buxbaum.Alcohol2011;  set Buxbaum.alq_g;  run;
data Buxbaum.BMI2011;      set Buxbaum.bmx_g;  run;
data Buxbaum.Demo2011;     set Buxbaum.demo_g; run;
data Buxbaum.Diabetes2011; set Buxbaum.diq_g;  run;
data Buxbaum.Diet2011;     set Buxbaum.dr1tot_g; run;
data Buxbaum.Hba1c2011;    set Buxbaum.ghb_g;  run;
data Buxbaum.Heart2011;    set Buxbaum.mcq_g;  run;
data Buxbaum.Kidney2011;   set Buxbaum.kiq_u_g; run;
data Buxbaum.Physical2011; set Buxbaum.paq_g;  run;
data Buxbaum.Sleep2011;    set Buxbaum.slq_g;  run;
data Buxbaum.Smoke2011;    set Buxbaum.smq_g;  run;

/* ── 2013–2014 ── */
data Buxbaum.Alcohol2013;  set Buxbaum.alq_h;  run;
data Buxbaum.BMI2013;      set Buxbaum.bmx_h;  run;
data Buxbaum.Demo2013;     set Buxbaum.demo_h; run;
data Buxbaum.Diabetes2013; set Buxbaum.diq_h;  run;
data Buxbaum.Diet2013;     set Buxbaum.dr1tot_h; run;
data Buxbaum.Hba1c2013;    set Buxbaum.ghb_h;  run;
data Buxbaum.Heart2013;    set Buxbaum.mcq_h;  run;
data Buxbaum.Kidney2013;   set Buxbaum.kiq_u_h; run;
data Buxbaum.Physical2013; set Buxbaum.paq_h;  run;
data Buxbaum.Sleep2013;    set Buxbaum.slq_h;  run;
data Buxbaum.Smoke2013;    set Buxbaum.smq_h;  run;

/* ── 2015–2016 ── */
data Buxbaum.Alcohol2015;  set Buxbaum.alq_i;  run;
data Buxbaum.BMI2015;      set Buxbaum.bmx_i;  run;
data Buxbaum.Demo2015;     set Buxbaum.demo_i; run;
data Buxbaum.Diabetes2015; set Buxbaum.diq_i;  run;
data Buxbaum.Diet2015;     set Buxbaum.dr1tot_i; run;
data Buxbaum.Hba1c2015;    set Buxbaum.ghb_i;  run;
data Buxbaum.Heart2015;    set Buxbaum.mcq_i;  run;
data Buxbaum.Kidney2015;   set Buxbaum.kiq_u_i; run;
data Buxbaum.Physical2015; set Buxbaum.paq_i;  run;
data Buxbaum.Sleep2015;    set Buxbaum.slq_i;  run;
data Buxbaum.Smoke2015;    set Buxbaum.smq_i;  run;

/* ── 2017–2018 ── */
data Buxbaum.Alcohol2017;  set Buxbaum.alq_j;  run;
data Buxbaum.BMI2017;      set Buxbaum.bmx_j;  run;
data Buxbaum.Demo2017;     set Buxbaum.demo_j; run;
data Buxbaum.Diabetes2017; set Buxbaum.diq_j;  run;
data Buxbaum.Diet2017;     set Buxbaum.dr1tot_j; run;
data Buxbaum.Hba1c2017;    set Buxbaum.ghb_j;  run;
data Buxbaum.Heart2017;    set Buxbaum.mcq_j;  run;
data Buxbaum.Kidney2017;   set Buxbaum.kiq_u_j; run;
data Buxbaum.Physical2017; set Buxbaum.paq_j;  run;
data Buxbaum.Sleep2017;    set Buxbaum.slq_j;  run;
data Buxbaum.Smoke2017;    set Buxbaum.smq_j;  run;


/* ============================================================
   PROGRAM 03 — MERGE ALL DOMAINS BY SEQN (PARTICIPANT ID)
   ============================================================
   Purpose : Merge 11 domain datasets per cycle into one combined
             dataset using the common participant identifier SEQN.
             Uses inner join — keeps only participants present in ALL
             11 domain files.
   Input   : Renamed datasets from Program 02
   Output  : Buxbaum.Combined1_2011 / 2013 / 2015 / 2017
   ============================================================ */

/* ── 2011 ── */
proc sort data=Buxbaum.demo2011;     by SEQN; run;
proc sort data=Buxbaum.bmi2011;      by SEQN; run;
proc sort data=Buxbaum.alcohol2011;  by SEQN; run;
proc sort data=Buxbaum.diabetes2011; by SEQN; run;
proc sort data=Buxbaum.diet2011;     by SEQN; run;
proc sort data=Buxbaum.hba1c2011;    by SEQN; run;
proc sort data=Buxbaum.heart2011;    by SEQN; run;
proc sort data=Buxbaum.kidney2011;   by SEQN; run;
proc sort data=Buxbaum.physical2011; by SEQN; run;
proc sort data=Buxbaum.sleep2011;    by SEQN; run;
proc sort data=Buxbaum.smoke2011;    by SEQN; run;

data Buxbaum.Combined1_2011;
  merge Buxbaum.demo2011     (in=a)
        Buxbaum.bmi2011      (in=b)
        Buxbaum.alcohol2011  (in=c)
        Buxbaum.diabetes2011 (in=d)
        Buxbaum.diet2011     (in=e)
        Buxbaum.hba1c2011    (in=f)
        Buxbaum.heart2011    (in=g)
        Buxbaum.kidney2011   (in=h)
        Buxbaum.physical2011 (in=i)
        Buxbaum.sleep2011    (in=j)
        Buxbaum.smoke2011    (in=k);
  by SEQN;
  if a and b and c and d and e and f and g and h and i and j and k;
run;

/* QC: Check observation count */
proc sql; select count(*) as N_2011 from Buxbaum.Combined1_2011; quit;

/* ── 2013 ── */
proc sort data=Buxbaum.demo2013;     by SEQN; run;
proc sort data=Buxbaum.bmi2013;      by SEQN; run;
proc sort data=Buxbaum.alcohol2013;  by SEQN; run;
proc sort data=Buxbaum.diabetes2013; by SEQN; run;
proc sort data=Buxbaum.diet2013;     by SEQN; run;
proc sort data=Buxbaum.hba1c2013;    by SEQN; run;
proc sort data=Buxbaum.heart2013;    by SEQN; run;
proc sort data=Buxbaum.kidney2013;   by SEQN; run;
proc sort data=Buxbaum.physical2013; by SEQN; run;
proc sort data=Buxbaum.sleep2013;    by SEQN; run;
proc sort data=Buxbaum.smoke2013;    by SEQN; run;

data Buxbaum.Combined1_2013;
  merge Buxbaum.demo2013     (in=a)
        Buxbaum.bmi2013      (in=b)
        Buxbaum.alcohol2013  (in=c)
        Buxbaum.diabetes2013 (in=d)
        Buxbaum.diet2013     (in=e)
        Buxbaum.hba1c2013    (in=f)
        Buxbaum.heart2013    (in=g)
        Buxbaum.kidney2013   (in=h)
        Buxbaum.physical2013 (in=i)
        Buxbaum.sleep2013    (in=j)
        Buxbaum.smoke2013    (in=k);
  by SEQN;
  if a and b and c and d and e and f and g and h and i and j and k;
run;

/* ── 2015 ── */
proc sort data=Buxbaum.demo2015;     by SEQN; run;
proc sort data=Buxbaum.bmi2015;      by SEQN; run;
proc sort data=Buxbaum.alcohol2015;  by SEQN; run;
proc sort data=Buxbaum.diabetes2015; by SEQN; run;
proc sort data=Buxbaum.diet2015;     by SEQN; run;
proc sort data=Buxbaum.hba1c2015;    by SEQN; run;
proc sort data=Buxbaum.heart2015;    by SEQN; run;
proc sort data=Buxbaum.kidney2015;   by SEQN; run;
proc sort data=Buxbaum.physical2015; by SEQN; run;
proc sort data=Buxbaum.sleep2015;    by SEQN; run;
proc sort data=Buxbaum.smoke2015;    by SEQN; run;

data Buxbaum.Combined1_2015;
  merge Buxbaum.demo2015     (in=a)
        Buxbaum.bmi2015      (in=b)
        Buxbaum.alcohol2015  (in=c)
        Buxbaum.diabetes2015 (in=d)
        Buxbaum.diet2015     (in=e)
        Buxbaum.hba1c2015    (in=f)
        Buxbaum.heart2015    (in=g)
        Buxbaum.kidney2015   (in=h)
        Buxbaum.physical2015 (in=i)
        Buxbaum.sleep2015    (in=j)
        Buxbaum.smoke2015    (in=k);
  by SEQN;
  if a and b and c and d and e and f and g and h and i and j and k;
run;

/* ── 2017 ── */
proc sort data=Buxbaum.demo2017;     by SEQN; run;
proc sort data=Buxbaum.bmi2017;      by SEQN; run;
proc sort data=Buxbaum.alcohol2017;  by SEQN; run;
proc sort data=Buxbaum.diabetes2017; by SEQN; run;
proc sort data=Buxbaum.diet2017;     by SEQN; run;
proc sort data=Buxbaum.hba1c2017;    by SEQN; run;
proc sort data=Buxbaum.heart2017;    by SEQN; run;
proc sort data=Buxbaum.kidney2017;   by SEQN; run;
proc sort data=Buxbaum.physical2017; by SEQN; run;
proc sort data=Buxbaum.sleep2017;    by SEQN; run;
proc sort data=Buxbaum.smoke2017;    by SEQN; run;

data Buxbaum.Combined1_2017;
  merge Buxbaum.demo2017     (in=a)
        Buxbaum.bmi2017      (in=b)
        Buxbaum.alcohol2017  (in=c)
        Buxbaum.diabetes2017 (in=d)
        Buxbaum.diet2017     (in=e)
        Buxbaum.hba1c2017    (in=f)
        Buxbaum.heart2017    (in=g)
        Buxbaum.kidney2017   (in=h)
        Buxbaum.physical2017 (in=i)
        Buxbaum.sleep2017    (in=j)
        Buxbaum.smoke2017    (in=k);
  by SEQN;
  if a and b and c and d and e and f and g and h and i and j and k;
run;


/* ============================================================
   PROGRAM 04 — ADD SURVEY CYCLE YEAR VARIABLE
   ============================================================
   Purpose : Add a YEAR variable to each dataset so observations
             can be traced back to their survey cycle.
   Input   : Combined1_YYYY from Program 03
   Output  : Combined2_YYYY
   ============================================================ */

data buxbaum.combined2_2011;
  set buxbaum.combined1_2011;
  YEAR = 2011;
run;

data buxbaum.combined2_2013;
  set buxbaum.combined1_2013;
  YEAR = 2013;
run;

data buxbaum.combined2_2015;
  set buxbaum.combined1_2015;
  YEAR = 2015;
run;

data buxbaum.combined2_2017;
  set buxbaum.combined1_2017;
  YEAR = 2017;
run;


/* ============================================================
   PROGRAM 05 — FILTER TO REQUIRED VARIABLES ONLY
   ============================================================
   Purpose : Reduce each dataset to only the variables needed for
             this analysis. Improves performance and reduces file size.
   Input   : Combined2_YYYY
   Output  : Combined3_YYYY
   ============================================================

   VARIABLE KEY:
   SEQN      = Participant unique ID
   RIDAGEYR  = Age in years at screening
   RIDRETH1  = Race/ethnicity (1-5)
   RIAGENDR  = Gender (1=Male, 2=Female)
   SDMVSTRA  = Survey stratum (REQUIRED for survey analysis)
   SDMVPSU   = Survey cluster/PSU (REQUIRED for survey analysis)
   WTDRD1    = Dietary Day 1 weight (used to create WEIGHT)
   MCQ160b   = Congestive heart failure (1=Yes, 2=No)
   MCQ160c   = Coronary heart disease (1=Yes, 2=No)
   MCQ160d   = Angina (1=Yes, 2=No)
   MCQ160e   = Heart attack (1=Yes, 2=No)
   MCQ160f   = Stroke (1=Yes, 2=No)
   ALQ130    = Avg drinks per day on drinking days
   ALQ120Q   = Number of drinking days in past year
   BMXBMI    = Body Mass Index (kg/m2)
   DR1TSODI  = Sodium (mg)
   DR1TCHOL  = Total cholesterol (mg)
   DR1TSFAT  = Saturated fatty acids (g)
   DR1TMFAT  = Monounsaturated fatty acids (g)
   DR1TPFAT  = Polyunsaturated fatty acids (g)
   DR1TFIBE  = Dietary fiber (g)
   DR1TKCAL  = Energy (kcal) -- DENOMINATOR for all ratios
   LBXGH     = Glycated haemoglobin / HbA1c (%)
   DIQ010    = Doctor told you have diabetes (1=Yes, 2=No, 3=Borderline)
   KIQ022    = Weak or failing kidneys (1=Yes, 2=No)
   PAQ650    = Vigorous activity days per week
   PAQ655    = Minutes vigorous activity per day
   SLQ050    = Doctor told you have sleep disorder (1=Yes, 2=No)
   SMQ020    = Smoked 100+ cigarettes in life (1=Yes, 2=No)
   SMQ040    = Do you now smoke (1=Every day, 2=Some days, 3=Not at all)
   ============================================================ */

data buxbaum.combined3_2011;
  set buxbaum.combined2_2011 (keep=
    SEQN RIDAGEYR RIDRETH1 RIAGENDR SDMVSTRA SDMVPSU WTDRD1
    MCQ160b MCQ160c MCQ160d MCQ160e MCQ160f
    ALQ130 ALQ120Q BMXBMI
    DR1TSODI DR1TCHOL DR1TSFAT DR1TMFAT DR1TPFAT DR1TFIBE DR1TKCAL
    LBXGH DIQ010 KIQ022 PAQ650 PAQ655 SLQ050 SMQ020 SMQ040 YEAR);
run;

data buxbaum.combined3_2013;
  set buxbaum.combined2_2013 (keep=
    SEQN RIDAGEYR RIDRETH1 RIAGENDR SDMVSTRA SDMVPSU WTDRD1
    MCQ160b MCQ160c MCQ160d MCQ160e MCQ160f
    ALQ130 ALQ120Q BMXBMI
    DR1TSODI DR1TCHOL DR1TSFAT DR1TMFAT DR1TPFAT DR1TFIBE DR1TKCAL
    LBXGH DIQ010 KIQ022 PAQ650 PAQ655 SLQ050 SMQ020 SMQ040 YEAR);
run;

data buxbaum.combined3_2015;
  set buxbaum.combined2_2015 (keep=
    SEQN RIDAGEYR RIDRETH1 RIAGENDR SDMVSTRA SDMVPSU WTDRD1
    MCQ160b MCQ160c MCQ160d MCQ160e MCQ160f
    ALQ130 ALQ120Q BMXBMI
    DR1TSODI DR1TCHOL DR1TSFAT DR1TMFAT DR1TPFAT DR1TFIBE DR1TKCAL
    LBXGH DIQ010 KIQ022 PAQ650 PAQ655 SLQ050 SMQ020 SMQ040 YEAR);
run;

data buxbaum.combined3_2017;
  set buxbaum.combined2_2017 (keep=
    SEQN RIDAGEYR RIDRETH1 RIAGENDR SDMVSTRA SDMVPSU WTDRD1
    MCQ160b MCQ160c MCQ160d MCQ160e MCQ160f
    ALQ130 ALQ120Q BMXBMI
    DR1TSODI DR1TCHOL DR1TSFAT DR1TMFAT DR1TPFAT DR1TFIBE DR1TKCAL
    LBXGH DIQ010 KIQ022 PAQ650 PAQ655 SLQ050 SMQ020 SMQ040 YEAR);
run;


/* ============================================================
   PROGRAM 06 — RENAME VARIABLES TO MEANINGFUL LABELS
   ============================================================
   Purpose : Rename cryptic NHANES variable codes to descriptive
             names used throughout the rest of the analysis.
   Input   : Combined3_YYYY
   Output  : Combined4_YYYY
   ============================================================ */

data buxbaum.combined4_2011;
  set buxbaum.combined3_2011 (rename=(
    RIDAGEYR = Age
    RIDRETH1 = Race
    RIAGENDR = Gender
    MCQ160b  = CHF           /* Congestive Heart Failure  */
    MCQ160c  = CHD           /* Coronary Heart Disease    */
    MCQ160d  = Angina
    MCQ160e  = Heart_Attack
    MCQ160f  = Stroke
    ALQ130   = Alcohol1      /* Avg drinks per drinking day */
    ALQ120Q  = Alcohol2      /* Drinking days per year      */
    BMXBMI   = BMI
    DR1TSODI = Sodium
    DR1TCHOL = Cholesterol
    DR1TSFAT = Saturated_Fats
    DR1TMFAT = Unsaturated_Fats1   /* Monounsaturated fats */
    DR1TPFAT = Unsaturated_Fats2   /* Polyunsaturated fats */
    DR1TFIBE = Fiber
    DR1TKCAL = Energy
    LBXGH    = Hba1c
    DIQ010   = Diabetes
    KIQ022   = Kidney
    PAQ650   = Physical_Activity1  /* Days/week vigorous activity */
    PAQ655   = Physical_Activity2  /* Min/day vigorous activity   */
    SLQ050   = Sleep_Disorder
    SMQ020   = Smoke1              /* Ever smoked 100+ cigarettes */
    SMQ040   = Smoke2              /* Currently smoke?            */
  ));
run;

data buxbaum.combined4_2013;
  set buxbaum.combined3_2013 (rename=(
    RIDAGEYR = Age          RIDRETH1 = Race         RIAGENDR = Gender
    MCQ160b  = CHF          MCQ160c  = CHD          MCQ160d  = Angina
    MCQ160e  = Heart_Attack MCQ160f  = Stroke
    ALQ130   = Alcohol1     ALQ120Q  = Alcohol2     BMXBMI   = BMI
    DR1TSODI = Sodium       DR1TCHOL = Cholesterol  DR1TSFAT = Saturated_Fats
    DR1TMFAT = Unsaturated_Fats1                    DR1TPFAT = Unsaturated_Fats2
    DR1TFIBE = Fiber        DR1TKCAL = Energy       LBXGH    = Hba1c
    DIQ010   = Diabetes     KIQ022   = Kidney
    PAQ650   = Physical_Activity1                   PAQ655   = Physical_Activity2
    SLQ050   = Sleep_Disorder  SMQ020 = Smoke1      SMQ040   = Smoke2
  ));
run;

data buxbaum.combined4_2015;
  set buxbaum.combined3_2015 (rename=(
    RIDAGEYR = Age          RIDRETH1 = Race         RIAGENDR = Gender
    MCQ160b  = CHF          MCQ160c  = CHD          MCQ160d  = Angina
    MCQ160e  = Heart_Attack MCQ160f  = Stroke
    ALQ130   = Alcohol1     ALQ120Q  = Alcohol2     BMXBMI   = BMI
    DR1TSODI = Sodium       DR1TCHOL = Cholesterol  DR1TSFAT = Saturated_Fats
    DR1TMFAT = Unsaturated_Fats1                    DR1TPFAT = Unsaturated_Fats2
    DR1TFIBE = Fiber        DR1TKCAL = Energy       LBXGH    = Hba1c
    DIQ010   = Diabetes     KIQ022   = Kidney
    PAQ650   = Physical_Activity1                   PAQ655   = Physical_Activity2
    SLQ050   = Sleep_Disorder  SMQ020 = Smoke1      SMQ040   = Smoke2
  ));
run;

data buxbaum.combined4_2017;
  set buxbaum.combined3_2017 (rename=(
    RIDAGEYR = Age          RIDRETH1 = Race         RIAGENDR = Gender
    MCQ160b  = CHF          MCQ160c  = CHD          MCQ160d  = Angina
    MCQ160e  = Heart_Attack MCQ160f  = Stroke
    ALQ130   = Alcohol1     ALQ120Q  = Alcohol2     BMXBMI   = BMI
    DR1TSODI = Sodium       DR1TCHOL = Cholesterol  DR1TSFAT = Saturated_Fats
    DR1TMFAT = Unsaturated_Fats1                    DR1TPFAT = Unsaturated_Fats2
    DR1TFIBE = Fiber        DR1TKCAL = Energy       LBXGH    = Hba1c
    DIQ010   = Diabetes     KIQ022   = Kidney
    PAQ650   = Physical_Activity1                   PAQ655   = Physical_Activity2
    SLQ050   = Sleep_Disorder  SMQ020 = Smoke1      SMQ040   = Smoke2
  ));
run;


/* ============================================================
   PROGRAM 07 — CREATE DERIVED CATEGORICAL VARIABLES
   ============================================================
   Purpose : Create 5 derived variables from raw NHANES values:
             Alcohol3, Physical_Activity3/4, Smoke3, BMI1,
             Unsaturated_Fats3
   Input   : Combined4_YYYY
   Output  : Combined5 through Combined10 (per year)

   NOTE: Binge drinking thresholds differ by cycle because NHANES
   updated the questionnaire scale between cycles. Always check
   the NHANES codebook for the cycle-specific valid range.
   ============================================================ */

/* ── ALCOHOL CLASSIFICATION ── */
/* Codes: Alcohol1 = avg drinks/day on drinking days
          Alcohol2 = days drank in past year
   2011 threshold: <351 drinks/year, <223 binge days
   2013 threshold: <366 / <351
   2015 threshold: <366 / <366
   2017 threshold: <11  / <11  (scale changed to drinks/week) */

data buxbaum.combined5_2011;
  length Alcohol3 $40;
  set buxbaum.combined4_2011;
  if      Alcohol1=0 and (Alcohol2=0 or Alcohol2=.)  then Alcohol3='Non-Drinker';
  else if (0<Alcohol1<351) and Alcohol2=0            then Alcohol3='Current drinker, no binge';
  else if (0<Alcohol1<351) and (0<Alcohol2<223)      then Alcohol3='Current drinker, binge';
  else Alcohol3='Missing';
run;

data buxbaum.combined5_2013;
  length Alcohol3 $40;
  set buxbaum.combined4_2013;
  if      Alcohol1=0 and (Alcohol2=0 or Alcohol2=.)  then Alcohol3='Non-Drinker';
  else if (0<Alcohol1<366) and Alcohol2=0            then Alcohol3='Current drinker, no binge';
  else if (0<Alcohol1<366) and (0<Alcohol2<351)      then Alcohol3='Current drinker, binge';
  else Alcohol3='Missing';
run;

data buxbaum.combined5_2015;
  length Alcohol3 $40;
  set buxbaum.combined4_2015;
  if      Alcohol1=0 and (Alcohol2=0 or Alcohol2=.)  then Alcohol3='Non-Drinker';
  else if (0<Alcohol1<366) and Alcohol2=0            then Alcohol3='Current drinker, no binge';
  else if (0<Alcohol1<366) and (0<Alcohol2<366)      then Alcohol3='Current drinker, binge';
  else Alcohol3='Missing';
run;

data buxbaum.combined5_2017;
  length Alcohol3 $40;
  set buxbaum.combined4_2017;
  if      Alcohol1=0 and (Alcohol2=0 or Alcohol2=.)  then Alcohol3='Non-Drinker';
  else if (0<Alcohol1<11)  and Alcohol2=0            then Alcohol3='Current drinker, no binge';
  else if (0<Alcohol1<11)  and (0<Alcohol2<11)       then Alcohol3='Current drinker, binge';
  else Alcohol3='Missing';
run;

/* QC — Alcohol */
proc freq data=buxbaum.combined5_2011; tables Alcohol3 / missing; run;
proc freq data=buxbaum.combined5_2013; tables Alcohol3 / missing; run;
proc freq data=buxbaum.combined5_2015; tables Alcohol3 / missing; run;
proc freq data=buxbaum.combined5_2017; tables Alcohol3 / missing; run;


/* ── PHYSICAL ACTIVITY (Step 1: compute minutes/week) ── */
/* Plausibility: >7 days/week or >900 min/day are impossible */
%macro pa_step1(yr);
data Buxbaum.combined6_&yr;
  set Buxbaum.combined5_&yr;
  if (Physical_Activity1>7) or (Physical_Activity2>900)
    then Physical_Activity3=.;
  else Physical_Activity3=Physical_Activity1 * Physical_Activity2;
run;
%mend;
%pa_step1(2011) %pa_step1(2013) %pa_step1(2015) %pa_step1(2017)

/* ── PHYSICAL ACTIVITY (Step 2: WHO categories) ── */
/* Based on WHO Global Action Plan for Physical Activity 2018:
   0 min/week       = Inactive
   1-149 min/week   = Insufficient Activity
   150-299 min/week = Sufficient Activity (meets minimum)
   300+ min/week    = Highly Active (exceeds recommendation) */
%macro pa_step2(yr);
data Buxbaum.combined7_&yr;
  set Buxbaum.combined6_&yr;
  length Physical_Activity4 $30;
  if      Physical_Activity3=0             then Physical_Activity4='Inactive';
  else if 0<Physical_Activity3<150         then Physical_Activity4='Insufficient_Activity';
  else if 150<=Physical_Activity3<300      then Physical_Activity4='Sufficient_Activity';
  else if 300<=Physical_Activity3          then Physical_Activity4='Highly_Active';
  else Physical_Activity4='Missing';
run;
%mend;
%pa_step2(2011) %pa_step2(2013) %pa_step2(2015) %pa_step2(2017)

/* QC — Physical Activity */
proc freq data=buxbaum.combined7_2011; tables Physical_Activity4; run;


/* ── SMOKING CLASSIFICATION ── */
/* Smoke1 (SMQ020): 1=Yes smoked 100+ cigarettes, 2=No
   Smoke2 (SMQ040): 1=Every day, 2=Some days, 3=Not at all
   Non_Smoker:    Never smoked >=100 cigarettes (Smoke1=2)
   Former_Smoker: Smoked >=100 but quit (Smoke1=1, Smoke2=3)
   Current_Smoker: Smokes now (Smoke1=1, Smoke2<3) */
%macro smoking(yr);
data Buxbaum.combined8_&yr;
  set Buxbaum.combined7_&yr;
  length Smoke3 $30;
  if      (Smoke1=2 and Smoke2=3)  then Smoke3='Non_Smoker';
  else if (Smoke1=2 and Smoke2=.)  then Smoke3='Non_Smoker';
  else if (Smoke1=1 and Smoke2=3)  then Smoke3='Former_Smoker';
  else if (Smoke1=1 and Smoke2<3)  then Smoke3='Current_Smoker';
  else Smoke3='Missing';
run;
%mend;
%smoking(2011) %smoking(2013) %smoking(2015) %smoking(2017)

/* QC — Smoking */
proc freq data=buxbaum.combined8_2011; tables Smoke3; run;
proc sql;
  select count(*) as N_total,
    sum((Smoke1=2) and (Smoke2=3 or Smoke2=.)) as Non_Smoker,
    sum(Smoke1=1 and Smoke2=3) as Former_Smoker,
    sum(Smoke1=1 and Smoke2<3) as Current_Smoker,
    sum(not((Smoke1=2 and (Smoke2=3 or Smoke2=.)) or
            (Smoke1=1 and Smoke2=3) or
            (Smoke1=1 and Smoke2<3))) as Missing
  from buxbaum.combined7_2011;
quit;


/* ── BMI CLASSIFICATION (WHO/CDC categories) ── */
%macro bmi(yr);
data Buxbaum.combined9_&yr;
  set Buxbaum.combined8_&yr;
  length BMI1 $30;
  if      0    < BMI <  18.5 then BMI1='Under_Weight';
  else if 18.5 <= BMI <  25  then BMI1='Normal_Weight';
  else if 25   <= BMI <  30  then BMI1='Over_Weight';
  else if 30   <= BMI <  35  then BMI1='Class_One_Obesity';
  else if 35   <= BMI <  40  then BMI1='Class_Two_Obesity';
  else if 40   <= BMI < 100  then BMI1='Class_Three_Obesity';
  else BMI1='Missing';
run;
%mend;
%bmi(2011) %bmi(2013) %bmi(2015) %bmi(2017)

/* QC — BMI */
proc freq data=buxbaum.combined9_2011; tables BMI1; run;


/* ── UNSATURATED FATS (Monounsaturated + Polyunsaturated) ── */
/* Plausibility thresholds differ by cycle (95th percentile values) */
data Buxbaum.combined10_2011;
  set Buxbaum.combined9_2011;
  if (Unsaturated_Fats1>189) or (Unsaturated_Fats2>189) then Unsaturated_Fats3=.;
  else Unsaturated_Fats3=Unsaturated_Fats1+Unsaturated_Fats2;
run;

data Buxbaum.combined10_2013;
  set Buxbaum.combined9_2013;
  if (Unsaturated_Fats1>222) or (Unsaturated_Fats2>222) then Unsaturated_Fats3=.;
  else Unsaturated_Fats3=Unsaturated_Fats1+Unsaturated_Fats2;
run;

data Buxbaum.combined10_2015;
  set Buxbaum.combined9_2015;
  if (Unsaturated_Fats1>170) or (Unsaturated_Fats2>170) then Unsaturated_Fats3=.;
  else Unsaturated_Fats3=Unsaturated_Fats1+Unsaturated_Fats2;
run;

data Buxbaum.combined10_2017;
  set Buxbaum.combined9_2017;
  if (Unsaturated_Fats1>201) or (Unsaturated_Fats2>201) then Unsaturated_Fats3=.;
  else Unsaturated_Fats3=Unsaturated_Fats1+Unsaturated_Fats2;
run;

/* QC — Unsaturated Fats */
proc means data=buxbaum.combined10_2011 n nmiss; var Unsaturated_Fats3; run;


/* ============================================================
   PROGRAM 08 — CREATE POOLED SURVEY WEIGHT
   ============================================================
   Purpose : Divide the dietary Day 1 weight (WTDRD1) by 4 to
             create a pooled weight appropriate for combining
             4 two-year NHANES cycles (2011-2018).
   Input   : Combined10_YYYY
   Output  : Combined11_YYYY

   WHY DIVIDE BY 4?
   When combining N two-year NHANES cycles, divide the cycle-specific
   weight by N. This ensures the sum of weights approximates the
   U.S. population size for the combined period, not N times that.
   (CDC NHANES Analytic Guidelines)
   ============================================================ */

%macro weight(yr);
data Buxbaum.COMBINED11_&yr;
  set Buxbaum.COMBINED10_&yr;
  if missing(WTDRD1) then WEIGHT=.;
  else WEIGHT=WTDRD1/4;
run;
%mend;
%weight(2011) %weight(2013) %weight(2015) %weight(2017)

/* QC — Weight */
proc means data=buxbaum.combined11_2011 n nmiss mean min max; var WEIGHT; run;
proc sql;
  select sum(not missing(WTDRD1)) as Available,
         sum(missing(WTDRD1))     as Missing
  from buxbaum.combined10_2011;
quit;


/* ============================================================
   PROGRAM 09 — STACK ALL FOUR SURVEY CYCLES
   ============================================================
   Purpose : Vertically stack all 4 cycle datasets into one
             unified analysis dataset.
   Input   : Combined11_2011 / 2013 / 2015 / 2017
   Output  : Combined12
   ============================================================ */

data Buxbaum.combined12;
  set Buxbaum.combined11_2011
      Buxbaum.combined11_2013
      Buxbaum.combined11_2015
      Buxbaum.combined11_2017;
run;

/* QC — Verify total count equals sum of individual cycle counts */
proc sql;
  select sum(cnt) as Total_from_Cycles
  from (
    select count(Alcohol3) as cnt from Buxbaum.combined11_2011 union all
    select count(Alcohol3) as cnt from Buxbaum.combined11_2013 union all
    select count(Alcohol3) as cnt from Buxbaum.combined11_2015 union all
    select count(Alcohol3) as cnt from Buxbaum.combined11_2017
  ) as x;
quit;

proc sql;
  select count(Alcohol3) as Total_in_Combined12
  from Buxbaum.combined12;
quit;
/* These two numbers MUST match exactly */

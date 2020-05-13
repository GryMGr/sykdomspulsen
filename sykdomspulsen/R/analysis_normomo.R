#' analysis_normomo
#' @param data a
#' @param argset a
#' @param schema a
#' @export
analysis_normomo <-  function(data, argset, schema){
  if(plnr::is_run_directly()){
    # sc::tm_run_task("analysis_normomo")

    sc::tm_update_plans("analysis_normomo")
    data <- sc::tm_get_data("analysis_normomo", index_plan=4)
    argset <- sc::tm_get_argset("analysis_normomo", index_plan=2, index_argset = 1)
    schema <- sc::tm_get_schema("analysis_normomo")
  }

  fs::dir_create(argset$wdir)

  d <- as.data.frame(data$raw[fhi::isoyear_n(DoR)<=argset$year_end])
  MOMO::SetOpts(
    DoA = argset$date_extracted,
    DoPR = as.Date("2012-1-1"),
    WStart = 1,
    WEnd = 52,
    country = argset$location_code,
    source = "FHI",
    MDATA = d,
    HDATA = analysis_normomo_hfile(),
    INPUTDIR = tempdir(),
    WDIR = argset$wdir,
    back = 7,
    WWW = 52*5,
    Ysum = argset$year_end,
    Wsum = 40,
    plotGraphs = FALSE,
    delayVersion = "richard",
    delayFunction = NULL,
    MOMOgroups = argset$momo_groups,
    MOMOmodels = argset$momo_models,
    Ydrop = argset$Ydrop,
    Wdrop = argset$Wdrop,
    verbose = FALSE
  )

  tryCatch({
    MOMO::RunMoMo()
  }, error=function(err){
    stop("ERROR HERE")
  })

  if(argset$upload){
    data_dirty <- rbindlist(MOMO::dataExport$toSave, fill = TRUE)
    data_clean <- clean_exported_momo_data(
      data_dirty,
      location_code = argset$location_code
    )
    # only upload
    data_clean <- data_clean[year >= argset$year_start_upload]
    schema$output$db_upsert_load_data_infile(data_clean, verbose = T)
  }
}


analysis_normomo_hfile <- function() {
  hfile <- fhidata::norway_dates_holidays[is_holiday == TRUE]
  hfile[, closed := 1]
  hfile[, is_holiday := NULL]
  return(as.data.frame(hfile))
}

analysis_normomo_function_factory <- function(location_code) {
  force(location_code)
  function(){
    sc::tbl("datar_normomo") %>%
      dplyr::filter(location_code==!!location_code) %>%
      dplyr::collect() %>%
      sc::latin1_to_utf8()
  }
}

analysis_normomo_plans <- function(){
  val <- sc::tbl("datar_normomo") %>%
    dplyr::summarize(date_extracted=max(date_extracted,na.rm=T)) %>%
    dplyr::collect()
  date_extracted <- val$date_extracted

  list_plan <- list()
  # For SSI ----
  list_plan[[length(list_plan)+1]] <- plnr::Plan$new()
  list_plan[[length(list_plan)]]$add_data(name = "raw", fn=function(){
    sc::tbl("datar_normomo") %>%
      dplyr::collect() %>%
      sc::latin1_to_utf8()
  })
  list_plan[[length(list_plan)]]$add_analysis(
    fn = analysis_normomo,
    location_code = "norway",
    year_end = fhi::isoyear_n(date_extracted),
    date_extracted = date_extracted,
    wdir = sc::path("output","sykdomspulsen_normomo_restricted_output",lubridate::today(),"ssi", create_dir = T),
    upload = FALSE,
    momo_groups = list(
      "0to4" =  "age >= 0 & age <=4",
      "5to14" = "age >= 5 & age <=14",
      "15to64" = "age >= 15 & age <=64",
      "65P" = "age >= 65 | is.na(age)",
      "Total" = "age >= 0 | is.na(age)",
      "65to74" = "65 <= age & age <= 74",
      "75to84" = "75 <= age & age <= 84",
      "85P" = "age >= 85 | is.na(age)"
    ),
    momo_models = c(
      "0to4" = "LINE",
      "5to14" = "LINE",
      "15to64" = "LINE_SIN",
      "65P" = "LINE_SIN",
      "Total" = "LINE_SIN",
      "65to74" = "LINE_SIN",
      "75to84" = "LINE_SIN",
      "85P" = "LINE_SIN"
    ),
    Ydrop = 2020,
    Wdrop = 01
  )

  # For FHI ----
  list_plan[[length(list_plan)+1]] <- plnr::Plan$new()
  list_plan[[length(list_plan)]]$add_data(name = "raw", fn=function(){
    sc::tbl("datar_normomo") %>%
      dplyr::collect() %>%
      sc::latin1_to_utf8()
  })

  # FHI - Norway ----
  for(i in 2012:fhi::isoyear_n(date_extracted)){
    if(i==fhi::isoyear_n(date_extracted)){
      date_extracted_year_specific <- date_extracted
    } else {
      date_extracted_year_specific <- fhidata::days[stringr::str_detect(yrwk, as.character(i))][.N]$sun
    }

    list_plan[[length(list_plan)]]$add_analysis(
      fn = analysis_normomo,
      location_code = "norge",
      year_start_upload = ifelse(i<=2015, i-4,i-1), ##ifelse(i==2012, 2008, i-1),
      year_end = i,
      date_extracted = date_extracted_year_specific,
      wdir = tempdir(),
      upload = TRUE,
      momo_groups = list(
        "0to4" =  "age >= 0 & age <=4",
        "5to14" = "age >= 5 & age <=14",
        "15to64" = "age >= 15 & age <=64",
        "65to74" = "65 <= age & age <= 74",
        "75to84" = "75 <= age & age <= 84",
        "85P" = "age >= 85 | is.na(age)",
        "Total" = "age >= 0 | is.na(age)",
        "65P" = "age >= 65 | is.na(age)"
      ),
      momo_models = c(
        "0to4" = "LINE",
        "5to14" = "LINE",
        "15to64" = "LINE_SIN",
        "65to74" = "LINE_SIN",
        "75to84" = "LINE_SIN",
        "85P" = "LINE_SIN",
        "Total" = "LINE_SIN",
        "65P" = "LINE_SIN"
      ),
      Ydrop = 2020,
      Wdrop = 01
    )
  }

  # FHI - County ----
  for(j in unique(norway_locations()$county_code)){
    list_plan[[length(list_plan)+1]] <- plnr::Plan$new()

    list_plan[[length(list_plan)]]$add_data(name = "raw", fn=analysis_normomo_function_factory(location_code = j))
    for(i in 2012:fhi::isoyear_n(date_extracted)){
      if(i==fhi::isoyear_n(date_extracted)){
        date_extracted_year_specific <- date_extracted
      } else {
        date_extracted_year_specific <- fhidata::days[stringr::str_detect(yrwk, as.character(i))][.N]$sun
      }

      list_plan[[length(list_plan)]]$add_analysis(
        fn = analysis_normomo,
        location_code = j,
        year_start_upload = ifelse(i==2012, 2008, i-1),
        year_end = i,
        date_extracted = date_extracted_year_specific,
        wdir = tempdir(),
        upload = TRUE,
        momo_groups = list(
          "0to4" =  "age >= 0 & age <=4",
          "5to14" = "age >= 5 & age <=14",
          "15to64" = "age >= 15 & age <=64",
          "65to74" = "65 <= age & age <= 74",
          "75to84" = "75 <= age & age <= 84",
          "85P" = "age >= 85 | is.na(age)",
          "Total" = "age >= 0 | is.na(age)",
          "65P" = "age >= 65 | is.na(age)"
        ),
        momo_models = c(
          "0to4" = "LINE",
          "5to14" = "LINE",
          "15to64" = "LINE_SIN",
          "65to74" = "LINE_SIN",
          "75to84" = "LINE_SIN",
          "85P" = "LINE_SIN",
          "Total" = "LINE_SIN",
          "65P" = "LINE_SIN"
        ),
        Ydrop = 2020,
        Wdrop = 01
      )
    }
  }

  return(list_plan)
}

clean_exported_momo_data <- function(
  data_dirty,
  location_code
  ) {

  data_dirty <- data_dirty[
    !is.na(Pnb),
    c(
      "GROUP",
      "wk",
      "wk2",
      "YoDi",
      "WoDi",
      "Pnb",
      "nb",
      "nbc",
      "UPIb2",
      "UPIb4",
      "UPIc",
      "LPIc",
      "UCIc",
      "LCIc",
      "zscore"
    ),
    with = F]

  data_dirty[,forecast := nbc != nb]

  # prediction interval
  data_dirty[is.na(UPIc) | UPIc < nbc, UPIc := nbc]
  data_dirty[is.na(LPIc) | LPIc > nbc, LPIc := nbc]
  data_dirty[LPIc < 0, LPIc := 0]
  # prediction interval cant be below the real value!
  data_dirty[is.na(LPIc) | LPIc < nb, LPIc := nb]

  # remove prediction intervals before correction
  data_dirty[forecast==FALSE, UPIc := nbc]
  data_dirty[forecast==FALSE, LPIc := nbc]

  setnames(data_dirty,c("LPIc","UPIc"),c("ncor_thresholdl0","ncor_thresholdu0"))
  setnames(data_dirty, "nb", "n_obs")
  setnames(data_dirty, "nbc", "ncor_est")
  setnames(data_dirty, "Pnb", "ncor_baseline_expected")
  setnames(data_dirty, "wk2", "yrwk")

  data_dirty[,yrwk:=as.character(yrwk)]
  setnames(data_dirty, "YoDi", "year")
  setnames(data_dirty, "WoDi", "week")
  setnames(data_dirty, "zscore", "ncor_zscore")

  data_dirty[, location_code := location_code]
  data_dirty[location_code == "norway", location_code := "norge"]
  data_dirty[, age := dplyr::case_when(
    GROUP == "0to4" ~ "0-4",
    GROUP == "5to14" ~ "5-14",
    GROUP == "15to64" ~ "15-64",
    GROUP == "65to74" ~ "65-74",
    GROUP == "75to84" ~ "75-84",
    GROUP == "85P" ~ "85+",
    GROUP == "Total" ~ "total",
    GROUP == "65P" ~ "65+"
  )]

  # creating thesholds
  data_dirty[, ncor_baseline_thresholdl0 := ncor_baseline_expected - abs(UPIb2 - ncor_baseline_expected)]
  setnames(data_dirty, "UPIb2", "ncor_baseline_thresholdu0")
  setnames(data_dirty, "UPIb4", "ncor_baseline_thresholdu1")
  data_dirty[, ncor_excess := pmax(ncor_est - ncor_baseline_thresholdu0, 0)]
  data_dirty[, ncor_status := "normal"]
  data_dirty[ncor_est > ncor_baseline_thresholdu0, ncor_status := "medium"]
  data_dirty[ncor_est > ncor_baseline_thresholdu1, ncor_status := "high"]
  data_dirty[fhidata::days, on = "yrwk", date := sun]

  data_dirty[,granularity_time := "week"]
  data_dirty[,granularity_geo := dplyr::case_when(
    location_code == "norge" ~ "nation",
    TRUE ~ "county"
  )]
  data_dirty[,border := config$border]
  data_dirty[,sex:="total"]
  data_dirty[,season:=fhi::season(yrwk)]
  data_dirty[,x:=fhi::x(week)]

  data_dirty <- data_dirty[,c(
    "granularity_time",
    "granularity_geo",
    "location_code",
    "border",
    "age",
    "sex",
    "season",
    "year",
    "week",
    "yrwk",
    "x",
    "date",
    "n_obs",
    "ncor_est",
    "ncor_thresholdl0",
    "ncor_thresholdu0",
    "ncor_zscore",
    "ncor_status",
    "ncor_excess",
    "ncor_baseline_expected",
    "ncor_baseline_thresholdl0",
    "ncor_baseline_thresholdu0",
    "ncor_baseline_thresholdu1",
    "forecast"
  )]

  return(data_dirty)
}

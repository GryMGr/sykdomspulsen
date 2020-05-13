set_db <- function(){

  # rundate ----
  sc::add_schema(
    name = "rundate",
    schema = sc::Schema$new(
      db_config = sc::config$db_config,
      db_table = "rundate",
      db_field_types = c(
        "task" = "TEXT",
        "date" = "DATE",
        "datetime" = "DATETIME"
      ),
      db_load_folder = tempdir(),
      keys = c(
        "task"
      )
    )
  )

  # covid19 ----
  # results_covid19_model ----
  sc::add_schema(
    name = "results_covid19_model",
    schema = sc::Schema$new(
      db_table = "results_covid19_model",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "infectious_prev_est" = "DOUBLE",
        "infectious_prev_thresholdl0" = "DOUBLE",
        "infectious_prev_thresholdu0" = "DOUBLE",

        "incidence_est" = "DOUBLE",
        "incidence_thresholdl0" = "DOUBLE",
        "incidence_thresholdu0" = "DOUBLE",

        "hosp_prev_est" = "DOUBLE",
        "hosp_prev_thresholdl0" = "DOUBLE",
        "hosp_prev_thresholdu0" = "DOUBLE",

        "icu_prev_est" = "DOUBLE",
        "icu_prev_thresholdl0" = "DOUBLE",
        "icu_prev_thresholdu0" = "DOUBLE"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "location_code",
        "date"
      )
    )
  )

  # data_covid19_msis_by_time_location ----
  sc::add_schema(
    name = "data_covid19_msis_by_time_location",
    schema = sc::Schema$new(
      db_table = "data_covid19_msis_by_time_location",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "n" = "INTEGER"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "granularity_time",
        "location_code",
        "date"
      )
    )
  )

  # data_covid19_msis_by_time_infected_abroad ----
  sc::add_schema(
    name = "data_covid19_msis_by_time_infected_abroad",
    schema = sc::Schema$new(
      db_table = "data_covid19_msis_by_time_infected_abroad",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "tag_location_infected" = "TEXT",
        "n" = "INTEGER"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "granularity_time",
        "location_code",
        "date",
        "tag_location_infected"
      )
    )
  )

  # data_covid19_msis_by_sex_age ----
  sc::add_schema(
    name = "data_covid19_msis_by_sex_age",
    schema = sc::Schema$new(
      db_table = "data_covid19_msis_by_sex_age",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "n" = "INTEGER"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "granularity_time",
        "location_code",
        "age",
        "sex",
        "date"
      )
    )
  )

  # data_covid19_lab_by_time ----
  sc::add_schema(
    name = "data_covid19_lab_by_time",
    schema = sc::Schema$new(
      db_table = "data_covid19_lab_by_time",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "n_neg" = "INTEGER",
        "n_pos" = "INTEGER",
        "pr100_pos" = "DOUBLE"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "granularity_time",
        "location_code",
        "date"
      )
    )
  )

  # data_covid19_hospital_by_time ----
  sc::add_schema(
    name = "data_covid19_hospital_by_time",
    schema = sc::Schema$new(
      db_table = "data_covid19_hospital_by_time",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "n_icu" = "INTEGER",
        "cum_n_icu" = "INTEGER",
        "cum_n_hospital_any_cause" = "INTEGER",
        "cum_n_hospital_main_cause" = "INTEGER"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "granularity_time",
        "location_code",
        "date"
      )
    ),

    # data_covid19_deaths ----
    data_covid19_deaths = Schema$new(
      db_table = "data_covid19_deaths",
      db_config = config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "cum_n" = "INTEGER"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "granularity_time",
        "location_code",
        "date"
      )
    )
  )

  # datar ----
  # datar_weather ----
  sc::add_schema(
    name = "datar_weather",
    schema = sc::Schema$new(
      db_config = sc::config$db_config,
      db_table = "datar_weather",
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "tg" = "DOUBLE",
        "tx" = "DOUBLE",
        "tn" = "DOUBLE",
        "rr" = "DOUBLE",
        "forecast" = "BOOLEAN"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "location_code",
        "date"
      )
    )
  )

  # datar_normomo ----
  sc::add_schema(
    name = "datar_normomo",
    schema = sc::Schema$new(
      db_config = sc::config$db_config,
      db_table = "datar_normomo",
      db_field_types =  c(
        "uuid" = "TEXT",
        "DoD" = "DATE",
        "DoR" = "DATE",
        "DoB" = "DATE",
        "age" = "INTEGER",
        "location_code" = "TEXT",
        "date_extracted" = "DATE"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "uuid"
      )
    )
  )

  # datar_norsyss_kht_email ----
  sc::add_schema(
    name = "datar_norsyss_kht_email",
    schema = sc::Schema$new(
      db_config = sc::config$db_config,
      db_table = "datar_norsyss_kht_email",
      db_field_types =  c(
        "location_code" = "TEXT",
        "email" = "TEXT"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "location_code",
        "email"
      )
    )
  )

  # data ----
  # data_weather ----
  sc::add_schema(
    name = "data_weather",
    schema = sc::Schema$new(
      db_config = sc::config$db_config,
      db_table = "data_weather",
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "tg" = "DOUBLE",
        "tx" = "DOUBLE",
        "tn" = "DOUBLE",
        "rr" = "DOUBLE",
        "forecast" = "BOOLEAN"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "location_code",
        "date"
      )
    )
  )

  # data_norsyss ----
  sc::add_schema(
    name = "data_norsyss",
    schema = sc::Schema$new(
      db_table = "data_norsyss",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "tag_outcome" = "TEXT",
        "holiday" = "DOUBLE",
        "n" = "INTEGER",
        "pop" = "INTEGER",
        "consult_with_influenza" = "INTEGER",
        "consult_without_influenza" = "INTEGER"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "tag_outcome",
        "location_code",
        "year",
        "date",
        "age"
      )
    )
  )

  # data_msis ----
  sc::add_schema(
    name = "data_msis",
    schema = sc::Schema$new(
      db_config = sc::config$db_config,
      db_table = "data_msis",
      db_field_types =  c(
        "tag_outcome" = "TEXT",
        "location_code" = "TEXT",
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "season" = "TEXT",
        "yrwk" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "n" = "INTEGER",
        "date" = "DATE",

        "month" = "TEXT"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "tag_outcome",
        "location_code",
        "year",
        "date"
      )
    )
  )

  # results ----
  # results_normomo_standard ----
  sc::add_schema(
    name = "results_normomo_standard",
    schema = sc::Schema$new(
      db_config = sc::config$db_config,
      db_table = "results_normomo_standard",
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "n_obs" = "INTEGER",

        "ncor_est" = "DOUBLE",
        "ncor_thresholdl0" = "DOUBLE",
        "ncor_thresholdu0" = "DOUBLE",
        "ncor_zscore" = "DOUBLE",
        "ncor_status" = "TEXT",
        "ncor_excess" = "DOUBLE",

        "ncor_baseline_expected" = "DOUBLE",
        "ncor_baseline_thresholdl0" = "DOUBLE",
        "ncor_baseline_thresholdu0" = "DOUBLE",
        "ncor_baseline_thresholdu1" = "DOUBLE",

        "forecast" = "BOOLEAN"
      ),
      keys = c(
        "granularity_time",
        "granularity_geo",
        "location_code",
        "age",
        "sex",
        "year",
        "week",
        "date"
      ),
      db_load_folder = tempdir()
    )
  )

  # results_norsyss_standard ----
  sc::add_schema(
    name = "results_norsyss_standard",
    schema = sc::Schema$new(
      db_table = "results_norsyss_standard",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "location_code" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "yrwk" = "TEXT",
        "season" = "TEXT",
        "x" = "DOUBLE",
        "date" = "DATE",

        "tag_outcome" = "TEXT",
        "n" = "INTEGER",
        "n_denominator" = "INTEGER",
        "n_baseline_expected" = "DOUBLE",
        "n_baseline_thresholdu0" = "DOUBLE",
        "n_baseline_thresholdu1" = "DOUBLE",
        "n_baseline_thresholdu2" = "DOUBLE",
        "n_zscore" = "DOUBLE",
        "n_status" = "TEXT",
        "failed" = "TINYINT",
        "source" = "TEXT"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "granularity_time",
        "granularity_geo",
        "tag_outcome",
        "location_code",
        "age",
        "year",
        "week",
        "date"
      )
    )
  )

  sc::add_schema(
    name = "results_simple",
    schema = sc::Schema$new(
      db_table = "results_simple",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "tag_outcome" = "TEXT",
        "source" = "TEXT",
        "location_code" = "TEXT",
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "date" = "DATE",
        "season" = "TEXT",
        "yrwk" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "month" = "TEXT",
        "n" = "TEXT",
        "n_expected" = "DOUBLE",
        "n_threshold_0" = "DOUBLE",
        "n_status"= "TEXT"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "tag_outcome",
        "location_code",
        "year",
        "date"
      )
    )
  )

  sc::add_schema(
    name = "results_mem",
    schema = sc::Schema$new(
      db_table = "results_mem",
      db_config = sc::config$db_config,
      db_field_types =  c(
        "tag_outcome" = "TEXT",
        "source" = "TEXT",
        "location_code" = "TEXT",
        "granularity_time" = "TEXT",
        "granularity_geo" = "TEXT",
        "border" = "INTEGER",
        "age" = "TEXT",
        "sex" = "TEXT",
        "date" = "DATE",
        "season" = "TEXT",
        "yrwk" = "TEXT",
        "year" = "INTEGER",
        "week" = "INTEGER",
        "n" = "INTEGER",
        "n_denominator" = "INTEGER",
        "rp100" = "DOUBLE",
        "rp100_baseline_thresholdu0" = "DOUBLE",
        "rp100_baseline_thresholdu1" = "DOUBLE",
        "rp100_baseline_thresholdu2" = "DOUBLE",
        "rp100_baseline_thresholdu3" = "DOUBLE",
        "rp100_status"= "TEXT"
      ),
      db_load_folder = tempdir(),
      keys =  c(
        "tag_outcome",
        "location_code",
        "year",
        "date",
        "age"
      )
    )
  )

  sc::add_schema(
    name = "results_mem_limits",
    schema = sc::Schema$new(
      db_table = "results_mem_limits",
      db_config = sc::config$db_config,
      db_field_types = list(
        "season" = "TEXT",
        "tag_outcome" = "TEXT",
        "age" = "TEXT",
        "location_code" = "TEXT",
        "rp100_baseline_thresholdu0" = "DOUBLE",
        "rp100_baseline_thresholdu1" = "DOUBLE",
        "rp100_baseline_thresholdu2" = "DOUBLE",
        "rp100_baseline_thresholdu3" = "DOUBLE"
      ),
      db_load_folder = tempdir(),
      keys = c("season", "tag_outcome", "age", "location_code")
    )
  )
}

set_tasks <- function() {
  # covid19 ----
  # data_covid19_model ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "data_covid19_model",
        type = "data",
        action = "sykdomspulsen::data_covid19_model",
        schema = list(output = sc::config$schemas$results_covid19_model)
      )
    )
  )

  # data_covid19_daily_report ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "data_covid19_daily_report",
        type = "data",
        action = "sykdomspulsen::data_covid19_daily_report",
        schema = list(
          data_covid19_msis_by_time_location = config$schema$data_covid19_msis_by_time_location,
          data_covid19_msis_by_time_infected_abroad = config$schema$data_covid19_msis_by_time_infected_abroad,
          data_covid19_msis_by_sex_age = config$schema$data_covid19_msis_by_sex_age,
          data_covid19_lab_by_time = config$schema$data_covid19_lab_by_time,
          data_covid19_hospital_by_time = config$schema$data_covid19_hospital_by_time,
          data_covid19_deaths = config$schema$data_covid19_deaths
        )
      )
    )
  )

  # data ----
  # data_pre_normomo ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "data_pre_normomo",
        type = "data",
        action = "sykdomspulsen::data_pre_normomo"
      )
    )
  )
  # datar_normomo ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "datar_normomo",
        type = "data",
        action = "sykdomspulsen::datar_normomo",
        schema = list(output = sc::config$schemas$datar_normomo)
      )
    )
  )
  # datar_normomo_drop ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "datar_normomo_drop",
        type = "data",
        action = "sykdomspulsen::datar_normomo_drop",
        schema = list(output = sc::config$schemas$datar_normomo)
      )
    )
  )

  # datar_norsyss_registration ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "datar_norsyss_kht_email",
        type = "data",
        action = "sykdomspulsen::datar_norsyss_kht_email",
        schema = list(output = sc::config$schemas$datar_norsyss_kht_email)
      )
    )
  )
  # datar_norsyss_kht_email_drop ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "datar_norsyss_kht_email_drop",
        type = "data",
        action = "sykdomspulsen::datar_norsyss_kht_email_drop",
        schema = list(output = sc::config$schemas$datar_norsyss_kht_email)
      )
    )
  )

  # data_pre_norsyss ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "data_pre_norsyss",
        type = "data",
        action = "sykdomspulsen::data_pre_norsyss",
        schema = list(),
        args = list(
          date_from = "2014-01-01",
          diags = list(
            "influensa" = c("R80"),
            "gastro" = c("D11", "D70", "D73"),
            "respiratory" = c("R05", "R74", "R78", "R83"),
            "respiratoryexternal" = c("R05", "R74", "R78", "R83"),
            "respiratoryinternal" = c("R05", "R74", "R83"),
            "lungebetennelse" = c("R81"),
            "bronkitt" = c("R78"),
            "skabb" = c("S72"),

            "hoste" = c("R05"),
            "akkut_ovre_luftveisinfeksjon" = c("R74"),
            "luftveisinfeksjon_ika" = c("R83"),
            "luftveissykdom_ika" = c("R99"),
            "virusinfeksjon_ika" = c("A77"),
            "rxx_for_covid19" = c(
              "R01",
              "R02",
              "R03",
              "R04",
              "R05",
              "R06",
              "R07",
              "R08",
              "R09",
              "R21",
              "R24",
              "R25",
              "R27",
              #"R270000",
              "R29",
              #"R71",
              "R72",
              "R74",
              "R75",
              "R76",
              "R77",
              "R78",
              "R79",
              "R80",
              "R81",
              "R82",
              "R83",
              #"R95",
              #"R96",
              "R99",
              "R991"
              #"R9910000"
            ),

            "covid19" = c("R991", "R992"),
            "covid19_r991" = c("R991"),
            "covid19_r992" = c("R992"),
            "engstelig_luftveissykdom_ika" = c("R27")
          )
        )
      )
    )
  )

  # data_norsyss ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "data_norsyss",
        type = "data",
        action = "sykdomspulsen::data_norsyss",
        schema = list(output = sc::config$schemas$data_norsyss),
        args = list(
          # v = (lege)vakt
          # k = (lege)kontor
          # o = oppmote
          # t = telefon
          # e = ekonsultasjon
          syndromes = rbind(
            data.table(
              tag_input = "influensa",
              tag_output = "influensa_vk_o",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list("oppmote")
            ),
            data.table(
              tag_input = "influensa",
              tag_output = "influensa_vk_ot",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt"))
            ),
            data.table(
              tag_input = "gastro",
              tag_output = "gastro_vk_ot",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt"))
            ),
            data.table(
              tag_input = "respiratoryinternal",
              tag_output = "respiratoryinternal_vk_ot",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt"))
            ),
            data.table(
              tag_input = "respiratoryexternal",
              tag_output = "respiratoryexternal_vk_ot",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt"))
            ),

            # ote
            data.table(
              tag_input = "covid19",
              tag_output = "covid19_vk_ote",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt", "ekonsultasjon"))
            ),
            data.table(
              tag_input = "covid19_r991",
              tag_output = "covid19_r991_vk_ote",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt", "ekonsultasjon"))
            ),
            data.table(
              tag_input = "covid19_r992",
              tag_output = "covid19_r992_vk_ote",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt", "ekonsultasjon"))
            ),
            data.table(
              tag_input = "influensa",
              tag_output = "influensa_vk_ote",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt", "ekonsultasjon"))
            ),
            data.table(
              tag_input = "rxx_for_covid19",
              tag_output = "rxx_for_covid19_vk_ote",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt", "ekonsultasjon"))
            ),
            data.table(
              tag_input = "akkut_ovre_luftveisinfeksjon",
              tag_output = "akkut_ovre_luftveisinfeksjon_vk_ote",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt", "ekonsultasjon"))
            ),
            data.table(
              tag_input = "engstelig_luftveissykdom_ika",
              tag_output = "engstelig_luftveissykdom_ika_vk_ote",
              practice_type = list(c("legevakt", "legekontor")),
              contactType = list(c("oppmote", "telefonkontakt", "ekonsultasjon"))
            ),

            # strata
            data.table(
              tag_input = "covid19",
              tag_output = "covid19_v_o",
              practice_type = list(c("legevakt")),
              contactType = list(c("oppmote"))
            ),
            data.table(
              tag_input = "covid19",
              tag_output = "covid19_v_t",
              practice_type = list(c("legevakt")),
              contactType = list(c("telefonkontakt"))
            ),
            data.table(
              tag_input = "covid19",
              tag_output = "covid19_v_e",
              practice_type = list(c("legevakt")),
              contactType = list(c("ekonsultasjon"))
            ),
            data.table(
              tag_input = "covid19",
              tag_output = "covid19_k_o",
              practice_type = list(c("legekontor")),
              contactType = list(c("oppmote"))
            ),
            data.table(
              tag_input = "covid19",
              tag_output = "covid19_k_t",
              practice_type = list(c("legekontor")),
              contactType = list(c("telefonkontakt"))
            ),
            data.table(
              tag_input = "covid19",
              tag_output = "covid19_k_e",
              practice_type = list(c("legekontor")),
              contactType = list(c("ekonsultasjon"))
            )

          )
        )
      )
    )
  )

  # datar_weather ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "datar_weather",
        type = "data",
        action = "sykdomspulsen::datar_weather",
        schema = list(output = sc::config$schemas$datar_weather)
      )
    )
  )
  # data_weather ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "data_weather",
        type = "data",
        action = "sykdomspulsen::data_weather",
        schema = list(
          input = sc::config$schemas$datar_weather,
          output = sc::config$schemas$data_weather
        )
      )
    )
  )
  # data_msis ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "data_msis",
        type = "data",
        action = "sykdomspulsen::data_msis",
        schema = list(output = sc::config$schemas$data_msis),
        args = list(
          start_year = 2008,
          end_year = 2019,
          tags = c("Kikoste", "Campylobacteriose")
        )
      )
    )
  )

  # analysis ----
  # analysis_normomo ----
  sc::add_task(
    sc::Task$new(
      name = "analysis_normomo",
      type = "analysis",
      update_plans_fn = analysis_normomo_plans,
      schema = c("output" = sc::config$schemas$results_normomo_standard),
      cores = min(6, parallel::detectCores()),
      chunk_size = 1
    )
  )

  # analysis_norsyss_qp_weekly ----
  sc::add_task(
    sc::task_from_config(
      conf = list(
        name = "analysis_norsyss_qp_weekly",
        db_table = "data_norsyss",
        type = "analysis",
        dependencies = c("data_norsyss"),
        cores = min(7, parallel::detectCores()),
        chunk_size= 1000,
        action = "sykdomspulsen::analysis_qp",
        for_each_plan = list(
          "age" = "all",
          "sex" = "total",
          "tag_outcome" = c(
            "gastro_vk_ot",
            "respiratoryexternal_vk_ot"
          )
        ),
        for_each_argset = list("location_code" = "all"),
        schema = list(
          output = sc::config$schemas$results_norsyss_standard
        ),
        upsert_at_end_of_each_plan = TRUE,
        args = list(
          train_length = 5,
          years = c(2018, 2019, 2020),
          weeklyDenominatorFunction = sum,
          denominator = "consult_without_influenza",
          granularity_time = "week"
        )
      )
    )
  )

  # analysis_norsyss_qp_daily ----
  sc::add_task(
    sc::task_from_config(
      conf = list(
        name = "analysis_norsyss_qp_daily",
        db_table = "data_norsyss",
        type = "analysis",
        dependencies = c("data_norsyss"),
        cores = min(7, parallel::detectCores()),
        chunk_size= 1000,
        action = "sykdomspulsen::analysis_qp",
        filter = "(granularity_geo=='county' | granularity_geo=='nation')",
        for_each_plan = list(
          "age" = "all",
          "sex" = "total",
          "tag_outcome" = c(
            "gastro_vk_ot",
            "respiratoryexternal_vk_ot"
          )
        ),
        for_each_argset = list("location_code" = "all"),
        schema = list(
          output = sc::config$schemas$results_norsyss_standard
        ),
        upsert_at_end_of_each_plan = TRUE,
        args = list(
          train_length = 5,
          years = c(2018, 2019, 2020),
          weeklyDenominatorFunction = sum,
          denominator = "consult_without_influenza",
          granularity_time = "day"
        )
      )
    )
  )

  # analysis_norsyss_mem_influensa ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "analysis_norsyss_mem_influensa",
        db_table = "data_norsyss",
        type = "analysis",
        dependencies = c("data_norsyss"),
        action = "analysis_mem",
        filter = "(granularity_geo=='county' | granularity_geo=='nation') & tag_outcome=='influensa_vk_o'",
        for_each_plan = list("location_code" = "all"),
        schema = list(
          output = sc::config$schemas$results_mem,
          output_limits = sc::config$schemas$results_mem_limits
        ),
        args = list(
          age = jsonlite::toJSON(list("total" = c("total"))),
          tag = "influensa",
          weeklyDenominatorFunction = "sum",
          multiplicative_factor = 100,
          denominator = "consult_with_influenza"
        )
      )
    )
  )

  sc::add_task(
    sc::task_from_config(
      list(
        name = "analysis_norsyss_mem_influensa_all",
        db_table = "data_norsyss",
        type = "analysis",
        dependencies = c("data_norsyss"),
        action = "sykdomspulsen::analysis_mem",
        filter = "(granularity_geo=='county' | granularity_geo=='norge') & tag_outcome=='influensa_vk_ote'",
        for_each_plan = list("location_code" = "all"),
        schema = list(
          output = sc::config$schemas$results_mem,
          output_limits = sc::config$schemas$results_mem_limits
        ),
        args = list(
          age = jsonlite::toJSON(list(
            "0-4" = c("0-4"), "5-14" = c("5-14"),
            "15-64" = c("15-19", "20-29", "30-64"), "65+" = c("65+")
          )),
          tag = "influensa",
          weeklyDenominatorFunction = "sum",
          multiplicative_factor = 100,
          denominator = "consult_with_influenza"
        )
      )
    )
  )

  sc::add_task(
    sc::task_from_config(
      list(
        name = "analysis_simple_msis",
        type = "analysis",
        db_table = "data_msis",
        action = "sykdomspulsen::analysis_simple",
        dependencies = c("data_msis"),
        schema = list(output = sc::config$schemas$results_simple),
        for_each_plan = list("location_code" = "all", "tag_outcome" = c("Kikoste", "Campylobacteriose")),
        args = list(
          group_by = "month",
          past_years = 5
        )
      )
    )
  )

  ############
  # ui ----
  # ui_surveillance_data ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_surveillance_data",
        type = "single",
        action = "sykdomspulsen::ui_surveillance_data",
        schema = list(
          data_covid19_msis_by_time_location=sc::config$schemas$data_covid19_msis_by_time_location
        )
      )
    )
  )

  # ui_normomo_ssi ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_normomo_ssi",
        type = "single",
        action = "sykdomspulsen::ui_normomo_ssi",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        dependencies = c("results_normomo_standard")
      )
    )
  )

  # ui_normomo_thresholds_1yr_5yr ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_normomo_thresholds_1yr_5yr",
        type = "ui",
        action = "sykdomspulsen::ui_normomo_thresholds_1yr_5yr",
        db_table = "results_normomo_standard",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        for_each_plan = list("location_code" = "all", "age" = "all"),
        dependencies = c("results_normomo_standard"),
        args = list(
          folder = "sykdomspulsen_normomo_restricted_output/{argset$today}/graphs_thresholds",
          filename = "{tag}_{argset$location_code}_{argset$age}_{argset$today}.png"
        )
      )
    )
  )

  # ui_normomo_overview_by_location ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_normomo_overview_by_location",
        type = "ui",
        action = "sykdomspulsen::ui_normomo_overview",
        db_table = "results_normomo_standard",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        for_each_plan = list("age" = "all"),
        dependencies = c("results_normomo_standard"),
        args = list(
          folder = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview",
          filename = "by_{argset$by}_{argset$age}_{argset$today}.png",
          by="location"
        )
      )
    )
  )

  # ui_normomo_overview_by_age ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_normomo_overview_by_age",
        type = "ui",
        action = "sykdomspulsen::ui_normomo_overview",
        db_table = "results_normomo_standard",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        for_each_plan = list("location_code" = "all"),
        dependencies = c("results_normomo_standard"),
        args = list(
          folder = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview",
          filename = "by_{argset$by}_{argset$location_code}_{argset$today}.png",
          by="age"
        )
      )
    )
  )

  # ui_normomo_table_overview ----
  sc::add_task(
    sc::task_from_config(
      conf = list(
        name = "ui_normomo_table_overview",
        type = "ui",
        action = "sykdomspulsen::ui_normomo_table_overview",
        db_table = "results_normomo_standard",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        for_each_plan = list("location_code" = c("all")),
        #filter = "age=='total'",
        dependencies = c("results_normomo_standard"),
        args = list(
          folder = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview",
          filename = "overview_{argset$location_code}_{argset$today}.png"
        )
      )
    )
  )

  # ui_normomo_table_excess_only_sort_location ----
  sc::add_task(
    sc::task_from_config(
      conf = list(
        name = "ui_normomo_table_excess_only_sort_location",
        type = "ui",
        action = "sykdomspulsen::ui_normomo_table_excess_only",
        db_table = "results_normomo_standard",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        for_each_plan = list("border" = 2020),
        #filter = "age=='total'",
        dependencies = c("results_normomo_standard"),
        args = list(
          folder = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview",
          filename = "overview_excess_only_sort_{argset$sort}_{argset$today}.png",
          sort = "location"
        )
      )
    )
  )

  # ui_normomo_table_excess_only_sort_age ----
  sc::add_task(
    sc::task_from_config(
      conf = list(
        name = "ui_normomo_table_excess_only_sort_age",
        type = "ui",
        action = "sykdomspulsen::ui_normomo_table_excess_only",
        db_table = "results_normomo_standard",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        for_each_plan = list("border" = 2020),
        #filter = "age=='total'",
        dependencies = c("results_normomo_standard"),
        args = list(
          folder = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview",
          filename = "overview_excess_only_sort_{argset$sort}_{argset$today}.png",
          sort = "age"
        )
      )
    )
  )

  # ui_normomo_data_files ----
  sc::add_task(
    sc::task_from_config(
      conf = list(
        name = "ui_normomo_data_files",
        type = "ui",
        action = "sykdomspulsen::ui_normomo_data_files",
        db_table = "results_normomo_standard",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        for_each_plan = list("border" = config$border),
        #filter = "age=='total'",
        dependencies = c("results_normomo_standard"),
        args = list(
          folder = "sykdomspulsen_normomo_restricted_output/{argset$today}/data",
          filename = "data_{argset$today}.xlsx"
        )
      )
    )
  )

  # ui_normomo_email_internal ----
  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_normomo_email_internal",
        type = "single",
        action = "sykdomspulsen::ui_normomo_email_internal",
        schema = list(input=sc::config$schemas$results_normomo_standard),
        dependencies = c("results_normomo_standard"),
        args = list(
          tab1 = "overview_norge_{argset$today}.png",
          tab1_filepath = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview/overview_norge_{argset$today}.png",

          tab2 = "overview_excess_only_sort_location_{argset$today}.png",
          tab2_filepath = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview/overview_excess_only_sort_location_{argset$today}.png",

          fig1 = "incl_reported_norge_total_{argset$today}.png",
          fig1_filepath = "sykdomspulsen_normomo_restricted_output/{argset$today}/graphs_thresholds/incl_reported_norge_total_{argset$today}.png",

          fig2 = "by_location_total_{argset$today}.png",
          fig2_filepath = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview/by_location_total_{argset$today}.png",

          fig3 = "by_age_norge_{argset$today}.png",
          fig3_filepath = "sykdomspulsen_normomo_restricted_output/{argset$today}/overview/by_age_norge_{argset$today}.png"
        )
      )
    )
  )

  # ui_norsyss_kht_email ----
  sc::add_task(
    sc::Task$new(
      name = "ui_norsyss_kht_email",
      type = "ui",
      permission = config$permissions$ui_norsyss_kht_email,
      update_plans_fn = ui_norsyss_kht_email_plans,
      schema = c("input" = sc::config$schemas$results_norsyss_standard)
    )
  )

  # ui_covid19_areas_at_risk ----
  sc::add_task(
    sc::Task$new(
      name = "ui_covid19_areas_at_risk",
      type = "ui",
      update_plans_fn = ui_covid19_areas_at_risk_plans,
      schema = c(
        "norsyss" = sc::config$schemas$data_norsyss,
        "covid" = sc::config$schemas$results_norsyss_standard
        )
    )
  )

  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_threshold_plot_msis",
        type = "ui",
        action = "ui_create_threshold_plot",
        db_table = "results_simple",
        schema = NULL,
        for_each_plan = list("location_code" = "all", "tag_outcome" = c("Kikoste", "Campylobacteriose")),
        dependencies = c("norsyss_mem_influensa"),
        args = list(
          filename = "{location_code}.png",
          folder = " {tag_outcome}/{today}"
        ),
        filter = "year > 2010 & source == 'data_msis'"
      )
    )
  )

  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_norsyss_mem_influensa",
        type = "ui",
        action = "ui_mem_plots",
        db_table = "results_mem",
        schema = NULL,
        for_each_plan = list(tag_outcome = c("influensa_all")),
        dependencies = c("norsyss_mem_influensa_all"),
        args = list(
          tag = "influensa",
          icpc2 = "R60",
          contactType = "oppmote, telefonkontakt",
          folder_name = "mem_influensa",
          outputs = c("n_doctors_sheet")
        ),
        filter = "source=='data_norsyss'"
      )
    )
  )

  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_norsyss_mem_influensa_all",
        type = "ui",
        action = "ui_mem_plots",
        db_table = "results_mem",
        schema = NULL,
        for_each_plan = list(tag_outcome = c("influensa")),
        dependencies = c("simple_analysis_msis"),
        args = list(
          tag = "influensa",
          icpc2 = "R80",
          contactType = "oppmote",
          folder_name = "mem_influensa",
          outputs = c("charts", "county_sheet", "region_sheet", "norway_sheet")
        ),
        filter = "source=='data_norsyss'"
      )
    )
  )

  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_norsyss_pdf",
        type = "data",
        schema=list(input=sc::config$schemas$results_norsyss_standard),
        action="ui_norsyss_pdf",
        args = list(
          tags = c("gastro"),
          name_short = config[["def"]]$short_names,
          name_long = config[["def"]]$long_names
        )
      )
    )
  )
  sc::add_task(
    sc::task_from_config(
      list(
        name = "ui_archive_results_norsyss_standard",
        type = "data",
        schema=list(input=sc::config$schemas$results_norsyss_standard),
        action="ui_archive_results",
        args = list(
          folder = "norsyss_qp",
          years = 2
        )
      )
    )
  )




 p <- plnr::Plan$new(use_foreach=T)
 for(i in 1:30){
   p$add_analysis(fn = function(data, argset, schema){Sys.sleep(1)})
 }
 sc::add_task(
   sc::Task$new(
     name = "test_parallel_1",
     type = "analysis",
     plans = list(p),
     schema = c("output" = sc::config$schemas$results_normomo_standard),
     cores = min(6, parallel::detectCores()),
     chunk_size = 1
   )
 )

 sc::add_task(
   sc::Task$new(
     name = "test_parallel_2",
     type = "analysis",
     plans = list(p,p),
     schema = c("output" = sc::config$schemas$results_normomo_standard),
     cores = min(6, parallel::detectCores()),
     chunk_size = 1
   )
 )

}

test_parallel <- function(data, argset, schema){

}
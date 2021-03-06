#' ui_normomo_ssi
#' @param data a
#' @param argset a
#' @param schema a
#' @export
ui_normomo_ssi <- function(data, argset, schema) {
  # tm_run_task("ui_normomo_ssi")

  if(plnr::is_run_directly()){
    data <- sc::tm_get_data("ui_normomo_ssi", index_plan=1)
    argset <- sc::tm_get_argset("ui_normomo_ssi", index_plan=1, index_argset = 1)
    schema <- sc::tm_get_schema("ui_normomo_ssi")
  }

  folder <- fs::dir_ls(sc::path("output", "sykdomspulsen_normomo_restricted_output", create_dir = T), regexp = "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]")
  folder <- max(folder)
  folder <- fs::dir_ls(fs::path(folder, "ssi"), regexp="norway")
  yrwk <- stringr::str_extract(folder, "[0-9][0-9][0-9][0-9]-[0-9][0-9]$")
  yrwk <- stringr::str_replace(yrwk, "-", " ")
  folder <- fs::dir_ls(folder, regexp = "COMPLETE")
  file <- fs::dir_ls(folder)

  html <- glue::glue(
    "Dear EuroMOMO hub,<br><br>",
    "Please find attached the current week's results.<br><br>",
    "Sincerely,<br><br>",
    "Norway"
  )

  if(sc::config$permissions$ui_normomo_email_ssi$has_permission()){
    mailr(
      subject = glue::glue("[euromomo input] [Norway] [{yrwk}]"),
      html = html,
      to = e_emails(
        "ui_normomo_ssi",
        is_final = sc::config$permissions$ui_normomo_email_ssi$is_final()
      ),
      attachments = file,
      is_final = sc::config$permissions$ui_normomo_email_ssi$is_final()
    )
    sc::config$permissions$ui_normomo_email_ssi$revoke_permission()
  }
}

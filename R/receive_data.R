#' Receive Charging Data
#'
#' Memvalidasi data transaksi pengisian kendaraan listrik.
#'
#' @param df Data frame transaksi.
#'
#' @return Data frame yang telah divalidasi.
#' @export

receive_charging_data <- function(df) {

  kolom_wajib <- c(
    "id_transaksi",
    "nama_stasiun",
    "tanggal",
    "jam_mulai",
    "durasi_menit",
    "energi_kwh",
    "tarif_per_kwh",
    "status_pengisian"
  )

  if (!all(kolom_wajib %in% names(df))) {
    stop("Ada kolom wajib yang belum tersedia.")
  }

  if (any(is.na(df))) {
    warning("Data mengandung nilai NA.")
  }

  df <- df[df$durasi_menit > 0, ]
  df <- df[df$energi_kwh > 0, ]
  df <- df[df$status_pengisian == "Success", ]

  df$pendapatan <- df$energi_kwh * df$tarif_per_kwh

  rownames(df) <- NULL

  return(df)
}

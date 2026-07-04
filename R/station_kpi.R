#' Station KPI
#'
#' Menghasilkan indikator kinerja setiap stasiun pengisian.
#'
#' @param df Data frame transaksi.
#'
#' @return Data frame KPI stasiun.
#'
#' @export

get_station_kpi <- function(df){

  energi <- aggregate(
    energi_kwh ~ nama_stasiun,
    data = df,
    sum
  )

  pendapatan <- aggregate(
    pendapatan ~ nama_stasiun,
    data = df,
    sum
  )

  transaksi <- aggregate(
    id_transaksi ~ nama_stasiun,
    data = df,
    length
  )

  durasi <- aggregate(
    durasi_menit ~ nama_stasiun,
    data = df,
    sum
  )

  names(energi)[2] <- "total_energi_kwh"
  names(pendapatan)[2] <- "total_pendapatan"
  names(transaksi)[2] <- "jumlah_transaksi"
  names(durasi)[2] <- "total_durasi"

  hasil <- merge(energi, pendapatan, by = "nama_stasiun")
  hasil <- merge(hasil, transaksi, by = "nama_stasiun")
  hasil <- merge(hasil, durasi, by = "nama_stasiun")

  hasil$utilisasi_persen <-
    round(
      hasil$total_durasi /
        (24 * 30 * 60) *
        100,
      2
    )

  hasil$kategori <- cut(
    hasil$utilisasi_persen,
    breaks = c(-Inf, 40, 60, 80, Inf),
    labels = c("Poor", "Fair", "Good", "Excellent")
  )

  hasil
}

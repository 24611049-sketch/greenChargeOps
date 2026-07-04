#' Manage Charging Tariff
#'
#' Mengelola perubahan tarif pengisian kendaraan listrik.
#'
#' @param df Data frame transaksi.
#' @param tarif_baru Tarif baru per kWh.
#'
#' @return Data frame transaksi dengan tarif dan pendapatan terbaru.
#'
#' @export

manage_tariff <- function(df, tarif_baru){

  if(!is.numeric(tarif_baru)){
    stop("tarif_baru harus berupa numerik.")
  }

  if(length(tarif_baru) != 1){
    stop("Masukkan satu nilai tarif.")
  }

  if(tarif_baru <= 0){
    stop("Tarif harus lebih besar dari nol.")
  }

  df$tarif_lama <- df$tarif_per_kwh

  df$pendapatan_lama <- df$pendapatan

  df$tarif_per_kwh <- tarif_baru

  df$pendapatan <- df$energi_kwh *
    df$tarif_per_kwh

  df$selisih_pendapatan <-
    df$pendapatan -
    df$pendapatan_lama

  rownames(df) <- NULL

  df

}

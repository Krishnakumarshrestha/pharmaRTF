context("helpers")
library(huxtable)

test_that("insert_buffer adds a blank column correctly", {
  ht <- huxtable(
    column1 = 1:5,
    column2 = letters[1:5]
  )
  rtf <- rtf_doc(ht)

  ht_head1 <- huxtable(
    column1 = as.integer(1),
    column2 = "a"
  )
  ht_head2 <- huxtable(
    column1 = c("", "1"),
    column2 = c("", "a")
  )
  ht_head3 <- huxtable(
    column1 = c("", "1", "", ""),
    column2 = c("", "a", "", "")
  )
  ht_head4 <- huxtable(
    column1 = as.integer(1),
    column2 = c("a")
  )

  ## adding this attribute back in because this is stored in the doc os it
  # isn't needed here.
  attr(ht_head1, "header.rows") <- 1
  attr(ht_head2, "header.rows") <- 1
  attr(ht_head3, "header.rows") <- 1
  attr(ht_head4, "header.rows") <- 1

  expect_true(dplyr::all_equal(insert_buffer(rtf, rtf$table[1:header_rows(rtf$table)]), ht_head1))
  column_header_buffer(rtf) <- list(top = 1)
  expect_true(dplyr::all_equal(insert_buffer(rtf, rtf$table[1:header_rows(rtf$table)]), ht_head2))
  column_header_buffer(rtf) <- list(bottom = 2)
  expect_true(dplyr::all_equal(insert_buffer(rtf, rtf$table[1:header_rows(rtf$table)]), ht_head3))
  column_header_buffer(rtf) <- list(top = 0, bottom = 0)
  expect_true(dplyr::all_equal(insert_buffer(rtf, rtf$table[1:header_rows(rtf$table)]), ht_head4))

})

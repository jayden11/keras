
skip_if_no_keras <- function() {
  if (!reticulate::py_module_available("tensorflow.contrib.keras"))
    skip("keras not available for testing")
}


test_succeeds <- function(desc, expr) {
  test_that(desc, {
    skip_if_no_keras()
    expect_error(force(expr), NA)
  })
}

test_call_succeeds <- function(call_name, expr) {
  test_succeeds(paste(call_name, "call succeeds"), expr)
}

is_implementation <- function(name) {
  identical(name, getOption("keras.implementation", default = "tensorflow"))
}

is_backend <- function(name) {
  identical(backend()$backend(), name)
}

define_model <- function() {
  model <- keras_model_sequential() 
  model %>%
    layer_dense(32, input_shape = 784, kernel_initializer = initializer_ones()) %>%
    layer_activation('relu') %>%
    layer_dense(10) %>%
    layer_activation('softmax')
  model
}

define_and_compile_model <- function() {
  model <- define_model()
  model %>% 
    compile(
      loss='binary_crossentropy',
      optimizer = optimizer_sgd(),
      metrics='accuracy'
    )
  model
}





HiddenCheckThresholds <- function(Epsilon, ProbThreshold, EFDR, suffix) {
  
  if (Epsilon < 0 | !is.finite(Epsilon)) {
    stop(paste0("'Epsilon", suffix, "' must be a positive real value"))
  }
  if (!is.null(ProbThreshold)) {
    if (ProbThreshold < 0 | ProbThreshold > 1 | !is.finite(ProbThreshold)) {
      stop(paste0("'ProbThreshold", suffix, "' must be contained in (0,1) \n"))
    }
  }
  if (!is.null(EFDR)) {
    if(EFDR < 0 | EFDR > 1 | !is.finite(EFDR)) {
      stop(paste0("'EFDR_", suffix, "' must be contained in (0,1) \n"))
    }
  }
  if(is.null(EFDR) & is.null(ProbThreshold)) {
    stop(paste0("A value for 'EFDR_", suffix, "' or 'ProbThreshold", suffix, 
                "' must be provided \n"))  
  }
}

HiddenHeaderTest_DE <- function(Chain1,
                                Chain2,
                                EpsilonM,
                                EpsilonD,
                                EpsilonR,
                                EFDR_M,
                                EFDR_D,
                                EFDR_R,
                                ProbThresholdM,
                                ProbThresholdD,
                                ProbThresholdR,
                                OrderVariable,
                                GroupLabel1,
                                GroupLabel2,
                                GenesSelect,
                                Plot,
                                PlotOffset,
                                Offset,
                                ...)
{
  # Checking validity of input arguments
  if (!is(Chain1, "BASiCS_Chain")) {
    stop("'Chain1' is not a 'BASiCS_Chain' class object.")
  }
  if (!is(Chain2, "BASiCS_Chain")) {
    stop("'Chain2' is not a 'BASiCS_Chain' class object.")
  }

  # Test compatibility of both BASiCS_Chain objects
  if (ncol(Chain1@parameters$mu) != ncol(Chain2@parameters$mu)) {
    stop("The 'BASiCS_Chain' objects contain different number of genes.")
  }
  if (!identical(colnames(Chain1@parameters$mu), colnames(Chain2@parameters$mu))) {
    stop("The  'BASiCS_Chain' objects contain genes in different order.")
  }

  if (!is.logical(Plot) | length(Plot) != 1) {
    stop("Please insert TRUE or FALSE for 'Plot' parameter")
  }
  if (!is.logical(PlotOffset) | length(PlotOffset) != 1) {
    stop("Please insert TRUE or FALSE for 'PlotOffset' parameter")
  }
  if (!is.logical(Offset) | length(Offset) != 1) {
    stop("Please insert TRUE or FALSE for 'Offset' parameter")
  }

  if ("OffSet" %in% names(list(...))) {
    stop("'OffSet' is no longer a valid argument. Use 'Offset' instead.\n")
  }

  # Checks valid threshold input values
  HiddenCheckThresholds(EpsilonM, ProbThresholdM, EFDR_M, suffix = "M")
  HiddenCheckThresholds(EpsilonD, ProbThresholdD, EFDR_D, suffix = "D")
  if (!is.null(Chain1@parameters$epsilon)) {
    HiddenCheckThresholds(EpsilonR, ProbThresholdR, EFDR_R, suffix = "R")  
  }
  
  if (!(OrderVariable %in% c("GeneIndex", "GeneName", "Mu"))) {
    stop("Invalid 'OrderVariable' value")
  }
  if (!is.character(GroupLabel1) | length(GroupLabel1) > 1) {
    stop("Invalid value for 'GroupLabel1'")
  }
  if (!is.character(GroupLabel2) | length(GroupLabel2) > 1) {
    stop("Invalid value for 'GroupLabel2'")
  }

  GeneName <- colnames(Chain1@parameters$mu)
  if (!is.null(GenesSelect) & (length(GenesSelect) != length(GeneName))) {
    stop("Invalid value for 'GenesSelect'")
  }
  if (!is.null(GenesSelect) & !is.logical(GenesSelect)) {
    stop("Invalid value for 'GenesSelect'")
  }

#  if (!is.null(ProbThresholdM)) {
#    message("A value has been provided for `ProbThresholdM` \n",
#            "EFDR will not be calibrated in differential mean test. \n")
#  }

#  if (!is.null(ProbThresholdD)) {
#    message("A value has been provided for `ProbThresholdD` \n",
#            "EFDR will not be calibrated in differential over-dispersion test. \n")
#  }
}

#!/bin/env python

import sys
import ROOT

from SimGeneral.MixingModule.mix_2016_25ns_Moriond17MC_PoissonOOTPU_cfi import *

# print mix.input.nbPileupEvents.probFunctionVariable
# print mix.input.nbPileupEvents.probValue

binMin = 0
binMax = 100

hist = ROOT.TH1D("pileup", "pileup", binMax-binMin, binMin, binMax)

for bin in mix.input.nbPileupEvents.probFunctionVariable:
    hist.SetBinContent(bin+1, mix.input.nbPileupEvents.probValue[bin])

file = ROOT.TFile.Open("root/pileup_mc_2016.root", "recreate")

hist.Write()
file.Write()
file.Close()

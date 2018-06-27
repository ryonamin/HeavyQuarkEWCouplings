#include <iostream>

using std::cout;
using std::endl;
#include "TString.h"

#include <TMath.h>
#include <TStyle.h>
#include <TProfile.h>
#include <TF1.h>
#include <TH1.h>
#include <TH2.h>
#include <TFile.h>
#include <TCanvas.h>
#include <THStack.h>
#include "TLegend.h"
#include "TPaveText.h"
void drawbtag(){
  const int Nvar = 3;

  TFile*fin;
  TFile*finx;
  TString filename = "/unix/lc/sohail/data/root/newsamplecheck.root";
  fin=new TFile(filename,"read");
  //  TString filenamex = "eL_background.root";
  //  finx=new TFile(filenamex,"read");

  TString temp[Nvar]={"BTagvsCosTheta1","BTagvsCosTheta2" , "BTagvsCosTheta3"  };

  TH2F* temph[Nvar];
    for(int i=0;i<Nvar;i++){
      temph[i]=(TH2F*)fin->Get(temp[i]);
    }

    TH2F * bgbtag = (TH2F*)fin->Get(temp[0]);
    //    bgbtag->Sclae(1);
    TProfile*pr1;
    TProfile*pr2;
    TProfile*pr3;
    TProfile*pr4;

    pr1 = temph[0]->ProfileX();
    pr2 = temph[1]->ProfileX();
    pr3 = temph[2]->ProfileX();
    pr4 = bgbtag->ProfileX();
    /*    temph[0]->SetTitle("");

    temph[0]->GetXaxis()->SetTitle("Q_{b}");
    temph[0]-> SetLineWidth(3);
    temph[0]->GetXaxis()->CenterLabels();
    temph[0]->GetXaxis()->SetRange(3,9);
    temph[0]->SetFillColor(2);
    temph[0]->SetLineColor(2);
    temph[0]->SetFillStyle(3004);
    temph[0]->SetMarkerStyle(20);
    temph[0]->SetMarkerSize(1.3);
    //    temph[0]->GetYaxis()->SetLabelSize(0.04);
    temph[0]->GetXaxis()->SetTitleSize(0.07);
    temph[0]->GetXaxis()->SetNdivisions(511);
    */

    pr1->Draw();
    pr2->Draw("same");
    pr3->Draw("same");
    pr4->Draw("same");

   TLegend *leg = new TLegend(0.2011494,0.6949153,0.3318966,0.8961864,NULL,"brNDC");

   leg->SetBorderSize(0);
   leg->SetTextSize(0.05508474);
   leg->SetLineColor(2);
   leg->SetLineStyle(2);
   leg->SetLineWidth(2);
   leg->SetFillColor(0);
   leg->SetFillStyle(1001);

   TLegendEntry *entry=leg->AddEntry(temph[0]," b quark","f");
   entry=leg->AddEntry(temph[1]," \\bar{b} quark","f");

   //   leg->Draw("same");




		
};

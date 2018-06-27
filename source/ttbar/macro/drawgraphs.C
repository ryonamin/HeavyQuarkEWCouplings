#include <iostream>

using std::cout;
using std::endl;
#include "TString.h"
#include <TMath.h>
#include <TStyle.h>
#include <TF1.h>
#include <TH1.h>
#include <TH2.h>
#include <TFile.h>
#include <TCanvas.h>
#include <THStack.h>
#include "TGraph.h"
#include "TGraphErrors.h"
#include "TLegend.h"
#include "TPaveText.h"

void drawgraphs(){
  //  TFile* fin=new TFile("grandcomb.root",,"read");
  TFile* fin=new TFile(" sumrooteRpL_813tx.root","read");
  TH1F* topangle = (TH1F*)fin->Get("TopAngle"); 
  TH1F* topanglebc = (TH1F*)fin->Get("TopAngle_bc"); 
  // TH1F* topangle = (TH1F*)fin->Get("Topanglecomp4c"); 
  // TH1F* topanglebc = (TH1F*)fin->Get("Topanglecomp4"); 


   TH1F* topanglemc = (TH1F*)fin->Get("TopAngle_mc"); 
   TH1F* topanglefc = (TH1F*)fin->Get("WrongQ"); 
   float f=topangle->Integral(topangle->FindBin(0.),topangle->FindBin(1.1));
   float t=topangle->GetEntries();
   float asymm= ( 2*f-t)/t;
   float val = 100*asymm-int(100*asymm);
   float val2 = int(100000*asymm);
   float eff = t/(topanglemc->GetEntries());
   float err = sqrt((1 - asymm*asymm)/(t));
   cout <<" error " <<  err << endl;
     //   cout << " Value " << val << " : " << int(asymm) <<"."<<val2<<endl; 
   //   cout << " Trick 2 " << int(100*asymm) << "." << int(1000* (100*asymm-int(100*asymm)))<<endl;;




   float fb=topanglebc->Integral(topanglebc->FindBin(0.),topanglebc->FindBin(1.1));
   float tb=topanglebc->GetEntries();
   float asymmb= ( 2*fb-tb)/tb;

   float effb = tb/(topanglemc->GetEntries());
   float errb = sqrt((1 - asymmb*asymmb)/(tb));
   cout <<" error bc" <<  errb << endl;


   float fm=topanglemc->Integral(topanglemc->FindBin(0.),topanglemc->FindBin(1.1));
   float tm=topanglemc->GetEntries();
   float asymmm= ( 2*fm-tm)/tm;

   float effm = tm/(topanglemc->GetEntries());
   float errm = sqrt((1 - asymmm*asymmm)/(tm));
   cout <<" error mc" <<  errm << endl;

  
   int step=10;
   Int_t n = 20;
   float ft[n], theta[n], ftb[n],thetab[n], ftm[n], ftf[n];
   topangle->Scale(t/topangle->Integral());
   topanglebc->Scale(t/topanglebc->Integral());
   topanglemc->Scale(t/topanglemc->Integral());
   topanglefc->Scale(t/topanglefc->Integral());
   cout <<topangle->Integral()<<":"<<(topanglebc->Integral())<<":"<<(topanglefc->Integral()) << endl;
   for(int i=0;i<n;i++){
     int j=5*i;
     //     cout << " J = " << j << " : +5 = " << j+5 << endl;
     ft[i] =  topangle->Integral(0,j+5);
     ftb[i] =  topanglebc->Integral(0,j+5);
     ftm[i] =  topanglemc->Integral(0,j+5);
     ftf[i] =  topanglefc->Integral(0,j+5);
     float k=i;
     theta[i]=k/10-0.9;
     // thetabc[i]=k/10-0.9;
     //     cout << "Theta = " << k << "/5 = " << k/10 << "- 2 = "<< k/10-0.9 << endl;  
     cout << theta[i]<< " : " << ftm[i] << " , " <<ftb[i]<< " , " << ft[i] << endl; 
}
   TGraph * afb = new TGraph (n, theta, ft);
   TGraph * afbb = new TGraph (n, theta, ftb);
   TGraph * afbm = new TGraph (n, theta, ftm);
   TGraph * afbf = new TGraph (n, theta, ftf);

   afbm->SetTitle("Afb Comparison");
   afbm->GetXaxis()->SetTitle("Cos(\\theta_{t}) ");
   afbm->GetXaxis()->SetLabelOffset(0.006);
   afbm->GetXaxis()->SetLabelSize(0.03);
   afbm->GetXaxis()->SetTitleSize(0.03);
   afbm->GetXaxis()->SetTitleFont(42);
   afbm->GetYaxis()->SetLabelOffset(0.008);
   afbm->GetYaxis()->SetLabelSize(0.03);
   afbm->GetYaxis()->SetTitleSize(0.05);
   afbm->GetYaxis()->SetTitleOffset(1.2);
   


   afbm->SetMarkerStyle(20);
   afbm->SetMarkerSize(0.9);
   afbm->SetLineColor(4);
   afbm->SetMarkerColor(4);

   afbb->SetMarkerStyle(21);
   afbb->SetMarkerSize(0.9);
   afbb->SetLineColor(2);
   afbb->SetMarkerColor(2);

   afb->SetMarkerStyle(22);
   afb->SetMarkerSize(0.9);
   afb->SetLineColor(3);
   afb->SetMarkerColor(3);

   afbf->SetMarkerStyle(23);
   afbf->SetMarkerSize(0.9);
   afbf->SetLineColor(6);
   afbf->SetMarkerColor(6);


   //   afb->Draw("samepl*");

   TPaveText *pt = new TPaveText(0.03178928,0.9238303,0.3188011,0.9771491,"blNDC");
   pt->SetName("title");
   pt->SetBorderSize(0);
   pt->SetFillColor(0);
   pt->SetTextFont(42);
   TText *text = pt->AddText("Afb Comparison");
   pt->Draw();
   

   TLegend *leg = new TLegend(0.2025431,0.6942329,0.3324251,0.8944505,NULL,"brNDC");

   leg->SetTextFont(62);
   leg->SetTextSize(0.03242823);
   leg->SetLineColor(2);
   leg->SetLineStyle(2);
   leg->SetLineWidth(2);
   leg->SetFillColor(0);
   leg->SetFillStyle(1001);
   leg->SetShadowColor(0);



   
   TString legm="Monte Carlo ";
   legm+=int(asymmm);
   legm+=".";
   legm+= int(100000*asymmm);
   //   legm+= int(1000* (100*asymmm-int(100*asymmm)));
   //   legm+="%";
   leg->AddEntry(afbm,legm,"p"); 
   TString legbc="Before Correction ";
   legbc+=int(asymmb);
   legbc+=".";
   legbc+= int(100000*asymmb);
   //   legbc+="%";
   leg->AddEntry(afbb,legbc,"p");
   TString legx="After Correction ";
   legx+=int(asymm);
   legx+=".";
   legx+= int(100000*asymm);
   //   legx+=" +/- ";
   //   legx+=err;
   //   legx+="%";
   leg->AddEntry(afb,legx,"p");


  

   TCanvas* cc = new  TCanvas("c1","Afb",10,10,900,700);
   cc->Print("graphs_afbtempx.ps[");
   //    TCanvas *c1 = new TCanvas("c1","Afb",10,10,600,400);
   afbm->Draw("ACsamepl");  
   afbb->Draw("samepl");
   afb->Draw("samepl");
   leg->Draw("same");
  
   cc->Print("graphs_afbtempx.ps");
   
   TLegend *legb = new TLegend(0.2025431,0.6942329,0.3324251,0.8944505,NULL,"brNDC");
   
   /*   legb->SetTextFont(62);
   legb->SetTextSize(0.03242823);
   legb->SetLineColor(2);
   legb->SetLineStyle(2);
   legb->SetLineWidth(2);
   legb->SetFillColor(0);
   legb->SetFillStyle(1001);
   legb->SetShadowColor(0);
   
   legb->AddEntry(afbb,"Before Correction","p");
   legb->AddEntry(afb,"After Correction","p");
   legb->AddEntry(afbf,"Wrong Charge","p"); 
   
   afbb->Draw("ACsamepl");
   afb->Draw("samepl");
   afbf->Draw("samepl");  
   legb->Draw("same");
  
   cc->Print("graphs_afbtempx.ps");
   */
   
   cc->Print("graphs_afbtempx.ps]");





   Int_t nd = 20;
   Double_t x[nd], y[nd];
   for (Int_t i=0; i<nd; i++) {
     x[i] = i*0.1;
     y[i] = 10*sin(x[i]+0.2);
   }
   TGraph *gr1 = new TGraph (nd, x, y);
   //   TCanvas *c1 = new TCanvas("c1","Graph Draw Options",200,10,600,400);
   //   gr1->Draw("AC*");

}
 




#!/bin/bash

#prepreindices=( 0 1 2 3 4 5 6 7 8 9 )
#prepreindices=( 0 )

preindices=( 0 1 2 3 4 5 6 7 8 9 )

#indices=( 0 1 2 3 4 5 6 7 8 9)


processes=( z_h ) 

pols=(eL.pR eR.pL )
eve=(400)

for proc in ${processes[@]}
  do
  for pol in ${pols[@]}
    do

if [ ${pol} == "eR.pL" ]; then
	if [ ${proc} == "bbcyyc" ]; then
	    pid=37623
	elif [ ${proc} == "bbuyyu" ]; then
	    pid=37611
	elif [ ${proc} == "yycyyu" ]; then
	    pid=36915
	elif [ ${proc} == "yyuyyc" ]; then
	    pid=36911
	elif [ ${proc} == "zz" ]; then
	    pid=250004
	elif [ ${proc} == "ww" ]; then
	    pid=250008	    
	elif [ ${proc} == "yyxylv" ]; then
	    pid=36903
	elif [ ${proc} == "yyxyev" ]; then
	    pid=36899
	elif [ ${proc} == "yyveyx" ]; then
	    pid=36883
	elif [ ${proc} == "yyvlyx" ]; then
	    pid=36895
	elif [ ${proc} == "z_h" ]; then
	    pid=250116
	elif [ ${proc} == "ww_l" ]; then
	    pid=250024
	fi 
    elif [ ${pol} == "eL.pR" ]; then
  	if [ ${proc} == "bbcyyc" ]; then
	    pid=37622
	elif [ ${proc} == "bbuyyu" ]; then
	    pid=37610
	elif [ ${proc} == "yycyyu" ]; then
	    pid=36914
	elif [ ${proc} == "yyuyyc" ]; then
	    pid=36910
	elif [ ${proc} == "zz" ]; then
	    pid=250002
	elif [ ${proc} == "ww" ]; then
	    pid=250006
	elif [ ${proc} == "yyxylv" ]; then
	    pid=36902
	elif [ ${proc} == "yyxyev" ]; then
	    pid=36898
	elif [ ${proc} == "yyveyx" ]; then
	    pid=36882
	elif [ ${proc} == "yyvlyx" ]; then
	    pid=36894
	elif [ ${proc} == "z_h" ]; then
	    pid=250114
	elif [ ${proc} == "ww_l" ]; then
	    pid=250026
	fi 
    fi


for preindex in ${preindices[@]}
  do

if [ ${preindex} -lt 10 ]; then
         indices=( 0 1 2 3 4 5 6 7 8 9  )
# 7 8 9 )
     elif [ ${preindex} -eq 10 ]; then
         indices=( 0 1 2 3 4 )
#5 6 7 8  )
     fi
  for index in ${indices[@]}
    do
    echo Index is $preindex$index Process ID $pid  Process $proc Polarization $pol

    cat > myflavortagging.xml << EOF
    
    <marlin>
    
    <execute>
    <processor name="MyFastJetProcessor" />
    <processor name="JetClusteringAndFlavorTag"/>
    <processor name="MyLCIOOutputProcessor"/>
    </execute>
    
    <global>
    <!--parameter name="LCIOInputFiles">/sps/flc/amjad/data/top/reconstructed/rv01-16-p05_500.sv01-14-01-p00.mILD_o1_v05.E500-TDR_ws.I${pid}.P4f_${proc}_h.${pol}-000${preindex}${index}-DST.slcio </parameter-->

    <parameter name="LCIOInputFiles"> /sps/flc/amjad/data/top/reconstructed/rv01-16-p05_500.sv01-14-01-p00.mILD_o1_v05.E500-TDR_ws.I${pid}.P2f_${proc}.${pol}-001${preindex}${index}-DST.slcio </parameter>
    <!--rv01-16-p04_nobg.sv01-14-01-p00.mILD_o1_v05.E500-TDR_ws.I37611.P6f_bbuyyu.eR.pL-000${preindex}${index}-DST.slcio</parameter-->
    <!--parameter name="LCIOInputFiles">/sps/flc/amjad/data/top/reconstructed/rv01-16-p05_500.sv01-14-01-p00.mILD_o1_v05.E500-TDR_ws.I37611.P6f_bbuyyu.eR.pL-000${preindex}${index}-DST.slcio</parameter-->

    
  <parameter name="MaxRecordNumber" value=${eve} />  
  <parameter name="SkipNEvents" value="0" />  
  <parameter name="SupressCheck" value="false" />  
  <parameter name="GearXMLFile"> gear_ILD_o1_v05.xml </parameter>  
  <parameter name="Verbosity" options="DEBUG0-4,MESSAGE0-4,WARNING0-4,ERROR0-4,SILENT">WARNING</parameter> 
  </global>
  


  <################### MyFastJetProcessor ######################################## >

  <processor name="MyFastJetProcessor" type="FastJetProcessor">
  <parameter name="algorithm" type="StringVec"> kt_algorithm 1.50 </parameter>
  <parameter name="clusteringMode" type="StringVec"> ExclusiveNJets 6 </parameter>
  <parameter name="recombinationScheme" type="string"> E_scheme </parameter>
  <parameter name="recParticleIn" type="string" lcioInType="ReconstructedParticle"> PandoraPFOs </parameter>
    <parameter name="jetOut" type="string" lcioOutType="ReconstructedParticle"> JetsAfterGamGamRemoval </parameter>
  </processor>
  


  <################### JetClusteringAndFlavorTag######################################## >



  <processor name="JetClusteringAndFlavorTag" type="LcfiplusProcessor">

  
  <!-- run primary and secondary vertex finders -->
  <parameter name="Algorithms" type="stringVec"> JetVertexRefiner FlavorTag ReadMVA</parameter>
  <!--parameter name="Algorithms" type="stringVec"> JetClustering JetVertexRefiner FlavorTag ReadMVA</parameter-->
  
  <!-- general parameters -->
  <parameter name="PFOCollection" type="string" value="PandoraPFOs" /> <!-- input PFO collection -->
  <parameter name="UseMCP" type="int" value="0" /> <!-- MC info not used -->
  <parameter name="MCPCollection" type="string" value="" /> <!-- not used -->
  <parameter name="MCPFORelation" type="string" value="" /> <!-- not used -->
  <parameter name="ReadSubdetectorEnergies" type="int" value="1"/> <!-- true for ILD -->
  <parameter name="UpdateVertexRPDaughters" type="int" value="0"/> <!-- false for non-updative PandoraPFOs -->
  
  <parameter name="FlavorTag.D0ProbFileName" type="string" value="vtxprob/d0prob_zpole.root"/>
  <parameter name="FlavorTag.Z0ProbFileName" type="string" value="vtxprob/z0prob_zpole.root"/>
  <!-- jet clustering parameters -->
  <parameter name="JetClustering.InputVertexCollectionName" type="string" value="BuildUpVertex" /> <!-- vertex collections to be used in JC -->
  <parameter name="JetClustering.OutputJetCollectionName" type="stringVec" value="VertexJets" /> <!-- output collection name, may be multiple -->
  <!--parameter name="JetClustering.OutputJetCollectionName" type="stringVec" value="VertexJets" /--> <!-- output collection name, may be multiple -->
  <parameter name="JetClustering.NJetsRequested" type="intVec" value="6" /> <!-- Multiple NJets can be specified -->
  
  <parameter name="JetClustering.YCut" type="doubleVec" value="0." /> <!-- specify 0 if not used -->
  <parameter name="JetClustering.UseMuonID" type="int" value="1" /> <!-- jet-muon ID for jet clustering -->
  <parameter name="JetClustering.VertexSelectionMinimumDistance" type="double" value="0.3" /> <!-- in mm -->
  <parameter name="JetClustering.VertexSelectionMaximumDistance" type="double" value="30." /> <!-- in mm -->
  <parameter name="JetClustering.VertexSelectionK0MassWidth" type="double" value="0.02" /> <!-- in GeV -->
  <parameter name="JetClustering.YAddedForJetVertexVertex" type="double" value="100"/> <!-- add penalty for combining vertices -->
  <parameter name="JetClustering.YAddedForJetLeptonVertex" type="double" value="100"/> <!-- add penalty for combining lepton and vertex -->
  <parameter name="JetClustering.YAddedForJetLeptonLepton" type="double" value="100"/> <!-- add penalty for combining leptons -->
  
  <!-- vertex refiner parameters -->
  <parameter name="JetVertexRefiner.InputJetCollectionName" type="string" value="JetsAfterGamGamRemoval" />
  <!--parameter name="JetVertexRefiner.InputJetCollectionName" type="string" value="VertexJets" /-->
  <!--parameter name="JetVertexRefiner.InputJetCollectionName" type="string" value="VertexJets_A" /-->
  <parameter name="JetVertexRefiner.OutputJetCollectionName" type="string" value="RefinedJets" />
  <!--parameter name="JetVertexRefiner.OutputJetCollectionName" type="string" value="RefinedJets_A" /-->
  <parameter name="JetVertexRefiner.PrimaryVertexCollectionName" type="string" value="PrimaryVertex" />
  <parameter name="JetVertexRefiner.InputVertexCollectionName" type="string" value="BuildUpVertex" />
  <parameter name="JetVertexRefiner.V0VertexCollectionName" type="string" value="BuildUpVertex_V0" />
  <parameter name="JetVertexRefiner.OutputVertexCollectionName" type="string" value="RefinedVertex" />
  <!--parameter name="JetVertexRefiner.OutputVertexCollectionName" type="string" value="RefinedVertex_A" /-->
  
  <parameter name="JetVertexRefiner.MinPosSingle" type="double" value="0.3" />
  <parameter name="JetVertexRefiner.MaxPosSingle" type="double" value="30." />
  <parameter name="JetVertexRefiner.MinEnergySingle" type="double" value="1." />
  <parameter name="JetVertexRefiner.MaxAngleSingle" type="double" value="0.5" />
  <parameter name="JetVertexRefiner.MaxSeparationPerPosSingle" type="double" value="0.1" />
  <parameter name="JetVertexRefiner.mind0sigSingle" type="double" value="5." />
  <parameter name="JetVertexRefiner.minz0sigSingle" type="double" value="5." />
  <parameter name="JetVertexRefiner.OneVertexProbThreshold" type="double" value="0.001" />
  <parameter name="JetVertexRefiner.MaxCharmFlightLengthPerJetEnergy" type="double" value="0.1" />
  
  <!-- FlavorTag parameters -->
  <parameter name="PrimaryVertexCollectionName" type="string" value="PrimaryVertex" />
  <parameter name="FlavorTag.JetCollectionName" type="string" value="RefinedJets" />
  <parameter name="MakeNtuple.AuxiliaryInfo" type="int" value="-1" />
  
  <parameter name="FlavorTag.WeightsDirectory" type="string" value="lcfiweights" />
  <parameter name="FlavorTag.WeightsPrefix" type="string" value=" 6q500_v01_p01" />
  <!--parameter name="FlavorTag.WeightsPrefix" type="string" value="zpole_v00" /-->
  <parameter name="FlavorTag.BookName" type="string" value="bdt" />
  <parameter name="FlavorTag.PIDAlgo" type="string" value="lcfiplus" />
  
  <parameter name="FlavorTag.CategoryDefinition1" type="string">nvtx==0</parameter>
  <parameter name="FlavorTag.CategoryPreselection1" type="string">trk1d0sig!=0</parameter>
  <parameter name="FlavorTag.CategoryVariables1" type="stringVec">
  trk1d0sig trk2d0sig trk1z0sig trk2z0sig trk1pt_jete trk2pt_jete jprobr jprobz
  </parameter>
  <parameter name="FlavorTag.CategorySpectators1" type="stringVec">
  aux nvtx
  </parameter>
  
  <parameter name="FlavorTag.CategoryDefinition2" type="string">nvtx==1&&nvtxall==1</parameter>
  <parameter name="FlavorTag.CategoryPreselection2" type="string">trk1d0sig!=0</parameter>
  <parameter name="FlavorTag.CategoryVariables2" type="stringVec">
  trk1d0sig trk2d0sig trk1z0sig trk2z0sig trk1pt_jete trk2pt_jete jprobr jprobz
  vtxlen1_jete vtxsig1_jete vtxdirang1_jete vtxmom1_jete vtxmass1 vtxmult1 vtxmasspc vtxprob
  </parameter>
  <parameter name="FlavorTag.CategorySpectators2" type="stringVec">
  aux nvtx
  </parameter>
  <parameter name="TrackHitOrdering" type="int" value="1"/> <!-- Track hit ordering: 0=ILD-LOI,SID-DBD, 1=ILD-DBD --> 
  <parameter name="FlavorTag.CategoryDefinition3" type="string">nvtx==1&&nvtxall==2</parameter>
  <parameter name="FlavorTag.CategoryPreselection3" type="string">trk1d0sig!=0</parameter>
  <parameter name="FlavorTag.CategoryVariables3" type="stringVec">
  trk1d0sig trk2d0sig trk1z0sig trk2z0sig trk1pt_jete trk2pt_jete jprobr jprobz
  vtxlen1_jete vtxsig1_jete vtxdirang1_jete vtxmom1_jete vtxmass1 vtxmult1 vtxmasspc vtxprob
  1vtxprob vtxlen12all_jete vtxmassall
  </parameter>
  <parameter name="FlavorTag.CategorySpectators3" type="stringVec">
  aux nvtx
  </parameter>
  
  <parameter name="FlavorTag.CategoryDefinition4" type="string">nvtx>=2</parameter>
  <parameter name="FlavorTag.CategoryPreselection4" type="string">trk1d0sig!=0</parameter>
  <parameter name="FlavorTag.CategoryVariables4" type="stringVec">
  trk1d0sig trk2d0sig trk1z0sig trk2z0sig trk1pt_jete trk2pt_jete jprobr jprobz
  vtxlen1_jete vtxsig1_jete vtxdirang1_jete vtxmom1_jete vtxmass1 vtxmult1 vtxmasspc vtxprob
  vtxlen2_jete vtxsig2_jete vtxdirang2_jete vtxmom2_jete vtxmass2 vtxmult2
  vtxlen12_jete vtxsig12_jete vtxdirang12_jete vtxmom_jete vtxmass vtxmult
  1vtxprob
  </parameter>
  <parameter name="FlavorTag.CategorySpectators4" type="stringVec">
  aux nvtx
  </parameter>
  
  </processor>
  
  <processor name="MyLCIOOutputProcessor" type="LCIOOutputProcessor">
  <parameter name="LCIOOutputFile" type="string">/sps/flc/amjad/data/top/flavortagged/xggremove_withbg_I${pid}.P2f_${proc}.${pol}-001${preindex}${index}-DST.slcio </parameter>
  <!--parameter name="LCIOOutputFile" type="string">/sps/flc/amjad/data/top/flavortagged/P2f_ggremoved_${proc}_h.${pol}-000${preindex}${index}-DST.slcio </parameter-->
                                                                                                       
  <parameter name="LCIOWriteMode" type="string" value="WRITE_NEW"/>
  </processor>
  
  </marlin>
  

  
EOF
 
Marlin  myflavortagging.xml
  
  done
done

  done
done
exit 0

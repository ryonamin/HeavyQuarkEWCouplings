    cat > myflavortagging.xml << EOF
    
    <marlin>
    
    <execute>
    <processor name="MyFastJetProcessor" />
    <processor name="JetClusteringAndFlavorTag"/>
    <processor name="MyLCIOOutputProcessor"/>
    </execute>
    
    <global>
    <parameter name="LCIOInputFiles"> /unix/lc/sohail/data/gridslcio/rv01-19-05-p01.sv01-19-05-p01.mILD_l5_o1_v02.E500-TDR_ws.I108675.Pyyxylv.eL.pR.n001_009.d_dst_00009261_712.slcio </parameter>
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
  <parameter name="LCIOOutputFile" type="string"> /unix/lc/sohail/data/flavortagslcio/rv01-19-05-p01.sv01-19-05-p01.mILD_l5_o1_v02.E500-TDR_ws.I108675.Pyyxylv.eL.pR.n001_009.d_dst_00009261_712.slcio  </parameter> 
  <parameter name="LCIOWriteMode" type="string" value="WRITE_NEW"/>
  </processor>
  
  </marlin>
  

  
EOF
 
Marlin  myflavortagging.xml
  
exit 0

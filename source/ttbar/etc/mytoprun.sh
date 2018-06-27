#!/bin/bash
eve=(100)
    cat > topsrun.xml << EOF
  
    <marlin>
    
    <execute>
       <processor name="ttbar"/>
    </execute>
    
  <!--######## Global   ######################################## -->
       <global>
       <parameter name="LCIOInputFiles"> /unix/lc/sohail/data/slcio/xggremove_withbg_I37623.P6f_bbcyyc.eR.pL-00025-DST.slcio </parameter>
       <parameter name="GearXMLFile" value="gear_ILD_o1_v05.xml"/>
       <parameter name="MaxRecordNumber" value=${eve}/>
       <parameter name="SkipNEvents" value="0"/>
       <parameter name="SupressCheck" value="false"/>
       <!--parameter name="Verbosity" options="DEBUG0-4,MESSAGE0-4,WARNING0-4,ERROR0-4,SILENT"> MESSAGE </parameter-->
       <parameter name="RandomSeed" value="1234567890" />
       </global>
  
   
       <!--########  ttbar  ######################################## -->
       <processor name="ttbar" type="ttbar">
       <parameter name="RefinedJets" type="string" lcioInType="ReconstructedParticle"> RefinedJets </parameter>
       <parameter name="RefinedJets_vtx_RP" type="string" lcioInType="ReconstructedParticle"> RefinedJets_vtx_RP </parameter>
       <parameter name="RefinedJets_rel" type="string" lcioInType="LCRelation"> RefinedJets_rel </parameter>
       <parameter name="MCCollection" type="string" lcioInType="MCParticle"> MCParticlesSkimmed  </parameter>
       <parameter name="ROOTFileName"> /unix/lc/sohail/data/root/xggremove_withbg_I37623.P6f_bbcyyc.eR.pL-00025-DST_newtest.root </parameter>
       </processor>


  </marlin>
  

  
EOF
 
Marlin  topsrun.xml 

 echo "                     Number of Events Processed : "  $eve

  
exit 0

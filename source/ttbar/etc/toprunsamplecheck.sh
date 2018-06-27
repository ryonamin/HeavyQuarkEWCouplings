#!/bin/bash

eve=(200)
n=001;

basename=/unix/lc/sohail/data/gridft/rv01-19-05-p01.sv01-19-05-p01.mILD_l5_o1_v02.E500-TDR_ws.I1086;
for file in ${basename}*;

do 
 echo ${file}
    cat > topsrunsc.xml << EOF

  
    <marlin>
    
    <execute>
       <processor name="ttbar"/>
    </execute>
    
  <!--######## Global   ######################################## -->
       <global>
       <parameter name="LCIOInputFiles"> ${file} </parameter>
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
       <parameter name="ROOTFileName"> ${file%.slcio}.root  </parameter>
       </processor>


  </marlin>
  

  
EOF
 
Marlin  topsrunsc.xml 

 echo "                     Number of Events Processed : "  $eve
  n=$((n+1));  
done 
exit 0

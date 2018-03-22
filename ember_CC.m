%  gptoolbox installation required 

clear
close all

[V,F] = readSTL('./AutoDesk_Open_Source_3D_Printer_Ember/files/EMBER_Assembly.stl');

[V1,F1] = remove_degenerate_faces(V,F);
[SV,SVI,SVJ] = remove_duplicate_vertices(V1,1e-7);
SF = SVJ(F1);

C = connected_components(F1);

cc = unique(C);


for i = 1:max(C)
  
  V_mapping = find(C==i);
  disp(i)
  disp(length(V_mapping))
  keySet = 1:length(V_mapping);

  mapObj = containers.Map(V_mapping,keySet);  
  
  Vi = V1(V_mapping,:);
  
  Fi = [];
  for j=1:size(F1,1)
    if (C( F1(j,1)) == i)
      Fi1 = mapObj(F1(j,1));
      Fi2 = mapObj(F1(j,2));
      Fi3 = mapObj(F1(j,3));
      Fi = [Fi; [Fi1 Fi2 Fi3]];
    end
  end
  
  writeSTL(sprintf('STL_files/%i.stl', i) ,Vi,Fi);

end


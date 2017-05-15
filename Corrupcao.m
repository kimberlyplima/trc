    clc
    clear all

    [FileName, PatchName] = uigetfile('*', 'Selecione o arquivo');
    diretorio = strcat(PatchName, FileName);

    IDarquivo = fopen(diretorio); 
    BitsComTrc = uint8(fread(IDarquivo, [1, inf], 'ubit1'));
    Tam = length(BitsComTrc);
    
    for i = 1:Tam
       BitACorromper = round((Tam*rand(1,1)));

       if (BitACorromper <= (round(Tam*0.03)))
            BitsComTrc(i) = not(BitsComTrc(i));
       end
    end
    
    Filecodif = fopen('BitsCorrompidosComTRC.bin', 'w');
    fwrite(Filecodif, BitsComTrc, 'ubit1');
    fclose(Filecodif);
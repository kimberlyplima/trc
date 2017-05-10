    clc % Limpa os comandos
    clear all % Limpa a memoria

    [FileName, PatchName] = uigetfile('*', 'Selecione o arquivo');
    diretorio = strcat(PatchName, FileName);

    IDarquivo = fopen(diretorio); % Abre o arquivo a ser cifrado e atribui a IDarquivo
    Conteudoarquivo = uint8(fread(IDarquivo, [1, inf], 'ubit1')); % Le o conteudo, bit a bit, do arquivo selecionado
    Tam = length(Conteudoarquivo); % Le o tamanho do arquivo e salva na variavel Tam


    Conteudoarquivo


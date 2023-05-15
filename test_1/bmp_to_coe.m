[picture] = imread('character.bmp');
picture_size = size(picture);       %figure out how big the image is
num_rows = picture_size(1);
num_columns = picture_size(2);

pixel_columns = zeros(95*512,1,'logical');  %pre-allocate a space for a new column vector

for no = 1:95
    for r = 1:32
        for c = 1:16
            if r <= 20 && c <= 13
                pixel_columns((no-1)*512+(r-1)*16+c) = picture(r,c+(no-1)*13);
            else
                pixel_columns((no-1)*512+(r-1)*16+c) = 0;
            end
        end
    end
end

rounded_data = round(pixel_columns);    %rounds them down
data = dec2bin(rounded_data,1);         %convert the binary data to 1 bit binary #s

%open a file
output_name = 'image.coe';
file = fopen(output_name,'w');

%write the header info
fprintf(file,'memory_initialization_radix=2;\n');
fprintf(file,'memory_initialization_vector=\n');
fclose(file);

%put commas in the data
rowxcolumn = size(data);
rows = rowxcolumn(1);
columns = rowxcolumn(2);
output = data;
for i = 1:(rows-1)
    output(i,(columns+1)) = ',';
end
output(rows,(columns+1)) = ';';

%append the numeric values to the file
dlmwrite(output_name,output,'-append','delimiter','', 'newline', 'pc');

function string = arabic2roman( arabic_in )
















roman_num  = { 'I' 'V' 'X' 'L' 'C' 'D' 'M' };
string = '';

if (arabic_in > 3999)
    error('arabic2roman:gt3999',...
        'Arabic number input is greater than 3999');
end

arabic_str = num2str( arabic_in );
len_arabic_str = length( arabic_str );

for index = len_arabic_str:-1:1
    j = 2*( len_arabic_str - index ) + 1;
    switch arabic_str( index )
        case '0'
            continue;
        case {'1' '2' '3'}
            for i = 1:str2double( arabic_str( index ))
                string = sprintf('%s%s', roman_num{ j }, string);
            end
        case '4'
            string = sprintf('%s%s%s', roman_num{ j }, roman_num{ j+1 }, string);
        case {'5' '6' '7' '8'}
            for i = 1:str2double(arabic_str(index))-5
                string = sprintf('%s%s', roman_num{ j }, string);
            end
            string = sprintf('%s%s', roman_num{ j+1 }, string);
       case '9'
            string = sprintf('%s%s%s',roman_num{ j }, roman_num{ j+2 }, string);
    end
end
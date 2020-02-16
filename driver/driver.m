files = dir('matlab-example-functions/');
global MCR;
MCR = "/usr/local/MATLAB/MATLAB_Runtime/v97";
global any2str;
any2str = @(x) evalc('disp(x)');
    
MAX_MUT = 3;
addpath(genpath("target"));

for file = files'
    if (file.name == "..") || (file.name == ".")
        continue
    end
    
    seed = randi(9999999);
    for num = 1:MAX_MUT
        [out_mcc_dir, compiled_res_file, in_f, o_fname, o_f] = gen(file, seed, num)

        for input = [randi(3), rand(), -randi(3), 0]
            f = str2func(o_fname);
            try
                [r1, r2] = exec(input, f, out_mcc_dir, o_fname, compiled_res_file);
                report(r1, r2, in_f, seed, num, input, o_fname);
            catch e 
                e
            end
        end
   
        delete(o_f);
        [status, result] = system("rm -rf " + out_mcc_dir);
    end
end

function report(r1, r2, in_f, seed, num, input, o_fname)
    try
        same = all(r1 == r2)
    catch e
        same = 0
    end
    
    if ~same && r2 ~= "[]"
        fid=fopen("bugs/" + o_fname + ".json",'w');
        fprintf(fid, "{""seed"": %d, ""in_f"": ""%s"", ""num_flipped"": %d, ""fn_in"": %d}", seed, in_f, num, input);
        
        fid=fopen("bugs/" + o_fname + "_diff.txt",'w');
        fprintf(fid, "%s \n\n\n\n\n %s", r1, r2);
    end
end

function [r1, r2] = exec(input, f, out_mcc_dir, o_fname, compiled_res_file)
    any2str = @(x) evalc('disp(x)');
    MCR = "/usr/local/MATLAB/MATLAB_Runtime/v97";
    
    r1 = f(input);
    r1 = strtrim(any2str(r1));
    
    cmd_str = out_mcc_dir + "/run_" +o_fname + ".sh " + MCR + " " + input + " > " + compiled_res_file;
    [status, result] = system(cmd_str);
    
    cmd_str = "tail -n +7 < " + compiled_res_file;
    [status, result] = system(cmd_str);
    
    r2 = strtrim(result);
end

function [out_mcc_dir, compiled_res_file, in_f, o_fname, o_f] = gen(file, seed, num)
    in_f = strcat(file.folder, "/", file.name);
    o_fname_ext = strcat("n" + num + "s", num2str(seed), file.name);
    split_fname = split(o_fname_ext, '.');
    o_fname = split_fname{1};
    o_f = strcat("target", "/", o_fname_ext);

    cmd_str = "./matlab-mutator " + in_f + " -s " + seed + " -n " + num + " -o " + o_f;
    [status, result] = system(cmd_str);

    out_mcc_dir = "target/" + o_fname;
    compiled_res_file = out_mcc_dir + "/out.txt";
    mkdir(out_mcc_dir)
    cmd_str = "mcc -m " + o_f + " -d " + out_mcc_dir;
    [status, result] = system(cmd_str);
end


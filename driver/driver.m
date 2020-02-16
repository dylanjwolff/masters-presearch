files = dir('matlab-example-functions/');
MCR = "/usr/local/MATLAB/MATLAB_Runtime/v97";
any2str = @(x) evalc('disp(x)');
MAX_MUT = 10;
addpath(genpath("target"));

for file = files'
    if (file.name == "..") || (file.name == ".")
        continue
    end
    
    seed = randi(9999999);
    num = 2;
    in_f = strcat(file.folder, "/", file.name);
    o_fname_ext = strcat("f", num2str(seed), file.name);
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

    
    %exec
    input = 3;
    f = str2func(o_fname);
    r1 = f(input);
    r1 = strtrim(any2str(r1));
    
    cmd_str = out_mcc_dir + "/run_" +o_fname + ".sh " + MCR + " " + input + " > " + compiled_res_file;
    [status, result] = system(cmd_str);
    
    cmd_str = "tail -n +7 < " + compiled_res_file
    [status, result] = system(cmd_str);
    
    r2 = strtrim(result);
    
    try
        same = all(r1 == r2)
    catch e
        same = 0
    end
    
    if ~same
        fid=fopen("bugs/" + o_fname + ".txt",'w');
        fprintf(fid, "{""seed"": %d, ""in_f"": ""%s"", ""num_flipped"": %d, ""fn_in"": %d}", seed, in_f, num, input);
    end
    
    delete(o_f);
    [status, result] = system("rm -rf " + out_mcc_dir);
end

function [out_mcc_dir, compiled_res_file, in_f, o_fname] = gen(file, seed, num)
    in_f = strcat(file.folder, "/", file.name);
    o_fname_ext = strcat("f", num2str(seed), file.name);
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


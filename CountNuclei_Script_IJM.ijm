//Date: 
// Name:  
//Description: Batch Script to Count Nuclei

//Step 1: Specify Input Directory
input_directory= getDirectory("Choose Input Directory");
print("Input Directory:"+input_directory);
//Step -1: Get a list of files in the input directory
image_list = getFileList(input_directory);
print(image_list.length+ "images found.");

//Step 2: Loop over files in the input directory 
for (image_index = 0; image_index < image_list.length; image_index++) {
	print(image_list[image_index]);
	full_file_path= input_directory + image_list[image_index];
	print(full_file_path);
//Step3: Open image 
	run("Bio-Formats Importer", "open=["+full_file_path + "]");

//Step 4: Split Channel 
	run("Split Channels");
//Step 5: Select First Channel 
	selectImage(1);
//Step 6: Smoothing/Filtering
	run("Gaussian Blur...", "sigma=2");
//Step 7: Threshold the Image 
	setAutoThreshold("Huang dark no-reset");
	setOption("BlackBackground", true);
	run("Convert to Mask");
//Step 8: Count Number of Particles 
	run("Analyze Particles...", "summarize");
	close("*");
	}




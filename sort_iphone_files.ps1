# *************** #
# TODO            #
# - add timer     #
# - add counter   #
# - add usage()   #
# *************** #

param(
   [string]$dir
)

$destination = "$home\pictures\iphone"

function traverse_dir {
   param(
      [string]$dir
   )

   $files = @(get-childitem -path $dir)
   foreach($file in $files){
      $path = $dir + '\' + $file.name
      if(test-path -path $path -pathtype container){
	 traverse_dir($path)
      }else{
         $ext = (get-item -path $path).extension.substring(1).toupper()
	 move-item -path $path -destination $destination-$ext
	 #write $path
      }
   }
}

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

$ext_list = @("HEIC", "PNG", "JPG", "MOV", "AAE")

foreach($ext in $ext_list){
   mkdir $destination-$ext 2>$null
}

traverse_dir($dir)
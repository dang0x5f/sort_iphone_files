# *************** #
# TODO            #
# - add timer     #
# - add counter   #
# - add usage()   #
# - user input:   #
#   cli , gui     #
# *************** #

param(
   [string]$dir
)

$ext_list = @{}
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
	 if($ext_list["$ext"] -eq $null){
            mkdir $destination-$ext 2>$null
	    $ext_list["$ext"] = 1
	 }
         move-item -path $path -destination $destination-$ext
      }
   }
}

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

traverse_dir($dir)
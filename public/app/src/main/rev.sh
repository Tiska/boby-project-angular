# $1 : chemin vers fichier à révisionner
function revision()
{
	#echo "dasn tes reves"
	file=$1
	md5=`md5sum.exe $file | cut -d' ' -f1 `
	md5=${md5: -12}
	fileStart=`echo $file | sed 's/\.[^\.]*$//'`
	fileExtension=`echo $file | sed 's/.*\.//'`
	newFile="${fileStart}.${md5}.rev.${fileExtension}"
	echo $newFile
}

# $1 : chemin vers fichier dans lequel le remplacement sera effectué
# $2 : fichier original
# $3 : nouveau fichier
function replace()
{
	echo "replace $1 $2 $3"
	sed -i "s|${2}|${3}|g" $1
}


# Révision js
grep '<script' index.html | grep src | sed 's/[^"]*"//' | sed 's/".*//' | while read file
do
	if [ -f $file ]
	then
		newFile=$(revision $file)	
		replace index.html $file $newFile
	fi
done

# Révision css
grep '<link' index.html | grep src | sed 's/[^"]*"//' | sed 's/".*//' | while read file
do
	if [ -f $file ]
	then
		newFile=$(revision $file)	
		replace index.html $file $newFile
	fi
done


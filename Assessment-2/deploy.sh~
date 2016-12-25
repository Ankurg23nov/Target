name=$1 
output=$2
if [[ $name == *.pdf ]]
then
python readfile.py $name
python pytesseract.py jpg0.jpg > $output
rm jpg0.jpg
else
python pytesseract.py $name > $output
fi


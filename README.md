=> Guide Installation Cocoapods
- exécuter cette commande dans votre terminal : 
 sudo gem install cocoapods
 en lire plus

= > Installer CocoaPods = > (lien)
$ sudo gem install cocoapods
Créer un fichier Podfile : 
	1.	 Ouvrir le terminal
	2.	 Naviguer dans "Finder". Pour le Desktop : cd Desktop
	3.	dans terminal, taper commande : pod init, pour creer un nouveau podfile
	4.	ouvrir le fichier podfile dans un code editeur (Sublime Text)
	5.	Ajouter code suivant:
platform :ios, "9.0"
use_frameworks!
target 'Instagram' do
  pod 'Firebase'
end
 
6. sauvegarder fichier
7. dans terminal, taper commande : pod install, pour installer les 

**Guide Installation **[**Cocoapods**](https://guides.cocoapods.org/using/getting-started.html)

$ sudo gem install cocoapods

Créer un fichier **Podfile : **

1.  Ouvrir le terminal
2.  Naviguer dans "Finder". Pour le Desktop : cd Desktop
3. dans terminal, taper commande : **_pod init_**, pour creer un nouveau podfile
4. ouvrir le fichier **_podfile_** dans un code editeur (Sublime Text)
5. Ajouter code suivant:


platform :ios, "9.0"

use_frameworks!

target 'Instagram' do

  pod 'Firebase'
  

end


6. sauvegarder fichier

7. dans terminal, taper commande : **_pod install_**, pour installer les dépendances.

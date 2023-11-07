Auteur : Abdel-had HANAMI

Contexte : Bootcamp DevOps - promotion 12

Centre de formation : eazytraining.fr

Date de publication : le 7 Novembre 2023

LinkedIn : https://www.linkedin.com/in/abdel-had-hanami/

---
# Infrastructure as Code avec Terraform

<img width="1200" alt="Terraform" src="https://github.com/Abdel-had/mini-projet-terraform/assets/101605739/890fb4c0-f3ad-4d91-b169-486369a47e5a">

Ce projet utilise Terraform pour déployer une application web sur AWS, en provisionnant une instance EC2 avec Ubuntu Bionic, un volume EBS, une adresse IP publique et un groupe de sécurité.

## Structure du Projet

Le projet est divisé en modules réutilisables pour faciliter la gestion et la maintenance de l'infrastructure :

- `modules/ebs_volume`: Définit un volume EBS.
- `modules/ec2_instance`: Configure une instance EC2 avec Ubuntu Bionic, installe nginx et utilise une clé SSH pour l'accès.
- `modules/public_ip`: Assigne une adresse IP publique à l'instance EC2 et enregistre cette adresse dans `ip_ec2.txt`.
- `modules/security_group`: Crée un groupe de sécurité qui autorise le trafic HTTP, HTTPS et SSH.
- `app`: Dossier contenant la configuration de l'application qui utilise les modules pour déployer l'instance EC2.

## Prérequis

- Terraform v0.12+ installé sur votre machine locale.
- AWS CLI configuré avec les identifiants appropriés.
- Un bucket S3 pour le backend de Terraform (déjà créé puis configuré dans `app/main.tf`).
- Une clé SSH nommée `devops-abdelhad` doit être disponible et configurée dans AWS.

## Démarrage Rapide

1. Clonez ce dépôt sur votre machine locale.

    ```
    git clone https://github.com/Abdel-had/mini-projet-terraform.git
    ```

2. Assurez-vous que vos identifiants AWS sont configurés correctement.

    Sur Windows :

    ```ps1
    $env:AWS_ACCESS_KEY_ID = "PUT_YOUR_OWN"
    $env:AWS_SECRET_ACCESS_KEY = "PUT_YOUR_OWN"
    ```

    Sur Linux :

    ```sh
    export AWS_ACCESS_KEY_ID="PUT_YOUR_OWN"
    export AWS_SECRET_ACCESS_KEY="PUT_YOUR_OWN"
    ```


3. Naviguez dans le dossier du projet (**app**) et initialisez Terraform avec la commande :

   ```sh
   terraform init
   ```

4. Appliquez la configuration Terraform :

   ```sh
   terraform apply
   ```

5. Confirmez les actions proposées par Terraform lorsque vous y êtes invité.

## Configuration

Les variables par défaut sont définies dans les fichiers `variables.tf` de chaque module. Pour personnaliser ces variables, je les ai surchargé dans `app/main.tf` à l'appel des modules. Vous pouvez créez un fichier `terraform.tfvars` dans le dossier `app` ou passez des variables directement via la ligne de commande.

Exemple de contenu pour `app/terraform.tfvars` :

```hcl
instancetype = "t2.micro"
ebs_size = 10
sg_name = "app-sg"
```

## Outputs

Après l'exécution, Terraform affichera les ID des ressources créées, y compris l'ID de l'instance EC2 et le nom du groupe de sécurité. Vous trouverez également l'adresse IP publique de l'instance dans le fichier `app/ip_ec2.txt`.

## Nettoyage

Pour détruire l'infrastructure créée par Terraform (et éviter des frais supplémentaires), exécutez :

```sh
terraform destroy
```

## Sécurité

- Ne versionnez jamais vos clés privées ou vos fichiers d'état Terraform.
- Utilisez des politiques IAM restrictives pour contrôler l'accès aux ressources AWS.

## Support

Si vous rencontrez des problèmes ou avez des questions, veuillez ouvrir une issue dans le dépôt du projet.

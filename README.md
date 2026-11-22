# Book Bloom v2 — cloud-ready 🌷

## Démarrage local
Ouvrir `index.html` dans un navigateur. Sans configuration Supabase, l'application fonctionne en mode local via `localStorage`.

## Activer comptes + synchronisation cloud
1. Créer un projet sur https://supabase.com/.
2. Dans SQL Editor, exécuter le contenu de `supabase-schema.sql`.
3. Dans Project Settings → API, copier Project URL et la clé `anon` / publishable.
4. Coller ces deux valeurs dans `supabase-config.js` (URL et clé publique uniquement).
5. Dans Authentication → URL Configuration, ajouter l'URL du site à Site URL et Redirect URLs. Pour tester localement, servir le dossier avec un serveur local (ex. `python -m http.server 8000`) et autoriser `http://localhost:8000/**`.
6. Héberger le dossier sur HTTPS (Netlify, Vercel ou GitHub Pages), puis ajouter le domaine de production aux Redirect URLs.
7. Ouvrir l'application, cliquer « Mon compte », créer un compte ou se connecter.

L'authentification email/mot de passe, la récupération de mot de passe, la sauvegarde cloud par compte et l'écoute des mises à jour sont intégrées au front-end.

## Sécurité
- La clé `anon`/publishable peut être présente dans le navigateur. Ne jamais mettre la clé `service_role` dans `supabase-config.js`.
- La table active RLS et limite chaque ligne à `auth.uid() = user_id`.
- Le contenu de bibliothèque est stocké dans un champ JSONB par utilisateur.
- Pour un usage à long terme, configurez la confirmation e-mail et des sauvegardes Supabase régulières.

## Limites à connaître
- Cette livraison fournit une intégration Supabase prête à configurer, mais ne crée pas le projet Supabase à ta place : il faut renseigner l'URL et la clé de ton projet.
- La synchronisation temps réel nécessite que la table soit activée dans Database → Replication. Les sauvegardes restent accessibles via export JSON.
- La synchronisation utilise un document JSON par compte : pratique pour une bibliothèque personnelle, mais les modifications simultanées sur deux appareils peuvent se remplacer. Pour un usage multi-appareil intensif, faire évoluer vers une table `books` avec une ligne par livre et une stratégie de conflits.
- Les couvertures ajoutées par URL doivent être accessibles publiquement. Le stockage privé des fichiers pourra être ajouté avec Supabase Storage.
- Recherche Google Books/Open Library, listes personnalisées indépendantes, édition de profil et suppression de compte ne sont pas encore incluses dans cette itération.

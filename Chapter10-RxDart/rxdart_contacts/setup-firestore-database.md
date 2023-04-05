![image-20230405210820905](.setup-firestore-database.assets/image-20230405210820905.png)



![image-20230405211111713](.setup-firestore-database.assets/image-20230405211111713.png)



![image-20230405212022921](.setup-firestore-database.assets/image-20230405212022921.png)



Edit rules:

![image-20230405213244705](.setup-firestore-database.assets/image-20230405213244705.png)

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{collection}/{document=**} {
    	function isCollectionOwner(collectionId) {
      	return request.auth != null && request.auth.uid == collectionId;
      }
      // the update rule includes delete rule, so the delete rule in no-need here
      allow create, read, update, write, delete: if isCollectionOwner(collection);
    }
  }
}
```



After publishing above rules, you can create ducuments in Firestore:

![image-20230405215558502](.setup-firestore-database.assets/image-20230405215558502.png)

![image-20230405220041255](.setup-firestore-database.assets/image-20230405220041255.png)

![image-20230405220210266](.setup-firestore-database.assets/image-20230405220210266.png)

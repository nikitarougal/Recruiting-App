public without sharing class FileUploader {
    // Creates a content version from a given file's base64 and name
   @AuraEnabled
  public static String uploadFile(String base64, String filename, String candidateId) {
        ContentVersion cv = createContentVersion(base64, filename);
        ContentDocumentLink cdl = createContentLink(cv.Id, candidateId);
        if (cv == null || cdl == null) { return null; }
        return cdl.Id;
  }
  // Creates a content version from a given file's base64 and name
  private static ContentVersion createContentVersion(String base64, String filename) {
    ContentVersion cv = new ContentVersion();
    cv.VersionData = EncodingUtil.base64Decode(base64);
    cv.Title = filename;
    cv.PathOnClient = filename;

    try {
      insert cv;
      return cv;
    } catch(DMLException e) {
      System.debug(e);
      return null;
    }
  }

   // Creates a content link for a given ContentVersion and record
  private static ContentDocumentLink createContentLink(String contentVersionId, String candidateId) {
    if (contentVersionId == null || candidateId == null) { return null; }

    List<ContentVersion> contentVersions = [
        SELECT ContentDocumentId 
        FROM ContentVersion 
        WHERE Id = :contentVersionId
    ];

    if (contentVersions.isEmpty()) {
        // Handle the case where no ContentVersion record was found
        return null;
    }

    ContentDocumentLink cdl = new ContentDocumentLink();
    cdl.ContentDocumentId = contentVersions[0].ContentDocumentId;
    cdl.LinkedEntityId = candidateId;
    // ShareType is either 'V', 'C', or 'I'
    // V = Viewer, C = Collaborator, I = Inferred
    cdl.ShareType = 'V';
    
    try {
        insert cdl;
        return cdl;
    } catch (DMLException e) {
        System.debug(e);
        return null;
    }
}
}
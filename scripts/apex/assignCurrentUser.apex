PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'PermName'];
List<PermissionSetAssignment> psas = new List<PermissionSetAssignment>();

for (Id uid : new List<Id>{ UserInfo.getUserId() }) {
  psas.add(
    new PermissionSetAssignment(AssigneeId = uid, PermissionSetId = ps.Id)
  );
}
insert psas;

.import "dataBaseCenter.js" as DBC
const tableName = "logs2"; //NOTE: this name is used inside saveLoadLogMessages.js as refrence

function set(groupName,groupPriority,groupTags)
{
   var db = DBC.getDatabase();
   var res = "";

   db.transaction
   (
       function(tx)
       {
                  tx.executeSql('CREATE TABLE IF NOT EXISTS '+tableName+' (l_id INTEGER PRIMARY KEY AUTOINCREMENT,l_name  TEXT, l_prioirty INT, l_tags TEXT)');
                  var rs = tx.executeSql('INSERT OR REPLACE INTO '+tableName+' (l_name,l_prioirty,l_tags) VALUES (?,?,?);',
                                                                                                [groupName,
                                                                                                groupPriority,
                                                                                                groupTags]);

                  if (rs.rowsAffected > 0)
                  {
                    res = "OK";
                  }

                  else
                  {
                    res = "Error (saveLoadLogs.set)";
                  }
      }
   );
  return res;
}

function get()
{
   var db = DBC.getDatabase();
   var res="";
    let result2 = '{ "logs" : [';


   try
   {
     db.transaction
     (
       function(tx)
       {

         var rs = tx.executeSql('SELECT * FROM '+tableName+' ORDER BY l_prioirty ASC;');
         var tableColumns = rs.rows.length;
         if (rs.rows.length > 0)
         {
                 for(var x=0; x<tableColumns; x++)
                 {
                     result2 +=
                             '{ "id":"'+ rs.rows.item(x).l_id +
                             '", "name":"'+ rs.rows.item(x).l_name +
                             '", "priority":"'+ rs.rows.item(x).l_prioirty +
                             '", "tags":"'+ rs.rows.item(x).l_tags + '" }';
                     if(x<tableColumns-1)
                     {
                         result2 += ",";
                     }

                 }
             result2 += "]}";


         }

         else
         {
             res = "";
         }


       }
     )
   }

   catch (err)
   {
       console.log("Database (saveLoadLogs.get): " + err);
//       res = default_value;
   };
//  return res;
   return result2;
}


function removeElement(targetId)
{
   var db = DBC.getDatabase();
   var res = "";

   db.transaction
   (
       function(tx)
       {
                  var rs = tx.executeSql('DELETE FROM '+tableName+' WHERE l_id=?;',[targetId]);

                  if (rs.rowsAffected > 0)
                  {
                    res = "OK";
                  }

                  else
                  {
                    res = "Error (saveLoadLogs.removeElement)";
                  }
      }
   );
  return res;
}

function updateElement(targetId,newname,newtag,newpriority)
{
   var db = DBC.getDatabase();
   var res = "";
    newpriority = parseInt(newpriority,10);

   db.transaction
   (
       function(tx)
       {
                  var rs = tx.executeSql('UPDATE '+tableName+' SET l_name = ? , l_tags = ?, l_prioirty = ? WHERE l_id=?;',[newname,newtag,newpriority,targetId]);

                  if (rs.rowsAffected > 0)
                  {
                    res = "OK";
                  }

                  else
                  {
                    res = "Error (saveLoadLogs.updateElement)";
                  }
      }
   );
  return res;
}

//function update(logId,fieldName,value)
//{
//   var db = DBC.getDatabase();
//   var res = "";
//   db.transaction
//   (
//       function(tx)
//       {
//                  var rs = tx.executeSql('UPDATE '+tableName+' SET '+ fieldName +' = '+ value +' WHERE l_id =?;',[logId]);
//                  if (rs.rowsAffected > 0)
//                  {
//                    res = "OK";
//                  }

//                  else
//                  {
//                    res = "Error (from saveLoadLogs.update)";
//                  }
//      }
//   );
//  return res;
//}



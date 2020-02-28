Nicolas Panov                    HW2

[npanov@sol41 ~]$ script
Script started, file is typescript
[npanov@sol41 ~]$ mkdir webapp
[npanov@sol41 ~]$ cd webapp
[npanov@sol41 webapp]$ mkdir hwtwo
[npanov@sol41 webapp]$ cd hwtwo
[npanov@sol41 hwtwo]$ vim test.txt
[npanov@sol41 hwtwo]$ cd
[npanov@sol41 ~]$ mkdir subversion
[npanov@sol41 ~]$ cd subversion
[npanov@sol41 subversion]$ svnadmin create repos
[npanov@sol41 subversion]$ cd
[npanov@sol41 ~]$ pwd
/users1/st/npanov
[npanov@sol41 ~]$ svn import webapp/hwtwo file:///users1/st/npanov/subversion/repos -m "initial report"
Adding         webapp/hwtwo/test.txt

Committed revision 1.
[npanov@sol41 ~]$ svn checkout file:///users1/st/npanov/subversion/repos hwtwo
A    hwtwo/test.txt
Checked out revision 1.
[npanov@sol41 ~]$ cd hwtwo
[npanov@sol41 hwtwo]$ vim test.txt
[npanov@sol41 hwtwo]$ svn diff
Index: test.txt
===================================================================
--- test.txt   (revision 1)
+++ test.txt   (working copy)
@@ -1 +1,2 @@
 Original Text
+Added Text
[npanov@sol41 hwtwo]$ svn commit
Sending        test.txt
Transmitting file data .
Committed revision 2.
[npanov@sol41 hwtwo]$ svn update
Updating '.':
At revision 2.
[npanov@sol41 hwtwo]$ cd
[npanov@sol41 ~]$ exit
exit
Script done, file is typescript


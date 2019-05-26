---
Title: What is the Guid in .NET?
Published: 5/26/2019
Tags: [.NET, ]
author: Johan Vergeer
---

After having done some online reseach I found that a Guid in .NET is probably a UUID version 4. Let's put that to the test.

I found several online resources that say something about .NET's `System.Guid`. Some of them are spot on, but not complete, but most of them say is't Microsofts implementation of a [UUID](https://web.archive.org/web/20060615195933/http://www.webdav.org/specs/draft-leach-uuids-guids-01.txt). These explanations are also right, but not complete. So here is my take on `System.Guid`. First to get the obvious out of the way. _GUID_ is an acronym for _Globally Unique Identifier_ and _UUID_ for _Universally Unique Identifier_. Nice to know but not very helpful. As you already know it is used by Microsoft in the .NET ecosystem. A lot of people seem to think it is exclusively used by Microsoft, but that's not true. It is also used by Oracle which has [`SYS_GUID`](https://docs.oracle.com/cd/B12037_01/server.101/b10759/functions153.htm) and C++ has a [`CoCreateGuide()`](https://docs.microsoft.com/en-us/windows/desktop/api/combaseapi/nf-combaseapi-cocreateguid) function. I'm sure there are more implementation that use Guid, but I haven't looked for them since that's not the point of this post.

I found a post on MSDN[^1] with a discussion whether `System.Guid` produces a UUID version 4, but even that thread couldn't rule everything out. So I wrote a simple script to put it to the test. The proposed standard on IETF[^2] states _the UUID version is in the most significant 4 bits of the time stamp (bits 4 through 7 of the time_hi_and_version field)_. This means it should be the fifteenth character in the UUID. So let's print out a couple of Guids to the console and have a look:

<?# Gist 7206ed44b09a8cc0c2a49f32ee8c3b40 File="a-list-of-guids-version-4" /?>

This looks like `System.Guid` is indeed a version 4 UUID. But then again, printing out 10 items doesn't really rule out that other values might occur, so lets print a couple more. I created a console application with the following script, which will generate 10 million Guids and verify whether each Guid is indeed a UUID version 4. Each time a Guid is found that isn't version 4 the `Errors found` value will increase.

<?# Gist 7206ed44b09a8cc0c2a49f32ee8c3b40 File="Program.cs" /?>

This shows the output below. I ran this test a couple of times and the results are the same every time I ran it. The conclusion I can draw from is this that it is __very__ likely that `System.Guid` is a UUID version 4. 

<?# Gist 7206ed44b09a8cc0c2a49f32ee8c3b40 File="test-results-10-million-guids" /?>

If you have any other insights on this topic, please let me know in the comments.

#### Sources

[^1]: [Thread on MSDN on System.Guid](https://social.msdn.microsoft.com/Forums/en-US/4956142a-0a5d-4f1e-b102-93a3eea1b5d5/does-guidnewguid-produce-uuid-version-4-according-to-rfc4122?forum=netfxbcl)
[^2]: [IETF proposed UUID Standard](https://tools.ietf.org/html/rfc4122#section-4.1.3)
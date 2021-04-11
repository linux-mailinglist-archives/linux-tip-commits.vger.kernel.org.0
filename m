Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A8B35B524
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhDKNp0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhDKNog (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:36 -0400
Date:   Sun, 11 Apr 2021 13:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8E4uceFvKnN/xT770WBe5YeMJjIlqXi1PvCmR8xPVZA=;
        b=F8nhZ+GjUrCBfWZkqkAVZGBmmsHG4C37pv5IbvaZajLTDwR9+lkrFhBjxVotuSkN6hjLOJ
        ArveMMXwvVUax9YiNQjiLDS88vOzrcd6+MesiK+0//H3S5iDByIlD8Ztrq7nEfJjk3IdnX
        uJet+Z6C/mqV920h0gY5Mv1B0RrnEiO0xQtOgLaOqJjLIAUZgMczGkoIl5wPbgd85CNaep
        SlHjJqi/CZ1e2PkdC1EqiI1kImU6xL+zxRTz2Xnh4i6v3OvAE9GT6/r+pW4574zpBhOdHj
        ig+o0sJ32MlqjCQpI4gYpr3KmPZ+4fi5N4XWeOyg46np9L7DvkNH0u8QfpGUlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8E4uceFvKnN/xT770WBe5YeMJjIlqXi1PvCmR8xPVZA=;
        b=kHt0ACLZW5cN6u97JhCulcUELHh7gmphICKsbru9lQwc/fTW3TnAGzd9nSQ/m/3lS/sSDC
        93f+r+6qQeuXX6Cw==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib: bitmap: support "N" as an alias for size of bitmap
Cc:     Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862468.29796.14743980110706161032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2c4885d24e64941702a8f81c8e83289823ba35d0
Gitweb:        https://git.kernel.org/tip/2c4885d24e64941702a8f81c8e83289823ba35d0
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 21 Feb 2021 03:08:25 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

lib: bitmap: support "N" as an alias for size of bitmap

While this is done for all bitmaps, the original use case in mind was
for CPU masks and cpulist_parse() as described below.

It seems that a common configuration is to use the 1st couple cores for
housekeeping tasks.  This tends to leave the remaining ones to form a
pool of similarly configured cores to take on the real workload of
interest to the user.

So on machine A - with 32 cores, it could be 0-3 for "system" and then
4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
setting up the worker pool of CPUs.

But then newer machine B is added, and it has 48 cores, and so while
the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.

Multiple deployment becomes easier when we can just simply replace 31
and 47 with "N" and let the system substitute in the actual number at
boot; a number that it knows better than we do.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com> # move it from CPU code
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.rst |  7 +++++-
 lib/bitmap.c                                    | 22 ++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 1132796..d6e3f67 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,6 +68,13 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The value "N" can be used to represent the numerically last CPU on the system,
+i.e "foo_cpus=16-N" would be equivalent to "16-31" on a 32 core system.
+
+Keep in mind that "N" is dynamic, so if system changes cause the bitmap width
+to change, such as less cores in the CPU list, then N and any ranges using N
+will also change.  Use the same on a small 4 core system, and "16-N" becomes
+"16-3" and now the same boot input will be flagged as invalid (start > end).
 
 
 This document may not be entirely up to date and comprehensive. The command
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 833f152..9f4626a 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -519,11 +519,17 @@ static int bitmap_check_region(const struct region *r)
 	return 0;
 }
 
-static const char *bitmap_getnum(const char *str, unsigned int *num)
+static const char *bitmap_getnum(const char *str, unsigned int *num,
+				 unsigned int lastbit)
 {
 	unsigned long long n;
 	unsigned int len;
 
+	if (str[0] == 'N') {
+		*num = lastbit;
+		return str + 1;
+	}
+
 	len = _parse_integer(str, 10, &n);
 	if (!len)
 		return ERR_PTR(-EINVAL);
@@ -571,7 +577,9 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
 
 static const char *bitmap_parse_region(const char *str, struct region *r)
 {
-	str = bitmap_getnum(str, &r->start);
+	unsigned int lastbit = r->nbits - 1;
+
+	str = bitmap_getnum(str, &r->start, lastbit);
 	if (IS_ERR(str))
 		return str;
 
@@ -581,7 +589,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != '-')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->end);
+	str = bitmap_getnum(str + 1, &r->end, lastbit);
 	if (IS_ERR(str))
 		return str;
 
@@ -591,14 +599,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != ':')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->off);
+	str = bitmap_getnum(str + 1, &r->off, lastbit);
 	if (IS_ERR(str))
 		return str;
 
 	if (*str != '/')
 		return ERR_PTR(-EINVAL);
 
-	return bitmap_getnum(str + 1, &r->group_len);
+	return bitmap_getnum(str + 1, &r->group_len, lastbit);
 
 no_end:
 	r->end = r->start;
@@ -625,6 +633,10 @@ no_pattern:
  * From each group will be used only defined amount of bits.
  * Syntax: range:used_size/group_size
  * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
+ * The value 'N' can be used as a dynamically substituted token for the
+ * maximum allowed value; i.e (nmaskbits - 1).  Keep in mind that it is
+ * dynamic, so if system changes cause the bitmap width to change, such
+ * as more cores in a CPU list, then any ranges using N will also change.
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *

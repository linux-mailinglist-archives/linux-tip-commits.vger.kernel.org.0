Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB235B527
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhDKNp2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbhDKNoh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:37 -0400
Date:   Sun, 11 Apr 2021 13:43:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RuSINVFcQ6jztcMyRgBU0XK6CE9+cMwoqeqNLZA30RY=;
        b=CAXrI2mEw/c/aRtF0BDP7rarkYrpWYxasGwTDuCdHcnf0cR+z68CotEQA2fHDbYY3uQDte
        On0DTk8BXcfMFGvbpMJ4YoaADbO8GyUPCxwfvJidpj23V7aNJlbfXNq4cMy+39YMXqkaf0
        5dh/Lhr8IdftoNZWsRMGHB354DTxjv3iFat5dCCV1Y/uLD7zQKdw0BUHyVIBUXMbVLkweQ
        ws4pSMRD3NmGUVMT1VTpvcpUHZyDtDNf5n4lhraPi6SrulzW5dXQ3f7W9Uh58ZFfk8iZia
        maYQ69JEbulYT78sqNibcq/OoJx4f9qT3mAxACZuEwnGzbG4SKrt/srjSl7s5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RuSINVFcQ6jztcMyRgBU0XK6CE9+cMwoqeqNLZA30RY=;
        b=hb3hN3+QfijG8NSVZUIKsbL+K3f29DWdR8B73kDV6YB1e4RF5Dnq525y0lmFIvfn1e+klS
        HkfifbelPrT8NFAA==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib: bitmap: fold nbits into region struct
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862545.29796.7185603723669044280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9d7a3366b7028ae8dd16a0d7585cbf11b03b42a0
Gitweb:        https://git.kernel.org/tip/9d7a3366b7028ae8dd16a0d7585cbf11b03b42a0
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 21 Feb 2021 03:08:23 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

lib: bitmap: fold nbits into region struct

This will reduce parameter passing and enable using nbits as part
of future dynamic region parameter parsing.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/bitmap.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4..162e285 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -487,24 +487,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
 
 /*
  * Region 9-38:4/10 describes the following bitmap structure:
- * 0	   9  12    18			38
- * .........****......****......****......
- *	    ^  ^     ^			 ^
- *      start  off   group_len	       end
+ * 0	   9  12    18			38	     N
+ * .........****......****......****..................
+ *	    ^  ^     ^			 ^	     ^
+ *      start  off   group_len	       end	 nbits
  */
 struct region {
 	unsigned int start;
 	unsigned int off;
 	unsigned int group_len;
 	unsigned int end;
+	unsigned int nbits;
 };
 
-static int bitmap_set_region(const struct region *r,
-				unsigned long *bitmap, int nbits)
+static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= nbits)
+	if (r->end >= r->nbits)
 		return -ERANGE;
 
 	for (start = r->start; start <= r->end; start += r->group_len)
@@ -640,7 +640,8 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 	struct region r;
 	long ret;
 
-	bitmap_zero(maskp, nmaskbits);
+	r.nbits = nmaskbits;
+	bitmap_zero(maskp, r.nbits);
 
 	while (buf) {
 		buf = bitmap_find_region(buf);
@@ -655,7 +656,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp, nmaskbits);
+		ret = bitmap_set_region(&r, maskp);
 		if (ret)
 			return ret;
 	}

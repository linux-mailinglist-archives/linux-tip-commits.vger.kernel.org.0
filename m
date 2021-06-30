Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35F23B8427
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbhF3NxA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33002 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhF3NvW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:22 -0400
Date:   Wed, 30 Jun 2021 13:48:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0uc/PPgOA3whdRN+v7RK+e5rNR2sx4zQnXR9MK1wtFA=;
        b=OPAX7cZ9i9TuAWCllDMhKlaNL/PriN9WIFu0MQqjNFJBvu0r8LvyUvKHZGn5Z/X5SiDrku
        BWkHRpKEoiiSNo3CDv5EvZU4R0ztjnLQNsQeYZnDUmMg4Z/cRtK0zsJg7RKbX8Tk/XyKxd
        CGWHnTlY8jAdeH//8QH9h90yA/ydaYhlzpBnCLJIz3ozLLiDMUrWAjOYhV4nxX9JCbz48f
        QvhTbiDLbyCPATAlZEzicD9TBYjY9TGDFwygMKR8dMFM4I8gxcQD/oboxJqIlOAvM3uVFl
        Ljt3v0nRg8GWVBJKBRWZmCiqrVR1JRH/p0a7walQysc7gy5FQzqd38/EQsKl0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0uc/PPgOA3whdRN+v7RK+e5rNR2sx4zQnXR9MK1wtFA=;
        b=8jPjP/Eszls1okaES6jhbdU3TyiBpelqiMwrE5Tq4w6kJCv7wW+BV4eToLzDJNq/VZOH4G
        M2bs0p8NfhjH8XAw==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] bitmap_parse: Support 'all' semantics
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506088324.395.4488352989288920101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b18def121f077857ccf92fc620366e19850bc297
Gitweb:        https://git.kernel.org/tip/b18def121f077857ccf92fc620366e19850bc297
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Tue, 20 Apr 2021 20:13:25 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 15:38:20 -07:00

bitmap_parse: Support 'all' semantics

RCU code supports an 'all' group as a special case when parsing rcu_nocbs
parameter. This patch moves the 'all' support to the core bitmap_parse
code, so that all bitmap users can enjoy this extension.

Moving 'all' parsing to a bitmap_parse level also allows users to pass
patterns together with 'all' in regular group:pattern format, for example,
"rcu_nocbs=all:1/2" would offload all the even-numbered CPUs regardless
of the number of CPUs on the system.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.rst |  5 +++++
 lib/bitmap.c                                    |  9 +++++++++
 lib/test_bitmap.c                               |  7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 3996b54..01ba293 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -76,6 +76,11 @@ to change, such as less cores in the CPU list, then N and any ranges using N
 will also change.  Use the same on a small 4 core system, and "16-N" becomes
 "16-3" and now the same boot input will be flagged as invalid (start > end).
 
+The special case-tolerant group name "all" has a meaning of selecting all CPUs,
+so that "nohz_full=all" is the equivalent of "nohz_full=0-N".
+
+The semantics of "N" and "all" is supported on a level of bitmaps and holds for
+all users of bitmap_parse().
 
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 74ceb02..6e29b2a 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -581,6 +581,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 {
 	unsigned int lastbit = r->nbits - 1;
 
+	if (!strncasecmp(str, "all", 3)) {
+		r->start = 0;
+		r->end = lastbit;
+		str += 3;
+
+		goto check_pattern;
+	}
+
 	str = bitmap_getnum(str, &r->start, lastbit);
 	if (IS_ERR(str))
 		return str;
@@ -595,6 +603,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (IS_ERR(str))
 		return str;
 
+check_pattern:
 	if (end_of_region(*str))
 		goto no_pattern;
 
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 9cd5755..4ea73f5 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -366,6 +366,13 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
 	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
 
+	{0,	  "all",		&exp1[8 * step], 32, 0},
+	{0,	  "0, 1, all,  ",	&exp1[8 * step], 32, 0},
+	{0,	  "all:1/2",		&exp1[4 * step], 32, 0},
+	{0,	  "ALL:1/2",		&exp1[4 * step], 32, 0},
+	{-EINVAL, "al", NULL, 8, 0},
+	{-EINVAL, "alll", NULL, 8, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},

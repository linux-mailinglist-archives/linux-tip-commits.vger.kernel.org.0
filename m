Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E232CD3D0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 11:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbgLCKgm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 05:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgLCKg2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B63C061A4F;
        Thu,  3 Dec 2020 02:35:48 -0800 (PST)
Date:   Thu, 03 Dec 2020 10:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606991745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ykou+zmM1/uA6mn6wpl+i1J3jxPVdWvO+a9hhP5WUhg=;
        b=o/g9boaBShYAeO7tBs8ESZc4EKcnxLzttr/gCiItFADNABGp5w3pKaNyMPCy3gZiAtco21
        7uZpMEG6R8VLZlfO3Gp37D3x3SoOLf5Wfgh+eqTqG5TE4NVoDlNsKvUgAdEDXiXqyg+3Sq
        zKmVyusC/k/vSsPmH9ZpNvlqGb3u+MMBHxBIGcqlwim8409rXcm3JA6sNlKw3M5FmITSch
        GbXnKG43zEAyQ0UubyTurf4I3LRcBQZVZOfuY2yoU7FTtVCNisCNrC34ZuqdCp2ogYN0Rn
        05jvS34gY9xVrfK0WaZORAuvae4yfnDnMT4Yf1HnsGjocEn2bzFa09FQkS41Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606991745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ykou+zmM1/uA6mn6wpl+i1J3jxPVdWvO+a9hhP5WUhg=;
        b=aDnvIdwl+bF2ed8nNfzB2x0rPQpU8vMjJ1bhOaYoKEqVb0YOb3/vVyf4UHchG41KmDcpnZ
        pCX7E9E12noIwkCg==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftest: Add spin_nest_lock test
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201102053743.450459-2-boqun.feng@gmail.com>
References: <20201102053743.450459-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <160699174456.3364.12078447208070407701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e04ce676e7aa490dcf5df880592e3db5e842a9bc
Gitweb:        https://git.kernel.org/tip/e04ce676e7aa490dcf5df880592e3db5e842a9bc
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Mon, 02 Nov 2020 13:37:42 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 11:20:50 +01:00

lockdep/selftest: Add spin_nest_lock test

Add a self test case to test the behavior for the following case:

	lock(A);
	lock_nest_lock(C1, A);
	lock(B);
	lock_nest_lock(C2, A);

This is a reproducer for a problem[1] reported by Chris Wilson, and is
helpful to prevent this.

[1]: https://lore.kernel.org/lkml/160390684819.31966.12048967113267928793@build.alporthouse.com/

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201102053743.450459-2-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index afa7d4b..4c24ac8 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2009,6 +2009,19 @@ static void ww_test_spin_nest_unlocked(void)
 	U(A);
 }
 
+/* This is not a deadlock, because we have X1 to serialize Y1 and Y2 */
+static void ww_test_spin_nest_lock(void)
+{
+	spin_lock(&lock_X1);
+	spin_lock_nest_lock(&lock_Y1, &lock_X1);
+	spin_lock(&lock_A);
+	spin_lock_nest_lock(&lock_Y2, &lock_X1);
+	spin_unlock(&lock_A);
+	spin_unlock(&lock_Y2);
+	spin_unlock(&lock_Y1);
+	spin_unlock(&lock_X1);
+}
+
 static void ww_test_unneeded_slow(void)
 {
 	WWAI(&t);
@@ -2226,6 +2239,10 @@ static void ww_tests(void)
 	dotest(ww_test_spin_nest_unlocked, FAILURE, LOCKTYPE_WW);
 	pr_cont("\n");
 
+	print_testname("spinlock nest test");
+	dotest(ww_test_spin_nest_lock, SUCCESS, LOCKTYPE_WW);
+	pr_cont("\n");
+
 	printk("  -----------------------------------------------------\n");
 	printk("                                 |block | try  |context|\n");
 	printk("  -----------------------------------------------------\n");

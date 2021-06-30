Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4499A3B83F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhF3Nvq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbhF3Nul (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:41 -0400
Date:   Wed, 30 Jun 2021 13:47:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Jwv2P8IEMTVSrhe+JQOxbRjf1Ez9c7g05x1zplH2aY8=;
        b=N0Qhr3Bhz60iLm1HaVp/ky5q8rBOg2iRSe8abWucZN+6Lg2LO7KfTUTiPvBM3GM+etIvYx
        nUayLLuLf3AIU6qTltU1j1yOtgqP0g9vlkqBwefd2XHuCfQ28XP0bIjBM2OZbreH72OOBH
        HBs1i0Wa0wdcNistvG6DE/axkxXqi+16kNmRUGkRTDunMVFgt6ufL7149/z6ZFsse8ohUR
        H1o+tRrde4Jh2mtnyjUH08N5yEilSkA9EUPjE17Zbd9f+joZboSh7xKRzfIf95uhtyAzzg
        lWVXXG+jaQpuxj18zLvW5BMVWC2+83g052EMtbrT+iSwbFMKjcGYh78pilEFag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Jwv2P8IEMTVSrhe+JQOxbRjf1Ez9c7g05x1zplH2aY8=;
        b=deECNK636zLLHlEMhl9pPqQukbgHWj6XcvpdJ33EfI6FKXj6fmDBWaeaneoUFUQXvvneZG
        KH/1iGeRUYVMROAA==
From:   "tip-bot2 for Maninder Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm/slub: Add Support for free path information of an object
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Vaneet Narang <v.narang@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087581.395.3966218022354994673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e548eaa116d858f07816d41e24835a41f7e7d270
Gitweb:        https://git.kernel.org/tip/e548eaa116d858f07816d41e24835a41f7e7d270
Author:        Maninder Singh <maninder1.s@samsung.com>
AuthorDate:    Tue, 16 Mar 2021 16:07:11 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:01:41 -07:00

mm/slub: Add Support for free path information of an object

This commit adds enables a stack dump for the last free of an object:

slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at meminfo_proc_show+0x40/0x4fc
[   20.192078]     meminfo_proc_show+0x40/0x4fc
[   20.192263]     seq_read_iter+0x18c/0x4c4
[   20.192430]     proc_reg_read_iter+0x84/0xac
[   20.192617]     generic_file_splice_read+0xe8/0x17c
[   20.192816]     splice_direct_to_actor+0xb8/0x290
[   20.193008]     do_splice_direct+0xa0/0xe0
[   20.193185]     do_sendfile+0x2d0/0x438
[   20.193345]     sys_sendfile64+0x12c/0x140
[   20.193523]     ret_fast_syscall+0x0/0x58
[   20.193695]     0xbeeacde4
[   20.193822]  Free path:
[   20.193935]     meminfo_proc_show+0x5c/0x4fc
[   20.194115]     seq_read_iter+0x18c/0x4c4
[   20.194285]     proc_reg_read_iter+0x84/0xac
[   20.194475]     generic_file_splice_read+0xe8/0x17c
[   20.194685]     splice_direct_to_actor+0xb8/0x290
[   20.194870]     do_splice_direct+0xa0/0xe0
[   20.195014]     do_sendfile+0x2d0/0x438
[   20.195174]     sys_sendfile64+0x12c/0x140
[   20.195336]     ret_fast_syscall+0x0/0x58
[   20.195491]     0xbeeacde4

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/slab.h        |  1 +
 mm/slab_common.c | 12 +++++++++++-
 mm/slub.c        |  7 +++++++
 mm/util.c        |  2 +-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 18c1927..7189daa 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -640,6 +640,7 @@ struct kmem_obj_info {
 	struct kmem_cache *kp_slab_cache;
 	void *kp_ret;
 	void *kp_stack[KS_ADDRS_COUNT];
+	void *kp_free_stack[KS_ADDRS_COUNT];
 };
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f8833d3..92e3aa7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -564,7 +564,7 @@ EXPORT_SYMBOL_GPL(kmem_valid_obj);
  * depends on the type of object and on how much debugging is enabled.
  * For a slab-cache object, the fact that it is a slab object is printed,
  * and, if available, the slab name, return address, and stack trace from
- * the allocation of that object.
+ * the allocation and last free path of that object.
  *
  * This function will splat if passed a pointer to a non-slab object.
  * If you are not sure what type of object you have, you should instead
@@ -609,6 +609,16 @@ void kmem_dump_obj(void *object)
 			break;
 		pr_info("    %pS\n", kp.kp_stack[i]);
 	}
+
+	if (kp.kp_free_stack[0])
+		pr_cont(" Free path:\n");
+
+	for (i = 0; i < ARRAY_SIZE(kp.kp_free_stack); i++) {
+		if (!kp.kp_free_stack[i])
+			break;
+		pr_info("    %pS\n", kp.kp_free_stack[i]);
+	}
+
 }
 EXPORT_SYMBOL_GPL(kmem_dump_obj);
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 8f2d135..deec894 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4011,6 +4011,13 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 		if (!kpp->kp_stack[i])
 			break;
 	}
+
+	trackp = get_track(s, objp, TRACK_FREE);
+	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
+		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
+		if (!kpp->kp_free_stack[i])
+			break;
+	}
 #endif
 #endif
 }
diff --git a/mm/util.c b/mm/util.c
index a8bf17f..0b6dd9d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -983,7 +983,7 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
  * depends on the type of object and on how much debugging is enabled.
  * For example, for a slab-cache object, the slab name is printed, and,
  * if available, the return address and stack trace from the allocation
- * of that object.
+ * and last free path of that object.
  */
 void mem_dump_obj(void *object)
 {

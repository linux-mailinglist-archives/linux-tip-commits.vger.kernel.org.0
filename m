Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DD319E82
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhBLMhz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhBLMhr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768DC061786;
        Fri, 12 Feb 2021 04:37:07 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Wm3+/ZioKwWoQFRQO8xdr1aYgVij0tuadky7iNPDJvk=;
        b=KdLSE5uZa0+fWqeypEylwVaW1fctaSCHbGDJn8LJcXZ9UQSQNp12XZM0HZsXL192gWgmQx
        FLsA8HG1aJ1h9EZyN7WeqxcF5bTcPpUBmpJ9O+Pv7TCTSRhg/bT9cLH0JMUBZaSVQ7TG0x
        WTzOGv86zL3WRpb4i/3hFKyf2lwpGIGfXO1QNuzbcrzloRAEEbMnoEjmKU/vC9UYwfif6b
        qxp+0Gi2jYtqi9++OPet50Nv22NBFR/jEZYDtPeARTm8TW+r6Voo0/y4C9uIx31sV9Q8Ow
        ycpqQGP3CAXEXSTCBhdNa0w+wce5hDIgTh8FoF8lclTqj/Fri02T5WIGKh3KOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Wm3+/ZioKwWoQFRQO8xdr1aYgVij0tuadky7iNPDJvk=;
        b=nHhoL9zC5QaFNLo0UMluLeV1FkHyD5zItr80kKUaNv/9CW0iC+y+x/jyZXmyUirdjPHG9A
        v67fv9wSGGcE0BBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm: Make mem_dump_obj() handle vmalloc() memory
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342375.23325.18336254972948855257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     98f180837a896ecedf8f7e12af22b57f271d43c9
Gitweb:        https://git.kernel.org/tip/98f180837a896ecedf8f7e12af22b57f271d43c9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 08 Dec 2020 16:13:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 22 Jan 2021 15:24:04 -08:00

mm: Make mem_dump_obj() handle vmalloc() memory

This commit adds vmalloc() support to mem_dump_obj().  Note that the
vmalloc_dump_obj() function combines the checking and dumping, in
contrast with the split between kmem_valid_obj() and kmem_dump_obj().
The reason for the difference is that the checking in the vmalloc()
case involves acquiring a global lock, and redundant acquisitions of
global locks should be avoided, even on not-so-fast paths.

Note that this change causes on-stack variables to be reported as
vmalloc() storage from kernel_clone() or similar, depending on the degree
of inlining that your compiler does.  This is likely more helpful than
the earlier "non-paged (local) memory".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/vmalloc.h |  6 ++++++
 mm/util.c               | 14 ++++++++------
 mm/vmalloc.c            | 12 ++++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 80c0181..c18f475 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -246,4 +246,10 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
+#ifdef CONFIG_MMU
+bool vmalloc_dump_obj(void *object);
+#else
+static inline bool vmalloc_dump_obj(void *object) { return false; }
+#endif
+
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/util.c b/mm/util.c
index 92f23d2..5487022 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -996,18 +996,20 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
  */
 void mem_dump_obj(void *object)
 {
+	if (kmem_valid_obj(object)) {
+		kmem_dump_obj(object);
+		return;
+	}
+	if (vmalloc_dump_obj(object))
+		return;
 	if (!virt_addr_valid(object)) {
 		if (object == NULL)
 			pr_cont(" NULL pointer.\n");
 		else if (object == ZERO_SIZE_PTR)
 			pr_cont(" zero-size pointer.\n");
 		else
-			pr_cont(" non-paged (local) memory.\n");
-		return;
-	}
-	if (kmem_valid_obj(object)) {
-		kmem_dump_obj(object);
+			pr_cont(" non-paged memory.\n");
 		return;
 	}
-	pr_cont(" non-slab memory.\n");
+	pr_cont(" non-slab/vmalloc memory.\n");
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4d88fe5..c274ea4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3448,6 +3448,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 }
 #endif	/* CONFIG_SMP */
 
+bool vmalloc_dump_obj(void *object)
+{
+	struct vm_struct *vm;
+	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+
+	vm = find_vm_area(objp);
+	if (!vm)
+		return false;
+	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
+	return true;
+}
+
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
 	__acquires(&vmap_purge_lock)

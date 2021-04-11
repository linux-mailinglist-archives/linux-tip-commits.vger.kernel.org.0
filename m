Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0542E35B501
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhDKNon (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhDKNoO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:14 -0400
Date:   Sun, 11 Apr 2021 13:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Pe0Qd4dqFoNuAWtRebMahlgUvIey1PIEH7ZZ9BPKXOE=;
        b=0gmt7/rGk/r/G2xOJECf0EUIDMOytmg9Rls+CeRLamoppUiAbzXWzK5tQZa/n51hSSFnzm
        lKXPiQnx6ssm7G/5+YJMxpZqS9IpwwfAb2Ulaiu4acfkmO4dWawXV96xGqlrnblTz4bZs9
        wnFjYEUbN+Z0WmAY8UJg+c9PovFmzRVGPlS8fEQ2hhpNjo1iOjljs5cnbbEk/E5XYGI4jN
        98HMzMSEApL3LEzsN+8983sxKNVerQWSlrRKwv7NmPJNyxA+T6DrBuUDOHhDFgtTQbmlmr
        yd42V6vZydMScjNKeRKRTKl89mfEuhofRUbfKR1eyDeucCEQcrPx/iEgwUYCwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Pe0Qd4dqFoNuAWtRebMahlgUvIey1PIEH7ZZ9BPKXOE=;
        b=vi3IGC6t699Vhx6XBCxaPxzhIkdMCqrH8C3mPPVwMazny1F8nx7zH+Au5SKRt/q+CXwrnm
        s8cbYk5+fyJLDBCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm: Don't build mm_dump_obj() on CONFIG_PRINTK=n kernels
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861892.29796.15016554542635308623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5bb1bb353cfe343fc3c84faf06f72ba309fde541
Gitweb:        https://git.kernel.org/tip/5bb1bb353cfe343fc3c84faf06f72ba309fde541
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 07 Jan 2021 13:46:11 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:18:46 -08:00

mm: Don't build mm_dump_obj() on CONFIG_PRINTK=n kernels

The mem_dump_obj() functionality adds a few hundred bytes, which is a
small price to pay.  Except on kernels built with CONFIG_PRINTK=n, in
which mem_dump_obj() messages will be suppressed.  This commit therefore
makes mem_dump_obj() be a static inline empty function on kernels built
with CONFIG_PRINTK=n and excludes all of its support functions as well.
This avoids kernel bloat on systems that cannot use mem_dump_obj().

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <linux-mm@kvack.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/mm.h      | 4 ++++
 include/linux/slab.h    | 2 ++
 include/linux/vmalloc.h | 2 +-
 mm/slab.c               | 2 ++
 mm/slab.h               | 2 ++
 mm/slab_common.c        | 2 ++
 mm/slob.c               | 2 ++
 mm/slub.c               | 2 ++
 mm/util.c               | 2 ++
 mm/vmalloc.c            | 2 ++
 10 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3..89fca44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3135,7 +3135,11 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
+#ifdef CONFIG_PRINTK
 void mem_dump_obj(void *object);
+#else
+static inline void mem_dump_obj(void *object) {}
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7ae6040..0c97d78 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -186,8 +186,10 @@ void kfree(const void *);
 void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
+#ifdef CONFIG_PRINTK
 bool kmem_valid_obj(void *object);
 void kmem_dump_obj(void *object);
+#endif
 
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index df92211..3de7be6 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -241,7 +241,7 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
 bool vmalloc_dump_obj(void *object);
 #else
 static inline bool vmalloc_dump_obj(void *object) { return false; }
diff --git a/mm/slab.c b/mm/slab.c
index 51fd424..2e64efe 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3651,6 +3651,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 {
 	struct kmem_cache *cachep;
@@ -3670,6 +3671,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	if (DEBUG && cachep->flags & SLAB_STORE_USER)
 		kpp->kp_ret = *dbg_userword(cachep, objp);
 }
+#endif
 
 /**
  * __do_kmalloc - allocate memory
diff --git a/mm/slab.h b/mm/slab.h
index 076582f..120b1d0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -619,6 +619,7 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
 	return false;
 }
 
+#ifdef CONFIG_PRINTK
 #define KS_ADDRS_COUNT 16
 struct kmem_obj_info {
 	void *kp_ptr;
@@ -630,5 +631,6 @@ struct kmem_obj_info {
 	void *kp_stack[KS_ADDRS_COUNT];
 };
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
+#endif
 
 #endif /* MM_SLAB_H */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 88e8339..cec9536 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -526,6 +526,7 @@ bool slab_is_available(void)
 	return slab_state >= UP;
 }
 
+#ifdef CONFIG_PRINTK
 /**
  * kmem_valid_obj - does the pointer reference a valid slab object?
  * @object: pointer to query.
@@ -600,6 +601,7 @@ void kmem_dump_obj(void *object)
 		pr_info("    %pS\n", kp.kp_stack[i]);
 	}
 }
+#endif
 
 #ifndef CONFIG_SLOB
 /* Create a cache during boot when no slab services are available yet */
diff --git a/mm/slob.c b/mm/slob.c
index 0578429..74d3f6e 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -461,11 +461,13 @@ out:
 	spin_unlock_irqrestore(&slob_lock, flags);
 }
 
+#ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 {
 	kpp->kp_ptr = object;
 	kpp->kp_page = page;
 }
+#endif
 
 /*
  * End of slob allocator proper. Begin kmem_cache_alloc and kmalloc frontend.
diff --git a/mm/slub.c b/mm/slub.c
index e26c274..077a019 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3963,6 +3963,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	return 0;
 }
 
+#ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 {
 	void *base;
@@ -4002,6 +4003,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 #endif
 #endif
 }
+#endif
 
 /********************************************************************
  *		Kmalloc subsystem
diff --git a/mm/util.c b/mm/util.c
index 5487022..2d497fe 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -983,6 +983,7 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	return ret;
 }
 
+#ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
  * @object: object for which to find provenance information.
@@ -1013,3 +1014,4 @@ void mem_dump_obj(void *object)
 	}
 	pr_cont(" non-slab/vmalloc memory.\n");
 }
+#endif
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f5f8c9..d5f2a84 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3450,6 +3450,7 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 }
 #endif	/* CONFIG_SMP */
 
+#ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
 	struct vm_struct *vm;
@@ -3462,6 +3463,7 @@ bool vmalloc_dump_obj(void *object)
 		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
 	return true;
 }
+#endif
 
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)

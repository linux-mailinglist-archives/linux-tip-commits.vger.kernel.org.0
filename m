Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E540319EA1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBLMjW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhBLMiO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941FC061788;
        Fri, 12 Feb 2021 04:37:09 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n/2O4MW6tBsb0be9oMwFvoXC9Q36a+ogMz2ToVT03zM=;
        b=pa3EcubmotNnoz/KHi2b2B7Av/66egnjUG6FvooAwzB0W2c8pkvcqVFvapN4z6HfBLhAaP
        erD8mhDVFAmJyboHCKeDna9nmCJTF8rjrJp6vR4XBiInPgFo1x1EBIo5uALnRZzIoERDhZ
        AuxbmTeDoLL/F+nwFSSg0044ZhKlBzc2KFFXt335HS+VE0QLj+sgYp1h/txaT/evcFcZGT
        fVTmRi/dvJUEgpOnyCvZEwtjjrAfFoOhqJNLbXlUlFYSp2hgsT4/PuwJ/QEHKnYDaQMXfd
        QKNKQMpw8gTMfTleGt9VFXfzkgcJcfRQx0OkUT7PNzmaCPVwg+w1gnf+Gu/kdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n/2O4MW6tBsb0be9oMwFvoXC9Q36a+ogMz2ToVT03zM=;
        b=uRO32VkAQpjczJ0qpWPRDj3aR3d2zi1sn7kt0jBx75JV9awi2FBvU9hB9u0yytllQYcq4/
        Hilwft1vbopVUfDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm: Add mem_dump_obj() to print source of memory block
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Andrii Nakryiko <andrii@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342425.23325.2274298051080359664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8e7f37f2aaa56b723a24f6872817cf9c6410b613
Gitweb:        https://git.kernel.org/tip/8e7f37f2aaa56b723a24f6872817cf9c6410b613
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 07 Dec 2020 17:41:02 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 22 Jan 2021 15:16:01 -08:00

mm: Add mem_dump_obj() to print source of memory block

There are kernel facilities such as per-CPU reference counts that give
error messages in generic handlers or callbacks, whose messages are
unenlightening.  In the case of per-CPU reference-count underflow, this
is not a problem when creating a new use of this facility because in that
case the bug is almost certainly in the code implementing that new use.
However, trouble arises when deploying across many systems, which might
exercise corner cases that were not seen during development and testing.
Here, it would be really nice to get some kind of hint as to which of
several uses the underflow was caused by.

This commit therefore exposes a mem_dump_obj() function that takes
a pointer to memory (which must still be allocated if it has been
dynamically allocated) and prints available information on where that
memory came from.  This pointer can reference the middle of the block as
well as the beginning of the block, as needed by things like RCU callback
functions and timer handlers that might not know where the beginning of
the memory block is.  These functions and handlers can use mem_dump_obj()
to print out better hints as to where the problem might lie.

The information printed can depend on kernel configuration.  For example,
the allocation return address can be printed only for slab and slub,
and even then only when the necessary debug has been enabled.  For slab,
build with CONFIG_DEBUG_SLAB=y, and either use sizes with ample space
to the next power of two or use the SLAB_STORE_USER when creating the
kmem_cache structure.  For slub, build with CONFIG_SLUB_DEBUG=y and
boot with slub_debug=U, or pass SLAB_STORE_USER to kmem_cache_create()
if more focused use is desired.  Also for slub, use CONFIG_STACKTRACE
to enable printing of the allocation-time stack trace.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
[ paulmck: Convert to printing and change names per Joonsoo Kim. ]
[ paulmck: Move slab definition per Stephen Rothwell and kbuild test robot. ]
[ paulmck: Handle CONFIG_MMU=n case where vmalloc() is kmalloc(). ]
[ paulmck: Apply Vlastimil Babka feedback on slab.c kmem_provenance(). ]
[ paulmck: Extract more info from !SLUB_DEBUG per Joonsoo Kim. ]
[ paulmck: Explicitly check for small pointers per Naresh Kamboju. ]
Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/mm.h   |  2 +-
 include/linux/slab.h |  2 +-
 mm/slab.c            | 20 +++++++++++-
 mm/slab.h            | 12 +++++++-
 mm/slab_common.c     | 75 +++++++++++++++++++++++++++++++++++++++++++-
 mm/slob.c            |  6 +++-
 mm/slub.c            | 40 +++++++++++++++++++++++-
 mm/util.c            | 24 ++++++++++++++-
 8 files changed, 181 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5299b90..af7d050 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3169,5 +3169,7 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
+void mem_dump_obj(void *object);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/slab.h b/include/linux/slab.h
index be4ba58..7ae6040 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -186,6 +186,8 @@ void kfree(const void *);
 void kfree_sensitive(const void *);
 size_t __ksize(const void *);
 size_t ksize(const void *);
+bool kmem_valid_obj(void *object);
+void kmem_dump_obj(void *object);
 
 #ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
 void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
diff --git a/mm/slab.c b/mm/slab.c
index d7c8da9..dcc55e7 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3635,6 +3635,26 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 #endif /* CONFIG_NUMA */
 
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
+{
+	struct kmem_cache *cachep;
+	unsigned int objnr;
+	void *objp;
+
+	kpp->kp_ptr = object;
+	kpp->kp_page = page;
+	cachep = page->slab_cache;
+	kpp->kp_slab_cache = cachep;
+	objp = object - obj_offset(cachep);
+	kpp->kp_data_offset = obj_offset(cachep);
+	page = virt_to_head_page(objp);
+	objnr = obj_to_index(cachep, page, objp);
+	objp = index_to_obj(cachep, page, objnr);
+	kpp->kp_objp = objp;
+	if (DEBUG && cachep->flags & SLAB_STORE_USER)
+		kpp->kp_ret = *dbg_userword(cachep, objp);
+}
+
 /**
  * __do_kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab.h b/mm/slab.h
index 1a756a3..ecad9b5 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -615,4 +615,16 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
 	return false;
 }
 
+#define KS_ADDRS_COUNT 16
+struct kmem_obj_info {
+	void *kp_ptr;
+	struct page *kp_page;
+	void *kp_objp;
+	unsigned long kp_data_offset;
+	struct kmem_cache *kp_slab_cache;
+	void *kp_ret;
+	void *kp_stack[KS_ADDRS_COUNT];
+};
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
+
 #endif /* MM_SLAB_H */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e981c80..adbace4 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -537,6 +537,81 @@ bool slab_is_available(void)
 	return slab_state >= UP;
 }
 
+/**
+ * kmem_valid_obj - does the pointer reference a valid slab object?
+ * @object: pointer to query.
+ *
+ * Return: %true if the pointer is to a not-yet-freed object from
+ * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
+ * is to an already-freed object, and %false otherwise.
+ */
+bool kmem_valid_obj(void *object)
+{
+	struct page *page;
+
+	/* Some arches consider ZERO_SIZE_PTR to be a valid address. */
+	if (object < (void *)PAGE_SIZE || !virt_addr_valid(object))
+		return false;
+	page = virt_to_head_page(object);
+	return PageSlab(page);
+}
+
+/**
+ * kmem_dump_obj - Print available slab provenance information
+ * @object: slab object for which to find provenance information.
+ *
+ * This function uses pr_cont(), so that the caller is expected to have
+ * printed out whatever preamble is appropriate.  The provenance information
+ * depends on the type of object and on how much debugging is enabled.
+ * For a slab-cache object, the fact that it is a slab object is printed,
+ * and, if available, the slab name, return address, and stack trace from
+ * the allocation of that object.
+ *
+ * This function will splat if passed a pointer to a non-slab object.
+ * If you are not sure what type of object you have, you should instead
+ * use mem_dump_obj().
+ */
+void kmem_dump_obj(void *object)
+{
+	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
+	int i;
+	struct page *page;
+	unsigned long ptroffset;
+	struct kmem_obj_info kp = { };
+
+	if (WARN_ON_ONCE(!virt_addr_valid(object)))
+		return;
+	page = virt_to_head_page(object);
+	if (WARN_ON_ONCE(!PageSlab(page))) {
+		pr_cont(" non-slab memory.\n");
+		return;
+	}
+	kmem_obj_info(&kp, object, page);
+	if (kp.kp_slab_cache)
+		pr_cont(" slab%s %s", cp, kp.kp_slab_cache->name);
+	else
+		pr_cont(" slab%s", cp);
+	if (kp.kp_objp)
+		pr_cont(" start %px", kp.kp_objp);
+	if (kp.kp_data_offset)
+		pr_cont(" data offset %lu", kp.kp_data_offset);
+	if (kp.kp_objp) {
+		ptroffset = ((char *)object - (char *)kp.kp_objp) - kp.kp_data_offset;
+		pr_cont(" pointer offset %lu", ptroffset);
+	}
+	if (kp.kp_slab_cache && kp.kp_slab_cache->usersize)
+		pr_cont(" size %u", kp.kp_slab_cache->usersize);
+	if (kp.kp_ret)
+		pr_cont(" allocated at %pS\n", kp.kp_ret);
+	else
+		pr_cont("\n");
+	for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
+		if (!kp.kp_stack[i])
+			break;
+		pr_info("    %pS\n", kp.kp_stack[i]);
+	}
+}
+
 #ifndef CONFIG_SLOB
 /* Create a cache during boot when no slab services are available yet */
 void __init create_boot_cache(struct kmem_cache *s, const char *name,
diff --git a/mm/slob.c b/mm/slob.c
index 8d4bfa4..ef87ada 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -461,6 +461,12 @@ out:
 	spin_unlock_irqrestore(&slob_lock, flags);
 }
 
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
+{
+	kpp->kp_ptr = object;
+	kpp->kp_page = page;
+}
+
 /*
  * End of slob allocator proper. Begin kmem_cache_alloc and kmalloc frontend.
  */
diff --git a/mm/slub.c b/mm/slub.c
index 0c8b43a..3c1a843 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3919,6 +3919,46 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	return 0;
 }
 
+void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
+{
+	void *base;
+	int __maybe_unused i;
+	unsigned int objnr;
+	void *objp;
+	void *objp0;
+	struct kmem_cache *s = page->slab_cache;
+	struct track __maybe_unused *trackp;
+
+	kpp->kp_ptr = object;
+	kpp->kp_page = page;
+	kpp->kp_slab_cache = s;
+	base = page_address(page);
+	objp0 = kasan_reset_tag(object);
+#ifdef CONFIG_SLUB_DEBUG
+	objp = restore_red_left(s, objp0);
+#else
+	objp = objp0;
+#endif
+	objnr = obj_to_index(s, page, objp);
+	kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
+	objp = base + s->size * objnr;
+	kpp->kp_objp = objp;
+	if (WARN_ON_ONCE(objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size) ||
+	    !(s->flags & SLAB_STORE_USER))
+		return;
+#ifdef CONFIG_SLUB_DEBUG
+	trackp = get_track(s, objp, TRACK_ALLOC);
+	kpp->kp_ret = (void *)trackp->addr;
+#ifdef CONFIG_STACKTRACE
+	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
+		kpp->kp_stack[i] = (void *)trackp->addrs[i];
+		if (!kpp->kp_stack[i])
+			break;
+	}
+#endif
+#endif
+}
+
 /********************************************************************
  *		Kmalloc subsystem
  *******************************************************************/
diff --git a/mm/util.c b/mm/util.c
index 8c9b7d1..da46f9d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -982,3 +982,27 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	kunmap_atomic(addr1);
 	return ret;
 }
+
+/**
+ * mem_dump_obj - Print available provenance information
+ * @object: object for which to find provenance information.
+ *
+ * This function uses pr_cont(), so that the caller is expected to have
+ * printed out whatever preamble is appropriate.  The provenance information
+ * depends on the type of object and on how much debugging is enabled.
+ * For example, for a slab-cache object, the slab name is printed, and,
+ * if available, the return address and stack trace from the allocation
+ * of that object.
+ */
+void mem_dump_obj(void *object)
+{
+	if (!virt_addr_valid(object)) {
+		pr_cont(" non-paged (local) memory.\n");
+		return;
+	}
+	if (kmem_valid_obj(object)) {
+		kmem_dump_obj(object);
+		return;
+	}
+	pr_cont(" non-slab memory.\n");
+}

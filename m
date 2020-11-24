Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2EB2C2950
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbgKXOU5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 09:20:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43714 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbgKXOUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 09:20:55 -0500
Date:   Tue, 24 Nov 2020 14:20:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606227653;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2mI+OrESNDvxkJdg/1FJ7DOP/kjL2pn+uAvR+x7Wa4=;
        b=fjUb7bv7H3/1zV6HOSDlxWOHtgOhVMp0YsL2hKCC2Svbj3O9ANV/yJPuPX1KZeY/2uly8N
        5MDkPGHEhAKD7hcbqeL8I2YBPwh3Xsi5iv+JuMJH3sEnl9U9h/AkyMWiF6aBTu6+iiZhj7
        Zi8h8r0Dt4bKIYmkCpjdDi+T8YLV9MLyFdRypMhO0tQGfQI++FuuOziFqlYmD786GsZKOI
        9V96eHQozNPNdpJ09GRxM/rUgPus0UmddiJwrP4kp+ERtR9FSPstoRvM9kEwFZPfPepxbK
        9MyX1UDvdCwSsN040Inpu8Y6jiUOwS2sZdjR+w7Bvhsqj1AKZJtrkgijQmFITA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606227653;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2mI+OrESNDvxkJdg/1FJ7DOP/kjL2pn+uAvR+x7Wa4=;
        b=eT3cNiRL0IQH3UXOipq6ypYlf4JwddZZqV9cP3wYWo+QxIh1DKsIKQ8SoWyhOrzDYBkUQn
        VqjWbJ7McQzIAFAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] io-mapping: Provide iomap_local variant
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118204007.561220818@linutronix.de>
References: <20201118204007.561220818@linutronix.de>
MIME-Version: 1.0
Message-ID: <160622765230.11115.6074280630655989113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     e66f6e095486f0210fcf3c5eb3ecf13fa348be4c
Gitweb:        https://git.kernel.org/tip/e66f6e095486f0210fcf3c5eb3ecf13fa348be4c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 18 Nov 2020 20:48:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 14:42:09 +01:00

io-mapping: Provide iomap_local variant

Similar to kmap local provide a iomap local variant which only disables
migration, but neither disables pagefaults nor preemption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201118204007.561220818@linutronix.de

---
 Documentation/driver-api/io-mapping.rst | 74 ++++++++++++++----------
 include/linux/io-mapping.h              | 30 +++++++++-
 2 files changed, 73 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/io-mapping.rst b/Documentation/driver-api/io-mapping.rst
index e33b882..a0cfb15 100644
--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -20,55 +20,71 @@ A mapping object is created during driver initialization using::
 mappable, while 'size' indicates how large a mapping region to
 enable. Both are in bytes.
 
-This _wc variant provides a mapping which may only be used
-with the io_mapping_map_atomic_wc or io_mapping_map_wc.
+This _wc variant provides a mapping which may only be used with
+io_mapping_map_atomic_wc(), io_mapping_map_local_wc() or
+io_mapping_map_wc().
 
-With this mapping object, individual pages can be mapped either atomically
-or not, depending on the necessary scheduling environment. Of course, atomic
-maps are more efficient::
+With this mapping object, individual pages can be mapped either temporarily
+or long term, depending on the requirements. Of course, temporary maps are
+more efficient. They come in two flavours::
+
+	void *io_mapping_map_local_wc(struct io_mapping *mapping,
+				      unsigned long offset)
 
 	void *io_mapping_map_atomic_wc(struct io_mapping *mapping,
 				       unsigned long offset)
 
-'offset' is the offset within the defined mapping region.
-Accessing addresses beyond the region specified in the
-creation function yields undefined results. Using an offset
-which is not page aligned yields an undefined result. The
-return value points to a single page in CPU address space.
+'offset' is the offset within the defined mapping region.  Accessing
+addresses beyond the region specified in the creation function yields
+undefined results. Using an offset which is not page aligned yields an
+undefined result. The return value points to a single page in CPU address
+space.
 
-This _wc variant returns a write-combining map to the
-page and may only be used with mappings created by
-io_mapping_create_wc
+This _wc variant returns a write-combining map to the page and may only be
+used with mappings created by io_mapping_create_wc()
 
-Note that the task may not sleep while holding this page
-mapped.
+Temporary mappings are only valid in the context of the caller. The mapping
+is not guaranteed to be globaly visible.
 
-::
+io_mapping_map_local_wc() has a side effect on X86 32bit as it disables
+migration to make the mapping code work. No caller can rely on this side
+effect.
 
-	void io_mapping_unmap_atomic(void *vaddr)
+io_mapping_map_atomic_wc() has the side effect of disabling preemption and
+pagefaults. Don't use in new code. Use io_mapping_map_local_wc() instead.
 
-'vaddr' must be the value returned by the last
-io_mapping_map_atomic_wc call. This unmaps the specified
-page and allows the task to sleep once again.
+Nested mappings need to be undone in reverse order because the mapping
+code uses a stack for keeping track of them::
 
-If you need to sleep while holding the lock, you can use the non-atomic
-variant, although they may be significantly slower.
+ addr1 = io_mapping_map_local_wc(map1, offset1);
+ addr2 = io_mapping_map_local_wc(map2, offset2);
+ ...
+ io_mapping_unmap_local(addr2);
+ io_mapping_unmap_local(addr1);
 
-::
+The mappings are released with::
+
+	void io_mapping_unmap_local(void *vaddr)
+	void io_mapping_unmap_atomic(void *vaddr)
+
+'vaddr' must be the value returned by the last io_mapping_map_local_wc() or
+io_mapping_map_atomic_wc() call. This unmaps the specified mapping and
+undoes the side effects of the mapping functions.
+
+If you need to sleep while holding a mapping, you can use the regular
+variant, although this may be significantly slower::
 
 	void *io_mapping_map_wc(struct io_mapping *mapping,
 				unsigned long offset)
 
-This works like io_mapping_map_atomic_wc except it allows
-the task to sleep while holding the page mapped.
-
+This works like io_mapping_map_atomic/local_wc() except it has no side
+effects and the pointer is globaly visible.
 
-::
+The mappings are released with::
 
 	void io_mapping_unmap(void *vaddr)
 
-This works like io_mapping_unmap_atomic, except it is used
-for pages mapped with io_mapping_map_wc.
+Use for pages mapped with io_mapping_map_wc().
 
 At driver close time, the io_mapping object must be freed::
 
diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 60e7c83..c093e81 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -83,6 +83,21 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 }
 
 static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	resource_size_t phys_addr;
+
+	BUG_ON(offset >= mapping->size);
+	phys_addr = mapping->base + offset;
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
+}
+
+static inline void __iomem *
 io_mapping_map_wc(struct io_mapping *mapping,
 		  unsigned long offset,
 		  unsigned long size)
@@ -101,7 +116,7 @@ io_mapping_unmap(void __iomem *vaddr)
 	iounmap(vaddr);
 }
 
-#else
+#else  /* HAVE_ATOMIC_IOMAP */
 
 #include <linux/uaccess.h>
 
@@ -166,7 +181,18 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 	preempt_enable();
 }
 
-#endif /* HAVE_ATOMIC_IOMAP */
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	io_mapping_unmap(vaddr);
+}
+
+#endif /* !HAVE_ATOMIC_IOMAP */
 
 static inline struct io_mapping *
 io_mapping_create_wc(resource_size_t base,

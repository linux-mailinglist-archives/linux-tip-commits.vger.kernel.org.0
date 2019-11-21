Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7F104A86
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Nov 2019 07:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUGDg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Nov 2019 01:03:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfKUGDf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Nov 2019 01:03:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXfYf-0004QT-PP; Thu, 21 Nov 2019 07:03:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 56B0B1C19AE;
        Thu, 21 Nov 2019 07:03:13 +0100 (CET)
Date:   Thu, 21 Nov 2019 06:03:13 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Rename pat_rbtree.c to pat_interval.c
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave@stgolabs.net,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191021231924.25373-5-dave@stgolabs.net>
References: <20191021231924.25373-5-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157431619321.21853.6320580586819014584.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ee4e7b04b718cc8a674810e3e0a339a493833640
Gitweb:        https://git.kernel.org/tip/ee4e7b04b718cc8a674810e3e0a339a493833640
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Mon, 21 Oct 2019 16:19:24 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 09:16:00 +01:00

x86/mm/pat: Rename pat_rbtree.c to pat_interval.c

Considering that we don't use an rbtree but an interval tree,
rename the main file accordingly.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave@stgolabs.net
Link: https://lkml.kernel.org/r/20191021231924.25373-5-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/Makefile       |   2 +-
 arch/x86/mm/pat_interval.c | 186 ++++++++++++++++++++++++++++++++++++-
 arch/x86/mm/pat_rbtree.c   | 186 +------------------------------------
 3 files changed, 187 insertions(+), 187 deletions(-)
 create mode 100644 arch/x86/mm/pat_interval.c
 delete mode 100644 arch/x86/mm/pat_rbtree.c

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 84373dc..de403df 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -23,7 +23,7 @@ CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 
-obj-$(CONFIG_X86_PAT)		+= pat_rbtree.o
+obj-$(CONFIG_X86_PAT)		+= pat_interval.o
 
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
new file mode 100644
index 0000000..ef59e0a
--- /dev/null
+++ b/arch/x86/mm/pat_interval.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handle caching attributes in page tables (PAT)
+ *
+ * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *          Suresh B Siddha <suresh.b.siddha@intel.com>
+ *
+ * Interval tree used to store the PAT memory type reservations.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/sched.h>
+#include <linux/gfp.h>
+
+#include <asm/pgtable.h>
+#include <asm/pat.h>
+
+#include "pat_internal.h"
+
+/*
+ * The memtype tree keeps track of memory type for specific
+ * physical memory areas. Without proper tracking, conflicting memory
+ * types in different mappings can cause CPU cache corruption.
+ *
+ * The tree is an interval tree (augmented rbtree) with tree ordered
+ * on starting address. Tree can contain multiple entries for
+ * different regions which overlap. All the aliases have the same
+ * cache attributes of course.
+ *
+ * memtype_lock protects the rbtree.
+ */
+static inline u64 memtype_interval_start(struct memtype *memtype)
+{
+	return memtype->start;
+}
+
+static inline u64 memtype_interval_end(struct memtype *memtype)
+{
+	return memtype->end - 1;
+}
+INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
+		     memtype_interval_start, memtype_interval_end,
+		     static, memtype_interval)
+
+static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
+
+enum {
+	MEMTYPE_EXACT_MATCH	= 0,
+	MEMTYPE_END_MATCH	= 1
+};
+
+static struct memtype *memtype_match(u64 start, u64 end, int match_type)
+{
+	struct memtype *match;
+
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
+	while (match != NULL && match->start < end) {
+		if ((match_type == MEMTYPE_EXACT_MATCH) &&
+		    (match->start == start) && (match->end == end))
+			return match;
+
+		if ((match_type == MEMTYPE_END_MATCH) &&
+		    (match->start < start) && (match->end == end))
+			return match;
+
+		match = memtype_interval_iter_next(match, start, end);
+	}
+
+	return NULL; /* Returns NULL if there is no match */
+}
+
+static int memtype_check_conflict(u64 start, u64 end,
+				  enum page_cache_mode reqtype,
+				  enum page_cache_mode *newtype)
+{
+	struct memtype *match;
+	enum page_cache_mode found_type = reqtype;
+
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
+	if (match == NULL)
+		goto success;
+
+	if (match->type != found_type && newtype == NULL)
+		goto failure;
+
+	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
+	found_type = match->type;
+
+	match = memtype_interval_iter_next(match, start, end);
+	while (match) {
+		if (match->type != found_type)
+			goto failure;
+
+		match = memtype_interval_iter_next(match, start, end);
+	}
+success:
+	if (newtype)
+		*newtype = found_type;
+
+	return 0;
+
+failure:
+	pr_info("x86/PAT: %s:%d conflicting memory types %Lx-%Lx %s<->%s\n",
+		current->comm, current->pid, start, end,
+		cattr_name(found_type), cattr_name(match->type));
+	return -EBUSY;
+}
+
+int memtype_check_insert(struct memtype *new,
+			 enum page_cache_mode *ret_type)
+{
+	int err = 0;
+
+	err = memtype_check_conflict(new->start, new->end,
+					new->type, ret_type);
+	if (err)
+		goto done;
+
+	if (ret_type)
+		new->type = *ret_type;
+	memtype_interval_insert(new, &memtype_rbroot);
+done:
+	return err;
+}
+
+struct memtype *memtype_erase(u64 start, u64 end)
+{
+	struct memtype *data;
+
+	/*
+	 * Since the memtype_rbroot tree allows overlapping ranges,
+	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
+	 * a whole node for the munmap case.  If no such entry is found,
+	 * it then checks with END_MATCH, i.e. shrink the size of a node
+	 * from the end for the mremap case.
+	 */
+	data = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
+	if (!data) {
+		data = memtype_match(start, end, MEMTYPE_END_MATCH);
+		if (!data)
+			return ERR_PTR(-EINVAL);
+	}
+
+	if (data->start == start) {
+		/* munmap: erase this node */
+		memtype_interval_remove(data, &memtype_rbroot);
+	} else {
+		/* mremap: update the end value of this node */
+		memtype_interval_remove(data, &memtype_rbroot);
+		data->end = start;
+		memtype_interval_insert(data, &memtype_rbroot);
+		return NULL;
+	}
+
+	return data;
+}
+
+struct memtype *memtype_lookup(u64 addr)
+{
+	return memtype_interval_iter_first(&memtype_rbroot, addr,
+					   addr + PAGE_SIZE);
+}
+
+#if defined(CONFIG_DEBUG_FS)
+int memtype_copy_nth_element(struct memtype *out, loff_t pos)
+{
+	struct memtype *match;
+	int i = 1;
+
+	match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
+	while (match && pos != i) {
+		match = memtype_interval_iter_next(match, 0, ULONG_MAX);
+		i++;
+	}
+
+	if (match) { /* pos == i */
+		*out = *match;
+		return 0;
+	} else {
+		return 1;
+	}
+}
+#endif
diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
deleted file mode 100644
index ef59e0a..0000000
--- a/arch/x86/mm/pat_rbtree.c
+++ /dev/null
@@ -1,186 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Handle caching attributes in page tables (PAT)
- *
- * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
- *          Suresh B Siddha <suresh.b.siddha@intel.com>
- *
- * Interval tree used to store the PAT memory type reservations.
- */
-
-#include <linux/seq_file.h>
-#include <linux/debugfs.h>
-#include <linux/kernel.h>
-#include <linux/interval_tree_generic.h>
-#include <linux/sched.h>
-#include <linux/gfp.h>
-
-#include <asm/pgtable.h>
-#include <asm/pat.h>
-
-#include "pat_internal.h"
-
-/*
- * The memtype tree keeps track of memory type for specific
- * physical memory areas. Without proper tracking, conflicting memory
- * types in different mappings can cause CPU cache corruption.
- *
- * The tree is an interval tree (augmented rbtree) with tree ordered
- * on starting address. Tree can contain multiple entries for
- * different regions which overlap. All the aliases have the same
- * cache attributes of course.
- *
- * memtype_lock protects the rbtree.
- */
-static inline u64 memtype_interval_start(struct memtype *memtype)
-{
-	return memtype->start;
-}
-
-static inline u64 memtype_interval_end(struct memtype *memtype)
-{
-	return memtype->end - 1;
-}
-INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
-		     memtype_interval_start, memtype_interval_end,
-		     static, memtype_interval)
-
-static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
-
-enum {
-	MEMTYPE_EXACT_MATCH	= 0,
-	MEMTYPE_END_MATCH	= 1
-};
-
-static struct memtype *memtype_match(u64 start, u64 end, int match_type)
-{
-	struct memtype *match;
-
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
-	while (match != NULL && match->start < end) {
-		if ((match_type == MEMTYPE_EXACT_MATCH) &&
-		    (match->start == start) && (match->end == end))
-			return match;
-
-		if ((match_type == MEMTYPE_END_MATCH) &&
-		    (match->start < start) && (match->end == end))
-			return match;
-
-		match = memtype_interval_iter_next(match, start, end);
-	}
-
-	return NULL; /* Returns NULL if there is no match */
-}
-
-static int memtype_check_conflict(u64 start, u64 end,
-				  enum page_cache_mode reqtype,
-				  enum page_cache_mode *newtype)
-{
-	struct memtype *match;
-	enum page_cache_mode found_type = reqtype;
-
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
-	if (match == NULL)
-		goto success;
-
-	if (match->type != found_type && newtype == NULL)
-		goto failure;
-
-	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
-	found_type = match->type;
-
-	match = memtype_interval_iter_next(match, start, end);
-	while (match) {
-		if (match->type != found_type)
-			goto failure;
-
-		match = memtype_interval_iter_next(match, start, end);
-	}
-success:
-	if (newtype)
-		*newtype = found_type;
-
-	return 0;
-
-failure:
-	pr_info("x86/PAT: %s:%d conflicting memory types %Lx-%Lx %s<->%s\n",
-		current->comm, current->pid, start, end,
-		cattr_name(found_type), cattr_name(match->type));
-	return -EBUSY;
-}
-
-int memtype_check_insert(struct memtype *new,
-			 enum page_cache_mode *ret_type)
-{
-	int err = 0;
-
-	err = memtype_check_conflict(new->start, new->end,
-					new->type, ret_type);
-	if (err)
-		goto done;
-
-	if (ret_type)
-		new->type = *ret_type;
-	memtype_interval_insert(new, &memtype_rbroot);
-done:
-	return err;
-}
-
-struct memtype *memtype_erase(u64 start, u64 end)
-{
-	struct memtype *data;
-
-	/*
-	 * Since the memtype_rbroot tree allows overlapping ranges,
-	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
-	 * a whole node for the munmap case.  If no such entry is found,
-	 * it then checks with END_MATCH, i.e. shrink the size of a node
-	 * from the end for the mremap case.
-	 */
-	data = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
-	if (!data) {
-		data = memtype_match(start, end, MEMTYPE_END_MATCH);
-		if (!data)
-			return ERR_PTR(-EINVAL);
-	}
-
-	if (data->start == start) {
-		/* munmap: erase this node */
-		memtype_interval_remove(data, &memtype_rbroot);
-	} else {
-		/* mremap: update the end value of this node */
-		memtype_interval_remove(data, &memtype_rbroot);
-		data->end = start;
-		memtype_interval_insert(data, &memtype_rbroot);
-		return NULL;
-	}
-
-	return data;
-}
-
-struct memtype *memtype_lookup(u64 addr)
-{
-	return memtype_interval_iter_first(&memtype_rbroot, addr,
-					   addr + PAGE_SIZE);
-}
-
-#if defined(CONFIG_DEBUG_FS)
-int memtype_copy_nth_element(struct memtype *out, loff_t pos)
-{
-	struct memtype *match;
-	int i = 1;
-
-	match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
-	while (match && pos != i) {
-		match = memtype_interval_iter_next(match, 0, ULONG_MAX);
-		i++;
-	}
-
-	if (match) { /* pos == i */
-		*out = *match;
-		return 0;
-	} else {
-		return 1;
-	}
-}
-#endif

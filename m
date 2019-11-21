Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710151058E1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Nov 2019 18:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKURzb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Nov 2019 12:55:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33117 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKURzb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Nov 2019 12:55:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXqfr-0002F8-DZ; Thu, 21 Nov 2019 18:55:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 16A981C1A46;
        Thu, 21 Nov 2019 18:55:23 +0100 (CET)
Date:   Thu, 21 Nov 2019 17:55:23 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Drop the rbt_ prefix from external memtype calls
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121011601.20611-4-dave@stgolabs.net>
References: <20191121011601.20611-4-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157435892301.21853.17987056547102781237.tip-bot2@tip-bot2>
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

Commit-ID:     511aaca834fe2dc0b652406bda6283842fdc70ce
Gitweb:        https://git.kernel.org/tip/511aaca834fe2dc0b652406bda6283842fdc70ce
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Wed, 20 Nov 2019 17:16:00 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 18:48:07 +01:00

x86/mm/pat: Drop the rbt_ prefix from external memtype calls

Drop the rbt_memtype_*() call rbt_ prefix, as we no longer use
an rbtree directly.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20191121011601.20611-4-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat.c          |  8 ++++----
 arch/x86/mm/pat_internal.h | 20 ++++++++++----------
 arch/x86/mm/pat_rbtree.c   | 12 ++++++------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index d9fbd4f..2d758e1 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -603,7 +603,7 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 	spin_lock(&memtype_lock);
 
-	err = rbt_memtype_check_insert(new, new_type);
+	err = memtype_check_insert(new, new_type);
 	if (err) {
 		pr_info("x86/PAT: reserve_memtype failed [mem %#010Lx-%#010Lx], track %s, req %s\n",
 			start, end - 1,
@@ -650,7 +650,7 @@ int free_memtype(u64 start, u64 end)
 	}
 
 	spin_lock(&memtype_lock);
-	entry = rbt_memtype_erase(start, end);
+	entry = memtype_erase(start, end);
 	spin_unlock(&memtype_lock);
 
 	if (IS_ERR(entry)) {
@@ -693,7 +693,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 
 	spin_lock(&memtype_lock);
 
-	entry = rbt_memtype_lookup(paddr);
+	entry = memtype_lookup(paddr);
 	if (entry != NULL)
 		rettype = entry->type;
 	else
@@ -1109,7 +1109,7 @@ static struct memtype *memtype_get_idx(loff_t pos)
 		return NULL;
 
 	spin_lock(&memtype_lock);
-	ret = rbt_memtype_copy_nth_element(print_entry, pos);
+	ret = memtype_copy_nth_element(print_entry, pos);
 	spin_unlock(&memtype_lock);
 
 	if (!ret) {
diff --git a/arch/x86/mm/pat_internal.h b/arch/x86/mm/pat_internal.h
index eeb5cae..79a0668 100644
--- a/arch/x86/mm/pat_internal.h
+++ b/arch/x86/mm/pat_internal.h
@@ -29,20 +29,20 @@ static inline char *cattr_name(enum page_cache_mode pcm)
 }
 
 #ifdef CONFIG_X86_PAT
-extern int rbt_memtype_check_insert(struct memtype *new,
-					enum page_cache_mode *new_type);
-extern struct memtype *rbt_memtype_erase(u64 start, u64 end);
-extern struct memtype *rbt_memtype_lookup(u64 addr);
-extern int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos);
+extern int memtype_check_insert(struct memtype *new,
+				enum page_cache_mode *new_type);
+extern struct memtype *memtype_erase(u64 start, u64 end);
+extern struct memtype *memtype_lookup(u64 addr);
+extern int memtype_copy_nth_element(struct memtype *out, loff_t pos);
 #else
-static inline int rbt_memtype_check_insert(struct memtype *new,
-					enum page_cache_mode *new_type)
+static inline int memtype_check_insert(struct memtype *new,
+				       enum page_cache_mode *new_type)
 { return 0; }
-static inline struct memtype *rbt_memtype_erase(u64 start, u64 end)
+static inline struct memtype *memtype_erase(u64 start, u64 end)
 { return NULL; }
-static inline struct memtype *rbt_memtype_lookup(u64 addr)
+static inline struct memtype *memtype_lookup(u64 addr)
 { return NULL; }
-static inline int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos)
+static inline int memtype_copy_nth_element(struct memtype *out, loff_t pos)
 { return 0; }
 #endif
 
diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index d31ca77..47a1bf3 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -109,8 +109,8 @@ failure:
 	return -EBUSY;
 }
 
-int rbt_memtype_check_insert(struct memtype *new,
-			     enum page_cache_mode *ret_type)
+int memtype_check_insert(struct memtype *new,
+			 enum page_cache_mode *ret_type)
 {
 	int err = 0;
 
@@ -125,13 +125,13 @@ int rbt_memtype_check_insert(struct memtype *new,
 	return 0;
 }
 
-struct memtype *rbt_memtype_erase(u64 start, u64 end)
+struct memtype *memtype_erase(u64 start, u64 end)
 {
 	struct memtype *data;
 
 	/*
 	 * Since the memtype_rbroot tree allows overlapping ranges,
-	 * rbt_memtype_erase() checks with EXACT_MATCH first, i.e. free
+	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
 	 * a whole node for the munmap case.  If no such entry is found,
 	 * it then checks with END_MATCH, i.e. shrink the size of a node
 	 * from the end for the mremap case.
@@ -157,14 +157,14 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 	return data;
 }
 
-struct memtype *rbt_memtype_lookup(u64 addr)
+struct memtype *memtype_lookup(u64 addr)
 {
 	return memtype_interval_iter_first(&memtype_rbroot, addr,
 					   addr + PAGE_SIZE);
 }
 
 #if defined(CONFIG_DEBUG_FS)
-int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos)
+int memtype_copy_nth_element(struct memtype *out, loff_t pos)
 {
 	struct memtype *match;
 	int i = 1;

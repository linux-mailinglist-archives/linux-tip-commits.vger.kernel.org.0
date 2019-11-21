Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32413104A82
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Nov 2019 07:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKUGDb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Nov 2019 01:03:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59715 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfKUGDb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Nov 2019 01:03:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXfYf-0004QV-V3; Thu, 21 Nov 2019 07:03:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 89D661C1A31;
        Thu, 21 Nov 2019 07:03:13 +0100 (CET)
Date:   Thu, 21 Nov 2019 06:03:13 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Drop the rbt_ prefix from external memtype
 function names
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
In-Reply-To: <20191021231924.25373-4-dave@stgolabs.net>
References: <20191021231924.25373-4-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157431619344.21853.17009548729789738080.tip-bot2@tip-bot2>
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

Commit-ID:     b40805c214c5b00151e168796dca5a4ea3b2882a
Gitweb:        https://git.kernel.org/tip/b40805c214c5b00151e168796dca5a4ea3b2882a
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Mon, 21 Oct 2019 16:19:23 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 09:08:43 +01:00

x86/mm/pat: Drop the rbt_ prefix from external memtype function names

Rename:

   rbt_memtype_* => memtype_*()

... as we no longer use an rbtree directly.

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
Link: https://lkml.kernel.org/r/20191021231924.25373-4-dave@stgolabs.net
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
index 7974136..ef59e0a 100644
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
 
@@ -126,13 +126,13 @@ done:
 	return err;
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
@@ -158,14 +158,14 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
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

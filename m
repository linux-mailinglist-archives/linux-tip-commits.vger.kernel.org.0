Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC516FD99A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 10:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKOJnW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 04:43:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42897 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOJnW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 04:43:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY8E-0004Mi-Pw; Fri, 15 Nov 2019 10:43:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 727C81C08AC;
        Fri, 15 Nov 2019 10:43:10 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:43:10 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/mm: Remove set_kernel_text_r[ow]()
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191111132457.819095320@infradead.org>
References: <20191111132457.819095320@infradead.org>
MIME-Version: 1.0
Message-ID: <157381099005.29467.16858532825273379880.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     1091902b2bd0075178fa9181adbc988b85a0116a
Gitweb:        https://git.kernel.org/tip/1091902b2bd0075178fa9181adbc988b85a0116a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 02 Sep 2019 10:16:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 09:07:42 +01:00

x86/mm: Remove set_kernel_text_r[ow]()

With the last and only user of these functions gone (ftrace) remove
them as well to avoid ever growing new users.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132457.819095320@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/set_memory.h |  2 +--
 arch/x86/mm/init_32.c             | 28 +-----------------------
 arch/x86/mm/init_64.c             | 36 +------------------------------
 3 files changed, 66 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 2ee8e46..64c3dce 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -81,8 +81,6 @@ int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 
 extern int kernel_set_to_readonly;
-void set_kernel_text_rw(void);
-void set_kernel_text_ro(void);
 
 #ifdef CONFIG_X86_64
 static inline int set_mce_nospec(unsigned long pfn)
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 930edeb..e9f239e 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -874,34 +874,6 @@ void arch_remove_memory(int nid, u64 start, u64 size,
 
 int kernel_set_to_readonly __read_mostly;
 
-void set_kernel_text_rw(void)
-{
-	unsigned long start = PFN_ALIGN(_text);
-	unsigned long size = PFN_ALIGN(_etext) - start;
-
-	if (!kernel_set_to_readonly)
-		return;
-
-	pr_debug("Set kernel text: %lx - %lx for read write\n",
-		 start, start+size);
-
-	set_pages_rw(virt_to_page(start), size >> PAGE_SHIFT);
-}
-
-void set_kernel_text_ro(void)
-{
-	unsigned long start = PFN_ALIGN(_text);
-	unsigned long size = PFN_ALIGN(_etext) - start;
-
-	if (!kernel_set_to_readonly)
-		return;
-
-	pr_debug("Set kernel text: %lx - %lx for read only\n",
-		 start, start+size);
-
-	set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
-}
-
 static void mark_nxdata_nx(void)
 {
 	/*
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dcb9bc9..b326f14 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1260,42 +1260,6 @@ void __init mem_init(void)
 
 int kernel_set_to_readonly;
 
-void set_kernel_text_rw(void)
-{
-	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = PFN_ALIGN(_etext);
-
-	if (!kernel_set_to_readonly)
-		return;
-
-	pr_debug("Set kernel text: %lx - %lx for read write\n",
-		 start, end);
-
-	/*
-	 * Make the kernel identity mapping for text RW. Kernel text
-	 * mapping will always be RO. Refer to the comment in
-	 * static_protections() in pageattr.c
-	 */
-	set_memory_rw(start, (end - start) >> PAGE_SHIFT);
-}
-
-void set_kernel_text_ro(void)
-{
-	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = PFN_ALIGN(_etext);
-
-	if (!kernel_set_to_readonly)
-		return;
-
-	pr_debug("Set kernel text: %lx - %lx for read only\n",
-		 start, end);
-
-	/*
-	 * Set the kernel identity mapping for text RO.
-	 */
-	set_memory_ro(start, (end - start) >> PAGE_SHIFT);
-}
-
 void mark_rodata_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);

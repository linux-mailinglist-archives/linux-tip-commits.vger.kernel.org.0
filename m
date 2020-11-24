Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C422C2947
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbgKXOUz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 09:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgKXOUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 09:20:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE61C0613D6;
        Tue, 24 Nov 2020 06:20:54 -0800 (PST)
Date:   Tue, 24 Nov 2020 14:20:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606227652;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuD9+vE8jHVOe2NGkmEymBs+LyeZyqp9jPSwcx7T1js=;
        b=HGihpdHY4NwaKeHoOkLclU9EysUCNgkFMcbclaDgMJxw7BPNBJ41/OF3ujv5Dy2rldl7n2
        b4qGw767bmh1Za2Kies9EysJjA/T/Gvw1qfd7FICn0/PdXDUNZw0GfJ35SYP3zPff43rW8
        nGvzxvZtXtWvSvL5lVKXr1EipJ0VdCVgQvh3+1+kyX9yerQRg8MtG9KTBIe5pOK3ckfowM
        NhTzHWNAeOs6LdKRRzj0SPWMuGBcY+T3XvGF4KxV5KaRY54F8MGxr9Utxrd/oIECSOsFfj
        M7vvWkd0V5cl2BoWQVyx4IL+bzkAW48CGyjPnN9FOsS2SzpLn67/PbpLy/mjEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606227652;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuD9+vE8jHVOe2NGkmEymBs+LyeZyqp9jPSwcx7T1js=;
        b=ajdY7g7oWklqmLlvuSyB1kV6jTrfyhKgmEI/Nmb0GkTz6HfwY2oHt5Ys0dgXjGjc1saFIc
        HsHn1rtNAqgHpMDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] x86/crashdump/32: Simplify copy_oldmem_page()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118204007.670851839@linutronix.de>
References: <20201118204007.670851839@linutronix.de>
MIME-Version: 1.0
Message-ID: <160622765151.11115.15024615296192019491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     7e015a279853e747f5d4f957855ec5310848c501
Gitweb:        https://git.kernel.org/tip/7e015a279853e747f5d4f957855ec5310848c501
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 18 Nov 2020 20:48:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 14:42:09 +01:00

x86/crashdump/32: Simplify copy_oldmem_page()

Replace kmap_atomic_pfn() with kmap_local_pfn() which is preemptible and
can take page faults.

Remove the indirection of the dump page and the related cruft which is not
longer required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201118204007.670851839@linutronix.de

---
 arch/x86/kernel/crash_dump_32.c | 48 ++++++--------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_32.c b/arch/x86/kernel/crash_dump_32.c
index 33ee476..5fcac46 100644
--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -13,8 +13,6 @@
 
 #include <linux/uaccess.h>
 
-static void *kdump_buf_page;
-
 static inline bool is_crashed_pfn_valid(unsigned long pfn)
 {
 #ifndef CONFIG_X86_PAE
@@ -41,15 +39,11 @@ static inline bool is_crashed_pfn_valid(unsigned long pfn)
  * @userbuf: if set, @buf is in user address space, use copy_to_user(),
  *	otherwise @buf is in kernel address space, use memcpy().
  *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- *
- * Calling copy_to_user() in atomic context is not desirable. Hence first
- * copying the data to a pre-allocated kernel page and then copying to user
- * space in non-atomic context.
+ * Copy a page from "oldmem". For this page, there might be no pte mapped
+ * in the current kernel.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			 unsigned long offset, int userbuf)
 {
 	void  *vaddr;
 
@@ -59,38 +53,16 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!is_crashed_pfn_valid(pfn))
 		return -EFAULT;
 
-	vaddr = kmap_atomic_pfn(pfn);
+	vaddr = kmap_local_pfn(pfn);
 
 	if (!userbuf) {
-		memcpy(buf, (vaddr + offset), csize);
-		kunmap_atomic(vaddr);
+		memcpy(buf, vaddr + offset, csize);
 	} else {
-		if (!kdump_buf_page) {
-			printk(KERN_WARNING "Kdump: Kdump buffer page not"
-				" allocated\n");
-			kunmap_atomic(vaddr);
-			return -EFAULT;
-		}
-		copy_page(kdump_buf_page, vaddr);
-		kunmap_atomic(vaddr);
-		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
-			return -EFAULT;
+		if (copy_to_user(buf, vaddr + offset, csize))
+			csize = -EFAULT;
 	}
 
-	return csize;
-}
+	kunmap_local(vaddr);
 
-static int __init kdump_buf_page_init(void)
-{
-	int ret = 0;
-
-	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!kdump_buf_page) {
-		printk(KERN_WARNING "Kdump: Failed to allocate kdump buffer"
-			 " page\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
+	return csize;
 }
-arch_initcall(kdump_buf_page_init);

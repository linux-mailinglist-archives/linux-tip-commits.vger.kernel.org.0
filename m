Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EBB2FF7C8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Jan 2021 23:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAUWN4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Jan 2021 17:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbhAUWN2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Jan 2021 17:13:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A2C0613D6;
        Thu, 21 Jan 2021 14:12:47 -0800 (PST)
Date:   Thu, 21 Jan 2021 22:12:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611267165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEOf2Xra16PGUReQEhC2To0LOR9b9PUjbvcNavJS5Yg=;
        b=EmLVxGrz3KID+o3ySUwOBdQEsD1RDlqBOjVBn+pUhao0nfHOf+CIyqsVIAWLdLNdK87tky
        HA94dFi3pRmoPDXJeICSSJnz/qiZBCIDPg2b/gnLqSEYWUSJya2mCNPOCjvOUsQF3cgJAm
        J/A9gaZvIm5VCVpNdOQ0E9hv8k9lmGziCOUh0GUB3rvZV3XLh2kP9+nkdDnzXuvYQIf21x
        SbNFgU65LuTlOggylgDSnZ4XNu+SOVFhhQCY6vgBxfxEKAn6nI8a2087UOqK+r57xNs2BJ
        8K/asSZiV817QP1/whFt5PFz6qAuTEJRm+UaP9JiXwH+u8K5fi5No9VLl09PVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611267165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEOf2Xra16PGUReQEhC2To0LOR9b9PUjbvcNavJS5Yg=;
        b=LvYfFCT6ndspTYCQXcDqAYoXUJ2s7h4oWsuLvLuqPfXTmYodiZK4xGFspVc34V5xTqitJO
        D9xxpLoSWDl+n+Bw==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp2@yandex.ru>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <f3086de0babcab36f69949b5780bde851f719bc8.1611078018.git.luto@kernel.org>
References: <f3086de0babcab36f69949b5780bde851f719bc8.1611078018.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161126716483.414.1924096848671679376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8ece53ef7f428ee3f8eab936268b1a3fe2725e6b
Gitweb:        https://git.kernel.org/tip/8ece53ef7f428ee3f8eab936268b1a3fe2725e6b
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 19 Jan 2021 09:40:55 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Jan 2021 20:08:53 +01:00

x86/vm86/32: Remove VM86_SCREEN_BITMAP support

The implementation was rather buggy.  It unconditionally marked PTEs
read-only, even for VM_SHARED mappings.  I'm not sure whether this is
actually a problem, but it certainly seems unwise.  More importantly, it
released the mmap lock before flushing the TLB, which could allow a racing
CoW operation to falsely believe that the underlying memory was not
writable.

I can't find any users at all of this mechanism, so just remove it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Stas Sergeev <stsp2@yandex.ru>
Link: https://lkml.kernel.org/r/f3086de0babcab36f69949b5780bde851f719bc8.1611078018.git.luto@kernel.org
---
 arch/x86/include/asm/vm86.h      |  1 +-
 arch/x86/include/uapi/asm/vm86.h |  4 +-
 arch/x86/kernel/vm86_32.c        | 62 +++++++------------------------
 arch/x86/mm/fault.c              | 30 +---------------
 4 files changed, 16 insertions(+), 81 deletions(-)

diff --git a/arch/x86/include/asm/vm86.h b/arch/x86/include/asm/vm86.h
index 26efbec..9e8ac50 100644
--- a/arch/x86/include/asm/vm86.h
+++ b/arch/x86/include/asm/vm86.h
@@ -36,7 +36,6 @@ struct vm86 {
 	unsigned long saved_sp0;
 
 	unsigned long flags;
-	unsigned long screen_bitmap;
 	unsigned long cpu_type;
 	struct revectored_struct int_revectored;
 	struct revectored_struct int21_revectored;
diff --git a/arch/x86/include/uapi/asm/vm86.h b/arch/x86/include/uapi/asm/vm86.h
index d2ee4e3..18909b8 100644
--- a/arch/x86/include/uapi/asm/vm86.h
+++ b/arch/x86/include/uapi/asm/vm86.h
@@ -97,7 +97,7 @@ struct revectored_struct {
 struct vm86_struct {
 	struct vm86_regs regs;
 	unsigned long flags;
-	unsigned long screen_bitmap;
+	unsigned long screen_bitmap;		/* unused, preserved by vm86() */
 	unsigned long cpu_type;
 	struct revectored_struct int_revectored;
 	struct revectored_struct int21_revectored;
@@ -106,7 +106,7 @@ struct vm86_struct {
 /*
  * flags masks
  */
-#define VM86_SCREEN_BITMAP	0x0001
+#define VM86_SCREEN_BITMAP	0x0001        /* no longer supported */
 
 struct vm86plus_info_struct {
 	unsigned long force_return_for_pic:1;
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 764573d..e5a7a10 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -134,7 +134,11 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	unsafe_put_user(regs->ds, &user->regs.ds, Efault_end);
 	unsafe_put_user(regs->fs, &user->regs.fs, Efault_end);
 	unsafe_put_user(regs->gs, &user->regs.gs, Efault_end);
-	unsafe_put_user(vm86->screen_bitmap, &user->screen_bitmap, Efault_end);
+
+	/*
+	 * Don't write screen_bitmap in case some user had a value there
+	 * and expected it to remain unchanged.
+	 */
 
 	user_access_end();
 
@@ -160,49 +164,6 @@ Efault:
 	do_exit(SIGSEGV);
 }
 
-static void mark_screen_rdonly(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-	spinlock_t *ptl;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int i;
-
-	mmap_write_lock(mm);
-	pgd = pgd_offset(mm, 0xA0000);
-	if (pgd_none_or_clear_bad(pgd))
-		goto out;
-	p4d = p4d_offset(pgd, 0xA0000);
-	if (p4d_none_or_clear_bad(p4d))
-		goto out;
-	pud = pud_offset(p4d, 0xA0000);
-	if (pud_none_or_clear_bad(pud))
-		goto out;
-	pmd = pmd_offset(pud, 0xA0000);
-
-	if (pmd_trans_huge(*pmd)) {
-		vma = find_vma(mm, 0xA0000);
-		split_huge_pmd(vma, pmd, 0xA0000);
-	}
-	if (pmd_none_or_clear_bad(pmd))
-		goto out;
-	pte = pte_offset_map_lock(mm, pmd, 0xA0000, &ptl);
-	for (i = 0; i < 32; i++) {
-		if (pte_present(*pte))
-			set_pte(pte, pte_wrprotect(*pte));
-		pte++;
-	}
-	pte_unmap_unlock(pte, ptl);
-out:
-	mmap_write_unlock(mm);
-	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT, false);
-}
-
-
-
 static int do_vm86_irq_handling(int subfunction, int irqnumber);
 static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus);
 
@@ -282,6 +243,15 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 			offsetof(struct vm86_struct, int_revectored)))
 		return -EFAULT;
 
+
+	/* VM86_SCREEN_BITMAP had numerous bugs and appears to have no users. */
+	if (v.flags & VM86_SCREEN_BITMAP) {
+		char comm[TASK_COMM_LEN];
+
+		pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no longer supported\n", get_task_comm(comm, current));
+		return -EINVAL;
+	}
+
 	memset(&vm86regs, 0, sizeof(vm86regs));
 
 	vm86regs.pt.bx = v.regs.ebx;
@@ -302,7 +272,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	vm86regs.gs = v.regs.gs;
 
 	vm86->flags = v.flags;
-	vm86->screen_bitmap = v.screen_bitmap;
 	vm86->cpu_type = v.cpu_type;
 
 	if (copy_from_user(&vm86->int_revectored,
@@ -370,9 +339,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	update_task_stack(tsk);
 	preempt_enable();
 
-	if (vm86->flags & VM86_SCREEN_BITMAP)
-		mark_screen_rdonly(tsk->mm);
-
 	memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
 	return regs->ax;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f1f1b5a..106b22d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -262,25 +262,6 @@ void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 	}
 }
 
-/*
- * Did it hit the DOS screen memory VA from vm86 mode?
- */
-static inline void
-check_v8086_mode(struct pt_regs *regs, unsigned long address,
-		 struct task_struct *tsk)
-{
-#ifdef CONFIG_VM86
-	unsigned long bit;
-
-	if (!v8086_mode(regs) || !tsk->thread.vm86)
-		return;
-
-	bit = (address - 0xA0000) >> PAGE_SHIFT;
-	if (bit < 32)
-		tsk->thread.vm86->screen_bitmap |= 1 << bit;
-#endif
-}
-
 static bool low_pfn(unsigned long pfn)
 {
 	return pfn < max_low_pfn;
@@ -335,15 +316,6 @@ KERN_ERR
 "******* Disabling USB legacy in the BIOS may also help.\n";
 #endif
 
-/*
- * No vm86 mode in 64-bit mode:
- */
-static inline void
-check_v8086_mode(struct pt_regs *regs, unsigned long address,
-		 struct task_struct *tsk)
-{
-}
-
 static int bad_address(void *p)
 {
 	unsigned long dummy;
@@ -1416,8 +1388,6 @@ good_area:
 		mm_fault_error(regs, hw_error_code, address, fault);
 		return;
 	}
-
-	check_v8086_mode(regs, address, tsk);
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
 

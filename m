Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFEA316D2B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhBJRq4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:46:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33120 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhBJRqp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:46:45 -0500
Date:   Wed, 10 Feb 2021 17:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODU2rioZ76L9LXKcbA7zNdT/RoXKeLN3WJLMdjrAwMc=;
        b=kVRjYTart+jDnkFQUZ6biXKTi3ocXwSnvqaiobJzcs2LGfZDTFVSSkpVQafFTzu772b64K
        Hmp5HanKS2BJjCdekXltddATeCcZLdVEH/SzC1acZpiDEK6wDeKTVqVHsZeclPx/6mjJbB
        KSZ4Xki1966+Zh4HD0YU4rtKEqc3/md7lLWbVHe91s66utbStqUA44KKEqQZ4tUZepSahe
        SX+uddImrdsiULjClMXy6Mfjg8vFg7BBcG+/0z3M57r85iPet/jYXOu2R+R5cwuc7W9yGu
        83gKwWzNqpyh+7RZp+WNOer37RYUQ6CQcMET/gMWii2dhMH6zSUG1AbAp6TEHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODU2rioZ76L9LXKcbA7zNdT/RoXKeLN3WJLMdjrAwMc=;
        b=g/y3VgA6ST2l0k8Kj9qpeC23WBpIvlS/kNEZMqyVkovEX44Q59uhlhqCiyDGF2Z3l0mCzi
        7PjXY/gwqvrYSmCA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/{fault,efi}: Fix and rename efi_recover_from_page_fault()
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f43b1e80830dc78ed60ed8b0826f4f189254570c.1612924255.git.luto@kernel.org>
References: <f43b1e80830dc78ed60ed8b0826f4f189254570c.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915421.23325.12410595112961336936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c46f52231e79af025e2c89e889d69ec20a4c024f
Gitweb:        https://git.kernel.org/tip/c46f52231e79af025e2c89e889d69ec20a4c024f
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:46 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 18:39:23 +01:00

x86/{fault,efi}: Fix and rename efi_recover_from_page_fault()

efi_recover_from_page_fault() doesn't recover -- it does a special EFI
mini-oops.  Rename it to make it clear that it crashes.

While renaming it, I noticed a blatant bug: a page fault oops in a
different thread happening concurrently with an EFI runtime service call
would be misinterpreted as an EFI page fault.  Fix that.

This isn't quite exact. The situation could be improved by using a
special CS for calls into EFI.

 [ bp: Massage commit message and simplify in interrupt check. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/f43b1e80830dc78ed60ed8b0826f4f189254570c.1612924255.git.luto@kernel.org
---
 arch/x86/include/asm/efi.h     |  2 +-
 arch/x86/mm/fault.c            | 11 ++++++-----
 arch/x86/platform/efi/quirks.c | 16 ++++++++++++----
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c98f783..4b7706d 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -150,7 +150,7 @@ extern void __init efi_apply_memmap_quirks(void);
 extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
-extern void efi_recover_from_page_fault(unsigned long phys_addr);
+extern void efi_crash_gracefully_on_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
 
 /* kexec external ABI */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1c3054b..7b3a125 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -16,7 +16,7 @@
 #include <linux/prefetch.h>		/* prefetchw			*/
 #include <linux/context_tracking.h>	/* exception_enter(), ...	*/
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
-#include <linux/efi.h>			/* efi_recover_from_page_fault()*/
+#include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <linux/mm_types.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
@@ -25,7 +25,7 @@
 #include <asm/vsyscall.h>		/* emulate_vsyscall		*/
 #include <asm/vm86.h>			/* struct vm86			*/
 #include <asm/mmu_context.h>		/* vma_pkey()			*/
-#include <asm/efi.h>			/* efi_recover_from_page_fault()*/
+#include <asm/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <asm/desc.h>			/* store_idt(), ...		*/
 #include <asm/cpu_entry_area.h>		/* exception stack		*/
 #include <asm/pgtable_areas.h>		/* VMALLOC_START, ...		*/
@@ -701,11 +701,12 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 #endif
 
 	/*
-	 * Buggy firmware could access regions which might page fault, try to
-	 * recover from such faults.
+	 * Buggy firmware could access regions which might page fault.  If
+	 * this happens, EFI has a special OOPS path that will try to
+	 * avoid hanging the system.
 	 */
 	if (IS_ENABLED(CONFIG_EFI))
-		efi_recover_from_page_fault(address);
+		efi_crash_gracefully_on_page_fault(address);
 
 oops:
 	/*
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 5a40fe4..67d93a2 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -687,15 +687,25 @@ int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
  * @return: Returns, if the page fault is not handled. This function
  * will never return if the page fault is handled successfully.
  */
-void efi_recover_from_page_fault(unsigned long phys_addr)
+void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	/*
+	 * If we get an interrupt/NMI while processing an EFI runtime service
+	 * then this is a regular OOPS, not an EFI failure.
+	 */
+	if (in_interrupt())
+		return;
+
+	/*
 	 * Make sure that an efi runtime service caused the page fault.
+	 * READ_ONCE() because we might be OOPSing in a different thread,
+	 * and we don't want to trip KTSAN while trying to OOPS.
 	 */
-	if (efi_rts_work.efi_rts_id == EFI_NONE)
+	if (READ_ONCE(efi_rts_work.efi_rts_id) == EFI_NONE ||
+	    current_work() != &efi_rts_work.work)
 		return;
 
 	/*
@@ -747,6 +757,4 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 		set_current_state(TASK_IDLE);
 		schedule();
 	}
-
-	return;
 }

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2038FDD0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhEYJas (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 05:30:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhEYJar (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 05:30:47 -0400
Date:   Tue, 25 May 2021 09:29:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621934957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VorUMb83p4ehxumq/ebKQWsh7Nj+7zYOTsVkY5VS6tA=;
        b=syXdFbsXgFPD3NHhVBvaxyisvrxG1tSABVEWK+tB6eP8dnFgVLj4/lhacIQxrRVfN0m0lX
        HYtRXby+R7lbtKw+qhk12MHeqJsJhwWiIAhtQLFqzoVhsTrO5Z71y2DLHR5dodqP/ny3Ed
        b79qHE003kzKgNq8TxBunVXo+GH3B4jVNc85WJy0+rpNe0hvtzWO4dpU4LVevX/dP/ZyAL
        dwfmU6NED8EU8pV9huMgqvSSIGb6E91CMOBiIzaft0VRykIx7jSmz/WI+5QWzUD3a1mDyG
        ytHiRJYXKql5f+WB7AwmK+hP7DA0OQE4J2abFJovUfrROKHgSwbRQT/O4EzuQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621934957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VorUMb83p4ehxumq/ebKQWsh7Nj+7zYOTsVkY5VS6tA=;
        b=O1i/uG5Ss+zhIJLdFVNJOO3zOs2rSig4hkv86LMAwb/d2OauIGh/qMbXt1yiCI52Y2RuAW
        7i/DxmGISTEWVHBg==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/idt: Remove address argument from idt_invalidate()
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210519212154.511983-5-hpa@zytor.com>
References: <20210519212154.511983-5-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162193495637.29796.13783203759887655053.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     8ec9069a432c873e52e6f4ce1496f282a4299604
Gitweb:        https://git.kernel.org/tip/8ec9069a432c873e52e6f4ce1496f282a4299604
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 19 May 2021 14:21:50 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 May 2021 12:36:45 +02:00

x86/idt: Remove address argument from idt_invalidate()

There is no reason to specify any specific address to idt_invalidate(). It
looks mostly like an artifact of unifying code done differently by
accident. The most "sensible" address to set here is a NULL pointer -
virtual address zero, just as a visual marker.

This also makes it possible to mark the struct desc_ptr in idt_invalidate()
as static const.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210519212154.511983-5-hpa@zytor.com

---
 arch/x86/include/asm/desc.h        | 2 +-
 arch/x86/kernel/idt.c              | 5 ++---
 arch/x86/kernel/machine_kexec_32.c | 2 +-
 arch/x86/kernel/reboot.c           | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 476082a..b8429ae 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -427,6 +427,6 @@ static inline void idt_setup_early_pf(void) { }
 static inline void idt_setup_ist_traps(void) { }
 #endif
 
-extern void idt_invalidate(void *addr);
+extern void idt_invalidate(void);
 
 #endif /* _ASM_X86_DESC_H */
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index d552f17..2779f52 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -331,11 +331,10 @@ void __init idt_setup_early_handler(void)
 
 /**
  * idt_invalidate - Invalidate interrupt descriptor table
- * @addr:	The virtual address of the 'invalid' IDT
  */
-void idt_invalidate(void *addr)
+void idt_invalidate(void)
 {
-	struct desc_ptr idt = { .address = (unsigned long) addr, .size = 0 };
+	static const struct desc_ptr idt = { .address = 0, .size = 0 };
 
 	load_idt(&idt);
 }
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 64b00b0..1e34fee 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -232,7 +232,7 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	idt_invalidate(phys_to_virt(0));
+	idt_invalidate();
 	set_gdt(phys_to_virt(0), 0);
 
 	/* now call it */
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index b29657b..ebfb911 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -669,7 +669,7 @@ static void native_machine_emergency_restart(void)
 			break;
 
 		case BOOT_TRIPLE:
-			idt_invalidate(NULL);
+			idt_invalidate();
 			__asm__ __volatile__("int3");
 
 			/* We're probably dead after this, but... */

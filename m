Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7A38FDD1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhEYJas (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhEYJas (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 05:30:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DFCC061574;
        Tue, 25 May 2021 02:29:18 -0700 (PDT)
Date:   Tue, 25 May 2021 09:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621934956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+1167+yV7PYchUIxIpvCLfF5JWRF7Pj6K7YzqQ8eOo=;
        b=vUC1ou2Zx/3q43XMnFJIoBDw4VziBHrV06FygnLUusKSJddb1j6+heJ+anmchuRXMWtKyY
        oT+9T8XBMyEwg6J37HSucvuGc5RQkqwOyS5OCSKRKLdjB7eof/FV9NZpXme2KC7m0Imo37
        syem6qbRAMdH9qsYpVqvUdYqqRUOKoml5Pro65ybrkrCNwV0jM9WON6ZwZBqE6YxRVZsI9
        bFkavUXEaZgK3bxFzl9REpwfLMjeesngkvpHhLxNlu3Lq1tBSpOxiG26Srnnloz8hGPOqk
        jZUvD2h3jT7jShoCO6L3TOwkS0xsS847F8Y3BXuDE3FtPhaOuGn8Cyy8mBHKcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621934956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+1167+yV7PYchUIxIpvCLfF5JWRF7Pj6K7YzqQ8eOo=;
        b=x7YIzulZ0oU5dfywHXpN3ld+rWjVBD+TGj2swKOjQeCM1O5uhbNOjbg3Rn6uYNdPbxu6KH
        ShK7wAXRgO8hiuBA==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/kexec: Set_[gi]dt() -> native_[gi]dt_invalidate()
 in machine_kexec_*.c
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210519212154.511983-7-hpa@zytor.com>
References: <20210519212154.511983-7-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162193495525.29796.7060476140067087676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     056c52f5e824c050c58fd27ea6d717cba32239c2
Gitweb:        https://git.kernel.org/tip/056c52f5e824c050c58fd27ea6d717cba32239c2
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 19 May 2021 14:21:52 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 May 2021 12:36:45 +02:00

x86/kexec: Set_[gi]dt() -> native_[gi]dt_invalidate() in machine_kexec_*.c

These files contain private set_gdt() functions which are only used to
invalid the gdt; machine_kexec_64.c also contains a set_idt()
function to invalidate the idt.

phys_to_virt(0) *really* doesn't make any sense for creating an
invalid GDT. A NULL pointer (virtual 0) makes a lot more sense;
although neither will allow any actual memory reference, a NULL
pointer stands out more.

Replace these calls with native_[gi]dt_invalidate().

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210519212154.511983-7-hpa@zytor.com

---
 arch/x86/kernel/machine_kexec_32.c | 15 +------------
 arch/x86/kernel/machine_kexec_64.c | 33 +----------------------------
 2 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 1e34fee..1b373d7 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -23,17 +23,6 @@
 #include <asm/set_memory.h>
 #include <asm/debugreg.h>
 
-static void set_gdt(void *newgdt, __u16 limit)
-{
-	struct desc_ptr curgdt;
-
-	/* ia32 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
-
-	load_gdt(&curgdt);
-}
-
 static void load_segments(void)
 {
 #define __STR(X) #X
@@ -232,8 +221,8 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	idt_invalidate();
-	set_gdt(phys_to_virt(0), 0);
+	native_idt_invalidate();
+	native_gdt_invalidate();
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c078b0d..131f30f 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -256,35 +256,6 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	return init_transition_pgtable(image, level4p);
 }
 
-static void set_idt(void *newidt, u16 limit)
-{
-	struct desc_ptr curidt;
-
-	/* x86-64 supports unaligned loads & stores */
-	curidt.size    = limit;
-	curidt.address = (unsigned long)newidt;
-
-	__asm__ __volatile__ (
-		"lidtq %0\n"
-		: : "m" (curidt)
-		);
-};
-
-
-static void set_gdt(void *newgdt, u16 limit)
-{
-	struct desc_ptr curgdt;
-
-	/* x86-64 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
-
-	__asm__ __volatile__ (
-		"lgdtq %0\n"
-		: : "m" (curgdt)
-		);
-};
-
 static void load_segments(void)
 {
 	__asm__ __volatile__ (
@@ -379,8 +350,8 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	set_gdt(phys_to_virt(0), 0);
-	set_idt(phys_to_virt(0), 0);
+	native_idt_invalidate();
+	native_gdt_invalidate();
 
 	/* now call it */
 	image->start = relocate_kernel((unsigned long)image->head,

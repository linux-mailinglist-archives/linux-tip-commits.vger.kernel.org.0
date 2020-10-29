Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A1029EB94
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgJ2MPo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgJ2MPn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:43 -0400
Date:   Thu, 29 Oct 2020 12:15:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJKphv6fCs9TTqRnSCCYTaIOHPRKCJ9jJH5dEh7qDvQ=;
        b=0nXSZ+ZDZZXlw6OeJ3RgwclLC5UVywXpYJjHHNxKecpgl50FclCjJ4CO99gkCT9ze9Ewgz
        SGpTea76QO8p8O01mlm3Oz55r77a1SnIawaQJWwtVtAlop27Dz0h/KrbJaglMt+QYQKjOw
        ikPUPjSyhYHPjxgsDcF1uBlofIRnOOZJXWJNgKww2Aag5qFQbRp1MqKMynHUFg+lRr4tIq
        kAq4g+SUxdJIKqV4hhqeUb+VOO+HD+vo4g7B7Sit0UWJ8vuPB18Q6tqEKYuBLzKRxy9bg9
        mkkXKHFRPQwpK49v2TyPIDG0aenza4ieF3kBooOhUM1FZyTWHo0gZJw5YyiZbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJKphv6fCs9TTqRnSCCYTaIOHPRKCJ9jJH5dEh7qDvQ=;
        b=1Ybtxa2soEHigG7CKDfZmrcT3JhqkUr/GqThq2Co7pzHTDIkTFiLGdWPMGmNFVA/cHQPH4
        OGJGc5YJVc368dCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/kvm: Use msi_msg shadow structs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-17-dwmw2@infradead.org>
References: <20201024213535.443185-17-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373999.397.6388133323340153383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     485940e0e691d6d7874fe1fe3b9453c5af41aace
Gitweb:        https://git.kernel.org/tip/485940e0e691d6d7874fe1fe3b9453c5af41aace
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:26 +01:00

x86/kvm: Use msi_msg shadow structs

Use the bitfields in the x86 shadow structs instead of decomposing the
32bit value with macros.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-17-dwmw2@infradead.org

---
 arch/x86/kvm/irq_comm.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 4aa1c2e..8a4de3f 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -16,8 +16,6 @@
 
 #include <trace/events/kvm.h>
 
-#include <asm/msidef.h>
-
 #include "irq.h"
 
 #include "ioapic.h"
@@ -104,22 +102,19 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 void kvm_set_msi_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 		     struct kvm_lapic_irq *irq)
 {
-	trace_kvm_msi_set_irq(e->msi.address_lo | (kvm->arch.x2apic_format ?
-	                                     (u64)e->msi.address_hi << 32 : 0),
-	                      e->msi.data);
-
-	irq->dest_id = (e->msi.address_lo &
-			MSI_ADDR_DEST_ID_MASK) >> MSI_ADDR_DEST_ID_SHIFT;
-	if (kvm->arch.x2apic_format)
-		irq->dest_id |= MSI_ADDR_EXT_DEST_ID(e->msi.address_hi);
-	irq->vector = (e->msi.data &
-			MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
-	irq->dest_mode = kvm_lapic_irq_dest_mode(
-	    !!((1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_lo));
-	irq->trig_mode = (1 << MSI_DATA_TRIGGER_SHIFT) & e->msi.data;
-	irq->delivery_mode = e->msi.data & 0x700;
-	irq->msi_redir_hint = ((e->msi.address_lo
-		& MSI_ADDR_REDIRECTION_LOWPRI) > 0);
+	struct msi_msg msg = { .address_lo = e->msi.address_lo,
+			       .address_hi = e->msi.address_hi,
+			       .data = e->msi.data };
+
+	trace_kvm_msi_set_irq(msg.address_lo | (kvm->arch.x2apic_format ?
+			      (u64)msg.address_hi << 32 : 0), msg.data);
+
+	irq->dest_id = x86_msi_msg_get_destid(&msg, kvm->arch.x2apic_format);
+	irq->vector = msg.arch_data.vector;
+	irq->dest_mode = kvm_lapic_irq_dest_mode(msg.arch_addr_lo.dest_mode_logical);
+	irq->trig_mode = msg.arch_data.is_level;
+	irq->delivery_mode = msg.arch_data.delivery_mode << 8;
+	irq->msi_redir_hint = msg.arch_addr_lo.redirect_hint;
 	irq->level = 1;
 	irq->shorthand = APIC_DEST_NOSHORT;
 }

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E837929EBB0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgJ2MRl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:17:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJ2MPi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:38 -0400
Date:   Thu, 29 Oct 2020 12:15:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xN8Wlv7Det/D8xalhwsFwV8fedb+MVYv+Bse4gPnF/c=;
        b=BxvKB1gfq6beI2+idxdsLavlEX9caV0lk3XKpcrwtwGcAAqZYbQSnarfVPDgXjMdEuIO0V
        YpUQc23XvK+KUSef6/RI7ZzJK4nVVfG/5AS4W2aRA7s4rf9Cml98VFw7ro8BTnSpi+X4VO
        xDO6rGBFBmuOO9+K5sJuYHzvPe1/uuX2r4A7kiLLfz8JwwWGyF2dxOyNrm0V8k8XS+769n
        DJstZA5mjCXWXdq+i7YR4hmGMARRTXj9sbrm7csw/YzR5Iz34b/R6kPtq5ox50stRCi5v9
        Vv2AxXUrZl0WYaRb9Zedo8jVTGWjTlDsigMpYcsYRGZC4riG1ow6z7IKk+j0fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xN8Wlv7Det/D8xalhwsFwV8fedb+MVYv+Bse4gPnF/c=;
        b=YWdPT1ttKdE7BTzuBh7zUTMsjODzKgKFdDngW513kQC04EjSJ0NInx4FHtng9EgaQKWF1J
        pJ6klSCcGrQi0PDg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Add select() method on vector irqdomain
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-24-dwmw2@infradead.org>
References: <20201024213535.443185-24-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373567.397.14712300426508521842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     6452ea2a323b80868ce5e6d3030e4ccbeab9dc30
Gitweb:        https://git.kernel.org/tip/6452ea2a323b80868ce5e6d3030e4ccbeab9dc30
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:27 +01:00

x86/apic: Add select() method on vector irqdomain

This will be used to select the irqdomain for I/O-APIC and HPET.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-24-dwmw2@infradead.org

---
 arch/x86/include/asm/irqdomain.h |  3 ++-
 arch/x86/kernel/apic/vector.c    | 43 +++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index cd684d4..125c23b 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -12,6 +12,9 @@ enum {
 	X86_IRQ_ALLOC_LEGACY				= 0x2,
 };
 
+extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
+extern int x86_fwspec_is_hpet(struct irq_fwspec *fwspec);
+
 extern struct irq_domain *x86_vector_domain;
 
 extern void init_irq_alloc_info(struct irq_alloc_info *info,
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb2e2a2..b9b05ca 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -636,7 +636,50 @@ static void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 }
 #endif
 
+int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec)
+{
+	if (fwspec->param_count != 1)
+		return 0;
+
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+		const char *fwname = fwnode_get_name(fwspec->fwnode);
+		return fwname && !strncmp(fwname, "IO-APIC-", 8) &&
+			simple_strtol(fwname+8, NULL, 10) == fwspec->param[0];
+	}
+	return to_of_node(fwspec->fwnode) &&
+		of_device_is_compatible(to_of_node(fwspec->fwnode),
+					"intel,ce4100-ioapic");
+}
+
+int x86_fwspec_is_hpet(struct irq_fwspec *fwspec)
+{
+	if (fwspec->param_count != 1)
+		return 0;
+
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+		const char *fwname = fwnode_get_name(fwspec->fwnode);
+		return fwname && !strncmp(fwname, "HPET-MSI-", 9) &&
+			simple_strtol(fwname+9, NULL, 10) == fwspec->param[0];
+	}
+	return 0;
+}
+
+static int x86_vector_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+			     enum irq_domain_bus_token bus_token)
+{
+	/*
+	 * HPET and I/OAPIC cannot be parented in the vector domain
+	 * if IRQ remapping is enabled. APIC IDs above 15 bits are
+	 * only permitted if IRQ remapping is enabled, so check that.
+	 */
+	if (apic->apic_id_valid(32768))
+		return 0;
+
+	return x86_fwspec_is_ioapic(fwspec) || x86_fwspec_is_hpet(fwspec);
+}
+
 static const struct irq_domain_ops x86_vector_domain_ops = {
+	.select		= x86_vector_select,
 	.alloc		= x86_vector_alloc_irqs,
 	.free		= x86_vector_free_irqs,
 	.activate	= x86_vector_activate,

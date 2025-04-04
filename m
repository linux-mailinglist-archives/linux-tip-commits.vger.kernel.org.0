Return-Path: <linux-tip-commits+bounces-4671-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE09A7C272
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5996D3BA5C1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636D7215F49;
	Fri,  4 Apr 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LmarW2X5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wy8wgpQp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531C2080D2;
	Fri,  4 Apr 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788045; cv=none; b=e1379hDZc7yLVnitZJjP+1HCsFJZ1fA4vbHrC6JVMMqK0ApRpzIA2oqAccRI/Yc1VuB1ORaI1pa1a6tkwz3wUG1forkG82++daGQDhl3UDlwpN9vXp7w7BWJAkwfmU2NC6EBewCVVA/qL3cAeplVRQyCTwvNdGw+DHwsEktR+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788045; c=relaxed/simple;
	bh=PE9KO/6xAPV+wFAKPGVST5BaHa/yodSgOWHD3dbD6As=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uSWrlGzOd4U/SndRvE60mZ8upC5e0X1wXgXjUz7wcm1zFTY1201mciN01AXl8DhaPpXPva4Zn0cNbns4vHQWFeD2vPkz3HGNN4gt8cUKyLwKMIqZMtfro5lm7V3JCcOiXj1733W7BSyKjgxg+8Jz3dHMpq4S1vrpAIFJ8YxKGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LmarW2X5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wy8wgpQp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdckBKoE1HsT04DALX8OShAtf6Jm1rwt2LhJ4ijwvMw=;
	b=LmarW2X5ciiZ1OfgeDpEqLZq0OqSivfSVJ+8X6MczNYMvdkkFrSNN0UqZB9chJZrMhWWqr
	EfoLm6BbOS4SaKmlbKZPebxWFdrOzn9oTq9jVw7G7a+YjCc9i9LM9uRw+zLI1AwxpRgeRP
	hBpYSZ8aAnxdpeXC7ues9FOZ4l36QLONhi/W3C6zrEm8pudIhuiAKRS0DfMXk/CggEeIat
	BnFdqr682iHEoAyRl/W+k43PUr/7BeeRmoSkxMIaMQMwnJJcIcrSsQW5ZpC70uyIAZFFwH
	kWaztkhcGHezviQ8gTRB74pXjqa8XRo5CjFNbVfm9pJHPQAqTsu0ZX675uNpIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdckBKoE1HsT04DALX8OShAtf6Jm1rwt2LhJ4ijwvMw=;
	b=Wy8wgpQpIuGGlbSsVVPECjItbMRGdjLufqGnyFmczyeBlv/+M8irOjxEz9T76UleYJ7TpK
	xfnySiI+dgUDwMCA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] irqdomain: Rename irq_get_default_host() to
 irq_get_default_domain()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-4-jirislaby@kernel.org>
References: <20250319092951.37667-4-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378804094.31282.7997471505390003954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     ae7746fbed18ce29997da5bd7ffd983ba9a96e05
Gitweb:        https://git.kernel.org/tip/ae7746fbed18ce29997da5bd7ffd983ba9a96e05
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:28:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:45 +02:00

irqdomain: Rename irq_get_default_host() to irq_get_default_domain()

Naming interrupt domains host is confusing at best and the irqdomain code
uses both domain and host inconsistently.

Therefore rename irq_get_default_host() to irq_get_default_domain().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-4-jirislaby@kernel.org

---
 arch/mips/pci/pci-xtalk-bridge.c          | 2 +-
 arch/powerpc/kvm/book3s_hv.c              | 2 +-
 arch/powerpc/kvm/book3s_xive.c            | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 arch/powerpc/platforms/pseries/msi.c      | 2 +-
 drivers/irqchip/irq-armada-370-xp.c       | 4 ++--
 include/linux/irqdomain.h                 | 2 +-
 kernel/irq/irqdomain.c                    | 6 +++---
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index dae856f..e00c386 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -620,7 +620,7 @@ static int bridge_probe(struct platform_device *pdev)
 	if (bridge_get_partnum(virt_to_phys((void *)bd->bridge_addr), partnum))
 		return -EPROBE_DEFER; /* not available yet */
 
-	parent = irq_get_default_host();
+	parent = irq_get_default_domain();
 	if (!parent)
 		return -ENODEV;
 	fn = irq_domain_alloc_named_fwnode("BRIDGE");
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 86bff15..19f4d29 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6041,7 +6041,7 @@ static int kvmppc_set_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	 * the underlying calls, which will EOI the interrupt in real
 	 * mode, need an HW IRQ number mapped in the XICS IRQ domain.
 	 */
-	host_data = irq_domain_get_irq_data(irq_get_default_host(), host_irq);
+	host_data = irq_domain_get_irq_data(irq_get_default_domain(), host_irq);
 	irq_map->r_hwirq = (unsigned int)irqd_to_hwirq(host_data);
 
 	if (i == pimap->n_mapped)
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 1362c67..1302b5a 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1555,7 +1555,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
 	struct kvmppc_xive_src_block *sb;
 	struct kvmppc_xive_irq_state *state;
 	struct irq_data *host_data =
-		irq_domain_get_irq_data(irq_get_default_host(), host_irq);
+		irq_domain_get_irq_data(irq_get_default_domain(), host_irq);
 	unsigned int hw_irq = (unsigned int)irqd_to_hwirq(host_data);
 	u16 idx;
 	u8 prio;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d2a8e02..ae4b549 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1881,7 +1881,7 @@ static const struct irq_domain_ops pnv_irq_domain_ops = {
 static int __init pnv_msi_allocate_domains(struct pci_controller *hose, unsigned int count)
 {
 	struct pnv_phb *phb = hose->private_data;
-	struct irq_domain *parent = irq_get_default_host();
+	struct irq_domain *parent = irq_get_default_domain();
 
 	hose->fwnode = irq_domain_alloc_named_id_fwnode("PNV-MSI", phb->opal_id);
 	if (!hose->fwnode)
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index fdc2f7f..f9d8011 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -611,7 +611,7 @@ static const struct irq_domain_ops pseries_irq_domain_ops = {
 static int __pseries_msi_allocate_domains(struct pci_controller *phb,
 					  unsigned int count)
 {
-	struct irq_domain *parent = irq_get_default_host();
+	struct irq_domain *parent = irq_get_default_domain();
 
 	phb->fwnode = irq_domain_alloc_named_id_fwnode("pSeries-MSI",
 						       phb->global_number);
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 6218e5d..2aa6a51 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -564,7 +564,7 @@ static void mpic_reenable_percpu(struct mpic *mpic)
 
 static int mpic_starting_cpu(unsigned int cpu)
 {
-	struct mpic *mpic = irq_get_default_host()->host_data;
+	struct mpic *mpic = irq_get_default_domain()->host_data;
 
 	mpic_perf_init(mpic);
 	mpic_smp_cpu_init(mpic);
@@ -700,7 +700,7 @@ static void mpic_handle_cascade_irq(struct irq_desc *desc)
 
 static void __exception_irq_entry mpic_handle_irq(struct pt_regs *regs)
 {
-	struct mpic *mpic = irq_get_default_host()->host_data;
+	struct mpic *mpic = irq_get_default_domain()->host_data;
 	irq_hw_number_t i;
 	u32 irqstat;
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4b5c495..e9ab95f 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -353,7 +353,7 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 					    enum irq_domain_bus_token bus_token);
 void irq_set_default_domain(struct irq_domain *domain);
-struct irq_domain *irq_get_default_host(void);
+struct irq_domain *irq_get_default_domain(void);
 int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 			   irq_hw_number_t hwirq, int node,
 			   const struct irq_affinity_desc *affinity);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 480fdc9..9d5c865 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -590,7 +590,7 @@ void irq_set_default_domain(struct irq_domain *domain)
 EXPORT_SYMBOL_GPL(irq_set_default_domain);
 
 /**
- * irq_get_default_host() - Retrieve the "default" irq domain
+ * irq_get_default_domain() - Retrieve the "default" irq domain
  *
  * Returns: the default domain, if any.
  *
@@ -598,11 +598,11 @@ EXPORT_SYMBOL_GPL(irq_set_default_domain);
  * systems that cannot implement a firmware->fwnode mapping (which
  * both DT and ACPI provide).
  */
-struct irq_domain *irq_get_default_host(void)
+struct irq_domain *irq_get_default_domain(void)
 {
 	return irq_default_domain;
 }
-EXPORT_SYMBOL_GPL(irq_get_default_host);
+EXPORT_SYMBOL_GPL(irq_get_default_domain);
 
 static bool irq_domain_is_nomap(struct irq_domain *domain)
 {


Return-Path: <linux-tip-commits+bounces-7026-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B735C0F650
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EC9484172
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E8320A32;
	Mon, 27 Oct 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UA1RQzrj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pdob8Enc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D630AD05;
	Mon, 27 Oct 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582687; cv=none; b=m50hau8MnJbc65yRGFY8fL+fNIwuLvj6U6or31WhmMRBjrA/wZINFQVVbS89FzJ+qvfE8iBUIiHnW9OluJEe28ndtwVm/WKdyObBvQDOiBQpcLDhOuI8l7bx05UP7JZq5iGgF5FGfVBkbNwjPFoG2Mg/oYY2teE/gz/18RQgL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582687; c=relaxed/simple;
	bh=s/0floMfv2onszxCMeNNs0Iu9+YtvNYjoM1HGbUJAkQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oeikm0Ud28YEZQWjrZjudv4oKpEkfSMyYql1QgoOOPVeMCMjHqLvSmwBjeX/npu+aDZHkJTSPCfCeC3yK1WC+Ef11/8Gd1KkdklfVsGowtslpL5ia9xRnynKqJg5CU5WNq++BZesV9hyY+90hjiNVXyKe0/h5E0lT7jw9AXoDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UA1RQzrj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pdob8Enc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tM/QMafYYVvbsgGICg31uh5fs1D2fRZX3tkjyVleNrE=;
	b=UA1RQzrjz+Dh9yy87Y6EGLforSSAm0ydUzSjvUKo4FvLIMVm+gc33uOvIWvUovEB++SLPE
	TW/+2ScK5kb2cQhnthnCXnzPywa5N09txdjGhbs0KCqrhEBcbCU+KTIqZgVaGWT/AyXYRI
	Bjyrmg+/zyuMC/8KTvQc+hAKfSnSPDeXvp7tJXjXewHG+ZF2voQ9aq3sqvaBYbntP4+F9A
	dufYztSmPmFblmfbrXxAiltRZii+AoRI2BtcTFFlALowOVxb7+7mHPVkDBr/DgMzkLk8Vh
	GnC28wZM5PT3fqjk6Abmx8L4jQDh/DTX1zbsF2PEx/3dFemuv4rAwOXcAc5eow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tM/QMafYYVvbsgGICg31uh5fs1D2fRZX3tkjyVleNrE=;
	b=pdob8Enc/ebFwroY8OE6914XYRldKBKzW8HNKcRQ9pjVgdfqPUu9fEKn6F6TNzCDgwsRK0
	1k7D8D/h/JyeULCg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Add firmware info reporting interface
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-2-maz@kernel.org>
References: <20251020122944.3074811-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158268239.2601451.11267754028108675159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     87b0031f7f73dac2ebb874fc8f331a66ee3b5cbd
Gitweb:        https://git.kernel.org/tip/87b0031f7f73dac2ebb874fc8f331a66ee3=
b5cbd
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:32 +01:00

irqdomain: Add firmware info reporting interface

Add an irqdomain callback to report firmware-provided information that is
otherwise not available in a generic way. This is reported using a new data
structure (struct irq_fwspec_info).

This callback is optional and the only information that can be reported
currently is the affinity of an interrupt. However, the containing
structure is designed to be extensible, allowing other potentially relevant
information to be reported in the future.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20251020122944.3074811-2-maz@kernel.org
---
 include/linux/irqdomain.h | 27 +++++++++++++++++++++++++++
 kernel/irq/irqdomain.c    | 32 +++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4a86e6b..9d6a5e9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -44,6 +44,23 @@ struct irq_fwspec {
 	u32			param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
 };
=20
+/**
+ * struct irq_fwspec_info - firmware provided IRQ information structure
+ *
+ * @flags:		Information validity flags
+ * @cpumask:		Affinity mask for this interrupt
+ *
+ * This structure reports firmware-specific information about an
+ * interrupt. The only significant information is the affinity of a
+ * per-CPU interrupt, but this is designed to be extended as required.
+ */
+struct irq_fwspec_info {
+	unsigned long		flags;
+	const struct cpumask	*affinity;
+};
+
+#define IRQ_FWSPEC_INFO_AFFINITY_VALID	BIT(0)
+
 /* Conversion function from of_phandle_args fields to fwspec  */
 void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 			       unsigned int count, struct irq_fwspec *fwspec);
@@ -69,6 +86,9 @@ void of_phandle_args_to_fwspec(struct device_node *np, cons=
t u32 *args,
  * @translate:	Given @fwspec, decode the hardware irq number (@out_hwirq) and
  *		linux irq type value (@out_type). This is a generalised @xlate
  *		(over struct irq_fwspec) and is preferred if provided.
+ * @get_fwspec_info:
+ *		Given @fwspec, report additional firmware-provided information in
+ *		@info. Optional.
  * @debug_show:	For domains to show specific data for an interrupt in debugf=
s.
  *
  * Functions below are provided by the driver and called whenever a new mapp=
ing
@@ -96,6 +116,7 @@ struct irq_domain_ops {
 	void	(*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
 	int	(*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
 			     unsigned long *out_hwirq, unsigned int *out_type);
+	int	(*get_fwspec_info)(struct irq_fwspec *fwspec, struct irq_fwspec_info *i=
nfo);
 #endif
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 	void	(*debug_show)(struct seq_file *m, struct irq_domain *d,
@@ -602,6 +623,8 @@ void irq_domain_free_irqs_parent(struct irq_domain *domai=
n, unsigned int irq_bas
=20
 int irq_domain_disconnect_hierarchy(struct irq_domain *domain, unsigned int =
virq);
=20
+int irq_populate_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_in=
fo *info);
+
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
 	return domain->flags & IRQ_DOMAIN_FLAG_HIERARCHY;
@@ -685,6 +708,10 @@ static inline bool irq_domain_is_msi_device(struct irq_d=
omain *domain)
 	return false;
 }
=20
+static inline int irq_populate_fwspec_info(struct irq_fwspec *fwspec, struct=
 irq_fwspec_info *info)
+{
+	return -EINVAL;
+}
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
=20
 #ifdef CONFIG_GENERIC_MSI_IRQ
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dc473fa..2652c4c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -867,13 +867,9 @@ void of_phandle_args_to_fwspec(struct device_node *np, c=
onst u32 *args,
 }
 EXPORT_SYMBOL_GPL(of_phandle_args_to_fwspec);
=20
-unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
+static struct irq_domain *fwspec_to_domain(struct irq_fwspec *fwspec)
 {
 	struct irq_domain *domain;
-	struct irq_data *irq_data;
-	irq_hw_number_t hwirq;
-	unsigned int type =3D IRQ_TYPE_NONE;
-	int virq;
=20
 	if (fwspec->fwnode) {
 		domain =3D irq_find_matching_fwspec(fwspec, DOMAIN_BUS_WIRED);
@@ -883,6 +879,32 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec=
 *fwspec)
 		domain =3D irq_default_domain;
 	}
=20
+	return domain;
+}
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+int irq_populate_fwspec_info(struct irq_fwspec *fwspec, struct irq_fwspec_in=
fo *info)
+{
+	struct irq_domain *domain =3D fwspec_to_domain(fwspec);
+
+	memset(info, 0, sizeof(*info));
+
+	if (!domain || !domain->ops->get_fwspec_info)
+		return 0;
+
+	return domain->ops->get_fwspec_info(fwspec, info);
+}
+#endif
+
+unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
+{
+	unsigned int type =3D IRQ_TYPE_NONE;
+	struct irq_domain *domain;
+	struct irq_data *irq_data;
+	irq_hw_number_t hwirq;
+	int virq;
+
+	domain =3D fwspec_to_domain(fwspec);
 	if (!domain) {
 		pr_warn("no irq domain found for %s !\n",
 			of_node_full_name(to_of_node(fwspec->fwnode)));


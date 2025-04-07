Return-Path: <linux-tip-commits+bounces-4715-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABACA7D69A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694DA1884F9A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63922B5A3;
	Mon,  7 Apr 2025 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GOVnPJaF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SVnXoQYR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D622A4ED;
	Mon,  7 Apr 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011788; cv=none; b=HV9iCxay/Yzidjv9IEMT3cFZaGg0jYeskDrl/xNJbQ+JQtyqKVPaoUksMb+bm/H8Y54M+4jLfhUXnS657cS2pSZ0/8Org4PBo8r9n7A/e3nPr9ri1DnMQQM13IhUyR2PYcvlYbUqoYTtMxWJ+4rJhcgh3KRqZuNiBsc97TGtKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011788; c=relaxed/simple;
	bh=Z18tG0YYAcgDJXTbPcKni8tCL725TAMxyNNo0ZfLVrs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RoxNnHK6V0oE6m0bCcQ+7BLLKxJ7q58FoGzxR3OJXW5uAIorROsO4d6823U+FRjDQVmsTITz4tDxdNNTIlhe4u68OogFeGCg5KEmrzk6+Rp8bjB7EKaT+ItNoY7NRWBv1VPSnK04N+pB/ycQB6dyzfLYXC+gFYSG5xE43sahhng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GOVnPJaF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SVnXoQYR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apAihtZ08wt73iCQ9Naf1ARpWTV93n9IpvEywPGt470=;
	b=GOVnPJaFmcvJmwYR7CI5L0JygGu6eVFv43VD65irMdGcPkr5OyGaBZArOOX3tRwmwodJjg
	JdTJSdnTVBNla19ozowq1AbBEOwm1c2/7iRCkYP5yN96QAlinJRfjQzAfNe1awJTOjgvau
	yimEWawMBE6Zmolzpzip3gzg5SFmR6vRTbK5AW6zUkG+Hp77g+ttwOVcDF41VTZ/YpDKUH
	vvlZf3Bfwa3RFXtaLoeSv1WSi5Cvsjyc2TC6Kqfv+PLX3VQ2KRN+pVppisAtEZdQ+KLazx
	s9OZgIL06ZNGa12xm0Cliszs+PX+5k9OPfx4Tjtlw3es0CGIVimQnhkD27s0IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apAihtZ08wt73iCQ9Naf1ARpWTV93n9IpvEywPGt470=;
	b=SVnXoQYRWVfPTqS6w+LP2fBF9GJuehMv2XB1sTpR83KHfFxkpUsw7EWJ1mcmKdFKhTPG/f
	CWPaWaARuQR+ngDg==
From: "tip-bot2 for Yixun Lan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Support three-cell scheme interrupts
Cc: Yixun Lan <dlan@gentoo.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250326-04-gpio-irq-threecell-v3-1-aab006ab0e00@gentoo.org>
References: <20250326-04-gpio-irq-threecell-v3-1-aab006ab0e00@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401178220.31282.2947787410456906417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0a02e1f4a54ace747304687ced3b76d159e58914
Gitweb:        https://git.kernel.org/tip/0a02e1f4a54ace747304687ced3b76d159e58914
Author:        Yixun Lan <dlan@gentoo.org>
AuthorDate:    Wed, 26 Mar 2025 06:06:19 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:36:09 +02:00

irqdomain: Support three-cell scheme interrupts

Add new function *_twothreecell() to extend support to parse three-cell
interrupts which encoded as <instance hwirq irqflag>, the translate
function will retrieve irq number and flag from last two cells.

This API will be used in gpio irq driver which need to work with
two or three cells cases.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250326-04-gpio-irq-threecell-v3-1-aab006ab0e00@gentoo.org

---
 include/linux/irqdomain.h | 20 +++++++-------
 kernel/irq/irqdomain.c    | 56 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bb71111..df7e927 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -571,16 +571,16 @@ int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *ctrlr,
 int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type);
-
-int irq_domain_translate_twocell(struct irq_domain *d,
-				 struct irq_fwspec *fwspec,
-				 unsigned long *out_hwirq,
-				 unsigned int *out_type);
-
-int irq_domain_translate_onecell(struct irq_domain *d,
-				 struct irq_fwspec *fwspec,
-				 unsigned long *out_hwirq,
-				 unsigned int *out_type);
+int irq_domain_xlate_twothreecell(struct irq_domain *d, struct device_node *ctrlr,
+				  const u32 *intspec, unsigned int intsize,
+				  irq_hw_number_t *out_hwirq, unsigned int *out_type);
+
+int irq_domain_translate_onecell(struct irq_domain *d, struct irq_fwspec *fwspec,
+				 unsigned long *out_hwirq, unsigned int *out_type);
+int irq_domain_translate_twocell(struct irq_domain *d, struct irq_fwspec *fwspec,
+				 unsigned long *out_hwirq, unsigned int *out_type);
+int irq_domain_translate_twothreecell(struct irq_domain *d, struct irq_fwspec *fwspec,
+				      unsigned long *out_hwirq, unsigned int *out_type);
 
 /* IPI functions */
 int irq_reserve_ipi(struct irq_domain *domain, const struct cpumask *dest);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 9d5c865..b294c3f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1133,6 +1133,31 @@ int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *ctrlr,
 EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
 
 /**
+ * irq_domain_xlate_twothreecell() - Generic xlate for direct two or three cell bindings
+ * @d:		Interrupt domain involved in the translation
+ * @ctrlr:	The device tree node for the device whose interrupt is translated
+ * @intspec:	The interrupt specifier data from the device tree
+ * @intsize:	The number of entries in @intspec
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
+ *
+ * Device Tree interrupt specifier translation function for two or three
+ * cell bindings, where the cell values map directly to the hardware
+ * interrupt number and the type specifier.
+ */
+int irq_domain_xlate_twothreecell(struct irq_domain *d, struct device_node *ctrlr,
+				  const u32 *intspec, unsigned int intsize,
+				  irq_hw_number_t *out_hwirq, unsigned int *out_type)
+{
+	struct irq_fwspec fwspec;
+
+	of_phandle_args_to_fwspec(ctrlr, intspec, intsize, &fwspec);
+
+	return irq_domain_translate_twothreecell(d, &fwspec, out_hwirq, out_type);
+}
+EXPORT_SYMBOL_GPL(irq_domain_xlate_twothreecell);
+
+/**
  * irq_domain_xlate_onetwocell() - Generic xlate for one or two cell bindings
  * @d:		Interrupt domain involved in the translation
  * @ctrlr:	The device tree node for the device whose interrupt is translated
@@ -1216,6 +1241,37 @@ int irq_domain_translate_twocell(struct irq_domain *d,
 }
 EXPORT_SYMBOL_GPL(irq_domain_translate_twocell);
 
+/**
+ * irq_domain_translate_twothreecell() - Generic translate for direct two or three cell
+ * bindings
+ * @d:		Interrupt domain involved in the translation
+ * @fwspec:	The firmware interrupt specifier to translate
+ * @out_hwirq:	Pointer to storage for the hardware interrupt number
+ * @out_type:	Pointer to storage for the interrupt type
+ *
+ * Firmware interrupt specifier translation function for two or three cell
+ * specifications, where the parameter values map directly to the hardware
+ * interrupt number and the type specifier.
+ */
+int irq_domain_translate_twothreecell(struct irq_domain *d, struct irq_fwspec *fwspec,
+				      unsigned long *out_hwirq, unsigned int *out_type)
+{
+	if (fwspec->param_count == 2) {
+		*out_hwirq = fwspec->param[0];
+		*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	if (fwspec->param_count == 3) {
+		*out_hwirq = fwspec->param[1];
+		*out_type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(irq_domain_translate_twothreecell);
+
 int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 			   int node, const struct irq_affinity_desc *affinity)
 {


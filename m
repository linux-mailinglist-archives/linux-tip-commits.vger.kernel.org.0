Return-Path: <linux-tip-commits+bounces-3834-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBDA4CD76
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 22:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC3C188E5E3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204DD1EEA36;
	Mon,  3 Mar 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9OT4S/x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJ1FTm7o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CBE148316;
	Mon,  3 Mar 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037179; cv=none; b=qZqdo6kCkIGLyr6duA0U3oNLWDLTl/InUdzJ7/7fiIJgDQEgxQlufBaXunIw85H32tZaX+ov2lo6j2HEhyV76xb8ilBJetM80TTtpNChrY+P0EOcLieCUNscaMUki/6++texTlaTNNVOoDYf6qFPdvipzQJp083ck84fjy7abmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037179; c=relaxed/simple;
	bh=x5niNhbRCTaWYz4g3AUn7yIyOVIMdWY0vUrDjXRo6iA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lIXd2FNPP/YMqRHMV/a/bKYeAk6bgaCEZ0lberMjy1PLE6VgWiSHx8/YLcK8tTHeaZw2lt3jRJh/6QPFFAkmL/0n2zDnaRUbaVyzVYoKdnG9jcRZhBAgOy849+/pqmvILJW3nHDSVqD8QBgTgoGk+9pbKKy/XmyvwqQSaCgLuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9OT4S/x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJ1FTm7o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 21:26:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741037174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9URKAqKnROY8wDeSKuK/mtCv23GRVaI2chW+pe6rO4=;
	b=f9OT4S/xhhNbt69Y/z35ONra28r4rmHq3rgjBV6ekKJ71o/GODYYdkuADyp9u53fgMc88P
	7CIK3UwWh/YJGt9/aNAWdbYlRNtfa8xRqPTbpq3PPw1BDra4APajDeB+ENWF/QxETmsp2m
	xiWl5H2A6XGlxF9m8XC/D67ybI1TMLtjzZLYwV/62DamzMcGdiDbpLTxvge4j4Cztsk30W
	lx+bmiQn0A6LUOsLbxcXhbkWliQaWU4D+The69MMGRdYhXJ2PVaXeOhjQjUp5YF6Ac2VZc
	6QYo+mjaIId/XUZ4hCnEkTzn8GaLCBMPnInGfau3AYmLSWtARo8IKb+Gk9vAPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741037174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9URKAqKnROY8wDeSKuK/mtCv23GRVaI2chW+pe6rO4=;
	b=aJ1FTm7oT5q8yNkgcOtLElx/GavxLmv6Ao7O9jVA2G0tMW2Y/mOuywoKqhVjxowz08sx4+
	ZkKuCqERvOgbUCDQ==
From: "tip-bot2 for Hans Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Expose MSI message data in debugfs
Cc: Hans Zhang <18255117159@163.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250303121008.309265-1-18255117159@163.com>
References: <20250303121008.309265-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174103716846.14745.18015237712343112296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     01499ae673dc66cf5e98589648848b520f6fdfe9
Gitweb:        https://git.kernel.org/tip/01499ae673dc66cf5e98589648848b520f6fdfe9
Author:        Hans Zhang <18255117159@163.com>
AuthorDate:    Mon, 03 Mar 2025 20:10:08 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 22:16:03 +01:00

genirq/msi: Expose MSI message data in debugfs

When debugging MSI-related hardware issues (e.g. interrupt delivery
failures), developers currently need to either:

  1. Recompile the kernel with dynamic debug for tracing msi_desc.
  2. Manually read device registers through low-level tools.

Both approaches become challenging in production environments where
dynamic debugging is often disabled.

The interrupt core provides a debugfs interface for inspection of interrupt
related data, which contains the per interrupt information in the view of
the hierarchical interrupt domains. Though this interface does not expose
the MSI address/data pair, which is important information to:

  - Verify whether the MSI configuration matches the hardware expectations
  - Diagnose interrupt routing errors (e.g., mismatched destination ID)
  - Validate remapping behavior in virtualized environments

Implement the debug_show() callback for the generic MSI interrupt domains,
and use it to expose the MSI address/data pair in the per interrupt
diagnostics.

Sample output:
  address_hi: 0x00000000
  address_lo: 0xfe670040
  msg_data:   0x00000001

[ tglx: Massaged change log. Use irq_data_get_msi_desc() to avoid pointless
  	lookup. ]

Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303121008.309265-1-18255117159@163.com
---
 kernel/irq/msi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067..fa92882 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -756,12 +757,30 @@ static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec *fw
 	return info->ops->msi_translate(domain, fwspec, hwirq, type);
 }
 
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
+				  struct irq_data *irqd, int ind)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(irqd);
+
+	if (!desc)
+		return;
+
+	seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "", desc->msg.address_hi);
+	seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "", desc->msg.address_lo);
+	seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "", desc->msg.data);
+}
+#endif
+
 static const struct irq_domain_ops msi_domain_ops = {
 	.alloc		= msi_domain_alloc,
 	.free		= msi_domain_free,
 	.activate	= msi_domain_activate,
 	.deactivate	= msi_domain_deactivate,
 	.translate	= msi_domain_translate,
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	.debug_show     = msi_domain_debug_show,
+#endif
 };
 
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,


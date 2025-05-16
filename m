Return-Path: <linux-tip-commits+bounces-5634-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34343ABA447
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C954D4E1422
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB5D280A33;
	Fri, 16 May 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3VaszZu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7DDNLtrp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394C280033;
	Fri, 16 May 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424833; cv=none; b=GnSrSnFWOfg1sM/qQhQAeF2hiDWVFemCqAcbBVv/GGKjVdBvIRp+QAOqoZISiOWV1+lim8/TkjmC005J8y9cdFRuuuCswOr36Nlv4YRcszct+M8QddphYvYESGTfcNPNERixwweustcXSsOUld7dMH73b3lSrPz6UGEvJ8Ypc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424833; c=relaxed/simple;
	bh=AmjYGwnFvA1DblYZn0j6uInTGVoyQLkLG1rF0IDTJXQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Eqgz1jCofIEfCEK/gWQexyqOnMpnCw1eCB2NJUJdR7kxHVoiL3EZkaPL9fSdQjyqKasGP4z6utzVuC5D862tx+vvgpHQtzfvlARscQj80kslWp5dDOv9BJuE1QoaeGIYifKjOhU2vPv43OHSJuh6GnSqqqOIqIBZtgYx0hc06pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3VaszZu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7DDNLtrp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:47:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pn3V3wxpfeHx9eWA2HqBfQ2eIDGaR1kLmj09hqn/ORc=;
	b=F3VaszZu5sP+IvuCAPSlnOOb+z+Au8Hk4rNkrfaqBO3R4YosaBCooU0syIQNeYxEAjv8dc
	8+RAamVQ2tuuwMOpBEFekPt8eiiZowtsGIZ/IC4DpVDcMKNfLGkqMP4unCvSHIW9FeoxTX
	IlhTkZrvYDQ8Ji2Xe50vRaOH/olAOSwuG+/MAyx9+xYsrAS9QZ3BdLPB7TVrY3BXpXgoU4
	g2DAEedjfX11SWxRqxeZHBhw7RVoNQRKJm2pKQsSG14DieM7rW5su9WBAugOs+vDe9FqCM
	m3L/fE+gK6PP6PpJOSPdABtazuY0jN1n3tybe54AcTr5A4YjSkH6ppXzl/t3jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pn3V3wxpfeHx9eWA2HqBfQ2eIDGaR1kLmj09hqn/ORc=;
	b=7DDNLtrpO5GgmUsZRF3G85gFIgbATcPX9aBbQ4D2eAV2QfJ8wIL/bkcc23Zl0dmluGZVPO
	4Dns6Vv1JnSA2dDA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] genirq/msi: Add helper for creating MSI-parent irq domains
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-3-maz@kernel.org>
References: <20250513172819.2216709-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742482943.406.2170659650991803980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     e4d001b54f78769ba1a1404c2801ae95e19fd893
Gitweb:        https://git.kernel.org/tip/e4d001b54f78769ba1a1404c2801ae95e19fd893
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:32:20 +02:00

genirq/msi: Add helper for creating MSI-parent irq domains

Creating an irq domain that serves as an MSI parent requires
a substantial amount of esoteric boiler-plate code, some of
which is often provided twice (such as the bus token).

To make things a bit simpler for the unsuspecting MSI tinkerer,
provide a helper that does it for them, and serves as documentation
of what needs to be provided.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513172819.2216709-3-maz@kernel.org

---
 include/linux/msi.h |  4 ++++
 kernel/irq/msi.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index f4b94cc..6863540 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -636,6 +636,10 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
 
+struct irq_domain_info;
+struct irq_domain *msi_create_parent_irq_domain(struct irq_domain_info *info,
+						const struct msi_parent_ops *msi_parent_ops);
+
 bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 				  const struct msi_domain_template *template,
 				  unsigned int hwsize, void *domain_data,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b5559fa..4830b75 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -912,6 +912,32 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 }
 
 /**
+ * msi_create_parent_irq_domain - Create an MSI-parent interrupt domain
+ * @info:		MSI irqdomain creation info
+ * @msi_parent_ops:	MSI parent callbacks and configuration
+ *
+ * Return: pointer to the created &struct irq_domain or %NULL on failure
+ */
+struct irq_domain *msi_create_parent_irq_domain(struct irq_domain_info *info,
+						const struct msi_parent_ops *msi_parent_ops)
+{
+	struct irq_domain *d;
+
+	info->hwirq_max		= max(info->hwirq_max, info->size);
+	info->size		= info->hwirq_max;
+	info->domain_flags	|= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	info->bus_token		= msi_parent_ops->bus_select_token;
+
+	d = irq_domain_instantiate(info);
+	if (IS_ERR(d))
+		return NULL;
+
+	d->msi_parent_ops = msi_parent_ops;
+	return d;
+}
+EXPORT_SYMBOL_GPL(msi_create_parent_irq_domain);
+
+/**
  * msi_parent_init_dev_msi_info - Delegate initialization of device MSI info down
  *				  in the domain hierarchy
  * @dev:		The device for which the domain should be created


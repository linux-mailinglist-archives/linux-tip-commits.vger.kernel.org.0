Return-Path: <linux-tip-commits+bounces-5574-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A199AB99A3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7853B25A8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982523506E;
	Fri, 16 May 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xo5Hk1fk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="btmj2Y1M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56A233712;
	Fri, 16 May 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389743; cv=none; b=HbEAuVtQKetGA6mIRoVpvoZxtPzrWnIazu55hQnzz9pRTt+p3HfJDpsWutGhxu1NCxuGeCOo/P8j/ACYDeoQSMGPytcyaZdbq0uJ+ohEnahtnK4YgJSSsU4h3TSJSSh1+fnK91OisuDSx/m8EtoSoaWm/zwPSqWUXR5/Bcbcve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389743; c=relaxed/simple;
	bh=nkMhTY610Hqq5k1JGKuYFLgdGSAAieWXx0ql4FarTis=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pwy5YJaVVIc2nX3lP9PF83o82epATzHRyzbSOkmUGr0hF/flrAjgHidzrpEvRIqgiNxY+r0Ptk9+ClJmOiBT0SO0wC0HbeNROWSvyJYycUiAjz0mUjC492nljzZ6Ej6KIxkPOzfSSOvyrzInnBrMuIADXb7ob+oEwd/pBvgdXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xo5Hk1fk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=btmj2Y1M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 10:02:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747389740;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9X7xlxrN7hdzzIxndhlEqrydlKyNF/vYrutu9w7T3s=;
	b=xo5Hk1fkqPTcAZMcmy4FB7I+Kf0L7rp0weAjaSQ2q6YpdQ/TTZz8WWpkMJippyoDrfjKvS
	5qOq2MOjMbctuPog/AIAu74RZQeDCzNj1+ZA7wsIqi8ytSIb2xi4JFrRMK+mTZSTM6WQUA
	6IuqoH2cw9OrZUc3wMo1+V6dxSp7CkOsKB0f4L7BU0KVZsKzvLBcaO6sx3qpdVkqCJmi+q
	/6JkJHgrNDDSadOpa8MTJF1QuJ1vl5hPCtoCHcOckL0yMghJf5K/xJyujA0nNZq8fFycf9
	lrHwuGk/ATFa+KGQsdEWkoARo0YEWDflJ8YhcOUY6w15brk9u9dM4y9PZH8Fcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747389740;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9X7xlxrN7hdzzIxndhlEqrydlKyNF/vYrutu9w7T3s=;
	b=btmj2Y1MK6gsw17Nu+XjObtaJZgEAYTsBqV98GmBgoBhRGcPo87NJvaYSXcHe8lstgKzqd
	xMMogyZ9ZDowGLAA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Add .msi_teardown() callback as the
 reverse of .msi_prepare()
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513163144.2215824-2-maz@kernel.org>
References: <20250513163144.2215824-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738973930.406.6053911270588279381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     28026cf2dd84d961a62123b1fa941dc3c2c4a132
Gitweb:        https://git.kernel.org/tip/28026cf2dd84d961a62123b1fa941dc3c2c4a132
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 17:31:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 May 2025 12:36:41 +02:00

genirq/msi: Add .msi_teardown() callback as the reverse of .msi_prepare()

While the MSI ops do have a .msi_prepare() callback that is responsible for
setting up the relevant (usually per-device) allocation, there is no
callback reversing this setup.

For this purpose, add .msi_teardown() callback.

In order to avoid breaking the ITS driver that suffers from related issues,
do not call the callback just yet.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513163144.2215824-2-maz@kernel.org

---
 include/linux/msi.h | 10 ++++++++--
 kernel/irq/msi.c    |  8 ++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8c0ec9f..63c2300 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -423,6 +423,7 @@ struct msi_domain_info;
  * @msi_init:		Domain specific init function for MSI interrupts
  * @msi_free:		Domain specific function to free a MSI interrupts
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
+ * @msi_teardown:	Reverse the effects of @msi_prepare
  * @prepare_desc:	Optional function to prepare the allocated MSI descriptor
  *			in the domain
  * @set_desc:		Set the msi descriptor for an interrupt
@@ -438,8 +439,9 @@ struct msi_domain_info;
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
  *
- * @msi_check, @msi_prepare, @prepare_desc and @set_desc are callbacks used by the
- * msi_domain_alloc/free_irqs*() variants.
+ * @msi_check, @msi_prepare, @msi_teardown, @prepare_desc and
+ * @set_desc are callbacks used by the msi_domain_alloc/free_irqs*()
+ * variants.
  *
  * @domain_alloc_irqs, @domain_free_irqs can be used to override the
  * default allocation/free functions (__msi_domain_alloc/free_irqs). This
@@ -461,6 +463,8 @@ struct msi_domain_ops {
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
+	void		(*msi_teardown)(struct irq_domain *domain,
+					msi_alloc_info_t *arg);
 	void		(*prepare_desc)(struct irq_domain *domain, msi_alloc_info_t *arg,
 					struct msi_desc *desc);
 	void		(*set_desc)(msi_alloc_info_t *arg,
@@ -489,6 +493,7 @@ struct msi_domain_ops {
  * @handler:		Optional: associated interrupt flow handler
  * @handler_data:	Optional: associated interrupt flow handler data
  * @handler_name:	Optional: associated interrupt flow handler name
+ * @alloc_data:		Optional: associated interrupt allocation data
  * @data:		Optional: domain specific data
  */
 struct msi_domain_info {
@@ -501,6 +506,7 @@ struct msi_domain_info {
 	irq_flow_handler_t		handler;
 	void				*handler_data;
 	const char			*handler_name;
+	msi_alloc_info_t		*alloc_data;
 	void				*data;
 };
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index a8f7701..7f0dfe0 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -795,6 +795,11 @@ static int msi_domain_ops_prepare(struct irq_domain *domain, struct device *dev,
 	return 0;
 }
 
+static void msi_domain_ops_teardown(struct irq_domain *domain,
+				    msi_alloc_info_t *arg)
+{
+}
+
 static void msi_domain_ops_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
@@ -820,6 +825,7 @@ static struct msi_domain_ops msi_domain_ops_default = {
 	.get_hwirq		= msi_domain_ops_get_hwirq,
 	.msi_init		= msi_domain_ops_init,
 	.msi_prepare		= msi_domain_ops_prepare,
+	.msi_teardown		= msi_domain_ops_teardown,
 	.set_desc		= msi_domain_ops_set_desc,
 };
 
@@ -841,6 +847,8 @@ static void msi_domain_update_dom_ops(struct msi_domain_info *info)
 		ops->msi_init = msi_domain_ops_default.msi_init;
 	if (ops->msi_prepare == NULL)
 		ops->msi_prepare = msi_domain_ops_default.msi_prepare;
+	if (ops->msi_teardown == NULL)
+		ops->msi_teardown = msi_domain_ops_default.msi_teardown;
 	if (ops->set_desc == NULL)
 		ops->set_desc = msi_domain_ops_default.set_desc;
 }


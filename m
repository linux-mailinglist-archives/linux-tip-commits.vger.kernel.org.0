Return-Path: <linux-tip-commits+bounces-5994-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04266AF767E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DEA561B9C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83012EAD11;
	Thu,  3 Jul 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I31JA0fj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OyioBVlg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300882EAB6F;
	Thu,  3 Jul 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551240; cv=none; b=rXmm0llWfPyDlSwFlPXFm2Mz75xgovqdCH/DvFgK2hkjg26X1MMvRP6p2YxlsCS0xJrwcZazIAyYBBM1xqjB/V1xhs3/6xh3Tt72mE7tKkzPokufRdb6kKxlEvmSPBwHfmyVb8ojlgKn/0bk96TyrFJ5BkYn5gqAu9fCl2UiQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551240; c=relaxed/simple;
	bh=JZqgCDl8EVOfb9GdL4Fr0Pr0tWAUyS0Dj8hAhktzTXE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PlDEvWrk8mGYUJC5n4kfdFioVDdbX2Qp7AVtnhTpn0T8yhTSgJUWN0Jr6VD8+Iz7akSP6EwU3htjFrOggaHTMeRqHc2KM+TXi1pPJNtna2cmgayBbYe3LSN2GAlyiefeGXCVfDrMyG9uuiroC/2nsZK+vrR0A/Pre2/BNbWAVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I31JA0fj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OyioBVlg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uSTbjdbBRsb6VhGUHgox9MxThlHR8yFAJS49oFJMI8=;
	b=I31JA0fjE9R4CrZKzJtyvbfpBbL06U30c+pRZ0jT4mkNwXgpOZJNQARLSUbZ3xYzzlJUcO
	RfZFpETo/+5o1mC8YQnUB5ZnhDA9qsdhIzcvHMdlOT3MpiS3DbI+rQ4SZIGlUxrLRbrZZ/
	DXOng7yUgmykWANAzkmsIaCz0d2HgdE7ZSaoBXGOM6capw059KuvXAOuoNj9oln+yhfyTP
	3xRGLQmxqvQ4M5MZ6CoG64BI0uec8bczZXP3lDT5OwI5ekTtTGEyPmi6Q7nCEjZxt4N6cy
	/mSxa5i7LMDuO+cVeMkHLkxTLWePe84LVVsDfhdasd/xBQey55nF9h2BiaDS5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uSTbjdbBRsb6VhGUHgox9MxThlHR8yFAJS49oFJMI8=;
	b=OyioBVlg2kkE9W2SEw4RD1Ye+GNbKlq2OyJ7jbsxuPDCz+1B42h0eyrjWvsjOgl7c9xKmf
	4UoBbBprZaNA4IBQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/riscv-imsic: Convert to
 msi_create_parent_irq_domain() helper
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241204124549.607054-6-maz@kernel.org>
References: <20241204124549.607054-6-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123642.406.3794766003423936937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     59422904dd9855f94d00dc66598bef1bd2663894
Gitweb:        https://git.kernel.org/tip/59422904dd9855f94d00dc66598bef1bd2663894
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 26 Jun 2025 16:49:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:24 +02:00

irqchip/riscv-imsic: Convert to msi_create_parent_irq_domain() helper

Now that we have a concise helper to create an MSI parent domain,
switch the RISC-V letter soup over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/b906a38d443577de45923b335d80fc54c5638da0.1750860131.git.namcao@linutronix.de
Link: https://lore.kernel.org/all/20241204124549.607054-6-maz@kernel.org
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 1b9fbfc..74a2a28 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -307,6 +307,11 @@ static const struct msi_parent_ops imsic_msi_parent_ops = {
 
 int imsic_irqdomain_init(void)
 {
+	struct irq_domain_info info = {
+		.fwnode		= imsic->fwnode,
+		.ops		= &imsic_base_domain_ops,
+		.host_data	= imsic,
+	};
 	struct imsic_global_config *global;
 
 	if (!imsic || !imsic->fwnode) {
@@ -320,16 +325,11 @@ int imsic_irqdomain_init(void)
 	}
 
 	/* Create Base IRQ domain */
-	imsic->base_domain = irq_domain_create_tree(imsic->fwnode,
-						    &imsic_base_domain_ops, imsic);
+	imsic->base_domain = msi_create_parent_irq_domain(&info, &imsic_msi_parent_ops);
 	if (!imsic->base_domain) {
 		pr_err("%pfwP: failed to create IMSIC base domain\n", imsic->fwnode);
 		return -ENOMEM;
 	}
-	imsic->base_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	imsic->base_domain->msi_parent_ops = &imsic_msi_parent_ops;
-
-	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
 
 	global = &imsic->global;
 	pr_info("%pfwP:  hart-index-bits: %d,  guest-index-bits: %d\n",


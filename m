Return-Path: <linux-tip-commits+bounces-5436-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B500AAE11D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8929882F9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1028B4EC;
	Wed,  7 May 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdGa4163";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="idXX0bVC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782328B3FC;
	Wed,  7 May 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625460; cv=none; b=pt9cgIwZKWvNKLy0vVwnEJ9Rg/Gwiyo2GPCJjIIBjeVYY07B7Gdq4Dk/ii0wdIWX5DvleBgZ7iqipzSi1L91fyz+iJWcpu4IJ+NqEIV8O4UR8fkX6Itwd6VXYwi8gOqOpJpayEHs1guJDujO7+XrVVdvFemYfVNIwE2hS00F0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625460; c=relaxed/simple;
	bh=msWW7g1lBrPjToaUd1rIxOTgXRdzU/RV3luH6C3dN+Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hvYfIEx/fQS/e1kSWNf1LlLm/BHzYtrlwgZ3INaKU5RRm60ecziWQhwTol3hy/Gz0dTuwseEZbipS4Q8RDjK2ceEXEDnlj6iRHltfpoD8iDTx14PFJno2DmqvRD6ivKcfBdGmch27Nq/2Sgz0/VQLBWt3pSyg/NB/Lb/NlCFIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdGa4163; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=idXX0bVC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WU/Rr5GlK23KWBYVGrTsd/7j7Fw3gHG4u7sCHY9j6Po=;
	b=FdGa4163mzH0Ih31+fdlFB1oPSZ5ah6pMoPDjwoOKP+FhWCG0DxE2aVJkNEZ4NPq3vU/jc
	yp+Ny9/JayZduwOq5MBgbNfAYR6yZvO3vov5fZAKai5OFIragPb+edi9s/WAxmE9VZamC9
	NF2d0Eg+bWyM3En/5906JluGrKRmcr2/1daWPsbZJ8p+D/5LyDJtZKxdnJ6udJGl6/+QUC
	WdiGvW5pMfw+dKBJfvbIeJGa8O+th8ZMJHmPNG19DOLk6ruoAZZOdps1R0dioeRF/xckqM
	NpUyb79Sui5kDNNslNgYRFm0yrnD/0/38QuuPANyWmkUCc/sENxCmW7a/IEE5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WU/Rr5GlK23KWBYVGrTsd/7j7Fw3gHG4u7sCHY9j6Po=;
	b=idXX0bVCWo+slduyTr3EDz/m18tmh6diEslKj5vy3/ItnuVu27y14P39qalOKhTv7ZAHpI
	BFoyc+Xja+9ONUDg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] sh: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-34-jirislaby@kernel.org>
References: <20250319092951.37667-34-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545625.406.17011618054695595318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     2e38bfc2ca8c8d1796a5d1bf6cddfb88cf291334
Gitweb:        https://git.kernel.org/tip/2e38bfc2ca8c8d1796a5d1bf6cddfb88cf291334
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:40 +02:00

sh: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-34-jirislaby@kernel.org


---
 arch/sh/boards/mach-se/7343/irq.c  | 5 +++--
 arch/sh/boards/mach-se/7722/irq.c  | 2 +-
 arch/sh/boards/mach-x3proto/gpio.c | 2 +-
 drivers/sh/intc/irqdomain.c        | 5 ++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index f9f3b14..8241bde 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -47,8 +47,9 @@ static void __init se7343_domain_init(void)
 {
 	int i;
 
-	se7343_irq_domain = irq_domain_add_linear(NULL, SE7343_FPGA_IRQ_NR,
-						  &irq_domain_simple_ops, NULL);
+	se7343_irq_domain = irq_domain_create_linear(NULL, SE7343_FPGA_IRQ_NR,
+						     &irq_domain_simple_ops,
+						     NULL);
 	if (unlikely(!se7343_irq_domain)) {
 		printk("Failed to get IRQ domain\n");
 		return;
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index efa96ed..9a460a8 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -46,7 +46,7 @@ static void __init se7722_domain_init(void)
 {
 	int i;
 
-	se7722_irq_domain = irq_domain_add_linear(NULL, SE7722_FPGA_IRQ_NR,
+	se7722_irq_domain = irq_domain_create_linear(NULL, SE7722_FPGA_IRQ_NR,
 						  &irq_domain_simple_ops, NULL);
 	if (unlikely(!se7722_irq_domain)) {
 		printk("Failed to get IRQ domain\n");
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index f82d3a6..c13d51b 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -108,7 +108,7 @@ int __init x3proto_gpio_setup(void)
 	if (unlikely(ret))
 		goto err_gpio;
 
-	x3proto_irq_domain = irq_domain_add_linear(NULL, NR_BASEBOARD_GPIOS,
+	x3proto_irq_domain = irq_domain_create_linear(NULL, NR_BASEBOARD_GPIOS,
 						   &x3proto_gpio_irq_ops, NULL);
 	if (unlikely(!x3proto_irq_domain))
 		goto err_irq;
diff --git a/drivers/sh/intc/irqdomain.c b/drivers/sh/intc/irqdomain.c
index 3968f1c..ed7a570 100644
--- a/drivers/sh/intc/irqdomain.c
+++ b/drivers/sh/intc/irqdomain.c
@@ -59,10 +59,9 @@ void __init intc_irq_domain_init(struct intc_desc_int *d,
 	 * tree penalty for linear cases with non-zero hwirq bases.
 	 */
 	if (irq_base == 0 && irq_end == (irq_base + hw->nr_vectors - 1))
-		d->domain = irq_domain_add_linear(NULL, hw->nr_vectors,
-						  &intc_evt_ops, NULL);
+		d->domain = irq_domain_create_linear(NULL, hw->nr_vectors, &intc_evt_ops, NULL);
 	else
-		d->domain = irq_domain_add_tree(NULL, &intc_evt_ops, NULL);
+		d->domain = irq_domain_create_tree(NULL, &intc_evt_ops, NULL);
 
 	BUG_ON(!d->domain);
 }


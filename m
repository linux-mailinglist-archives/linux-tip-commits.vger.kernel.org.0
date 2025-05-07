Return-Path: <linux-tip-commits+bounces-5363-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A2EAAD9BE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A87998343F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE27236454;
	Wed,  7 May 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FY1+Da+q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EME0cFbp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94253235362;
	Wed,  7 May 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604699; cv=none; b=fKflHGIiUTJA2SQI+0NREHGwuCwG47PxI6lh8SZoozkDbUVU9qkew8N65QelapYg1hUdrrIY5QFutpJ2VIQHHxYlPd332q2CEqGkLGkOAxW6tTQ8ZxfxzPcM1DjhkyQsmg77IPJvACtkHGFTAUBMNyFyLquGQyLRdf3dORQ4dOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604699; c=relaxed/simple;
	bh=EAFoBx47XIH4Wfci77huexky9RtpfvlGW1ApOOp3Lqc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lCdyTmLdtl++ql+TXKMeojn4M/P7pOYoJtbW+xUHvGdpHheWnnKxOGX6MpO4xgej0l4luqElvS1wt0eap3T/G329lxIzHQM73YWqkMf7rTinxsDItMdCjMVGdKmdmsMfy6tRRZTcDRlszX/RYswKoRhN+snlW4mB5g2Lh80GDCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FY1+Da+q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EME0cFbp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZgyd7iyNMHcCGsLiuD3QYfPizeFiTMUHr+h+gL/0o4=;
	b=FY1+Da+qAiHTl5oufDftUpVMNCnzS2605Oui1Di3HnF6fpXMXpmjQur1pmB9fLYndtUC8Y
	IqbRh4TLvAqW8iT8O85Opau2a274j6aLKnP4Gn+A7E7Vmez8bsxMB8RhmKShaT5imQdx25
	U3Ah6i4YZQB+X+RquyHbbReQEGvzE0UZYMgbbzBjpVVh9KX4H2ucZaNIHRetOlMhoDg3pa
	CH22EknEhx+MpcpBHtzg1GAQ+yy78Z9s4+1jDALFedyjtSk52jSF5hHxc1c/H27PF4F6Xe
	m8U+NmNjE0waCB10Spxz1lc4lzcBRyLxalYA//DS2c0DQlX6BzJA7ZiAl6hhvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZgyd7iyNMHcCGsLiuD3QYfPizeFiTMUHr+h+gL/0o4=;
	b=EME0cFbpji7r+8CRDvsUwhcEjO5fGLRlXU/GchymTaNcDSXg0hO9O/YpoZGyO/0zzFSSxy
	DKu7ZZmvpwNm8IBQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] ARC: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-14-jirislaby@kernel.org>
References: <20250319092951.37667-14-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660469426.406.10866979434291357053.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     8afd2253df98c9d3d1baae662f51bdea17fd101e
Gitweb:        https://git.kernel.org/tip/8afd2253df98c9d3d1baae662f51bdea17fd101e
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:22 +02:00

ARC: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-14-jirislaby@kernel.org

---
 arch/arc/kernel/intc-arcv2.c   | 2 +-
 arch/arc/kernel/intc-compact.c | 5 +++--
 arch/arc/kernel/mcip.c         | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index fea29d9..809edc5 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -170,7 +170,7 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	if (parent)
 		panic("DeviceTree incore intc not a root irq controller\n");
 
-	root_domain = irq_domain_add_linear(intc, nr_cpu_irqs, &arcv2_irq_ops, NULL);
+	root_domain = irq_domain_create_linear(of_fwnode_handle(intc), nr_cpu_irqs, &arcv2_irq_ops, NULL);
 	if (!root_domain)
 		panic("root irq domain not avail\n");
 
diff --git a/arch/arc/kernel/intc-compact.c b/arch/arc/kernel/intc-compact.c
index 1d2ff1c..1b159e9 100644
--- a/arch/arc/kernel/intc-compact.c
+++ b/arch/arc/kernel/intc-compact.c
@@ -112,8 +112,9 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	if (parent)
 		panic("DeviceTree incore intc not a root irq controller\n");
 
-	root_domain = irq_domain_add_linear(intc, NR_CPU_IRQS,
-					    &arc_intc_domain_ops, NULL);
+	root_domain = irq_domain_create_linear(of_fwnode_handle(intc),
+					       NR_CPU_IRQS,
+					       &arc_intc_domain_ops, NULL);
 	if (!root_domain)
 		panic("root irq domain not avail\n");
 
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index cdd370e..02b28a9 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -391,7 +391,8 @@ idu_of_init(struct device_node *intc, struct device_node *parent)
 
 	pr_info("MCIP: IDU supports %u common irqs\n", nr_irqs);
 
-	domain = irq_domain_add_linear(intc, nr_irqs, &idu_irq_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(intc), nr_irqs,
+					  &idu_irq_ops, NULL);
 
 	/* Parent interrupts (core-intc) are already mapped */
 


Return-Path: <linux-tip-commits+bounces-1407-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D190B2B8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AF3283173
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED2C1D0F71;
	Mon, 17 Jun 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ppLtDQw3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="58eRhSam"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5B1D18ED;
	Mon, 17 Jun 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632273; cv=none; b=RnNcgbCVwewo8TjfSokNXKDdKVFo0zC98FYFxRlP5SnioDPZOOeN/sFOOAAQ7p5hUSN37b7sRXUDNFjkJ++zlz/PWLWJfxl5gdjFwWCHxdjEQf8EZnn9I7mQ9Bt+B1834sx6/DMVNz6iTPEfK+fI50KB7Mx5dycgvwa86pZ7TTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632273; c=relaxed/simple;
	bh=cZ8vxuV3/BGkug1XB5t7m+1I1274jJj2YbhlncRw6wM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TJRnJkuwjMUlGSRWRtFT0OO6QY7o6rHGaRjBsywHmw+5AVZzTJAr/eyR11jeyfx3JepdMgRQ5qzYt5fvRnTsLgasWrf/kh6XsPWZt6TDFKCqSw//A4GMhQvz/9OgGBHzVSO+sdjso3iRT2ERYCwDm42oxsnr7hhdnu7LZWIjpSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ppLtDQw3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=58eRhSam; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5v5Xcma6l1Dr44WRDZNvXKbGt23LhKjVZGhiWINTuoM=;
	b=ppLtDQw3a90v0wuxM26JjcYTi7wxCbkk6JdGW0/TnaSNt3AOxKWvEHFaIBxqJ2ZvAt2xIf
	m1yL5zBUXt4Tno9j2E+X5qBqf09KR2rYZyjzH4HZtHPttlw+jsS7qXkFGVSkN84Q2ir0et
	cTJhQQdlzPSsk4i7kMowIRrpjKdg+IQre09dVC1jOnHBTce8LrJvGfNFb11hj1eqq8qCr1
	zlZ47lhVfUQG7hws6HYptP3CwPFM4kz47zUtz36yxnDGqbNhSkdP9RHXubFQAx0sd/PfDA
	EKCSi81nUnbl4Kxbztr10mM4MVHyizuuoPi1hH4iYRd1PRwpB85mMCXLSqYizA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5v5Xcma6l1Dr44WRDZNvXKbGt23LhKjVZGhiWINTuoM=;
	b=58eRhSampNxIgfzYghBx2K5pnXF7hKhxYAc4cc7b8Y6mqTaYibyFsTme6ZzG7FNMgLlTIw
	6EabxFHoIlRB0PAQ==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] _PATCH_19_23_um_virt_pci_Use_irq_domain_instantiate_
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-20-herve.codina@bootlin.com>
References: <20240614173232.1184015-20-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226883.10875.14230756524705766057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a701f8e93b8355a0817a3b60974e8211797e0733
Gitweb:        https://git.kernel.org/tip/a701f8e93b8355a0817a3b60974e8211797e0733
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:15 +02:00

_PATCH_19_23_um_virt_pci_Use_irq_domain_instantiate_

um_pci_init() uses __irq_domain_add(). With the introduction of
irq_domain_instantiate(), __irq_domain_add() becomes obsolete.

In order to fully remove __irq_domain_add(), use directly
irq_domain_instantiate().

[ tglx: Fixup struct initializer ]

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-20-herve.codina@bootlin.com

---
 arch/um/drivers/virt-pci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7cb5034..a0883d5 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -986,6 +986,11 @@ static struct resource virt_platform_resource = {
 
 static int __init um_pci_init(void)
 {
+	struct irq_domain_info inner_domain_info = {
+		.size		= MAX_MSI_VECTORS,
+		.hwirq_max	= MAX_MSI_VECTORS,
+		.ops		= &um_pci_inner_domain_ops,
+	};
 	int err, i;
 
 	WARN_ON(logic_iomem_add_region(&virt_cfgspace_resource,
@@ -1015,11 +1020,10 @@ static int __init um_pci_init(void)
 		goto free;
 	}
 
-	um_pci_inner_domain = __irq_domain_add(um_pci_fwnode, MAX_MSI_VECTORS,
-					       MAX_MSI_VECTORS, 0,
-					       &um_pci_inner_domain_ops, NULL);
-	if (!um_pci_inner_domain) {
-		err = -ENOMEM;
+	inner_domain_info.fwnode = um_pci_fwnode;
+	um_pci_inner_domain = irq_domain_instantiate(&inner_domain_info);
+	if (IS_ERR(um_pci_inner_domain)) {
+		err = PTR_ERR(um_pci_inner_domain);
 		goto free;
 	}
 
@@ -1056,7 +1060,7 @@ static int __init um_pci_init(void)
 		goto free;
 	return 0;
 free:
-	if (um_pci_inner_domain)
+	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);


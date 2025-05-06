Return-Path: <linux-tip-commits+bounces-5311-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E97AAC613
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A964522E3F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EFF289826;
	Tue,  6 May 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUVWmaT+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3DvcTWuK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C308289355;
	Tue,  6 May 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537648; cv=none; b=hmIMbVgLr+Nx04UJ3vPRpMaxB16dFUgGfyYcCFbMyqSWdPWo3iXtdXwKZA+yTuJDV/7V+aFsLXVwNnWHkj0iHIyF/W32n5rZF8z0Z2knIvNFPWghCCufY7X/b4SVgQwZ6dsRXhN+RV5PubwU3LOt1vIWetzFHB5IroO77QaBEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537648; c=relaxed/simple;
	bh=M7mebuzFELAojl1lKRV1NWWcx8f3pooeRrvfpVp7unA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f+1z8CMi3EY9WrOXheXadaFOTUtYf0qgyxlX+1EJov9Pi2dnFb/WohBfPjI1KA1YPL8PPY28daCFyi0LYOK1IWR1fd5tIvUo9oFuqudogjwGKsCHOkRfFHoDyxdWUjZft0iElCCNUy1vtLLTkO4qP2BqP17kcyk+nC2ZamWB11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUVWmaT+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3DvcTWuK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rOvSXgpLhR4xgS/gI9nu6qDkmt+hnpP58fXGiN8yjQ=;
	b=iUVWmaT+/ITKs6Ev1I/PE4jgO299vNV68Tkhb6XE8Z17Bh/zs13MuOQFDglAUSvpiKwSJ6
	RthVMv6k9CDI0oDSMEuXW/P8DiuyX2gkLRzOHlEz9ACupzRhbrRpTwJAOCII/bpcyqPhr3
	GRkhnvgR90fFquD8rImy/8bps3z0wmz//fqXvDMcGqHB/Q2PiM3aVr9yiUJz9Q2xu1TDzI
	b/oAdnUrBHVVKO/BXRPCQ+Ub0NRxfaSSTs8b3izceh3OPLuvunns9pb34VoXqxC+US1Rl6
	pgEtltXpYPPN6zDrUIs+Q4mAFnvVIUO9CueIgxW1kbJbGkoUds8noW8Jb0Ooaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537644;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rOvSXgpLhR4xgS/gI9nu6qDkmt+hnpP58fXGiN8yjQ=;
	b=3DvcTWuKI4AChryqcmdeP6/Akhjsi8Qa1dQYCPzCslK5oEmzEfbNKqIx2OLtStlFz/UN1x
	1xN9znhT9d62gDBA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] um: Use irq_domain_create_linear() helper
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-2-jirislaby@kernel.org>
References: <20250319092951.37667-2-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653764375.406.14094940844981132372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     48199713a6a8115172534a2c4d23ec15938e8af5
Gitweb:        https://git.kernel.org/tip/48199713a6a8115172534a2c4d23ec15938e8af5
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:28:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:03 +02:00

um: Use irq_domain_create_linear() helper

um_pci_init() open-codes what the irq_domain_create_linear() helper
does already. Use the helper instead of open-coding it.

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-2-jirislaby@kernel.org
---
 arch/um/drivers/virt-pci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index b83b5a7..0fe207c 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -538,11 +538,6 @@ void um_pci_platform_device_unregister(struct um_pci_device *dev)
 
 static int __init um_pci_init(void)
 {
-	struct irq_domain_info inner_domain_info = {
-		.size		= MAX_MSI_VECTORS,
-		.hwirq_max	= MAX_MSI_VECTORS,
-		.ops		= &um_pci_inner_domain_ops,
-	};
 	int err, i;
 
 	WARN_ON(logic_iomem_add_region(&virt_cfgspace_resource,
@@ -564,10 +559,10 @@ static int __init um_pci_init(void)
 		goto free;
 	}
 
-	inner_domain_info.fwnode = um_pci_fwnode;
-	um_pci_inner_domain = irq_domain_instantiate(&inner_domain_info);
-	if (IS_ERR(um_pci_inner_domain)) {
-		err = PTR_ERR(um_pci_inner_domain);
+	um_pci_inner_domain = irq_domain_create_linear(um_pci_fwnode, MAX_MSI_VECTORS,
+						       &um_pci_inner_domain_ops, NULL);
+	if (!um_pci_inner_domain) {
+		err = -ENOMEM;
 		goto free;
 	}
 
@@ -602,7 +597,7 @@ static int __init um_pci_init(void)
 	return 0;
 
 free:
-	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
+	if (um_pci_inner_domain)
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);


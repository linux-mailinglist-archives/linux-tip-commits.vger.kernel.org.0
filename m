Return-Path: <linux-tip-commits+bounces-5301-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF54AAC5FF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE1B17BB2C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFE5288513;
	Tue,  6 May 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KGDjB6G+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tTJE+SrA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0CE2882A6;
	Tue,  6 May 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537641; cv=none; b=pTZyLlUSoxOVRR5zf2aiocKbNs+3cCndmuSmjv+uvKT3q953jMyrwfjjbDa/YSieEKJ0HP/BMx8LofQaI0Pjp21PWtMlB/yl0PBbnqxKpJr83hP5xLRWEO2N8SewPIxejq6Dsh3PpWAQFDVinkRWH6GG5qIHc9Se7CYP458fe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537641; c=relaxed/simple;
	bh=3TYnxp+G4Qz0W/JCEcdBc3o51R9WuLHZY20eIPBNLXI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zyn4oNqrtlQHP1tBoMx1oceALRuGNRtrflhbwFBGb1+pD951CXYMlGhypCQNqIPNpbSm9nPuQW/Ytj2hHyxGkgJeLkTrp7kalmp4xgqSEMST3o26y9y3hnttGqgFnzwcvvr68RaMT+9sTvWnXjJDGRk7wD5WBGjXbUfHpDT0rQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KGDjB6G+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tTJE+SrA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFsmMZXQFzWF3mjW8GcOT5/5D2q/Nz5Sp7Iu7oCuPTk=;
	b=KGDjB6G+Lx1d0rt9CqQ0jSahHky/+Y8Jv2x6mTG9zq+GXMK4vuZJ3FDxfCH9taqIFhFSrA
	Vxhw2YZfr+4uz6WVVmdWgPblD1Uj6Eu8s6vqcMZh1C++HRCN0UtrzoqdJFZtuaORGZphlN
	LJSlm/gpgsquIFpXZWDyU3Q6Mw1+dTXm7muf+AciF/4nK9FCwjB08H55ZFn765P7J8Fg0T
	IPFY/+sOp2X5vpDR9fJ3SyBNnwP+6VWe4QfMB3nFegmfRH5y0XqaVuFB2UmrzyqDqUqkre
	7aN8H1N/0mtzeymYWqJfuOJ+fbn5jKSzbxp0+I4Lyo0+QqC8CKPCYVz0vDa7Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFsmMZXQFzWF3mjW8GcOT5/5D2q/Nz5Sp7Iu7oCuPTk=;
	b=tTJE+SrA0yaB/p9lqzVcVMUhDcb+fkDVx+m8minU0rWc2UOmQ+0qMjKvFuaFQFv+wEe38U
	CNCjuxxhhHHB51AA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] EDAC/altera: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-17-jirislaby@kernel.org>
References: <20250319092951.37667-17-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653763709.406.15922468144420684854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     aeba799a19594e9fafaf7106f915e112d3f6e58b
Gitweb:        https://git.kernel.org/tip/aeba799a19594e9fafaf7106f915e112d3f6e58b
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:04 +02:00

EDAC/altera: Switch to irq_domain_create_linear()

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
Link: https://lore.kernel.org/all/20250319092951.37667-17-jirislaby@kernel.org

---
 drivers/edac/altera_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f9..47cea64 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2130,8 +2130,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
-	edac->domain = irq_domain_add_linear(pdev->dev.of_node, 64,
-					     &a10_eccmgr_ic_ops, edac);
+	edac->domain = irq_domain_create_linear(of_fwnode_handle(pdev->dev.of_node),
+						64, &a10_eccmgr_ic_ops, edac);
 	if (!edac->domain) {
 		dev_err(&pdev->dev, "Error adding IRQ domain\n");
 		return -ENOMEM;


Return-Path: <linux-tip-commits+bounces-5494-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686E2AB0175
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B5CB23655
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E32D2868B3;
	Thu,  8 May 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dUMFVvt5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GyAND9h0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75620B21F;
	Thu,  8 May 2025 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725235; cv=none; b=InofBijt3BuyJqHN3dL/SQlxuzqSCJNZw3Z/3uAB471wLWA1Bh8hkplzy/1KZY8VmCSty0IhdRbhHjplaY69geum6OciiFCRsl/KBx6NYAVDWZJGlwa3QJk2US6Gt57Beg1jlQeCHIl82QkF1QB0hAfj3vslDCSGao626Dhsfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725235; c=relaxed/simple;
	bh=Z1konojWv8bxnIxBBS6LNsNNq4m6F3O+yzUUkbVOZ2w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YI0QNlgXu5QH/nYqQi/ammoI6ttoN03geTaj6nj3wQX0B7xDWT6bevR1ZpnVsvUpgq2zwKJCE7gMkYcAjO+Lw/EgJgezVg9AZUS4B2DqccVPwIFGjDAP4LL5PC8t/piBp6tJCKUXO8TUunsJ7sThcVyYPNbSL9KvP6T38cBT5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dUMFVvt5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GyAND9h0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:27:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746725232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/4iXgm9XPEVlOc7w7CieT5wYvTfrlGDc+pF0CASN24=;
	b=dUMFVvt5EZaev4dMdWCFHWCULaCdIIsSbp6dJVi7jD2EqK0PIylSXraC+lvbOabp5bwtoO
	z5dZ70J7Dj4FDz/o2OYEo93AoTNeD8RLOfNbWuIlbTZWDP6l+tEQ/CQU2BV0X/RFIzwkwP
	3bICKmQRdhiPw+zZRaZAsFxmdUteCzZ4cwo0Dotf5Yg3xOi2cc6gvGzaSI1rLsVTcDe3SC
	Jl9WwzXrhBcu7U2zCeIElaHWALE8cQT74rDyiKNvaS7++4CAjbt70Ipmhpvi21DTix9/Oa
	wP5ZtwX/JN6aLYYoeacQO9JPtzDCIKth1SgNvYN3UoM9rWHpySXEXgqqhkHs5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746725232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/4iXgm9XPEVlOc7w7CieT5wYvTfrlGDc+pF0CASN24=;
	b=GyAND9h0Cr7X0X3VnSSZjbsJyRPwPNImbGvEIb5J1zinnL9CzENVWmZsaNzx7ly1Elexcw
	esU6RGaO2zlIH0CA==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
Cc: Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414-ep-msi-v18-3-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-3-f69b49917464@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672523121.406.3458922274949729976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     fd120c38fefd26f1e23f308141f52098c1bbfb31
Gitweb:        https://git.kernel.org/tip/fd120c38fefd26f1e23f308141f52098c1bbfb31
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Mon, 14 Apr 2025 14:30:57 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 17:49:00 +02:00

irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS

Set the IRQ_DOMAIN_FLAG_MSI_IMMUTABLE flag for ITS, as it does not change
the address/data pair after setup.

Ensure compatibility with MSI users, such as PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged. Enable PCIe endpoints to
use ITS for triggering doorbells from the PCIe Root Complex (RC) side.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250414-ep-msi-v18-3-f69b49917464@nxp.com

---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0115ad6..fd6e7c1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5140,7 +5140,7 @@ static int its_init_domain(struct its_node *its)
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 
 	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
 
 	return 0;
 }


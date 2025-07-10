Return-Path: <linux-tip-commits+bounces-6071-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3D8B00E3D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EB21C8657B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC735290092;
	Thu, 10 Jul 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31wMQMwB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0khRk/Sk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA928DF27;
	Thu, 10 Jul 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184586; cv=none; b=uBI0PgbFInD9eK/9xlelFwWOSREM+TqHGyZiGRDHoknfmBHLKbtASOqr9ugkZA9J8COi9Gt19scwRBrB60kMoE1+zNkREmG6mqXM+G/HGeDZzAE47EYui2sQT33vIHVbxY3yVIMovReWpsB45cV8J/nllCPNHtD5jOGP4ZZDVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184586; c=relaxed/simple;
	bh=QHNBja283vzdVpy070jqNyFysgvX9DvQT90Xk9Kdmfw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mu+qv25ETNoIxiAqu93/YeUCqoiLsksi92Vsen9Ibpiabga582G2Lt5gS5bpgzjfVbKIA6llhFsnXBy+vtnDmmu+UBVgP8g8uZwaaPUHmSxxr943Nar9NjdSBrapkZXfApBOhBAKcCYyTG+xZdwrUq37svLGnai+sBbKteJQ/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31wMQMwB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0khRk/Sk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 21:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752184583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUPnAwJVipvlnYGY44ZfC/0a45hH1uK/2owJhHlfmvE=;
	b=31wMQMwBHEERrSm49/OcVHRn3R2fTTSXV3DlYLHcUIASlIzu5i7bQ0e5TVcm7bQUi3pB2Z
	6BEF2FiTioJPZLb2Go4GDdlYbDokiVmIPWkcdhID8svD/naXEFtVmzEWrInnaNYFZd7ZTD
	fCvFjGX/RFX2j0mK3b0ACTd7JAgghyhlQNBodorQg1FXbKWhapcWRqwjWG76Vg69zm1DAf
	lYQUNs2IrjO4XmVUdKvpY3hV+Zn85AcMLsSwzG7NTaZssQm4QT1k7NTTMQ7zY72idgHPwf
	hA1FEGgg0jbGjr9IpwF3tmuPD8EVqX8eXMl/vR+dId4Tt23yqOREbDl45qrmKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752184583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUPnAwJVipvlnYGY44ZfC/0a45hH1uK/2owJhHlfmvE=;
	b=0khRk/SkfbRCqTVgB/JL4VGWAxjpzNClVQHl29PrYwakP13lfushRMEj6m5cP4nUnggGOi
	BZIxXDxkrsR58cDA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-msi-lib: Fix build with PCI disabled
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710080021.2303640-1-arnd@kernel.org>
References: <20250710080021.2303640-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175218458197.406.10894224254556298432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a8b289f0f2dcbadd8c207ad8f33cf7ba2b4eb088
Gitweb:        https://git.kernel.org/tip/a8b289f0f2dcbadd8c207ad8f33cf7ba2b4eb088
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 10 Jul 2025 10:00:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 10 Jul 2025 23:46:05 +02:00

irqchip/irq-msi-lib: Fix build with PCI disabled

The armada-370-xp irqchip fails in some randconfig builds because
of a missing declaration:

In file included from drivers/irqchip/irq-armada-370-xp.c:23:
include/linux/irqchip/irq-msi-lib.h:25:39: error: 'struct msi_domain_info' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]

Add a forward declaration for the msi_domain_info structure.

[ tglx: Fixed up the subsystem prefix. Is it really that hard to get right? ]

Fixes: e51b27438a10 ("irqchip: Make irq-msi-lib.h globally available")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250710080021.2303640-1-arnd@kernel.org

---
 include/linux/irqchip/irq-msi-lib.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqchip/irq-msi-lib.h b/include/linux/irqchip/irq-msi-lib.h
index dd8d1d1..224ac28 100644
--- a/include/linux/irqchip/irq-msi-lib.h
+++ b/include/linux/irqchip/irq-msi-lib.h
@@ -17,6 +17,7 @@
 
 #define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
 
+struct msi_domain_info;
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 


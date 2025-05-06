Return-Path: <linux-tip-commits+bounces-5281-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C896AAC5C6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB121C200DF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266F283FCD;
	Tue,  6 May 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONU7+XVr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ooX9u0FR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7453283689;
	Tue,  6 May 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537626; cv=none; b=Q+WTN+wHRG9j3i7cPEVR9B08OXrvo1ljJl9n+rsPopSjCUeuq68G0rzNooOrrOWtSQo4fEo5J2KdbavKDMz2Ble1xDrQ4myrRF5GJaP3QWwQRgbU6NTwz2Rf3DFCeD8p7OiYzHJZV3KYbTJx5MhsjyOYkVPXNZJXxf1WpqodDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537626; c=relaxed/simple;
	bh=CTTDQRrrdIVKNCsVDWKf2ksChjfflzmt/k3SFq0sUo4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ENb/Peunyw0qrHA2+3lK+qWCfpPMPE+cWbY+HnEE75vRbNWrdZ2dfs8OxxHOr3hx0Eli/BkqaR1Ps2xzUYdNBwsv70wksg2NgiMn2Dq64yL1L40gVZ/ZhCDBSErMynegRMaFmLjx/YGUpFPXWUJXXPnf2MUHkW2w57hI5Vfm/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONU7+XVr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ooX9u0FR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZgKjx4g1pun5A8JS1ZdQY+EfTCAGSATeWIw/9/DnTc=;
	b=ONU7+XVrW3L62xmWuADAJRj0mHEVgeGubMNyizM0kgzr4zH5Rt/ndzSN53lOMrFnqq5UpP
	zU2dMi7v0Opghl/iTcmlG00Ke94Gn0W49HmeCNMcn7St6rHvrsZGJWExeuws64yrWHLdo4
	+Jk7fseCMQyCJNeq41SD3pbNFUO292aN3b+r39kL8b1uutHrsCYu9DzQLcLMBQRDXUn/7q
	3amFrkzVu7MaAS6xX190ZNlYmOm8NFBhKi7Loy/HCZtZv6yxESO22Ry1HvPvpR/1mubeiP
	IjPInLNzs9bkyZuCbzG4AK1XND6T3e7cXqJO4fA7Re0Th1w8B/EErj/TvTsrKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZgKjx4g1pun5A8JS1ZdQY+EfTCAGSATeWIw/9/DnTc=;
	b=ooX9u0FRzb3w1rgpcRmwwg/dzzPztRXyviff0/G65zo/U5rH45bRtxQPUeAZfeaOBfbyrd
	nxoHwwXd0sOq/nBA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] sh: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-43-jirislaby@kernel.org>
References: <20250319092951.37667-43-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653762211.406.16216507066380134137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     a1babe8d24478d3bd6802daec378d4817f092cda
Gitweb:        https://git.kernel.org/tip/a1babe8d24478d3bd6802daec378d4817f092cda
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:08 +02:00

sh: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-43-jirislaby@kernel.org

---
 arch/sh/boards/mach-se/7343/irq.c | 2 +-
 arch/sh/boards/mach-se/7722/irq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 8241bde..730c01b 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -71,7 +71,7 @@ static void __init se7343_gc_init(void)
 	struct irq_chip_type *ct;
 	unsigned int irq_base;
 
-	irq_base = irq_linear_revmap(se7343_irq_domain, 0);
+	irq_base = irq_find_mapping(se7343_irq_domain, 0);
 
 	gc = irq_alloc_generic_chip(DRV_NAME, 1, irq_base, se7343_irq_regs,
 				    handle_level_irq);
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 9a460a8..49aa3a2 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -69,7 +69,7 @@ static void __init se7722_gc_init(void)
 	struct irq_chip_type *ct;
 	unsigned int irq_base;
 
-	irq_base = irq_linear_revmap(se7722_irq_domain, 0);
+	irq_base = irq_find_mapping(se7722_irq_domain, 0);
 
 	gc = irq_alloc_generic_chip(DRV_NAME, 1, irq_base, se7722_irq_regs,
 				    handle_level_irq);


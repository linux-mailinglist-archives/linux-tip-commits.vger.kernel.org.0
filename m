Return-Path: <linux-tip-commits+bounces-2135-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFA8964789
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F591F256AA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78119FA93;
	Thu, 29 Aug 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4Jo/4Tx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ds/rQhs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78291AD40E;
	Thu, 29 Aug 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940266; cv=none; b=L959iOkOscCxPUp400DRIHycOqsxx4JLE39s8Ii8Rcf76oPo15u+Tfnhtm29T3510ySeRD4xz2js4ada8rSCol5dvyOc21/2X7b5f0gpU16E9tnIub+NMjRtibbns34BiiT/iAttQov4o/p1NTaXK0lkqzIwgSc6IKwuE3QjpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940266; c=relaxed/simple;
	bh=L+qmLDm5j51gSFEzEAY/L2ocsFU/xY9DOuRHPcLHoG4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jOBFbSZ7sFLUJlYuvxyNuzTIKrJbJl+/yRSlta4E+tgUI5fDTXVrgAQO+Nf5dwf0huS0IDXkExixOFpjKuuiW/xzlQeje50QCCg4xz9zQLxBP1/A2T0dK9bqhs/duyRSftLXMra4Lu+hsI1PVq7QOgc3w1JtKCiEVQE6IuL7hyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4Jo/4Tx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ds/rQhs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Aug 2024 14:04:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724940263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIJTXF8NiWDYSUs8ZLeQ+UTdHUqcwx1xBnv79LOa0ZU=;
	b=p4Jo/4Tx7MhLbfX12m6CFxbZh0IFIMYrKb+R40uK+n9XaLMslbL7sdofYBl8ylFagNbV31
	XfDBcUsbgGp+/T7gSjv7H2bLssceT3byU3lSMVFw6hqC7O2WYIybv+y9GjxicAXVfKfVcI
	EFFgXRSMeNp+uret8xxf+7cxf6BcHyTA5s5raR0J+jeR9ZiYoksHrxH7MG7bvGpveevVr8
	dgvvRtI5YyB7QweaP99CrdeVA83DV3ZRl/zXYgMDRjpX6bd3ieIVVCFwZWGfljNeOp/mvW
	GEhLDHdPpwQRa4eJFTSjYrCZdWE4T+9mMklawQd7QQhOP95ddH8rLryAr7UBYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724940263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIJTXF8NiWDYSUs8ZLeQ+UTdHUqcwx1xBnv79LOa0ZU=;
	b=6ds/rQhsGrY2MJGolyogoG/Ndojner5+iOWdTzYJ3rOJoWvxWkSoc7k1PUFIe7MD4pvrwZ
	zYD8GoBHTAoofJBA==
From: "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/EISA: Dereference memory directly instead of
 using readl()
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2408261015270.30766@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408261015270.30766@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172494026261.2215.11601124401069203669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     a678164aadbf68d80f7ab79b8bd5cfe3711e42fa
Gitweb:        https://git.kernel.org/tip/a678164aadbf68d80f7ab79b8bd5cfe3711e42fa
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Mon, 26 Aug 2024 10:21:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Aug 2024 15:57:09 +02:00

x86/EISA: Dereference memory directly instead of using readl()

Sparse expect an __iomem pointer, but after converting the EISA probe to
memremap() the pointer is a regular memory pointer. Access it directly
instead.

[ tglx: Converted it to fix the already applied version  ]

Fixes: 80a4da05642c ("x86/EISA: Use memremap() to probe for the EISA BIOS signature")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/alpine.DEB.2.21.2408261015270.30766@angie.orcam.me.uk
---
 arch/x86/kernel/eisa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index 5a4f99a..9535a65 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -11,13 +11,13 @@
 
 static __init int eisa_bus_probe(void)
 {
-	void *p;
+	u32 *p;
 
 	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return 0;
 
 	p = memremap(0x0FFFD9, 4, MEMREMAP_WB);
-	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
+	if (p && *p == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
 		EISA_bus = 1;
 	memunmap(p);
 	return 0;


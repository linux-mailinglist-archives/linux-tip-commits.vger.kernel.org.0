Return-Path: <linux-tip-commits+bounces-5622-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B80ABA431
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3956A25A24
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F528A1C8;
	Fri, 16 May 2025 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fIUUoEio";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AzrdkONB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420728982E;
	Fri, 16 May 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424270; cv=none; b=FCvyny/+sfBYye3DoFgCSJRlM5HYzi9OWquB05ty/Df9SS8eZcYJZaPpzr2CccyQrOkQfJraSf1ND5XOSSBHIklJ/vIWhzNO98994NcJBZDyNJRYfFk9EJ2U8hFlDaxTmg0fgLfaEWg3Kq+c4neIDi/V2LYMM6vGzNnd2ca4TCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424270; c=relaxed/simple;
	bh=kqQNuBXBPsNHEIghE7wlwP3DF38el1V0Op/EUpXcDTc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vp5jl+4+A9N41r9pdqNyk7vulrcQsbG26qr0wK3A6GuThkWYps3FbDguEDFo98Lp8PijNBRZMVNYH0qoeeJ+1g1xVj78pLZ9YjMoy3raSleH+3/JEaggRc1ne1bRtOBUvQjM9kGHCm+I3bctB8xh3dlatc9sqb+Je8SQdgZ3+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fIUUoEio; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AzrdkONB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNu5zzlgs3o8W68QV+b0BFeHPBt1huWruY8IN9quA7Y=;
	b=fIUUoEio5i9UAHWH0BmZzd0cms0FDt3RaXLwXkFBzEhY0WZiC1buI8AkW/j4wxg2n9E9BX
	9DEVwWJM/AaPKQkhhG7tWOVZiI6UeRFhqVLkbqEUPuFXinZze7Ox6SLLCInsJJ32L5PINj
	xn52L8fM6Mz0DK0Hm+x65nbWBUaggNkB4YUFpB2XRi1T3zgUqYuRa6b6EVk+oY9mz4LgSg
	ANPVvPcHsatEuWlNSxYALdCNh6sD4D1fpklRwULpj1ra3QuQ+QFq2sCjnYeeSUAkUN4WOE
	uOiYeID/QgPnJ7vcFmybwpUAfATzx91niLvc+Rt9csrdBV4HixS6d4zwQ3m9aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNu5zzlgs3o8W68QV+b0BFeHPBt1huWruY8IN9quA7Y=;
	b=AzrdkONBX0qiLXeodQ8JoH/lEoLl3KJLDhFj0kMCtEWnnKPoRnmKcdg3IOgqDxw0H/aJ3O
	nOHLwCjfjs44wmBw==
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
Message-ID: <174742426576.406.2513645913631484861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     80f2405bf204c6dd5ccfad8a96ebebe818f01214
Gitweb:        https://git.kernel.org/tip/80f2405bf204c6dd5ccfad8a96ebebe818f01214
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:08 +02:00

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
 


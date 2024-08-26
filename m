Return-Path: <linux-tip-commits+bounces-2120-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3179B95F0FE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2024 14:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A651C23843
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2024 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D8189506;
	Mon, 26 Aug 2024 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="okFJKFtw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CrssHsP3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8ED189509;
	Mon, 26 Aug 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674200; cv=none; b=eG9egb3m2MmKwP2Lg+SoCNyt3dRtphJ/I2BD4TkBeCgq7ey+QbetlY/C7QEaXNyjAQ7YqSM54MPountBwcl36a3zMLwhWBCWssDEd6LXPi3hebLXxF0UdttwFcxgdzwonapXoyr1LgBs4y2tsQOt78phDNuJbFkOt9i3JtBdQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674200; c=relaxed/simple;
	bh=VoLPEo0V9JY7ZJwtxy7Y2qZ4SJgIQCnBig2lazCG50A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WkvOSjplKn3Zu1nAZV/h0ak3Fnhh+5wDI6OPZ1PA0O5Z4ZdcU5cP43gYm1E29HNEPLhzEm1Ws4n9wN7Aj9eNFTqmEuQEp9pIvyJh8hwDY6EsyuLkgBga6U1W9xvxnA75WrpYgpMXcfONE5GiapXg2sX2E8hrVLl8b2EUcwPoIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=okFJKFtw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CrssHsP3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Aug 2024 12:09:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724674197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3sTcGhLvRk1Meh2xKh6nIA6x5WZngjdgUC8xii6ZXI=;
	b=okFJKFtwTkq31xVzucoBNru+ob3oGlAmWY0XQkDSjzUOedKtzp+WJ4PMEfCJl6KswgKAPx
	YBQX+lZqKAyqm68lxgNq2/fGS/HGJnOc3qEywT3uwrHVEK8778Pa0TZrLlCCDxrwjmAEjI
	aZlFqbWye7N3vs+6CZHwk0tMkvRrxRj6m5I8Jc2CEAJuGMKa1g+xxcXLcvBeHJW7MJy6ln
	nCCVoTY1q2JQueoXd5GwU+fynx2FC8nFP83So+1tJLG/l9B1DmV/V++5RsVbBehj5XCl+3
	vuCu7SZjbuunebUxBNra48uCSAU47162bmhkD6w2NRAvoXEqhVxEg64eUT2wPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724674197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3sTcGhLvRk1Meh2xKh6nIA6x5WZngjdgUC8xii6ZXI=;
	b=CrssHsP3HFw905p6mngf9GjIl4LyQHvyWVh6OGXYGjUdZZg8mULEFRHtDSxNsLyR+lNCV1
	LY7pMdswVJvVm8BA==
From: "tip-bot2 for Jeff Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/procfs: Correctly set file permissions for
 affinity control files
Cc: Jeff Xie <jeff.xie@linux.dev>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240825131911.107119-1-jeff.xie@linux.dev>
References: <20240825131911.107119-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172467419648.2215.9140005520755593403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0b39441eaab8bedcba1129776ec85178d4d0d9fb
Gitweb:        https://git.kernel.org/tip/0b39441eaab8bedcba1129776ec85178d4d0d9fb
Author:        Jeff Xie <jeff.xie@linux.dev>
AuthorDate:    Sun, 25 Aug 2024 21:19:11 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Aug 2024 14:00:25 +02:00

genirq/procfs: Correctly set file permissions for affinity control files

The kernel already knows at the time of interrupt allocation whether
affinity of an interrupt can be controlled by userspace or not.

It still creates all related procfs control files with read/write
permissions. That's inconsistent and non-intuitive for system
administrators and tools.

Therefore set the file permissions to read-only for such interrupts.

[ tglx: Massage change log ]

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240825131911.107119-1-jeff.xie@linux.dev
---
 kernel/irq/proc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 8cccdf4..dcf8190 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -340,6 +340,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 	static DEFINE_MUTEX(register_lock);
 	void __maybe_unused *irqp = (void *)(unsigned long) irq;
 	char name [MAX_NAMELEN];
+	umode_t umode = S_IRUGO;
 
 	if (!root_irq_dir || (desc->irq_data.chip == &no_irq_chip))
 		return;
@@ -362,8 +363,11 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 		goto out_unlock;
 
 #ifdef CONFIG_SMP
+	if (irq_can_set_affinity_usr(desc->irq_data.irq))
+		umode |= S_IWUSR;
+
 	/* create /proc/irq/<irq>/smp_affinity */
-	proc_create_data("smp_affinity", 0644, desc->dir,
+	proc_create_data("smp_affinity", umode, desc->dir,
 			 &irq_affinity_proc_ops, irqp);
 
 	/* create /proc/irq/<irq>/affinity_hint */
@@ -371,7 +375,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 			irq_affinity_hint_proc_show, irqp);
 
 	/* create /proc/irq/<irq>/smp_affinity_list */
-	proc_create_data("smp_affinity_list", 0644, desc->dir,
+	proc_create_data("smp_affinity_list", umode, desc->dir,
 			 &irq_affinity_list_proc_ops, irqp);
 
 	proc_create_single_data("node", 0444, desc->dir, irq_node_proc_show,


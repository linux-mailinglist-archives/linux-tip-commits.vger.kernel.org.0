Return-Path: <linux-tip-commits+bounces-2130-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E02960748
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835FD284EBB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC776199221;
	Tue, 27 Aug 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5xIW2G4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u+ZWkE5a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CC149E0E;
	Tue, 27 Aug 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754028; cv=none; b=XCXO8CgGtKNKVcOj1Y90s2Qz5B+ho8B7yodLg3ChiD2Ojqj7zplt3m9vK5c18hwnHjSfqZepYNwAqlB/cj8iBirZjijxljnXJ0z8bJD//wYBsMWcDwh4ecXtSGB2W1wIwcpLNQGsX2L7irIXSfKoOayJ5a6y/BH/zlzFjEaLmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754028; c=relaxed/simple;
	bh=DoWiCpuV8oMJ0++4sG5IE3lnEwMLYRHxySh0HH3+phM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LKlo4ahoabP50aNmRm7CaprebXfkPfXgpq7AM+QKHpnR4tBHvb2hYHFsCdQq/gC7PuaQGtBsG/uecsaaNBl7bnHw8at8xB5/d5A19MAZKP0h4im+84EWBuiVgfRB3huNMOa8Lw+mpVHL9ZlXXaNWVG8Yv2D63cYlzMzm6wp+ynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z5xIW2G4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u+ZWkE5a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 10:20:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724754025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uOkwcGy0ztBmTHO28SLZDsPB4ULZg0WrGe+TmUilT0=;
	b=z5xIW2G4BHKDJg+71Ez5KcpjASxfqlE0ngdi6/h0h/o+m5HEqhjaY/ijgZwlc516QIqpnP
	iMr5ncIh6IruTRYsVsbvY4P7Eum/zVehBUgBW11eeoLbaPFllB5Fqj6AJ+1ZT4EdqvbMXG
	xccWIPl/BqshceG0UINeVNDOLyo07mxhbXnmJcutpmq2lYKtF5CLNGqLcdvxwJmtle/eXg
	XAnU6pjP0Pbr8SbGrCqD1xSp0OjKJHuPvCFuEK0c53pldc+j7B6d0McNp7Jh4B2NYoqjMg
	EXsb3TXJqaM1tWKcXydSWz7Lk7Ah8/544YuRPdFcPuY0YvNXtED6/1L7xwsFww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724754025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uOkwcGy0ztBmTHO28SLZDsPB4ULZg0WrGe+TmUilT0=;
	b=u+ZWkE5auBAYKEsHYH8jS2csh0zt6kd1hsXfQhDCjTVI0AgKrPH0TMVPF6iR17Z56wA3KK
	fCw5Yl1VBrvE1ZBQ==
From: "tip-bot2 for Jeff Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/procfs: Correctly set file permissions for
 affinity control files
Cc: Jeff Xie <jeff.xie@linux.dev>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240825131911.107119-1-jeff.xie@linux.dev>
References: <20240825131911.107119-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172475402445.2215.14218268958042501838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     413abc4d0f1a1a19713db34ee689609856ffea0e
Gitweb:        https://git.kernel.org/tip/413abc4d0f1a1a19713db34ee689609856ffea0e
Author:        Jeff Xie <jeff.xie@linux.dev>
AuthorDate:    Sun, 25 Aug 2024 21:19:11 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 27 Aug 2024 12:16:40 +02:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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


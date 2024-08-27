Return-Path: <linux-tip-commits+bounces-2131-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D5960979
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAAF286734
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803361A08B0;
	Tue, 27 Aug 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UErywBHC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+illMXBu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681319EECD;
	Tue, 27 Aug 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760158; cv=none; b=Lq2c5wOH3XN7+1nv+UPRt4g3nNJJsxViduwLicmkyDrvM85HlDJHHW4BIjJvwQXZEBAYqWHk3zGhGUohaRBb3zq1E8rVoaTHbyCNkFetmrInxb/WMvBf6DZ/2i2+424I7ePOecRnZrubJcJvKvOm6qGM1eW16hvR8F7K3ee2UZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760158; c=relaxed/simple;
	bh=AD5mGqmBvB4/k+W/Qk7pSdJuwT+e0SKb18X/zQKlIPo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sPz1axugOCpu/3DOm7Y6dNOT9qQTUeBI+Rry0hkP5s3GKOeFzMg3RXhogpeu8LvC0vXddlaD2sluVxZdal7ISKngNR8Y8kZJ//6Eqf+2coX7C0jT6ljKF04Xx3GxIFUnKcz9FPw6j6+RnfJ92VgtQyi52fytFUqqSf4j9i5d/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UErywBHC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+illMXBu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 12:02:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724760154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWaA6AdnBjlmaHmQIhCpsOxuHXwZBTf31kKBuAP4E1Y=;
	b=UErywBHCST4R8gkn+Nwiy1FnvPGu2Su+ZseASuMAaC7yIO1DL7oLeDpdp0fsWIS41vbBGD
	OIESfZK/oahylEq7Cfv125OiNQvKN1Z6/fVYOn5Qr9cHgbi+UebbwX9+pi611Lz18CTDew
	j56KFovgOuBibRt82mTCDjejA+WpN5cAyexkgwUf0D/UxibUHjTCM0wDxPiwq2bIHjvTih
	Ctmx45kH5OrhwsIGOL+HWLlDNp6o+DE//e/1sXF4QmQ7YFOtfyAbbE1q7n1AAC0sNkupbi
	3xnVnG7h263BKrvfIGnAodAmaAavQj3eGRkO/JBv0rmiwUPfAAlEEu+OZassdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724760154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWaA6AdnBjlmaHmQIhCpsOxuHXwZBTf31kKBuAP4E1Y=;
	b=+illMXBuPmZ/zwG0nxho6WBmfToH1SRSjIqJ9www5cInFjnEgcp8IQOQ69u7cQWcWbsaYM
	NROr0bvQzgjPNnCg==
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
Message-ID: <172476015394.2215.3482620775920965712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     92f9d825b12fa3f6c14b42405489880d0694c96f
Gitweb:        https://git.kernel.org/tip/92f9d825b12fa3f6c14b42405489880d0694c96f
Author:        Jeff Xie <jeff.xie@linux.dev>
AuthorDate:    Sun, 25 Aug 2024 21:19:11 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Aug 2024 13:54:15 +02:00

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


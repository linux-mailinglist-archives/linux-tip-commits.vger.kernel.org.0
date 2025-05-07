Return-Path: <linux-tip-commits+bounces-5428-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411A1AAE10E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2B31BC8248
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263DA28A3EF;
	Wed,  7 May 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qgc3gFNi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="79e3FESa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AB289E1F;
	Wed,  7 May 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625454; cv=none; b=hXABAzQiO1j+o9wWIBr41fwFW+i4hW8ouHYIfMD2eHgCl52GOTMhupaGZs595bR3E4iF9LhEdJFIhejqRf9EeJ7rpqs2xl1ZGncpZBjyaM2PLjV4g9ZdC8IxiMm6SpZ6jGEbkq31hugfYoDpVTe99Yja9TUGBKQnxYUrnKBPjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625454; c=relaxed/simple;
	bh=PdziXW2bVblGGzokn331COXPFnDGmWlZGlBf7TXTHT8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N6herlOajpA1t9QIS7mc1kuDBt79A/gy1l6amippnr4z1b4awdTUFnehxvZjfloGsdTyHllsnA/grzol9YCetIfqupRE58Ll0Wqj4A5vhqGP1QV1njjc2epUWJx0SO5YkOm+hdx222E2mYnsMO9dZX5bAV2/POHiMj2YSbKiP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qgc3gFNi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=79e3FESa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zaQpulAjb7cQsD04zq7Lt8C8JGLmty3HA5++sMdkMk=;
	b=Qgc3gFNiz46mHeiAhlY5jTWwBScsO5IpefeXFd3qaKt3XhT7WAay9sKZFGxe3IKMgcuujH
	Y9+rGeUe9Sgjr1GgryV2PDX2P0GrA6Hv2OdoQZ89cq9KQEbnmQ3EFxZ63ib5egl2FUzyy5
	jKVREYATkoSIq9SJsm6W3U36tUZtLmRkPlunwbw0fUQ4pZM17KJ6ciVv+HWMoBlnfR3FsJ
	g2ju6piAQrO01S2pPn6P/s9TEmKhFEvkbRST7iWKBS4Ht4ztM86E3e9F7GD4mapVkvtDtc
	xxuyMi2H19i/J9tOHV9sZ2/aLcwg5VwlRVU8gJbFoPfVdKEERhgXjfkEyq65hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zaQpulAjb7cQsD04zq7Lt8C8JGLmty3HA5++sMdkMk=;
	b=79e3FESaDkQdBGRq3s43ZkOr3RVYHWfXytuXSU1rhxqyYsfqiz0VHbfImVw3x1h+j+9+hQ
	sJ6QSICEBHA6KJBg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] irqchip/armada-370-xp: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-47-jirislaby@kernel.org>
References: <20250319092951.37667-47-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545008.406.2119772682259614681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     3a6a7c4537e61e0e4b922f2a5b4f6bcd820c87c1
Gitweb:        https://git.kernel.org/tip/3a6a7c4537e61e0e4b922f2a5b4f6bcd820c87c1
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:41 +02:00

irqchip/armada-370-xp: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-47-jirislaby@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index e516129..67b672a 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -546,7 +546,7 @@ static void mpic_reenable_percpu(struct mpic *mpic)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i = 0; i < MPIC_PER_CPU_IRQS_NR; i++) {
-		unsigned int virq = irq_linear_revmap(mpic->domain, i);
+		unsigned int virq = irq_find_mapping(mpic->domain, i);
 		struct irq_data *d;
 
 		if (!virq || !irq_percpu_is_enabled(virq))
@@ -740,7 +740,7 @@ static void mpic_resume(void)
 
 	/* Re-enable interrupts */
 	for (irq_hw_number_t i = 0; i < mpic->domain->hwirq_max; i++) {
-		unsigned int virq = irq_linear_revmap(mpic->domain, i);
+		unsigned int virq = irq_find_mapping(mpic->domain, i);
 		struct irq_data *d;
 
 		if (!virq)


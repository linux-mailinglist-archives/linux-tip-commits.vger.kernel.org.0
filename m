Return-Path: <linux-tip-commits+bounces-5840-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AAAD8CF7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C43189D594
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D971482F2;
	Fri, 13 Jun 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWtTJ5dw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rXUcGO+d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D72F22;
	Fri, 13 Jun 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820553; cv=none; b=WxCtotjdig2/sX3W1RRMbhBwDyW3/mUAUtwq1lY7b3vuTWRaxxU9G8EBdttzNw1Mp0wMTAlPChVUR1MCTyZb713yAFvxSIEoOXC5YONy9/fMYftFdzQqN60hTPhkuyMDuw1KG94wwipgCABE/E/BQiDPa0CjOqy2etOXZ6xOxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820553; c=relaxed/simple;
	bh=obrbZwAwISKmUGgzZ8xbbLbeafL3y18u9ytG1/D2M10=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XKQ66YwYBUwHYHej1boqwvc9gcseglUQ3HlWHnNBgljSdLTHdDa1dmWehJEqqhEJHUQH/2fkawaQLAqD2h5kzYLQ6qsUehtMoAfxvKwUsSbX4QL1qkcvyrKAD2NW/kMlp3RXNVztBi3fL+hBaO29mdCzPx1HeGAy+MKjQc3osVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWtTJ5dw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rXUcGO+d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 13:15:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749820550;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWqRVRBJjUU47KItwBhCFAOZFZEIc/vfrnUzIE0TYFE=;
	b=jWtTJ5dwnc08FDpObK/hQt4Muw+duKucgjlqkP6ZRH+yy1LzkyT19D8FRTY96RX7WseW9P
	zoh8u1IxiSbygzRneVakI0LlMAtW3oT2scp3AiQtf7TfGQRRuZLEgMwxTpPsXy1aJTNZdx
	3hw9qberBvuJyj+571eSus6kj/Ky/PdcWrk6uWv29/ThtSPBDX4Pi6OAZwp3xUICF4v9kj
	RLoljDGLV7Sc57MqdvFGkq21ZN8j3beMZwhC6jWpWD5iTOB5OGlLbqYrGumt80RO5rlgIo
	jTkG+vED83ebq4O4m8SxsIHqrDJX6uovEW3A/lE98i7zMYfTTAHqZb4n/BdG9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749820550;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWqRVRBJjUU47KItwBhCFAOZFZEIc/vfrnUzIE0TYFE=;
	b=rXUcGO+dEWtlFhZcnkEwuNwOhhgVUrRfP6TZt+XnZl54AcX+87J+3Xp2e7SPAeGARLC4y1
	9qUrpV59+48e+8AA==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/cpuhotplug: Rebalance managed interrupts
 across multi-CPU hotplug
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250612183303.3433234-2-briannorris@chromium.org>
References: <20250612183303.3433234-2-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174982054908.406.13897114312168103744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     2b32fc8ff08deac3aa509f321a28e21b1eea5525
Gitweb:        https://git.kernel.org/tip/2b32fc8ff08deac3aa509f321a28e21b1eea5525
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Thu, 12 Jun 2025 11:32:51 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Jun 2025 15:13:35 +02:00

genirq/cpuhotplug: Rebalance managed interrupts across multi-CPU hotplug

Commit 788019eb559f ("genirq: Retain disable depth for managed interrupts
across CPU hotplug") intended to only decrement the disable depth once per
managed shutdown, but instead it decrements for each CPU hotplug in the
affinity mask, until its depth reaches a point where it finally gets
re-started.

For example, consider:

1. Interrupt is affine to CPU {M,N}
2. disable_irq() -> depth is 1
3. CPU M goes offline -> interrupt migrates to CPU N / depth is still 1
4. CPU N goes offline -> irq_shutdown() / depth is 2
5. CPU N goes online
    -> irq_restore_affinity_of_irq()
       -> irqd_is_managed_and_shutdown()==true
          -> irq_startup_managed() -> depth is 1
6. CPU M goes online
    -> irq_restore_affinity_of_irq()
       -> irqd_is_managed_and_shutdown()==true
          -> irq_startup_managed() -> depth is 0
          *** BUG: driver expects the interrupt is still disabled ***
             -> irq_startup() -> irqd_clr_managed_shutdown()
7. enable_irq() -> depth underflow / unbalanced enable_irq() warning

This should clear the managed-shutdown flag at step 6, so that further
hotplugs don't cause further imbalance.

Note: It might be cleaner to also remove the irqd_clr_managed_shutdown()
invocation from __irq_startup_managed(). But this is currently not possible
because of irq_update_affinity_desc() as it sets IRQD_MANAGED_SHUTDOWN and
expects irq_startup() to clear it.

Fixes: 788019eb559f ("genirq: Retain disable depth for managed interrupts across CPU hotplug")
Reported-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Link: https://lore.kernel.org/all/20250612183303.3433234-2-briannorris@chromium.org
---
 kernel/irq/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b0e0a73..2b27400 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -205,6 +205,14 @@ __irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
 
 void irq_startup_managed(struct irq_desc *desc)
 {
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+
+	/*
+	 * Clear managed-shutdown flag, so we don't repeat managed-startup for
+	 * multiple hotplugs, and cause imbalanced disable depth.
+	 */
+	irqd_clr_managed_shutdown(d);
+
 	/*
 	 * Only start it up when the disable depth is 1, so that a disable,
 	 * hotunplug, hotplug sequence does not end up enabling it during


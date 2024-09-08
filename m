Return-Path: <linux-tip-commits+bounces-2203-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE8970806
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352E81C21225
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD38814C5BA;
	Sun,  8 Sep 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRfUbVlr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PWAX2uI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CE219ED;
	Sun,  8 Sep 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804917; cv=none; b=L8kxd8l/gHa2tpqVd2bK9RxNflJAjEb/0j3i0UEgV1GTBAelw2ZI/K1c93QUFzLXnA+669jeef2wpjnrhhOBfjSwL7dDOL3bs5+fgqb1l4CbG6E6vdZEvJ5HbriPepwlTtMXug5/Bzgz8ky55F60uLwbSL5ZDvlKJ6WMF87itGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804917; c=relaxed/simple;
	bh=FnzT2L0MnjoAi9abjjtYGkuUpQ+CYWZxazaFq+RYge4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=suf4JcIFc3r5qBYZ4id/wb0pOh6bOt2RvQp3wbPrJusbnSIfz/ocuTmrMp5j7YOgEVGTfnDDoUak7GBDsJs5KzHS4uwGnVu/eA36t+GdDCLlzvpX+IRPbEbgIXzx/yPHGwg8rWyquru7nJQBJtMq3FMqvOLyIfVv2Qrh9cKy0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRfUbVlr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PWAX2uI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Sep 2024 14:15:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725804914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy7elxVlvN2z/M7W4vL0KZydNngL99Q5Y8kTY2HFiWw=;
	b=HRfUbVlrZoVpljhotSKG+Dl75oymaK2xUEJ/jpj3V4rOhXCcTIovVTGXvABozXakZsIZeD
	BmkLXxyF/WgzFT2szqtiqNsgNwQvEifqYa4F2bZajJjO3BqGJOuW07tYR0Xd/gKA9Oq2GI
	BJmmysAdvZpwDrGBHfPrNanF+YwT/HU5SY4+S1cjtVxNhirUcITJPhY4G83CripsEPlGgA
	EFGsU1eUt/sW+Z6I88KC4bDHrJJbnR1q210peoEAFxjVd4FYczsry1lTfw1BYHyYAsyemr
	LUMjhUd53V8/kgXnUiGA+CTthxKr7VOmjcwmRnLmjp2zXAAfgA3A75xYGkGiUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725804914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy7elxVlvN2z/M7W4vL0KZydNngL99Q5Y8kTY2HFiWw=;
	b=0PWAX2uIHR+eGQKxQX+o6wbCSbFljaUfXgvW+xQYLze43j60o0XO5/aOjm+XNwn1aMB60K
	G3FQos3EAfxykFDQ==
From: "tip-bot2 for Costa Shulyupin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Use cpumask_intersects()
Cc: Costa Shulyupin <costa.shul@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240906170142.1135207-1-costa.shul@redhat.com>
References: <20240906170142.1135207-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172580491392.2215.8286128466229905799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a6fe30d1e3657991c832702cecb44576128d7fa3
Gitweb:        https://git.kernel.org/tip/a6fe30d1e3657991c832702cecb44576128d7fa3
Author:        Costa Shulyupin <costa.shul@redhat.com>
AuthorDate:    Fri, 06 Sep 2024 20:01:40 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Sep 2024 16:06:51 +02:00

genirq: Use cpumask_intersects()

Replace `cpumask_any_and(a, b) >= nr_cpu_ids` and `cpumask_any_and(a, b) <
nr_cpu_ids` with the more readable `!cpumask_intersects(a, b)` and
`cpumask_intersects(a, b)`

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240906170142.1135207-1-costa.shul@redhat.com

---
 kernel/irq/chip.c      | 2 +-
 kernel/irq/migration.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0b..271e913 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -198,7 +198,7 @@ __irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
 
 	irqd_clr_managed_shutdown(d);
 
-	if (cpumask_any_and(aff, cpu_online_mask) >= nr_cpu_ids) {
+	if (!cpumask_intersects(aff, cpu_online_mask)) {
 		/*
 		 * Catch code which fiddles with enable_irq() on a managed
 		 * and potentially shutdown IRQ. Chained interrupt
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 61ca924..eb150af 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -26,7 +26,7 @@ bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear)
 	 * The outgoing CPU might be the last online target in a pending
 	 * interrupt move. If that's the case clear the pending move bit.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) >= nr_cpu_ids) {
+	if (!cpumask_intersects(desc->pending_mask, cpu_online_mask)) {
 		irqd_clr_move_pending(data);
 		return false;
 	}
@@ -74,7 +74,7 @@ void irq_move_masked_irq(struct irq_data *idata)
 	 * For correct operation this depends on the caller
 	 * masking the irqs.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids) {
+	if (cpumask_intersects(desc->pending_mask, cpu_online_mask)) {
 		int ret;
 
 		ret = irq_do_set_affinity(data, desc->pending_mask, false);


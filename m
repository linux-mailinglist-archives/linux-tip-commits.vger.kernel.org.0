Return-Path: <linux-tip-commits+bounces-3249-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736AA11EDA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 11:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798353AB8D8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7900323F27A;
	Wed, 15 Jan 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FI3mj2oI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nI4o/joR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECB22F394;
	Wed, 15 Jan 2025 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935459; cv=none; b=RNRKQSbCyefukPr+FwRy59HLLJY5lUE8kUTVw/Fx5NBJBHJHm/EnslvrLkso779bE7AQ/Dk+IqvF3mx7mXHkcavGGXYV2DWBxjVRn5HXhCylzgEKVqnU3nPY8MlOsDAfkFk5NOXQ1xSeYYsgjZXyedIPON4XzEbnWpykemGqW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935459; c=relaxed/simple;
	bh=3ChXb/+KtIWAmZomvyc4MlTmL0hoedrkm8JsoF2Czvg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LcZYoL7RaXIcBfCJ9yNdWtVR2Y/FQlZs7c1wKdtdbwNTDGlas2mQzT9thM4CIl64NAKVxDijY+8bPplledn5Vu41Bihti+itqjNlfO+ZZZThDwShMLJdMqKQaNlzhFKh9nUM/O1KPtjmL7QzBphRVIMI14FAsugfvTwoVq5/8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FI3mj2oI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nI4o/joR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 10:04:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736935456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUNlPUUBlI4u4CnYstMJlZvk9441ipbxgcJH8sKmIec=;
	b=FI3mj2oIswH8eoEtEqzjRQb7U/tUk31RnQXsNpud+NA8waevrDPHQBgRhPV+OsF2WBKTjn
	tB9lZXBjTbk+ILIgzMSyeb1lIvHa0qhy7ZfH2lzERdYaUF8U51q0LG0+Ym02M2I9o1dBoJ
	H1uw/drU84iX27OWP/oqfsmXkZeSbv2x5Y+y4uyIT7xY6uOiyUt1p9y2j/s7PgucQEVsfd
	Cfbi0+IUA02OLziLr2ldt65X01HaxYyn078lTSCuHeOECjNRDiKwfdu38qQ9eb9R3h+rxi
	RFfFvLRPkO1RHO5aso4+jWa4qjLheGCAZeQUL9IlGkIQranHjCyUR33vyOORfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736935456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUNlPUUBlI4u4CnYstMJlZvk9441ipbxgcJH8sKmIec=;
	b=nI4o/joRkBOmqiTbN1eCB/+6OfuVSzttDxNvHrVMpKv21qU8Zw5EwjpeoasjNO+yqNP7Hs
	lCpwOTXNNGajEuBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove handle_enforce_irqctx() wrapper
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241210101811.561078243@linutronix.de>
References: <20241210101811.561078243@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693545548.31546.1445553406516861442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9620301cc27f6dc6197236a55a44fac8e64be0a1
Gitweb:        https://git.kernel.org/tip/9620301cc27f6dc6197236a55a44fac8e64be0a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Dec 2024 11:20:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 10:56:22 +01:00

genirq: Remove handle_enforce_irqctx() wrapper

Now that it is unconditionally available, remove the wrapper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241210101811.561078243@linutronix.de

---
 kernel/irq/internals.h | 5 -----
 kernel/irq/irqdesc.c   | 2 +-
 kernel/irq/resend.c    | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index a29df4b..b61fc64 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -469,11 +469,6 @@ static inline bool irq_fixup_move_pending(struct irq_desc *desc, bool fclear)
 }
 #endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
-static inline bool handle_enforce_irqctx(struct irq_data *data)
-{
-	return irqd_is_handle_enforce_irqctx(data);
-}
-
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
 static inline int irq_domain_activate_irq(struct irq_data *data, bool reserve)
 {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 0253e77..2878307 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -708,7 +708,7 @@ int handle_irq_desc(struct irq_desc *desc)
 		return -EINVAL;
 
 	data = irq_desc_get_irq_data(desc);
-	if (WARN_ON_ONCE(!in_hardirq() && handle_enforce_irqctx(data)))
+	if (WARN_ON_ONCE(!in_hardirq() && irqd_is_handle_enforce_irqctx(data)))
 		return -EPERM;
 
 	generic_handle_irq_desc(desc);
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index b07a2d7..1b7fa72 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -53,7 +53,7 @@ static int irq_sw_resend(struct irq_desc *desc)
 	 * Validate whether this interrupt can be safely injected from
 	 * non interrupt context
 	 */
-	if (handle_enforce_irqctx(&desc->irq_data))
+	if (irqd_is_handle_enforce_irqctx(&desc->irq_data))
 		return -EINVAL;
 
 	/*


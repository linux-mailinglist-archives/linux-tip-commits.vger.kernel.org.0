Return-Path: <linux-tip-commits+bounces-3251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0DEA11EDD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 11:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3331616580B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3099241692;
	Wed, 15 Jan 2025 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPC3VwdH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jV0FTutZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267623F266;
	Wed, 15 Jan 2025 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935460; cv=none; b=Z0hyrum14bLhIxALLr1ncNNg/6ZTjf8EneIoFl9uM/YTe9ZuCqXshvTiGp0jSiS53hHQRDDcTZljy0yZdpYK03Zr3BctfeCZRl52zQTv0wXRSjpKf2shgiNAuzhLuLvyV+OxriU7R1MPhPYzBR7TJ0hRFOz2+WepKXtjY3FlLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935460; c=relaxed/simple;
	bh=7EmXN6r6cCAEPxbonrxxHLHyznG4S+nebt9+/d0gejE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Na36C5X1qUn0LicDKErs+7nLWnHE62ANLE/E0imB+kk8xwncCj9NQDlC4rFgbhlgvMooQ0aZ5U4SflRcBpn2Wh1WRFoDPJEycn+HD9oF8psZrNqwfP2mYWcQEopjfqB7WXQDqaK5V8IBNSC8wQOtZErSZQiUZQqKXJTNi+lGY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GPC3VwdH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jV0FTutZ; arc=none smtp.client-ip=193.142.43.55
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
	bh=YjqP6VQZfJOOojI/P2aqcTnwo+EWnkjxLZWKzkLAqe8=;
	b=GPC3VwdHJtDX5fpICZoAPtVAlovPCqIL6Fuk/P8b/8LJJGBugxJCVVl3rkxfQ5fLhAf0SD
	HeiYxWOYkCTs0fegQNnvtJjuC30DII9ekBwU4K0/yzBJGY/mk8i/cNXK1zS9CElOKLSBeM
	bFeig2OyVOsSB4mQ8DaVayDYRMHMdfxmGZtUSUPo9J+zrdaFD/NgkPm2aXzdiNx7fTWfj0
	vBBOIgXQUzgenx6a4AYnO2X49kRhTx3ZZSmUA2Dn6kfuAqKW57tHS2iDuvm2PNaSOoNFog
	w5dTF3cUikwcgqyDbaQ7cDhx6px7LgtwfPJTcO72E/JkxvUqpflguv1ZfVQsvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736935456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjqP6VQZfJOOojI/P2aqcTnwo+EWnkjxLZWKzkLAqe8=;
	b=jV0FTutZJsqrwITIXf+cDF4dEMYpUsCXSZQtf6EN6aT/DXZwgbPSh2oCaOObK6vOLpDuU6
	HR4YF4pNEGqT0aBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Make handle_enforce_irqctx() unconditionally
 available
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241210101811.497716609@linutronix.de>
References: <20241210101811.497716609@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693545599.31546.9263072490501024592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8d187a77f04c14fb459a5301d69f733a5a1396bc
Gitweb:        https://git.kernel.org/tip/8d187a77f04c14fb459a5301d69f733a5a1396bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Dec 2024 11:20:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 10:56:21 +01:00

genirq: Make handle_enforce_irqctx() unconditionally available

Commit 1b57d91b969c ("irqchip/gic-v2, v3: Prevent SW resends entirely")
sett the flag which enforces interrupt handling in interrupt context and
prevents software base resends for ARM GIC v2/v3.

But it missed that the helper function which checks the flag was hidden
behind CONFIG_GENERIC_PENDING_IRQ, which is not set by ARM[64].

Make the helper unconditionally available so that the enforcement actually
works.

Fixes: 1b57d91b969c ("irqchip/gic-v2, v3: Prevent SW resends entirely")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241210101811.497716609@linutronix.de

---
 kernel/irq/internals.h |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fe0272c..a29df4b 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -441,10 +441,6 @@ static inline struct cpumask *irq_desc_get_pending_mask(struct irq_desc *desc)
 {
 	return desc->pending_mask;
 }
-static inline bool handle_enforce_irqctx(struct irq_data *data)
-{
-	return irqd_is_handle_enforce_irqctx(data);
-}
 bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear);
 #else /* CONFIG_GENERIC_PENDING_IRQ */
 static inline bool irq_can_move_pcntxt(struct irq_data *data)
@@ -471,11 +467,12 @@ static inline bool irq_fixup_move_pending(struct irq_desc *desc, bool fclear)
 {
 	return false;
 }
+#endif /* !CONFIG_GENERIC_PENDING_IRQ */
+
 static inline bool handle_enforce_irqctx(struct irq_data *data)
 {
-	return false;
+	return irqd_is_handle_enforce_irqctx(data);
 }
-#endif /* !CONFIG_GENERIC_PENDING_IRQ */
 
 #if !defined(CONFIG_IRQ_DOMAIN) || !defined(CONFIG_IRQ_DOMAIN_HIERARCHY)
 static inline int irq_domain_activate_irq(struct irq_data *data, bool reserve)


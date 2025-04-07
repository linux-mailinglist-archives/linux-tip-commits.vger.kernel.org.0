Return-Path: <linux-tip-commits+bounces-4724-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337EA7D709
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 10:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0996042282C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B4227BB5;
	Mon,  7 Apr 2025 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bfezmrQK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gG6bxhRT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0198229B17;
	Mon,  7 Apr 2025 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012438; cv=none; b=mINvppNOvr6Nn21T23cOx+nnSMUmu44kgbeA/Mi8Q8j/2THZjHyIF95Aks2U0UfBpWLYeT2WTQ3nzGcE597yllptzUc2or4U0n9B/i1ZU5pZTYl+/H3iJbGEZIuvnuLySd4wvC5cwV969MkKjwAtLivzS3/9VOZaVctcW8/FLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012438; c=relaxed/simple;
	bh=hr3PPT0BZx7a4k3crHwQAeMTpTeGYoP5CKl7emLQTsI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S55WzSGbDg0WXIfI1P0A+fYH1u3MkqN7Kbw1AEiT3qQ9PvhsSX0L5dQQf1PKUCnLc9Srre8AB1bDtOdzOa9bxxnD8pPrry0lQCzFWI6pTPNUA7/AFK3TRnBiR1nhUEZAtOIMvFtNr73rs/PzbDQzV5R4dNLk21rNz7qt+HUrSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bfezmrQK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gG6bxhRT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:53:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744012434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DX9tUDRzVVIEfV6wn3/YswGB1ECEjomcy1ljcE8OVWo=;
	b=bfezmrQKm4i2O0CGZPyQjh5wjQyprfmU/rux+ktOIApADbkGW88N5OFSWqS8e/TuE5lDYV
	ivPWNYrCbugegmeXV/abC2d714U58rO1MLkza1dTjRozdZQSd+57rMFjkFrt0B7NnQPemf
	RPLCZSIRl5ZuKmI+KHn72gT8ftryarKp4RjCi2dMBjyAS0/s3g1ZKne695z7XQ5vjRJwMm
	Xhv+ZfSvPZ40+n8AmW9/m1EpZmANift9XqitBaZhVOWBU2yhyYsFLNhKUJl7OGZzbHy+HZ
	09imzxD4Ism34Lz6ffhJGWM0kkNqJMg2824RAS3sTBsN8XS4Kku/BIBE2Sv3Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744012434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DX9tUDRzVVIEfV6wn3/YswGB1ECEjomcy1ljcE8OVWo=;
	b=gG6bxhRTWmHsF8uwSEoY4P91xjPBs9XEWBY7b77KsD+e9mWbKpmh2Q0HamI1KU2vZ3ggGe
	JIrVIpPfhRpULLBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] genirq/generic-chip: Make locking unconditional
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313142524.011345765@linutronix.de>
References: <20250313142524.011345765@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401243393.31282.13098708422031962410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     06f2f68a670aae28b825065439301831e74da880
Gitweb:        https://git.kernel.org/tip/06f2f68a670aae28b825065439301831e74da880
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 13 Mar 2025 15:31:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:43:19 +02:00

genirq/generic-chip: Make locking unconditional

The SMP conditional wrappers around raw_spin_[un]lock() have no real
value. On !SMP kernels the lock operations are NOOPs except for a
preempt_disable/enable() pair on PREEMPT enabled kernels, which are not
really worth to optimize for. Aside of that this evades lockdep on !SMP
kernels.

Remove the !SMP stubs and make it unconditional.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250313142524.011345765@linutronix.de

---
 include/linux/irq.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index dd5df1e..5007729 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1222,7 +1222,6 @@ static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
 
 #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
 
-#ifdef CONFIG_SMP
 static inline void irq_gc_lock(struct irq_chip_generic *gc)
 {
 	raw_spin_lock(&gc->lock);
@@ -1232,10 +1231,6 @@ static inline void irq_gc_unlock(struct irq_chip_generic *gc)
 {
 	raw_spin_unlock(&gc->lock);
 }
-#else
-static inline void irq_gc_lock(struct irq_chip_generic *gc) { }
-static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
-#endif
 
 /*
  * The irqsave variants are for usage in non interrupt code. Do not use


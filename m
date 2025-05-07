Return-Path: <linux-tip-commits+bounces-5324-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911FAAD93B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9774C4E20F7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267122173D;
	Wed,  7 May 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AikqAYTW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rEwL+2LY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0F221714;
	Wed,  7 May 2025 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604670; cv=none; b=Wkn/RMbZyRwvY5k1ZwsVTZDzGen349rq3l0++n+rJSxz/tueZ8aeAb0aOlFnVG4m0uSxxeWffbEzLL5TnTUza/pCTB4T6R2yI48bR6dwWJi1fcnGAUPUzc521stGPyzNKlHi23SikMIXWEUDMzTUHx0am2mwDqrPezX8bXIidSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604670; c=relaxed/simple;
	bh=Edi48S2QW7Bl1AlBnEAmSAX/cjArHfSTkl4yq02K7e0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pDS8SbOJTqrPGGqOY/bZ7Rv0Pq4SorIbvRWYl2luZ23eMzgM4vl2dVdzMuCXQO2hg5pgekOmC4iyWU/kIGX9t0qXy0e1wxnRe8BzXorYHtrgSKDEzeDWSqPeB9VGSALHif1foA8GiYNEztrYe+7Qw1vRgyELkF28q+LRsM0jYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AikqAYTW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rEwL+2LY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSvjRaQObSyYccysfBqIoddjsNA8E23r2vfDiTYpelM=;
	b=AikqAYTWyY/iH9/OomCD/5FV5Hb0EkATYxypVv3XTOC2XnMWVLeXcJcFR8xJyR9X1TVzJS
	d/5Dco7pz+KVtOIE37JXKrJDmLZu/Le1s5HWI23olHM6KfpvsRv5imEnfZ5T+qV12AP1tF
	3SDjVo1qdE+GL8d6rupNHQAuRSRUvYKcY+WHgkgUbgcXzDeCHLxx0hJy1AHqEQSXvihGVe
	bkSQFvU25jsGa2qB8O9+bT0V0j830P8MYKx6h0ddWh5wxOvAaOQuLRbQgg1BwQmhAMd7Um
	11l9hJVvtDNPdeoIqwoV9FCbHj3i0e9Lf9VVoxQKHPTMfZ4VdnZmuUkdGu5vuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSvjRaQObSyYccysfBqIoddjsNA8E23r2vfDiTYpelM=;
	b=rEwL+2LYNT0iNU+ryGRb8hZzU4CSAg8HhprGMmOX9+2ByOFX2fWu8SA987pCG2WEJ4j4IN
	Fv2W0dm/Gsv7IpDg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] irqdomain: Fix kernel-doc and add it to Documentation
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-58-jirislaby@kernel.org>
References: <20250319092951.37667-58-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660466603.406.2754537138927068541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     6b67de3a2db90987b5d0845b9c6a3ed7eb94dcf4
Gitweb:        https://git.kernel.org/tip/6b67de3a2db90987b5d0845b9c6a3ed7eb94dcf4
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:25 +02:00

irqdomain: Fix kernel-doc and add it to Documentation

irqdomain.c's kernel-doc exists, but is not plugged into Documentation/
yet.

Before plugging it in, fix it first: irq_domain_get_irq_data() and
irq_domain_set_info() were documented twice. Identically, by both
definitions for CONFIG_IRQ_DOMAIN_HIERARCHY and !CONFIG_IRQ_DOMAIN_HIERARCHY.

Therefore, switch the second kernel-doc into an ordinary comment -- change
"/**" to simple "/*". This avoids sphinx's: WARNING: Duplicate C
declaration

Next, in commit b7b377332b96 ("irqdomain: Fix the kernel-doc and plug it
into Documentation"), irqdomain.h's (header) kernel-doc was added into
core-api/genericirq.rst. But given the amount of irqdomain functions and
structures, move all these to core-api/irq/irq-domain.rst now.

Finally, add these newly fixed irqdomain.c's (source) docs there as
well.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-58-jirislaby@kernel.org

---
 Documentation/core-api/genericirq.rst     |  2 --
 Documentation/core-api/irq/irq-domain.rst | 20 ++++++++++++++++++++
 kernel/irq/irqdomain.c                    |  4 ++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
index 25f94df..582bde9 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -410,8 +410,6 @@ which are used in the generic IRQ layer.
 .. kernel-doc:: include/linux/interrupt.h
    :internal:
 
-.. kernel-doc:: include/linux/irqdomain.h
-
 Public Functions Provided
 =========================
 
diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 67d45b3..a01c6ea 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -298,3 +298,23 @@ Debugging
 
 Most of the internals of the IRQ subsystem are exposed in debugfs by
 turning CONFIG_GENERIC_IRQ_DEBUGFS on.
+
+Structures and Public Functions Provided
+========================================
+
+This chapter contains the autogenerated documentation of the structures
+and exported kernel API functions which are used for IRQ domains.
+
+.. kernel-doc:: include/linux/irqdomain.h
+
+.. kernel-doc:: kernel/irq/irqdomain.c
+   :export:
+
+Internal Functions Provided
+===========================
+
+This chapter contains the autogenerated documentation of the internal
+functions.
+
+.. kernel-doc:: kernel/irq/irqdomain.c
+   :internal:
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 57098c7..c8b6de0 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1996,7 +1996,7 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain)
 		domain->flags |= IRQ_DOMAIN_FLAG_HIERARCHY;
 }
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
-/**
+/*
  * irq_domain_get_irq_data - Get irq_data associated with @virq and @domain
  * @domain:	domain to match
  * @virq:	IRQ number to get irq_data
@@ -2010,7 +2010,7 @@ struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 }
 EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
 
-/**
+/*
  * irq_domain_set_info - Set the complete data for a @virq in @domain
  * @domain:		Interrupt domain to match
  * @virq:		IRQ number


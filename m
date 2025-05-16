Return-Path: <linux-tip-commits+bounces-5583-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20DAABA3DB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2131BA728D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34725CC40;
	Fri, 16 May 2025 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lCMhE9px";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+G8SNvg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76AEEBA;
	Fri, 16 May 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424241; cv=none; b=KtZAG2O3afx7nP3ODWoC6UAdDdo9J/VakuI2696r3POs2X+8mhdaooepOgVlljAgqkI4hSMqU6uw3pGJEo1OayVEVatVJ1rZMcy7yV9IbcU2GO4RfuFCrt29OPt76Yewc951VFrbePK4QxhncJUpfL2zOFx425WU4EJhpZ/z44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424241; c=relaxed/simple;
	bh=W2lit/L9T2zeb70FPIpwTljFg48a+I0DBfEinW5d5is=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iPyTzADUxJhnhSB6Fanjqu2jCkDLgeYVZlGoTjWPq0KeJj8Sbat4vMCxnQLTTfM1hGi+jvG3UA0xD/btsZ4Ufl0pAXhWNXFDYGFF233axZfirUGKHWtwSQDkcD2jOQyeZ2j/j5/vmeyITtV1CEJd61mKj/MblkcVDCe4vA0gePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lCMhE9px; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V+G8SNvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MckOpty5q+6I172+CP8zzcF6MGtAVmqcD53uTePLqXI=;
	b=lCMhE9pxO9Qd49030w97tPihPvABZ1Y5yWNCjZEa3jND10bhIKCoXkLRQfJ48JLM5tuf44
	A5t7B0I5trEm79/YRwAOiacXk3sdb22ceJC99wCbTed6eKAjMzcRrjlNXnypnzTzWyM0af
	lYFslDU5e47wULf4Q23TDCUhkx57WqmXyqR5y6TZvEfMAO0f0koFagFfz439x+1o2BYMUM
	Ob1hyV/pFoECP4T32cTgyvKznnWqyWMqyez+p2jtfyNPobBuHUKS0QIvvF9EcgfnopkWFS
	6lyzhA9mzeDXP1vFK3NS7t4nfRsLKwvnAAGyo6ZnFPALGrXF5COvT+hlapQ/aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MckOpty5q+6I172+CP8zzcF6MGtAVmqcD53uTePLqXI=;
	b=V+G8SNvgKPeXGJcFulRm6lB74wkJOLN7Z1sJ1ftIy/iq83T4hIK8f57IFmvZRvcdMGwnrg
	odVhcp2cdPzIyVAw==
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
Message-ID: <174742423683.406.8745749211098772079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     a10024e671d12c8125a8f31d08c67245f6dee16d
Gitweb:        https://git.kernel.org/tip/a10024e671d12c8125a8f31d08c67245f6dee16d
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:13 +02:00

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


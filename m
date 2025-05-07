Return-Path: <linux-tip-commits+bounces-5418-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A271AAE0F7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7761BC5BE7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA8289341;
	Wed,  7 May 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xH7BXXXc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="46ks5SrH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4F288CA6;
	Wed,  7 May 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625447; cv=none; b=D4LkQW90ZRzmIS+CXddPgvO8NPHhcNoXnVJ4QlIz8OJ2zT/CjD+WBF+w27ukNz/Bjy+wl1Gp3Vr4OvZaIB5JF2VO3LBrjKdTDeeGnuyMLvxVsAMs5SOpTb/swQWskwNp18ju7230OBNNuGtOXKYp2u7hNgHtujJBNuotibnsT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625447; c=relaxed/simple;
	bh=lKfkn1qw05tjHnm/bw+QSo8I/h6JmxQj8itRkLYryQo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UAKMPgoqiNkCcO5jM75yj4Q9im9CZQGKPP5uaKOEtAZElPrRt0JEgqoaO/AftN2uxTsq2CIuhTxqbfeuI+8zh8E2iFIxc5Qw73zgQgKEW5kpd0NhQGU08Cm622DsSY65yBk057yhbc9tK11hpKSotnuOPMNmUhyLtT1Z0CWYQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xH7BXXXc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=46ks5SrH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVGFQJI0fJW2b6lTcj/0uHNZLKrTHsBs7pOp+inK2jo=;
	b=xH7BXXXccKdBLvHMsS7hIxBKMP+ALuwkbghWcPHQhiZtZcym/kpypUP7NLXpbTKR/X+1+q
	IaHVMxz9uO+203GwlvR4Z32muy5GvirE9adZN9eZCP1jr72RQ/44tB+x+u3AO3f0ARF9vg
	d63W0bh+PAJoY9cKa0fh/qC/GjFCrQuolw+sVws0N24ZW+j8Rtn7QIUFy5zpy1oZrhTS2P
	WCHGnlo0Byzn/vFeUqllwHpRhFZAktaH3H6USijohvpNNVkesDFr4qdwzhRh+U0u19AKrd
	8vT0E6AgEd3LGomCkpoSWnKQlmOvMzv87apqe2Q7elxPHMKLfMoBn1wu0aLqmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVGFQJI0fJW2b6lTcj/0uHNZLKrTHsBs7pOp+inK2jo=;
	b=46ks5SrH1a7yi8Zvib3j78989GeDo9ABK6FYE/VAa/AVBYwRFGAUCWiCKWl9hDCpzmatwr
	lsjs5qeCQNywEPAA==
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
Message-ID: <174662544294.406.11237929511542030885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     e0de777349a3a1f97acedc876cba1ceb589fb9be
Gitweb:        https://git.kernel.org/tip/e0de777349a3a1f97acedc876cba1ceb589fb9be
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:43 +02:00

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


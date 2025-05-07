Return-Path: <linux-tip-commits+bounces-5413-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A017FAADB13
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798E31C204C7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB2253F39;
	Wed,  7 May 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RaaGXYK1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ZW/NfzP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEA241662;
	Wed,  7 May 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608873; cv=none; b=Xwo2Sw/lLOYB+clK1SPPHr9ddeLnt2Tx93hw3IRM5qKcZsD/wpmWY2eu/x3VH6jkHlhpF79eQDr52C/y23or0mZeDxJ+/X6JCnOfhQRGbzG/nKZcWAKFjZOzkr8EXJt8/LzciKROyUa2Q8r8edpjpt5G3jrTuGfCmIvzEBkFJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608873; c=relaxed/simple;
	bh=A5ugYcvm/mnJMDxqbV3jQiIu2QMKbXrKTpZWxTGjr+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lwI+Y1/zlTh8vddErWxGSe7gaE9SZISe/Qg9DNrN44595Qe6mrQCPBeOdGWG9UtBnvGjZTWtdEPmv2XlpvwkOONWAchpRBtmM2nP7OP2kK66ItnEedig77qug98J0xTc7HJRKxszU4yk9RL9BDqGGeM5gaDya36vULUgTkcC/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RaaGXYK1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7ZW/NfzP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eY5GA35uVgOc0orLrhHdwNIgr3ZLtHFeN+rtMCW/3rk=;
	b=RaaGXYK1G38ZCgdrOMMIWDfeKIoU7DIFhd25fKSxUOz05gpDu613Hg4v1l2s17y39G8rOS
	hqeRUy1PDNT6bcWPU+WBRJ6KWgD8MKg1kSDh7BtxQhiS8GlzB+gKrN4ZRZx50FdUVdcsqe
	D0QnA3vN6SHUc+YPvzAlXWyIcWSFYZwK+sGOiaoZqm6XF0IbWuQ15in8EPob8CJLaTznHQ
	3Ea/WyFbZqSPhFMMakch+mIBMz2Qj8MTIjsyTUi+GtBck3+ARy6V3IRXQ0fNpd/dgeDXil
	HCi/uhhPYmkT+oLADAu/oF5vJtAq44t7U+dIyK/3Pjv0iiCA8m24vSCFO5pFXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eY5GA35uVgOc0orLrhHdwNIgr3ZLtHFeN+rtMCW/3rk=;
	b=7ZW/NfzPitNsYupTPHYcLFiTUAkbtwqhgcafWyLclPvKEgPFaw3adoBxTGYng1oqo51IW9
	oTz/o+LKKWZe6iBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Provide conditional lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.061659985@linutronix.de>
References: <20250429065420.061659985@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886861.406.11820421398467260083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0f70a49f3fa386d34203efd426a2937592cd26c6
Gitweb:        https://git.kernel.org/tip/0f70a49f3fa386d34203efd426a2937592cd26c6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:54:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:11 +02:00

genirq: Provide conditional lock guards

The interrupt core code has an ever repeating pattern:

    unsigned long flags;
    struct irq_desc *desc = irq_get_desc_[bus]lock(irq, &flags, mode);

    if (!desc)
       return -EINVAL;
    ....
    irq_put_desc_[bus]unlock(desc, flags);

That requires gotos in failure paths and just creates visual clutter.

Provide lock guards, which allow to simplify the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.061659985@linutronix.de


---
 kernel/irq/internals.h | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index b029084..44d3a67 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -141,6 +141,10 @@ extern int irq_setup_affinity(struct irq_desc *desc);
 static inline int irq_setup_affinity(struct irq_desc *desc) { return 0; }
 #endif
 
+
+#define for_each_action_of_desc(desc, act)			\
+	for (act = desc->action; act; act = act->next)
+
 /* Inline functions for support of irq chips on slow busses */
 static inline void chip_bus_lock(struct irq_desc *desc)
 {
@@ -160,14 +164,33 @@ static inline void chip_bus_sync_unlock(struct irq_desc *desc)
 #define IRQ_GET_DESC_CHECK_GLOBAL	(_IRQ_DESC_CHECK)
 #define IRQ_GET_DESC_CHECK_PERCPU	(_IRQ_DESC_CHECK | _IRQ_DESC_PERCPU)
 
-#define for_each_action_of_desc(desc, act)			\
-	for (act = desc->action; act; act = act->next)
-
-struct irq_desc *
-__irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
-		    unsigned int check);
+struct irq_desc *__irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
+				     unsigned int check);
 void __irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags, bool bus);
 
+__DEFINE_CLASS_IS_CONDITIONAL(irqdesc_lock, true);
+__DEFINE_UNLOCK_GUARD(irqdesc_lock, struct irq_desc,
+		      __irq_put_desc_unlock(_T->lock, _T->flags, _T->bus),
+		      unsigned long flags; bool bus);
+
+static inline class_irqdesc_lock_t class_irqdesc_lock_constructor(unsigned int irq, bool bus,
+								  unsigned int check)
+{
+	class_irqdesc_lock_t _t = {
+		.bus	= bus,
+		.lock	= __irq_get_desc_lock(irq, &_t.flags, bus, check),
+	};
+	return _t;
+}
+
+#define scoped_irqdesc_get_and_lock(_irq, _check)		\
+	scoped_guard(irqdesc_lock, _irq, false, _check)
+
+#define scoped_irqdesc_get_and_buslock(_irq, _check)		\
+	scoped_guard(irqdesc_lock, _irq, true, _check)
+
+#define scoped_irqdesc		((struct irq_desc *)(__guard_ptr(irqdesc_lock)(&scope)))
+
 static inline struct irq_desc *
 irq_get_desc_buslock(unsigned int irq, unsigned long *flags, unsigned int check)
 {


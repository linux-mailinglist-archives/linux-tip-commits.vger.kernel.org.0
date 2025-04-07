Return-Path: <linux-tip-commits+bounces-4718-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD0A7D704
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31B63AFCF6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F045225797;
	Mon,  7 Apr 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQWURKr6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2HMLXA6X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E18192D68;
	Mon,  7 Apr 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012434; cv=none; b=gilT2mgstuJv3we6RMtBrlgk9ryz9L+jFprEjr2yUu4EDepwpYDjV9GBiN85fVwVok1JEWbcSL5wFP/7Y1p1RUG7kBrLyULZO2C69XNPRkFOOSsAyrg+SlmCBs7hLy503WEq4xvC2W7ns9YJ8C1UIBPuDAgEptVPxIe7VXgLS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012434; c=relaxed/simple;
	bh=SqFxF3ymIvFkTvxExSUV+eN4GDD7pcG1fqNv9C2sbPI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M3DdHFpGgOKALqCyYRpsECOlhVVKxG/MiDEi5+pPDBGMtnidaXnc1JfdJqH3emYI+c5A9VL37gruCrZhZ2DNbyrZk5l1HkANNY9vaWg9jYXTcFmo1j/4aatYPXKc2VLpYeW2fRg9v3f8qkzWarcilcjbVZpZPoLgBuMjy66ydbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQWURKr6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2HMLXA6X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744012430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRdKfDtD+et4prnywYALkbCpvoPAI8NLZ7jiLgz+D48=;
	b=hQWURKr6gSMr/GJMxDH/Qlk/ZXySC7OPvXUsLD+u+275Q3KzZw/cGJm7C4A7l7ku6hcrw8
	HlLOia0+Tmq/HKgMzu6QF2oGghN8Exq34MLbWQWlbCyOwbI6V/0kWja/ja6AgeMUQ96eB2
	01GKZKhIP4lYO6xQXLAeL2kSWfXEHxN1ebCjqjcFUe3JEdUoZKEpMUYoinXhmQi240/wKH
	o6WSt2lsTn1DAVqpe2tS6Esw0EwyhNqPqqMD6ddRVavBDS6sM+HS608ylBTT+duNAyWd1p
	N5Wmv9U0qFPhEafyJtoApHIV9Z1SjFbXKHgooVQG6v4FrOx9Np62vCcuPt1GXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744012430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRdKfDtD+et4prnywYALkbCpvoPAI8NLZ7jiLgz+D48=;
	b=2HMLXA6XbPpoHHRAwraYzGC5NJPy2YBnSx6D9LGIH2+7lMXXQb+g2FY2yOZMdWRwUGCph4
	/AvYHX5aQ73899CQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] genirq/generic-chip: Remove unused lock wrappers
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313142524.388478168@linutronix.de>
References: <20250313142524.388478168@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401242527.31282.10339675728114626100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7ae844a6650c5c15ccfbf76ed767e7f2cc61ec1d
Gitweb:        https://git.kernel.org/tip/7ae844a6650c5c15ccfbf76ed767e7f2cc61ec1d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 13 Mar 2025 15:31:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:43:20 +02:00

genirq/generic-chip: Remove unused lock wrappers

All users are converted to lock guards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250313142524.388478168@linutronix.de

---
 include/linux/irq.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5007729..d896d3a 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1222,26 +1222,6 @@ static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
 
 #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
 
-static inline void irq_gc_lock(struct irq_chip_generic *gc)
-{
-	raw_spin_lock(&gc->lock);
-}
-
-static inline void irq_gc_unlock(struct irq_chip_generic *gc)
-{
-	raw_spin_unlock(&gc->lock);
-}
-
-/*
- * The irqsave variants are for usage in non interrupt code. Do not use
- * them in irq_chip callbacks. Use irq_gc_lock() instead.
- */
-#define irq_gc_lock_irqsave(gc, flags)	\
-	raw_spin_lock_irqsave(&(gc)->lock, flags)
-
-#define irq_gc_unlock_irqrestore(gc, flags)	\
-	raw_spin_unlock_irqrestore(&(gc)->lock, flags)
-
 static inline void irq_reg_writel(struct irq_chip_generic *gc,
 				  u32 val, int reg_offset)
 {


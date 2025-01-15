Return-Path: <linux-tip-commits+bounces-3260-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019EDA12B69
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 20:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEE0188551E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 19:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B911D63C7;
	Wed, 15 Jan 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cx5I56Vt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DFnjPxjA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83561D799D;
	Wed, 15 Jan 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967817; cv=none; b=IZTiQ95KKwwsyT4XpPzpBzPnVAPSouf5MZpY+OzdRrf7naZ3zlCRKuITlv+GdufU7VhAE9OerZQSrNjLxJg7DXMGYSrNrvj+rVxWlWfAVin+I9681o3sSenafMQhbv8+c1oLgjcNndM7YFQc5WK/9mccBeXiQf/+WNwi4qFiKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967817; c=relaxed/simple;
	bh=+8WP5wfu67s/Yle52Rvqk8oh68CGq9NoyKxI4KyXnJk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CkPxPBgXeoHNwYF5aBEygR8a0w9GLDKr+rKhJbI9lzpDrirP1gkCnU4fpyQpvHWbxaReOHFEFbqLqIEavzLz4oxofDvqveJZx8kFHWSbFyWV/WyWo/83QL9Tp4PFRR8xSkWLKCoOojl/yendpUj7KhxuNFrUrzXGT816D5dbDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cx5I56Vt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DFnjPxjA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 19:03:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736967811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+DXKvHzw++eHk1GUPNTCinbR80NRuyYIIVBQRvrhMY=;
	b=Cx5I56VtKrK+01IH4dCf1qS+MAz7U/YeWHk5YX8EZb9NrurdFflPDqm1PERzw6z4NigKP4
	uvxRaKi0kky63P52RPk0jUlUsxi65DC/y/wJx/1eE3CZmb52HhhvicSNp7HozhirYqMNJC
	2N9TvmLcBAx2XLGT0TbQ7DC3yuVYFLW9EC55dQlMUaCCItFUZL6jLkJk0AClOwA6DrbpFc
	1lu2AtHHtVfdcvkqLOsJPMm4DwodimQNf1EMGw1dhi2dOChQFDx4Xu8y9amU9YucYHeAN2
	XyQdW6T2+Gunia//bTY5w+QTwCfZ6RtdHgEcf6y+RFubbrKMaXP2YwCNyDrAbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736967811;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+DXKvHzw++eHk1GUPNTCinbR80NRuyYIIVBQRvrhMY=;
	b=DFnjPxjAObRVwcx0kNQw1cEHAzklzBqcnSfweFlJdu2OxPzz6YyGMJxcLW9iUDQdB+8Aa7
	O67RJK/bwHnkegAw==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/timings: Add kernel-doc for a function parameter
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250111062954.910657-1-rdunlap@infradead.org>
References: <20250111062954.910657-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173696780887.31546.11324687228677189711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2bebd2da85640a9bf96fa931064fe7847eca7f0e
Gitweb:        https://git.kernel.org/tip/2bebd2da85640a9bf96fa931064fe7847eca7f0e
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 10 Jan 2025 22:29:54 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 19:50:55 +01:00

genirq/timings: Add kernel-doc for a function parameter

Add the description for @now to eliminate a kernel-doc warning.

timings.c:537: warning: Function parameter or struct member 'now' not described in 'irq_timings_next_event'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250111062954.910657-1-rdunlap@infradead.org

---
 kernel/irq/timings.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index c43e2ac..4b7315e 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -509,6 +509,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
 
 /**
  * irq_timings_next_event - Return when the next event is supposed to arrive
+ * @now: current time
  *
  * During the last busy cycle, the number of interrupts is incremented
  * and stored in the irq_timings structure. This information is


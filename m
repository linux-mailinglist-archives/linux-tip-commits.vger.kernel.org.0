Return-Path: <linux-tip-commits+bounces-3261-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8722A12CEB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 21:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5997A30D3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C01B1D90BC;
	Wed, 15 Jan 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2QfFoKZC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7mPKwFq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F21D5162;
	Wed, 15 Jan 2025 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974041; cv=none; b=WxZ57AN//7jHKQ+DP+i/0ILfTsbfWJhFzqsw5pIWGTJneOrAdtbxiCQJAoV/LZpOW+SzZhVxrcX2isxH0Pw1I2ZNTZeelhSA0rQiYpaPodZ573m+bkEYx6a4O6i/np+gRl+H144ekq31mhVPCTxDDM5iYQf0x7FpWgiIttD9kAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974041; c=relaxed/simple;
	bh=JTD9VoZ5nBY25+AlMS+0vKZs161q/J0/Rwxn9ssz9Ys=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ih/v5LQGW5ha7o61N8t2TDhc/zlo/et87o386b6A6N2XXQpaGwSiradhZSwSb7dAD8qk0qcN22BZjFafcmf3VRdljbFEWb13lfZlAwFDFkYxcdYItlxWRyoOnDMO4Qr2FIVf7mk05Q0/ZRmDMZvlsoHB/Wd/cKUGXGGGdhSbW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2QfFoKZC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7mPKwFq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 20:47:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736974037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4Ea8kK5VrcINjFsa2gTQG7ROezWpzdSt9+KU7KH2wE=;
	b=2QfFoKZCv43FWX/E+rwfG7lJv+7FdCjBBYYd+8+bIx/4Fbta94qA97qEURA7m430kcId1J
	+oiMyI9csa8h6LPi3lt2r76rtdAgNxQWIeHQXu2krfXUSmfbe4xb4P61dsNmwHhF/72HrJ
	Js2Bjcfp8RvL/RhpFg/TwfiC4yXdz7ZrPgEuVdiKHRdnVE6IpTkEa+dGvmCZmK1Ey/ssq8
	3e/N5xaYsmy044sxgxr/5thzX+W4A5XVa+yR4vsL58AitgMBXbcB7RaRdWIm4DRJlbb+uE
	8cW6rfjtF4JvqTrAfNFtJJ0QtasuTLzi12of5CGR4+7U+A02eNAHyXiGcCCGgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736974037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4Ea8kK5VrcINjFsa2gTQG7ROezWpzdSt9+KU7KH2wE=;
	b=m7mPKwFq9guuXMXiWuOfISBVf90+sgZNuL+JBQe265T2gNmz6Ykx8+gnJdXLdJQMwFyBBT
	KWffV+t1QYS4O/Dg==
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
Message-ID: <173697403510.31546.4138916792062921369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     554d0fee8a5b09e79ec17a9c3867d4d7b7a818c0
Gitweb:        https://git.kernel.org/tip/554d0fee8a5b09e79ec17a9c3867d4d7b7a818c0
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 10 Jan 2025 22:29:54 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 21:38:53 +01:00

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


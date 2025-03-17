Return-Path: <linux-tip-commits+bounces-4296-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F983A66213
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 23:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABA8189C68E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 22:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A933D204080;
	Mon, 17 Mar 2025 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJVLgAVK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/tYFJ7a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7960200111;
	Mon, 17 Mar 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251880; cv=none; b=GRSxHkic7/naYFpnw3+YuWltdnJL/paZJTV/+AfnFqhAzG09bD0/I8f4QmR1EL2DfPWYBrIAKBHIvZaX/oayNk/63A8uZXOQY6mmHc3aR5Tet4zFdFAlQAUhTOGoiNTlSv72MtEi3mMH1GMzyga2e3L6IphzURPaLBZQDWUWMFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251880; c=relaxed/simple;
	bh=ty8COmLCYXzrSs2VKimK+5lRrGoXtwOi0ut2Q2ZP7T8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LoeEU/whTqRLO3BsLb1bRyctg31iIGwQziSL+CWnDaBgDD0lA6nqkTLOhY35ITprZlquwzpb66l9x+amri2yV1GBZWF9uQg1MROr8yJ6CbKYKmMof4q/ydD1jLb0HUAe2wIu6RvduKHUkHmbhvKGoiHdqroLDbPzWTkpKRTrhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJVLgAVK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/tYFJ7a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 22:51:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742251869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwvxwfzHTsd8qiCIg1rWmUI1koniPlKx5MCWSN0KrLw=;
	b=jJVLgAVKycJwoINK69QkBolDQJ3A4s+gEym6YUVZ/bPoc+qKN+pnv+LRScqOfN4EtaTC4Z
	ANdDIU7KONNBtuYkNGaYB2+ttVFdGSZ0KcayS0qfEw4T8gL2kOkdF6NAO1AtYaKQqZ/qFA
	ymF2ROyOMNr7VKgeGsUZzw61sCoh+uuukF6aw0A7k+Q1jgvTVA5ohrCYAFWx4+w70RZSt1
	bFNDFvAB0Al9wmewHiOJEOpWMCtC6cuJBgLFzRzONfAWtxdT0c4Uxzs6+ATRnttahxtWkY
	O/KNPJ4/GadZojhbU2Ha1ys1CuoBEOPOJpQLIxh5otu/V1vPagZjdddT+22QOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742251869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwvxwfzHTsd8qiCIg1rWmUI1koniPlKx5MCWSN0KrLw=;
	b=u/tYFJ7ajPdy8Ad2xE6GOClOmh+doZlk6G+Bw+fQR7bErCk+yYMCMq61Z/hi6RBe8jos5l
	Zj0OoCCAzi0J8eCQ==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86: Check data address for IBS software filter
Cc: Matteo Rizzo <matteorizzo@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317163755.1842589-1-namhyung@kernel.org>
References: <20250317163755.1842589-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174225186227.14745.16631399663046111624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     65a99264f5e5a2bcc8c905f7b2d633e8991672ac
Gitweb:        https://git.kernel.org/tip/65a99264f5e5a2bcc8c905f7b2d633e8991672ac
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 09:37:55 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 17 Mar 2025 23:37:31 +01:00

perf/x86: Check data address for IBS software filter

The IBS software filter is filtering kernel samples for regular users in
the PMI handler.  It checks the instruction address in the IBS register to
determine if it was in kernel mode or not.

But it turns out that it's possible to report a kernel data address even
if the instruction address belongs to user-space.  Matteo Rizzo
found that when an instruction raises an exception, IBS can report some
kernel data addresses like IDT while holding the faulting instruction's
RIP.  To prevent an information leak, it should double check if the data
address in PERF_SAMPLE_DATA is in the kernel space as well.

[ mingo: Clarified the changelog ]

Suggested-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250317163755.1842589-1-namhyung@kernel.org
---
 arch/x86/events/amd/ibs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e7a8b87..c465005 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1128,8 +1128,13 @@ fail:
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
+	if (perf_ibs == &perf_ibs_op)
+		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+
 	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_exclude_event(event, &regs)) {
+	    (perf_exclude_event(event, &regs) ||
+	     ((data.sample_flags & PERF_SAMPLE_ADDR) &&
+	      event->attr.exclude_kernel && kernel_ip(data.addr)))) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
@@ -1144,9 +1149,6 @@ fail:
 		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
-	if (perf_ibs == &perf_ibs_op)
-		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
-
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from


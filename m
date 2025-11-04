Return-Path: <linux-tip-commits+bounces-7232-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D170EC2FCFB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB1A3BFC90
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A3314B60;
	Tue,  4 Nov 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YZwddiAp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F7xf1KMH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0533148BE;
	Tue,  4 Nov 2025 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244238; cv=none; b=Mda8lUmXr0ql0FWyQgfuk/Cq7hJJ1+W12kHvILmQgjd76G1JUbSvHsAOKBM3/Kk5mqRvzjugyTbitdRRxCJmf5jgC1GF1yQ4uLJaMGw72HxS8UX2vTMsbgpQF1/obUKM6gfExpKrXKoc2HruSx2WWDsJjAx7AEdySvBhwelDefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244238; c=relaxed/simple;
	bh=O8+eNVZ+CEkiYNRIG98AdK0RDUStngEGV+uWp5M+6DU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gr9udQN+WOMDCHxrfaHyTTC7abmoGigbLEYBwCZ+WvdY54Nhc4vy2zxxSRyLhbma66MxTmYD8nkEOxjJSLp50K9G3U9A+XJYww+y5D6ahpWsdmSxCIkmbUxrclmn3OVwhkeRc986TZNphuFzrkoPu6c5wPlBUgn+naJv693/8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YZwddiAp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F7xf1KMH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5Czk6jyULOFgUm2iCDPoxduTvaS7BEvpckEPq1x3KQ=;
	b=YZwddiApXCK0wwwhX8Jt5xDR/X128lx423m/hn/hT/5/WyxEjGLeThR51KqfrEL1JATrkK
	AC+kC8S/jCTf+Evl0FUVmvZjwUgwNoNDdu5QrZiMUZ34/EvAyEy7QmvW3eGbTo9W8c47qB
	LnpUieD7PAehlKuUj/p5ulAnbgvCqSuf7V6vh/ozdkDHJBoBS11nWi1JzmxRq3cxuxN0Rh
	aDiKBB2mztLoheFNP7hN8z19JWw3CQbCY3fVwe0xLC5FPRZjB2Px43i5HYSK6MrS19UBsL
	s3j7JonFA4Wh87z9EDf/1Q9wgKQvnEQ7d4udG8uklqkGtvJ540uFqv7Bjyx+TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5Czk6jyULOFgUm2iCDPoxduTvaS7BEvpckEPq1x3KQ=;
	b=F7xf1KMH+gGcu+L+rbVEYuv0/EwYV6Hx3tPA7GviGWacE6FcER6d2BG8ug6oMSBhMJMbLG
	Sx3AYatOmmSbh7Bg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Make exit debugging static branch based
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.272660745@linutronix.de>
References: <20251027084307.272660745@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224423329.2601451.13487373940415446410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     c1cbad8f99b5c73c6af6e96acbfa64eaaaeb085f
Gitweb:        https://git.kernel.org/tip/c1cbad8f99b5c73c6af6e96acbfa64eaaae=
b085f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:02 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:33:20 +01:00

rseq: Make exit debugging static branch based

Disconnect it from the config switch and use the static debug branch. This
is a temporary measure for validating the rework. At the end this check
needs to be hidden behind lockdep as it has nothing to do with the other
debug infrastructure, which mainly aids user space debugging by enabling a
zoo of checks which terminate misbehaving tasks instead of letting them
keep the hard to diagnose pieces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.272660745@linutronix.de
---
 include/linux/rseq_entry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index f9510ce..5bdcf5b 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -285,7 +285,7 @@ static __always_inline void rseq_exit_to_user_mode(void)
=20
 	rseq_stat_inc(rseq_stats.exit);
=20
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+	if (static_branch_unlikely(&rseq_debug_enabled))
 		WARN_ON_ONCE(ev->sched_switch);
=20
 	/*


Return-Path: <linux-tip-commits+bounces-5477-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8970EAAF7FF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C8A9C3813
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5576822B8C2;
	Thu,  8 May 2025 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gm7TPaOX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0FzXKre7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEE22A4CA;
	Thu,  8 May 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700440; cv=none; b=iNrsqP/oPteuoMxM7D21JFLASSfkVTSr5aIEWL/bulUZAbvcuuLwEkFctl1WtHlwmO5NorMXj2jXRbgyYF53wDVpPfHG/Zd/Y76Yx8IPXQMDHt8EIwkyiHhvzOM3w289+ppmhj7BRfZGRj1bOH3+6RvvcWRFNwS2gRNyttZBUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700440; c=relaxed/simple;
	bh=jlRvldUhTi0zvowuYsSs4Ib6LFKy/lX1gHbpvUUKsAQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T5AdhB6gSBKkmXfa5FWA++EGDTlPNWeN+6IndQE6QDOL2hot+nb1OCXqGhQmA6H7i0+w5pMoDHC/hI0xJuXScu/J4V7uVXWGeZC/iAZMJbhgbLzlp7vFqBFnqS88vkBc2Iwl199IRTNyBRoS1j6joDECVGbbW4HLefv2A+98MNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gm7TPaOX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0FzXKre7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jn+UuHiG3Zs8Yd8Pu+BILatUQuseEMRMNkeg/iFdcWE=;
	b=Gm7TPaOX5QCY/YcPpjsl0ZjJBL380nxU06VcUtb7285SX6DNFTubUeu1V7BUJV0i0/S7bi
	OfdPjHBX9yW/6dIlFuv3H0JBr8GLHSR2+2EfwqThg2lIqSdymp5Rq4sovZ9t7WtYK2H1rL
	tzjxpgoI7arArbnP0pI+kIVoGnvVtB7/HktEEcP9BZah04/7FbqI+W+5dfVLNiqXvEvgrW
	s3EPHWxO7c3xPoMnwmxc+31oqnVVME6XqupCa2SI3MMwvPOG2fFx8pBdxI1WgZQFPd7brj
	dk2IeVWoMYocqAoW2DERhk4Mgd2cmHxdBd+5z6HIzpqGxskrxZCNosuM2/BVMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jn+UuHiG3Zs8Yd8Pu+BILatUQuseEMRMNkeg/iFdcWE=;
	b=0FzXKre7u2A7tfwp+VTXnLyM1OkoZZHbMg2kcJc8AQuXAYbrI2QaHIyacyRy10dCNk89Ao
	DDFfjcUO/ftsl+BA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Acquire a hash reference in
 futex_wait_multiple_setup()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-9-bigeasy@linutronix.de>
References: <20250416162921.513656-9-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043556.406.13694680291429891836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     3f6b233018af2a6fb449faa324d94a437e2e47ce
Gitweb:        https://git.kernel.org/tip/3f6b233018af2a6fb449faa324d94a437e2e47ce
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:06 +02:00

futex: Acquire a hash reference in futex_wait_multiple_setup()

futex_wait_multiple_setup() changes task_struct::__state to
!TASK_RUNNING and then enqueues on multiple futexes. Every
futex_q_lock() acquires a reference on the global hash which is
dropped later.

If a rehash is in progress then the loop will block on
mm_struct::futex_hash_bucket for the rehash to complete and this will
lose the previously set task_struct::__state.

Acquire a reference on the local hash to avoiding blocking on
mm_struct::futex_hash_bucket.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-9-bigeasy@linutronix.de
---
 kernel/futex/waitwake.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index d52541b..bd8fef0 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -407,6 +407,12 @@ int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *woken)
 	u32 uval;
 
 	/*
+	 * Make sure to have a reference on the private_hash such that we
+	 * don't block on rehash after changing the task state below.
+	 */
+	guard(private_hash)();
+
+	/*
 	 * Enqueuing multiple futexes is tricky, because we need to enqueue
 	 * each futex on the list before dealing with the next one to avoid
 	 * deadlocking on the hash bucket. But, before enqueuing, we need to


Return-Path: <linux-tip-commits+bounces-6829-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C6BE26C8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171893E1795
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760E31A55A;
	Thu, 16 Oct 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ejRxWRP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E58SjRgI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1D31A576;
	Thu, 16 Oct 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607209; cv=none; b=eH6S8v88GQNIhu/8A+fPd5smTU2zCyD5J3sTGWp2cJL4Hykjy10chTc1nxaJWzDWiNq8LSJHXo+59hs/YkwIkD5VKgzpS2on2fie57Dk2qQw7D966E19qm2PrAaRSCuJZfNs+VX6Nq/stYQfx/Z0nn1EDXpEVLIjWhGrFOpi4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607209; c=relaxed/simple;
	bh=cpse6PnvTAHy5sZ4EIT80DZQemwO9DPC5gBmnmRpgeA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qUIRTODbB64HvOW4Q3JWkhtmEvpUQloYcAnLzeSNZkTJUEKUakmBGql354YY5Aw1gMkrcHnfEsrx0U5WKcfUSmoJcfgbxiM52A+7drCzo6fIdyuyF6IMxa/88lHrYuDxFQ+7gNP1/YSeiy+uLEWcKvdN8WxCBxwfaP+ywOwrdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ejRxWRP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E58SjRgI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhNK0hIIiOrwK23KEnSST7yPrQjhEPJLcevOoObqLI8=;
	b=1ejRxWRPBfbTDxuBwBrH07lHBbDK4hx3MAQsM9c1BMpda1/h2kjv/Vn79DQe3rEIXpUebE
	jHFuHJ2SspB+NHBlDpKWRpDOERKW1vyMY+4lU9L329kT2wD78aQWIxcnBlQE/PmFqmHhzI
	tfng54lxAXJfQtG+2LuLrFr5b730CJLi46j/h7n7liO2sSej8AbSiruppDAN/8l0FzsL/8
	N6xkQ+CHAl0HfsWGHfBMUkpcSmBFI29y810Mj2GhIcoEgtWgyRsNbnDSTcffLQ+bGAzfq4
	cXaQNvArwCm9rYY6HZVGUBbzRULbvr77k2/jf9NdIIDVMXkS8O19o5uL+++QHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhNK0hIIiOrwK23KEnSST7yPrQjhEPJLcevOoObqLI8=;
	b=E58SjRgI3uX8i11UGZ23UUI37NWdcA1uheAvrt5CIbccdeFfkNnJS5EqYcatvuDEb0vjaI
	Yxaae1IxTbjrrjCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Mandate shared flags for sched_change
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006181429.GV3245006@noisy.programming.kicks-ass.net>
References: <20251006181429.GV3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060720339.709179.11411110575937690476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     73ec89a1ce4bce98f74b6520a95e64cd9986aae5
Gitweb:        https://git.kernel.org/tip/73ec89a1ce4bce98f74b6520a95e64cd998=
6aae5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 06 Oct 2025 20:12:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:54 +02:00

sched: Mandate shared flags for sched_change

Shrikanth noted that sched_change pattern relies on using shared
flags.

Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d5659f..e2199e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10781,6 +10781,12 @@ struct sched_change_ctx *sched_change_begin(struct t=
ask_struct *p, unsigned int=20
 	struct sched_change_ctx *ctx =3D this_cpu_ptr(&sched_change_ctx);
 	struct rq *rq =3D task_rq(p);
=20
+	/*
+	 * Must exclusively use matched flags since this is both dequeue and
+	 * enqueue.
+	 */
+	WARN_ON_ONCE(flags & 0xFFFF0000);
+
 	lockdep_assert_rq_held(rq);
=20
 	if (!(flags & DEQUEUE_NOCLOCK)) {


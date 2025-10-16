Return-Path: <linux-tip-commits+bounces-6841-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A259ABE270A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A683ABC59
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53732320CAE;
	Thu, 16 Oct 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ibWDy2jd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EG8mB8Y2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74799320A23;
	Thu, 16 Oct 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607224; cv=none; b=XJPr/++7AQyqtMsMB+DrTMO+7j9z2jdl/lh+QiMmI1ptdXfyIPVMOI1NJG9cBBt4HDM192WYPkh5iPe3Y8qyVl6guI+yUc6DmxQxZqT/ZGgbCyJeeXiFeZkmP8q1EI2K5Do47fYBOkmo+IZwFm4pijCkXkm77vunBCiSaLpDEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607224; c=relaxed/simple;
	bh=fRSrbLcUzfwPUUgPcPCkhqdujYZ42TcuYS1HfLohun0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WL/vuxsYcE4h4AZ4PZy/i03j/T5pFmKt7yX5Db+a9w7r9sE3/WBJWYHJYEAFx3kXSIv49f0XGGG8oJY1431M2eXqruCT2JlsCK2oAUen+LoYwY6DfkrCriovo7fo9swZq94BOMyMWYcFC6wfT/E/pUh7r4Fc+V9Dw3Akmb0QiDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ibWDy2jd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EG8mB8Y2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SkGXuXDfN2uFgn8U3U+8pHDWRN3VhKq2VB9LplGjTk=;
	b=ibWDy2jdOqLOXLLlyb/tw7FaNdfAJxZGTHZ+INhE1QElqhZSMi+m316PEYr+vEbskMywOS
	JpkVorHN9S0oP2EHuxHmkL49B6ASaniOrPBa58IFlaXwMcAWxiLMD1hyQUcu+Pl1mECufn
	tRG9LBVKW9lUHGxpyMhDGJvB0Z/u8ftvZvmr4ufc5EKv+EqpGPcM/H6FIx1Ge89ez/Pri+
	9e5dDyMjn7WRJaBCQETHzBlaEPT8pR9SMD0KaQNIyo+yRJCKyPaq8e66oW3Pj/Emf5zfyf
	5JbiXWsIV9InCSFadf/+PicYjCyvkbluHjbu+1OgKUEuItam9PMDMdYviVrf7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SkGXuXDfN2uFgn8U3U+8pHDWRN3VhKq2VB9LplGjTk=;
	b=EG8mB8Y2/75nprP3vDQp+BiPF4vTU1r0xn9MVUgmJodrtj3OT9fz8f///xo/he7Ik6v4On
	9eF5Dx/YPxYprECQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Re-arrange the {EN,DE}QUEUE flags
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104526.729048003@infradead.org>
References: <20251006104526.729048003@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060721924.709179.15465733304415882859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     376f8963bbda5fee838eb1823b07562368104024
Gitweb:        https://git.kernel.org/tip/376f8963bbda5fee838eb1823b075623681=
04024
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2024 13:52:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:50 +02:00

sched: Re-arrange the {EN,DE}QUEUE flags

Ensure the matched flags are in the low word while the unmatched flags
go into the second word.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/sched.h | 45 ++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6546849..24b3c6c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2362,27 +2362,30 @@ extern const u32		sched_prio_to_wmult[40];
  *
  */
=20
-#define DEQUEUE_SLEEP		0x01 /* Matches ENQUEUE_WAKEUP */
-#define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
-#define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
-#define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
-#define DEQUEUE_SPECIAL		0x10
-#define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
-#define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
-#define DEQUEUE_THROTTLE	0x800
-
-#define ENQUEUE_WAKEUP		0x01
-#define ENQUEUE_RESTORE		0x02
-#define ENQUEUE_MOVE		0x04
-#define ENQUEUE_NOCLOCK		0x08
-
-#define ENQUEUE_HEAD		0x10
-#define ENQUEUE_REPLENISH	0x20
-#define ENQUEUE_MIGRATED	0x40
-#define ENQUEUE_INITIAL		0x80
-#define ENQUEUE_MIGRATING	0x100
-#define ENQUEUE_DELAYED		0x200
-#define ENQUEUE_RQ_SELECTED	0x400
+#define DEQUEUE_SLEEP		0x0001 /* Matches ENQUEUE_WAKEUP */
+#define DEQUEUE_SAVE		0x0002 /* Matches ENQUEUE_RESTORE */
+#define DEQUEUE_MOVE		0x0004 /* Matches ENQUEUE_MOVE */
+#define DEQUEUE_NOCLOCK		0x0008 /* Matches ENQUEUE_NOCLOCK */
+
+#define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
+#define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
+
+#define DEQUEUE_SPECIAL		0x00010000
+#define DEQUEUE_THROTTLE	0x00020000
+
+#define ENQUEUE_WAKEUP		0x0001
+#define ENQUEUE_RESTORE		0x0002
+#define ENQUEUE_MOVE		0x0004
+#define ENQUEUE_NOCLOCK		0x0008
+
+#define ENQUEUE_MIGRATING	0x0010
+#define ENQUEUE_DELAYED		0x0020
+
+#define ENQUEUE_HEAD		0x00010000
+#define ENQUEUE_REPLENISH	0x00020000
+#define ENQUEUE_MIGRATED	0x00040000
+#define ENQUEUE_INITIAL		0x00080000
+#define ENQUEUE_RQ_SELECTED	0x00100000
=20
 #define RETRY_TASK		((void *)-1UL)
=20


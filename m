Return-Path: <linux-tip-commits+bounces-7703-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA47CBCE81
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 09:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE68303D684
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F532AAC0;
	Mon, 15 Dec 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKyBMb3W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LIyg+R5s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE7329E6B;
	Mon, 15 Dec 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785562; cv=none; b=eie4rIStCGZaId12e37Oe64nBGP+GBw2TVlPeJ3gAPfMBMLoKO03fP0qNiOClRDe5Df4eQE/+Si8Fn9TS8/ztM5dxgkQsLX0mZIw5eU7oqS7obw3njmHUj1571we90gSmILLeJuiCQfQ0NgapUORc+IT99UMknfhMSyLC0sMnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785562; c=relaxed/simple;
	bh=EuXMSQ5FsS+xs7+xs+TzwAWziK+N3qzDweeB4b4ICJo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R+IUgsguhOYgkxfk0bPyrkOVprZgTcTcK7s+i0QxnHxPgnQyhson7UjVNjEdjwMaCLYjU5Ode110gRdLQKOfx7K7R+ogeq3SbJDY+JRCXY0evXvdJXT+Xx2BFtQgIiYt7Vatw1LLGcjrtyx0h6GiVpFCPHYAUVxdHkBzv8MwgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKyBMb3W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LIyg+R5s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765785556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3NJ791t9hYUT/zAYj5aEIp62aC/K5LbakGGBPdqL0Tg=;
	b=NKyBMb3WA1iVhH3Xl54CxEKhaFFkZT3BLLEFW2XjwfDrpou851W8Wdp3RcgSZ96okkS73U
	mqZd+nFCh2S4jFaT6i87lgF9QsqBr/RWEMM9sVqfzGb5OyvsFGcBiiCdY0axny2kZDBbrf
	PjMzvM0XLkECKIvN9t8blMlYWT9iUTZkiDtkvgoUzYnKnhOo8ip892odHuxCfRhbDGPpap
	kMCz2yVNlxiHplgDXiEjW/C1O/wFc4W8D/djdGYgGKmxalcCRZAY47egyGu0mLyVvz9bM/
	anwdazQZv9k2JSUPKQ235oaCp5UCaL1IcAbJ+SHwv63kn0QrTXHv6NhtSFpbTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765785556;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3NJ791t9hYUT/zAYj5aEIp62aC/K5LbakGGBPdqL0Tg=;
	b=LIyg+R5sf+I2A1un6fvkv3B0PzDEcHh/KEltwe8xrGFoLVGmsMICsFiifCBnqDF3Luk7W+
	epv3iVY8t9tQvFAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Join two #ifdef CONFIG_FAIR_GROUP_SCHED blocks
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201064647.1851919-2-mingo@kernel.org>
References: <20251201064647.1851919-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578555504.498.12526457652376516562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2b8c3d3dc9b1ee323e2982945088e3f5eebdf3dd
Gitweb:        https://git.kernel.org/tip/2b8c3d3dc9b1ee323e2982945088e3f5eeb=
df3dd
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 26 Nov 2025 11:31:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 15 Dec 2025 07:52:44 +01:00

sched/fair: Join two #ifdef CONFIG_FAIR_GROUP_SCHED blocks

Join two identical #ifdef blocks:

  #ifdef CONFIG_FAIR_GROUP_SCHED
  ...
  #endif

  #ifdef CONFIG_FAIR_GROUP_SCHED
  ...
  #endif

Also mark nested #ifdef blocks in the usual fashion, to make
it more apparent where in a nested hierarchy of #ifdefs we
are at a glance.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://patch.msgid.link/20251201064647.1851919-2-mingo@kernel.org
---
 kernel/sched/sched.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a40582d..2173e3d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -726,9 +726,7 @@ struct cfs_rq {
 	unsigned long		h_load;
 	u64			last_h_load_update;
 	struct sched_entity	*h_load_next;
-#endif /* CONFIG_FAIR_GROUP_SCHED */
=20
-#ifdef CONFIG_FAIR_GROUP_SCHED
 	struct rq		*rq;	/* CPU runqueue to which this cfs_rq is attached */
=20
 	/*
@@ -746,14 +744,14 @@ struct cfs_rq {
 	/* Locally cached copy of our task_group's idle value */
 	int			idle;
=20
-#ifdef CONFIG_CFS_BANDWIDTH
+# ifdef CONFIG_CFS_BANDWIDTH
 	int			runtime_enabled;
 	s64			runtime_remaining;
=20
 	u64			throttled_pelt_idle;
-#ifndef CONFIG_64BIT
+#  ifndef CONFIG_64BIT
 	u64                     throttled_pelt_idle_copy;
-#endif
+#  endif
 	u64			throttled_clock;
 	u64			throttled_clock_pelt;
 	u64			throttled_clock_pelt_time;
@@ -765,7 +763,7 @@ struct cfs_rq {
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
 	struct list_head        throttled_limbo_list;
-#endif /* CONFIG_CFS_BANDWIDTH */
+# endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
=20


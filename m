Return-Path: <linux-tip-commits+bounces-7651-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 433EACBB765
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B4743004CCC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D02BEC2C;
	Sun, 14 Dec 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iv3DoUCf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Te6I9/Fj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BD29BDBB;
	Sun, 14 Dec 2025 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698407; cv=none; b=OBN7YL7y6Xv1KDsyEmItg/cvR2w+r97LaO7khH0AWfEIOKylZosO51BmRFCURVuSyZ2KLTN1TtI3pKuSA0F4gktJpVWMLKvelZTjm62+mGW6cEtmjGdt1s0jzMn5QBVx7bgauTiGkYNy/QbJ78lL66FuWtao9jBAAsK0/P8o5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698407; c=relaxed/simple;
	bh=agl6L3mVK7hdNzc8aqJVqqiUKD4ZOK7rFE5SSI+RLQE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kr+w8i80gq8Kj9LEyaP5wHqUQByJz/qjAtv3CM8qJOMTDpnwWbujJ7gKUCO9to/47FzrvPhBuMtGJqg20teKrSeI3K0hhbnoCnsRwniRsEltgdBAgPIiu7rjpD9qY9uRC0Fh9+/7pHBzXQDywZcF+Ecc9mMz6GsILWwvbSPgffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iv3DoUCf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Te6I9/Fj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EnhTWmedq++xUysDFpRKFMGr0st2Fx9pXG5nYUxY2w=;
	b=iv3DoUCfftfOaXnPNsO8SwBgLTIcE/o6IEBBMU8nLVmYXIq+uJsOdGJqbEeQTwmQyR0rmd
	Clg7OL41/37/VpDeJAPp2Smn8UWRzwl0gN/4G1yjiF/t+YmqsTCzEVn7cNCci+0FG4uwSX
	kuUbc04pk8xSjoMT1CI3SXTrqmaBSxrthPGQlOpgqELbjJedmeCUqOll8JnfeQIgGffiHQ
	TvoFmvA9WN9m/eeTS4vK9uAlo+RpUZ2rAcjRW7J073ofvUNmJMYc512c+4a2z4XMx77zuC
	GvPx/ZvOo15sGQrrM2z79fJb6hI3I+MhVitiKlx0Ak9eysFdG+KyGQnZULHLKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EnhTWmedq++xUysDFpRKFMGr0st2Fx9pXG5nYUxY2w=;
	b=Te6I9/FjoideNbAPi5ZSfM/uHDNUe0rkgyDu9PnDhrhHMFlSvZjBkJ7eY4gZ+3W5dPzabG
	ubh1kK5AAUPKtLAg==
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
Message-ID: <176569839993.498.1351325693052440713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7e1f73851205657e90e34a4013d86d129ed514a1
Gitweb:        https://git.kernel.org/tip/7e1f73851205657e90e34a4013d86d129ed=
514a1
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 26 Nov 2025 11:31:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

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
index 467ea31..f751ac3 100644
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


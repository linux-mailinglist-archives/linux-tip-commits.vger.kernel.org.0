Return-Path: <linux-tip-commits+bounces-7593-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F756CA13F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A573324F220
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8783164C5;
	Wed,  3 Dec 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OYQhEMvI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R15nnqrZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63A314B8B;
	Wed,  3 Dec 2025 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786316; cv=none; b=YYREMreBRkkVmLWgcUWZ5G6PZrmpKGtmkgxxcuhma7RVQ0sycU/ozPEjFJKKG3M2xiYLaetH4IXjIqHa08zL06ayj9XfzB4BOHkeUdJ9I8Lerf+YrtJalM131l5AVPkg/cqk0oTVedMU+pFNOUsK6NUDBbdJnqdj/J0cCPI8sFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786316; c=relaxed/simple;
	bh=9YkRU4hMS3tCbAoiPkwINC/wuxZS1mTDy3GVppXk68w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XX0YF4pwYlhwspBYTQbVacVBc0Gne4opv+vI9SOyg4M+IptIigKau3YkbuVopcZCCY5iLC88NLLTwF8OMAxPw1tRYhjtczcRMTJaH2T4tdcEwSs9HfdKAU4SIBo5f0VqAHUiys87C4sHhIEbBQ3Mo0eb8aXUJFfYgjdAg7sh/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OYQhEMvI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R15nnqrZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:25:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEvbMBLibL3VBgU8Rjk/+4TD1V3vQnUzhqA2I6OZUU0=;
	b=OYQhEMvI3j3hp5Drt45n02OMNIbaPmGnNyIE7ryY0SI1aXGeYUWbVNsM6qYKWBIyAZTnO7
	GPSVJFLmK2iukPEdb32aurnJ8rBgtHTqU/vnuHpu1FSoKy3OJsLbqTKlDz3Oio6mHNV2SS
	+HzZZ+8M/LXbeA+DTI2Wqa32+uOuFEVC4QhqZli/bY6ILAgnxPi9wxHsLe1CR7MM4eXDdg
	pgxdMaAeQKoA5PEXwxMrOJqnkuNaUpe1bsKywtWGGeS0eC4DTk3hZIZgRWah4yUkEAr7TI
	y6rCMkgCJyQLJSLrUh418IWI6NNbIbJrTYYlEVJGYF9HXHGXmVFmjw/yXTwe2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEvbMBLibL3VBgU8Rjk/+4TD1V3vQnUzhqA2I6OZUU0=;
	b=R15nnqrZVVesSflykxJhycbaIGHY8edU0wRC8NKcqoqDHTMsyJ7v+24S9K1CXAgciTh8m9
	le5dvDDWSVNiS0Dg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/headers: Remove whitespace noise from
 kernel/sched/sched.h
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <176478595428.498.13816176784792752599.tip-bot2@tip-bot2>
References: <176478595428.498.13816176784792752599.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478630979.498.684043438307356926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e5865c256af0707df79e478235d6603e069dd90e
Gitweb:        https://git.kernel.org/tip/e5865c256af0707df79e478235d6603e069=
dd90e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 18:19:14=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:21:54 +01:00

sched/headers: Remove whitespace noise from kernel/sched/sched.h

sched/headers: Remove whitespace noise from kernel/sched/sched.h

A single case of space-Tab noise snuck in recently.

Fixes: 36569780b0d6 ("sched: Change nr_uninterruptible type to unsigned long")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/176478595428.498.13816176784792752599.tip-bot2=
@tip-bot2
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b419a4d..25241c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1165,7 +1165,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned long 		nr_uninterruptible;
+	unsigned long		nr_uninterruptible;
=20
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	struct task_struct __rcu	*donor;  /* Scheduling context */


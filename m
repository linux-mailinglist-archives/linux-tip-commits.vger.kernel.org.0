Return-Path: <linux-tip-commits+bounces-5959-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C8BAEF9A7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013A53AA373
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA1819FA8D;
	Tue,  1 Jul 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7Aun8vo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z/YaWViX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8D1E1E1E;
	Tue,  1 Jul 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375032; cv=none; b=ZFwDFyyXWdXus89EaUwail/7nE+yJWdt5fzmkGlgZe4gP3uUKNbY7t8iY8UouCD5IsGbLv1kA2FUQd97g/B5WLqEcgpUD5NDqZXAjY+OIlmQ+ZjvcuuAHzy3kZ+CiN5TGOKirpmgoFrAqVFXQ8cYUb8JmeUpGpeSLumG5u17Z8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375032; c=relaxed/simple;
	bh=S5Hg+X8e2QzihCzBoLqZb5BH+cwrADcuS8qO3Y0d4Bk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n4inSNFkvO4xClRz2ikCIwPIKiNEbHHF/YabyNhuyc/1J7VCUX7TkWt80DfWnTqqOGmAcKZb9aV6BkTjGr6Q1tw6ab+LI/98pPMHi7htyS0gZvJM0bowTJV3vzyTFpIlYEuDWwWBsnQ0vnUwHuAi6/ogx4NhLRVvlhTENMwucrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7Aun8vo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z/YaWViX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:03:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751375028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15D30aEIUIhpwgRWWRYtkuHH+V1ByXaSPG/UNQ5EUaQ=;
	b=Z7Aun8vongnqUTEAaj+0taqyhKpFcvL2rftQZ7nb/Hd/UsD4icmCQfS1uJ7alOwcKPslhm
	CFsSAHMmpPiF49KsS+SifpdiCq3fJNh2oGBYASyuuDXFJ1TiA0OoU1JiFmSONgR7ofWWqK
	NXE4h1faPJP6lQz764MrxQvM04c20Nr3HpVqVX1iqfLl4CwDSHRZv0oqY7euHsqWnxQ/3M
	KvErxRO/p/zGiJqllw1fnvNdO3iKowo+COX4g/bk9VHDOJ6/6J4x6QshikawB70tJU0LVq
	tbCM/ZI081u/8rBGK7CBRSipF+U9OSmByvj1MkR+tUHP8tw9Hsj6/2x27YK3sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751375028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15D30aEIUIhpwgRWWRYtkuHH+V1ByXaSPG/UNQ5EUaQ=;
	b=Z/YaWViXgAacIqK5pc5oXJw4SRixm2SXjUiLlvjwZ8rmV+Hb6NFq9G4219j3eefOfEZSTq
	3Q40dzaSxuuH2TDA==
From: "tip-bot2 for Luo Gengkun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix the WARN_ON_ONCE is out of lock
 protected region
Cc: Luo Gengkun <luogengkun@huaweicloud.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250626135403.2454105-1-luogengkun@huaweicloud.com>
References: <20250626135403.2454105-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137502738.406.18395407234477293993.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7b4c5a37544ba22c6ebe72c0d4ea56c953459fa5
Gitweb:        https://git.kernel.org/tip/7b4c5a37544ba22c6ebe72c0d4ea56c953459fa5
Author:        Luo Gengkun <luogengkun@huaweicloud.com>
AuthorDate:    Thu, 26 Jun 2025 13:54:03 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 30 Jun 2025 09:32:49 +02:00

perf/core: Fix the WARN_ON_ONCE is out of lock protected region

commit 3172fb986666 ("perf/core: Fix WARN in perf_cgroup_switch()") try to
fix a concurrency problem between perf_cgroup_switch and
perf_cgroup_event_disable. But it does not to move the WARN_ON_ONCE into
lock-protected region, so the warning is still be triggered.

Fixes: 3172fb986666 ("perf/core: Fix WARN in perf_cgroup_switch()")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250626135403.2454105-1-luogengkun@huaweicloud.com
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7281230..bf2118c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -951,8 +951,6 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
 		return;
 
-	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
-
 	cgrp = perf_cgroup_from_task(task, NULL);
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
 		return;
@@ -964,6 +962,8 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == NULL)
 		return;
 
+	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);


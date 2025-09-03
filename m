Return-Path: <linux-tip-commits+bounces-6428-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11649B41827
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910703BDF24
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC82DECC2;
	Wed,  3 Sep 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJT96RRo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfh3UxXn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9D16FF37;
	Wed,  3 Sep 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887372; cv=none; b=OJwFAbwRFrKX7hKVTvyKkrOSCAr3E144eHeoN6F/YKIzkthyWbxvT+dJ3gibxPUF40PCX4SXCuMVjeTHjXZTABDGn/BFBoUNbzXOKSUhpkce7h+Cyt7dSFaTq2o7J37U9/tTioM1gI3ilNLNfbfvx3usDdR19m9RyjfBTKHPKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887372; c=relaxed/simple;
	bh=ZZW1QJ9cApbJYvCqSQ30eEBa2jpGyXAN9jGlT7L01wI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KzccnltRCy+rVFQ+p3OK91fP6wpBzg2g78gHPGNjFyDcdjBsFIhLhQ/mjUj15l1h+RJz8wJc59H+h/VsRhn1I9y7oW3lCm7RmrXTtwI3vKfbip4TAnK9LRMsoNyqsDKZ265L6Gbm3nVu/+LAEqnmro1sJdawR8u1pPgn7Rf5Kuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJT96RRo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vfh3UxXn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756887369;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sV7X87U4aeZhdE4WwSESmlaSklS7xixQO49yvBM4j4g=;
	b=GJT96RRouZ3gqXG71Alu86uvPbhM121lomAZIG4y2KzIa122gSNJULOolbb7KZs2yGndg1
	pY0VcqrLYUECUsmpJSXeek+P6uhjJ5ijGOKpuTL+SdEkIwZAISCM32DtrDiInqhVGeDE4D
	0yAlMh5rBRDVKxIW63gpwPi4v4DOnVKXEfjUENjZ+OmSeI/BN1FeaXoHg80J5vKmjIA5lz
	+nNlydA8odjAgXCF0eTEn1r6jjnKUe5z2BcskDHyKMb0yHgJ8qlw0FX3ByVyFhgCG7+W4o
	a6J0Zcumzs1bxl7z3wjMBbFTff4HU7TUWta0C13j5avZ4fl0hmjZSNxyBpfulQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756887369;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sV7X87U4aeZhdE4WwSESmlaSklS7xixQO49yvBM4j4g=;
	b=vfh3UxXnHJBsf2YHCfT9B2mKOJ//88Wx4aOEs1RGDOq777+DchtcqDMox5dT23jGeqtcuf
	4qD94wxHJWih+sAw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix the POLL_HUP delivery breakage
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250811182644.1305952-1-kan.liang@linux.intel.com>
References: <20250811182644.1305952-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688736802.1920.7630470115367445255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240
Gitweb:        https://git.kernel.org/tip/18dbcbfabfffc4a5d3ea10290c5ad27f22b=
0d240
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 11 Aug 2025 11:26:44 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:10:59 +02:00

perf: Fix the POLL_HUP delivery breakage

The event_limit can be set by the PERF_EVENT_IOC_REFRESH to limit the
number of events. When the event_limit reaches 0, the POLL_HUP signal
should be sent. But it's missed.

The corresponding counter should be stopped when the event_limit reaches
0. It was implemented in the ARCH-specific code. However, since the
commit 9734e25fbf5a ("perf: Fix the throttle logic for a group"), all
the ARCH-specific code has been moved to the generic code. The code to
handle the event_limit was lost.

Add the event->pmu->stop(event, 0); back.

Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Closes: https://lore.kernel.org/lkml/aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a=
85c-a78bff51fc11.ibm.com/
Reported-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Link: https://lkml.kernel.org/r/20250811182644.1305952-1-kan.liang@linux.inte=
l.com
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 872122e..8201275 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10330,6 +10330,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 		ret =3D 1;
 		event->pending_kill =3D POLL_HUP;
 		perf_event_disable_inatomic(event);
+		event->pmu->stop(event, 0);
 	}
=20
 	if (event->attr.sigtrap) {


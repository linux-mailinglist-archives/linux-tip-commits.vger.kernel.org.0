Return-Path: <linux-tip-commits+bounces-6265-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AECB29F0D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F180177997
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6F0318144;
	Mon, 18 Aug 2025 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4af6SXrN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cuOV20d4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC6315791;
	Mon, 18 Aug 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512547; cv=none; b=c0oqL+zHvx/rc17e8N0nOrCskXIHk9wQrPPI63ACmrtOf/tKm2b5stt8gyvv58e+Un9Muzz3c/LfqXdJPf+oJqtUFUT3lV/+DlDfy7tk9PepCDqVfMY2JDotuk8P8DJhyAyJbOu13KgDtb0zdSLewgRq1LOvZ4UvZ/33nAHJGAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512547; c=relaxed/simple;
	bh=LV9/0rXsnTWMLw4AtMuaqVbpa8r0I1hDjlDnkmnnRRA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d7NuLe0i5Gg7baTuO2FqhXo0hykYYP/Vj9gFk96lKbQeqU+Y3YplsnsVLKIUNQazB8AbjWFaEh5v1ntr/wnWvaapA+TW7KN2MW8EqyLID8ZpBrSxWo4M01BcJXqNf1miq/ZCejm5E2EklpxWFp1CWJFj0FQ+Nejyws96KyXZpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4af6SXrN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cuOV20d4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpO46FAGx3KykVCWaFfz+GTCBSVFGV0W19QlYgUYXJU=;
	b=4af6SXrNR4L35zVNQcQyQqU1RxrgtgAbHAV5o5D2ehT75YXK7sT2arrUUDxx/AuJR/yUuq
	juDUebnpTMxX4rU0xjMXPmhvr7O4BHO61yjO/uW3I/63UQToShCN24g+ZndvtP2FIkYQG5
	8m//39DkKQ58ZfhShPqFoy5KmOlbefa3gCeeBaIvUsYKI+wDPn6GLZC4qy91Vc+rT7nCNI
	HU7xElEuPs1L4Vtgz9VjRpT8qTQchbO0pM8t5WZ+B9GmbxtNeyt34jQ1q783RdLG8zNvmc
	mglV14IzYtzWIXfHjj733T8EYwpvaAddhLhfZ5z0vS4DqdN4/tBgzSB4140EmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpO46FAGx3KykVCWaFfz+GTCBSVFGV0W19QlYgUYXJU=;
	b=cuOV20d47nhFvNcGWtKjXwRvIj+hZssm8k/W0CfaK9vUbfA0EYeUB4Fhqm27DFaz3/HL6B
	ZmEOyWf4iPDMBzAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Use scoped_guard() for mmap_mutex in perf_mmap()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104019.838047976@infradead.org>
References: <20250812104019.838047976@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551254231.1420.3762486862116091229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d23a6dbc0a71741eb7b141fdc04e31360fba46ef
Gitweb:        https://git.kernel.org/tip/d23a6dbc0a71741eb7b141fdc04e31360fb=
a46ef
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:13:01 +02:00

perf: Use scoped_guard() for mmap_mutex in perf_mmap()

Mostly just re-indent noise.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104019.838047976@infradead.org
---
 kernel/events/core.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3a5fd2b..41941df 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7146,30 +7146,23 @@ static int perf_mmap(struct file *file, struct vm_are=
a_struct *vma)
 	if (vma_size !=3D PAGE_SIZE * nr_pages)
 		return -EINVAL;
=20
-	mutex_lock(&event->mmap_mutex);
-	ret =3D -EINVAL;
+	scoped_guard (mutex, &event->mmap_mutex) {
+		/*
+		 * This relies on __pmu_detach_event() taking mmap_mutex after marking
+		 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
+		 * will detach the rb created here.
+		 */
+		if (event->state <=3D PERF_EVENT_STATE_REVOKED)
+			return -ENODEV;
=20
-	/*
-	 * This relies on __pmu_detach_event() taking mmap_mutex after marking
-	 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
-	 * will detach the rb created here.
-	 */
-	if (event->state <=3D PERF_EVENT_STATE_REVOKED) {
-		ret =3D -ENODEV;
-		goto unlock;
+		if (vma->vm_pgoff =3D=3D 0)
+			ret =3D perf_mmap_rb(vma, event, nr_pages);
+		else
+			ret =3D perf_mmap_aux(vma, event, nr_pages);
+		if (ret)
+			return ret;
 	}
=20
-	if (vma->vm_pgoff =3D=3D 0)
-		ret =3D perf_mmap_rb(vma, event, nr_pages);
-	else
-		ret =3D perf_mmap_aux(vma, event, nr_pages);
-
-unlock:
-	mutex_unlock(&event->mmap_mutex);
-
-	if (ret)
-		return ret;
-
 	/*
 	 * Since pinned accounting is per vm we cannot allow fork() to copy our
 	 * vma.


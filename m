Return-Path: <linux-tip-commits+bounces-6264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C49B29EF5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B84E29DE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE854315794;
	Mon, 18 Aug 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAZukk4S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Y0LLpay"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34849310781;
	Mon, 18 Aug 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512545; cv=none; b=oh2pcUqS/wN1f2J+9JGQ5saf6SybjJT/XwfLcJCwToc5MeUT0DHoqZ+u5s6k7UWec5OtKo+qItrQSnj4B0KeuY99EWJ9w7iauRsgcADPYXepsDjYFuzYcu/uzSpWhkUu8xUwz5TRi9PRIVH8eTjEVmN3WTiXce1WSW9oRif2sqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512545; c=relaxed/simple;
	bh=m3+kPG7phNOUIlkygU89zmX/g5b0e15Y2Xw1s3+WoS8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m6yBCteYiZvGZmhCJaN8LIqoiBIY96aUXVgasiuFIxldREqv68FdQ0pARhZPAjtWakA0+xgSF0h+1zvyvXjn5xW7ua3qaUSwodtLdU0req0JP8hZQV32IEeLPF0cdffmSENzEpmYYTUoixcZxr0rovqrmW1Zn8NUuWWGRLEucrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qAZukk4S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Y0LLpay; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIANA1wkLnraFp8iJSufp9XkMQsTV+JL5aZ0B38MVn4=;
	b=qAZukk4SbEv/PLPrQGjJVvftqCSp2J+IBy9K7B9DqDirIA5h5xcVRyN/lQhgHn0sTLKO/0
	sLIIRxZbErlnDoJ72XwjC3f3AdrrgZJniay1jPz3aHpEpDOZE707dwO6uzynVHKnuERrro
	fCEClBAHZD7fFFEd22yge/b+hmf+4NMSpufdtfCKvZNO0WT9je9dTaJwT4r+ycbiTojNI+
	Y1RAGuRp0P3oFNQgPb24Lc8Y4GFpvGr5inCKM8k73nanNdQ2/mz5+VAt7r4tqdr1pG1QW3
	Wlco4po30c7TkG32nB882/gcCt7yAoupj5mtRLtOF3KVJyDZX6TJjpUdA6nUog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIANA1wkLnraFp8iJSufp9XkMQsTV+JL5aZ0B38MVn4=;
	b=4Y0LLpay8MOSXZx6DeGk+9jUD5v8zlKKNaB62vCbG2XkjIUIdlKYwp29XnMZraebjH00pd
	nYPRPqDRF/ObZiAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Identify the 0->1 transition for event::mmap_count
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104019.956479989@infradead.org>
References: <20250812104019.956479989@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551254020.1420.9814271943292016323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     59741451b49ce9964a9758c19d6f7df2a1255c75
Gitweb:        https://git.kernel.org/tip/59741451b49ce9964a9758c19d6f7df2a12=
55c75
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:13:02 +02:00

perf: Identify the 0->1 transition for event::mmap_count

Needed because refcount_inc() doesn't allow the 0->1 transition.

Specifically, this is the case where we've created the RB, this means
there was no RB, and as such there could not have been an mmap.
Additionally we hold mmap_mutex to serialize everything.

This must be the first.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250812104019.956479989@infradead.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 41941df..f6211ab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7034,7 +7034,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, str=
uct perf_event *event,
 	perf_event_update_userpage(event);
=20
 	perf_mmap_account(vma, user_extra, extra);
-	atomic_inc(&event->mmap_count);
+	atomic_set(&event->mmap_count, 1);
=20
 	return 0;
 }


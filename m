Return-Path: <linux-tip-commits+bounces-5510-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61930AB041F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCCD3A356E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C228C2A9;
	Thu,  8 May 2025 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nes9HDFV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cNV8yMgH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79328AB07;
	Thu,  8 May 2025 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734122; cv=none; b=soZ6B6Y98CrjoU5lLJoHaGWuO1bKGClnCOh0v+buqVbN4tR046+kAXPgwQpuRv3WayBUP4cri4AMD7Oq0rTh986bgSmadIFwzCdZ0eRtO5bIV4K3wyE0IEGiKMHF7syEyUBxImpLVeThPHVbAjeqh10dO/BXTYXE5B/2ms9WzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734122; c=relaxed/simple;
	bh=CK0t9cJNPiohA7U6VrTawN2ImWwY9f5GAj6+i9bjzNc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vGTM3OSbFIuGH7+TUtUzkvkflZ5d3N9A45ehEZ1YO/Z4XZ32kCaXYD7ARNhHOtgn3kJMnk0HL30b+Tk80dNNk9NH68ZNIJdcbtcP5/P/0EReY4Fb0ciOdpZljWiYZ51BYZDLm2OuHvZ/R1GDv9bP9gNBju41v8B0qiDCY77Fe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nes9HDFV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cNV8yMgH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 19:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746734119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siNDSESzLlnGOv9tiEV7pGvjDx2pwY3p8vKTGiSB9tE=;
	b=Nes9HDFVrkWfnrG1nhCcIb0fsw30xhEVYJFQCkq+a2nishHDQMd8XqbR+tkejAqdweif/P
	9vXj7Neyzg2J8PIUnn1PCQG+vX0ekNTxFjY3MWqfLJ5nWqMBA04CzoS0PZFCLboeRLYf9h
	OT4KKC/akOQRLu2rdsB53M+fhSpEQRUx/kZJRgNfGIBGvWU/6XngusJqbUac5A+e4vSF5L
	re65zSkLdAb/809r0/vK5FnrbFh5sZVDI1M5TFNqWIe2EXBVmEfb+KPK58KJol9UF8wPfM
	F9OUnicetyZCGjedHblwEXBGeZAVY3wD4VqsjSZFIyenDVjyML7NLvxnU1bNIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746734119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siNDSESzLlnGOv9tiEV7pGvjDx2pwY3p8vKTGiSB9tE=;
	b=cNV8yMgHCNQdqPtEGYpZWBRna0RJrPdmYhlzYMpuEkgD/dMC6l8Luc6yEcxIJrWBNvTE56
	9tAhR9CO+X+zd4Dg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix failing inherit_event() doing extra
 refcount decrement on parent
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424161128.29176-2-frederic@kernel.org>
References: <20250424161128.29176-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174673411813.406.11065501391492821247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     22d38babb3adcb1227ecfb91d9423008a46548fe
Gitweb:        https://git.kernel.org/tip/22d38babb3adcb1227ecfb91d9423008a46548fe
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 24 Apr 2025 18:11:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 May 2025 21:50:18 +02:00

perf: Fix failing inherit_event() doing extra refcount decrement on parent

When inherit_event() fails after the child allocation but before the
parent refcount has been incremented, calling put_event() wrongly
decrements the reference to the parent, risking to free it too early.

Also pmu_get_event() can't be holding a reference to the child
concurrently at this point since it is under pmus_srcu critical section.

Fix it with restoring the deleted free_event() function and call it on
the failing child in order to free it directly under the verified
assumption that its refcount is only 1. The refcount to the parent is
then voluntarily omitted.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424161128.29176-2-frederic@kernel.org
---
 kernel/events/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 05136e8..882db7b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5628,6 +5628,22 @@ static void _free_event(struct perf_event *event)
 }
 
 /*
+ * Used to free events which have a known refcount of 1, such as in error paths
+ * of inherited events.
+ */
+static void free_event(struct perf_event *event)
+{
+	if (WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1,
+				     "unexpected event refcount: %ld; ptr=%p\n",
+				     atomic_long_read(&event->refcount), event)) {
+		/* leak to avoid use-after-free */
+		return;
+	}
+
+	_free_event(event);
+}
+
+/*
  * Remove user event from the owner task.
  */
 static void perf_remove_from_owner(struct perf_event *event)
@@ -14184,7 +14200,7 @@ inherit_event(struct perf_event *parent_event,
 
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
-		put_event(child_event);
+		free_event(child_event);
 		return ERR_CAST(pmu_ctx);
 	}
 	child_event->pmu_ctx = pmu_ctx;
@@ -14199,7 +14215,7 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		put_event(child_event);
+		free_event(child_event);
 		return NULL;
 	}
 


Return-Path: <linux-tip-commits+bounces-2046-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC719513FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 07:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B44B1F25256
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 05:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB7641A80;
	Wed, 14 Aug 2024 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r+wWkGYB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oIRvLSPj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9020B0F;
	Wed, 14 Aug 2024 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614240; cv=none; b=Jb3Fn0MEIQ2h8zXtjFpYrSvp2LYeCywb9Nko/RZAwCFEHjUmCX4KafMapSqYoOGmsio0Jt4tX7yymXcvj4pLlt/+w0oIktlubdI3enfMN0Sn+YegeDiRfJoEkFvsSHpuzIzRLkSB+ndL6+Vm/XhvGWgHla6ANTKj//uFw15Uy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614240; c=relaxed/simple;
	bh=Po7+jfmpHgBYwd8GKQngogAk4ImzWdPJ+1iB9htAukI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QT7UiwRSVnlkWcrV4ieuceU8saJduVVLp2uDaDF0Ptkn+MaIcPGxrP302dvUaq+3tcQMY8Hz+kjGyXw5gT8s8fIWZypKyoHHFs711kkaGQNN0OqgjAtuH3DPkIQ0DCs9HB2q8vHoW+MebVtv87IOQAxPTiKSbD7vnEvrP2H6ogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r+wWkGYB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oIRvLSPj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Aug 2024 05:43:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723614236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3TtCRdPcSTZkNX1gEfswQxh7x6hVAuRaTuDKoZvcYvM=;
	b=r+wWkGYBa0wlXxfb0IJrs2R0e03spxHXX2Uv5z+Ny7H8b1pkChTQ3XQbt1SdGQY1PEbPmJ
	rmHPOF4dZG3vGU8JHZWmzF8ePeKMyPjxsddUttGIqIQVtgFsSIg2Vu6D66Frjh93E1xTjm
	mrSSh0ZHyO5gVLJzvn0EIhGiPFiANsi7J5+6zr8LcaqSD3Sg+dfQLr6XtcuOOzLG8ecnB8
	TCgYSNOas3yb/Nm6O4aNACS0mI5lWFobdPHQYIGXQVGruUC4faWKKOpAgWLBt1lbLDJ5wn
	fVUyNRdkBiZlXrlLOo3HjXL0b9DBDqg0dHVsRntguo7fwOq7ialB/Lrao8SLFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723614236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3TtCRdPcSTZkNX1gEfswQxh7x6hVAuRaTuDKoZvcYvM=;
	b=oIRvLSPjcdfDg3ukkso4IDWRCL/5hNfSyHb9mTNEnyWcHHSgeKnTURR88e5oZe0Uf6/Ojr
	Oz2M/jQn8bB8cACA==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Really fix event_function_call() locking
Cc: Pengfei Xu <pengfei.xu@intel.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172361423558.2215.17332323799213170213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fe826cc2654e8561b64246325e6a51b62bf2488c
Gitweb:        https://git.kernel.org/tip/fe826cc2654e8561b64246325e6a51b62bf2488c
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 13 Aug 2024 22:55:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 Aug 2024 07:39:09 +02:00

perf: Really fix event_function_call() locking

Commit 558abc7e3f89 ("perf: Fix event_function_call() locking") lost
IRQ disabling by mistake.

Fixes: 558abc7e3f89 ("perf: Fix event_function_call() locking")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9893ba5..c6a720f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -298,8 +298,8 @@ unlock:
 static void event_function_call(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
+	struct perf_cpu_context *cpuctx;
 	struct event_function_struct efs = {
 		.event = event,
 		.func = func,
@@ -327,22 +327,25 @@ again:
 	if (!task_function_call(task, event_function, &efs))
 		return;
 
+	local_irq_disable();
+	cpuctx = this_cpu_ptr(&perf_cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
 	/*
 	 * Reload the task pointer, it might have been changed by
 	 * a concurrent perf_event_context_sched_out().
 	 */
 	task = ctx->task;
-	if (task == TASK_TOMBSTONE) {
-		perf_ctx_unlock(cpuctx, ctx);
-		return;
-	}
+	if (task == TASK_TOMBSTONE)
+		goto unlock;
 	if (ctx->is_active) {
 		perf_ctx_unlock(cpuctx, ctx);
+		local_irq_enable();
 		goto again;
 	}
 	func(event, NULL, ctx, data);
+unlock:
 	perf_ctx_unlock(cpuctx, ctx);
+	local_irq_enable();
 }
 
 /*


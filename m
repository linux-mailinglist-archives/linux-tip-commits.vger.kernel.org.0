Return-Path: <linux-tip-commits+bounces-3608-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E07A42BB3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Feb 2025 19:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B6D3AFD87
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Feb 2025 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132C626657D;
	Mon, 24 Feb 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbhJmzOW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWX7kvZj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1426656E;
	Mon, 24 Feb 2025 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422204; cv=none; b=uTCZZkmWymeyCXu6Kkb4BgcpNekNYyugHClOXQnRHJVvQIRFk6mjKa7drpBgttK1jcs9IcVeZSw4jMlVGQPHrpk4qVdlVBegQuapatlALcrHL5X6kxzI9LD3nuvoCj8txRCerPVFMlZI30PjNhx5q+1623lCbzXPhVTHGUtmXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422204; c=relaxed/simple;
	bh=M4VPRT6o6MozbN+TH3tx4tc7aWbSW58mgJKcuBKG6ZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mu68BpwgGWW1ckx8HZ7PoPq0hA+ukAzP9wUuUNxmvVZkDxdVw0HbE7lgLXmSdEZYHwbwRfVixTLs5rSOT+Q9BacYLI6Zm8nFB6yZwbI6BuaoD0N3vh11sHq1Fo35AHnxllbw/ml9ZjeKieOUzcmraWiu39GQjoxIBlTmtNif1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbhJmzOW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWX7kvZj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 18:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740422198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiAFBPY73VaBh9CvFiz4PNXDthwdrgK2k3EDjPxurSg=;
	b=fbhJmzOWqh+C4Zde9yXFZv/HUyy0yNxedH0MVNFVRLaNTFWPFXTGKOBGLLqYwhMgD6mQSG
	LbYHATE10L9eX5ITRJNp/mfDLTKBOUyuS6kobFZ9+LFA20BtsPD7Eqw8Ut5szF7HuLtvGS
	zWq14IvuzrUcyC2nAUrc+LITL8/INT+54LlfXzHqURX+ijkF25tBn3ajnlBUkF2jEFnMzW
	D561NTJHOIneL7HhXNN5zma1+Vg3dFxx20wgrm5etzwgIUDdEghDyadqKFQU2wwsAhITqp
	vdKaJ4OsfGeWBA5gt21bzcchk+4aGoIR5N0H2I3rWbsXyEZjgkY/+gFpy/Uoxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740422198;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiAFBPY73VaBh9CvFiz4PNXDthwdrgK2k3EDjPxurSg=;
	b=CWX7kvZjzF+SlOw55sV00Q3Qxs6kAh6RBxLByNcBarcjqlNTqeuGYGL5IbZ36QU9QhN0Xg
	2M89ZeiErMiCqQDQ==
From: "tip-bot2 for Luo Gengkun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Order the PMU list to fix warning about
 unordered pmu_ctx_list
Cc: Luo Gengkun <luogengkun@huaweicloud.com>, Ingo Molnar <mingo@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250122073356.1824736-1-luogengkun@huaweicloud.com>
References: <20250122073356.1824736-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174042219525.10177.4368075939520286235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2016066c66192a99d9e0ebf433789c490a6785a2
Gitweb:        https://git.kernel.org/tip/2016066c66192a99d9e0ebf433789c490a6785a2
Author:        Luo Gengkun <luogengkun@huaweicloud.com>
AuthorDate:    Wed, 22 Jan 2025 07:33:56 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2025 19:22:37 +01:00

perf/core: Order the PMU list to fix warning about unordered pmu_ctx_list

Syskaller triggers a warning due to prev_epc->pmu != next_epc->pmu in
perf_event_swap_task_ctx_data(). vmcore shows that two lists have the same
perf_event_pmu_context, but not in the same order.

The problem is that the order of pmu_ctx_list for the parent is impacted by
the time when an event/PMU is added. While the order for a child is
impacted by the event order in the pinned_groups and flexible_groups. So
the order of pmu_ctx_list in the parent and child may be different.

To fix this problem, insert the perf_event_pmu_context to its proper place
after iteration of the pmu_ctx_list.

The follow testcase can trigger above warning:

 # perf record -e cycles --call-graph lbr -- taskset -c 3 ./a.out &
 # perf stat -e cpu-clock,cs -p xxx // xxx is the pid of a.out

 test.c

 void main() {
        int count = 0;
        pid_t pid;

        printf("%d running\n", getpid());
        sleep(30);
        printf("running\n");

        pid = fork();
        if (pid == -1) {
                printf("fork error\n");
                return;
        }
        if (pid == 0) {
                while (1) {
                        count++;
                }
        } else {
                while (1) {
                        count++;
                }
        }
 }

The testcase first opens an LBR event, so it will allocate task_ctx_data,
and then open tracepoint and software events, so the parent context will
have 3 different perf_event_pmu_contexts. On inheritance, child ctx will
insert the perf_event_pmu_context in another order and the warning will
trigger.

[ mingo: Tidied up the changelog. ]

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20250122073356.1824736-1-luogengkun@huaweicloud.com
---
 kernel/events/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7dabbca..086d46d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4950,7 +4950,7 @@ static struct perf_event_pmu_context *
 find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
 {
-	struct perf_event_pmu_context *new = NULL, *epc;
+	struct perf_event_pmu_context *new = NULL, *pos = NULL, *epc;
 	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
@@ -5007,12 +5007,19 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 			atomic_inc(&epc->refcount);
 			goto found_epc;
 		}
+		/* Make sure the pmu_ctx_list is sorted by PMU type: */
+		if (!pos && epc->pmu->type > pmu->type)
+			pos = epc;
 	}
 
 	epc = new;
 	new = NULL;
 
-	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	if (!pos)
+		list_add_tail(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	else
+		list_add(&epc->pmu_ctx_entry, pos->pmu_ctx_entry.prev);
+
 	epc->ctx = ctx;
 
 found_epc:


Return-Path: <linux-tip-commits+bounces-5998-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6747BAF8E52
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 11:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0426B1655AA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jul 2025 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1152ECD27;
	Fri,  4 Jul 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nhd00h6g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7liUHniS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCE2F5493;
	Fri,  4 Jul 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620408; cv=none; b=s43ERZjGrnnmSxJKXnIWzsQzNPe62Z036AZfZXBmbJWPfkdGm5L34FAA2EUpx2zR2ZMd8WP01F0UyrqV7QY7IqHl9TsnCtYCDiHE0p5nIpNHFI9Fq8KkBqVwhClFnqYHU2jJR1dnhh0z5Z0E72NbPWFzuQr81Rib6+p4ZDK0Nx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620408; c=relaxed/simple;
	bh=diogebFSP8aXq74Iso455LQJwx4Pgy52QOqqR48ucDY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yo/8NR7KfLsG7TrbBQ9m/uB83slS5+7ubOnd5Wq1vAuuG5Vbg7IrfjvgXUU75Q7x+Q+TsAtYZti9qLczpSe4sqW2Lc+dI3K9SwzA2qjBQk54ge25F9Y5Fi18aFZHaVWo5GwkuI6VaA6KZwsafijArC9RPOQ09FYrR7XAAthiW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nhd00h6g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7liUHniS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Jul 2025 09:13:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751620398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x653JVlYzh2z+/ikKk0N2ldf40BlcH63j5i2qtNYCAw=;
	b=Nhd00h6gqicqVCrNsPDoP4xMxef75eTMdVmGAr3Y24ifSbNlIoDvmahKOkOVL9m7hBbulP
	/DDeN/t9E+1rn+64JG+VgCOybum7Asi8YsPs+fdZX3Qiv3d9FIk3hOfoVqfJr0jmiTLubr
	poz3FTL8FEYChBCdyF5aWviSwLkQ4PLPf16yCc4gPMtXWBOizjj+y67oYgujmpa9H0Fsnv
	6jKxow3yrUqRbzbJOU4cmTgZCSRTzEtJIMlMojXsC3yPsmjHG4PY8tmWMgJkzTCF2V+nHD
	h/G8aemHxuwNln/muKubgbDbGde+dzYkSrxaTLiqCfuIv2qm/u2g8kJ1i/IK9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751620398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x653JVlYzh2z+/ikKk0N2ldf40BlcH63j5i2qtNYCAw=;
	b=7liUHniSB5YD1SxHyFbNKfzaInSsGUiSSENpVve0FnJXTJfOyE7DMgovMN4HGIREgDgWIv
	7+zb+J1XyO1Me+AA==
From: "tip-bot2 for kuyo chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/deadline: Fix dl_server runtime calculation formula
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>,
 kuyo chang <kuyo.chang@mediatek.com>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250702021440.2594736-1-kuyo.chang@mediatek.com>
References: <20250702021440.2594736-1-kuyo.chang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175162039765.406.4702062609825995302.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     fc975cfb36393db1db517fbbe366e550bcdcff14
Gitweb:        https://git.kernel.org/tip/fc975cfb36393db1db517fbbe366e550bcdcff14
Author:        kuyo chang <kuyo.chang@mediatek.com>
AuthorDate:    Wed, 02 Jul 2025 10:12:25 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 04 Jul 2025 10:35:56 +02:00

sched/deadline: Fix dl_server runtime calculation formula

In our testing with 6.12 based kernel on a big.LITTLE system, we were
seeing instances of RT tasks being blocked from running on the LITTLE
cpus for multiple seconds of time, apparently by the dl_server. This
far exceeds the default configured 50ms per second runtime.

This is due to the fair dl_server runtime calculation being scaled
for frequency & capacity of the cpu.

Consider the following case under a Big.LITTLE architecture:
Assume the runtime is: 50,000,000 ns, and Frequency/capacity
scale-invariance defined as below:
Frequency scale-invariance: 100
Capacity scale-invariance: 50
First by Frequency scale-invariance,
the runtime is scaled to 50,000,000 * 100 >> 10 = 4,882,812
Then by capacity scale-invariance,
it is further scaled to 4,882,812 * 50 >> 10 = 238,418.
So it will scaled to 238,418 ns.

This smaller "accounted runtime" value is what ends up being
subtracted against the fair-server's runtime for the current period.
Thus after 50ms of real time, we've only accounted ~238us against the
fair servers runtime. This 209:1 ratio in this example means that on
the smaller cpu the fair server is allowed to continue running,
blocking RT tasks, for over 10 seconds before it exhausts its supposed
50ms of runtime.  And on other hardware configurations it can be even
worse.

For the fair deadline_server, to prevent realtime tasks from being
unexpectedly delayed, we really do want to use fixed time, and not
scaled time for smaller capacity/frequency cpus. So remove the scaling
from the fair server's accounting to fix this.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: John Stultz <jstultz@google.com>
Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: John Stultz <jstultz@google.com>
Tested-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20250702021440.2594736-1-kuyo.chang@mediatek.com
---
 kernel/sched/deadline.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ad45a8f..89019a1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1504,7 +1504,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	scaled_delta_exec = dl_scaled_delta_exec(rq, dl_se, delta_exec);
+	scaled_delta_exec = delta_exec;
+	if (!dl_server(dl_se))
+		scaled_delta_exec = dl_scaled_delta_exec(rq, dl_se, delta_exec);
 
 	dl_se->runtime -= scaled_delta_exec;
 
@@ -1611,7 +1613,7 @@ throttle:
  */
 void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 {
-	s64 delta_exec, scaled_delta_exec;
+	s64 delta_exec;
 
 	if (!rq->fair_server.dl_defer)
 		return;
@@ -1624,9 +1626,7 @@ void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 	if (delta_exec < 0)
 		return;
 
-	scaled_delta_exec = dl_scaled_delta_exec(rq, &rq->fair_server, delta_exec);
-
-	rq->fair_server.runtime -= scaled_delta_exec;
+	rq->fair_server.runtime -= delta_exec;
 
 	if (rq->fair_server.runtime < 0) {
 		rq->fair_server.dl_defer_running = 0;


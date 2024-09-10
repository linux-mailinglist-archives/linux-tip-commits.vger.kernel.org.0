Return-Path: <linux-tip-commits+bounces-2281-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A69972BC9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1F1286FCC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9F319414E;
	Tue, 10 Sep 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQ61tk8T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FhLgjEUL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3E192D6D;
	Tue, 10 Sep 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955775; cv=none; b=K1r/s65C00ZnC2XnZ2akSpzxvWK6GYWEW5ZvCIhB0LdPN/eW7EZnHX+E9DLTeTd83mC48rXjpI2hfXaIx6C4wqFBdRwFtTxoIzblUEkhBbB5nlL3hEdr/yjT6SxVnkYUDwV+sBpSKlXGgg29exaHPs5Jsp0Rl/tOaNrWzPSVCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955775; c=relaxed/simple;
	bh=L/SGRmpeJNk4BOB+Z0bGtVtuh76i7wwNPSXerCPYv0E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n8b8cL9i9mcoDJOVpwJQGO5d+NfvalM33jZqCRsoxXnVQ3rST9WfSt4BL0aR61dBRR8Az5NHcIN7tuCvogA7B9hT6L6iJcp9nnjBa1gdcErQJKHXGrh9o0NDZVAOeY0eZTj/eW4O5TA9SXiJdcaZghTEX6uGeJ1gJk+xKoeewT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQ61tk8T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FhLgjEUL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIZ49JXL1v4k6wjblfYIxoL0ac4eNLaNvBin0IP8G7Q=;
	b=lQ61tk8T9ANg9ZQBImsGNV7obToFCiBwZ/C/xbDhgdvOD0W+cBxqhTHStLO2/9RdFcYg4x
	G6qa3q2swASNcS2a1k4yQ7xKHbxTgfZ3TeBE33ncxmsTBb9rFBvQeex9Z8vTju8cKt/LlI
	H18jI/DeSovayKHVCN5OxCozp+KfhMdwf2sSA4ycZTBCuWERl44D/QZQ7t0P8RRPdNhzZJ
	jJXHI4wTZjPUJuZaVCuVxzILvXAOA5qen1AKVAAIuk94TI7Q7oKlQxDVzXimkda4JvS/pL
	OsK0OrKQSNUNipLX5yxEvAOsNey5qTUtf0Jo/qc5nxZhi4otl6Qi/WKR9/9nTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIZ49JXL1v4k6wjblfYIxoL0ac4eNLaNvBin0IP8G7Q=;
	b=FhLgjEUL+SHMJP8UX1MaKagHnKRHn0oE2ksbeVwTq43P/ai3TaI96bIimKeNjKMa8nZ51Y
	eBMtF2STJCbm6cDA==
From: "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Use rq_clock_task() for hw_pressure
Cc: Chen Yu <yu.c.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Hongyan Xia <hongyan.xia2@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240827112607.181206-1-yu.c.chen@intel.com>
References: <20240827112607.181206-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576427.2215.5709980474741967775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     84d265281d6cea65353fc24146280e0d86ac50cb
Gitweb:        https://git.kernel.org/tip/84d265281d6cea65353fc24146280e0d86ac50cb
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Tue, 27 Aug 2024 19:26:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:14 +02:00

sched/pelt: Use rq_clock_task() for hw_pressure

commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
removed the decay_shift for hw_pressure. This commit uses the
sched_clock_task() in sched_tick() while it replaces the
sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
This could bring inconsistence. One possible scenario I can think of
is in ___update_load_sum():

  u64 delta = now - sa->last_update_time

'now' could be calculated by rq_clock_pelt() from
__update_blocked_others(), and last_update_time was calculated by
rq_clock_task() previously from sched_tick(). Usually the former
chases after the latter, it cause a very large 'delta' and brings
unexpected behavior.

Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20240827112607.181206-1-yu.c.chen@intel.com
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9e19009..e946ca0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9719,9 +9719,10 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 
+	/* hw_pressure doesn't care about invariance */
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(now, rq, hw_pressure) |
+		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))


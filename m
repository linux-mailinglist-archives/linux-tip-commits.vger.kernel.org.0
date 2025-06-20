Return-Path: <linux-tip-commits+bounces-5873-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D38AE1840
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 11:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AB51BC3A0C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6A280A27;
	Fri, 20 Jun 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TmbV8Tx7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gPnPk2fo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07256229B1E;
	Fri, 20 Jun 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412996; cv=none; b=lupqht0WCiVy1+nvai8FVJYTj6LkBgLUgYoICNZvnvhsaJ/7boXDEfYGaUF6OUklTMYtKXfqe/InbZSGzaUdJsFAXf5RWoTh3GWiF2Wq4qP8qAGMOnLMGM0Guxcuv+/wJGwaQBZouQ8Z2OhPzX0NDiX6JvvP65a/6QAmh9kE/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412996; c=relaxed/simple;
	bh=w/IZIUlVfxj6StexsGKbT+cS5xQ+MpOOiUS9y+RIgOM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M12bKEE3Jtzx7T9mM+thB3YCHtQembrS6Nxb8+MynrEFl8rbTxeXNVQFgAceXFlMmyigBRiaylzRI4mcEBapKXQy+qA3wEFvwwzYGnfe8xWaikBfCONKT8Zgbe8pxReU3UgzZJvhAiOcS6mDWfpyO0W1L5fyCN/rfhEv4gzgcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TmbV8Tx7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gPnPk2fo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 09:49:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750412993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8u8Le9QKzGFGeU/8gqppJD2C6i2QDdK14vNaGZ922/Q=;
	b=TmbV8Tx7drPYltkK9wAJX+9oHuWFacNRBYohUlkjB8PHk+DixVjlfqB8GjapLDL309PiiT
	mU5imBsRYqaTTCRnNpAMbwKck+A+DMFdjVo51jEKNVToMUg6J1/mPoLaQmKhEn5UoIaXuX
	wPeMKYzL/ngpiOjoHDa4FD3aKBpD4/xlgxCxV0ogC46r6dCv7v4htBGxCQTpMiEZWbac/E
	fv38fUyIzds/xssjYNJLut/SIxIcQh0Ab+GHhmoSaSmYnrqfzXFfHDSvgBRD4qccFRnNdu
	rRsnu51Om3s0EN+fkYU8PiOogAk10ioQFqdzPRbS5dF7g4+4zjEc1mfHzwWAPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750412993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8u8Le9QKzGFGeU/8gqppJD2C6i2QDdK14vNaGZ922/Q=;
	b=gPnPk2foodbeGvtELtdBIOauQ1mnqylpBp9S08z1gjEqf0vux89s0rcneeknUKWg8UtNlz
	Wlt25eyWa9rsZpDg==
From: "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Reorganize cgroup bandwidth control
 interface file reads
Cc: Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250614012346.2358261-4-tj@kernel.org>
References: <20250614012346.2358261-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175041299243.406.8917774484930071478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     43e33f53e25687ca870248d1939cfade0164426c
Gitweb:        https://git.kernel.org/tip/43e33f53e25687ca870248d1939cfade0164426c
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Fri, 13 Jun 2025 15:23:29 -10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 Jun 2025 13:59:57 +02:00

sched/core: Reorganize cgroup bandwidth control interface file reads

- Update tg_get_cfs_*() to return u64 values. These are now used as the low
  level accessors to the fair's bandwidth configuration parameters.
  Translation to usecs takes place in these functions.

- Add tg_bandwidth() which reads all three bandwidth parameters using
  tg_get_cfs_*().

- Reimplement cgroup interface read functions using tg_bandwidth(). Drop cfs
  from the function names.

This is to prepare for adding bandwidth control support to sched_ext.
tg_bandwidth() will be used as the muxing point similar to tg_weight(). No
functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250614012346.2358261-4-tj@kernel.org
---
 kernel/sched/core.c | 58 ++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dc9668a..8de93a3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9404,7 +9404,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	return 0;
 }
 
-static long tg_get_cfs_period(struct task_group *tg)
+static u64 tg_get_cfs_period(struct task_group *tg)
 {
 	u64 cfs_period_us;
 
@@ -9414,12 +9414,12 @@ static long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
-static long tg_get_cfs_quota(struct task_group *tg)
+static u64 tg_get_cfs_quota(struct task_group *tg)
 {
 	u64 quota_us;
 
 	if (tg->cfs_bandwidth.quota == RUNTIME_INF)
-		return -1;
+		return RUNTIME_INF;
 
 	quota_us = tg->cfs_bandwidth.quota;
 	do_div(quota_us, NSEC_PER_USEC);
@@ -9427,7 +9427,7 @@ static long tg_get_cfs_quota(struct task_group *tg)
 	return quota_us;
 }
 
-static long tg_get_cfs_burst(struct task_group *tg)
+static u64 tg_get_cfs_burst(struct task_group *tg)
 {
 	u64 burst_us;
 
@@ -9614,22 +9614,42 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static u64 cpu_cfs_period_read_u64(struct cgroup_subsys_state *css,
-				   struct cftype *cft)
+static void tg_bandwidth(struct task_group *tg,
+			 u64 *period_us_p, u64 *quota_us_p, u64 *burst_us_p)
 {
-	return tg_get_cfs_period(css_tg(css));
+	if (period_us_p)
+		*period_us_p = tg_get_cfs_period(tg);
+	if (quota_us_p)
+		*quota_us_p = tg_get_cfs_quota(tg);
+	if (burst_us_p)
+		*burst_us_p = tg_get_cfs_burst(tg);
 }
 
-static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
-				  struct cftype *cft)
+static u64 cpu_period_read_u64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
 {
-	return tg_get_cfs_quota(css_tg(css));
+	u64 period_us;
+
+	tg_bandwidth(css_tg(css), &period_us, NULL, NULL);
+	return period_us;
 }
 
-static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
-				  struct cftype *cft)
+static s64 cpu_quota_read_s64(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
 {
-	return tg_get_cfs_burst(css_tg(css));
+	u64 quota_us;
+
+	tg_bandwidth(css_tg(css), NULL, &quota_us, NULL);
+	return quota_us;	/* (s64)RUNTIME_INF becomes -1 */
+}
+
+static u64 cpu_burst_read_u64(struct cgroup_subsys_state *css,
+			      struct cftype *cft)
+{
+	u64 burst_us;
+
+	tg_bandwidth(css_tg(css), NULL, NULL, &burst_us);
+	return burst_us;
 }
 
 static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
@@ -9712,17 +9732,17 @@ static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "cfs_period_us",
-		.read_u64 = cpu_cfs_period_read_u64,
+		.read_u64 = cpu_period_read_u64,
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
 	{
 		.name = "cfs_quota_us",
-		.read_s64 = cpu_cfs_quota_read_s64,
+		.read_s64 = cpu_quota_read_s64,
 		.write_s64 = cpu_cfs_quota_write_s64,
 	},
 	{
 		.name = "cfs_burst_us",
-		.read_u64 = cpu_cfs_burst_read_u64,
+		.read_u64 = cpu_burst_read_u64,
 		.write_u64 = cpu_cfs_burst_write_u64,
 	},
 	{
@@ -9944,8 +9964,10 @@ static int __maybe_unused cpu_period_quota_parse(char *buf,
 static int cpu_max_show(struct seq_file *sf, void *v)
 {
 	struct task_group *tg = css_tg(seq_css(sf));
+	u64 period_us, quota_us;
 
-	cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg));
+	tg_bandwidth(tg, &period_us, &quota_us, NULL);
+	cpu_period_quota_print(sf, period_us, quota_us);
 	return 0;
 }
 
@@ -9996,7 +10018,7 @@ static struct cftype cpu_files[] = {
 	{
 		.name = "max.burst",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.read_u64 = cpu_cfs_burst_read_u64,
+		.read_u64 = cpu_burst_read_u64,
 		.write_u64 = cpu_cfs_burst_write_u64,
 	},
 #endif /* CONFIG_CFS_BANDWIDTH */


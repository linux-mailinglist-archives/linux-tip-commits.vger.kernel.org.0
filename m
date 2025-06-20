Return-Path: <linux-tip-commits+bounces-5875-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E6AE1839
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 11:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8705C16E392
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF6828469A;
	Fri, 20 Jun 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NxM2+do9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="podZXSsi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7554283FEC;
	Fri, 20 Jun 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412999; cv=none; b=F94TUGs/QJkxzZF0Vc9scVkPVCs7Y6tW8rRuTH+Gu1vUpvSBDNgYuRwiQ2O7GJipMDaxdZdUfN+rVz/cq0mcAniIcnpT6Od+PHqEGqDs8GAF4jAYIK8K8ZBfQ0dwPKpL/qBgn3zP7T+RbjZhW+PZ6E3+ZokhJxMqD826g0UKUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412999; c=relaxed/simple;
	bh=5w1RVDMlpHgxhHS+ezn+h94n3OBUvb9f5Alg5672KRE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nkopMEWSNgsLssYMg34HeQdmv0Hhd9xifvq6TbENuBIeE/irDj7IhsmspVM70JVFq/P6U2ZW1IBxAEBxTuH6xGzFvl6o+wvpAgL8xMTLtNBF821ISGfKBod7oAseQr7BmgjaYhmAPT4MogHSJ9eT2i37qvp47k40RSDj9/VS5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NxM2+do9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=podZXSsi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 09:49:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750412995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3XCeQ0lJThbNBNR3OpAMHYfQq3b890wL5JjvUHVKl0=;
	b=NxM2+do9/nHat4QPJ/9MzbxXLmOFhIicTodUny0eEj56B5UtQ7WPCjb49M25dKILROuz7C
	dRbqr/mKVU7DHPMBXINeSOalT1jzYt/bVh2OvV5VI89uJBg/0Q0j3YGHvS/CkF1AnioO9o
	2xrTcy60QNHyKdkLSgrtv5l2h/FmCxmROr3+H7f0Qmb+WbhqA/zEsaXXTrQX0QEU4FJli0
	6yWETHOqk+LL6mmGpGLszECCKzyvAzwHrcu9XA0jj+Ap4dHF4S9uIFvG0u0dFov6kiO4sZ
	wS6CaKqRNkA3CZvOr6Qu+yWr8o4MnkDLxTT72tQcwIGAaI00FGkuYvxgpj9ixQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750412995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3XCeQ0lJThbNBNR3OpAMHYfQq3b890wL5JjvUHVKl0=;
	b=podZXSsiLXY6VcVCaw6hd2xPqK9aF6mvhR5M3bwb6n2CmwmNutN8k/wkut0nLEXnI9R6XQ
	90GP6gcjHcrgL9Dw==
From: "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Move max_cfs_quota_period decl and
 default_cfs_period() def from fair.c to sched.h
Cc: Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250614012346.2358261-2-tj@kernel.org>
References: <20250614012346.2358261-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175041299429.406.12351300919151112485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d403a3689af5c3a3e3ac6e282958d0eaa69ca47f
Gitweb:        https://git.kernel.org/tip/d403a3689af5c3a3e3ac6e282958d0eaa69ca47f
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Fri, 13 Jun 2025 15:23:27 -10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 Jun 2025 13:59:56 +02:00

sched/fair: Move max_cfs_quota_period decl and default_cfs_period() def from fair.c to sched.h

max_cfs_quota_period is defined in core.c but has a declaration in fair.c.
Move the declaration to kernel/sched/sched.h. Also, move
default_cfs_period() from fair.c to sched.h. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250614012346.2358261-2-tj@kernel.org
---
 kernel/sched/fair.c  | 11 -----------
 kernel/sched/sched.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6b17d3d..707be45 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5617,15 +5617,6 @@ void cfs_bandwidth_usage_inc(void) {}
 void cfs_bandwidth_usage_dec(void) {}
 #endif /* !CONFIG_JUMP_LABEL */
 
-/*
- * default period for cfs group bandwidth.
- * default: 0.1s, units: nanoseconds
- */
-static inline u64 default_cfs_period(void)
-{
-	return 100000000ULL;
-}
-
 static inline u64 sched_cfs_bandwidth_slice(void)
 {
 	return (u64)sysctl_sched_cfs_bandwidth_slice * NSEC_PER_USEC;
@@ -6405,8 +6396,6 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-extern const u64 max_cfs_quota_period;
-
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c323d01..e00b80c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -402,6 +402,19 @@ static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 
 extern struct list_head task_groups;
 
+#ifdef CONFIG_CFS_BANDWIDTH
+extern const u64 max_cfs_quota_period;
+
+/*
+ * default period for cfs group bandwidth.
+ * default: 0.1s, units: nanoseconds
+ */
+static inline u64 default_cfs_period(void)
+{
+	return 100000000ULL;
+}
+#endif /* CONFIG_CFS_BANDWIDTH */
+
 struct cfs_bandwidth {
 #ifdef CONFIG_CFS_BANDWIDTH
 	raw_spinlock_t		lock;


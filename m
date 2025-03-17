Return-Path: <linux-tip-commits+bounces-4257-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A3A64A29
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64533167895
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C37E23BCE9;
	Mon, 17 Mar 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TvaRIcuC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4YFAHPo2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2362356AF;
	Mon, 17 Mar 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207683; cv=none; b=o9uQJpXIEIEvX7pLljZrKk8a0HBqY6z3DEDM3OCF2yL0j4yxkt9NPDOBBh701xM6HMf7ucTHW6zZexc1JCVdbz2Fb8U2OzZmTH8YGJgNYAN3b0VLufcT0QFmJoSVocMjqbg064g9T2T9cG8fjy2YUUG+IucpW0+4iV1JCUbGaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207683; c=relaxed/simple;
	bh=86o5xrDXWOCXMLo8es3lZJID4cwdcZnAneOfduDMQ6U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PGZ6c/W8c0vqxx9KZdR8UBP5LBbWELOg0ep0VjFcT01cngZJF+AtCKP6EUxJIeMRnv9T6Rt4Nt/PgJO14gulLBfPbF6ZB5Jm9R84tdp4tZa8j9wQZvlZRpsfwYFzJsAqtidwY1bPHuz+9140SLFU+uTuqnMnv3Gikgft5qvvEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TvaRIcuC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4YFAHPo2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHCOt9+vPZFHbV0nc6dGrU/bEaOT2OwVoCtLeRN9oB8=;
	b=TvaRIcuCsJXzmGAy/KuDpy4/7DsHuaWuYc+frCvG65n4JKGMLtmX/s0Zm667qq56x85stD
	Qc0WTk4Qmr7wvPUP0Gn8qI6GFH1MQ2L1/lm0ATR2UkUGLfRBxrCyb2pXQnyc+O4RaVCJ56
	zFdpayQAU0K2v9UKGVqQgMFCx9AabEekk5Wt0VrVlkOztd4QCnL0SIix2qgMf82DKBI+hO
	ZFj/Kzbsb0VlP4CUREsgOzqhHIWrIe1ft55/l+ha/WVU/c5Ur+QwfrB5cWQwrLpKdrgfLg
	DJLhCWpbMP9moG6Xyog4lRAUVqjIWzgRnvlCQLfPm4zDBffcnIo6aNdCYtF9Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHCOt9+vPZFHbV0nc6dGrU/bEaOT2OwVoCtLeRN9oB8=;
	b=4YFAHPo23SBR9yoC+XIeGqODAepq/MGTmobCd01aMWwzAOC2Wbd/9Jr4zve6uM2chj9tXJ
	SSH7xdkeQC5g2nAA==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/topology: Remove redundant dl_clear_root_domain call
Cc: Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <llong@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Waiman Long <longman@redhat.com>,
 Jon Hunter <jonathanh@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z9MRtcX4tz4tcLRR@jlelli-thinkpadt14gen4.remote.csb>
References: <Z9MRtcX4tz4tcLRR@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220767961.14745.14327073917316253565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d735bab3d58c4c96e67037490d19d35392065da9
Gitweb:        https://git.kernel.org/tip/d735bab3d58c4c96e67037490d19d35392065da9
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Thu, 13 Mar 2025 18:11:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:42 +01:00

sched/topology: Remove redundant dl_clear_root_domain call

We completely clean and restore root domains bandwidth accounting after
every root domains change, so the dl_clear_root_domain() call in
partition_sched_domains_locked() is redundant.

Remove it.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/Z9MRtcX4tz4tcLRR@jlelli-thinkpadt14gen4.remote.csb
---
 kernel/sched/topology.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 363ad26..df2d94a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2720,21 +2720,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
-			    dattrs_equal(dattr_cur, i, dattr_new, j)) {
-				struct root_domain *rd;
-
-				/*
-				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.
-				 * Tasks contribution will be then recomputed
-				 * in function dl_update_tasks_root_domain(),
-				 * dl_servers contribution in function
-				 * dl_restore_server_root_domain().
-				 */
-				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
-				dl_clear_root_domain(rd);
+			    dattrs_equal(dattr_cur, i, dattr_new, j))
 				goto match1;
-			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);


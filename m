Return-Path: <linux-tip-commits+bounces-4255-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C30A64A27
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053337A59E6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA1C233D99;
	Mon, 17 Mar 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OR2K0tR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1MHJNFRU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F41230BC9;
	Mon, 17 Mar 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207681; cv=none; b=N3G1jln+lZpPaw7I/eNPLWQAkivm0e3GaSNtP8bCgo0Gwf17jB5jZyLFde4qddklUpzBDodtRoxh4vimrX5t/PwWGxmKuE702MkamdAlEsRg1ctJYSGG04iRsLIkyryZJur7GNxVkgX7VHuofW3qj6vjcHbUerDIFojUDCLaBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207681; c=relaxed/simple;
	bh=b5Ojy9/Rv0Yk6zbM2L/FeYK5p0jIUwaXeFu+jzjRE+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bakxMScM02dwpmziavQGOgvYa9UcxjS+arKpgHDJRN3DNwgjn2AoJYtdtZmX/fkcGnu15v90SxTbRHK5r2zoAQso0IeU05o95//K/zkQZ75c0wBJQExWlxezddj2p4ezZNBNOJ58J6tSKkIrpn2rs9CNW808nU2gf98Qc2Huz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2OR2K0tR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1MHJNFRU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7r/hpAcACN4kyIGjRkZAfRuTVh3KJO8vwD98IYCY14=;
	b=2OR2K0tR0sY9StNEfr7BFAkotlkt5CSLardwdYBoBH1P1ueSbtW1daTH+CI9fW2fb8almq
	SJGwhWvjcNXbvhKJ/ZkNwxjeq5aRkBgIY8sLAA4L45hnqh2W+YUCJnOILSTP+RMX5szdm7
	ZnlmmV4v/nLiYL0NTH1OjI8KkVvYZCCPY/MxEVTKm7IeBab6V2C8XKnFN1+WE7cHXwv6rM
	d3dB75lpi3lSI2L3j90BwfIjZBXBzWrVCqBZ4ITC5rPIAeBBozsiGQE4w5zlJsmZbWv8Ri
	ta2ymjyQkYzLQdUBd+S9U6Vu/+dHumD9ZaBNBo1CN6Ctv5NWCC3SqMgNh5vJ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7r/hpAcACN4kyIGjRkZAfRuTVh3KJO8vwD98IYCY14=;
	b=1MHJNFRUETsNChvEwvUXWWekMs9n6rHFK60jsON2ZT7HdAHZS7HWHAmo6RTB/I+YeoHVNE
	XHmAgWJYvTo+y2Bw==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Stop exposing
 partition_sched_domains_locked
Cc: Waiman Long <llong@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Waiman Long <longman@redhat.com>,
 Jon Hunter <jonathanh@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z9MSC96a8FcqWV3G@jlelli-thinkpadt14gen4.remote.csb>
References: <Z9MSC96a8FcqWV3G@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220767798.14745.3645911642719361161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d128130f486b4aa86086655af0fbb943b26b0003
Gitweb:        https://git.kernel.org/tip/d128130f486b4aa86086655af0fbb943b26b0003
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Thu, 13 Mar 2025 18:12:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:43 +01:00

sched/topology: Stop exposing partition_sched_domains_locked

The are no callers of partition_sched_domains_locked() outside
topology.c.

Stop exposing such function.

Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/Z9MSC96a8FcqWV3G@jlelli-thinkpadt14gen4.remote.csb
---
 include/linux/sched/topology.h | 10 ----------
 kernel/sched/topology.c        |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 1622232..96e69bf 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -168,10 +168,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 
 extern void dl_rebuild_rd_accounting(void);
 
-extern void partition_sched_domains_locked(int ndoms_new,
-					   cpumask_var_t doms_new[],
-					   struct sched_domain_attr *dattr_new);
-
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -213,12 +209,6 @@ extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 struct sched_domain_attr;
 
 static inline void
-partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
-			       struct sched_domain_attr *dattr_new)
-{
-}
-
-static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2d94a..95bde79 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2688,7 +2688,7 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  *
  * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;


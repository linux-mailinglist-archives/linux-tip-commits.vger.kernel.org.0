Return-Path: <linux-tip-commits+bounces-4256-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDDA64A70
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAD03B4173
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BD72356D1;
	Mon, 17 Mar 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xh01Exet";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/lL/qCxu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9A230BE0;
	Mon, 17 Mar 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207682; cv=none; b=eiF1Xp9ATievFwmive0pZB9it6DT5YBr98Vg4epudp8K9JH0E20RKAxNG9n1EcH9oYz7CH8pzq2Q7Hfv8S4DEcpRY6ZYznYPF4N4SrRn2tGBwuLRPf1iodOsdMVqneA5vcmml1kqJSCcNp83030EHrM9fh4f5LGIy92esHXvTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207682; c=relaxed/simple;
	bh=zLoUY+xb4ftPiapgAJpe+9poiGzXZbvMdwGqCZt1+i4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e6rf3tiRO8UIb6mvPiQzv/qF1H2veuePaftQ7hE0+wnbOZXOazuHYRVx1ZPRYIVOiS6fsATczhgPbtnVIr4OZWOwGavv33IB6AINsPCUOHivPqZeOBHV5VejT20ofY+cRhbH3RqVEc2tL5nLSpsZ7XC8Unm3CYdbnJLe7k8s8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xh01Exet; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/lL/qCxu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHroq8WmjgIvssmRsgJzLKxrV3oC9rLZaT7V8WNfnfg=;
	b=Xh01Exet5J6NTCsuHN/B7fr/Lvs2FcLH4geTKE9c/pQajBgpU5qpIlddjsqCw+Wti1aLcR
	AFNmzmilnQWi6i9NueBCzT9dI9OLrA8lIvRJLjHmd0FhOcFiQEaW9MvXk+VEMRSn2VWZO5
	SuIz7QDYpX5Pluawriqzv5WH29Y54jZ/zMiLO8g8zewLpv4m6ZCbD7qo/FsF93ELIx1QpH
	qQ1+Is9L1NfqHGh1Ac4LGwTk+xfvXDgYfkuT2iwFyHJAOnCpCgkPAEwqshhtPieOAQVxef
	if24z4Ilf1CyaJshCaYtxAZKlN9cfOroTm9rWsI4c67XRE2IfgRIex/nNB5u+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHroq8WmjgIvssmRsgJzLKxrV3oC9rLZaT7V8WNfnfg=;
	b=/lL/qCxu5gV2UH3AZF9vmUDwFAnfvdwEC7Z0Wo3Abd1+0i+4+TEmzXXnj8/7r2bggpQMA/
	loKcUJQ6ee3emRAQ==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] cgroup/cpuset: Remove partition_and_rebuild_sched_domains
Cc: Waiman Long <llong@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Waiman Long <longman@redhat.com>,
 Jon Hunter <jonathanh@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z9MR4ryNDJZDzsSG@jlelli-thinkpadt14gen4.remote.csb>
References: <Z9MR4ryNDJZDzsSG@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220767883.14745.10939376719775083351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ce9b3f93d770c699ffae30c595e34769c86e4a6c
Gitweb:        https://git.kernel.org/tip/ce9b3f93d770c699ffae30c595e34769c86e4a6c
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Thu, 13 Mar 2025 18:12:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:42 +01:00

cgroup/cpuset: Remove partition_and_rebuild_sched_domains

partition_and_rebuild_sched_domains() and partition_sched_domains() are
now equivalent.

Remove the former as a nice clean up.

Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/Z9MR4ryNDJZDzsSG@jlelli-thinkpadt14gen4.remote.csb
---
 kernel/cgroup/cpuset.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1892dc8..a51099e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -993,15 +993,6 @@ void dl_rebuild_rd_accounting(void)
 	rcu_read_unlock();
 }
 
-static void
-partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-				    struct sched_domain_attr *dattr_new)
-{
-	sched_domains_mutex_lock();
-	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	sched_domains_mutex_unlock();
-}
-
 /*
  * Rebuild scheduler domains.
  *
@@ -1063,7 +1054,7 @@ void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_and_rebuild_sched_domains(ndoms, doms, attr);
+	partition_sched_domains(ndoms, doms, attr);
 }
 #else /* !CONFIG_SMP */
 void rebuild_sched_domains_locked(void)


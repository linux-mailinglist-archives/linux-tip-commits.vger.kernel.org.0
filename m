Return-Path: <linux-tip-commits+bounces-1342-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE088FCCAD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 14:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CBA288606
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853819CCE5;
	Wed,  5 Jun 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KhwchRSR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/KDG7WEp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6319CCF0;
	Wed,  5 Jun 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588728; cv=none; b=oWjMy0k/wvkOcoabIAgfXKt5vdw/k8CWqJlaxfS7q+Df+9ypgrnHdTeJK2BtvfHnDpgmWD9WHNv452X1uBnu307MPZfN/eFn/i26WCtXg/iC9FOjzbGrWWZqOwM/evpcpWL0i52lFxUGecnDEjVMjGbBWZInrnYohm8SklRE+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588728; c=relaxed/simple;
	bh=7Ef0ncgscO0OD6Dn8yPg3403dMb6KQsV93tFgcfzA0s=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=YB1asd3vk1A0TQqZ8oDYFyt/u0ZGSIK/0R7tQM7sWdx6jPQxjnpbd0uGon7ikmwVw9HWRj868GqHtfRGx/KLLhOvK1nEjuc7lqYWDmWa0gbDN/ZjGYb5CNnA7wpEm2eCheM0ivLegj8Txf8YbZ4e5eYXuZV3UM6xXvu1RiWCXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KhwchRSR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/KDG7WEp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 11:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717588725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j8VKAxipfG7b8cYFeMCVG/fbpeVomP6m0v3OqHxz7hQ=;
	b=KhwchRSRuCUHa5oaVsT3bObDjCyEmxk5gDFo+siyvlxDthYCypSm6UM9crReNqoSzfsWQl
	KemfmKSuhLwZBn89cdEr8xlDVX4wn7JmpBAcUqBtiv5C5wWWokcFIzSvXAGE+ism5eLjpy
	/kLmO4FW76Q2SBfrHS1JXDpfPhp684dBGk4kvbG8M2RCYG1ulCxJrZiY3MpWXXqKt6fEHV
	7t12ll8O0M7iJBgPzatUJYx+brX5q7hc61hVN7ZkIVEjCG8AZw8k8RHHjIrbEYXC8rKYX7
	bDxdWz5XBfiyMcxSgMDw63xaeVBfnJNtmO8owkS/CbM4mvcRn7L0wGA+E8h2Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717588725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j8VKAxipfG7b8cYFeMCVG/fbpeVomP6m0v3OqHxz7hQ=;
	b=/KDG7WEpyFb5Fq+I1Vyu2q2v97YQD/XTZgCbfW+iilL9UYx2MvG40TkQ2+vFML15OFqmV7
	rymkZ1KwgsdUHkBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Move struct pre-declarations to the
 beginning of the header
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171758872489.10875.7704825011213776196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3cd7271987ffd89c2d5eaeea85d3e9a16aec6894
Gitweb:        https://git.kernel.org/tip/3cd7271987ffd89c2d5eaeea85d3e9a16aec6894
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 05 Jun 2024 13:44:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Jun 2024 13:52:25 +02:00

sched/headers: Move struct pre-declarations to the beginning of the header

There's a random number of structure pre-declaration lines in
kernel/sched/sched.h, some of which are unnecessary duplicates.

Move them to the head & order them a bit for readability.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/sched.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 078241d..62fd8bc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -74,6 +74,12 @@
 
 #include "../workqueue_internal.h"
 
+struct rq;
+struct cfs_rq;
+struct rt_rq;
+struct sched_group;
+struct cpuidle_state;
+
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
 # include <asm/paravirt_api_clock.h>
@@ -90,9 +96,6 @@
 # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
 #endif
 
-struct rq;
-struct cpuidle_state;
-
 /* task_struct::on_rq states: */
 #define TASK_ON_RQ_QUEUED	1
 #define TASK_ON_RQ_MIGRATING	2
@@ -362,9 +365,6 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 
 #ifdef CONFIG_CGROUP_SCHED
 
-struct cfs_rq;
-struct rt_rq;
-
 extern struct list_head task_groups;
 
 struct cfs_bandwidth {
@@ -996,8 +996,6 @@ struct uclamp_rq {
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
-struct rq;
-
 struct balance_callback {
 	struct balance_callback *next;
 	void (*func)(struct rq *rq);
@@ -1255,8 +1253,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
-struct sched_group;
-
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 


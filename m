Return-Path: <linux-tip-commits+bounces-1263-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D80A8C8255
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 10:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD5281395
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 May 2024 08:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC622301;
	Fri, 17 May 2024 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJamJ9ML";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0D/g/+c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A591A269;
	Fri, 17 May 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933174; cv=none; b=Ksb37vreEHUefxQ1AIidmQWZenMkcVQufMBVRmLHHaw4FArt/f8KyW9VmuMBsCIClsDysvxEUn0ctY4J0AgGaiQk24K8oOMV66xVzevc2wBEX8/nupwUoAxzH9fCfJ+qYBeCFeCHEZqYdyGFQvH/PWKsoIUWZNJtK3RFQqf32QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933174; c=relaxed/simple;
	bh=QMr/SPTgmh1haotnJyA6+vALv91yT0q8VT2NouVZ4dk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OeaGRR9+jwW2rxxJo3E54fUqCT5T9z3179aa9gjWoKI+WYeXcBF2q5N4wgqu0H66e8BWFx9nUVwkfUPo82N4HSOT8uBXg/3i3lb4KYhe5do3Ct9YXDaZpSf9rOgyPY6euCQGHDIyRCVylrmrVWFgUwKOtA8QXo2Qr8zJpdjDTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJamJ9ML; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0D/g/+c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 May 2024 08:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715933170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvspPlO30Dpgs5BRdySP249xAR6/Pg+jqZL6QxyeFOU=;
	b=WJamJ9MLvwL+L3+0hcVWtg/Z32m7m4t5Cgl5XrSPuSumvPPsgENHhLEm2wUSMGOfuT7UPi
	fJ78LarQpBzb+wmekXTQckwW5q2k4fS60URjSxCxBDur77w5/YMHL/hQKfo8j3g9uC2pNX
	tz5SFm5xQRFVvlYQxIOK8v+263TmPeyqHAaSjS90wCx2Y1uNkSsd861ZBxGS2Wp/gJdIk5
	F8VFnLvDRETCM3nVPbqTAxtGJzhF1ICe4KE7jHgJFeC5D81vSoiyf4lUn8xw1dOK6Kj5Za
	Kjn6JhXvgSieezsrWDsKnNtMWGRy7V7tXhlNGav+Yan+Td2CLIC3Fnod3dHsFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715933170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvspPlO30Dpgs5BRdySP249xAR6/Pg+jqZL6QxyeFOU=;
	b=b0D/g/+c/U0+x91a6/XfL5qOY4EiKzJezVlZgBMJeWhJzprY7n/G2wzsT64ISMkM54Iqe3
	VZDHedjAXKpN+9Cg==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix initial util_avg calculation
Cc: Dawei Li <daweilics@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Vishal Chourasia <vishalc@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240315015916.21545-1-daweilics@gmail.com>
References: <20240315015916.21545-1-daweilics@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171593317056.10875.16807671929410125258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     72bffbf57c5247ac6146d1103ef42e9f8d094bc8
Gitweb:        https://git.kernel.org/tip/72bffbf57c5247ac6146d1103ef42e9f8d094bc8
Author:        Dawei Li <daweilics@gmail.com>
AuthorDate:    Thu, 14 Mar 2024 18:59:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 May 2024 09:49:44 +02:00

sched/fair: Fix initial util_avg calculation

Change se->load.weight to se_weight(se) in the calculation for the
initial util_avg to avoid unnecessarily inflating the util_avg by 1024
times.

The reason is that se->load.weight has the unit/scale as the scaled-up
load, while cfs_rg->avg.load_avg has the unit/scale as the true task
weight (as mapped directly from the task's nice/priority value). With
CONFIG_32BIT, the scaled-up load is equal to the true task weight. With
CONFIG_64BIT, the scaled-up load is 1024 times the true task weight.
Thus, the current code may inflate the util_avg by 1024 times. The
follow-up capping will not allow the util_avg value to go wild. But the
calculation should have the correct logic.

Signed-off-by: Dawei Li <daweilics@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Link: https://lore.kernel.org/r/20240315015916.21545-1-daweilics@gmail.com
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 146ecf9..9009787 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_entity *se)
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
  *
- *   util_avg = cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.weight
+ *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
+ *		* se_weight(se)
  *
  * However, in many cases, the above util_avg does not give a desired
  * value. Moreover, the sum of the util_avgs may be divergent, such
@@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
 			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
 
 			if (sa->util_avg > cap)


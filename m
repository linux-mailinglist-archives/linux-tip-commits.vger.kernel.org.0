Return-Path: <linux-tip-commits+bounces-4254-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD97A64A26
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11191713CB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D121B8E0;
	Mon, 17 Mar 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RLQE+EdB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSG5Vvxe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCA133987;
	Mon, 17 Mar 2025 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207681; cv=none; b=UbpbwJJFHjH1cCtbsxpoO19HuHPdQkP+nQV8PSiiX2UIkOtzi5ZgS2szYULDUe1uAij+WU2uXx3q8ZzGPB8qHt5sNmOyPc/ttRTC6p4pE4b0phKnyiqT6NGZPMRn1YqRtRbM6ywwlxul1tHfWuWqwIKgrVuCI7HOftHvNLNpU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207681; c=relaxed/simple;
	bh=pW9QO+5A+/soDux6FyiCLin/PxvqjN4pSHEWgfX1uG8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cBdsqW1Eq6ukISM2tu1kUVCGLpSxGGuSoNLMLOqmIbY8y111p7Gv2twWNF5V2T08fCouIpfskCxD6u897rCm8zxaR2NKa+x+rBiCXckJa5xIVeZsmqkFzDCrFJro7D8C8HH8REUks7X9mTjnnp7if8VcevNqlEvampcC6lP707k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RLQE+EdB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSG5Vvxe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hm1R16iny6guq5C0P5Th/vRMz6fALWaS6i3qlgndaQ0=;
	b=RLQE+EdBGsJcvvT36PBw/wUehqQGRFY5G0SmTsbPQeVXTo524m99JQRkHI9CuhB6zQGENn
	agDgwRTBdwIqQkBSz9dsJved2KB+aaxOP7d1KGlnYUn6jMTunw8dEI/wigR/1ypOihTFgH
	OkjvISPME4q4ggRKJvYsvbOBzHqzfOBja+mM+XuLRG6BJUsuIn4Ln6Q5LrdM+bWQETXVWZ
	Ph+SbDqk4SW2+b9h/JBmJGB2vSTwcV2jmvOMqLoptNhm3eBe2idnma3MU3F8HyTbLmdMIx
	SIhl9WxPZmNpR5dGi2z8c2mrP5YITsZXdW4QpSSilL74pRT94Qj+P7V5m3FE6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hm1R16iny6guq5C0P5Th/vRMz6fALWaS6i3qlgndaQ0=;
	b=xSG5Vvxe10OkBldLmZaTW67a9NCHkPhX5XCK6gyXWFKrUu2JcuqxK45G5Kaj7/1jB+nwaV
	hefiUcxP0BZUWdCg==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] include/{topology,cpuset}: Move
 dl_rebuild_rd_accounting to cpuset.h
Cc: Waiman Long <llong@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Waiman Long <longman@redhat.com>,
 Jon Hunter <jonathanh@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z9MSOVMpU7jpVrMU@jlelli-thinkpadt14gen4.remote.csb>
References: <Z9MSOVMpU7jpVrMU@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220767709.14745.16178599491544207298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     34929a070b7fd06c386080c926b61ee844e6ad34
Gitweb:        https://git.kernel.org/tip/34929a070b7fd06c386080c926b61ee844e6ad34
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Thu, 13 Mar 2025 18:13:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:43 +01:00

include/{topology,cpuset}: Move dl_rebuild_rd_accounting to cpuset.h

dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
sense to move related declarations to cpuset.h.

Implement the move.

Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <llong@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/Z9MSOVMpU7jpVrMU@jlelli-thinkpadt14gen4.remote.csb
---
 include/linux/cpuset.h         | 5 +++++
 include/linux/sched/topology.h | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 17cc90d..5466c96 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -125,6 +125,7 @@ static inline int cpuset_do_page_mem_spread(void)
 
 extern bool current_cpuset_is_being_rebound(void);
 
+extern void dl_rebuild_rd_accounting(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
@@ -260,6 +261,10 @@ static inline bool current_cpuset_is_being_rebound(void)
 	return false;
 }
 
+static inline void dl_rebuild_rd_accounting(void)
+{
+}
+
 static inline void rebuild_sched_domains(void)
 {
 	partition_sched_domains(1, NULL, NULL);
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 96e69bf..51f7b81 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -166,8 +166,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
-extern void dl_rebuild_rd_accounting(void);
-
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 


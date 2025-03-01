Return-Path: <linux-tip-commits+bounces-3758-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D6A4ADAC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951B07A25FE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5E1EB191;
	Sat,  1 Mar 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rf7B0dgq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lN9LLW4Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE91E9B22;
	Sat,  1 Mar 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859658; cv=none; b=jyIDm99xjsDckAXt00M60NrMrNaErbfU0XaIRHScQCOByQQOH3eWz/7jq5pO1yJ/Qd+cUfjwXtnb+nCaiuKWN21Kzw9h1UWKS3hxomH9bdBPLAz8FpMOYRb2iaSqm58iY8HA7j/U0bSTRMeD+/0bS5tX3b1puQhoVoQeuYiyBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859658; c=relaxed/simple;
	bh=CBKzGW9oYPCkC2Uzo+lkX7iun9R0R6Fb75UCeOfTCd8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z746mp8d8ZgU2wiz4r/VRv3ceZaTZgTQlESmdiy4C/cuMPAMLHVLxmNj9/7jmdrrkJVfbbasjJWhHBUUyWWhKs/Kj3JJ5bCp/2tPr2cyiiA2Luylt+Kr26evyYlwVZG4gbJifNA1If19qk0/qFoOOVDJJKk+XjKlL9XvakYM91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rf7B0dgq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lN9LLW4Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvsB8E/cgISoAVD4lBn5h5syqscNH5rJZZIKQCkYtO4=;
	b=rf7B0dgqQk317CrtPpipaVUtn4d5CICbmKZvnHHb+xyNoHYjr2gX0wfPkdBaihrM6qQ8Wq
	0bC3XVFewmhd7YAyL9IRukhJMBP/SlLdjz+VLCd/OApEW+U6LJ3CHnF2YnP72y/Hhk+JAE
	sQCTREn1Fjs6wcalVmIl2Wmt+s9aTcmcYzdzBm+YqnR4jj3+KSMSbC3rkrLYjhgyx9la9g
	kHf5lHZjmECVXj9Xs4vLHAklfQgEBltXbELRuuwBduVEeqTcYbpxNjCPOj/rm1dysQh+oD
	e0UzPIk+m+5SzJJUakiWfIo8rcd7G0Iv2DO3pGRsZaiVvH7ownZQyBnA4vyn5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvsB8E/cgISoAVD4lBn5h5syqscNH5rJZZIKQCkYtO4=;
	b=lN9LLW4YYHxbLfgoExvaScGgOl+qY6QmM7kct4V9zsrU3/y4xcjfZlhce6LD4BzCb4/X8e
	zaDfKEoW2SUiIsBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Simplify perf_init_event()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.302444446@infradead.org>
References: <20241104135518.302444446@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965416.10177.16488182367399775052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9954ea69de5c06c5bf073d366d6768c1c4a2a1c7
Gitweb:        https://git.kernel.org/tip/9954ea69de5c06c5bf073d366d6768c1c4a2a1c7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 19:54:05 +01:00

perf/core: Simplify perf_init_event()

Use the <linux/cleanup.h> guard() and scoped_guard() infrastructure
to simplify the control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20241104135518.302444446@infradead.org
---
 kernel/events/core.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 215dad5..fd35236 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12101,10 +12101,10 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 static struct pmu *perf_init_event(struct perf_event *event)
 {
 	bool extended_type = false;
-	int idx, type, ret;
 	struct pmu *pmu;
+	int type, ret;
 
-	idx = srcu_read_lock(&pmus_srcu);
+	guard(srcu)(&pmus_srcu);
 
 	/*
 	 * Save original type before calling pmu->event_init() since certain
@@ -12117,7 +12117,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 		pmu = event->parent->pmu;
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
-			goto unlock;
+			return pmu;
 	}
 
 	/*
@@ -12136,13 +12136,12 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	}
 
 again:
-	rcu_read_lock();
-	pmu = idr_find(&pmu_idr, type);
-	rcu_read_unlock();
+	scoped_guard (rcu)
+		pmu = idr_find(&pmu_idr, type);
 	if (pmu) {
 		if (event->attr.type != type && type != PERF_TYPE_RAW &&
 		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-			goto fail;
+			return ERR_PTR(-ENOENT);
 
 		ret = perf_try_init_event(pmu, event);
 		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
@@ -12151,27 +12150,21 @@ again:
 		}
 
 		if (ret)
-			pmu = ERR_PTR(ret);
+			return ERR_PTR(ret);
 
-		goto unlock;
+		return pmu;
 	}
 
 	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
-			goto unlock;
+			return pmu;
 
-		if (ret != -ENOENT) {
-			pmu = ERR_PTR(ret);
-			goto unlock;
-		}
+		if (ret != -ENOENT)
+			return ERR_PTR(ret);
 	}
-fail:
-	pmu = ERR_PTR(-ENOENT);
-unlock:
-	srcu_read_unlock(&pmus_srcu, idx);
 
-	return pmu;
+	return ERR_PTR(-ENOENT);
 }
 
 static void attach_sb_event(struct perf_event *event)


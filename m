Return-Path: <linux-tip-commits+bounces-1990-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27DD94BA95
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E33F283273
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC11189F39;
	Thu,  8 Aug 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqg68SO/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDwDDXbv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963D189BBE;
	Thu,  8 Aug 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112079; cv=none; b=VzjhVxsAd/CQGNf/mCluklanMaY+uy8MTAUG6IaVXWJBmmbQEj5Exm+vAx8Xi+ZUnkdrOxy0HOUYh1TRFTDidGG9quXqktiQxjex0kPXRPBmSRWHMg1IEBzDRRnh0tsxFIujRQWkaktQ3gkxRzXIEuyoMwxTswoNlHP6m87qUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112079; c=relaxed/simple;
	bh=BMt6lCxhg7cUKNmNfW3nmscHeMjz0N7QLHxe7ePwQ2M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IoK0FHkwpV4+Q4uq+/d6VfuzZQ0S4nDVzsq9TtOP3eES0FpUKjHQF15SbFk7VW/0ClChbFSYmANdnZ222EQOp70TdIVyXGawSlFShXkSoKA66Gamn7Knkd1YnIbsycobppSEt1IsQwCDeV4o5mWd3uEedkDsVG9I3iGb6kowoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqg68SO/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDwDDXbv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:14:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723112075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6AN2K/gywlUyGKZNEJ/N0f+HTt8FAXv9AqsY4SULFI=;
	b=fqg68SO/z0dASN4TSo5xjoMVTthOzHjGF+NgcjdiL6+LARfmIQfnMDOhI7Y5iBqz6e2pBj
	tWJcqe0NcqOSo1vnsrcjG21sVoOGvwW4JuLtcHNy7g5XihLrqfzStqZcRsprbQX7+JDzG8
	PBwnvgLjnvdJFw73aBkxRLV3J/T1sK6jpkg9DramXh3Y2NiwynpyooFJqMHaTeCoF/fW8k
	aCV3JJLd3yBeUtDcNY8lfceJEYsVWYaOjJxfkMNNdlkO+XUraIoYh8mp9PJnungA2pEoCm
	WeqnB65BBedcGbKnpqWW51ffQAcAuxM1TaQbV6SczT775+TyVwAIVi6krcOpQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723112075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6AN2K/gywlUyGKZNEJ/N0f+HTt8FAXv9AqsY4SULFI=;
	b=DDwDDXbv2w4NrqTLXvk3Peotk5oKa8fb/fLHwkXEg1h/DOAWwA+UmV/lGaI6pKYBTvMqKz
	15N0JTsROb6nq+Cw==
From: "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt, dl: Convert functions to return bool
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Qais Yousef <qyousef@layalina.io>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Metin Kaya <metin.kaya@arm.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240610192018.1567075-3-qyousef@layalina.io>
References: <20240610192018.1567075-3-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311207528.2215.16982778692842999098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b166af3db70fdcecf125662a2360471bb20be203
Gitweb:        https://git.kernel.org/tip/b166af3db70fdcecf125662a2360471bb20be203
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Mon, 10 Jun 2024 20:20:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Aug 2024 18:32:38 +02:00

sched/rt, dl: Convert functions to return bool

{rt, realtime, dl}_{task, prio}() functions' return value is actually
a bool. Convert their return type to reflect that.

Suggested-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Link: https://lore.kernel.org/r/20240610192018.1567075-3-qyousef@layalina.io
---
 include/linux/sched/deadline.h |  8 +++-----
 include/linux/sched/rt.h       | 16 ++++++----------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 5cb88b7..3a912ab 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -10,18 +10,16 @@
 
 #include <linux/sched.h>
 
-static inline int dl_prio(int prio)
+static inline bool dl_prio(int prio)
 {
-	if (unlikely(prio < MAX_DL_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_DL_PRIO);
 }
 
 /*
  * Returns true if a task has a priority that belongs to DL class. PI-boosted
  * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
  */
-static inline int dl_task(struct task_struct *p)
+static inline bool dl_task(struct task_struct *p)
 {
 	return dl_prio(p->prio);
 }
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index a055dd6..91ef1ef 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -6,25 +6,21 @@
 
 struct task_struct;
 
-static inline int rt_prio(int prio)
+static inline bool rt_prio(int prio)
 {
-	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO);
 }
 
-static inline int realtime_prio(int prio)
+static inline bool realtime_prio(int prio)
 {
-	if (unlikely(prio < MAX_RT_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_RT_PRIO);
 }
 
 /*
  * Returns true if a task has a priority that belongs to RT class. PI-boosted
  * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
  */
-static inline int rt_task(struct task_struct *p)
+static inline bool rt_task(struct task_struct *p)
 {
 	return rt_prio(p->prio);
 }
@@ -34,7 +30,7 @@ static inline int rt_task(struct task_struct *p)
  * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
  * PI-boosted tasks.
  */
-static inline int realtime_task(struct task_struct *p)
+static inline bool realtime_task(struct task_struct *p)
 {
 	return realtime_prio(p->prio);
 }


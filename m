Return-Path: <linux-tip-commits+bounces-2060-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D415955B26
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C8E2824F4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C010940;
	Sun, 18 Aug 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QgCgsuMn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AaJ9nCYQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F5DDA9;
	Sun, 18 Aug 2024 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962191; cv=none; b=uNZIu3TOoLppwxHHNphQL3+AmJdxhqQnwoyHiQD/oK+99znwbD6OK+lTTP6r4juAmuU8KpdQS/U137BpLv40Ebq1V8hysgQGvJ8ZwUMAHgCgtfY7WdSL3+bm4EPtv0+4wxm2PoV45mTVWfYnjWMXVDf1HmtLRVtrRSVmsIzoW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962191; c=relaxed/simple;
	bh=SQW8G6qIumhkHI9yEHT8i+qqK8Wiz6/vsAVRur6lETU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KM2PIV2hTC10Ggew7w1Uv9koVXctfrfkVDwgsxAhYPEKNA+Vh6UT+LEeNox5DpZfkY1h5BeOFAlqO7G6IMsr21eOwXEldR23spMAHC3oSxTeYioAxIwjfWBUBEkH7Wd/tW5EVzrbGnhlmRhzrZ71lGBrWKPQQg2SlANgPKTf0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QgCgsuMn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AaJ9nCYQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8J24fH8DiujoGc1xa74J4kuDs+d8JIkFERbXVjI7Y0=;
	b=QgCgsuMnV5mJdJ1cI/Y7OKzgf6n0fjg6iWK4GC9Pk4ZPB9xD3xwG/i83Gb8pHEylQC3N4R
	cPrBop3SCy1a4+AOdydRxpyfmoKQX+FwRI48cd3TCT3pOOCm16E2R8dINTmohK66jbPVuH
	cGAATwinJnw0ChOd81hw3oLJFD4738UPt1XvZGxWKwKKr64cqt0lCplnEo67d7vhXGPXb9
	5uKf/8rpM8ihOnv3MTSNPs2Z24knUhN6FyQ90FzucFVXkd1SnNdF94AzNvAONdzt1Z+Ftj
	ucHUuRajMaiU7+DRTINfezbqVMM47J62/FklMGbCTa5SCbGdYLghAEYi95EJRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8J24fH8DiujoGc1xa74J4kuDs+d8JIkFERbXVjI7Y0=;
	b=AaJ9nCYQhBwUrTba+b45LFIm1VsZbo1dSVBR51kL7dUSLAdTRPT/Fvk7EbsCt0f3BA7wCF
	L+WpeJ2BZWPgBBDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105030.514088302@infradead.org>
References: <20240727105030.514088302@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218716.2215.14145464753382998776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fc1892becd5672f52329a75c73117b60ac7841b7
Gitweb:        https://git.kernel.org/tip/fc1892becd5672f52329a75c73117b60ac7841b7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Apr 2024 13:00:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:45 +02:00

sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE

Note that tasks that are kept on the runqueue to burn off negative
lag, are not in fact runnable anymore, they'll get dequeued the moment
they get picked.

As such, don't count this time towards runnable.

Thanks to Valentin for spotting I had this backwards initially.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105030.514088302@infradead.org
---
 kernel/sched/fair.c  | 2 ++
 kernel/sched/sched.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a59339..0eb1bbf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5402,6 +5402,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		    !entity_eligible(cfs_rq, se)) {
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
+			update_load_avg(cfs_rq, se, 0);
 			se->sched_delayed = 1;
 			return false;
 		}
@@ -6841,6 +6842,7 @@ requeue_delayed_entity(struct sched_entity *se)
 		}
 	}
 
+	update_load_avg(cfs_rq, se, 0);
 	se->sched_delayed = 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 263b4de..2f5d658 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -820,6 +820,9 @@ static inline void se_update_runnable(struct sched_entity *se)
 
 static inline long se_runnable(struct sched_entity *se)
 {
+	if (se->sched_delayed)
+		return false;
+
 	if (entity_is_task(se))
 		return !!se->on_rq;
 	else
@@ -834,6 +837,9 @@ static inline void se_update_runnable(struct sched_entity *se) { }
 
 static inline long se_runnable(struct sched_entity *se)
 {
+	if (se->sched_delayed)
+		return false;
+
 	return !!se->on_rq;
 }
 


Return-Path: <linux-tip-commits+bounces-2404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E599B56E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 16:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E65EB22F2C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3FE1993B9;
	Sat, 12 Oct 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J3dr6ZB4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jlal1/v0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E7198826;
	Sat, 12 Oct 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742572; cv=none; b=GHl0tjEheb7KcoKV1pReRYa3z7jNh5v9vzG5J7ixYbLfvZj6040N1F5oPUd9LozcwU29RTKZ6MmMNEb7fOnKXNn4JqnVawvcdRsmDtg8T7Q7MxMsKap89fTn0JVcAYwLGuCeIyBCUkZdLR/ghUqUoqhfQ3wxDJGK6nWrsBZaPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742572; c=relaxed/simple;
	bh=7vp1glLxjQdG+izVPyYi9/jgvkmBCJ2fm1BaavrVM5k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TsXrEhG87Wf2GQhG1obUtei1jTtocPKGweY9AYbkPIF6ldIVS3JiXRmogxMmqqXYPKHJnRgp8nKE3n0f2lpSN7whTBILKiJrrABC5T6QFIdEae8mB9+fhaKDP2+FPabmyvzHrAUVgA1KEO0ZFSdF1HoXAlaxSGRWBZzkZSDjhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J3dr6ZB4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jlal1/v0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Oct 2024 14:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728742563;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDIQqsXmnLg7FHFtgthqIl4Fa+xMxT5RVA9vGg4jQz0=;
	b=J3dr6ZB4GwW3ZruFa9HFpxsH1VZnfWXwArJ+kalMymslu1wquCRSo49sKWTH6DgefJDKI5
	9W/rhSKN7vJAcmLGYQ3hiIbmRaR8UGKgf7Gb9azPLre7tarIfaK2q9IkrJ8LRYE2CQ6lO/
	mqb+g2NBPSwxkr1pDLKBA9nL0TbljHfu6yQzl+C7K942RjIMmFzFI0M0CsKBwHZC55A58J
	gSEQHB+qu5smVkSMNvsmSHnpfYsn3YhERXJCcmAjCUeXCfvrOc9zV0vYSBOr7Q18fgJQw/
	8e0S64YOEf4O0Ij+IZHrJmPdKe50tounOsaygTin2qej84XM6k55WIX0+pJAKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728742563;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDIQqsXmnLg7FHFtgthqIl4Fa+xMxT5RVA9vGg4jQz0=;
	b=Jlal1/v0OlhnjsWlm/yoWt+ezW/lGgN0IOk/gqwG7+kkH6Dp/HQC2eUMVsni6k6pCmxQuS
	CVQZI7LGLdGJQfBw==
From: "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Use hrtick_enabled_dl() before
 start_hrtick_dl()
Cc: Phil Auld <pauld@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241004123729.460668-1-pauld@redhat.com>
References: <20241004123729.460668-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172874256158.1442.10862855848728117458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d16b7eb6f523eeac3cff13001ef2a59cd462aa73
Gitweb:        https://git.kernel.org/tip/d16b7eb6f523eeac3cff13001ef2a59cd462aa73
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Fri, 04 Oct 2024 08:37:29 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Oct 2024 10:49:32 +02:00

sched/deadline: Use hrtick_enabled_dl() before start_hrtick_dl()

The deadline server code moved one of the start_hrtick_dl() calls
but dropped the dl specific hrtick_enabled check. This causes hrticks
to get armed even when sched_feat(HRTICK_DL) is false. Fix it.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20241004123729.460668-1-pauld@redhat.com
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ce93d0..be1b917 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2385,7 +2385,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 
 	deadline_queue_push_tasks(rq);
 
-	if (hrtick_enabled(rq))
+	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, &p->dl);
 }
 


Return-Path: <linux-tip-commits+bounces-2075-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B712B955B43
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D911C21087
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095F6EB64;
	Sun, 18 Aug 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TXO5uBv5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bBMQSFE3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BD200A9;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962197; cv=none; b=DAjXIP1D8DZ1q2mxD8NoJ+rXrFabIvvchwnY0JN2Zv6MsYGM3OrzS3hOYiRX88olNNq3tToakVCrGTuQTO4XEfob3ATey336Z4iQsK4xGlWctNBTjOjmdnWrsoaXMGc2jDPM7TgxlVNZgyrRs0LGAYKMelovumShYzQ8RCZFXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962197; c=relaxed/simple;
	bh=fWpFre8PEINNDhYwjbP9gmfg/ISaat9urEqkosxwKwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H5y7bO4klSfzEU68mVn3XMfhglOWndRjO/XWg/Mr9VbmMhISlDxPBEwNiExIf7zF3Np/uE0EpPbyUrXDTQkTXgdjGOf+fNiot9ksmRVZ1mejcxEY4FJAJk4iSsIUpL0PYGQF6BNLiIx4Gc2P8ZtzvVxcwxOWRSv80wlzFgi1PxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TXO5uBv5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bBMQSFE3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyjc4lUTWUmKUaa6yf5FtUQnwZkbhXUd9Ryu1PdHOGA=;
	b=TXO5uBv5zQDJ19pnYWVYA6mSQbKsQoR70R/ydspz8y81SSn8fQZUZHQOGOR+SbmRAWlgBn
	eMzEJ7OQJ+m7gin0eE1WP49Zs32m4I7h2N6GwVrqnYQM8K8HCvF631uRUzQDCt1MWVQin8
	tbWwSJ6oQl5kvjFxYFlJkUU9YMugsRlALB6SoMC6C6WrOy2SB4ayqJxr566d96+0TJwbH+
	RAPVgXJlTASgbnQCXd+Dm5HzX7xKhJj/0kmXfrm+tCsOagaUaC9iEhVmkM1XAqKNb9e6qC
	OI/Ei7nFRo9c9gogR0phAXGEKudA8qzYfUuJ+YSt9khu4gkC53yC0XYIE4ODMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyjc4lUTWUmKUaa6yf5FtUQnwZkbhXUd9Ryu1PdHOGA=;
	b=bBMQSFE3LfUH3PTnSJ6g3tM8Bk6KT+bzRu1R8pD296HEyvuSMhA16wTF3+CAxYn9d8JK8U
	i7rHinttNZ7UvXBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Cleanup pick_task_fair()'s curr
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105028.614707623@infradead.org>
References: <20240727105028.614707623@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219167.2215.5679069297614499404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c97f54fe6d014419e557200ed075cf53b47c5420
Gitweb:        https://git.kernel.org/tip/c97f54fe6d014419e557200ed075cf53b47c5420
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Apr 2024 09:50:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:41 +02:00

sched/fair: Cleanup pick_task_fair()'s curr

With 4c456c9ad334 ("sched/fair: Remove unused 'curr' argument from
pick_next_entity()") curr is no longer being used, so no point in
clearing it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105028.614707623@infradead.org
---
 kernel/sched/fair.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7ba1ca5..175ccec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8463,15 +8463,9 @@ again:
 		return NULL;
 
 	do {
-		struct sched_entity *curr = cfs_rq->curr;
-
 		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
-		if (curr) {
-			if (curr->on_rq)
-				update_curr(cfs_rq);
-			else
-				curr = NULL;
-		}
+		if (cfs_rq->curr && cfs_rq->curr->on_rq)
+			update_curr(cfs_rq);
 
 		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 			goto again;


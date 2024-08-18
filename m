Return-Path: <linux-tip-commits+bounces-2073-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435D955B41
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FFF1F21983
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3914DA1F;
	Sun, 18 Aug 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VviVqbUM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOoPjGvy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D499210EE;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962197; cv=none; b=EG7J0ekXy3ed/aR78GFr01E1NVyuLLMu3LJ3QSSnlcoNV2cR0GmTjPT38nzgWiAF725UfdjcU/vXHt0dOzbYL7czI730e333YvADT8ov3L5lUGofBT0sxKFJIKv0GU0HHZEkW6QQWK345NJABRSxWarST2xMtNI9pKTfVVcPFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962197; c=relaxed/simple;
	bh=3InMIdYcsYCj1eCELgQq6yUViZpUG9UgSsh8i0ZD3HE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RoOxXnWnHGtEJjZTpuEXDF0i82p6HFL5SeQ8HzKIWnSTKBJR589FVRvzHmbrBesMhtroBPVurQ4xTuPMyxaaT8IVG1tafy77Sn6ApO4mitTNVofL6OQ0TYKIZDPmECQIHifKzz+tFJrB6j9PYybxR+BNlg8algKRwBQi6pCb5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VviVqbUM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOoPjGvy; arc=none smtp.client-ip=193.142.43.55
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
	bh=U8UgdiEs0J2qxWvvFwdvXkoKh0ZTrMib7dcd57HBGYw=;
	b=VviVqbUMbMSa0UqZyzJylYZEvYqxzEIDw1zhM7uQQAbKDhaN4iPpfVrwbgZT0f1sEI9Rnb
	y/bwJxORrVvzDaxt30WgzdIzxWiSLb25Xg6joZuM2f+sHoj/TIjBFu+9b4z//VMvNA1dBP
	IghOGAIxilyC0Df57XtUSIkvPtG3aSInqhWG1yIsWXbwNOYYdkbfXA+pZJjScku5bZY4Ii
	vjqoyh0kXkEsL0gfmAFB+U4L6SrE/xvF6bp/m7nPiiw/tH3/qDNXSeb0MAXZdjrQ2uUoFk
	ILejQHK3Djo/YjoFnUA+GptoTL7oDbu6Sc+r2FdKXvUp5pYD85wgL4duc4+E1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962192;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8UgdiEs0J2qxWvvFwdvXkoKh0ZTrMib7dcd57HBGYw=;
	b=JOoPjGvycPu9j1lZ6Sw5TItd+/gul0OwMsXv5/WgkBYihXEDQICLOOtWhI39WXkseaoazR
	6vuRwd/bWAKKGODg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Cleanup pick_task_fair() vs throttle
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ben Segall <bsegall@google.com>, Valentin Schneider <vschneid@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240727105028.501679876@infradead.org>
References: <20240727105028.501679876@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219197.2215.9997555285176136397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8e2e13ac6122915bd98315237b0317495e391be0
Gitweb:        https://git.kernel.org/tip/8e2e13ac6122915bd98315237b0317495e391be0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Apr 2024 09:50:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:40 +02:00

sched/fair: Cleanup pick_task_fair() vs throttle

Per 54d27365cae8 ("sched/fair: Prevent throttling in early
pick_next_task_fair()") the reason check_cfs_rq_runtime() is under the
'if (curr)' check is to ensure the (downward) traversal does not
result in an empty cfs_rq.

But then the pick_task_fair() 'copy' of all this made it restart the
traversal anyway, so that seems to solve the issue too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105028.501679876@infradead.org
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8201f0f..7ba1ca5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8471,11 +8471,11 @@ again:
 				update_curr(cfs_rq);
 			else
 				curr = NULL;
-
-			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
-				goto again;
 		}
 
+		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
+			goto again;
+
 		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);


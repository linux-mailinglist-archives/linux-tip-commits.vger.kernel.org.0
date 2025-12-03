Return-Path: <linux-tip-commits+bounces-7599-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9952FCA12CC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0611D3002880
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D77346FBE;
	Wed,  3 Dec 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bnNwJoCk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="smpRh2oV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C18347FDE;
	Wed,  3 Dec 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786676; cv=none; b=FDFZ3PgGVc8POzwuxJG5sITD4NYYEflLRBPQUEuyDDpUWU1Ok3u/erUdf+VnMiass5bS1CirDKtBkYk8aY0hQ2JElew4ptm8ikb9b2JUbbVJ5b6KH4RMpy7pwJE9qD/Y6STcT/YAQsBFvKw+Bfpw53Z7JGU6l0mIkKvUB/pwPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786676; c=relaxed/simple;
	bh=9WEg9dQTqBHs8PL0oEsk0Bi/5dQA9R5xQejRf4DYJGc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZKw0SUGM5+4CMi0H5wTwdWrd//m7+T017xtve9oEJgCGqe0IUrcsDDwxOaUOHNhbpA4YgHJwfhKzISJ5GloH2db4eGyv4rjzvVJiYRen2kb9saYJlgY97XYrAPYcnyYIPB7nm1oenR6PBvaVEK07+CFy6u8N2pa4rb1AQuA1xvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bnNwJoCk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=smpRh2oV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c2WXE2uP4Rcj3+aZDpUknnpsSO6iXGVgzXgi5Trrc4=;
	b=bnNwJoCkiQceAR9uvSKOcYxs+5kDKdYkgkpKofe46W1XQMNoslaNgFzQAkzTtMdGDguhRL
	6eTm/CLBqflXQEloMVmvV6dApJtnMb8krNeGF9b6KmLKUM2ns5cP3nhrXFLi4FCAY8lxCH
	yphszI5jsiaWjY3PmwCbswofFlAtEKSbK79a9GOV16chJf6KjgFji1NMKijsQFHbWvsZcf
	hDB2/TEhzeFhfgQoiSgoQCLDz/3NNAZ4T2L4NtLmYltYxpd/kjk9+fdK7soqCQQA7HdabN
	fbZns44uhftujpCWXWqspq6JIoESPty9S12/Vb6aXOmhlQTQ3NDtlnkB2SVEEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c2WXE2uP4Rcj3+aZDpUknnpsSO6iXGVgzXgi5Trrc4=;
	b=smpRh2oVi++Vle2ycuOV0waAEo1J7G8BHZW8hBywuz/IceZBJktxqa+VGnUNSoIT3yciy4
	GlOT54Cu1HcNwZDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/hrtick: Fix hrtick() vs. scheduling context
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250918080205.442967033@infradead.org>
References: <20250918080205.442967033@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478666986.498.5419895556054571407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     40671f3f91986844df8947b65b9af5e770752047
Gitweb:        https://git.kernel.org/tip/40671f3f91986844df8947b65b9af5e7707=
52047
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 01 Sep 2025 22:46:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:26:00 +01:00

sched/hrtick: Fix hrtick() vs. scheduling context

The sched_class::task_tick() method is called on the donor
sched_class, and sched_tick() hands it rq->donor as argument,
which is consistent.

However, while hrtick() uses the donor sched_class, it then passes
rq->curr, which is inconsistent. Fix it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: John Stultz <jstultz@google.com>
Link: https://patch.msgid.link/20250918080205.442967033@infradead.org
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc358c1..1711e9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -878,7 +878,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
=20
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
+	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
 	rq_unlock(rq, &rf);
=20
 	return HRTIMER_NORESTART;


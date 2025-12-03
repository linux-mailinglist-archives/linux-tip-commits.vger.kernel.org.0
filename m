Return-Path: <linux-tip-commits+bounces-7594-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45387CA1390
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DB5325CB5B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB23164A0;
	Wed,  3 Dec 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OA7/zlyQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1qp0Yl0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73D312831;
	Wed,  3 Dec 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786319; cv=none; b=eiZhLUc6bIelwsIGdar+vnM2T2+5vxz0I3/LxouAEHrbCe6jyznVbTIuJ3aWYw65B+mj7Zlin8Y4pNB8lIbkFRNbc57U19rj4Kq5NWFcmzzDN8rzPbYhAS+jUVBjO1BgEIDvbNtEAvju3HXZbgG7O5fhDiLI7n8rsuMyNlxwLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786319; c=relaxed/simple;
	bh=cJg4mJjno0rp0rsm356rKYcJ06Ew1OktMioXG6SMi20=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DNQcvz+jJknIHlNNsk3NCDYmR98vbi1AMhjcB4cBHHH088MwUdNgL73AIj7ZgyfriV1TlqAybUhHtlS8IlTF0vYDdMgrtAM8sDLHe5rpaiJnlo01AEyNW1lpuc2kmqmrkQ6MLip5wC5f0/PqjtyEVhCcaB5VtDKTc87nihQI9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OA7/zlyQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1qp0Yl0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:25:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786312;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjuGoFJZyGPt1nb3/QqunE74KF33Q8VlNUvaxi9NeXw=;
	b=OA7/zlyQCPzRl+ry3RSJq1M3WhxLtvTiWG8EGFFKGC/oeEd9ZKpZwWVrhYaxiBazY4Hzkb
	Scl7U1DUvGB2G5jIuVceGZh1I3cQ4xqdqyM/G0pcIEU5mi8mTjipFIolQ43gp0KbOJNh8c
	VVwcvMuJLVb73AVgZE6LsYqiV8Pxg4CeAlttt9LTmS/qKK/GBQ6lqEhbRNz7N5XJwqMrlb
	l+MqqyoLRMS/3AxZZD0738TT1JNnfOLbMs4gy06OJ4mQozE/CMcArzNkMGFv9/50l4hXMk
	aV1eF510TV+HaaO1LiFmN5caOTnQwm+pMgAKTWVGk2opNgqMm3UTu7WZ9ok+Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786312;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjuGoFJZyGPt1nb3/QqunE74KF33Q8VlNUvaxi9NeXw=;
	b=j1qp0Yl0v57v7J66892UNCrVr3pKMcTlK6F3syBYeJTVtdkMKC8Yvg6GEhldgBjXoWClsa
	zqVQ732bbi2fkjCQ==
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
Message-ID: <176478631093.498.14674730101010917528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     8720ba2d028f1aff08a55d8fe1a124dd5a6cfb0a
Gitweb:        https://git.kernel.org/tip/8720ba2d028f1aff08a55d8fe1a124dd5a6=
cfb0a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 01 Sep 2025 22:46:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Dec 2025 15:37:52 +01:00

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
index 7dfb6a9..be55f95 100644
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


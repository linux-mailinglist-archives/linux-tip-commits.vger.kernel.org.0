Return-Path: <linux-tip-commits+bounces-7656-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BFECBB792
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A1D3301B2EE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2B2C21D8;
	Sun, 14 Dec 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kWZJEYjd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hMiSe2vm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C42BEC42;
	Sun, 14 Dec 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698409; cv=none; b=L4MvTdSpuJSITu9Fo30KbjgoAa9n/alL0O2uKov6w0fixScJ747UjjOSjUCb7ce3X7dTjj90KvQO5Yogv8CX8abeQ2n4Dw8UAYsNkxapPIr53bb7X7pB5fXikJpEGbu5gZEPECyTNIGmRvSAZrz5btS1HZ2Inmgtn0JSB2P6eTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698409; c=relaxed/simple;
	bh=uch4LVCtt4F/okM1Qz7OCdAiaRg33RyarvYVpIAvGTU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T6M0LcLyKXo/UarFyZBpE8bUJXAtPSgJVL94ied9qPzICjvt6xosUnt9lETB1r8WLTL0zoYln94pb5YdOg0oWkB4R+32qlfWhJymgFUpYsnqB6Z/NBWEdObuAwE2qSrX+zyB0onBjUUauZ620/mYiHqgmHvXp6ZXJKQ+HQVr9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kWZJEYjd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hMiSe2vm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/1beNgHSLRmIlyW7IGgUnxYnUj1dE9TCyMJ8rMVIPU=;
	b=kWZJEYjdnTVU+s8qA6TzyJvbKsYvjoK9gObVjsAQ5VgxHruEh9Ah3haMVoFNMANY9Y/2P/
	dA6iYj3dCeMsh1aXE0waiqUgoo6hRx+nU4rSN3TnNd57CU0bdqgN9XJq8CyRQ2qMtKO6F2
	BkATs6WgNeth1MwjzzT7jVnY1TJ6Pm3vsNwR6eizFb3n/9bym8OXuiU/5c3er7BdCmtIu6
	U9yRURrqC06+bAIDd229hUOfUyZI16eXhF00DICjvfBXQm6j91DbVUBZF9zo+T3UtPwJEs
	aJSU+pp/e+PXmiJs3OaKvFZsxG3xfVZK1ElSGwA6JAXrooJmf0qpwU5bouKZtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/1beNgHSLRmIlyW7IGgUnxYnUj1dE9TCyMJ8rMVIPU=;
	b=hMiSe2vmhdvdjyBxAeDeYY73FfkSH7ZK7CVus9i0VK5UNo/DwTLLXXvTAuDASwmch++nm2
	isv22hp0UHTSwFAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Limit hrtick work
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250918080205.563385766@infradead.org>
References: <20250918080205.563385766@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569840329.498.11558609512617664315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     95a0155224a658965f34ed4b1943b238d9be1fea
Gitweb:        https://git.kernel.org/tip/95a0155224a658965f34ed4b1943b238d9b=
e1fea
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 01 Sep 2025 22:50:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

sched/fair: Limit hrtick work

The task_tick_fair() function does:

 - update the hierarchical runtimes
 - drive NUMA-balancing
 - update load-balance statistics
 - drive force-idle preemption

All but the very first can be limited to the periodic tick. Let hrtick
only update accounting and drive preemption, not load-balancing and
other bits.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20250918080205.563385766@infradead.org
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 496a30a..f79951f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13332,6 +13332,12 @@ static void task_tick_fair(struct rq *rq, struct tas=
k_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
=20
+	if (queued) {
+		if (!need_resched())
+			hrtick_start_fair(rq, curr);
+		return;
+	}
+
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
=20


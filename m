Return-Path: <linux-tip-commits+bounces-7597-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11267CA15B5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 867B43066D9C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDDA346FC0;
	Wed,  3 Dec 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="udLQDQTw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cB/utKIw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F21346FBA;
	Wed,  3 Dec 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786672; cv=none; b=s+Glf1Y6nRQWkL5bjXe/srkzEVFG58Ov1DJQ++nPxLxDspaaFmaQA5UdIsGd+b4EMjwPeLP+O01naZS76Lc/ri7Ldp50pDlNXADLow6OtGGwSJ+qVAnFzkzvx6QFp3kgC6YbBrUVIIx3lmg0w9STnjI9RlHrRpuk9SZarsgXGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786672; c=relaxed/simple;
	bh=ojgvNvqa/EVDRGYoRCZRqurh4oQWl1MsAVncmjfkI0M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HUH8u0JQUhdjEhI2TFZkSuEBG5QFHKiHgIXfRypMvUmPdQHUjqO540aXr4xPym/YjAD3eFRU7zC7bCDLeAGqhFnQKlHt0qhRGLOqtG87+NCj1zIXut5s9uharKk5tLo3Zqh6rjvef3odJgCJKiu9jKqAQlIqa88mc6af7Hgtt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=udLQDQTw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cB/utKIw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:31:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUsZG7DNe3LCXju5LxuN/MpkgCJiT1vBDzZLFOXb6Ho=;
	b=udLQDQTwnVsNP26rwBMl9vfz17n3mI3Q7b8IbbSj3FPh7S7oa0YsNUbS24bG0/G++SkgY3
	Z/lB/Mgta0/z2ZNkp8nqwBtD7Rld23AIqEtALdjiqEvTBzyJLFRtBHHqT6ZB3P9lgMzM/u
	Zd/ku3t2HBtG5GjbrC+FAvOn3BDqNOCEDI8jua/4FnVSHddgR7tBeixIOKR4+CPUQg2eO8
	JkXcKMaiClY5N4nF+RtFWgSnjiEgVZB/LLlfOjtilbjFgfMHGb+9jxGdwvyBv3c/eT2FZP
	xtPBeod85M48NFpI/5mEc0c0ZEsrYVstMwHrf23IJUIZ6+5tll93kiSNxXZmEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUsZG7DNe3LCXju5LxuN/MpkgCJiT1vBDzZLFOXb6Ho=;
	b=cB/utKIwJFdw22+/9h3YTru2ROb6ZaHd0kRsQDXvmCq7Fnrv19otA+c9sfmeOu7gLxDzLr
	PL1s8/p+4vlErTCQ==
From: "tip-bot2 for xupengbo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out
Cc: xupengbo <xupengbo@oppo.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Aaron Lu <ziqianlu@bytedance.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250827022208.14487-1-xupengbo@oppo.com>
References: <20250827022208.14487-1-xupengbo@oppo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478666765.498.14794586596740719888.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     3dc7ae575aa1a32971565d9aaf784e6050dae959
Gitweb:        https://git.kernel.org/tip/3dc7ae575aa1a32971565d9aaf784e6050d=
ae959
Author:        xupengbo <xupengbo@oppo.com>
AuthorDate:    Wed, 27 Aug 2025 10:22:07 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:26:22 +01:00

sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the las=
t task migrates out

When a task is migrated out, there is a probability that the tg->load_avg
value will become abnormal. The reason is as follows:

1. Due to the 1ms update period limitation in update_tg_load_avg(), there
   is a possibility that the reduced load_avg is not updated to tg->load_avg
   when a task migrates out.

2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
   calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
   function cfs_rq_is_decayed() does not check whether
   cfs->tg_load_avg_contrib is null. Consequently, in some cases,
   __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
   updated to tg->load_avg.

Add a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
which fixes the case (2.) mentioned above.

Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
Signed-off-by: xupengbo <xupengbo@oppo.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Aaron Lu <ziqianlu@bytedance.com>
Link: https://patch.msgid.link/20250827022208.14487-1-xupengbo@oppo.com
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00a32c9..a31d88e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4034,6 +4034,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs=
_rq)
 	if (child_cfs_rq_on_list(cfs_rq))
 		return false;
=20
+	if (cfs_rq->tg_load_avg_contrib)
+		return false;
+
 	return true;
 }
=20


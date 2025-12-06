Return-Path: <linux-tip-commits+bounces-7610-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 594FDCAA32D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 06 Dec 2025 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FEDD3011F9C
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Dec 2025 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386A23E25B;
	Sat,  6 Dec 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RIEINXJE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XnvNX7Eh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3D1B983F;
	Sat,  6 Dec 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765012247; cv=none; b=H7NEBtfSWAE/Ntz3fCYvEr2bTmTqBa83895vt2N1sctxaRO+mHkvhWbBGDdf7ySXx9gQ5R9IS83OYhpygH+ckzSd924ffB8XEVHk0U9CIzbFgTlNmDARSwdTR7eoSIgF5wI/7zncUtD/d+nP6b7tOZFp5e96sSW3euvqfSdjCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765012247; c=relaxed/simple;
	bh=0uAEr5xpM8+0gPoFIfxJiLQvteHBavq+xsE2w/PZib0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KNNkKy3C8delzqgy8JJkHDb2BJ9PAmcJ0CKfLS6tMP43Sjvgb10eiOsNBdek5ZHz5Y6/Mgpe29cJsA+B+DSxfS323tV4CYEPPOe4EsPvi7y/3xOg6cIS7tT90f3CT03bMIPHG5YZvV1vUbXDh9jRdo2DwhORcB8JIh5dgd65+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RIEINXJE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XnvNX7Eh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Dec 2025 09:10:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765012244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZeIvIBMZ+U0crmY/PRoD9i/oSJGSfVzsBH8Zdi5cRA=;
	b=RIEINXJERVqcAH5lFmTr/oL6BbXBKLQpUlBE7o3bRB8s72fgS9f1ckD85p4OIGXKU3ILNS
	I4QZxspUiuIC8uwfS+tOTIxABu8AkDF3sfFgWJnNO953qkjkAdJ5IOGIW83ABbPMzRzkWo
	4r9KN5JCczcJYFBtv0WWYJu0BnPYol4SOCahVmuyFgCjwnMzTNswqMsHlR5IlrXhangio5
	gCWA6BjE3xVIiQsFghE+o9vlMBzgV27RhSirF4QT0abrNYyoK7Wdz9o1YuAovbqXQAD8HM
	7K3SphXfW9xYzllI1DrezghitexDjjanREAsADeP/4dBrCbGCPnfAAMCre/Pjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765012244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZeIvIBMZ+U0crmY/PRoD9i/oSJGSfVzsBH8Zdi5cRA=;
	b=XnvNX7EhQDccQUOJIeKFze6ea3S/uHNAcS1/efEoMJJKNwm2PZXqOK+Ni7aHCVFrYLuAWx
	qQLcnoXCUs4rlpDg==
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
Message-ID: <176501224219.498.11354500034109601677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ca125231dd29fc0678dd3622e9cdea80a51dffe4
Gitweb:        https://git.kernel.org/tip/ca125231dd29fc0678dd3622e9cdea80a51=
dffe4
Author:        xupengbo <xupengbo@oppo.com>
AuthorDate:    Wed, 27 Aug 2025 10:22:07 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Dec 2025 10:03:13 +01:00

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
index 769d7b7..da46c31 100644
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


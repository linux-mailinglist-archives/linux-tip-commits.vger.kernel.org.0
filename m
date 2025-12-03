Return-Path: <linux-tip-commits+bounces-7595-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3BCA138A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D930F325F6CE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398231A56B;
	Wed,  3 Dec 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ikeb7BUY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2/6qMQn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA2F309DC0;
	Wed,  3 Dec 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786319; cv=none; b=QFIJ4NtawXDxOwngs7MlC5sQgsOvFhV+bcGr/XbViCp8VVoF/yEUk9klBtJ8e9JcuD8UgylbqlzCCMLJUTQk7O1r6iUZDzyR2OCSeKtjht03vrGkKqPWH4Jq6KdXcpH1O+870ShCRa2IIyf2ki8SR4L+bTJGstsId0oa15wKUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786319; c=relaxed/simple;
	bh=yOq06h+80oK43m2VW8dVR1VTsjFL4AkZYZ4jI8RfCJY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=apEB7cnfQR/pI4QqZo/J7lyEV9jGYTzO8BP5ejg2HpZLgPxwbqNR3VoUsrpzYAx9gB5ADM9M1Y7ODHfobSx7iNHigr3EYxe439SsEtUepyzK9wNnlHstYdAh7zt7BL3PLk6E6akH9NC2ZaejlfPZ4nHhlumYj4Zay+uVHn2Pzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ikeb7BUY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2/6qMQn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:25:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOgg6zzV2vR0dGhgCrhOHvBsRfEyXPv2IthXP/pBQk8=;
	b=ikeb7BUYAy+1xTeq4C+5x4bxvsxYfMzA1yZnGplf3dZMpHaXWU8v5RilybS4ncv1Y0rZV0
	0NJNwPjDiyNOLi0l0Zug2/RKy6lUOl73MY0dlYg4ZlE7m9DjXATwAsZto5JvKofbWCkR65
	TpC5DhqMoiDUYTRVZOA0fgCJReuNew1xZEXFXP/IFZBtyLAxOFi5oTNNTmVcQlokbEdxRk
	mRqiPmoexd9wkdVOQi+CWg5ycF2x0WdpIt8hZHdEtznLLIK2vJcGM3GhEoJeLJg9d4Kg3y
	dYV2xqli3Voby13ZngN+RL6AePwQs4fOXPzgPjbQ6c4+7b/UPGM3rhvVUiF/ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOgg6zzV2vR0dGhgCrhOHvBsRfEyXPv2IthXP/pBQk8=;
	b=H2/6qMQn2tYFGgTcyLc9onaJY0aQMuBNbZAv8q/BshKKaPMEaOQ9J16+1Ap55xYWP4+rHd
	JaLMsf/vFT4uD2Dw==
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
Message-ID: <176478631306.498.14266514375160843863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     36c26a1f1f510b23ab81db176c90921305fae669
Gitweb:        https://git.kernel.org/tip/36c26a1f1f510b23ab81db176c90921305f=
ae669
Author:        xupengbo <xupengbo@oppo.com>
AuthorDate:    Wed, 27 Aug 2025 10:22:07 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Dec 2025 15:25:00 +01:00

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


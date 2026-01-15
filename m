Return-Path: <linux-tip-commits+bounces-8027-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590BD28D60
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E980030AA144
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC213328E6;
	Thu, 15 Jan 2026 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRx+OLsc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v698B8w4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7C3314C3;
	Thu, 15 Jan 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513463; cv=none; b=GPKM8rp8+lmECs5zqLu0Qia9D0FjkyROrR3SzhF1ZGx0m+OP8uaAG7XTrnbmtSkTt5HQJuVh4q6ZkVSMs/dtRyoVzfNqi0w6XVaJhoDyLIVH2EzSO/WHGIt6p3RhPx1TVB76K1cgsS4u2ggRY3UlHqmWPGjh5dPOVvzSeOwcu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513463; c=relaxed/simple;
	bh=lNwUMQXiv+/OS9RfjSAvUauJAkZkayUayVX4t67aHqg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MdyOdHQLnGArFpkOmYjRSclGyQtL3DDGV1FATDzIY4Zl4negT1TkVaOQQei+GpD8t8Iwrvdsp0J/Tu1D2EL+sTw8duD0fmKp3HbjOubQ8amM+MHRPM3sL1ZV3+oi/2aDuz9+1p9J97x5BmyuX0/o2zBia0Bek+5xf5yiDM0W6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRx+OLsc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v698B8w4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/b+Oc2mdkSSqj8cjyQOWp2akpZToc836zQtrQnhIik=;
	b=PRx+OLscL3g2wruk7iFw7AxTptjbLclJywzFolzUMGpuhldVJOWhXQYuj6JPkunJ6tIfJF
	JSiRaCFqIAPwuF/FfPV/Hma5nkXB46STWu0MFszcBOp7fkfyedkXqgqAFom5bQ4aJCD46B
	r4xEe42yTvKxtQBgl7mENRc1RimJvmICdvLCReTIes2E4Jy7uhS2olNoUXlgCHHy5mtgf4
	XRvt2H5BfzzLdqzVshAX6YTaUNMbjUAt0tClWuEqwOXqF5RzsBOZzYTHkN3Ka59Nmis5A8
	vuFqg2q2B87VRNCMGbSSDqt5j6Pxi6/Z2Pus96Jgw06lI23YLaQqm5F9/mvxqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/b+Oc2mdkSSqj8cjyQOWp2akpZToc836zQtrQnhIik=;
	b=v698B8w4jaYMcnE9KUf1ZN5AYgVUnFtW/y6r/v/EhJvzNCkr8Ie59MflpOEamegjdn9saK
	oUK/wXMBt5ktTvBw==
From: "tip-bot2 for Zhan Xusheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix math notation errors in
 avg_vruntime comment
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114090035.19033-1-zhanxusheng@xiaomi.com>
References: <20260114090035.19033-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851345880.510.10598609220244806180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     553255cc857c08d72658b57d01c04f76cde9a83a
Gitweb:        https://git.kernel.org/tip/553255cc857c08d72658b57d01c04f76cde=
9a83a
Author:        Zhan Xusheng <zhanxusheng1024@gmail.com>
AuthorDate:    Wed, 14 Jan 2026 17:00:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 22:41:26 +01:00

sched/fair: Fix math notation errors in avg_vruntime comment

The avg_vruntime comment contains a couple of mathematical notation
issues:

 - The summation over w_i * (V - v_i) is written in an ambiguous form
 - The delta term refers to v instead of v0, which is inconsistent
   with the code and preceding explanation

Fix these to make the comment mathematically correct and consistent
with the implementation.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260114090035.19033-1-zhanxusheng@xiaomi.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebee20f..af120e8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -613,7 +613,7 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struc=
t sched_entity *se)
  *
  *   \Sum lag_i =3D 0
  *   \Sum w_i * (V - v_i) =3D 0
- *   \Sum w_i * V - w_i * v_i =3D 0
+ *   \Sum (w_i * V - w_i * v_i) =3D 0
  *
  * From which we can solve an expression for V in v_i (which we have in
  * se->vruntime):
@@ -648,7 +648,7 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struc=
t sched_entity *se)
  *              \Sum w_i :=3D cfs_rq->sum_weight
  *
  * Since zero_vruntime closely tracks the per-task service, these
- * deltas: (v_i - v), will be in the order of the maximal (virtual) lag
+ * deltas: (v_i - v0), will be in the order of the maximal (virtual) lag
  * induced in the system due to quantisation.
  *
  * Also, we use scale_load_down() to reduce the size.


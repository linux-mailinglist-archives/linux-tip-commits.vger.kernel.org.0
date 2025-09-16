Return-Path: <linux-tip-commits+bounces-6649-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10AB5957C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F37A2B77
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACFE308F11;
	Tue, 16 Sep 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zV8UHxYM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GvKMlS5V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ABB307AEA;
	Tue, 16 Sep 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023017; cv=none; b=lH+6GNXXTOqlA1jKLwD4wy7zsSt5ULrOvTobjdC1fDkMT9G90xPRWmtDwP0N/0zyUuoY/9fuGtuJBMjw0J9Y0IrW/8+5Ty21uP1kMCjPBr/tE0cdhzVj8lTE1y6OmjkRvr9fF2JVa1JND2jBcSRaDfbBzN3av4o1ZObeR7Z/P1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023017; c=relaxed/simple;
	bh=MNw6y7i4bGasSbBXKvwBZKxgJS8dj9Q25AGwXJWEtvM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gBLAImlIrqQm1LvBvbUeiiUYoHxyPdvkF7LCYX74VfuG7lB64IeCKJNC+0eqP79hC7p+Vu+HyJKCk+MIh5Zc1/CWJIrXH5wSOE0nb6DUffSdFuwVHQRp+HQUvWjAhEHKs2vFJpNiLP6iMSwTP74CKR1MNsWH9e2m9wLBU+ne+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zV8UHxYM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GvKMlS5V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 11:43:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758023013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB4CffaxYYXAdSlFX/F3FjyMBIj1vbIa8GgiamXd3rA=;
	b=zV8UHxYMbtMkBhwXEcPKZZqAaMDmJvcIcWl9vLRNWT2xhQwtJaW4YJg8s97/twLQvhDTsF
	qZ6Ome38PzAihX70uGKsbQ0xib67JqjfmrosZrumTygh0kB4YultSx2w9Lx7M605fi7FNl
	oPB18z3+c3kYzahhhfxAf5699wyyWh38QiMDNdyjMRXT0CSr0v1sPj3RCZA04BtNTJ8YYP
	FteXFHXpeNNQR1Rg2L6G54gBysmAIKym5fzr+h6ADnYvtgbkHszt2NWCBnkRyZGDC0xbCj
	kaVgQDax2IB3dDWqY1a7vaYdUD3qyiGP+SDBvh4uWRyiqE+riNk/wEN8kxRCCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758023013;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB4CffaxYYXAdSlFX/F3FjyMBIj1vbIa8GgiamXd3rA=;
	b=GvKMlS5VgGDy+chXgF14usFPkQCk+B8Y6l/Bn6mtFTsRS3jEGMDJPvXzS5f0SyQuJaZhKu
	PHB9IFkjmom1V7DA==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: update_cfs_group() for throttled cfs_rqs
Cc: Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250910095044.278-3-ziqianlu@bytedance.com>
References: <20250910095044.278-3-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802301247.709179.4721721462650666548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fcd394866e3db344cbe0bb485d7e3f741ac07245
Gitweb:        https://git.kernel.org/tip/fcd394866e3db344cbe0bb485d7e3f741ac=
07245
Author:        Aaron Lu <ziqianlu@bytedance.com>
AuthorDate:    Wed, 10 Sep 2025 17:50:42 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:37 +02:00

sched/fair: update_cfs_group() for throttled cfs_rqs

With task based throttle model, tasks in a throttled hierarchy are
allowed to continue to run if they are running in kernel mode. For this
reason, PELT clock is not stopped for these cfs_rqs in throttled
hierarchy when they still have tasks running or queued.

Since PELT clock is not stopped, whether to allow update_cfs_group()
doing its job for cfs_rqs which are in throttled hierarchy but still
have tasks running/queued is a question.

The good side is, continue to run update_cfs_group() can get these
cfs_rq entities with an up2date weight and that up2date weight can be
useful to derive an accurate load for the CPU as well as ensure fairness
if multiple tasks of different cgroups are running on the same CPU.
OTOH, as Benjamin Segall pointed: when unthrottle comes around the most
likely correct distribution is the distribution we had at the time of
throttle.

In reality, either way may not matter that much if tasks in throttled
hierarchy don't run in kernel mode for too long. But in case that
happens, let these cfs_rq entities have an up2date weight seems a good
thing to do.

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f993de3..58f5349 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3957,9 +3957,6 @@ static void update_cfs_group(struct sched_entity *se)
 	if (!gcfs_rq || !gcfs_rq->load.weight)
 		return;
=20
-	if (throttled_hierarchy(gcfs_rq))
-		return;
-
 	shares =3D calc_group_shares(gcfs_rq);
 	if (unlikely(se->load.weight !=3D shares))
 		reweight_entity(cfs_rq_of(se), se, shares);


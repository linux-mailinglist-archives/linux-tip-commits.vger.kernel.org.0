Return-Path: <linux-tip-commits+bounces-7888-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E19FAD1114D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BD48305C079
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D5346E62;
	Mon, 12 Jan 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3+AgagKd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBJrmMnf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFC33BBD4;
	Mon, 12 Jan 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205015; cv=none; b=kapWttbcaRCt6IbrBif4k1D5r6OaKuy2UqrnE+ZphLA4IWz+BrVtiLgtchVSwwEm4LhleahOBgwQehTAG2Q0Lur+5c1A+GGHxFg364QD0QpLwhNECtSeGKMg7NnL5vRFdI+yyxfAjyBHfO83yRMlBzUr2+4qM520gC0GwUeie+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205015; c=relaxed/simple;
	bh=RPtHowQ5uaHRWkXoC8DCqwpGVdB5hyr3BmMj4c4uvaU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E5Q78u8kuNyoBUGgDz0qgZwMZyKYt2el661estRd1Zl8LiySHnYcvP0GhLyt5NhxJIg1E2G/e4LNy6eGFFHpgNIbIMDoNS71c0xM0YSaDL5AtWROVc9JyfNqWiAVRbQ6KH5nrXK77RzF0cfX4PmMCQ3TMjfe/IWefNiQUOkkLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3+AgagKd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBJrmMnf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768205007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tw+gxGbDfRPWM6lklq7eTDG1tUN8L/8Llb8gKR4rdYE=;
	b=3+AgagKdkX5E8/kmfihsMpOv0Rn6naAp77ulsTgghVm0l+KAALrIdM8WmIA8gz1vATPEDh
	+aq7ci/Z4alTvoq4uSeysLIkpOqV2b+UcTnftRHPqc7YTDDZSH6x7pxkwKOLghwFh9RzpT
	Sl1cZSaQyPNPcJWdWzJHZwPEV3Jd4arRWaLkLyWbinhsDqKgo5AFo3BmqYQjrHr0UiKavi
	iHuHs5gwYEHF49kdy3bvOgG+oInVOMf8WFACcYbuRjU/jwPCjCbCkoVYWVacy3Jz6NB2Ex
	pg+DrznwAbf/Ri0aM/4BSuuW4o3x/C/utShrNGqTQJhxokx9xpgwy8aLgkR0XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768205007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tw+gxGbDfRPWM6lklq7eTDG1tUN8L/8Llb8gKR4rdYE=;
	b=KBJrmMnfTl6ddAwfx83Tqmgg6Y/nWwHFJdSeXatOCPolr+z7MmhsrwqjPXK9q3PAPXcnR4
	F9XB5Njy4j1a7XBw==
From: "tip-bot2 for Yury Norov (NVIDIA)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use cpumask_weight_and() in
 sched_balance_find_dst_group()
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Fernand Sieber <sieberf@amazon.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251207034247.402926-1-yury.norov@gmail.com>
References: <20251207034247.402926-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820500577.510.10215655917802186780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     55b39b0cf183b9c682717a55a2fba06da69bba6b
Gitweb:        https://git.kernel.org/tip/55b39b0cf183b9c682717a55a2fba06da69=
bba6b
Author:        Yury Norov (NVIDIA) <yury.norov@gmail.com>
AuthorDate:    Sat, 06 Dec 2025 22:42:47 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Jan 2026 12:43:56 +01:00

sched/fair: Use cpumask_weight_and() in sched_balance_find_dst_group()

In the group_has_spare case, the function creates a temporary cpumask
to just calculate weight of (p->cpus_ptr & sched_group_span(local)).

We've got a dedicated helper for it.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Fernand Sieber <sieberf@amazon.com>
Link: https://patch.msgid.link/20251207034247.402926-1-yury.norov@gmail.com
---
 kernel/sched/fair.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 842a0f2..ebee20f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10974,10 +10974,9 @@ sched_balance_find_dst_group(struct sched_domain *sd=
, struct task_struct *p, int
 			 * take care of it.
 			 */
 			if (p->nr_cpus_allowed !=3D NR_CPUS) {
-				struct cpumask *cpus =3D this_cpu_cpumask_var_ptr(select_rq_mask);
-
-				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
-				imb_numa_nr =3D min(cpumask_weight(cpus), sd->imb_numa_nr);
+				unsigned int w =3D cpumask_weight_and(p->cpus_ptr,
+								sched_group_span(local));
+				imb_numa_nr =3D min(w, sd->imb_numa_nr);
 			}
=20
 			imbalance =3D abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);


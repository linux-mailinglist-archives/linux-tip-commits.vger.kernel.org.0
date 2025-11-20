Return-Path: <linux-tip-commits+bounces-7431-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B42C76102
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 20:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F1E94E1BF5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298B30214B;
	Thu, 20 Nov 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IuyxzKyz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OWaHP+un"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1242E6CC2;
	Thu, 20 Nov 2025 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666577; cv=none; b=O8LKueShTx7KI/ZftBGqSQKWGOXvqewDgfXWK91wvpgWeJkzO89YWxHtzYyX9inMqf+KiS8WjCEyAegO9XXgZr3FuB/KlpkPfbd2bIaS5ZEw6ap8J4l0GB6JhmCmCWUQeQI9qGcpDJCSGap8l2+rcMePvcrJE88upGiRMOWnX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666577; c=relaxed/simple;
	bh=WgUklgDRXheQ/Adz8KNp1rGqCz1tP/MmHzEcYPb0qKs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AjOMY4hafC4Z9bzcseEgcsUIr9bADjpMv4vV3topv30I8nMRHQ1rlqLVxCVZl9ASkUaU7vKntR0cSCqseYCbEwd4xA+j6KbH3VBpBy6qDrk0BcWFf76DiCdLuOEuNkU0j3aLsP9gPpsW4uyztCtYvizRx4/8QieaRd2ueZ9yJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IuyxzKyz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OWaHP+un; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 19:22:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763666574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/likFpUgi6UyS4UlipW9R5Vx15b5JUTj55qkgoUHDHI=;
	b=IuyxzKyz7uxJJChJ1kdB9GblHuUjxwTrF2SMBLw/Xv2l0gNmP9YMDo8apWME5/zH3O3zCv
	ZjuQR4W8roPbS51wBq9Y/ARsuUQLLzm1z6+7hNUdFIFnMQ4sFR6BRhUeIRRzXJAN4b6q1G
	J4bwWCPO1ZOWRdFQCru55JJP2q/vSSPvTj8HUjEovRcU3O//hgqmPYu86zl5qxtRFP/PfM
	uRVLYSp6Of7cmXYM3bFQSTqjZZ6ihxzAKjqwiaocfX8L2YM/Fx3ByGlct31jre9QvCqbbJ
	f4PBPU+CctYaxjsXds4wOFdtjciGxCyFhVdbGUVxQsSxm4O7wzNESpNeyKda3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763666574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/likFpUgi6UyS4UlipW9R5Vx15b5JUTj55qkgoUHDHI=;
	b=OWaHP+un/izdM6Hid0FeWlWb2M1Mq/FvdcJjR8yRfqYRXRexn8bzzaJPJx7giHRUMHH8Vi
	tl//L+tyM8Y8GiDg==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] sched/isolation: Force housekeeping if isolcpus
 and nohz_full don't leave any
Cc: Gabriele Monaco <gmonaco@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251120145653.296659-6-gmonaco@redhat.com>
References: <20251120145653.296659-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176366657323.498.43337298021579327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     185bccc79797d71477e672a1b2a2b7d0325044e7
Gitweb:        https://git.kernel.org/tip/185bccc79797d71477e672a1b2a2b7d0325=
044e7
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Thu, 20 Nov 2025 15:56:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 20:17:31 +01:00

sched/isolation: Force housekeeping if isolcpus and nohz_full don't leave any

Currently the user can set up isolcpus and nohz_full in such a way that
leaves no housekeeping CPU (i.e. no CPU that is neither domain isolated
nor nohz full). This can be a problem for other subsystems (e.g. the
timer wheel imgration).

Prevent this configuration by invalidating the last setting in case the
union of isolcpus (domain) and nohz_full covers all CPUs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://patch.msgid.link/20251120145653.296659-6-gmonaco@redhat.com
---
 kernel/sched/isolation.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a4cf17b..3ad0d6d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -167,6 +167,29 @@ static int __init housekeeping_setup(char *str, unsigned=
 long flags)
 			}
 		}
=20
+		/*
+		 * Check the combination of nohz_full and isolcpus=3Ddomain,
+		 * necessary to avoid problems with the timer migration
+		 * hierarchy. managed_irq is ignored by this check since it
+		 * isn't considered in the timer migration logic.
+		 */
+		iter_flags =3D housekeeping.flags & (HK_FLAG_KERNEL_NOISE | HK_FLAG_DOMAIN=
);
+		type =3D find_first_bit(&iter_flags, HK_TYPE_MAX);
+		/*
+		 * Pass the check if none of these flags were previously set or
+		 * are not in the current selection.
+		 */
+		iter_flags =3D flags & (HK_FLAG_KERNEL_NOISE | HK_FLAG_DOMAIN);
+		first_cpu =3D (type =3D=3D HK_TYPE_MAX || !iter_flags) ? 0 :
+			    cpumask_first_and_and(cpu_present_mask,
+				    housekeeping_staging, housekeeping.cpumasks[type]);
+		if (first_cpu >=3D min(nr_cpu_ids, setup_max_cpus)) {
+			pr_warn("Housekeeping: must include one present CPU "
+				"neither in nohz_full=3D nor in isolcpus=3Ddomain, "
+				"ignoring setting %s\n", str);
+			goto free_housekeeping_staging;
+		}
+
 		iter_flags =3D flags & ~housekeeping.flags;
=20
 		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)


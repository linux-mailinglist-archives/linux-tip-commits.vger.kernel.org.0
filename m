Return-Path: <linux-tip-commits+bounces-7477-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD3C7E60B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Nov 2025 20:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 737734E2D71
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Nov 2025 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961C20B7E1;
	Sun, 23 Nov 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nCnAUg4A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fTOouyoh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD63596B;
	Sun, 23 Nov 2025 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924641; cv=none; b=a5pGRLfJ1uWK0OCeSEm7Tz1m4WWIKjamZX81UrEpVIIZhXypUW2i/7TYkLiAO74c0VS+ZOlrvSC16fyNP4km+4tgefrnik5dBhD6s3Ezzg+p+IC7aL6FsWqtXxav7FNP1E1rjzlslyNzvuNNQn8ssu6/nXT+G58bbApCbqPp250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924641; c=relaxed/simple;
	bh=hWYa8jt/xpaXEzfKzBhEQWOw+hqZNgCMf6/u+06fe2E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hHhrCD6b+Gu0wg877CIzUomwC9Fmq8pvMmbXA8JfU0Wbh15Guo7tDuvxddPOr3AlePyW+uMSsQhIYzKL/ryCJfAj2Nlg+QW4X1ARyXru/nZPT+7n3ogLf6QwXmQeNK/qKr69MPb42xfWH3TWJw6/Mp1SE9u/du12iT2VECMWDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nCnAUg4A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fTOouyoh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Nov 2025 19:03:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763924638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feAABFbubzSkXafQABL+C7R0i2X8D9GTnG+4kHkDD74=;
	b=nCnAUg4AxGvgWLBNuP3hEL9SH5VwwUyhf1+7ydbk1svPNI9RPxslKQvdUm4UVTHcvAiEJt
	r5jNB73Pc4r6kG5JHnY7bxZsAZ2t+BuZPa7Nl4G7+KhiLism53BvedOFMpEGug1wPKOvGP
	91nVWCOQGySgmP3MGHuMOgC2GXF7t30Y08btRZwNqgl8kWNq50piYpzJyz8KnRtT/I1Z6x
	wTiikyh21cl1OICJdmc44J46naitXJbKpYa/kp44tFIHGkWuZLiycK2udJbbEdESN1V/Wn
	G6kjrwBqyHe7MUDXd/feKgUCA3yYG2q8mi05HV13YN8Vaz8jZUR+dR2Z+DsgRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763924638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feAABFbubzSkXafQABL+C7R0i2X8D9GTnG+4kHkDD74=;
	b=fTOouyohwWPempqdSAdMxfHdbCzlVwtsPUbQgVJc8/a+W0T4/LaD15nRb/LqnFF16taFLw
	hLjIS5rluE+MdbCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Ensure that per CPU threshold is > 0
Cc: Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <873466jekm.ffs@tglx>
References: <873466jekm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176392463742.498.9762634691842916515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     14b2b17cca541bf46341beb912cf4420ff27a0c7
Gitweb:        https://git.kernel.org/tip/14b2b17cca541bf46341beb912cf4420ff2=
7a0c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 22 Nov 2025 15:54:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Nov 2025 19:59:30 +01:00

sched/mmcid: Ensure that per CPU threshold is > 0

When num_possible_cpus() =3D=3D 1 then the calculation for the threshold to
switch back from per CPU mode to per task mode results in 0, which
indicates that the per CPU mode is disabled.

Ensure that the threshold is > 0 to prevent that.

Fixes: 340af997d25d ("sched/mmcid: Provide CID ownership mode fixup functions=
")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/873466jekm.ffs@tglx
Closes: https://lore.kernel.org/all/20251122004358.GB2682494@ax162
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5821968..58b4dbe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10364,7 +10364,8 @@ static inline unsigned int mm_cid_calc_pcpu_thrs(stru=
ct mm_mm_cid *mc)
 	unsigned int opt_cids;
=20
 	opt_cids =3D min(mc->nr_cpus_allowed, mc->users);
-	return min(opt_cids - opt_cids / 4, num_possible_cpus() / 2);
+	/* Has to be at least 1 because 0 indicates PCPU mode off */
+	return max(min(opt_cids - opt_cids / 4, num_possible_cpus() / 2), 1);
 }
=20
 static bool mm_update_max_cids(struct mm_struct *mm)


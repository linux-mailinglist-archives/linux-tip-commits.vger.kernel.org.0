Return-Path: <linux-tip-commits+bounces-6230-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC292B18EA3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 15:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4C07AFD37
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34C41FF1C9;
	Sat,  2 Aug 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pW7akEpl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u2c2J0Am"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E3DF59;
	Sat,  2 Aug 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754140935; cv=none; b=e/kaVfsXx3gZCUUQxjbsFFFyKyw/STu55ZmuBb3nRlLpUHsXJyreVnfcjetReBsBAD6S4a67fHy3ZJvjecW9Vjvq+9OiwI/rS1UmOI8u8e46gi+0afd30snivLOHr1pQc2AM5556eLLENvAA+bG41z3KBpy1JcrOm5r6nV+CJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754140935; c=relaxed/simple;
	bh=hz/0gjecOptrI9UvUPaN9LhyE9IZyca85DU4M7ciD6I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tvu9Yw30vXVtdyWpJqFNmUpYAfYFg3bHa8bG4iA8sROCc5xWrqqTVJ9NZPNetTTZYbTg/IE3VK0kAvJQWTwtV8oEWNQJ9bEAVe+f1T3yr2qV3vbNvNdyOEKeJAcABCXzjrchrDBQNHKANwm9xPGuXfTD2aaRQNwlrGL8KUdLoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pW7akEpl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u2c2J0Am; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Aug 2025 13:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754140932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4D/4kLLTiRXkitxTv/Ie/vFzdnhCnVgUx5k18OMot0=;
	b=pW7akEpl+eM+MEPVXndohY6KHHxK6mb2KH7dJgSt7iyDGJf6zowaPx14b+rT+uoBPeeal6
	0Qd7nr5ETtqnbw7j5I9qJm/SL+BedFnrouN2Vq6PyTxE+h8eETAEeDgbHGFRh2ZahJiF5e
	VbbXBH1PFu//LVjfktOvFUI4K6f826KEKsqnWHGXfZwpE1Z18b2m5iHDVTpSM3HyNms09A
	daZHuhaZzBasYo6xDjUDhA0WHmD442c6hHbXONOJdb2AqEVSftQAMr2yDcCI0OiJzlLvG+
	XQs8LAnpVlzr8vi7V6AxROwBOo4LbHxxTVoRSHhWf6L+uW3OrsqLW0/o5wheSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754140932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4D/4kLLTiRXkitxTv/Ie/vFzdnhCnVgUx5k18OMot0=;
	b=u2c2J0Amvk1qf4weGZkysQ++6LCjUF2oEwS6ohIhLKEYc/0pDE0bcadQ3LepQn4cg/CSCw
	s+Su6wKYj4EqrWAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Move futex cleanup to __mmdrop()
Cc: andre.draszik@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87ldo5ihu0.ffs@tglx>
References: <87ldo5ihu0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175414093081.1420.8088049602488588887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     e703b7e247503b8bf87b62c02a4392749b09eca8
Gitweb:        https://git.kernel.org/tip/e703b7e247503b8bf87b62c02a4392749b0=
9eca8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 30 Jul 2025 21:44:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Aug 2025 15:11:52 +02:00

futex: Move futex cleanup to __mmdrop()

Futex hash allocations are done in mm_init() and the cleanup happens in
__mmput(). That works most of the time, but there are mm instances which
are instantiated via mm_alloc() and freed via mmdrop(), which causes the
futex hash to be leaked.

Move the cleanup to __mmdrop().

Fixes: 56180dd20c19 ("futex: Use RCU-based per-CPU reference counting instead=
 of rcuref_t")
Reported-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
Link: https://lore.kernel.org/all/87ldo5ihu0.ffs@tglx
Closes: https://lore.kernel.org/all/0c8cc83bb73abf080faf584f319008b67d0931db.=
camel@linaro.org

---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f82b77e..1b0535e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -686,6 +686,7 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+	futex_hash_free(mm);
=20
 	free_mm(mm);
 }
@@ -1133,7 +1134,6 @@ static inline void __mmput(struct mm_struct *mm)
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	lru_gen_del_mm(mm);
-	futex_hash_free(mm);
 	mmdrop(mm);
 }
=20


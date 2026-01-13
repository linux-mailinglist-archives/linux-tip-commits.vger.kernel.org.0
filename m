Return-Path: <linux-tip-commits+bounces-7963-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B99D1A8B5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 18:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31141300519C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901B3502AA;
	Tue, 13 Jan 2026 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4sH9pEO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ng7JP81q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F25343D78;
	Tue, 13 Jan 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324518; cv=none; b=dtqpKPNoTQP5uZHqYDYYqYraW8U6I0Q/y1vywaw9YPCgCx87shAzp/60h4TNiD584hY06zqsSxgHYj/dsa89uYKvJ0MSfKv9yiDVOsbSKTqVE9VcJ++lMrlc6UDIA+8A6uIhbCIpGqgo7nm6xfe68oVjPcyxb9JnCi8NIeivsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324518; c=relaxed/simple;
	bh=X9Vkm+KKJeEOReWS8Q2qWyoQhCELABbt8xk8J4BL+dQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sNTLqc7us4YH6PwC8tEDFJe2WTMhd8Q8EqYRAICkB2movWiKSMvwW40ln7rPz3fnJavqYzZ0UEX2xUcIoHS47Sv7V/5ug4U9ycUiV+XCS2bSwbr7XGD8w4Jb3JlHOjM+oIZNkZUDqXpo7zXElDB9IkoWXS1fhJWYv6HpBSkbc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4sH9pEO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ng7JP81q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 17:15:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768324515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AigVotkEkPYjJSobhzYoJ2YgYKCLIiwgYsUN74OG2sg=;
	b=Y4sH9pEOCGCvc3515vX4a3D31BwakrwOPE9qzxxdsRjrK4v+eGYhDCo8OgsLgq2jMgNtdD
	GgndmohRtfpKihK/rek/ztQw2N6h3YXXkorvXHENXGzSwW1CMzNoBMtRDBmTMOqe0/d0NZ
	GEq7XipV86eP6AvbTNMrzwShUADEew5nk67mXP4vkO6+iLBOalC27qAKiENUmpR15mYjyF
	TF8XcKCSR6GpJVGp6BT5EgXr16UJGXqt90Vxe4FwTlWazIDP2Jro/bumypcQHmsFs/p7/9
	6vtLRzIkt9YsYzhDfnkQwADLv9u9JFd/3jd5MMYN5yTR7dMXvuHyZi40ymjy/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768324515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AigVotkEkPYjJSobhzYoJ2YgYKCLIiwgYsUN74OG2sg=;
	b=ng7JP81qFXNMLiBCZaP2A9IBdamcfcpf5w5pth7nykvn8tR1a/QYZg9JF6nnNj3RhULxCc
	olG6Qhj1+UNiMnCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/sched_clock: Use ACCESS_PRIVATE() to evaluate
 hrtimer::function
Cc: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <875x95jw7q.ffs@tglx>
References: <875x95jw7q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176832451368.510.9081222014514031930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3db5306b0bd562ac0fe7eddad26c60ebb6f5fdd4
Gitweb:        https://git.kernel.org/tip/3db5306b0bd562ac0fe7eddad26c60ebb6f=
5fdd4
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 13 Jan 2026 17:47:37 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 18:08:57 +01:00

time/sched_clock: Use ACCESS_PRIVATE() to evaluate hrtimer::function

This dereference of sched_clock_timer::function was missed when the
hrtimer callback function pointer was marked private.

Fixes: 04257da0c99c ("hrtimers: Make callback function pointer private")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/875x95jw7q.ffs@tglx
Closes: https://lore.kernel.org/oe-kbuild-all/202601131713.KsxhXQ0M-lkp@intel=
.com/
---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index f391118..f3aaef6 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -215,7 +215,7 @@ void sched_clock_register(u64 (*read)(void), int bits, un=
signed long rate)
=20
 	update_clock_read_data(&rd);
=20
-	if (sched_clock_timer.function !=3D NULL) {
+	if (ACCESS_PRIVATE(&sched_clock_timer, function) !=3D NULL) {
 		/* update timeout for clock wrap */
 		hrtimer_start(&sched_clock_timer, cd.wrap_kt,
 			      HRTIMER_MODE_REL_HARD);


Return-Path: <linux-tip-commits+bounces-2811-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A059BFC1B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87330B22E8C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20318E75A;
	Thu,  7 Nov 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CXP8xx7d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmXCzfxB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86F17A5BD;
	Thu,  7 Nov 2024 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944784; cv=none; b=FPjR2DtOeSBMyENxFB4kmngRsM8C8wE/QDAYSRW7Rctf8owtdEiAZk8JLozyyW60koxAvQ4R/8TP5uZShzWD8kHCC176OGBIfkVpEkrAOuGKokxFGJ5Y5yHXtiBmP0+9bvc/s3igyXVED63GNJO/vYBW8kbAI0TfExPisVzgkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944784; c=relaxed/simple;
	bh=9Bc4kwXB6l/2BVUkRSH/84UnfuQbAjOTCRzpwGvnGS4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=erMqTdZLcKPgMseGObynRAzMwMmh1JHZS08FdsuTE1f6cxlrdGaZEIIFdAzcN7JlS2LmdrjbLXjtCMbfxcLH+DttNJtrEfmQTFsKdxUh8kUyGuH2S5di/QuLBaPFcjD3DgalXQ9Lg3Ypx9sfBk9dkptMsNzCWaxC2wuBwNH/1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CXP8xx7d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dmXCzfxB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944781;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vw+xwXuIMOyqsyCuVZgLdp+VkkZ2v8+dt2OczknkE8=;
	b=CXP8xx7dDaJ5CF4A9ZZP6yrdDUPoKQ7ln+g5LYI7/zdRmq4fpnKgX3Tlf5X6w7WJc3O8m0
	KKNHe74+2imTjHJzs0iWy3YmUBmfJ0u89rXA91zcOCrHqvdSDEqgdNiwPSEYmsy0LpiKlw
	RSg4cUe+JMPiusVNIuJU96paPQGqFYCQXs1sFyfS3VaDMnpYKc03Mxllg+jN1lrtqJZJkE
	aooOhNXN74Hgvq1OgjOBWdfyr+a1PzJME7g4KEC0o+RAsnctTqha67lrXIbeUfOHUTX5Ac
	ijfTkFwOmRMDzOtEfEFexptJVieaOoiUO4V9O6sn/Afz/HYoacV/EtXZaKy8lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944781;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vw+xwXuIMOyqsyCuVZgLdp+VkkZ2v8+dt2OczknkE8=;
	b=dmXCzfxBImJZR5HacHcOHeF0bTZdBZ+farXntPW1RvOjGFlsXVBpqn1bwenhpFkbrlvTmh
	me9P7OXgnZd23GAg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] futex: Switch to use hrtimer_setup_sleeper_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd92116a17313dee283ebc959869bea80fbf94cdb=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd92116a17313dee283ebc959869bea80fbf94cdb=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478056.32228.13253435373091294271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9788c1f0ff120476f58ad53e18098af8249d7e36
Gitweb:        https://git.kernel.org/tip/9788c1f0ff120476f58ad53e18098af8249d7e36
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:06 +01:00

futex: Switch to use hrtimer_setup_sleeper_on_stack()

hrtimer_setup_sleeper_on_stack() replaces hrtimer_init_sleeper_on_stack()
to keep the naming convention consistent.

Convert the usage site over to it. The conversion was done with Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d92116a17313dee283ebc959869bea80fbf94cdb.1730386209.git.namcao@linutronix.de

---
 kernel/futex/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768a..fb7214c 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -140,9 +140,9 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 	if (!time)
 		return NULL;
 
-	hrtimer_init_sleeper_on_stack(timeout, (flags & FLAGS_CLOCKRT) ?
-				      CLOCK_REALTIME : CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(timeout,
+				       (flags & FLAGS_CLOCKRT) ? CLOCK_REALTIME : CLOCK_MONOTONIC,
+				       HRTIMER_MODE_ABS);
 	/*
 	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
 	 * effectively the same as calling hrtimer_set_expires().


Return-Path: <linux-tip-commits+bounces-2677-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D97D9B791C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71B3281A6E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF36199E93;
	Thu, 31 Oct 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mLHGFsMZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oorA59oK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EF13A25F;
	Thu, 31 Oct 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372076; cv=none; b=sC1rLUD3hy6Q5sJOm6umrvBWFM0s9JGd1dNUuxw1EBXkc8pnLL6ipgok8sgUHJYKnx9RGS6+VIn0OST0go9Ru1Wa3ca5pl9ylVR/STTWQQaK0yTNcShBYOAIxu8z2XX3gDufhtUSRKTgIt3JvVxIuJnqkRyLdLQCnjVSsqKAks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372076; c=relaxed/simple;
	bh=5WZdky7rPuKlew/RcJrq8DjI0BblXDblhtDQuTj8awU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tlBNeROPzsC77M+e1CY0AoG94nFTNoJV/g0gEHvSVRJ/lcVNgBrGPeL8vXMkk5KNaFosqUnDLLyzcn4dtjcK36W44DifPw/oQnenCTctrwCLmqAR4mGAzIIVuY5NGrY5M9nyvqr9fEz+VZdFkB0fR2Ptuyvo2wFMMHuNx0cx6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mLHGFsMZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oorA59oK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 10:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730372073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4eopBclYZr+iwXymxEXnas8YQzfxQYie3/fuRR0vNE=;
	b=mLHGFsMZqrdQXl/J9JxwC+BCpeE1zmqlvSmBkGKZ2ZTVF45/4HDzFF0hi0jsMkbyAbt/g8
	fRpbAIKjRMMIfazkMj1H5gxJ2P/6alxXCsw99IeGVRSNNsf055Zf6j+dH2Foy2DbRYeTRB
	B8u2UyN+d4h0y8ezTv8Xc3LsqhNjZoNWeM6DYEpPnjDD+Xdr+gG3HJi6qOzzcRVBLpg7Hd
	meA8oogaCoUKWdW/HXoVPdcqOm80ZjDlwwoyWnwGOmz+x7NBNbx/orzP6BWdzajw7fIJt3
	q8HHwunLTjmET+TeyDnAuU55lNy2r0rodKY9AUAn6kBolneZEf/GikpEMRd5VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730372073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4eopBclYZr+iwXymxEXnas8YQzfxQYie3/fuRR0vNE=;
	b=oorA59oKzoFRLQ/6R0Pb+Q105JnnRNj49tnWrna0lhimOy+mvKRFEKU3xS8OBpYa0zqobt
	EB4Hps9brV3LflDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Add missing READ_ONCE() in __run_timer_base()
Cc: kernel test robot <oliver.sang@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87a5emyqk0.ffs@tglx>
References: <87a5emyqk0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173037207205.3137.14718526161744864721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1d4199cbbe95efaba51304cfd844bd0ccd224e61
Gitweb:        https://git.kernel.org/tip/1d4199cbbe95efaba51304cfd844bd0ccd224e61
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 30 Oct 2024 08:53:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 11:45:01 +01:00

timers: Add missing READ_ONCE() in __run_timer_base()

__run_timer_base() checks base::next_expiry without holding
base::lock. That can race with a remote CPU updating next_expiry under the
lock. This is an intentional and harmless data race, but lacks a
READ_ONCE(), so KCSAN complains about this.

Add the missing READ_ONCE(). All other places are covered already.

Fixes: 79f8b28e85f8 ("timers: Annotate possible non critical data race of next_expiry")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/87a5emyqk0.ffs@tglx
Closes: https://lore.kernel.org/oe-lkp/202410301205.ef8e9743-lkp@intel.com
---
 kernel/time/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 02355b2..a283e52 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2421,7 +2421,8 @@ static inline void __run_timers(struct timer_base *base)
 
 static void __run_timer_base(struct timer_base *base)
 {
-	if (time_before(jiffies, base->next_expiry))
+	/* Can race against a remote CPU updating next_expiry under the lock */
+	if (time_before(jiffies, READ_ONCE(base->next_expiry)))
 		return;
 
 	timer_base_lock_expiry(base);


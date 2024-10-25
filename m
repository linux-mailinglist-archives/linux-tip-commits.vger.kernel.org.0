Return-Path: <linux-tip-commits+bounces-2599-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9DA9B0C94
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A429CB2594B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051321766E;
	Fri, 25 Oct 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S76J1S40";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MnGlcpea"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD5217451;
	Fri, 25 Oct 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879293; cv=none; b=hjge1twNgfOrYawLFDhNFegKuO+q1ljbuYPPWa+NBx7gQ2uzBhdVjc3S/8JGmRKirodJczKLMIEk0eLEwn9+JKjCLCCCcraZG4ZMuK5VRTTjpNzYVeiJnzV3auB3eQacCtvK2jZ/lWRh9EWSnzO5YU0PvpUqjauIXZ9ovOorrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879293; c=relaxed/simple;
	bh=cF6oJbhSBcLD52N2CfL9nQ4ToQr/GmZ8ZN1vTBneVHg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZUkaMW5WtNwrbWyL2YNGuuvx5RopTn2aj+b0SNB/9JQjV6PzpBEyKkj8YMgf+YzM+8E8FhG5BuswwbA/P7a+0xz0ZYmnqdIPDJ4mAACPrjwwFveLLcU9G9zxtiN1ZCllUrZ09ye5CcH1VIKbV29JV/0KZNeEbc3KHTxxF1T0pUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S76J1S40; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MnGlcpea; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQosbcjHC2UBrM1D+MrMpWZiYa8vuXgbySr84Q0Ilpo=;
	b=S76J1S407CuOggJSGvGnAQF7YDnC8O/UL6OSJDMN+zdIjCYOG3M1g5KZ8qytIhJg0S/3u1
	lh3C7fBKHOZsKeTJXaoMHzga+0sNr+tfYinj+13cTk4zEzn3pVRYDcZele6kCf49EYphcG
	tz/IEQuP5OqkvjlG2dO6/ug38A9vQbeek+YGcpL+cho1excjlwKTiaOROo47caDHcJVGgi
	dI+aCVA/tz0tlZ1aldxUK8NO915egMdIoK5QoVITXP2YDDox8wj2VWphYOsESKZq6thHWv
	7nfnpPvyFx/aftCOOEEIt24/ClOHQvMwBKig5buIuo00/REQrx84TZihhB7rOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQosbcjHC2UBrM1D+MrMpWZiYa8vuXgbySr84Q0Ilpo=;
	b=MnGlcpea0zP6R5+BjTt7BD5MPGhLEJjzCtKogI03GQHUZ98MYeW3BROL+Z0t7k2MMo68Hf
	SaUs1couR3AlqkAw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Avoid duplicate leap state update
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-3-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-3-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928913.1442.6254070184964233404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9fe7d9a984f2309ceb9f53bc89eb4885994e5052
Gitweb:        https://git.kernel.org/tip/9fe7d9a984f2309ceb9f53bc89eb4885994e5052
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:28:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:13 +02:00

timekeeping: Avoid duplicate leap state update

do_adjtimex() invokes tk_update_leap_state() unconditionally even when a
previous invocation of timekeeping_update() already did that update.

Put it into the else path which is invoked when timekeeping_update() is not
called.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-3-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ff98a0b..14aaa44 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2715,8 +2715,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 		__timekeeping_set_tai_offset(tk, tai);
 		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 		clock_set = true;
+	} else {
+		tk_update_leap_state(tk);
 	}
-	tk_update_leap_state(tk);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);


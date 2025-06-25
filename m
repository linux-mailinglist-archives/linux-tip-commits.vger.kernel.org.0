Return-Path: <linux-tip-commits+bounces-5904-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2171AE897D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9625189DB1A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912502D6604;
	Wed, 25 Jun 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wpk6nRHL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xHWDeuIE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A982D540A;
	Wed, 25 Jun 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868164; cv=none; b=E0IZi6jR9qyzG53y0CbpQ9i6rtFLYYMqiXrzARKZyv6jnaVJ3IvpQAQG0WQpNniL/FRAKA+JCDexjTxo50ZDKw9M3VR11SvLhB2gyU7u5Sav2bRoWAd0POHWzzJHejfHmJyDz6C3eC9v4Qj5fKzpkSnh/JsvOxe5OQraOeVmwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868164; c=relaxed/simple;
	bh=dmnDPscXSqIYVCtwzMDAnFHcnqA03RpvR3l57gGpvIA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RjF5Y2e4GD/NyLDZbWh8Zb+HYyWJV4/ThETLogOKrvb45ShT7YcIMc0xEyOTSdtI4PUe1DAFxxaHmYXbmlCWws9E33JcOoplhfk235NPerebRd4gj9fLLHhDoqfyyUoRqxb9HmT5wJ5oYJz/aO6sFah6o3Y+ID2SHTAWJu3KihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wpk6nRHL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xHWDeuIE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sei0PpJtslruRFvRz5lzJXLhDJCvSjJfhYgfzthq1MQ=;
	b=wpk6nRHLC8D0F1zEbxC740q/NDSMchms3Cm+a3uAfw8YLmP6ZiPfvIfyuOHryv3eww8oQx
	7ERblG/KvW4thLEPl9aMszu63kaW01ijPGVa80L42Yx8Ul4zlCQmqKFSSuOzKQJuzLQ3h4
	xGKoJfJbjXn8QW7Hdi1dNLu1psj7nNNrvrCmQykI1tDhhDXA1s1vVDHATNSmNLwrO2H5/n
	6r6cPontmr6a+PIRd4LHxgeSQnNs5JxrbZTAHBS7bLM3ZThUes8KTSRzkrI3orNmVbPXED
	oaQ3VbJIkFavR5Ksi0gKx/1qvWIxSrzGfkpGfX05GVRF44QFo779pzWV5LlfgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sei0PpJtslruRFvRz5lzJXLhDJCvSjJfhYgfzthq1MQ=;
	b=xHWDeuIECTtBv1bw48T7aHyMmZjbCHFoICedhTA3cIdV3GoOnMw8nvLBU5pnCSStg2AiZi
	bSCVJlFeoWwH5zAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Prepare timekeeping_update_from_shadow()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250519083026.223876435@linutronix.de>
References: <20250519083026.223876435@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816034.406.14610672224050144956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     8c782acd3f47e21f9b03fd3720172d1f8e4fb796
Gitweb:        https://git.kernel.org/tip/8c782acd3f47e21f9b03fd3720172d1f8e4fb796
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:23 +02:00

timekeeping: Prepare timekeeping_update_from_shadow()

Don't invoke the VDSO and paravirt updates when utilized for auxiliary
clocks. This is a temporary workaround until the VDSO and paravirt
interfaces have been worked out.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250519083026.223876435@linutronix.de


---
 kernel/time/timekeeping.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 153f760..e3c1a1c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -683,13 +683,15 @@ static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int act
 
 	tk_update_leap_state(tk);
 	tk_update_ktime_data(tk);
+	tk->tkr_mono.base_real = tk->tkr_mono.base + tk->offs_real;
 
-	update_vsyscall(tk);
-	update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
+	if (tk->id == TIMEKEEPER_CORE) {
+		update_vsyscall(tk);
+		update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
 
-	tk->tkr_mono.base_real = tk->tkr_mono.base + tk->offs_real;
-	update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
-	update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+		update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
+		update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+	}
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;


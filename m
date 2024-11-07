Return-Path: <linux-tip-commits+bounces-2813-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 833CE9BFC20
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BEC2B229B5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6DA192B62;
	Thu,  7 Nov 2024 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/+Ns31L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2qvDrc27"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395B18D65A;
	Thu,  7 Nov 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944785; cv=none; b=Y0fgkH/W8REvReg8mGIBJqfaXyJyWD1BGLA26DBjWQAyXzNMD49NWN77H1iYf81IhzYX7472PASc12xLG21ySg3nUvN5TeY4eP8nQCuLZnHGWK9q/8mMQX+Qqo7BzjDyYveirXRzEjDIo93RS22MffvtoQdGuJroYiHD5DPznJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944785; c=relaxed/simple;
	bh=wvv1tsk3HtU+kUy+O7h78APwBSBvavsk4OlbhdtJJ1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oowZ65pGXD3JQM1iSv/gV/nirK414g7BzoeadD2ysBtu59+zxYaimi3T1wfoiyj9ldG3Ln/Z04kqhlBPjgYpF4+6mUwsIdDtw7RLi2UGMfYhbwBQS09+8LeW/nWTFb+IZLyta7MeMo25iCez1I1h45VNWNpYSUs8pMt8M85xOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E/+Ns31L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2qvDrc27; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6IInVYJhwTVeR3UEv+C5mOgnyk2NfO6X3Yirn0Nn90=;
	b=E/+Ns31LYSVf4MYlqEvHhaO2+n9fFT05AKx6ZrvHqwLRtdMG/LfaD6bS6dzZjKWp+tvf0F
	reetiwSCmufNKiVShThyvkXGZwS4CbvlaVoJiTtSgWXHJg8sWu52S1DVowpNfUo02p5sNc
	u+UOMjXbKVi+0lPYRpUweWmBdvfhj5GrsHJ08EogfvjxJdAEh6Ds+MMl5ImSh2oePg7idO
	LYv0GF7sMAwt6hlXFP7vX0dDxzUlIBdROQT6vgDV2UiR+TKZOkEfjnavst1Jjo03hFrl4I
	LqxmCf4ftGU1oVWVPRURofbIyt8S62rqLe25b452htp+OEW5m79bvGLct6KgAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6IInVYJhwTVeR3UEv+C5mOgnyk2NfO6X3Yirn0Nn90=;
	b=2qvDrc27eqAHQ8yVrlD/SgDPFMW5F5JR49CqvuDVm5LE01TPutUwDa7TwAz6s2cnUwExyM
	09ul0dMhx+Hs9cCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Introduce hrtimer_update_function()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20a937b0ae09ad54b5b6d86eabead7c570f1b72e=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20a937b0ae09ad54b5b6d86eabead7c570f1b72e=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478200.32228.6992950404693357404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8f02e3563bb5824eb01c94f2c75f1dcee2d05625
Gitweb:        https://git.kernel.org/tip/8f02e3563bb5824eb01c94f2c75f1dcee2d05625
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:05 +01:00

hrtimers: Introduce hrtimer_update_function()

Some users of hrtimer need to change the callback function after the
initial setup. They write to hrtimer::function directly.

That's not safe under all circumstances as the write is lockless and a
concurrent timer expiry might end up using the wrong function pointer.

Introduce hrtimer_update_function(), which also performs runtime checks
whether it is safe to modify the callback.

This allows to make hrtimer::function private once all users are converted.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20a937b0ae09ad54b5b6d86eabead7c570f1b72e.1730386209.git.namcao@linutronix.de

---
 include/linux/hrtimer.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 48872a2..6e02673 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -327,6 +327,28 @@ static inline int hrtimer_callback_running(struct hrtimer *timer)
 	return timer->base->running == timer;
 }
 
+/**
+ * hrtimer_update_function - Update the timer's callback function
+ * @timer:	Timer to update
+ * @function:	New callback function
+ *
+ * Only safe to call if the timer is not enqueued. Can be called in the callback function if the
+ * timer is not enqueued at the same time (see the comments above HRTIMER_STATE_ENQUEUED).
+ */
+static inline void hrtimer_update_function(struct hrtimer *timer,
+					   enum hrtimer_restart (*function)(struct hrtimer *))
+{
+	guard(raw_spinlock_irqsave)(&timer->base->cpu_base->lock);
+
+	if (WARN_ON_ONCE(hrtimer_is_queued(timer)))
+		return;
+
+	if (WARN_ON_ONCE(!function))
+		return;
+
+	timer->function = function;
+}
+
 /* Forward a hrtimer so it expires after now: */
 extern u64
 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);


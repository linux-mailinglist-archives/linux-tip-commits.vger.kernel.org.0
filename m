Return-Path: <linux-tip-commits+bounces-2559-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81C9B0665
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA631C2261A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A5D20BB3E;
	Fri, 25 Oct 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pGNv7VxY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4x8uniF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C01465A0;
	Fri, 25 Oct 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868036; cv=none; b=F49UayhAKocdZR9ouZI9deHmLm/lKuvAsx8RrcD10Y5iPcFjJWc3vEmEIBonOW5pQE3BM3AsaVi0L9+YOrze+XQ+FAtaMNQYKgMp70P975IPHoUKQJamgkENZHDfaZOQn/BdlL2bPdDCwJLy6NKpyBrIwz7RjFmubyiEknYInW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868036; c=relaxed/simple;
	bh=yCWGo4HDuHZDbQkxatiVrMCYRpY4l2ltImj+0kSOPFI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MoWXNq2OOVUUtiTG6Kw1SlduquBgJqFX6PQRU4QVxEcttjLlEybGm27O+48xdOq3S4Fvq50Sk1BFn92x1+22JdkjZ2SrapVw2PQcUeieTftMF7iTcXVkZGRUTTxr1kWFGOEwfxYC+EpmMizLKCCU0RpEGGO6GCLPGyeyIfY2N7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pGNv7VxY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4x8uniF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2uafFYgGfl2+gboUma5/yvSC2D4G8NDVUTfOmoKUf8=;
	b=pGNv7VxYlPJksomeaH4hqMv3oKJTJouwLFzDNkThi9eZhuQCu80yqp7/EV2036baAWG4w5
	PGjbwYQn7rGoPEtKTB8WSzkNv5m6cfzBe0FS7fJPpxITRlL91X3/3XO2ujlWcGPxkPCUtr
	9fWfOAgt7ILFKq4pCJDkRUmm0KN0Dw3s+zkn3a/TsaOE0acDa2f8+bcE0nbP6e4r90Y6Rq
	GTjENhfs0ZKUwb+XI0GqDZWWJ10TX+ih9Gx8w1dy4+IAuLJ6+0XWe87yYRFRP1g7LkJNiX
	eebTDz1tSvQc7aXKPz2qPfQ08RUPe4olxKt3nlXnildLp4mhLrFil3e4sHlr1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2uafFYgGfl2+gboUma5/yvSC2D4G8NDVUTfOmoKUf8=;
	b=U4x8uniF5rof16YcagIZPb9N6FGBBnVa7fze0tfOJJRn+ZNRgyGk+xBDu3B1tAXiQ7/QiQ
	F3oeCzeHH0Ha8MBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Provide timekeeping_restore_shadow()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-15-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-15-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986803133.1442.13788252589194407885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     571b39c71a4c23b86e0407684cb6c79f899678bc
Gitweb:        https://git.kernel.org/tip/571b39c71a4c23b86e0407684cb6c79f899678bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:12 +02:00

timekeeping: Provide timekeeping_restore_shadow()

From: Thomas Gleixner <tglx@linutronix.de>

Functions which operate on the real timekeeper, e.g. do_settimeofday(),
have error conditions. If they are hit a full timekeeping update is still
required because the already committed operations modified the timekeeper.

When switching these functions to operate on the shadow timekeeper then the
full update can be avoided in the error case, but the modified shadow
timekeeper has to be restored.

Provide a helper function for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-15-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c30b187..ed0e328 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -774,6 +774,15 @@ static inline void tk_update_ktime_data(struct timekeeper *tk)
 	tk->tkr_raw.base = ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
 
+/*
+ * Restore the shadow timekeeper from the real timekeeper.
+ */
+static void timekeeping_restore_shadow(struct tk_data *tkd)
+{
+	lockdep_assert_held(&tkd->lock);
+	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
+}
+
 static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsigned int action)
 {
 	lockdep_assert_held(&tkd->lock);
@@ -801,7 +810,7 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&tkd->shadow_timekeeper, tk, sizeof(*tk));
+		timekeeping_restore_shadow(tkd);
 }
 
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)


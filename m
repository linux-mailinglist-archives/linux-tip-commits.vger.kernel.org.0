Return-Path: <linux-tip-commits+bounces-6531-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9546B4AAB7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E9D3BC8F3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADFC31C560;
	Tue,  9 Sep 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="raXYmn0M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3yTyFn2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EF318150;
	Tue,  9 Sep 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413866; cv=none; b=jRZKkXCD0GXTMqyh/QUPKgdThPiSf6RO+0GSCa/cxv7Re+4JxYpbcFAquFW4aOnz51ix0UO0fPny6Jw9DCMCvm9grYzi3jwwAGAIHfjR3hljJaOIk2IvG/BpCNt+BsCNuM1Qwp2KtMD4nLVX3Atfx5bLw3t8OdWNFHOR2vLf/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413866; c=relaxed/simple;
	bh=x9rPh1nMM9Cf4I8k5bekgH7OF7D/vwlrPH8LHBC4r+s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=icDawX30rXoo2sbEPo6u6UkJfxkxUh299rItF+6f25mUB8VRN+N3Ln6SiwUcBnDnxyFs85BK3mHPGeBkyQj5z92UcAeu3eGPeu43sTWPtcHE1zjWehy7TcnuJhsF3L1kPOEeGkGH+AK5sqeBb5G3f9QyoXzjkWvy0EgqS4ejvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=raXYmn0M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3yTyFn2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:31:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4iUYjlbaE/sLHAeS7/+DPWsX+hgbAejZNjQ8Id2NI0=;
	b=raXYmn0M0cOQrGgebllV9ecUtKUptWfD6FFWK3Pc2zlwmLJ/T3i/EUnx4bD5x6d8w9mnNp
	V+MMi362jbkynOIrtlbzjg9s6vS2HG7Ne2kfOgbKLY4gU1z445GSvStZ1ell4uXyKaNiX3
	neqli/90skoysODfxXeUu+p9alKJ6nWv1jAH5DsNJnE7IJe6lBOXwLNGKbDtue6WnvaxNf
	SD9lIQZPM5lza8Qc4JrIiIJAj6kRA84UOMxNtHl16rWhlYbbBm5WhRO5gYXKzuVcNHHcUK
	SyV3Ds8Iqx6jfMEsfS3PaxfSjfMAbz4ZiNNVz0CrWQN5J7mMJob+Y2BveL0+Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4iUYjlbaE/sLHAeS7/+DPWsX+hgbAejZNjQ8Id2NI0=;
	b=i3yTyFn2e5wxVDvfzJUQhMc0FZc8cih2o8OkcndWhW7m0Rkrd7jzExpO6JAD3IWnCbrVxD
	ucWCxFOZiFnaVYCA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Use hrtimer_cb_get_time() helper
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-7-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-7-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741386116.1920.15844683693783499105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cdea7cdae26995992a766443e1ea862923f2443d
Gitweb:        https://git.kernel.org/tip/cdea7cdae26995992a766443e1ea862923f=
2443d
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:18 +02:00

hrtimer: Use hrtimer_cb_get_time() helper

Various other helpers contain open-coded implementations of
hrtimer_cb_get_time(). This prevents refactoring the implementation.

Reuse the existing helper.

For this to work, move hrtimer_cb_get_time() a bit up in the file and also
make its argument 'const'.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-7-3ae8=
22e5bfbd@linutronix.de

---
 include/linux/hrtimer.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 1ef867b..e655502 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -154,14 +154,14 @@ static inline s64 hrtimer_get_expires_ns(const struct h=
rtimer *timer)
 	return ktime_to_ns(timer->node.expires);
 }
=20
-static inline ktime_t hrtimer_expires_remaining(const struct hrtimer *timer)
+static inline ktime_t hrtimer_cb_get_time(const struct hrtimer *timer)
 {
-	return ktime_sub(timer->node.expires, timer->base->get_time());
+	return timer->base->get_time();
 }
=20
-static inline ktime_t hrtimer_cb_get_time(struct hrtimer *timer)
+static inline ktime_t hrtimer_expires_remaining(const struct hrtimer *timer)
 {
-	return timer->base->get_time();
+	return ktime_sub(timer->node.expires, hrtimer_cb_get_time(timer));
 }
=20
 static inline int hrtimer_is_hres_active(struct hrtimer *timer)
@@ -200,8 +200,7 @@ __hrtimer_expires_remaining_adjusted(const struct hrtimer=
 *timer, ktime_t now)
 static inline ktime_t
 hrtimer_expires_remaining_adjusted(const struct hrtimer *timer)
 {
-	return __hrtimer_expires_remaining_adjusted(timer,
-						    timer->base->get_time());
+	return __hrtimer_expires_remaining_adjusted(timer, hrtimer_cb_get_time(time=
r));
 }
=20
 #ifdef CONFIG_TIMERFD
@@ -363,7 +362,7 @@ hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime=
_t interval);
 static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 				      ktime_t interval)
 {
-	return hrtimer_forward(timer, timer->base->get_time(), interval);
+	return hrtimer_forward(timer, hrtimer_cb_get_time(timer), interval);
 }
=20
 /* Precise sleep: */


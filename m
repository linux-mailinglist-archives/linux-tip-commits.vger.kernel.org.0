Return-Path: <linux-tip-commits+bounces-6505-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C7B4A625
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A2F174E18
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E362750F6;
	Tue,  9 Sep 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Br1IpR5T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6m82KAjr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC35271475;
	Tue,  9 Sep 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408205; cv=none; b=TVVNzh7skB8S+ZRDg6emhAvgvEbpbOJ52TyKNwG6JE7BF733p2O1jAabE4Ta0cyk4oOzdH/VHHDbHZd4Z8VX8IJLeddpKiu5quKU0cJ9XGp6Kj7OY+6oOtXdEHTKbWDQcvle7bc+hfo2Adk6uxRKos1GLYfaQH8BBhwH6WzZreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408205; c=relaxed/simple;
	bh=+0pK9uMEMpKWpD3YkxOhbk3vpgq8Txmq49EPOxSaay0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OYL982s6vC6VvzUvwbkSgbUdxkyTozJuluqE6zMBWIJ3iFaHoeSUGLEtrZtT6h2pUvOW+/qkVby2k5rxtxNMmMGzBlxWD7kpXiwF6js1O8GkE9bQMRxHEKH4LJ/iOsiuT9yGyu7R3HLzzxtBQE2xWWBbgllpEecWGnEXt8r+mVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Br1IpR5T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6m82KAjr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 08:56:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C41bZck4mCGkFE7e1B/CRF4NA4/zETVFESSqTczHy6k=;
	b=Br1IpR5TJlaYdobnh4/Jvfke1AWYiaij65sgPlcMwl2z7pmlbg/F/jukDApCRipZGzVOmw
	GJfCpD8Q42DqRbjEwChOVeqO3vKnUr/knj4FVEhOAmIjRL8WVA2DBSpePdFgkjQo7681Hn
	tDBWPTHOjbx6zl0iwD9rBkZ/QeKCUycbTagdsjp5E1YNS9XlUl5ZwkvlXSgWv3C5NEpEJx
	LR/Sbbosxu3u4Bq/8Pwm/RYddVjZ5MR+VfHTaplO3ABcUJ+DwEKhEc3TVb6gu3M7dxS61I
	E2382pLWjOw+eBHdhQ2UACFKNvMMp/LY5d+JpKG0ToZ9PRB/2R8k+YD6bCeByA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C41bZck4mCGkFE7e1B/CRF4NA4/zETVFESSqTczHy6k=;
	b=6m82KAjrBpUl3MeEGmUyXWWnckCLZgVnr/rDXsEaoFbE2tm7SN9VETyCVKIFRhpdVsatU4
	zCGritWSdV1bVvCg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Use hrtimer_cb_get_time() helper
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250812-hrtimer-cleanup-get_time-v1-7-b962cd9d9385@linutronix.de>
References:
 <20250812-hrtimer-cleanup-get_time-v1-7-b962cd9d9385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740820049.1920.4477278044090618908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     19243b3beb9e362fad88a55cc28cf87a05785f70
Gitweb:        https://git.kernel.org/tip/19243b3beb9e362fad88a55cc28cf87a057=
85f70
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 08:08:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:53:19 +02:00

hrtimer: Use hrtimer_cb_get_time() helper

Various other helpers contain open-coded implementations of
hrtimer_cb_get_time(). This prevents refactoring the implementation.

Reuse the existing helper.

For this to work, move hrtimer_cb_get_time() a bit up in the file and also
make its argument 'const'.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-hrtimer-cleanup-get_time-v1-7-b962=
cd9d9385@linutronix.de

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


Return-Path: <linux-tip-commits+bounces-2578-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6F9B0C6B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116EC2817BC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52C20BB2A;
	Fri, 25 Oct 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0eccq0k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Am2x4Bku"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757F189F50;
	Fri, 25 Oct 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879279; cv=none; b=PodBE6SJxfIPXH0edmAdFlu+5f7jV5jQzWjxLhpeiN3CgjEb4XZmSssoz3Remjtib1ihLzW6MLuM32EKxNqq8ierRPiD7w+g0q7F1Bin55Cd9ONmXaibspOLGS0nxnRoWxfQg6Fz0KMsQICMguxZp/YeZaHRA6nu0yUtnJW/D54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879279; c=relaxed/simple;
	bh=O4MuLUJnib/uQVf8P7rFOwty0z889OlhY9uEyikve2k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fNIwZWZYC+IjxqXEbnZ9bSP7IkRMvd+7w+sI4rk2Y8Xh9T06ODMkv1zg6Fr6SbiweE9+6tFIBu5ELeJaVugoSlymJo5XG4+p/tLNGXiXYJ1iFTo01L9wrDaQomT202QVXPJtxKh+IfGrOO+VRJVvCEu9/VTibCC0Gx7Sgf6v6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0eccq0k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Am2x4Bku; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PBJXUBRlsT+v+avESWDEkx2xE/h9Q9cDdYZIRs8LIA=;
	b=M0eccq0kuq/4gKPEYK+CFQct/AsG5Pr8SZUBZZSmiM/xC0bEyyn8dL77nEf6VVlsBS7GDa
	t751/nydZjS7VUK3APM9VRXBDqQoRoaKvsztTK2W0Mx1RbOTS0ukND49nbIHWiJCZNE0Dq
	XKXmPDDavU4daoNyhM7YNNMpKnBKIYH/8EkKQq5rupETY4gq1SM76TtlrzBtDNVQ2zEwaZ
	Mqvps3HIuETxQ8e1RQjrrzGpZeCR7m5ek1lQxujB9nwIFVYSSv6s45UmIHWaW8UbOfDo24
	lc12Ud6J7z4Q1AxZCv1e20eihGwZtXrwC6HlSXloWtRutACh1rMJ8+S0hwg/Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PBJXUBRlsT+v+avESWDEkx2xE/h9Q9cDdYZIRs8LIA=;
	b=Am2x4Bku9JDHzpp5kG71Yi7zUpNLECYuWRRIOEs7OPxKKk7QhnkWKQIfvLvvXaS8oTBrLM
	488yoS8JATPTePAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Remove TK_MIRROR timekeeping_update() action
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-24-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-24-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987927344.1442.18209542457202456809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0026766dfd699cf217beae5ac92cd153a30b60b0
Gitweb:        https://git.kernel.org/tip/0026766dfd699cf217beae5ac92cd153a30b60b0
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:15 +02:00

timekeeping: Remove TK_MIRROR timekeeping_update() action

All call sites of using TK_MIRROR flag in timekeeping_update() are
gone. The TK_MIRROR dependent code path is therefore dead code.

Remove it along with the TK_MIRROR define.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-24-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f117982..6ca250a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -30,8 +30,7 @@
 #include "timekeeping_internal.h"
 
 #define TK_CLEAR_NTP		(1 << 0)
-#define TK_MIRROR		(1 << 1)
-#define TK_CLOCK_WAS_SET	(1 << 2)
+#define TK_CLOCK_WAS_SET	(1 << 1)
 
 #define TK_UPDATE_ALL		(TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
 
@@ -816,13 +815,6 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
-	/*
-	 * The mirroring of the data to the shadow-timekeeper needs
-	 * to happen last here to ensure we don't over-write the
-	 * timekeeper structure on the next update with stale data
-	 */
-	if (action & TK_MIRROR)
-		timekeeping_restore_shadow(tkd);
 }
 
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)


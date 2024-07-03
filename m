Return-Path: <linux-tip-commits+bounces-1592-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314EC92690F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 21:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A056DB23D33
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281AB194147;
	Wed,  3 Jul 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A8uJaR0L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7dQToH+t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A31191F6C;
	Wed,  3 Jul 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035385; cv=none; b=BQSLafUOeIqkLjbzRVYWwXT6Y96EciybiqE7g3CrFUMjvu72wTZ6aujjRuYp39sn94RMRNjNqKInQw7RFgD3PJ9Xp5OLXaBRA9wZrcjLDXxwb+BbdLzWTT0LOoSr649poN5l8WHcrmJrmJBov8uOu0g8pDdwbUjd9i6OdUnuYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035385; c=relaxed/simple;
	bh=8fuGryCgeO/VX/VP4KPRyjqZ/d9LorLCsI3jRFMZbEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZoHsUigQeaF5OGXiMl4otRVG1utV2QkT9IU8Y+L/IF0AeeK8rN9zYVEiIucYzXUlqlMFNGyhDzO+7leQqhnGfm4bFEf/nz4oSyM9r2ioT0NKLoX2ON+doLpkzxyDg57ZZ98D09MDltHegzAaD/3s+5iAwdvo/d5QxdCeI/4mm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A8uJaR0L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7dQToH+t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jul 2024 19:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720035380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvRnm5IcZ1aTs7z5LMKf0mCH0HlBpmP0Q4YZWwGa/34=;
	b=A8uJaR0LwztiREm3uQiVmldGBvdkM29ZUEd91b2pkuMDPtWU4lITfE1nYGFoV1/6E5fMwQ
	EeMDP0WEaUvRZ0qtYkC63RzwwPoW7Xb8qAPV7QM0kUNC7jK6J/ZjSO8PtpoGauBzXktVld
	J38Wn1hwHfecf7TDRzkwvRTiNNuc5zIB2f4CBO9ZUGbu2L40UQvOye9GM0HWJSYzBq3vMj
	EYe4uMImcNBLpHTk8Q5aQsEntd56iS4I6DvLcs1/MGarP+DWhkz2CJC3TKmCz6GdIPSGDy
	RAVMhqkS6I9goKAt3QPFms4VA3qmw6vgjQ+wgYfmxQ4n6fAuPubdIQLX4KPDIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720035380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvRnm5IcZ1aTs7z5LMKf0mCH0HlBpmP0Q4YZWwGa/34=;
	b=7dQToH+tbLyAn47enCRnzAzB8wPFKmzUzxjBqO2FktQNn8vlSlyhBKCz4fGQPNG3SDUE19
	NdAHutF8Ur8R09Ag==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso/gettimeofday: Clarify comment about open
 coded function
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-vdso-cleanup-v1-1-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-1-36eb64e7ece2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172003538036.2215.4609585909791491212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f48955e038eaf43812c3701079c7371abe0315a4
Gitweb:        https://git.kernel.org/tip/f48955e038eaf43812c3701079c7371abe0315a4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 16:47:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jul 2024 21:27:03 +02:00

vdso/gettimeofday: Clarify comment about open coded function

The two comments state, that the following code open codes something but
they lack to specify what exactly is open coded.

Expand comments by mentioning the reference to the open coded function.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/20240701-vdso-cleanup-v1-1-36eb64e7ece2@linutronix.de

---
 lib/vdso/gettimeofday.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 899850b..c01eaaf 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -140,14 +140,14 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 
 	do {
 		/*
-		 * Open coded to handle VDSO_CLOCKMODE_TIMENS. Time namespace
-		 * enabled tasks have a special VVAR page installed which
-		 * has vd->seq set to 1 and vd->clock_mode set to
-		 * VDSO_CLOCKMODE_TIMENS. For non time namespace affected tasks
-		 * this does not affect performance because if vd->seq is
-		 * odd, i.e. a concurrent update is in progress the extra
-		 * check for vd->clock_mode is just a few extra
-		 * instructions while spin waiting for vd->seq to become
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCKMODE_TIMENS. Time namespace enabled tasks have a
+		 * special VVAR page installed which has vd->seq set to 1 and
+		 * vd->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
+		 * namespace affected tasks this does not affect performance
+		 * because if vd->seq is odd, i.e. a concurrent update is in
+		 * progress the extra check for vd->clock_mode is just a few
+		 * extra instructions while spin waiting for vd->seq to become
 		 * even again.
 		 */
 		while (unlikely((seq = READ_ONCE(vd->seq)) & 1)) {
@@ -223,8 +223,8 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 
 	do {
 		/*
-		 * Open coded to handle VDSO_CLOCK_TIMENS. See comment in
-		 * do_hres().
+		 * Open coded function vdso_read_begin() to handle
+		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
 		 */
 		while ((seq = READ_ONCE(vd->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&


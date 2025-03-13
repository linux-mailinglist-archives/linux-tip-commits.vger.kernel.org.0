Return-Path: <linux-tip-commits+bounces-4190-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34235A5F277
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA857AE0BA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51144267738;
	Thu, 13 Mar 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkz36ADE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LCurN1bw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA8267710;
	Thu, 13 Mar 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865495; cv=none; b=tVZMsU0jNnOHt8ORV2S3AOlCwmIcw4Czxn8WifRO0gUXk9HMH560rV5baYXGHPRxIhk7BBIghSYxnu9Lb+0q+v/sNcRV/bLxO5Q2q7ZSpHWHFWB2mz+PMI3fP5MzTC/FuibIRTq+r+yotgPJoBbmERBBbouzhXfP+uiRYDVGdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865495; c=relaxed/simple;
	bh=+tDNoYmeJG9QxEOj0f4e0aBcEXQ2brPf3AlrLY3fhRA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pORuoThEKLnU4KZ1d2DK2uVnFSIHC2ThI9qXhdw1CyQb/TBT3SsJ+Ky3yNXsnRM9ON8iQEBV1XWqJBtPsyJpeEevi1lKKTf1ZLyD/LfcHChPudfyGvU/T9ujOnmqrS7/NqyKEaM5oGgjRlivBto+e3IrEPaiQJfTETcRYozOSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kkz36ADE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LCurN1bw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOvbJplCwyhJi6+gruVkwS4o9kb45JVjYI8H5Njbwsc=;
	b=kkz36ADEsme+1AOs+atqvjg95MGYSanARKUT9j6zhLem/C+W9DtmJgG9U6YGmdjxtdT9Cr
	8Tfe2PK/0GxQmQdioqSFHmgPo86QRAcXY84jGlNGb7Lwly9jvlj/DZU9ywg7qivRD+XLwa
	EnpEDYCVg6YIH78YQE1YNjsjjRuJaRsvfGWUdIh8bHdPfbaeER83SFUpxCBfghT0YiTLlV
	tqqjyhz1FVDjA7VrYb/s49dIPUOjhdvPYHx/s0V0LAojmsYAu/EitlMQrr3eV51j8qKNVZ
	5/6V93ui5FQ/WNxJXdL3mmnl2Gha9Ru4P9YjvjTZbOM2MQVh0lU0WGHlEPJ0fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOvbJplCwyhJi6+gruVkwS4o9kb45JVjYI8H5Njbwsc=;
	b=LCurN1bwS7sjCP2AbrjaH4u7X+RajoD4pIB8fTFktt5fwjzoFBZKmRk8dxK/HLeoeGRITU
	6UzF+PCNRgYVnYCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Remove SLAB_PANIC from kmem cache
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155623.829215801@linutronix.de>
References: <20250308155623.829215801@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186549142.14745.11638273423021281512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f6d0c3d2ebb3355dc2b2a9015563cfbae6596417
Gitweb:        https://git.kernel.org/tip/f6d0c3d2ebb3355dc2b2a9015563cfbae6596417
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:16 +01:00

posix-timers: Remove SLAB_PANIC from kmem cache

There is no need to panic when the posix-timer kmem_cache can't be
created. timer_create() will fail with -ENOMEM and that's it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155623.829215801@linutronix.de

---
 kernel/time/posix-timers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 5591b15..b7bf863 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -243,9 +243,8 @@ static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 
 static __init int init_posix_timers(void)
 {
-	posix_timers_cache = kmem_cache_create("posix_timers_cache",
-					sizeof(struct k_itimer), 0,
-					SLAB_PANIC | SLAB_ACCOUNT, NULL);
+	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer), 0,
+					       SLAB_ACCOUNT, NULL);
 	return 0;
 }
 __initcall(init_posix_timers);
@@ -371,8 +370,12 @@ static struct pid *good_sigevent(sigevent_t * event)
 
 static struct k_itimer *alloc_posix_timer(void)
 {
-	struct k_itimer *tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+	struct k_itimer *tmr;
 
+	if (unlikely(!posix_timers_cache))
+		return NULL;
+
+	tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
 	if (!tmr)
 		return tmr;
 


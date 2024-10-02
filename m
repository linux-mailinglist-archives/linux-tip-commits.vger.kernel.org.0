Return-Path: <linux-tip-commits+bounces-2344-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1498E050
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 18:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9042828063A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BFF1D1737;
	Wed,  2 Oct 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNPfIXs7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I67VDV9z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D11D1512;
	Wed,  2 Oct 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885542; cv=none; b=VJMPjTA30NuFO0oEXWLL0G+hsqApVJdeIYyAgHdZtcOAVZ2Fgb+Q/HDU2HCbN7bY0TyoUmhzB6cN1aX5tNPRqLNKbWNXcGo1WGyfmd51KYsNd2lx4pTlbWhLKFyUQ5quJy7SySTA7RahHqUKS91RrCbnXMfbeJ249kD0GZgm7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885542; c=relaxed/simple;
	bh=ugZ7kEswfY+nphqv7uJ9Fc5AZtrBEcWkr0EHVmNXZZY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I+YS75ZlDRi8H5Xsr/oHOuaDIwv62mofqR48+ajtkGokFEt2GyXQfwr2HZ33Z5p9VDAuMTkvO35VoEcnMknjc0OxCga+8X7uiu7fF+6z5sFDVwlmMjJxZWwrlGCDcUhGk6fJ/mPVrCsLCEg4PEOVF1hGxPfexW07QO4hbXcbikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNPfIXs7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I67VDV9z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 16:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727885525;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IKUEVGxAFo2/cvfHZlym/U1Co8i8UR4bBLTpcoPaM8=;
	b=FNPfIXs78LmC73v/ctaphkRarP3sFx4yI8haY7lYHaZEZYm15jJQbeD4nQfCKA209L/N0o
	HrTuFh68QxaTtUpxTaKAvGQTgHbJB3evnfrmXO++pzqqb3j/d9HifFcmsIKqAZ9Q2ZY6yS
	YMR4eZBKOhdd1NAmmX4lgkNHROYu5GpU9oYp07GT3qdgghxuqbGZ4/RLBrvmnv/6Jj6l/I
	O4tOUm3h0YkMCjOjhUBkagPyrMticFyVUWnZ0GsdibWyhuwy2qQcTZXrJe8UbydSecPL2z
	yJSCF5BWKRWRACNeKQsGgqcsIkYPQWKWo9xgMxpKQNWinrI0IgINDLY2NxwGfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727885525;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IKUEVGxAFo2/cvfHZlym/U1Co8i8UR4bBLTpcoPaM8=;
	b=I67VDV9zUpQj6LIcsbxuvFR3FeQznArkrx++ZrxH+rIF2jyxZc+L3JNztkDBLJMS4M5GLd
	mr/M3L3t36H5g+Ag==
From: "tip-bot2 for Jeff Layton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Don't use seqcount loop in
 ktime_mono_to_any() on 64-bit systems
Cc: Jeff Layton <jlayton@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240910-mgtime-v3-1-84406ed53fad@kernel.org>
References: <20240910-mgtime-v3-1-84406ed53fad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788552446.1442.6739684333919865155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8c111f1b967687f47bb0cfbedf2863b62c23223c
Gitweb:        https://git.kernel.org/tip/8c111f1b967687f47bb0cfbedf2863b62c23223c
Author:        Jeff Layton <jlayton@kernel.org>
AuthorDate:    Tue, 10 Sep 2024 13:43:34 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 18:06:03 +02:00

timekeeping: Don't use seqcount loop in ktime_mono_to_any() on 64-bit systems

ktime_mono_to_any() only fetches the offset inside the loop. This is a
single word on 64-bit CPUs, and seqcount_read_begin() implies a full SMP
barrier.

Use READ_ONCE() to fetch the offset instead of doing a seqcount loop on
64-bit and add the matching WRITE_ONCE()'s to update the offsets in
tk_set_wall_to_mono() and tk_update_sleep_time().

[ tglx: Get rid of the #ifdeffery ]

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240910-mgtime-v3-1-84406ed53fad@kernel.org
---
 kernel/time/timekeeping.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 47e44b9..a57f2ee 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -161,13 +161,15 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 	WARN_ON_ONCE(tk->offs_real != timespec64_to_ktime(tmp));
 	tk->wall_to_monotonic = wtm;
 	set_normalized_timespec64(&tmp, -wtm.tv_sec, -wtm.tv_nsec);
-	tk->offs_real = timespec64_to_ktime(tmp);
-	tk->offs_tai = ktime_add(tk->offs_real, ktime_set(tk->tai_offset, 0));
+	/* Paired with READ_ONCE() in ktime_mono_to_any() */
+	WRITE_ONCE(tk->offs_real, timespec64_to_ktime(tmp));
+	WRITE_ONCE(tk->offs_tai, ktime_add(tk->offs_real, ktime_set(tk->tai_offset, 0)));
 }
 
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
-	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+	/* Paired with READ_ONCE() in ktime_mono_to_any() */
+	WRITE_ONCE(tk->offs_boot, ktime_add(tk->offs_boot, delta));
 	/*
 	 * Timespec representation for VDSO update to avoid 64bit division
 	 * on every update.
@@ -930,6 +932,14 @@ ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 	unsigned int seq;
 	ktime_t tconv;
 
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		/*
+		 * Paired with WRITE_ONCE()s in tk_set_wall_to_mono() and
+		 * tk_update_sleep_time().
+		 */
+		return ktime_add(tmono, READ_ONCE(*offset));
+	}
+
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		tconv = ktime_add(tmono, *offset);


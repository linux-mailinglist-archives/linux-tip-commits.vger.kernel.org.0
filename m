Return-Path: <linux-tip-commits+bounces-2600-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CF49B0C97
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270C7B216B4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69C218933;
	Fri, 25 Oct 2024 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itTAWSeQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="veyWNkf8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAE217470;
	Fri, 25 Oct 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879294; cv=none; b=Y2BJh+ETEC00BPq6yUXX6wcjAWpSaHJdwKrhEVzSYMESLjRwFg4lRCzNIDRSbAG6Y4Jsn3Sf7NK3EA6wdo8L4tzgI1Dl5O1P7DISPRtLK9PTETt3WYLtXjtSdsOOZMmtoI6BpnsZ8Yo88sx+m/ii4qRbnIlEDGzAhmU3laLMcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879294; c=relaxed/simple;
	bh=DjX6oruJqD2QP7CGieRZuxPxKrmXT63gixRv3ARb5cM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X4I1TjcvZ/juJpdo3HWYLA4sA9fbrPBoItj4vjwvHfAQI1v2vEM6ab8UJ691Efw4CkzJOUfVqGSsjeu1Vb4B50eBRIoPiY34Jb/mrWNRSPjzMMr1nVWXGMpvvLkpfZ14lcS4gjBGloTDb5hM8G46T9Ua/1WqIhCDYzcbRtmA3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itTAWSeQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=veyWNkf8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC4bwRZ6lsPyTPHiFSY5euZuQhFtCN7eLd2FUXDktqk=;
	b=itTAWSeQNNRZuI27wiFsKYZKlpvdQiUmiW9jUwfU0MM47+ypNegdU/30+uq7iNB9yfC83X
	EIgCVTBciwFUtzLqs3T/iAp8eClbmWX13+k0TY7y5xgGB6rT9gL3Pt9U16E17ibZzYtsS9
	qIIqVRGT2K+0BN7xvz07j+0UsAUPbICYLAqKP93tyedfcyCby36pyQoBdrvrOI1wT/bybc
	HtG4MRCJy70w3+87G8ifsqFLcW9Las1J88VeGHpc0AzGP5VVuHqmZ67jkWOkSNJbzThVfX
	7b/9pq8DVT9pMfq708+nPAvwO+A2pfgXXV5WeJ8jxMTNzOLTBN3wjgABBXALbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC4bwRZ6lsPyTPHiFSY5euZuQhFtCN7eLd2FUXDktqk=;
	b=veyWNkf8OyE7d3FhpurIJPBXgYCVJfRrzkjm5chqEMZRXV4Q5FpOps9YhAawm6Y3FgzYCT
	PpCbw5DamooylmBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Don't stop time readers across
 hard_pps() update
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-2-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-2-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928985.1442.4888093989004626478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     886150fb4f19505b8f9d26201d7671b25c233a9f
Gitweb:        https://git.kernel.org/tip/886150fb4f19505b8f9d26201d7671b25c233a9f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:28:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:13 +02:00

timekeeping: Don't stop time readers across hard_pps() update

hard_pps() update does not modify anything which might be required by time
readers so forcing readers out of the way during the update is a pointless
exercise.

The interaction with adjtimex() and timekeeper updates which call into the
NTP code is properly serialized by timekeeper_lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-2-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2bc3542..ff98a0b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2746,11 +2746,7 @@ void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
 	__hardpps(phase_ts, raw_ts);
-
-	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 }
 EXPORT_SYMBOL(hardpps);


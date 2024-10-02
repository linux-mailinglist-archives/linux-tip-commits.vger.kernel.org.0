Return-Path: <linux-tip-commits+bounces-2335-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F416598DFA0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DA11C21FD2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347F21D1F52;
	Wed,  2 Oct 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1gF04hx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Hfo5bwC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BC1D1740;
	Wed,  2 Oct 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883899; cv=none; b=UBMavlCUrCMPtUXsKmay4WOKf4DiGJIx8V/pvZDLaJtPjCDfzqraqoGWrvkbmd1n/kzyMyMuH7T+xWmUGIKlxsCe8hdKiWw6L5KC18HILXQoFGAmjLdU5B8S2RUB05CDSfyNMgbveNSXzJeZ8sZVbw4WANS0L7zrk9/5MRUcyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883899; c=relaxed/simple;
	bh=cWxqOX+m4ssfdDCAZesbOucz7xvZcCLCReajjqCXBcM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PsQOcql/CUBkoRWq+450zSxTbhIZkzujWB/1hLz+/N+OFa2G++Kude/b05OeyUzbC92FLjtOSwT+2cZuxS+FxD4JflxFy4Z24J3knSnUfxuybycTIjRXJBqvh7ikzzgNIR8hp72gCiAPZXoIXaR3xTFPu3aCwGq7OH7efPEA5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1gF04hx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Hfo5bwC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkoHf87zhhl5ZhQwgJ7tizZLIK55YSFsI3hpjlSkOSg=;
	b=Q1gF04hxAAFbnElbhU91icSEx95fhdgJr3HMLHneigCa8uMGEghBsPlSVe01UE9XWo6UrF
	nlzsdyH188NSKkQITET0QUTnEVYdlcuERB4RFu8UhzJx2k1ytLA1ee2Ldw7i46T1mvQ4F5
	z/nin5MtLsWvoGtHBoRjrRtbqA9c6R8J+jejn8DAfxg/7pCFYM4uLDRQ0O843Xkes6Jcdu
	KPhv8TEe+1nVREfU/g7Lv7aTYSwScKU3S12a0L5KusicLRmsnVs5W9CwsrSscFW7LfLbos
	VUkvyO5QiqeKFbrubLdfDQHZS/JaKp7FlBw0OO7ES/BbPE6nhIqL9lLdc/uimw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkoHf87zhhl5ZhQwgJ7tizZLIK55YSFsI3hpjlSkOSg=;
	b=+Hfo5bwCi1GE7GGrPbrku8z8Y6h12r88i2RSpxM9YAVe1l1K99c4rCohGtuejNSLBY5kvz
	pC6Wtl/eMRxlLvDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Read reference time only once
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-6-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-6-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389470.1442.1849710502053804594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     136bccbc2e78d3cd0bd8831e4c5a4509c0ddd945
Gitweb:        https://git.kernel.org/tip/136bccbc2e78d3cd0bd8831e4c5a4509c0ddd945
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:39 +02:00

ntp: Read reference time only once

The reference time is required twice in ntp_update_offset(). It will not
change in the meantime as the calling code holds the timekeeper lock. Read
it only once and store it into a local variable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-6-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 905b021..0bfd07d 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -283,9 +283,8 @@ static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
 
 static void ntp_update_offset(long offset)
 {
-	s64 freq_adj;
-	s64 offset64;
-	long secs;
+	s64 freq_adj, offset64;
+	long secs, real_secs;
 
 	if (!(time_status & STA_PLL))
 		return;
@@ -303,11 +302,12 @@ static void ntp_update_offset(long offset)
 	 * Select how the frequency is to be controlled
 	 * and in which mode (PLL or FLL).
 	 */
-	secs = (long)(__ktime_get_real_seconds() - time_reftime);
+	real_secs = __ktime_get_real_seconds();
+	secs = (long)(real_secs - time_reftime);
 	if (unlikely(time_status & STA_FREQHOLD))
 		secs = 0;
 
-	time_reftime = __ktime_get_real_seconds();
+	time_reftime = real_secs;
 
 	offset64    = offset;
 	freq_adj    = ntp_update_offset_fll(offset64, secs);


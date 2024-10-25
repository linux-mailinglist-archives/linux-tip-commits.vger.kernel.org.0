Return-Path: <linux-tip-commits+bounces-2572-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8229B0686
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA731C23A49
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F002188BD;
	Fri, 25 Oct 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0dpwQiH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eLtt5AF4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BA20C61C;
	Fri, 25 Oct 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868044; cv=none; b=MrxhI2WwqJaPeNy0s9p4CdG2wzbHo81IxCaNyzMjdUZyVHmRqlqJZh8CaeNetJ35Fgw9ob3qGV/jSYlqsh/Qlz336GZFcbhjBNi5T1RFovPFwQhUKSIWRhl5Yaa2isjEDC1rGsTfzmW4FKERLC+GjgtM8/6tIGr+EINgIjCPz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868044; c=relaxed/simple;
	bh=MboG+eiMjKBd7csgMIojh5O5BEf0BQ+atNp4Q4Kjbk4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ej3uxLKV6ZFMZhvoFGU2riIHp2UFTjBhgbwV4tI8l6NMaimdgCZpBAvUwEShWj/zeW9raZoVgGtIgJCMpi4fdu8jMdFFXrNsJ/7YJCXE+yjHYeKrVCfekEq1uJ4Cueyrl+a4XhQtoc2p7VAb4jaKH7CvPvHzjhpYVP6BzI1uVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0dpwQiH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eLtt5AF4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:54:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z37eKXnirngIRu0lzOo4ghUbmVbTa7wnxdAHVRHQiO8=;
	b=Q0dpwQiHjcOF28WJphLFrdHPvtYgOLfwbsWV9kFQLa7jE85kuOznOGSAhx/Uut8NKd3vT2
	HDFvw3bcjum+KQoQ5mGLVGeUwvjLbNZjOlynNtYb/BpRlhhVm2lS/qovYGqShj8U+RQNSe
	iX5FxOcoFMfZNuzhJvI7xJZYSHPnqg6+CoG5waBrdriNC2abBT9zTWkHqRxHW6LUNHO+f2
	CmVNVTAWBAH3W0S4d7UDRo22DBVm2qO11PMxW1VLWDh7P1fnRlSTaOlf7dbcohZyzCzENp
	faH396D9UQM7ErSyhqdE4mTvCmy9rL8QlrFQuVE9vTdbNfzrGUvLLQzXqkYepg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z37eKXnirngIRu0lzOo4ghUbmVbTa7wnxdAHVRHQiO8=;
	b=eLtt5AF4riQ4Rc7HWt+P/wxINUjvgHeE/7+JgAIyzsT5W2q+cZ7/Qj3YPvKvKQ15Q5/Wm+
	o/Q1XvR3E8m4/KBg==
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
Message-ID: <172986804008.1442.6590256124537365421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     708573a8f75ec94e9063d6c47e0571bcf39f0bb0
Gitweb:        https://git.kernel.org/tip/708573a8f75ec94e9063d6c47e0571bcf39f0bb0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:28:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:11 +02:00

timekeeping: Don't stop time readers across hard_pps() update

From: Thomas Gleixner <tglx@linutronix.de>

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


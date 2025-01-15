Return-Path: <linux-tip-commits+bounces-3258-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFCDA12B37
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FDF1636FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 18:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D341D7E31;
	Wed, 15 Jan 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ie4Q3P28";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kP36xCXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3B1D6DB1;
	Wed, 15 Jan 2025 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967269; cv=none; b=CqMIVEfvZmxM+yoeBgkwrbNMTOw51eIFVybiSTAS2Bwkgh6c9RORbtKWIAsKApsphJh7w3YHAaFoVDhOnyIrcvUTbM5fwKOgDXPpEfqOdgHFtTnxq8aZvhRjvMJvf0CvAoHXSW3WTb+HXBYqDDOD2ED18m/LkdgYEhXDEHzyjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967269; c=relaxed/simple;
	bh=S5lIgFSuaS9d3+O1z0Wf89KURQH9KnGkxhOScVROAqo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QOoN33MnlEN6GhF5iu5O+XtOOsqqEIwunKCCjpfp/Tl/KpyW1PT0AKPkOK6/z4Pxjg+vcjWeIT83y4FI4CFQVTHV8GLJJGQ+XEfvmgzPkK8D5jmVy/800aqcvvbLVIkxmSIIk8QswGwbeX2EZVhg1vI6kkodEEAB2j2qgUAgXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ie4Q3P28; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kP36xCXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 18:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736967264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ9mtT3dN/N1aZYZEwFJnoMGpg79c+iEbAcKSki/pBE=;
	b=ie4Q3P28gWgEJpZyJnX+tHwjnWiBKHuGt0nGaBQPyDJxTHQGA81SoXLk8KV1AY3UpdDKzE
	48l0EcLrpkcxCWTrSYjHqc0B6zG9vGE7h/TkenXh0M5GyRo6ny6V08v3ofN+GDr1GNeRVd
	yzQniEE6QEeAQp1ffVKlyRd4DItHT4Uii3AMN4mMtXLtNpVUuZ2q0pVdOpCx0kQJy87MtE
	Oh/vWe1Jki5Ypsd1S4qsj8wPDj5Svcf00Uas3EbTSNlFOPrgIa42GSkkU9eucIg/6hb3VW
	n4wxZptgMqKOjA1IJJYJ+7Z3pn4H7DWxi6OC/XiM8Lro4EG1pP+lKQQVYK4emg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736967264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ9mtT3dN/N1aZYZEwFJnoMGpg79c+iEbAcKSki/pBE=;
	b=kP36xCXp9LrUulcqK5XUEAtFoKuSoKaXk25R8Fa5DmDNtK9wH2qOLgvmrm9/9KXXb+xaKj
	QqKi8F22SblvY+BQ==
From: "tip-bot2 for Richard Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] hrtimers: Update the return type of enqueue_hrtimer()
Cc: Richard Clark <richard.xnu.clark@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z2ppT7me13dtxm1a@MBC02GN1V4Q05P>
References: <Z2ppT7me13dtxm1a@MBC02GN1V4Q05P>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173696726376.31546.9239702221804169704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     da7100d3bf7d6f5c49ef493ea963766898e9b069
Gitweb:        https://git.kernel.org/tip/da7100d3bf7d6f5c49ef493ea963766898e9b069
Author:        Richard Clark <richard.xnu.clark@gmail.com>
AuthorDate:    Tue, 24 Dec 2024 15:57:03 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 19:49:14 +01:00

hrtimers: Update the return type of enqueue_hrtimer()

The return type should be 'bool' instead of 'int' according to the calling
context in the kernel, and its internal implementation, i.e. :

	return timerqueue_add();

which is a bool-return function.

[ tglx: Adjust function arguments ]

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/Z2ppT7me13dtxm1a@MBC02GN1V4Q05P

---
 kernel/time/hrtimer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 80fe374..b026fd4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1067,11 +1067,10 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
  * The timer is inserted in expiry order. Insertion into the
  * red black tree is O(log(n)). Must hold the base lock.
  *
- * Returns 1 when the new timer is the leftmost timer in the tree.
+ * Returns true when the new timer is the leftmost timer in the tree.
  */
-static int enqueue_hrtimer(struct hrtimer *timer,
-			   struct hrtimer_clock_base *base,
-			   enum hrtimer_mode mode)
+static bool enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base,
+			    enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
 	WARN_ON_ONCE(!base->cpu_base->online);


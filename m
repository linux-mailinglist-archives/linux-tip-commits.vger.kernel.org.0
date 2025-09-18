Return-Path: <linux-tip-commits+bounces-6682-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF404B86E84
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 22:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E657C2B2E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD831D72D;
	Thu, 18 Sep 2025 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mxz9Zawq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JqDlXbjL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364E31D371;
	Thu, 18 Sep 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227131; cv=none; b=JgIZ06BVbhJlVncizvBxbhkjjc/LVD0ROUFwmw85pQ6SIvP9n++TZpFLM8GsHXg73sBtH7K7m91zccmFLmcWtTrUZunnz0MujnE4w82Wvn2haxdaMZJ73/wpqFrLC3cMJx1ATuZesB6Nxg/SUhnrnr8fpjzKTdmRG+RrNwFetvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227131; c=relaxed/simple;
	bh=eovftIg+1hbkFUmKtdbfedihd5Xy9fKFb36JzuVuCg0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q9XrLB34I1UCwXZzSYVZoUow720dse+J3nVM5cFc3Jotefa4twU63tjGAChBsjGqueFs0vQHyvjeNl475Lupl/oUVg2rOBRoFIkoUFnzbqqrjtb7TidjIN4xl7N5D7OyNukqT+XXUQe0fnPa4JzKkxmqKqK+4chp86tAvhvxycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mxz9Zawq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JqDlXbjL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 20:25:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758227128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNdasAameuEoTSW0ZPoaUG6eBRjtOAa4bdYSR51TChk=;
	b=mxz9ZawqcuURV5V7PUjvN4uDsoWXkAcXZRvvCYQHxCd7DIeaF6/axL0r5TNfisrh1ozf5I
	IXOnc7aV4uizuFoxRMZI61ffUfjP+Z7CVDr15JNxjbtlVy2f6xsKtoCI1IszAaT7O36+gA
	4rUwiwEYRNZmTm8/qdQtrFgc3UGjLk9rQqCtqMkOM9oHhRoVv8LGsk9tFfPXt1ezEPKdpK
	Lz752Uo1zBX5+NvN8pdcVlRZtKI8pp1H5Blfonss5jbIyL5WAI8vHvrAydx5kB9Yq+8pQs
	h+JlhU0ryHXQ47XCAaHf+/i79rO12rNUnKNUUlxqbqidEvBX+d7tfXUgvgI1Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758227128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNdasAameuEoTSW0ZPoaUG6eBRjtOAa4bdYSR51TChk=;
	b=JqDlXbjL36XrzAhHwLYPvJO7qAyOKhUmbKEVXAaqy3+JNbesw0vsNho/purpnShyT7BSpi
	rxj2G6cOb/ak9sAA==
From: "tip-bot2 for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: smp/core] smp: Fix up and expand the smp_call_function_many() kerneldoc
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <6191405.lOV4Wx5bFT@rafael.j.wysocki>
References: <6191405.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175822712533.709179.8869554095732242608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     ccf09357ffef2ab472369ab9cdf470c9bc9b821a
Gitweb:        https://git.kernel.org/tip/ccf09357ffef2ab472369ab9cdf470c9bc9=
b821a
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Tue, 09 Sep 2025 13:44:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Sep 2025 22:21:28 +02:00

smp: Fix up and expand the smp_call_function_many() kerneldoc

The smp_call_function_many() kerneldoc comment got out of sync with the
function definition (bool parameter "wait" is incorrectly described as a
bitmask in it), so fix it up by copying the "wait" description from the
smp_call_function() kerneldoc and add information regarding the handling
of the local CPU to it.

Fixes: 49b3bd213a9f ("smp: Fix all kernel-doc warnings")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/smp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 56f83aa..02f5229 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -884,16 +884,15 @@ static void smp_call_function_many_cond(const struct cp=
umask *mask,
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
- *        (atomically) until function has completed on other CPUs. If
- *        %SCF_RUN_LOCAL is set, the function will also be run locally
- *        if the local CPU is set in the @cpumask.
- *
- * If @wait is true, then returns once @func has returned.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler. Preemption
  * must be disabled when calling this function.
+ *
+ * @func is not called on the local CPU even if @mask contains it.  Consider
+ * using on_each_cpu_cond_mask() instead if this is not desirable.
  */
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)


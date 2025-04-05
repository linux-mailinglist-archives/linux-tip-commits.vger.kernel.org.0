Return-Path: <linux-tip-commits+bounces-4697-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDF8A7C850
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 10:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066F1177EE6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247C1DED46;
	Sat,  5 Apr 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27nR1BXy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8WZeoHYr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616811DAC97;
	Sat,  5 Apr 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743842805; cv=none; b=Rd8uV6CITztkwx+mp8TYmMwmHMm+JDyVBdOkSjDaCPHfzLF8pABy5trsrK1+USwQKuSRAIVBVeYJh5tikfCep5WbRuYRL7486DM25QiMWu5vnk2jP1CgWTx0QySbej7lUdVW39QWTtV6nP3soP1qFgWpir9clIswuFaS99jHLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743842805; c=relaxed/simple;
	bh=2HDkxSHn3uX19knXVfoUy66stwfX1udad45i2IcNs5I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UU1LOG4RX9rtVn3a70t0cgsaJahiYlPRKwfhJ3QLKVhqSuGL6zwBJHGLdSUB49hhZ/SHrL8ue9gduBKmbuAXRCVYcKEwrFZcgqE7R5EukIJTtFFLM0mNkrYAGJoLmhdi3v65dEJpm2etmhRV4wp4oFf+lJ7prXSDqeYfgEKTQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=27nR1BXy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8WZeoHYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 05 Apr 2025 08:46:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743842796;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Up725vbGGQ5Ak5YJvFNlA7Ctg3MtdeLU0vv4IMXCcMI=;
	b=27nR1BXyYw3AY7W/nmtJJxUumWdEyVVoPb89yb35dOEUf7I9GQzi2UMiWS+Efvy2yKXCaw
	1MqOAKWkRcLcYaQQ+tMOkB8QpKw8WE6ysxyRzuKWSMAOBrIRXf7xJ+Tcr9X1jUuX1yfA5U
	uf94GnjxO6gPfqEvQP/DlMfgRk3+18vTwZpRWOByyr7467iQsejt6ONxXHkFYZvbvXEGoE
	NUrqetVKrtUWYJjgGZIcY/qaIFFF3aJwLNsx94ZZMspqiJSHuFrRM0nwXFXgkZlWEfUtmn
	C4krUnOSJ0/mLon4y/OhMhGfrxZNpPZpV8SFDOTr0anLaJqiujUnSBR97pJw8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743842796;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Up725vbGGQ5Ak5YJvFNlA7Ctg3MtdeLU0vv4IMXCcMI=;
	b=8WZeoHYr8dUPpksm/liF3GuLo7HGTW+3QXAPiEIMIgpsXPUDQblSRoiF9EBBYm5WcNp9cu
	hE4a1U77IS0TcuCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Remove unnecessary NULL check in
 hrtimer_start_range_ns()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4661c571ee87980c340ccc318fc1a473c0c8f6bc=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4661c571ee87980c340ccc318fc1a473c0c8f6bc=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174384279618.31282.9872402807172220863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     1cc24f2e766c5a6606b834a677bd58991c1b9781
Gitweb:        https://git.kernel.org/tip/1cc24f2e766c5a6606b834a677bd58991c1b9781
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 05 Apr 2025 10:30:17 +02:00

hrtimers: Remove unnecessary NULL check in hrtimer_start_range_ns()

The struct hrtimer::function field can only be changed using
hrtimer_setup*() or hrtimer_update_function(), and both already null-check
'function'. Therefore, null-checking 'function' in hrtimer_start_range_ns()
is not necessary.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/4661c571ee87980c340ccc318fc1a473c0c8f6bc.1738746927.git.namcao@linutronix.de
---
 kernel/time/hrtimer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 88ea4bb..e883f65 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1316,8 +1316,6 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(!ACCESS_PRIVATE(timer, function)))
-		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard


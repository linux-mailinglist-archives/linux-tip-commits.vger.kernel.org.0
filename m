Return-Path: <linux-tip-commits+bounces-5524-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF4AB5675
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED589171D59
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037B0298CD0;
	Tue, 13 May 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLsMeBpU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/N5qUAk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CC2609EE;
	Tue, 13 May 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144157; cv=none; b=u2TdFHH3bX+To6z6EwkxfuCgbtYAIBygLzFU7z8+03+/vMDALJfvujjRwVxcVNDWadxlU9xe/4hTeUoHJVL9RAdKAais6DyLISaqRFqA/x09xW0OY312NzHEbcUvFHJG+bdMtvJQJoGv6ty20Z/VhvPRG+V3XsdpmaU0g5QpORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144157; c=relaxed/simple;
	bh=x7HMU+Yc7rGpSFHM6soCkqQhLrHEzGWqmticcYTG2Mw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uMJS15h7+PDCigIYgHA366jF+0MsXp+lK8G4yov4lzxt0E88rIbHEoKsY7aQ/+1TV5eNVxohNx8fpJ2rx+j6Gn4t1Y5KFDHiTkqpcplIwzyF8WLEsOQ4l1MDrUo6+ytVkXbj51ZPFOZxYE3VFP43mQXaQF0/RL1Ge2GglwTBLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLsMeBpU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/N5qUAk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 13:49:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747144147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvbrM2HweCKbU7x8wJ6Z3IlRDGtX/OrbJSX2JVavmR0=;
	b=sLsMeBpUQEIPVUmg9GY1UG5wfQa2rpsvs8ih/AaAk44R6DPl91FjmfdCyV0seNsMv3Hxlt
	7L6+2cIh+kgzeM8yc6zCDIkutZzBCDsvYNPoTGqkBhymK7bRTyuAOU6gEb84mywM+7JhMj
	HdXmmcvVhIlUoJV0FfY1rhdwqevY33A0CLG/Ck0h5ejljIG478QJap0J47M+u1h7BjjyZB
	TYq5hySS2qtjd973iWtPncMP+R7+4qEBlu/8Y2JwrEg5rRsHpbHSlSKmcvRlKOHA0fCRHc
	EPcAsXnminVsAn+Hxon9v6SIdEcSpvHU3ALUKhHqOddgcrwGFyY9mhVAdB+CFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747144147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvbrM2HweCKbU7x8wJ6Z3IlRDGtX/OrbJSX2JVavmR0=;
	b=B/N5qUAkOrULlOetzTKfkAu7Li3XtrbxnxMmXQacGnmD+MAUBhbi1qFMrxLFyhfumD7hje
	SHc8Vo2i7L6BZHAg==
From: "tip-bot2 for Guilherme G. Piccoli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Fix the CPUs' choice in the watchdog
 per CPU verification
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250323173857.372390-1-gpiccoli@igalia.com>
References: <20250323173857.372390-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174714414676.406.18250814688771473751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     08d7becc1a6b8c936e25d827becabfe3bff72a36
Gitweb:        https://git.kernel.org/tip/08d7becc1a6b8c936e25d827becabfe3bff72a36
Author:        Guilherme G. Piccoli <gpiccoli@igalia.com>
AuthorDate:    Sun, 23 Mar 2025 14:36:24 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 May 2025 15:38:55 +02:00

clocksource: Fix the CPUs' choice in the watchdog per CPU verification

Right now, if the clocksource watchdog detects a clocksource skew, it might
perform a per CPU check, for example in the TSC case on x86.  In other
words: supposing TSC is detected as unstable by the clocksource watchdog
running at CPU1, as part of marking TSC unstable the kernel will also run a
check of TSC readings on some CPUs to be sure it is synced between them
all.

But that check happens only on some CPUs, not all of them; this choice is
based on the parameter "verify_n_cpus" and in some random cpumask
calculation. So, the watchdog runs such per CPU checks on up to
"verify_n_cpus" random CPUs among all online CPUs, with the risk of
repeating CPUs (that aren't double checked) in the cpumask random
calculation.

But if "verify_n_cpus" > num_online_cpus(), it should skip the random
calculation and just go ahead and check the clocksource sync between
all online CPUs, without the risk of skipping some CPUs due to
duplicity in the random cpumask calculation.

Tests in a 4 CPU laptop with TSC skew detected led to some cases of the per
CPU verification skipping some CPU even with verify_n_cpus=8, due to the
duplicity on random cpumask generation. Skipping the randomization when the
number of online CPUs is smaller than verify_n_cpus, solves that.

Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/all/20250323173857.372390-1-gpiccoli@igalia.com
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index bb48498..6a8bc7d 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -310,7 +310,7 @@ static void clocksource_verify_choose_cpus(void)
 {
 	int cpu, i, n = verify_n_cpus;
 
-	if (n < 0) {
+	if (n < 0 || n >= num_online_cpus()) {
 		/* Check all of the CPUs. */
 		cpumask_copy(&cpus_chosen, cpu_online_mask);
 		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);


Return-Path: <linux-tip-commits+bounces-5932-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBEBAEA914
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 23:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EB31C40C48
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA4260579;
	Thu, 26 Jun 2025 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BP9HrZTS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMyzVJFL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720B238141;
	Thu, 26 Jun 2025 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750974947; cv=none; b=uhnhF8CePdkPiLMjGzRUMVwutua+8m3WQJyJjirOpZYfKUGms1OnItfte5QULYmEYPXCWg7QB7402xB8m97uBwqet5BEntaTvmswWj1Z4f1OyvvoBDRv8cjzaFFtrLmrZAHI289lzr3ZwSmgWziiQxfn85XyQCqXqCv7+k1SA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750974947; c=relaxed/simple;
	bh=tqQfAg0tUAA+uv27cHcOCVa/hjDub859ShH6nww2Hik=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CPypBpcDKyQ94KwqPePksmR0Ix2r3e4sb2QqLXzsdkRq7q97JHuFJoeYVunvETLh9U0jBLj5vt2AgjK+Gyp12vxhvsaIXuAzf5iJ0vgE/+3VqPJpX7Qm5Xe/ir4GtTQVo+vwiBFJuXiIAoWa8UI6xOs+b1AeJf75wMGwwRTIsjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BP9HrZTS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iMyzVJFL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 21:55:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750974943;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yi+mpT/sGFQjoC2roEaMlU8g+SJkc8gxupCRM4CuUZI=;
	b=BP9HrZTSVyJEGAaNqMe666GLh5RLSzY/XbIC1Hziea6mFUUNU3G7gzLd52wq0LNZDiJafJ
	Liqk4aqC2KHm99nGxsQav6QwzWlyOrcvLgx9Ssc0ickIyeteTiDRgsg4H40HpIBUEkgfiU
	yEJQ6CdiMVhlfuqYOdd/QOBfK/K+UfhvOYCHr0V3AFAcrAj2Cn/0Br/uA2Aez/igwIEexp
	Pdigwn7HN8qo62ldOACNF9YHWr4Qj7E7LhusWkbyuWl8k/4zJ0Trnq1B7FfcDybWTomr5u
	Nd627RJuPfndt9wPEVm0Ri1I4YSgP1uss8qa5tqGhVJHHr5gxiPIgN5uxu0OsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750974943;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yi+mpT/sGFQjoC2roEaMlU8g+SJkc8gxupCRM4CuUZI=;
	b=iMyzVJFLHkhicU2ZfWM79b59Of3bchouPPKDZZfiHWL4WsPckYO9ZxVeCdhG1vsxaMM4Kh
	6uiMGBfAZauiF9Cw==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Defer check for local execution in
 smp_call_function_many_cond()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250623000010.10124-5-yury.norov@gmail.com>
References: <20250623000010.10124-5-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175097494203.406.12944175640042495059.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     b4d6510684bf040c24dead879cce29035ef45826
Gitweb:        https://git.kernel.org/tip/b4d6510684bf040c24dead879cce29035ef45826
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Sun, 22 Jun 2025 20:00:09 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 23:46:35 +02:00

smp: Defer check for local execution in smp_call_function_many_cond()

Defer check for local execution to the actual place where it is needed,
which removes the extra local variable.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250623000010.10124-5-yury.norov@gmail.com

---
 kernel/smp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 7151906..8456125 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -779,7 +779,6 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	bool wait = scf_flags & SCF_WAIT;
 	int nr_cpus = 0;
 	bool run_remote = false;
-	bool run_local = false;
 
 	lockdep_assert_preemption_disabled();
 
@@ -801,11 +800,6 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	 */
 	WARN_ON_ONCE(!in_task());
 
-	/* Check if we need local execution. */
-	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask) &&
-	    (!cond_func || cond_func(this_cpu, info)))
-		run_local = true;
-
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	if (cpumask_any_and_but(mask, cpu_online_mask, this_cpu) < nr_cpu_ids) {
 		run_remote = true;
@@ -853,7 +847,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			run_remote = false;
 	}
 
-	if (run_local) {
+	/* Check if we need local execution. */
+	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask) &&
+	    (!cond_func || cond_func(this_cpu, info))) {
 		unsigned long flags;
 
 		local_irq_save(flags);


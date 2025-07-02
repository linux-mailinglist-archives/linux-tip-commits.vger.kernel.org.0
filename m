Return-Path: <linux-tip-commits+bounces-5976-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489BAF5FE3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Jul 2025 19:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECA37AB70E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Jul 2025 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E28301127;
	Wed,  2 Jul 2025 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ta2udvop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/YcXn9Uz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FA2D94A2;
	Wed,  2 Jul 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477024; cv=none; b=Z5v2FvTp5ymWPLDTv8qh33TViw3M3ayB2AGzXoU0exTGeL3kWC5XEIMMzWTeMCvxLHeguqew4SlBBM9D01m3Qk/DVJm8XfhCezv8EeYHRRmADRpfommLxj1mST3RoxYqYLmU8o16KlPWuBDbgeHe4Pw9efE53JKccil9URZzass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477024; c=relaxed/simple;
	bh=LW0GWMm33jWE9qVOKBL31FcXidkh6ToKqiCP3h0ZkD4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wfs1PeH6hhjisA55Q7WH50s+Vv0YxaocIyMy+kDprwfQPIJCvpzr4utyY4I+gKG849SRgS5WculEae9xxatYeDAZee9im0x/aMezOO8S5f6NEFe9nD40jwNkITpBbkaKiOUmtfNrghOtkOdb1HpXrbzF+kaanQwboQARRYdukTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ta2udvop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/YcXn9Uz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Jul 2025 17:23:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751477021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2COFfY1UgkdIHYWi+ShV5oCtrFbUVRG+GfJGPhoyO24=;
	b=ta2udvopDdDVeJ519DsOpliVRVcMMc4YjuH4VXljo5QyewRQL8kiuaiixaJbizPFHv18DQ
	Z1udSfm/L4ABfoaeEMLE+ByGaJ09/8ZjCdRajPL88ctblxiFeB0AxmIrtiz9mOu/I8nGAq
	L8rARMqRA/Qc3mFvcdmwYS6ag1WWMQihL94WxYTgFiHK+WQCqoNHZ2ftMY/BOVrZuw61ME
	aR2LllCQsv1VsEaCc/19ZDDx1nQK3/4CUCD+X6HpMXG8Eq+E5aumHSmZGvXAN5idEJdMxE
	W7VXiTrRW5uxLbEcHXWJg8mXmy7N5WEwOww59X5cfyY2h5kCL8cXto27jrBqFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751477021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2COFfY1UgkdIHYWi+ShV5oCtrFbUVRG+GfJGPhoyO24=;
	b=/YcXn9Uzl8msF9162XGZKctVv4wVcrfQ/auL7RX9wz+6MmFiXYFIXnq/jpJJZQSCmqte8F
	ZUD8qQYAV9hdp6BQ==
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
Message-ID: <175147701995.406.2190759503320187064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     e0e9506523fea415e0d5abaa103fd67dc8a39696
Gitweb:        https://git.kernel.org/tip/e0e9506523fea415e0d5abaa103fd67dc8a39696
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Sun, 22 Jun 2025 20:00:09 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Jul 2025 19:13:14 +02:00

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
index 5871acf..99d1fd0 100644
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
@@ -851,7 +845,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
 
-	if (run_local) {
+	/* Check if we need local execution. */
+	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask) &&
+	    (!cond_func || cond_func(this_cpu, info))) {
 		unsigned long flags;
 
 		local_irq_save(flags);


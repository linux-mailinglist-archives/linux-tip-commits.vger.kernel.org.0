Return-Path: <linux-tip-commits+bounces-3424-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA6A39784
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045D57A5025
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE42417EC;
	Tue, 18 Feb 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELG9lg14";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pl78WA7u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658FF24061B;
	Tue, 18 Feb 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872003; cv=none; b=jjUgxmnuZXwdMOxFHF3uQEmZJByWjWB59hgiDPUXIHg+NIZAFcJCLfiS7FnNETQoEvf5JIlHAYz+NuSyTnOucCoNNTSlfZ4lmg4m1xHbYitCyzMRe5ABLvD2rcd+QzQP79FPeFmG6ysD5tvmihQsHOa5OAAecEifIk+8MKQ9gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872003; c=relaxed/simple;
	bh=QiUfmpfhI41FdwvozdmNTohNQUXBnJUweyd6em1Qf64=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cNmriQqm61P40BAE7dxDAFbd80ZBBwjsKOIhqyV5kPGovC/7D97g7VGyWYzmomB061qf40T9VuhkmD1Z7+lLeqBf9yJFQ8uy9Yw7KMvDVW9GHb1KA/azwhXi82TXo2xX3auudggz6Xoj0V1DI77i3iiyj9a9ndElwf43AMTpCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELG9lg14; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pl78WA7u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Do9ShhgZNaVPx9CEcb8cIEFHkmA86NCDcHFtmat4QrE=;
	b=ELG9lg14lBVXjsjtcioXbr+ks31OytFH42jzY3ed2PRXxFR49ZBH2EsEO4j6edfTW6dqIk
	QhMi5CyC/ABgy8qpTHm0876kYoWntSV1iNb5XSUYzrxW1IjOR4aeUR6D4gUObV6G0UFbPw
	w/zwkOz6ZplGS+JTgiAV5VFvzl34uBX0ZHFOA6ubOTWR7LgOBKeVjgsco8H2wtpx0dp5i2
	e2+H7Q/JqTzZXw9t4+m6cA61ccxdqRgzyIBt5F6Ex7NhV2ese9fcJADosRuhjZQNq9rUSn
	SE4MBk8bvVp+EqPlq4xtJp68nYKAZJHxlMUeUjBrFyolsJTSSGrIf4EJocgBPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Do9ShhgZNaVPx9CEcb8cIEFHkmA86NCDcHFtmat4QrE=;
	b=Pl78WA7uCKa51+wAplO0PYoIxmy7ycQbMMhgkJPM3LDXvMhcKRYu2zHaLxVRLdFR4QHvCF
	j0Rm4GbTxGTFGzCg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] perf/x86: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce84ad5a660b8e10867e547db8e64f7e99c48ebba=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ce84ad5a660b8e10867e547db8e64f7e99c48ebba=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199951.10177.13134666698456925374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     c56c98e5af6d912c07b4e1e7be8ee97b0ff6ab27
Gitweb:        https://git.kernel.org/tip/c56c98e5af6d912c07b4e1e7be8ee97b0ff6ab27
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:31 +01:00

perf/x86: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/e84ad5a660b8e10867e547db8e64f7e99c48ebba.1738746821.git.namcao@linutronix.de

---
 arch/x86/events/intel/uncore.c | 3 +--
 arch/x86/events/rapl.c         | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 60b3078..a34e50f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -347,8 +347,7 @@ void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *box)
 
 static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 {
-	hrtimer_init(&box->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	box->hrtimer.function = uncore_pmu_hrtimer;
+	hrtimer_setup(&box->hrtimer, uncore_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
 
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 4952faf..6a0d957 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -274,8 +274,7 @@ static void rapl_hrtimer_init(struct rapl_pmu *rapl_pmu)
 {
 	struct hrtimer *hr = &rapl_pmu->hrtimer;
 
-	hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hr->function = rapl_hrtimer_handle;
+	hrtimer_setup(hr, rapl_hrtimer_handle, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
 
 static void __rapl_pmu_event_start(struct rapl_pmu *rapl_pmu,


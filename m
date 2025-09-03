Return-Path: <linux-tip-commits+bounces-6437-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E597B42497
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A513B34C8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF431AF12;
	Wed,  3 Sep 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="in98uJnK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rw7c+cIb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021C313527;
	Wed,  3 Sep 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912354; cv=none; b=L7OH0nf8U4bdOozIZo4Y2Ytxm7CvxQGLDvWJr9fQx5/XE1ApqZhOni+4f6x8pl9Vl5xC0aanB0nUBV20rGit3Pm4sqckcflxGjKaXj4remNE40+QYHUy4zyUNzeVUxEWSDIg9UGr1IP5dx6ql560FDh+0re16Dp8aJ65JRH3IIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912354; c=relaxed/simple;
	bh=Tj8ZGnf2A/KfcVmW5RAyXSHXYerobzkXBQ1D3pl9Qro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mk3h+NvanOX0gasH1VU6Ph4tNFjXsUNrzHE031E1VaM/P8cvSqrQSz5A9RP96eQNhBa2+0leL1ncfa9s5Cm0dmK1f1KKm5rx7foBdvwjBWxDMuAJbzvvd6P9bnzqXKGG9PwuGRuiX+Tf03myjR3c2rkQHu1+++iBP+M+qoJVm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=in98uJnK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rw7c+cIb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 15:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756912349;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDvlvzEbK1tvh7BK+KtXeIqt7H+yinYDn9n8ULEfspo=;
	b=in98uJnK6ex2inheh0ceJ0gJqJmRTFc+KPcb3DiPCT4oBSjOSNBzLs4J1TdTvE0ToHZYFI
	141zUxdQbLSkz2a95TXHz6HqKbLeitk37cFBh2Z8SDpchOffd44xKEQUPAWzwB+WCoLlqj
	ZY7003BDGWHPwtPMPS4qBALFtDx/m0cpHEP7YjHKue9Tb/aWoxOsOEcG6Og4sCwM0ixWr/
	kJbQxzW80w6MT8wXd+q0prkcZwZn7wFstdn7E5WZ8Ru5e9pv0aCwOrh/ASJl9UcETjDIMj
	hx+R6ke8pPU8JiuFpOz5oyhpKfFGMfo0PcqoOj8ulJhOxx2J0RdokzSrw++BHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756912349;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDvlvzEbK1tvh7BK+KtXeIqt7H+yinYDn9n8ULEfspo=;
	b=rw7c+cIbg9g0tydJqeHPT0O1d/l1avdRpyZk/gKvTSfEiJJ/qeQQQkuIGrdJhY14GZ+O4M
	p/mcTZpz59N6YbCQ==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
Cc: Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Gow <davidgow@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20250822190140.2154646-6-briannorris@chromium.org>
References: <20250822190140.2154646-6-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175691234810.1920.10556521436506250097.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     add03fdb9d52411cabb3872fb7692df6f4c67586
Gitweb:        https://git.kernel.org/tip/add03fdb9d52411cabb3872fb7692df6f4c=
67586
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Fri, 22 Aug 2025 11:59:06 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 17:04:52 +02:00

genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions

Not all platforms use the generic IRQ migration code, even if they select
GENERIC_IRQ_MIGRATION. (See, for example, powerpc / pseries_cpu_disable().)

If such platforms don't perform managed shutdown the same way, the interrupt
may not actually shut down, and these tests fail:

[    4.357022][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kerne=
l/irq/irq_test.c:211
[    4.357022][  T101]     Expected irqd_is_activated(data) to be false, but =
is true
[    4.358128][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kerne=
l/irq/irq_test.c:212
[    4.358128][  T101]     Expected irqd_is_started(data) to be false, but is=
 true
[    4.375558][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kerne=
l/irq/irq_test.c:216
[    4.375558][  T101]     Expected irqd_is_activated(data) to be false, but =
is true
[    4.376088][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kerne=
l/irq/irq_test.c:217
[    4.376088][  T101]     Expected irqd_is_started(data) to be false, but is=
 true
[    4.377851][    T1]     # irq_cpuhotplug_test: pass:0 fail:1 skip:0 total:1
[    4.377901][    T1]     not ok 4 irq_cpuhotplug_test
[    4.378073][    T1] # irq_test_cases: pass:3 fail:1 skip:0 total:4

Rather than test that PowerPC performs migration the same way as the
unterrupt core, just drop the state checks. The point of the test was to
ensure that the code kept |depth| balanced, which still can be tested for.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/all/20250822190140.2154646-6-briannorris@chromi=
um.org

---
 kernel/irq/irq_test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index 56baeb5..bbb89a3 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -203,13 +203,9 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
=20
 	KUNIT_EXPECT_EQ(test, remove_cpu(1), 0);
-	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
 	KUNIT_EXPECT_GE(test, desc->depth, 1);
 	KUNIT_EXPECT_EQ(test, add_cpu(1), 0);
=20
-	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
=20
 	enable_irq(virq);


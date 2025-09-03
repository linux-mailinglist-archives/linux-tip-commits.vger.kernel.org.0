Return-Path: <linux-tip-commits+bounces-6441-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4524B424A5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 17:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380B87AAA50
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4573C322A15;
	Wed,  3 Sep 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UYzCKZWj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3scCrUYi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04F320CB0;
	Wed,  3 Sep 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912358; cv=none; b=Vkl4RHVboSWpYfhBSkE+HS70AVh0AHEkwmGyvtJVRPHW2ps7259gWD1QQPFyHVzFprQNRZm+eiipiKJd71nnZIGFVMeXu50TXxwHsTru80eDZo8w14COhq7s3RYviC+3knz0f7YUr4/Y8SFvmC4cOPQFyFm7SUuDNt2kCSd+Cc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912358; c=relaxed/simple;
	bh=Y3Qpuyjc6bBCmTgWlr50IIWtW6bHKPysiKjUx+LoyD4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mr4zwx8gUt16I3Qg7DkQZYdr+0DcIWMoKMgTDp8pKF0Uo0DD610oFR9Nw/wvjUQqjy+n8QXvFK2aYbXiSwCnkUK96We5J7hiHqGRyc0Yj5Nvqq5nSTSTxI2uPyangySYV0ZhvGw0Xe2EWy07Mad/+dwV1vYMa71cYwor/1ju8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UYzCKZWj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3scCrUYi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 15:12:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756912354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIymcpVKC2rWBlVHaRoBarhqUEE6qZiC/GYrgnOztGE=;
	b=UYzCKZWjbw1HrlsK0Llt63Zre66jIv4wMtZEHzXrr0vwOfQ5JzWThCuusCtGZYCMYnIR4V
	L+UKuMRuQnPa891qxgxKG7wWeRlco1h9Sx4QlJxY4tzN4aVk8AaXVpTP00moKVmWqBUGHG
	/xUiRe6m33KCQpNHp50M1Q8ryubEzg/DCtmQl/yEbLijdmkuVc9Z8ZZRny6PuHWwpe9XkN
	a9oYCD7+Lch2niQ0iYpZqWdfKZV+bITlRV/FeeHvIhY55JMbbucqWtVL3HEdoM80TUD8Ju
	QpPn9aSW6dCb0xBjI52HvC3xAXbfuYEfS5P2SEOUjpm5rGE3hvnrtlvQDs95Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756912354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIymcpVKC2rWBlVHaRoBarhqUEE6qZiC/GYrgnOztGE=;
	b=3scCrUYiieTKPvKEc3sLoBlsA+C/Jpgv5U9W/vr/FZ70l5ypxqJfYjYfbjtGFhkPGcDYJT
	Xf4yplyAH/HoeQDw==
From: "tip-bot2 for David Gow" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/test: Fix depth tests on architectures with
 NOREQUEST by default.
Cc: David Gow <davidgow@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250816094528.3560222-2-davidgow@google.com>
References: <20250816094528.3560222-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175691235363.1920.260429564520251502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c9163915a93d40e32c4e4aeb942c0adcb190d72e
Gitweb:        https://git.kernel.org/tip/c9163915a93d40e32c4e4aeb942c0adcb19=
0d72e
Author:        David Gow <davidgow@google.com>
AuthorDate:    Sat, 16 Aug 2025 17:45:28 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 17:04:51 +02:00

genirq/test: Fix depth tests on architectures with NOREQUEST by default.

The new irq KUnit tests fail on some architectures (notably PowerPC and
32-bit ARM), as the request_irq() call fails due to the ARCH_IRQ_INIT_FLAGS
containing IRQ_NOREQUEST, yielding the following errors:

[10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq=
_test.c:88
[10:17:45]     Expected ret =3D=3D 0, but
[10:17:45]         ret =3D=3D -22 (0xffffffffffffffea)
[10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq=
_test.c:90
[10:17:45]     Expected desc->depth =3D=3D 0, but
[10:17:45]         desc->depth =3D=3D 1 (0x1)
[10:17:45]     # irq_free_disabled_test: EXPECTATION FAILED at kernel/irq/irq=
_test.c:93
[10:17:45]     Expected desc->depth =3D=3D 1, but
[10:17:45]         desc->depth =3D=3D 2 (0x2)

By clearing IRQ_NOREQUEST from the interrupt descriptor, these tests now
pass on ARM and PowerPC.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/all/20250816094528.3560222-2-davidgow@google.com

---
 kernel/irq/irq_test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index a75abeb..e220e7b 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -54,6 +54,9 @@ static void irq_disable_depth_test(struct kunit *test)
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
=20
@@ -81,6 +84,9 @@ static void irq_free_disabled_test(struct kunit *test)
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
=20
@@ -120,6 +126,9 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
 	data =3D irq_desc_get_irq_data(desc);
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
=20
@@ -180,6 +189,9 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
+	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
+	irq_settings_clr_norequest(desc);
+
 	data =3D irq_desc_get_irq_data(desc);
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
=20


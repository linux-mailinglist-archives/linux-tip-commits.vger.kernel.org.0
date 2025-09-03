Return-Path: <linux-tip-commits+bounces-6439-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC83B4249E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539393BA6AC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E306320A1B;
	Wed,  3 Sep 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cga1WtLi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tmhoGDMZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536631A071;
	Wed,  3 Sep 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912356; cv=none; b=a+8cahlOD7PQW8aQKuKQfkkQ9dsG4AkccMKAeSYJblv0NPTk2EdpfF6t3Pax526oQuuelYyGQHzoPQmB9uBN4s+fNL97fNsTwgnlo1Q6Qcjp57xDr3WQBa+R9f2OBiqEP4d2bqkeI3AAWa3yR3VZ84BpR388TiSOLxSzyGPn80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912356; c=relaxed/simple;
	bh=F4syEAe1hGH1aQuq5oQM/06DobchxZR5KAq2vpdAqPs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YrdnpGT18d/sSAl7tCWM0uJOmzHeHPaVlkDnLYWxF1qbe/x35pGCGN4ldh7sxeXAg2ReWq++/gqQsuVi3cXbgAMHSvcsCd2jrtgoJaJjZc6Zl2jqczfyvGHGrshN1IinEe24/mepyk1WFFtWWSrdllvOJ0ubXwBvBAiyo4OSEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cga1WtLi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tmhoGDMZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 15:12:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756912352;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXR2Idb80yIqhM4XECEpemao3XiGcTEfZ1LP2evu2wg=;
	b=cga1WtLiaHnxqoTzI6Ky5dgl7uS4Ny7T261jXMIbsYl3trhG+YQDNhAwnjBFRtT3rbRm2i
	SLk/9GPANsgFlO10OJhmw7ssVhcRfqV6o9SmoEfUlEQQRG6VJnaK7lxMGkTAQKA7jieWdh
	Cto+QoyA4IdRE/RojL3hAeIXqTmN89XmyKYml0BG3zj6Hr0EqBldb5XMrggpCV9kgOT/+r
	ftMU4/QdMAEiRxQoZsEV5o+3cr9qvgJ0cJyDF7x2D+mgFJOKGRaZGMSlniKK7PigwcDYDP
	y4u62UUNy59n1OyhgJ/vcKxSbSnQQgNwKM8J8Fh4RzIDf8rjfgeqnjlYkr8suA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756912352;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXR2Idb80yIqhM4XECEpemao3XiGcTEfZ1LP2evu2wg=;
	b=tmhoGDMZxhwivJaahCSiFhmg/5qkvH3A0MbI2f7HIYIN5Ifbs5X2j14KGlBtXrsqXOGwRl
	TGi1nzaNjxu3iGDg==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/test: Factor out fake-virq setup
Cc: Brian Norris <briannorris@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>,
 David Gow <davidgow@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20250822190140.2154646-3-briannorris@chromium.org>
References: <20250822190140.2154646-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175691235142.1920.11470228687702736631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     59405c248acea65d534497bbe29f34858b0fdd3c
Gitweb:        https://git.kernel.org/tip/59405c248acea65d534497bbe29f34858b0=
fdd3c
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Fri, 22 Aug 2025 11:59:03 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 17:04:52 +02:00

genirq/test: Factor out fake-virq setup

A few things need to be repeated in tests. Factor out the creation of fake
interrupts.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/all/20250822190140.2154646-3-briannorris@chromi=
um.org

---
 kernel/irq/irq_test.c | 45 ++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index e220e7b..f8f4532 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -41,15 +41,15 @@ static struct irq_chip fake_irq_chip =3D {
 	.flags          =3D IRQCHIP_SKIP_SET_WAKE,
 };
=20
-static void irq_disable_depth_test(struct kunit *test)
+static int irq_test_setup_fake_irq(struct kunit *test, struct irq_affinity_d=
esc *affd)
 {
 	struct irq_desc *desc;
-	int virq, ret;
+	int virq;
=20
-	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
+	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, affd);
 	KUNIT_ASSERT_GE(test, virq, 0);
=20
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
=20
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
@@ -57,6 +57,19 @@ static void irq_disable_depth_test(struct kunit *test)
 	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
 	irq_settings_clr_norequest(desc);
=20
+	return virq;
+}
+
+static void irq_disable_depth_test(struct kunit *test)
+{
+	struct irq_desc *desc;
+	int virq, ret;
+
+	virq =3D irq_test_setup_fake_irq(test, NULL);
+
+	desc =3D irq_to_desc(virq);
+	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
+
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
=20
@@ -76,17 +89,11 @@ static void irq_free_disabled_test(struct kunit *test)
 	struct irq_desc *desc;
 	int virq, ret;
=20
-	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, NULL);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	virq =3D irq_test_setup_fake_irq(test, NULL);
=20
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
-	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
-	irq_settings_clr_norequest(desc);
-
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
=20
@@ -118,17 +125,11 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	if (!IS_ENABLED(CONFIG_SMP))
 		kunit_skip(test, "requires CONFIG_SMP for managed shutdown");
=20
-	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
+	virq =3D irq_test_setup_fake_irq(test, &affinity);
=20
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
-	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
-	irq_settings_clr_norequest(desc);
-
 	data =3D irq_desc_get_irq_data(desc);
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
=20
@@ -181,17 +182,11 @@ static void irq_cpuhotplug_test(struct kunit *test)
=20
 	cpumask_copy(&affinity.mask, cpumask_of(1));
=20
-	virq =3D irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, &affinity);
-	KUNIT_ASSERT_GE(test, virq, 0);
-
-	irq_set_chip_and_handler(virq, &fake_irq_chip, handle_simple_irq);
+	virq =3D irq_test_setup_fake_irq(test, &affinity);
=20
 	desc =3D irq_to_desc(virq);
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
-	/* On some architectures, IRQs are NOREQUEST | NOPROBE by default. */
-	irq_settings_clr_norequest(desc);
-
 	data =3D irq_desc_get_irq_data(desc);
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
=20


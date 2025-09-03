Return-Path: <linux-tip-commits+bounces-6438-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0E9B4249A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527D4482092
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9A31CA49;
	Wed,  3 Sep 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESrvTt4r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXQu/9FF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64D317700;
	Wed,  3 Sep 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912355; cv=none; b=Jye4LUVUZOgOoKq38ImwFNe7OBMFyaCchdvlIYGWocV6nOAa7MaZ/+W0o24N6E7Wqhq04ZadmKaebue9Bcs42zKvZA4eMuLc6Zrei1wIyfO4cbHTDNtdTbjpsU42rcV3/x+AnxawwoHSqqKSzfbXpPVFaTk0UQ48ZK+LDwwB94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912355; c=relaxed/simple;
	bh=eMMuPMhwTJIdB4SlnZWrio7HsL08u292rieY+TKYKEE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jqLyRsXHohlh9+xYzkfRyN4JP0OkxGATVkSIbFINLJ4Bou1b0T/0RcF2Rx+v3FbbzNizpfLJjfghwoTJeSdHOyd4qBl5BkB92RW19xHJS8XazAmlsuqCJVUNV4JHyg/wxoARsgRVd62OpX/goAvB07oa1jA3IN1MW0B8V7A2/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ESrvTt4r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXQu/9FF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 15:12:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756912351;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EiVV17akpqWuIcFtOtdlze14z5BllqVmj1eLJgINmE=;
	b=ESrvTt4rp9ZOo5QVGEOtC6sqmD3qQqPJRLSYTWD/ficGuZLBYlWU50RGnB/COYux2ERida
	5fPoleWde+9yduSrIPxx5D/7jTaHO3r5ZmNwTbGJBPzBdYUgrT09OS+iYDAk+AVyifLMxS
	1tmoXYGtb1t2pq4URXOyUy2DpzPWXxBFswM8mvSVlDHX9MA74dlRRxthq6AldsV5UjqJow
	foj3YztxOkf9cRW/z3+1Kjtpi6WAlnsNvhzz6skQCh+tzdIirwtf75fAYQ+hatN/6h1BjP
	ruyp5wwyWSmq10fvlOqGUHjS2aqB6Efv9ypOg0khfzclQ5esRAQvq07hDPXG+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756912351;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EiVV17akpqWuIcFtOtdlze14z5BllqVmj1eLJgINmE=;
	b=iXQu/9FFml9nF9LTNKzzmeddpikPq5AMn7FEoAkgLUfTmaU/905Z/fif/OoT6IlpuTVfpi
	B/AnyDQxRXlnXKAw==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/test: Fail early if interrupt request fails
Cc: Brian Norris <briannorris@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>,
 David Gow <davidgow@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20250822190140.2154646-4-briannorris@chromium.org>
References: <20250822190140.2154646-4-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175691235027.1920.4770657039561880832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     988f45467f13c038f73a91f5154b66f278f495d4
Gitweb:        https://git.kernel.org/tip/988f45467f13c038f73a91f5154b66f278f=
495d4
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Fri, 22 Aug 2025 11:59:04 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 17:04:52 +02:00

genirq/test: Fail early if interrupt request fails

Requesting an interrupt is part of the basic test setup. If it fails, most
of the subsequent tests are likely to fail, and the output gets noisy.

Use "assert" to fail early.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/all/20250822190140.2154646-4-briannorris@chromi=
um.org

---
 kernel/irq/irq_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index f8f4532..56baeb5 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -71,7 +71,7 @@ static void irq_disable_depth_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
=20
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
=20
@@ -95,7 +95,7 @@ static void irq_free_disabled_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, desc, NULL);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
=20
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
=20
@@ -106,7 +106,7 @@ static void irq_free_disabled_test(struct kunit *test)
 	KUNIT_EXPECT_GE(test, desc->depth, 1);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_EXPECT_EQ(test, desc->depth, 0);
=20
 	free_irq(virq, NULL);
@@ -134,7 +134,7 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
=20
 	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
 	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));
@@ -191,7 +191,7 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	KUNIT_ASSERT_PTR_NE(test, data, NULL);
=20
 	ret =3D request_irq(virq, noop_handler, 0, "test_irq", NULL);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
=20
 	KUNIT_EXPECT_TRUE(test, irqd_is_activated(data));
 	KUNIT_EXPECT_TRUE(test, irqd_is_started(data));


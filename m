Return-Path: <linux-tip-commits+bounces-6440-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF2B424A2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A752E680F50
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB3321F3B;
	Wed,  3 Sep 2025 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxgnE5Os";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMgb3VMv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35FC320A0C;
	Wed,  3 Sep 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912357; cv=none; b=HSrgmYufM16VbjEM1rEqWoU9ao3KtHnw6nJxPxakl5cicDU11b1JDbDl51n/lW+fMxqpL2OQ6sb18+rUdgaTeuIEJN5XGNSYJDoPDsLQNoDpffr58UNFgfUzxIypA4h5ssjaJE1b04c6vp7b7Yg/WNv6uc1ayVq4T2yznLAu4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912357; c=relaxed/simple;
	bh=16NeIuxXtAnYZRftrBcbBJ2Xhkrjk9sHAlMaXxaCdPs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B2/q/u18EPJ7Vd9Nkkdi6Sy9lK/pJnShnNek6RWWS95nh5EMZqkhWUHsoOPxPOwXQO98Y6eGfsL37ojSMmk9kelZ/i0IzQgDFXrcfc8U4lZuHMmViXpy3jogrSeQLl4WyxMgkoCz5VIMk2dAdgD7qyy8VO3PymoB7vdaJJL1zC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxgnE5Os; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMgb3VMv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 15:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756912353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u41lNaP24N3I7KFS997jmyYM0tYqqzML0MefaD9aIbo=;
	b=DxgnE5Os9MbMhOTjS5+M1WpZjiDN4hx/SLEpyYv1src0WHETERpVpqYzYzPel+SeHYwZ76
	EfNkupPC44clvF1NUgxwDCYllNFPbeDYB0J0J9Vk9QZeMXyg6+e+jzOvjbbXWBenuzK1BC
	9cyKvOPHOYSRNyB6nxjINFPG36c40kzshrxwNs07razJNLRsxWrPAssMBqR7YScXATN7Nb
	LEDzFpTGweH/3huOtn1X97SzvJ5DT2xC3+oRovzXmEFmUMdd+Pi7SrvdETXtRh6nU+eldQ
	4u8k4OPUx+t6JAblqetttsSN4CQIFtU4JaUggAZ5YZJPo43vawfE6OuhmLU8jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756912353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u41lNaP24N3I7KFS997jmyYM0tYqqzML0MefaD9aIbo=;
	b=SMgb3VMvTerzuQuB+8m841bQqZ4dysuOPpCojFF/Q+uzcP5N12fWp2Z8g5nfx1nb6T9xmZ
	SOmi5vW4hJIWHlAQ==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/test: Select IRQ_DOMAIN
Cc: Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Gow <davidgow@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20250822190140.2154646-2-briannorris@chromium.org>
References: <20250822190140.2154646-2-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175691235253.1920.10187725279710747530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f8a44f9babd054ff19e20a30cab661d716ad5459
Gitweb:        https://git.kernel.org/tip/f8a44f9babd054ff19e20a30cab661d716a=
d5459
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Fri, 22 Aug 2025 11:59:02 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 17:04:52 +02:00

genirq/test: Select IRQ_DOMAIN

These tests use irq_domain_alloc_descs() and so require CONFIG_IRQ_DOMAIN.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/all/20250822190140.2154646-2-briannorris@chromi=
um.org
Closes: https://lore.kernel.org/lkml/ded44edf-eeb7-420c-b8a8-d6543b955e6e@roe=
ck-us.net/
---
 kernel/irq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 3667364..8bc4de3 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -144,6 +144,7 @@ config IRQ_KUNIT_TEST
 	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
 	depends on KUNIT=3Dy
 	default KUNIT_ALL_TESTS
+	select IRQ_DOMAIN
 	imply SMP
 	help
 	  This option enables KUnit tests for the IRQ subsystem API. These are


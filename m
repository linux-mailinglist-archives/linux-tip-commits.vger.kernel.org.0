Return-Path: <linux-tip-commits+bounces-6239-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C365B1C236
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Aug 2025 10:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5FD18C14C7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Aug 2025 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0628137E;
	Wed,  6 Aug 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRtrcilA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gzfHTrqZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C922156C;
	Wed,  6 Aug 2025 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469212; cv=none; b=hgrcDoF+VgzsbC269LQgRzQ7IDv2pEiXzFBZLn95A/YbW+5YknUa2/Oq5UVNQKyrU1z/Y6SrtOEhsic4199mBgBXPOTnaBzGYMQI2cKbkhsLof2qMuq2HO/3I6M4uI2/pvcj3a/MGZgX78mo1qP0UuZzy3z2I6k3vMfVCtZDBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469212; c=relaxed/simple;
	bh=Q64QHHoSvnKNexMvPaB7nwVJ9n+Cify44fwzMpwFQSY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MGsz+Myen7VA4REa7/CbEkeISl1NbBPW63B+1WgjbZinPl6qkKHw1owNx7Vw9SpEMMlp0eALkuPscYW4DLG6K6B/H2Gw9ACuPFhFOfMoJXp0KhKVYvhA/5O6S1BlH5ZJlYbWXHLUYfvUXbWKkgZKSTjYtNTUo7Aa/UrkvQx46sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRtrcilA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gzfHTrqZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Aug 2025 08:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754469209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y68ZHRhkztS1h/H4g+Moz3rzxfTmuJt9fJVU7c1+Mw=;
	b=gRtrcilAGXB6zYdSwEfmX+BtBrQ4nw0VCZG38AKraKICmhfoU85WnSxCaPLa6MevVRNgY8
	wU4vkuckf1T+ighg52XcO7x7ZeljyD/QAP/7+8Dih+6RwO0B8AbSqJDia2kIK3Emnpcewz
	X9JhKAkYozV/kxmlQ8Jg/BVZbuH8GMWz9/xcHQD4dyAXiOryEsRifmatTNcLelFJjRQbZ7
	opv4eiHfR7DPcCKZBhDk7PPXKmqoacN9hSUgpswGfkWEDYwJ3i+cX45jO96Hq6k4YRezh1
	QnSx7IRydhQiIucml62Wi8RGoDl728eXff2tmkwenRFbiJGMYErBfsxOctZXuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754469209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y68ZHRhkztS1h/H4g+Moz3rzxfTmuJt9fJVU7c1+Mw=;
	b=gzfHTrqZodPRUVuffQ+dADt3ZgshjEX6mqnUb6FD91b+I1iMhujT74VtFF5m/sMMOBWpDD
	FCbI/Phz5ENJvGCA==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/test: Resolve irq lock inversion warnings
Cc: Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <aJJONEIoIiTSDMqc@google.com>
References: <aJJONEIoIiTSDMqc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175446920768.1420.10144196712187691411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     5b65258229117995eb6c4bd74995e15fb5f2cfe3
Gitweb:        https://git.kernel.org/tip/5b65258229117995eb6c4bd74995e15fb5f=
2cfe3
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Tue, 05 Aug 2025 11:32:20 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 06 Aug 2025 10:29:48 +02:00

genirq/test: Resolve irq lock inversion warnings

irq_shutdown_and_deactivate() is normally called with the descriptor lock
held, and interrupts disabled. Nested a few levels down, it grabs the
global irq_resend_lock. Lockdep rightfully complains when interrupts are
not disabled:

       CPU0                    CPU1
       ----                    ----
  lock(irq_resend_lock);
                               local_irq_disable();
                               lock(&irq_desc_lock_class);
                               lock(irq_resend_lock);
  <Interrupt>
    lock(&irq_desc_lock_class);

...
   _raw_spin_lock+0x2b/0x40
   clear_irq_resend+0x14/0x70
   irq_shutdown_and_deactivate+0x29/0x80
   irq_shutdown_depth_test+0x1ce/0x600
   kunit_try_run_case+0x90/0x120

Grab the descriptor lock and disable interrupts, to resolve the
problem.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/aJJONEIoIiTSDMqc@google.com
Closes: https://lore.kernel.org/lkml/31a761e4-8f81-40cf-aaf5-d220ba11911c@roe=
ck-us.net/
---
 kernel/irq/irq_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index 5161b56..a75abeb 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1+
=20
+#include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
@@ -134,7 +135,8 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	disable_irq(virq);
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
=20
-	irq_shutdown_and_deactivate(desc);
+	scoped_guard(raw_spinlock_irqsave, &desc->lock)
+		irq_shutdown_and_deactivate(desc);
=20
 	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
 	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));


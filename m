Return-Path: <linux-tip-commits+bounces-3384-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9AA38F27
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 23:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C8116B49D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 22:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7A1A4E9E;
	Mon, 17 Feb 2025 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kc+dvkd+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uIGjXqyl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3618B495;
	Mon, 17 Feb 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831761; cv=none; b=VIA3rS+ggscYH6wfpFQ8Iz/Q6gxSVpJkaEqggoI8Os6zR7195KG6XEd4KCxRDBTk5fktRdtpwztZNCctapbU9R0lflVEYA6SQHMocJoystltcIur71zd3+m4MOMR9vXCxqEXMjDVEUEJDGeOY5az1HhrlvWbGMXVqWvlwNUuIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831761; c=relaxed/simple;
	bh=oMICIuWIG6DxASFGtvq1TCWt6gz+3YFNwUR5Td1nUZY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gPWCKx9azxnCbN8yebnw+DQf3AM0DALEU93uUWJo0AsHt5GmSg5EvfG6AjWq4DMLJg99diuQpD5mRexU9ZZHb2m2ai+tHD5Q8e+D+kY3tF5EJacHyXoTnsJe1mwbwC+YBpy6BJLQZF+hGLZAz4CBcD9Ah4noEU0iSh30939TORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kc+dvkd+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uIGjXqyl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 22:35:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739831757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmFmRvLIBNNe2lKaA6QGnqy8aZBZgPT6Hw2gPxP7vxk=;
	b=Kc+dvkd+UDEQTOIgGTaz2Mm+NnPK/huWycnrmqmoFSZiJ+ruXpeVRielR5Sr60Z/Kxumkd
	yHBCk6FPRJ9vvyMF1Rb9Rukw32yC3uek7ep/QenoLm2HiHp8zoGF3Pbv28NSphd0FUJ6Yw
	o/lgdkGnEolpz6HPkx0Lx2I247xcD09WMaNCZnRCjYkhnNMbUno/eixZuD/5Vvj0bkL8dP
	xhRjw/qP9hoynsu0/wrJCGA7og/3HNVs7NWzI96a4oqmW/cz0rXo6TPAv4CIy56vN5nHe9
	QGGY8mrhrvwcJtsVE+JsIiJLwjyRxZm82y8f5l0ueo6YR1FuPwQAtMWZ8uk03A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739831757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmFmRvLIBNNe2lKaA6QGnqy8aZBZgPT6Hw2gPxP7vxk=;
	b=uIGjXqylNth2/B5E1EU8OTII9xTQMUEM9iD28GQklpsGxTncznXY9fog/T2r66N232Ule4
	P79TjU0Jo1AyZECA==
From: "tip-bot2 for Artur Rojek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/jcore-aic, clocksource/drivers/jcore: Fix
 jcore-pit interrupt request
Cc: Artur Rojek <contact@artur-rojek.eu>, Thomas Gleixner <tglx@linutronix.de>,
 Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20250216175545.35079-3-contact@artur-rojek.eu>
References: <20250216175545.35079-3-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173983175288.10177.2680129742009360731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     d7e3fd658248f257006227285095d190e70ee73a
Gitweb:        https://git.kernel.org/tip/d7e3fd658248f257006227285095d190e70ee73a
Author:        Artur Rojek <contact@artur-rojek.eu>
AuthorDate:    Sun, 16 Feb 2025 18:55:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2025 23:27:49 +01:00

irqchip/jcore-aic, clocksource/drivers/jcore: Fix jcore-pit interrupt request

The jcore-aic irqchip does not have separate interrupt numbers reserved for
cpu-local vs global interrupts. Therefore the device drivers need to
request the given interrupt as per CPU interrupt.

69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")
converted the clocksource driver over to request_percpu_irq(), but failed
to do add all the required changes, resulting in a failure to register PIT
interrupts.

Fix this by:

 1) Explicitly mark the interrupt via irq_set_percpu_devid() in
    jcore_pit_init().

 2) Enable and disable the per CPU interrupt in the CPU hotplug callbacks.

 3) Pass the correct per-cpu cookie to the irq handler by using
    handle_percpu_devid_irq() instead of handle_percpu_irq() in
    handle_jcore_irq().

[ tglx: Massage change log ]

Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/all/20250216175545.35079-3-contact@artur-rojek.eu
---
 drivers/clocksource/jcore-pit.c | 15 ++++++++++++++-
 drivers/irqchip/irq-jcore-aic.c |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index a3fe98c..8281542 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -114,6 +114,18 @@ static int jcore_pit_local_init(unsigned cpu)
 	pit->periodic_delta = DIV_ROUND_CLOSEST(NSEC_PER_SEC, HZ * buspd);
 
 	clockevents_config_and_register(&pit->ced, freq, 1, ULONG_MAX);
+	enable_percpu_irq(pit->ced.irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int jcore_pit_local_teardown(unsigned cpu)
+{
+	struct jcore_pit *pit = this_cpu_ptr(jcore_pit_percpu);
+
+	pr_info("Local J-Core PIT teardown on cpu %u\n", cpu);
+
+	disable_percpu_irq(pit->ced.irq);
 
 	return 0;
 }
@@ -168,6 +180,7 @@ static int __init jcore_pit_init(struct device_node *node)
 		return -ENOMEM;
 	}
 
+	irq_set_percpu_devid(pit_irq);
 	err = request_percpu_irq(pit_irq, jcore_timer_interrupt,
 				 "jcore_pit", jcore_pit_percpu);
 	if (err) {
@@ -237,7 +250,7 @@ static int __init jcore_pit_init(struct device_node *node)
 
 	cpuhp_setup_state(CPUHP_AP_JCORE_TIMER_STARTING,
 			  "clockevents/jcore:starting",
-			  jcore_pit_local_init, NULL);
+			  jcore_pit_local_init, jcore_pit_local_teardown);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index b9dcc8e..1f613eb 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -38,7 +38,7 @@ static struct irq_chip jcore_aic;
 static void handle_jcore_irq(struct irq_desc *desc)
 {
 	if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
-		handle_percpu_irq(desc);
+		handle_percpu_devid_irq(desc);
 	else
 		handle_simple_irq(desc);
 }


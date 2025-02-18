Return-Path: <linux-tip-commits+bounces-3495-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B7BA39963
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112413BD755
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE12676F0;
	Tue, 18 Feb 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xQgWIuat";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+cPK3F4+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34F237168;
	Tue, 18 Feb 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874407; cv=none; b=CqZwzFFJTn7E73+sJS1wBSsafBTmcqUudNCJFsGOixdjKi2/EPNfQ3gym+IezRNiMmbVeY/iKkUeNHKUyKobUZxo9QHNVVNPYwPMxXU9eyP6qOjEG/g3aF4WzbdtCD6guaMtozApCZ6RidrXn/3BSu93xEqXd8LMIXC0bG2k9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874407; c=relaxed/simple;
	bh=X9ba10SMTmZ5zLLzkqqvr+rgMlY9CdvHFd17KFo6RKQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IL3H4anZDd/49YatxeG3gIJqLCI0Z10DC2sZZPNGGt3DmPF9lPU+LutgYlpdqxreJKTXcWGLxZt57RNpzK58ebqu6VCMM3cNhIu1IrD+DccjjTEstqwxRTr5o5I9TbC9W8gDlR1KiKCc+6JyLzq41/fiEA9A7MVkLrAT+qbOYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xQgWIuat; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+cPK3F4+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzL35jOq4W8JcbvDiMDKkBYfi7+FBV5i1UxQK3s/Ep4=;
	b=xQgWIuat5t/oB/fytMga6aZ9rL2hGnH2VUgFg4IkE0xj6Kh6nji4u8xzzMZv0ygcEzMBS1
	27x8XrlCeTwsbxykpEKicWIe+SuiAYjL+uh+3xVnJagNxFvK4+bU+3XblgOAiZNBRYU3US
	YnEdM9X/La57fKpWsna/2/p7GrlL57twtwHqqwdxsVOW6JUplYDXJ89iTeANcsf6Edrr7s
	sLQkbpUVAb876/mKudlz22MciOhywR3Yx3oLF3eKG/L9UHJfvsURmLOy8poKGJdZI6Sh6g
	lcNFd0RABbEva1FLGIOTkflayHlv+AckX3va8Fq+BAo8YnaAqTnwlAJLKP26UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzL35jOq4W8JcbvDiMDKkBYfi7+FBV5i1UxQK3s/Ep4=;
	b=+cPK3F4+m4ii7lXBm7HTra8/s4S20jSf8xCMma1Zx0htnwm4kcwY/vw36vttimsR39sf9q
	pk//xYA9oa5CxVBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] usb: typec: tcpm: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7fd2a1f72b3833e1fb36f56f2b28a08c1e64f47e=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C7fd2a1f72b3833e1fb36f56f2b28a08c1e64f47e=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440403.10177.6340130315822872245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     9fdf17c5aa2ccd9f7e6cf23c01f79a1541a9f932
Gitweb:        https://git.kernel.org/tip/9fdf17c5aa2ccd9f7e6cf23c01f79a1541a9f932
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:45:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:02 +01:00

usb: typec: tcpm: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/7fd2a1f72b3833e1fb36f56f2b28a08c1e64f47e.1738746904.git.namcao@linutronix.de

---
 drivers/usb/typec/tcpm/tcpm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6bf1a22..9c455f0 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7721,14 +7721,14 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	kthread_init_work(&port->event_work, tcpm_pd_event_handler);
 	kthread_init_work(&port->enable_frs, tcpm_enable_frs_work);
 	kthread_init_work(&port->send_discover_work, tcpm_send_discover_work);
-	hrtimer_init(&port->state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->state_machine_timer.function = state_machine_timer_handler;
-	hrtimer_init(&port->vdm_state_machine_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->vdm_state_machine_timer.function = vdm_state_machine_timer_handler;
-	hrtimer_init(&port->enable_frs_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->enable_frs_timer.function = enable_frs_timer_handler;
-	hrtimer_init(&port->send_discover_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	port->send_discover_timer.function = send_discover_timer_handler;
+	hrtimer_setup(&port->state_machine_timer, state_machine_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&port->vdm_state_machine_timer, vdm_state_machine_timer_handler,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&port->enable_frs_timer, enable_frs_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&port->send_discover_timer, send_discover_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	spin_lock_init(&port->pd_event_lock);
 


Return-Path: <linux-tip-commits+bounces-3453-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D3BA39872
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C24F3A556A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF522417FC;
	Tue, 18 Feb 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blV4gLqJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5FjhiCO4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B323BF96;
	Tue, 18 Feb 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873215; cv=none; b=VcfKIKxmDU/4Oz1a8sMq5ck6+MemjI0NXa43/gxaVDH/0e8/r0DQeUfpGRBnkEhMPB2RvD4o6turMxzkymFJM2a54STWBhFn18h0XXUiaOvxgxk7XqvraRV9KicRwwtLr5Cta+led/vtptRcpeQdqYirM9118jyuQPNbAwFU21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873215; c=relaxed/simple;
	bh=P1lpki9ZoCwmiPsyIXHjVuJYoVKKT5EqUgK+e4lcfOo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P+U+k7QgnbB6qwJzvDI+KbB/1FqJj8siSs0ssjSsDujXtawVG6OR4XCeC/rsPTG8ghagALI5CKaq5x56X4rbtImZbCXjeWSnMDzEPv4IFMNERhae2+LeXHahbv3EJWpw5Bam3Lnwv6ywPJAOUXKGmSKfsBveyrzvoLp0Yryv2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blV4gLqJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5FjhiCO4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rD98Xh3g5CsSj447vJkjRXH0DOZ8l0VSQKOQ919rFDU=;
	b=blV4gLqJsAhri2C1wGW8v+wDO8Ot/0LYhGyCWOkgGCQmH5hXk9EyD06nNAIGfTCTGdCX0c
	G69LNkkzsmfPoRUj4UdN2Df0yWKYMLnrx28DtqE7/bJcJnxqbTMjJNj62bUUAUvSTT2Td0
	HvaVNlvF3uMgB1pueHQ6i+uWQ9aC2WZ2pKnZb/rKiIORrKnGhF+6m+dg1FfooKEPaK7lgh
	OGdTgwSjaVPHyUkZnNiRdBkCW7IfUloX5sZIfp1/8DRfoeYUJszC1HqOhDkxajscItb3jZ
	BwLPBJSwHotjIhjADts9+Z8FHIhUbIHrkmb1t3iy+aHiUF37nSQYMUzkVrQyRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rD98Xh3g5CsSj447vJkjRXH0DOZ8l0VSQKOQ919rFDU=;
	b=5FjhiCO4s0LKU/wBzLS4yqXwNTc6gvoL2/S1IJT9qqgffp0+VqVhBAmKi1ceX8UcWhZgwi
	lrJkyHnKp6T7/ZDQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] can: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca3a6be42c818722ad41758457408a32163bfd9a0=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca3a6be42c818722ad41758457408a32163bfd9a0=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987321128.10177.13000300129501160127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     806e32248e22582715dbbb7664567b81b9d6928a
Gitweb:        https://git.kernel.org/tip/806e32248e22582715dbbb7664567b81b9d6928a
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:45 +01:00

can: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Most of this patch is generated by Coccinelle. Except for the TX thrtimer
in bcm_tx_setup() because this timer is not used and the callback function
is never set. For this particular case, set the callback to
hrtimer_dummy_timeout()

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/all/a3a6be42c818722ad41758457408a32163bfd9a0.1738746872.git.namcao@linutronix.de

---
 include/linux/hrtimer.h   |  5 +++++
 kernel/time/hrtimer.c     |  5 -----
 net/can/bcm.c             | 20 ++++++++------------
 net/can/isotp.c           | 10 ++++------
 net/can/j1939/bus.c       |  4 ++--
 net/can/j1939/transport.c |  8 ++------
 6 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f7bfdcf..acae379 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -223,6 +223,11 @@ static inline void hrtimer_cancel_wait_running(struct hrtimer *timer)
 }
 #endif
 
+static inline enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
+{
+	return HRTIMER_NORESTART;
+}
+
 /* Exported timer functions: */
 
 /* Initialize timers: */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index deb1aa3..47df6f5 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1597,11 +1597,6 @@ static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 	return HRTIMER_BASE_MONOTONIC;
 }
 
-static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
-{
-	return HRTIMER_NORESTART;
-}
-
 static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 217049f..526cb6c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1011,13 +1011,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		op->ifindex = ifindex;
 
 		/* initialize uninitialized (kzalloc) structure */
-		hrtimer_init(&op->timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->timer.function = bcm_tx_timeout_handler;
+		hrtimer_setup(&op->timer, bcm_tx_timeout_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
 
 		/* currently unused in tx_ops */
-		hrtimer_init(&op->thrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
+		hrtimer_setup(&op->thrtimer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
 
 		/* add this bcm_op to the list of the tx_ops */
 		list_add(&op->list, &bo->tx_ops);
@@ -1192,13 +1191,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		op->rx_ifindex = ifindex;
 
 		/* initialize uninitialized (kzalloc) structure */
-		hrtimer_init(&op->timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->timer.function = bcm_rx_timeout_handler;
-
-		hrtimer_init(&op->thrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->thrtimer.function = bcm_rx_thr_handler;
+		hrtimer_setup(&op->timer, bcm_rx_timeout_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
+		hrtimer_setup(&op->thrtimer, bcm_rx_thr_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
 
 		/* add this bcm_op to the list of the rx_ops */
 		list_add(&op->list, &bo->rx_ops);
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1604693..442c343 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1634,12 +1634,10 @@ static int isotp_init(struct sock *sk)
 	so->rx.buflen = ARRAY_SIZE(so->rx.sbuf);
 	so->tx.buflen = ARRAY_SIZE(so->tx.sbuf);
 
-	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->rxtimer.function = isotp_rx_timer_handler;
-	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->txtimer.function = isotp_tx_timer_handler;
-	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->txfrtimer.function = isotp_txfr_timer_handler;
+	hrtimer_setup(&so->rxtimer, isotp_rx_timer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&so->txtimer, isotp_tx_timer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&so->txfrtimer, isotp_txfr_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
 
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 4866879..39844f1 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -158,8 +158,8 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 	ecu->addr = J1939_IDLE_ADDR;
 	ecu->name = name;
 
-	hrtimer_init(&ecu->ac_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	ecu->ac_timer.function = j1939_ecu_timer_handler;
+	hrtimer_setup(&ecu->ac_timer, j1939_ecu_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
 	INIT_LIST_HEAD(&ecu->list);
 
 	j1939_priv_get(priv);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 9b72d11..fbf5c80 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1511,12 +1511,8 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
 
-	hrtimer_init(&session->txtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	session->txtimer.function = j1939_tp_txtimer;
-	hrtimer_init(&session->rxtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	session->rxtimer.function = j1939_tp_rxtimer;
+	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 
 	netdev_dbg(priv->ndev, "%s: 0x%p: sa: %02x, da: %02x\n",
 		   __func__, session, skcb->addr.sa, skcb->addr.da);


Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72432D9014
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395360AbgLMTXu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbgLMTC1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E8CC061282;
        Sun, 13 Dec 2020 11:01:05 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AeWG2SQxfcs+TMUUv9TjV1ylgX06RcP7ZbJt1qv/sbM=;
        b=BM508yvSdnNxmEqOGx3lqbjZV2F6xZ7DubUV+0h/UCAEHun46WHKwmJfj6cUfuZ/PBkHTv
        D1ZCEtKmxcE2790oB9mUIfDmmezKZ5R71TUtjvc0MxTZZh4P6VjLfxnaY5YLAHsGxqEjKO
        orI1PbnPy2OWShKfyreEONs5cJq2hJeCUSitWjNa6I0vthd667j5hekwaOtHdXZttfjg0T
        E0pvPOIqvDNjJhgFWYWK02oMwrgAwZgxDi+thKA4Vo+vhfB7ft1zOx5hftCq0T4+VXTQcG
        oO59CzHFsrcTQ913uTn4gGIOjbFD6PJPnC/W5s4Rqqtc95c2R1KGNrMOAWeTDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AeWG2SQxfcs+TMUUv9TjV1ylgX06RcP7ZbJt1qv/sbM=;
        b=N9igNXsXmFWt3sfPM+6iFw/rP/3c16MagDK493EBsjCVK2zxRMR4Pw9kmTEpEfbu3MkzSI
        7eJAMztKK25o1kAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Allow rcu_irq_enter_check_tick() from NMI
Cc:     eupm90@gmail.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606372.3364.15335366947329166750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6dbce04d8417ae706596366e16841d77c454ba52
Gitweb:        https://git.kernel.org/tip/6dbce04d8417ae706596366e16841d77c45=
4ba52
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 16 Nov 2020 13:10:12 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:34:17 -08:00

rcu: Allow rcu_irq_enter_check_tick() from NMI

Eugenio managed to tickle #PF from NMI context which resulted in
hitting a WARN in RCU through irqentry_enter() ->
__rcu_irq_enter_check_tick().

However, this situation is perfectly sane and does not warrant an
WARN. The #PF will (necessarily) be atomic and not require messing
with the tick state, so early return is correct.  This commit
therefore removes the WARN.

Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_n=
mi_enter()")
Reported-by: "Eugenio P=C3=A9rez" <eupm90@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef..93e1808 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -928,8 +928,8 @@ void __rcu_irq_enter_check_tick(void)
 {
 	struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
=20
-	 // Enabling the tick is unsafe in NMI handlers.
-	if (WARN_ON_ONCE(in_nmi()))
+	// If we're here from NMI there's nothing to do.
+	if (in_nmi())
 		return;
=20
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),

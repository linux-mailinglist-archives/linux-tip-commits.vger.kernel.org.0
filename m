Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE692342C5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgGaJXY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbgGaJXU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:20 -0400
Date:   Fri, 31 Jul 2020 09:23:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Vgwh3ZjjxoW02xVCuM08ArWybeNvNYs6uTnUfCIOxMc=;
        b=VYEycOsjx11viQJWa0c52WilBOIoaadKWo5tBNlIAeoG2qtIi+BmFnZ5uWH2xv2Z1Lj9VR
        K3Ep12S0eYL/ePAhQEeKft9NJnHrdfRTQdO0x+oG0WJnEJ00+GAlA7bXwClflNUphW5A3Q
        C0//DX9jgIoDJS5XpsiabrVyXQocXbENVnFXbB0/cVCiY1+X4WiALD3hYtOgWA9y2AWTGy
        izU0V7P75LIxQr2P1OWzu0zdzfds9TafiCrJq9clkWCeApR/TdjVO1QbpiJ2QTel+sueXM
        gS/odQCTzIr8olfZBM49OYy/EVK2SHvOXIv9pl91tr9+vsLGIi62VIC4QJL7Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Vgwh3ZjjxoW02xVCuM08ArWybeNvNYs6uTnUfCIOxMc=;
        b=rufF4nK2xozWBir+x/Pce9++VFnT0+me9q6fgBLuPXCPseYD+i21mmTXjqACrYyc/BLq/v
        nB3AFHwWm+2O/YBw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tiny: support vmalloc in tiny-RCU
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739853.4006.8750094199097034951.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     64d1d06ccb1b7de245ccf781b91517f328bebd9f
Gitweb:        https://git.kernel.org/tip/64d1d06ccb1b7de245ccf781b91517f328bebd9f
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:54 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tiny: support vmalloc in tiny-RCU

Replace kfree() with kvfree() in rcu_reclaim_tiny().
This makes it possible to release either SLAB or vmalloc
objects after a GP.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tiny.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dd572ce..4b99f7b 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/prefetch.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 #include "rcu.h"
 
@@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	rcu_lock_acquire(&rcu_callback_map);
 	if (__is_kfree_rcu_offset(offset)) {
 		trace_rcu_invoke_kfree_callback("", head, offset);
-		kfree((void *)head - offset);
+		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
 	}

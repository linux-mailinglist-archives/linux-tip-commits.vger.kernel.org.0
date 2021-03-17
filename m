Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4621633F46A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhCQPt3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhCQPs6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:58 -0400
Date:   Wed, 17 Mar 2021 15:48:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9x+FyJLzjd3GfH1PbsDf89B6OuvZz4A+c4a4E5E9ew=;
        b=dWTcd7oajPlYeHr0GHgcd5IJ2BiibiaCqyt37qTw3+6WZwUA9TDn//51VGC7P6h06PVYbl
        /D9aycE/FrURkIObOJjVIWRJmGYNlfmyyDee4FeLCeuQvWNRiATdRS0epiKA+N72Ft/w6C
        dGToOIkqNH5gK27K30929LQZskKH2AyoyC9aTszQ/kIflBJgboGVYjfhYTyQ80+nzbwnoW
        JhIEKN1lLYBierJwFdChVEM3eRGhmut9xQWoQ45OfDAY3bmSAVDF7KItsc67+Aa0N6pOpV
        og70KRJNFgV6mtodde1KKgnpHYzUi4t4DDgxNIJOC1XRmoa3snzk9I0Jd630KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9x+FyJLzjd3GfH1PbsDf89B6OuvZz4A+c4a4E5E9ew=;
        b=fiIv8g7m7qXMpeoIciFmuSjKj926vaTUBIwwvsRKY1S/3x8xrHsSb2gpsxMlnRK4DLGrXB
        4QYzkm1rhOY+BKCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ath9k: Use tasklet_disable_in_atomic()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084242.313899703@linutronix.de>
References: <20210309084242.313899703@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613681.398.13526096212765880377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3250aa8a293b1859d76577714a3e1fe95732c721
Gitweb:        https://git.kernel.org/tip/3250aa8a293b1859d76577714a3e1fe95732c721
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:02 +01:00

ath9k: Use tasklet_disable_in_atomic()

All callers of ath9k_beacon_ensure_primary_slot() are preemptible /
acquire a mutex except for this callchain:

  spin_lock_bh(&sc->sc_pcu_lock);
  ath_complete_reset()
  -> ath9k_calculate_summary_state()
     -> ath9k_beacon_ensure_primary_slot()

It's unclear how that can be distangled, so use tasklet_disable_in_atomic()
for now. This allows tasklet_disable() to become sleepable once the
remaining atomic users are cleaned up.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084242.313899703@linutronix.de

---
 drivers/net/wireless/ath/ath9k/beacon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index 71e2ada..72e2e71 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -251,7 +251,7 @@ void ath9k_beacon_ensure_primary_slot(struct ath_softc *sc)
 	int first_slot = ATH_BCBUF;
 	int slot;
 
-	tasklet_disable(&sc->bcon_tasklet);
+	tasklet_disable_in_atomic(&sc->bcon_tasklet);
 
 	/* Find first taken slot. */
 	for (slot = 0; slot < ATH_BCBUF; slot++) {

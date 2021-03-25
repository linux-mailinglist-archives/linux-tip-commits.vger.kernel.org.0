Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49E03497FE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 18:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYR1z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 13:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhCYR1g (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 13:27:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D15C06174A;
        Thu, 25 Mar 2021 10:27:33 -0700 (PDT)
Date:   Thu, 25 Mar 2021 17:27:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616693252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJTRqgUtW7Eyw6qr1jbu08J47m9lxS5iWAogm3GSpig=;
        b=ZlRvkk6dOme6gCBdYz3IsWGecKmqaZUPS7jRlly5fT9EZRC1HuhtkJurA9qob9Cw3eTddw
        dIuXjrgBAVTyocbBHe7b1wr8oJmBkcfGzr9fG7mlrZw7+ndOnNXEwzuGncqFgdktJ3qFv0
        LeJr8yK77Wk5hJE7EV8451rSAzOCgmr2UnNsXY6iv9MjzvkJIfzf/fUjl3l9lJbbn8/LnP
        YtEM7XyW1t+BHWT82a28uNoc8trggrMBVOalywX80ixWeHG+KT+EZ/2KC3ynAbS0jK4WE0
        aoiVAC2ghCyFHJMRKXVeLPHX4t71JLLmOees+I7BKfQz/1OAj2Y9A1TDlSZPIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616693252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJTRqgUtW7Eyw6qr1jbu08J47m9lxS5iWAogm3GSpig=;
        b=HOsA/eP5yVIX9qTylzVI/qRW/GkjuafAw0t0QeKBgs1g4swTfzGeRZREubhmU29RH+bO00
        32Dy5ZwakaUDnfCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] drm/i915: Use tasklet_unlock_spin_wait() in
 __tasklet_disable_sync_once()
Cc:     kernel test robot <oliver.sang@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210323092221.awq7g5b2muzypjw3@flow>
References: <20210323092221.awq7g5b2muzypjw3@flow>
MIME-Version: 1.0
Message-ID: <161669325149.398.2210216936273918999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6e457914935a3161eeb74e319abf9fd511aa1e4d
Gitweb:        https://git.kernel.org/tip/6e457914935a3161eeb74e319abf9fd511aa1e4d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 10:22:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Mar 2021 18:21:03 +01:00

drm/i915: Use tasklet_unlock_spin_wait() in __tasklet_disable_sync_once()

The i915 driver has its own tasklet interface which was overseen in the
tasklet rework. __tasklet_disable_sync_once() is a wrapper around
tasklet_unlock_wait(). tasklet_unlock_wait() might sleep, but the i915
wrappers invokes it from non-preemtible contexts with bottom halves disabled.

Use tasklet_unlock_spin_wait() instead which can be invoked from
non-preemptible contexts.

Fixes: da044747401fc ("tasklets: Replace spin wait in tasklet_unlock_wait()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210323092221.awq7g5b2muzypjw3@flow
---
 drivers/gpu/drm/i915/i915_gem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
index e622aee..440c35f 100644
--- a/drivers/gpu/drm/i915/i915_gem.h
+++ b/drivers/gpu/drm/i915/i915_gem.h
@@ -105,7 +105,7 @@ static inline bool tasklet_is_locked(const struct tasklet_struct *t)
 static inline void __tasklet_disable_sync_once(struct tasklet_struct *t)
 {
 	if (!atomic_fetch_inc(&t->count))
-		tasklet_unlock_wait(t);
+		tasklet_unlock_spin_wait(t);
 }
 
 static inline bool __tasklet_is_enabled(const struct tasklet_struct *t)

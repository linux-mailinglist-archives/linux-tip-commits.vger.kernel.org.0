Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E846432C779
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349925AbhCDAcF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350064AbhCCIQp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 03:16:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7BAC061793;
        Wed,  3 Mar 2021 00:16:01 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614759359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KS76QJybmSg5e/fjqFjX6w1OpnhCzFgC4r1JyNgxdps=;
        b=rSoZ14lvW9oju/0ebD3qBjHLEtkT3H42SV3tVoClqMR8AzxK5NfdEJtSbhj01HCHDLMHMf
        KE4KXrp/nxqOa8QjTRgcgHPBcN6zvZGJqp4lFDz1CwJFdEcqH71e2+/NV6xO7yHmd+3W/3
        6d9aWh8H/AG6rSLVMBnS2ZT+a8xYYHoCHstRLBIYlMyVYbWRK4PgGlEwJvm4ToqxMUnSag
        vUPJ+BA8es2qQPgioeKv9uUNi1P89RS+xERlnVHlsvRWFV99Z2ufK/3heO8Al6WGLDMGMr
        Dmz6bOWF21BA73VQTspK35On01DuvBCcuwbR41G/f6SforhDB7giVfdrfqdBEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614759359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KS76QJybmSg5e/fjqFjX6w1OpnhCzFgC4r1JyNgxdps=;
        b=EMe51mkICoSE8Qs+Oj7gcof1oR5yMXia+b34stFx/a2UxwdXKUNBMjpn1J0d8r0R8HstgS
        abgBaHiJ38bF5bBQ==
From:   "tip-bot2 for Shuah Khan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] ath10k: Detect conf_mutex held ath10k_drain_tx() calls
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kalle Valo <kvalo@codeaurora.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161475935878.20312.1052815878297335176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     de469d82991b905548b5dc6539177f7b881dce1b
Gitweb:        https://git.kernel.org/tip/de469d82991b905548b5dc6539177f7b881dce1b
Author:        Shuah Khan <skhan@linuxfoundation.org>
AuthorDate:    Fri, 26 Feb 2021 17:07:00 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 02 Mar 2021 15:06:35 +01:00

ath10k: Detect conf_mutex held ath10k_drain_tx() calls

ath10k_drain_tx() must not be called with conf_mutex held as workers can
use that also. Add call to lockdep_assert_not_held() on conf_mutex to
detect if conf_mutex is held by the caller.

The idea for this patch stemmed from coming across the comment block
above the ath10k_drain_tx() while reviewing the conf_mutex holds during
to debug the conf_mutex lock assert in ath10k_debug_fw_stats_request().

Adding detection to assert on conf_mutex hold will help detect incorrect
usages that could lead to locking problems when async worker routines try
to call this routine.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/linux-wireless/871rdmu9z9.fsf@codeaurora.org/
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index bb6c5ee..5ce4f8d 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4727,6 +4727,8 @@ out:
 /* Must not be called with conf_mutex held as workers can use that also. */
 void ath10k_drain_tx(struct ath10k *ar)
 {
+	lockdep_assert_not_held(&ar->conf_mutex);
+
 	/* make sure rcu-protected mac80211 tx path itself is drained */
 	synchronize_net();
 

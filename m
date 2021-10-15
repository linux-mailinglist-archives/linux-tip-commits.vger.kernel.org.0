Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9C42EEA6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhJOKSg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 06:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbhJOKSe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 06:18:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE5C061753;
        Fri, 15 Oct 2021 03:16:27 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:16:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634292986;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Bmg97JKUcyzet1kFgFTdjKQLYMVhBefL/dVN2V8koko=;
        b=UKgjm7y1mpk8tYuNjuIEz7E8iqsgffL/+qIKA0NJ7ZeM/KweXe1Sv2j6i5kDitYgqenbp2
        TwwP28jYzZzd2orBDae9+wFe8N7rCC97LsTQWKHxELN6NzCuVcQWsHaHPf4/nPY2e0mfZ0
        56hFP+C1GnjEGzcDjoXh0RE4mLVLnGqdQPdunzq0NCX7OULTwL/+CMScBfbMPP5soTQ8zn
        wyVtBb9zqUcUECHZQPSmW5+OVxf9T+B/UTopzMFmcJBfgMG1ccNCjBbT07jcstzyrvh35y
        7NDwWhXbMfl/5yK7Su68dGUb3fJClGPF9o2qSL/60NPD95+zoUjj2OesWzPwWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634292986;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Bmg97JKUcyzet1kFgFTdjKQLYMVhBefL/dVN2V8koko=;
        b=VHUmMbc479fjKwZTNvEbUieIvvig4c1Pyl+ifGLRgwhAbxFAg/RhfHekVLaHJvHTU3Kn7r
        NC9UutRKfIMp8mBQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: Disable runtime services on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163429298558.25758.6363484092944199023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     d9f283ae71afef6560a7101c0a31d7ddb5b0f29a
Gitweb:        https://git.kernel.org/tip/d9f283ae71afef6560a7101c0a31d7ddb5b0f29a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 24 Sep 2021 15:49:18 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 28 Sep 2021 22:43:53 +02:00

efi: Disable runtime services on RT

Based on measurements the EFI functions get_variable /
get_next_variable take up to 2us which looks okay.
The functions get_time, set_time take around 10ms. These 10ms are too
much. Even one ms would be too much.
Ard mentioned that SetVariable might even trigger larger latencies if
the firmware will erase flash blocks on NOR.

The time-functions are used by efi-rtc and can be triggered during
run-time (either via explicit read/write or ntp sync).

The variable write could be used by pstore.
These functions can be disabled without much of a loss. The poweroff /
reboot hooks may be provided by PSCI.

Disable EFI's runtime wrappers on PREEMPT_RT.

This was observed on "EFI v2.60 by SoftIron Overdrive 1000".

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 847f33f..39031cf 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -66,7 +66,7 @@ struct mm_struct efi_mm = {
 
 struct workqueue_struct *efi_rts_wq;
 
-static bool disable_runtime;
+static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime = true;

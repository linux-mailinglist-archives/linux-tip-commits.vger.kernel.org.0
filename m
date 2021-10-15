Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE0542EEA5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbhJOKSg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 06:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbhJOKSe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 06:18:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B1C061570;
        Fri, 15 Oct 2021 03:16:27 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:16:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634292985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WCSTvxdrXbhAIHCaAWoTOpxHvcWPVmoArS0PESVVgDk=;
        b=ocgh6cBBdTSOEuUdccFrUnRgG/jcAxH8aB05+/nfEJCKFjMGpe28AVAq5Q9pQeBZpnAf0C
        xzvP0tz1bpfOYMkFyy3LHr/qNtD2CNVp3SvluB63wppU0A6A24x9bZFh2zC0wv6V335SPe
        1GONh0qOYEFcXn+xZxp+8YaOlTXYY27fDCM8+cMctLa0UZBpPgieW9eFyENjTosi5XHIRl
        Upt0CtUwI4ASXhb8HHeszUWMRZ4aPWkVfRekxN6Uwt0fh14ndkOxd4mCRNyx6nrLmqVzPC
        wofGCnOpO1jluO2X0kWWlT6b34Bc6xkSYW5i8kc/zpSJinGpXdJLlwtSsjm6NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634292985;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WCSTvxdrXbhAIHCaAWoTOpxHvcWPVmoArS0PESVVgDk=;
        b=I2og/HW/AelwSJo8H99VwO4aImOs3c5AGvGvbvwPhqFwxVD0+YmWnQPlfJNCLgUouHfOBk
        dPAcCTt94jH4U4Bg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: Allow efi=runtime
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163429298458.25758.4664663159209860167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     720dff78de360ad9742d5f438101cedcdb5dad84
Gitweb:        https://git.kernel.org/tip/720dff78de360ad9742d5f438101cedcdb5dad84
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 24 Sep 2021 15:49:19 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 28 Sep 2021 22:44:15 +02:00

efi: Allow efi=runtime

In case the command line option "efi=noruntime" is default at built-time, the user
could overwrite its state by `efi=runtime' and allow it again.

This is useful on PREEMPT_RT where "efi=noruntime" is default and the
user might need to alter the boot order for instance.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 39031cf..ae79c33 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -97,6 +97,9 @@ static int __init parse_efi_cmdline(char *str)
 	if (parse_option_str(str, "noruntime"))
 		disable_runtime = true;
 
+	if (parse_option_str(str, "runtime"))
+		disable_runtime = false;
+
 	if (parse_option_str(str, "nosoftreserve"))
 		set_bit(EFI_MEM_NO_SOFT_RESERVE, &efi.flags);
 

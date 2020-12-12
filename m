Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9162D88B3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 18:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395314AbgLLRja (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 12:39:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42210 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404003AbgLLRja (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 12:39:30 -0500
Date:   Sat, 12 Dec 2020 17:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607794728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zV7CVjbm1+62mfzyN4V2sX30rOJ3HjcrXX4B0n7Q9mc=;
        b=1+egzGW+FvrcStBHPl7mTNG4i72dDuUrxHEqnV5nTCZsICjZtabNuGX8ZT5OZ2LFxTmZZG
        Xz2e+i/Kbhz/Sl0xtO6cwhaFvEc/3eCabbiA2o7TqU8a/DOb4gmhGB7MwSBQX5+1lGnmHr
        P2EjkrPnzZYI5jIFFbfdZiFbKYGyoarmmHj/1XS+uk12jsgowBsk7grGqIMZCj/JjAirFQ
        LuOdVEgMpwyDzJowb9LCUOs0xny2uOBGxRtb6CHRA+DUYXITN44ZizuVhQYdaYYdP3lO2Q
        CjSsrCrC/KqObtFUei3ITYwZVjFElTxxfUVrW4GO22oGXYzHeRNv+7sfVn519A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607794728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zV7CVjbm1+62mfzyN4V2sX30rOJ3HjcrXX4B0n7Q9mc=;
        b=T/Cfj/57o5yux0DSGol6VVj8HnLZrbRdexJNcZGs7r07o8/px5H+rG8xtsTj+DKr+n+pg5
        Kxs8Nwf/nFAnl5CQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Fix build error
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160779472752.3364.6530360000037468284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a3356a079da268cd35460d9bfe052c74383e179b
Gitweb:        https://git.kernel.org/tip/a3356a079da268cd35460d9bfe052c74383e179b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 12 Dec 2020 18:29:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Dec 2020 18:35:12 +01:00

ntp: Fix build error

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/timekeeping.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7f7e4a3..929d3f3 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -303,6 +303,8 @@ extern int persistent_clock_is_local;
 extern void read_persistent_clock64(struct timespec64 *ts);
 void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
 					  struct timespec64 *boot_offset);
+#ifdef CONFIG_GENERIC_CMOS_UPDATE
 extern int update_persistent_clock64(struct timespec64 now);
+#endif
 
 #endif

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42723EFE6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbhHRH7Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38746 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbhHRH7U (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:20 -0400
Date:   Wed, 18 Aug 2021 07:58:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lm0+YvosZA+mPmYVfDrw8nP5X2a9say5Sge1QxrmI2U=;
        b=AuJQR4CBO6VJ3qzJYMnJBdq8zQlg4j3ynrxaCpwWibdoElylroAx8927qtEtbZ/GsPr7e7
        kF/zvzHIrbuE39ZCiLk8itAgwBIE2Ptz/Fd02pF5+cwJxrwEpVypu/KZrS77IuICroAzzd
        U/vz9fZxWznuCRQTqE9PffvX3FLliQflO/ZBoqGsslFDzR+OEZ3VlIsvtAnqwAF7pAPK0d
        Ybt6xvxaqAAIuBaI5MomT1NoSnZ1ieFJB4vqB1d357at/1wEcvBImdGwNhHcp1SiuNiRD4
        XCp1LlAvZZZWDpoPpaFbOr5vC4rCTBOeBwtrPqUtjLuz6CH5U58FdKs4y/JpIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lm0+YvosZA+mPmYVfDrw8nP5X2a9say5Sge1QxrmI2U=;
        b=iUKxjgMuesclxzesufJJIGHDaBRK+WBD0TTfEKhYpSFCSyh+RNDv/B629BaXQcaqP1MLVr
        2jD8YJJJxWfLtHDg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] kcsan: Print if strict or non-strict during init
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352347.25758.7867881825400913039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     9c827cd1fcdf54bb50f874f91af0d5de2aceb035
Gitweb:        https://git.kernel.org/tip/9c827cd1fcdf54bb50f874f91af0d5de2aceb035
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 07 Jun 2021 14:56:52 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:49:44 -07:00

kcsan: Print if strict or non-strict during init

Show a brief message if KCSAN is strict or non-strict, and if non-strict
also say that CONFIG_KCSAN_STRICT=y can be used to see all data races.

This is to hint to users of KCSAN who blindly use the default config
that their configuration might miss data races of interest.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 439edb9..76e67d1 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -656,6 +656,15 @@ void __init kcsan_init(void)
 		pr_info("enabled early\n");
 		WRITE_ONCE(kcsan_enabled, true);
 	}
+
+	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) ||
+	    IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) ||
+	    IS_ENABLED(CONFIG_KCSAN_PERMISSIVE) ||
+	    IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {
+		pr_warn("non-strict mode configured - use CONFIG_KCSAN_STRICT=y to see all data races\n");
+	} else {
+		pr_info("strict mode configured\n");
+	}
 }
 
 /* === Exported interface =================================================== */

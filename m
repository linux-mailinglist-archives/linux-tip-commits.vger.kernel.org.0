Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E223380A05
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 May 2021 14:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhENNAR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 May 2021 09:00:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36628 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhENNAQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 May 2021 09:00:16 -0400
Date:   Fri, 14 May 2021 12:59:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620997144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RA5xS7f4ejLOEDBZcWJrzacApLY1RiYGUqm+bDE3Dwo=;
        b=q6q6xWYFlYi5/qUm+M2dd1NNSxzYLkhm0VEfqb/Y5LsJi7wLVYZRSnkFIaLU1U/a8LXcMd
        P5iYJ3am3mxjGPsTDr58yocT9Z5TjnMi7cJdHs5QK5tIPTmV5NeYAljtPOmNzWt0afrpIf
        +kHNRkaEdSBZGsignH0yHvGbfqLlcNucW8SkkXFc8s+6397/4D1GpFBq5NgxEAhGVlybox
        rMgSkpGVLoGCWlppb/WhCr9X91DJcqtYdmtMjpMFbbQgR93nvG7VmSWsGfxwyvQmHRH0ud
        Q8eQPVZjjicSqqRnzVEzVDON048fUXNHFmM7ElIHAIx05Ep+ou0YJJf0DRENHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620997144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RA5xS7f4ejLOEDBZcWJrzacApLY1RiYGUqm+bDE3Dwo=;
        b=xOTuOEoEVaS1hooCBmbAEPWUEZs0zoTBcsPUbKO5Ry/bwyAeop48aAzF5NE0d2FF3/fxXp
        qGzXsqCPMSG3H0BQ==
From:   "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/hyper-v: Re-enable
 VDSO_CLOCKMODE_HVCLOCK on X86
Cc:     Mohammed Gamal <mgamal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210513073246.1715070-1-vkuznets@redhat.com>
References: <20210513073246.1715070-1-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <162099714364.29796.11946407878774637795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     3486d2c9be652a31033363bdd50391b0c8a8fe21
Gitweb:        https://git.kernel.org/tip/3486d2c9be652a31033363bdd50391b0c8a8fe21
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Thu, 13 May 2021 09:32:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 May 2021 14:55:13 +02:00

clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86

Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=213029)
the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
differences inline") broke vDSO on x86. The problem appears to be that
VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
'#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
a define).

Use a dedicated HAVE_VDSO_CLOCKMODE_HVCLOCK define instead.

Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO differences inline")
Reported-by: Mohammed Gamal <mgamal@redhat.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20210513073246.1715070-1-vkuznets@redhat.com

---
 arch/x86/include/asm/vdso/clocksource.h | 2 ++
 drivers/clocksource/hyperv_timer.c      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/vdso/clocksource.h b/arch/x86/include/asm/vdso/clocksource.h
index 119ac86..136e5e5 100644
--- a/arch/x86/include/asm/vdso/clocksource.h
+++ b/arch/x86/include/asm/vdso/clocksource.h
@@ -7,4 +7,6 @@
 	VDSO_CLOCKMODE_PVCLOCK,	\
 	VDSO_CLOCKMODE_HVCLOCK
 
+#define HAVE_VDSO_CLOCKMODE_HVCLOCK
+
 #endif /* __ASM_VDSO_CLOCKSOURCE_H */
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 977fd05..d6ece7b 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 }
 
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
@@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 	.enable = hv_cs_enable,
 	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
 #else

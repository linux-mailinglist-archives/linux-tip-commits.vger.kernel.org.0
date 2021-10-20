Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE03A434C74
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhJTNrX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhJTNrB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:47:01 -0400
Date:   Wed, 20 Oct 2021 13:44:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnXI+ysx+QDUdlMwf6E2T5DsGdSWlq9U7Y+xXwIxxBA=;
        b=xTz/W2E9/awV1W1KJvgFunD1MGN3UP9kAskx0pPwWWyxrYUGXVwGaStAD6TrfobwuKKi4x
        PMC7GsnElVElJtwTWGhL13JPITWvzfddP5RxLvFOYQzZtk5Ier4KR+WapQST0lZOPzUCgK
        wYH+MQr8mWp7b+mab8FQbmnzyydKRHezFMX7H1GKHlky8QkLMqU208r+DizX7NGMsCS0SL
        +AgVTTsDFZL1DfBeLsnsj0biKPlBGVejTN6jD+g1AqvVGcnPl+4ja4MaUsYYcqf5cIULzi
        Pmfn+fAk1c/8b6cq0WyBK+yhM1ZMm18orB9WvCGOJGkUnIrjJK8AfBEApSBz3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnXI+ysx+QDUdlMwf6E2T5DsGdSWlq9U7Y+xXwIxxBA=;
        b=eFTcaR622UmGAHVs2SbMvBsj0/ilPeo+8EB8U2zUHHYLu8AlulkcIG2pF0CD7U2UgX46K1
        MQ5qpfFcHXoJG2DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/pkru: Remove useless include
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.551522694@linutronix.de>
References: <20211015011538.551522694@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748504.25758.16064094593650594112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b50854eca0e014c2d3738073b387ab8ec85118ab
Gitweb:        https://git.kernel.org/tip/b50854eca0e014c2d3738073b387ab8ec85118ab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:15:57 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:25 +02:00

x86/pkru: Remove useless include

PKRU code does not need anything from FPU headers. Include cpufeature.h
instead and fixup the resulting fallout in perf.

This is a preparation for FPU changes in order to prevent recursive include
hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.551522694@linutronix.de
---
 arch/x86/events/perf_event.h | 1 +
 arch/x86/include/asm/pkru.h  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c..134c08d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -14,6 +14,7 @@
 
 #include <linux/perf_event.h>
 
+#include <asm/fpu/xstate.h>
 #include <asm/intel_ds.h>
 #include <asm/cpu.h>
 
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index ccc539f..4cd49af 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PKRU_H
 #define _ASM_X86_PKRU_H
 
-#include <asm/fpu/xstate.h>
+#include <asm/cpufeature.h>
 
 #define PKRU_AD_BIT 0x1
 #define PKRU_WD_BIT 0x2

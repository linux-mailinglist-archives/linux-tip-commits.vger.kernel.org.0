Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4763737537E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhEFMPL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhEFMPF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:05 -0400
Date:   Thu, 06 May 2021 12:14:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVKmbkvq/YAvlyOKbAQxcTBG+xVjqmu+cXkIWMfVhWU=;
        b=GZBs3fZP90rnVhA53CIYdR2Ij3y+WuvjrDt7zrFctSGtPiD5HbUbJhaTnzesSGgYyZL0xD
        +AzUBm1pSXbY/WHuZ5xyvmo6SsP8G8UwepbxUj4h+qEdZjGg5r2X0q7NknuNWiXbpk30oQ
        /TNTKoD0ReRHx04H7Fbg7++z0/G2h5lsQmw7ofMz2GyJOBaiCEEzNVmnbIh6ywY0kO85Ki
        t5sTg43rJtem8N4bVNhV/ztkaD5OF3X0zdwhEwz82M+1lhcSuFieUjY1SqCm3j/ibFwHmj
        uWd1+M7a4l1n1cFFInSNdHLJAVZbDEqtNcCeBWrjxhvEFkl2AI1r1L+yjrQ0Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVKmbkvq/YAvlyOKbAQxcTBG+xVjqmu+cXkIWMfVhWU=;
        b=IIBNrK8CdzUW3qHXnF2MqJE/f3Or/eagb6jkW7FE3frL/4VXO2uFlj+fQwbOXEbg8Y8hMq
        hYpynHorKGaz2YBQ==
From:   "tip-bot2 for Wanpeng Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] context_tracking: Move guest exit vtime accounting
 to separate helpers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <seanjc@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505002735.1684165-3-seanjc@google.com>
References: <20210505002735.1684165-3-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <162030324513.29796.12806725485526292547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     88d8220bbf06dd8045b2ac4be1046290eaa7773a
Gitweb:        https://git.kernel.org/tip/88d8220bbf06dd8045b2ac4be1046290eaa7773a
Author:        Wanpeng Li <wanpengli@tencent.com>
AuthorDate:    Tue, 04 May 2021 17:27:29 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 22:54:11 +02:00

context_tracking: Move guest exit vtime accounting to separate helpers

Provide separate vtime accounting functions for guest exit instead of
open coding the logic within the context tracking code.  This will allow
KVM x86 to handle vtime accounting slightly differently when using
tick-based accounting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Link: https://lore.kernel.org/r/20210505002735.1684165-3-seanjc@google.com

---
 include/linux/context_tracking.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index b8c7313..4f45562 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -137,15 +137,20 @@ static __always_inline void context_tracking_guest_exit(void)
 		__context_tracking_exit(CONTEXT_GUEST);
 }
 
-static __always_inline void guest_exit_irqoff(void)
+static __always_inline void vtime_account_guest_exit(void)
 {
-	context_tracking_guest_exit();
-
-	instrumentation_begin();
 	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_exit(current);
 	else
 		current->flags &= ~PF_VCPU;
+}
+
+static __always_inline void guest_exit_irqoff(void)
+{
+	context_tracking_guest_exit();
+
+	instrumentation_begin();
+	vtime_account_guest_exit();
 	instrumentation_end();
 }
 
@@ -166,12 +171,17 @@ static __always_inline void guest_enter_irqoff(void)
 
 static __always_inline void context_tracking_guest_exit(void) { }
 
+static __always_inline void vtime_account_guest_exit(void)
+{
+	vtime_account_kernel(current);
+	current->flags &= ~PF_VCPU;
+}
+
 static __always_inline void guest_exit_irqoff(void)
 {
 	instrumentation_begin();
 	/* Flush the guest cputime we spent on the guest */
-	vtime_account_kernel(current);
-	current->flags &= ~PF_VCPU;
+	vtime_account_guest_exit();
 	instrumentation_end();
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */

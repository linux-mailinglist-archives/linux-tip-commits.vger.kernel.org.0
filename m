Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22AE191CDA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 23:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgCXWdc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 18:33:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46425 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgCXWc0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5v-0006xI-BJ; Tue, 24 Mar 2020 23:32:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 23E0D1C0493;
        Tue, 24 Mar 2020 23:32:21 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:20 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/kvm: Convert to new CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131509.136884777@linutronix.de>
References: <20200320131509.136884777@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508914081.28353.655072271128512572.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     320debe5ef6d4990a70535b5cf891472e6e14d93
Gitweb:        https://git.kernel.org/tip/320debe5ef6d4990a70535b5cf891472e6e14d93
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:50 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:27:29 +01:00

x86/kvm: Convert to new CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131509.136884777@linutronix.de
---
 arch/x86/kvm/svm.c     | 2 +-
 arch/x86/kvm/vmx/vmx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 5753fc3..7c959ae 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -59,7 +59,7 @@ MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
 static const struct x86_cpu_id svm_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_SVM),
+	X86_MATCH_FEATURE(X86_FEATURE_SVM, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, svm_cpu_id);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 31c80fa..5b017ef 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -66,7 +66,7 @@ MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
 
 static const struct x86_cpu_id vmx_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_VMX),
+	X86_MATCH_FEATURE(X86_FEATURE_VMX, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, vmx_cpu_id);

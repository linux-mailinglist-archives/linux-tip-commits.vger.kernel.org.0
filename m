Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA2E37BA72
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhELK3s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50560 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhELK3j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:39 -0400
Date:   Wed, 12 May 2021 10:28:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UHXKCObtPjBsaIewS+lWuVHbm3jNlFOs2DYp5P4drc=;
        b=tmYP7UM1z8YpjPZC/C9Ivdg+NGqfZahb1+9ZpYi9zNLkF+LHT6P81pVH4vaDajrYnxr+E+
        qz6Ui1aFH93+IjIfcQnW/YFcwmMlDgKmTX1dK9TaR6fe6QFO9t6b8Sa1NDWaK8r3aiugLx
        OLx8NiYzSZ951ABfMDEA3RI5iFFqzykmhzoPnw2zuyJ4rOkI4RzPZHwU9aQRpeTmDMNb/v
        j79jtf6+VNJI6izfJLfs7YdDi0+bBch4cIs9TApQUHR4Pgw5Umt8bE7kM9YH8aq7JVbL4F
        KNo0s6GS2U0HJ/ztgIal3a87Bic2WqU49ZFUOHSk9CEZgoqSISK8gAeGt54gdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UHXKCObtPjBsaIewS+lWuVHbm3jNlFOs2DYp5P4drc=;
        b=AGVWuNpjisBC3b/1wuIeqkMZZuT2r50MwZcc4xT196C/1e2Bhg+uZn/aFGs725BSygwcZ2
        1v6X7FSpZpDfIzDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505111525.187225172@infradead.org>
References: <20210505111525.187225172@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530990.29796.11497571349080467949.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     63b3f96e1a989846a5a521d4fbef4bc86406929d
Gitweb:        https://git.kernel.org/tip/63b3f96e1a989846a5a521d4fbef4bc86406929d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 May 2021 22:43:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:24 +02:00

kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT

AFAICT KVM only relies on SCHED_INFO. Nothing uses the p->delays data
that belongs to TASK_DELAY_ACCT.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Link: https://lkml.kernel.org/r/20210505111525.187225172@infradead.org
---
 arch/arm64/kvm/Kconfig | 5 +----
 arch/x86/kvm/Kconfig   | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 3964acf..a4eba09 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -20,8 +20,6 @@ if VIRTUALIZATION
 menuconfig KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on OF
-	# for TASKSTATS/TASK_DELAY_ACCT:
-	depends on NET && MULTIUSER
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
@@ -38,8 +36,7 @@ menuconfig KVM
 	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
-	select TASKSTATS
-	select TASK_DELAY_ACCT
+	select SCHED_INFO
 	help
 	  Support hosting virtualized guest machines.
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index f6b93a3..fb8efb3 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -22,8 +22,6 @@ config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
 	depends on HIGH_RES_TIMERS
-	# for TASKSTATS/TASK_DELAY_ACCT:
-	depends on NET && MULTIUSER
 	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
 	select MMU_NOTIFIER
@@ -36,8 +34,7 @@ config KVM
 	select KVM_ASYNC_PF
 	select USER_RETURN_NOTIFIER
 	select KVM_MMIO
-	select TASKSTATS
-	select TASK_DELAY_ACCT
+	select SCHED_INFO
 	select PERF_EVENTS
 	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT

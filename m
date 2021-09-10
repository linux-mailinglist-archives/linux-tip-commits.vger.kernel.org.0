Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3BD407379
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Sep 2021 00:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhIJWq0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Sep 2021 18:46:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41358 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIJWq0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Sep 2021 18:46:26 -0400
Date:   Fri, 10 Sep 2021 22:45:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631313913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Czemq6M7VuzZauK9Ub7w1sd6p0om74tLjiFnNA9SH4=;
        b=u6l/cH754WFAEbhQi3ggKTM8r4Aw3NgFMYo+Lw0slTSKfKXhO+CoyWDOW4G60VpgXcwess
        Fc6aTLlQjodjoySKVrN3+gHOmg0CE81PhPaMAZZ0eo6YYZwFFZYddjMpxQQNK2irANnefV
        8oRjCoDNr/BZKLvqAoPPTAiPMcf6b32RNamt1r+tO0p5i6jWWq6q01tRCDjtYPby66CF+9
        l6bOrX8H84hnCNXZG1gh0J2H1Ce4X045kGWVe1bSaH+saC4ABG8rEpoLec6ghJiEsuTMgk
        6kZ0Zrizv7Ah8HfV2k102e81wREojaimd/4PcApYLjrZEa7Vtkli7UHlZId1Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631313913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Czemq6M7VuzZauK9Ub7w1sd6p0om74tLjiFnNA9SH4=;
        b=CjJRDTHO7q0mES5UqqADTJcAzEOWz03R1Z3YN1PNxxzdpCJ2tm7V3oC4wpCnQ0wksnKmvB
        lZFOcobVkxIlenAQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] cpu/hotplug: Remove deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-39-bigeasy@linutronix.de>
References: <20210803141621.780504-39-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163131391233.25758.7903234378099925474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     8c854303ce0e38e5bbedd725ff39da7e235865d8
Gitweb:        https://git.kernel.org/tip/8c854303ce0e38e5bbedd725ff39da7e235865d8
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:16:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 11 Sep 2021 00:41:21 +02:00

cpu/hotplug: Remove deprecated CPU-hotplug functions.

No users in tree use the deprecated CPU-hotplug functions anymore.

Remove them.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-39-bigeasy@linutronix.de

---
 include/linux/cpu.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 94a578a..9cf51e4 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -143,12 +143,6 @@ static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
 static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
-/* Wrappers which go away once all code is converted */
-static inline void cpu_hotplug_begin(void) { cpus_write_lock(); }
-static inline void cpu_hotplug_done(void) { cpus_write_unlock(); }
-static inline void get_online_cpus(void) { cpus_read_lock(); }
-static inline void put_online_cpus(void) { cpus_read_unlock(); }
-
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
 extern void thaw_secondary_cpus(void);

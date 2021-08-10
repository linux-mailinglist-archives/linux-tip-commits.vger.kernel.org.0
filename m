Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B903A3E7D41
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhHJQPJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:15:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44530 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbhHJQPD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:15:03 -0400
Date:   Tue, 10 Aug 2021 16:14:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628612080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfZRj/JLbgxmayH0yuM2YH+yveoLlA5U/56cTXeJUEQ=;
        b=Kia2JpzW/WbP8NMG5iNfxieYuJvkFtsMIUaGgxu9A1gTOOhsGZy918MSslQV6b0BSlxodi
        eWM3QZ+C1HCUpTn14tNjErg267G9ZWnAu5Qx5LijXTi2rkRQRNTTsfOF9UGEp3ZQ88+Axc
        KxVXWRJgT39i9UuFfVjqWE4NZxDmkzmwYqgTFD4zIdfKRLckFusbc3D7XR2FguROC19Rv6
        eGTY2pllycLJNrbZUyC7wPa1vicTOH9zHlpnV+ox2JC1yxqxa0ugbUf98p4xC2eZMlNUan
        970ULiQXYqdEaxD0MgcWrTHtd4d25HXxRuOpiaNH/sp64JnyzBqGf3EJYU2OXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628612080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfZRj/JLbgxmayH0yuM2YH+yveoLlA5U/56cTXeJUEQ=;
        b=urIUjXb4gg4mtKyIdOrFM6yr/TSXwRbEpJBkJ089hpOUgCH1YPVkYUQWeIzYWI7v/AcjZ3
        mZdShSycl8AxN7CQ==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Eliminate all kernel-doc warnings
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210809223825.24512-1-rdunlap@infradead.org>
References: <20210809223825.24512-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <162861207969.395.12939999877657003272.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     11bc021d1fbaaa1a6e7b92d6631faa875dd40b7d
Gitweb:        https://git.kernel.org/tip/11bc021d1fbaaa1a6e7b92d6631faa875dd40b7d
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Mon, 09 Aug 2021 15:38:25 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 18:07:38 +02:00

cpu/hotplug: Eliminate all kernel-doc warnings

kernel/cpu.c:57: warning: cannot understand function prototype: 'struct cpuhp_cpu_state '
kernel/cpu.c:115: warning: cannot understand function prototype: 'struct cpuhp_step '
kernel/cpu.c:146: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * cpuhp_invoke_callback _ Invoke the callbacks for a given state
kernel/cpu.c:75: warning: Function parameter or member 'fail' not described in 'cpuhp_cpu_state'
kernel/cpu.c:75: warning: Function parameter or member 'cpu' not described in 'cpuhp_cpu_state'
kernel/cpu.c:75: warning: Function parameter or member 'node' not described in 'cpuhp_cpu_state'
kernel/cpu.c:75: warning: Function parameter or member 'last' not described in 'cpuhp_cpu_state'
kernel/cpu.c:130: warning: Function parameter or member 'list' not described in 'cpuhp_step'
kernel/cpu.c:130: warning: Function parameter or member 'multi_instance' not described in 'cpuhp_step'
kernel/cpu.c:158: warning: No description found for return value of 'cpuhp_invoke_callback'
kernel/cpu.c:1188: warning: No description found for return value of 'cpu_device_down'
kernel/cpu.c:1400: warning: No description found for return value of 'cpu_device_up'
kernel/cpu.c:1425: warning: No description found for return value of 'bringup_hibernate_cpu'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210809223825.24512-1-rdunlap@infradead.org

---
 kernel/cpu.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8930a4e..62fb67e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -41,14 +41,19 @@
 #include "smpboot.h"
 
 /**
- * cpuhp_cpu_state - Per cpu hotplug state storage
+ * struct cpuhp_cpu_state - Per cpu hotplug state storage
  * @state:	The current cpu state
  * @target:	The target state
+ * @fail:	Current CPU hotplug callback state
  * @thread:	Pointer to the hotplug thread
  * @should_run:	Thread should execute
  * @rollback:	Perform a rollback
  * @single:	Single callback invocation
  * @bringup:	Single callback bringup or teardown selector
+ * @cpu:	CPU number
+ * @node:	Remote CPU node; for multi-instance, do a
+ *		single entry callback for install/remove
+ * @last:	For multi-instance rollback, remember how far we got
  * @cb_state:	The state for a single callback (install/uninstall)
  * @result:	Result of the operation
  * @done_up:	Signal completion to the issuer of the task for cpu-up
@@ -106,11 +111,12 @@ static inline void cpuhp_lock_release(bool bringup) { }
 #endif
 
 /**
- * cpuhp_step - Hotplug state machine step
+ * struct cpuhp_step - Hotplug state machine step
  * @name:	Name of the step
  * @startup:	Startup function of the step
  * @teardown:	Teardown function of the step
  * @cant_stop:	Bringup/teardown can't be stopped at this step
+ * @multi_instance:	State has multiple instances which get added afterwards
  */
 struct cpuhp_step {
 	const char		*name;
@@ -124,7 +130,9 @@ struct cpuhp_step {
 		int		(*multi)(unsigned int cpu,
 					 struct hlist_node *node);
 	} teardown;
+	/* private: */
 	struct hlist_head	list;
+	/* public: */
 	bool			cant_stop;
 	bool			multi_instance;
 };
@@ -143,7 +151,7 @@ static bool cpuhp_step_empty(bool bringup, struct cpuhp_step *step)
 }
 
 /**
- * cpuhp_invoke_callback _ Invoke the callbacks for a given state
+ * cpuhp_invoke_callback - Invoke the callbacks for a given state
  * @cpu:	The cpu for which the callback should be invoked
  * @state:	The state to do callbacks for
  * @bringup:	True if the bringup callback should be invoked
@@ -151,6 +159,8 @@ static bool cpuhp_step_empty(bool bringup, struct cpuhp_step *step)
  * @lastp:	For multi-instance rollback, remember how far we got
  *
  * Called from cpu hotplug and from the state register machinery.
+ *
+ * Return: %0 on success or a negative errno code
  */
 static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 				 bool bringup, struct hlist_node *node,
@@ -1183,6 +1193,8 @@ static int cpu_down(unsigned int cpu, enum cpuhp_state target)
  * This function is meant to be used by device core cpu subsystem only.
  *
  * Other subsystems should use remove_cpu() instead.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int cpu_device_down(struct device *dev)
 {
@@ -1395,6 +1407,8 @@ out:
  * This function is meant to be used by device core cpu subsystem only.
  *
  * Other subsystems should use add_cpu() instead.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int cpu_device_up(struct device *dev)
 {
@@ -1420,6 +1434,8 @@ EXPORT_SYMBOL_GPL(add_cpu);
  * On some architectures like arm64, we can hibernate on any CPU, but on
  * wake up the CPU we hibernated on might be offline as a side effect of
  * using maxcpus= for example.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int bringup_hibernate_cpu(unsigned int sleep_cpu)
 {
@@ -1985,9 +2001,9 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
  *			added afterwards.
  *
  * The caller needs to hold cpus read locked while calling this function.
- * Returns:
+ * Return:
  *   On success:
- *      Positive state number if @state is CPUHP_AP_ONLINE_DYN
+ *      Positive state number if @state is CPUHP_AP_ONLINE_DYN;
  *      0 for all other states
  *   On failure: proper (negative) error code
  */

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6D362496
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhDPPyT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbhDPPyL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:11 -0400
Date:   Fri, 16 Apr 2021 15:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0I1y9MZrhphYrDfk6yqvW3We/nuPC92yA0E/zHcvn6U=;
        b=KAIA5qR9mRLX8nedrnKXUcVypSGVbAzEh6ff1GnM9nyYGfAdvTTZg/Qw+QHf0tVkesJZRm
        Hb5IuG8Hj+PR6XOumM7tYlAfsGgbb3LLJO3AiWaEsXuTazMJYzidEPuvGscfuZaGm9Au/Z
        MupnF3TPmr9jxZ+AdyOuT0VPkk2VLUaAGxLPCx5FA3sb+8MREiMonhaBw0+X3+2COLJmbR
        F64FXmer4lw3dMvkn/yQAjMg37M7XnrZJ2+rfubA0+B6IMMr1RO98G3XKii0qYl6kxw2US
        AWcs0B2H4HNuFghbrZ02/vpPdooFXqFugTFPv5Dk9BeHLCiws68CZpri2ijshA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0I1y9MZrhphYrDfk6yqvW3We/nuPC92yA0E/zHcvn6U=;
        b=IMazAZlD83ahY30pWwNjwLOZq4lyiD++pbF3oAviDdeFRY3G7z2Ko11Sy5h6dWvAyiuBxk
        PUj3aUrzpr4KauAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpumask: Make cpu_{online,possible,present,active}() inline
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210310150109.045447765@infradead.org>
References: <20210310150109.045447765@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842514.29796.3881459178050340077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b02a4fd8148f655095d9e3d6eddd8f0042bcc27c
Gitweb:        https://git.kernel.org/tip/b02a4fd8148f655095d9e3d6eddd8f0042bcc27c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 25 Jan 2021 16:46:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:32 +02:00

cpumask: Make cpu_{online,possible,present,active}() inline

Prepare for addition of another mask. Primarily a code movement to
avoid having to create more #ifdef, but while there, convert
everything with an argument to an inline function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210310150109.045447765@infradead.org
---
 include/linux/cpumask.h | 97 +++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 31 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 383684e..a584336 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -98,37 +98,6 @@ extern struct cpumask __cpu_active_mask;
 
 extern atomic_t __num_online_cpus;
 
-#if NR_CPUS > 1
-/**
- * num_online_cpus() - Read the number of online CPUs
- *
- * Despite the fact that __num_online_cpus is of type atomic_t, this
- * interface gives only a momentary snapshot and is not protected against
- * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
- * region.
- */
-static inline unsigned int num_online_cpus(void)
-{
-	return atomic_read(&__num_online_cpus);
-}
-#define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
-#define num_present_cpus()	cpumask_weight(cpu_present_mask)
-#define num_active_cpus()	cpumask_weight(cpu_active_mask)
-#define cpu_online(cpu)		cpumask_test_cpu((cpu), cpu_online_mask)
-#define cpu_possible(cpu)	cpumask_test_cpu((cpu), cpu_possible_mask)
-#define cpu_present(cpu)	cpumask_test_cpu((cpu), cpu_present_mask)
-#define cpu_active(cpu)		cpumask_test_cpu((cpu), cpu_active_mask)
-#else
-#define num_online_cpus()	1U
-#define num_possible_cpus()	1U
-#define num_present_cpus()	1U
-#define num_active_cpus()	1U
-#define cpu_online(cpu)		((cpu) == 0)
-#define cpu_possible(cpu)	((cpu) == 0)
-#define cpu_present(cpu)	((cpu) == 0)
-#define cpu_active(cpu)		((cpu) == 0)
-#endif
-
 extern cpumask_t cpus_booted_once_mask;
 
 static inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
@@ -894,6 +863,72 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
 	return to_cpumask(p);
 }
 
+#if NR_CPUS > 1
+/**
+ * num_online_cpus() - Read the number of online CPUs
+ *
+ * Despite the fact that __num_online_cpus is of type atomic_t, this
+ * interface gives only a momentary snapshot and is not protected against
+ * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
+ * region.
+ */
+static inline unsigned int num_online_cpus(void)
+{
+	return atomic_read(&__num_online_cpus);
+}
+#define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
+#define num_present_cpus()	cpumask_weight(cpu_present_mask)
+#define num_active_cpus()	cpumask_weight(cpu_active_mask)
+
+static inline bool cpu_online(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_online_mask);
+}
+
+static inline bool cpu_possible(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_possible_mask);
+}
+
+static inline bool cpu_present(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_present_mask);
+}
+
+static inline bool cpu_active(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_active_mask);
+}
+
+#else
+
+#define num_online_cpus()	1U
+#define num_possible_cpus()	1U
+#define num_present_cpus()	1U
+#define num_active_cpus()	1U
+
+static inline bool cpu_online(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
+static inline bool cpu_possible(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
+static inline bool cpu_present(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
+static inline bool cpu_active(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
+#endif /* NR_CPUS > 1 */
+
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
 
 #if NR_CPUS <= BITS_PER_LONG

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6319A560
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfHWCOM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:14:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbfHWCOM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:14:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z5a-000139-J7; Fri, 23 Aug 2019 04:14:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 26C7C1C07E4;
        Fri, 23 Aug 2019 04:14:06 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:14:05 -0000
From:   tip-bot2 for Hans de Goede <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/intel/iosf_mbi Rewrite locking
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20190812102113.95794-1-hdegoede@redhat.com>
References: <20190812102113.95794-1-hdegoede@redhat.com>
MIME-Version: 1.0
Message-ID: <156652644596.12175.3446865164541852023.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     00452ba9fdb5bf6fb5fea1dae5227b4bbed44fc4
Gitweb:        https://git.kernel.org/tip/00452ba9fdb5bf6fb5fea1dae5227b4bbed44fc4
Author:        Hans de Goede <hdegoede@redhat.com>
AuthorDate:    Mon, 12 Aug 2019 12:21:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Aug 2019 20:52:39 +02:00

x86/platform/intel/iosf_mbi Rewrite locking

There are 2 problems with the old iosf PMIC I2C bus arbritration code which
need to be addressed:

1. The lockdep code complains about a possible deadlock in the
iosf_mbi_[un]block_punit_i2c_access code:

[    6.712662] ======================================================
[    6.712673] WARNING: possible circular locking dependency detected
[    6.712685] 5.3.0-rc2+ #79 Not tainted
[    6.712692] ------------------------------------------------------
[    6.712702] kworker/0:1/7 is trying to acquire lock:
[    6.712712] 00000000df1c5681 (iosf_mbi_block_punit_i2c_access_count_mutex){+.+.}, at: iosf_mbi_unblock_punit_i2c_access+0x13/0x90
[    6.712739]
               but task is already holding lock:
[    6.712749] 0000000067cb23e7 (iosf_mbi_punit_mutex){+.+.}, at: iosf_mbi_block_punit_i2c_access+0x97/0x186
[    6.712768]
               which lock already depends on the new lock.

[    6.712780]
               the existing dependency chain (in reverse order) is:
[    6.712792]
               -> #1 (iosf_mbi_punit_mutex){+.+.}:
[    6.712808]        __mutex_lock+0xa8/0x9a0
[    6.712818]        iosf_mbi_block_punit_i2c_access+0x97/0x186
[    6.712831]        i2c_dw_acquire_lock+0x20/0x30
[    6.712841]        i2c_dw_set_reg_access+0x15/0xb0
[    6.712851]        i2c_dw_probe+0x57/0x473
[    6.712861]        dw_i2c_plat_probe+0x33e/0x640
[    6.712874]        platform_drv_probe+0x38/0x80
[    6.712884]        really_probe+0xf3/0x380
[    6.712894]        driver_probe_device+0x59/0xd0
[    6.712905]        bus_for_each_drv+0x84/0xd0
[    6.712915]        __device_attach+0xe4/0x170
[    6.712925]        bus_probe_device+0x9f/0xb0
[    6.712935]        deferred_probe_work_func+0x79/0xd0
[    6.712946]        process_one_work+0x234/0x560
[    6.712957]        worker_thread+0x50/0x3b0
[    6.712967]        kthread+0x10a/0x140
[    6.712977]        ret_from_fork+0x3a/0x50
[    6.712986]
               -> #0 (iosf_mbi_block_punit_i2c_access_count_mutex){+.+.}:
[    6.713004]        __lock_acquire+0xe07/0x1930
[    6.713015]        lock_acquire+0x9d/0x1a0
[    6.713025]        __mutex_lock+0xa8/0x9a0
[    6.713035]        iosf_mbi_unblock_punit_i2c_access+0x13/0x90
[    6.713047]        i2c_dw_set_reg_access+0x4d/0xb0
[    6.713058]        i2c_dw_probe+0x57/0x473
[    6.713068]        dw_i2c_plat_probe+0x33e/0x640
[    6.713079]        platform_drv_probe+0x38/0x80
[    6.713089]        really_probe+0xf3/0x380
[    6.713099]        driver_probe_device+0x59/0xd0
[    6.713109]        bus_for_each_drv+0x84/0xd0
[    6.713119]        __device_attach+0xe4/0x170
[    6.713129]        bus_probe_device+0x9f/0xb0
[    6.713140]        deferred_probe_work_func+0x79/0xd0
[    6.713150]        process_one_work+0x234/0x560
[    6.713160]        worker_thread+0x50/0x3b0
[    6.713170]        kthread+0x10a/0x140
[    6.713180]        ret_from_fork+0x3a/0x50
[    6.713189]
               other info that might help us debug this:

[    6.713202]  Possible unsafe locking scenario:

[    6.713212]        CPU0                    CPU1
[    6.713221]        ----                    ----
[    6.713229]   lock(iosf_mbi_punit_mutex);
[    6.713239]                                lock(iosf_mbi_block_punit_i2c_access_count_mutex);
[    6.713253]                                lock(iosf_mbi_punit_mutex);
[    6.713265]   lock(iosf_mbi_block_punit_i2c_access_count_mutex);
[    6.713276]
                *** DEADLOCK ***

In practice can never happen because only the first caller which
increments iosf_mbi_block_punit_i2c_access_count will also take
iosf_mbi_punit_mutex, that is the whole purpose of the counter, which
itself is protected by iosf_mbi_block_punit_i2c_access_count_mutex.

But there is no way to tell the lockdep code about this and we really
want to be able to run a kernel with lockdep enabled without these
warnings being triggered.

2. The lockdep warning also points out another real problem, if 2 threads
both are in a block of code protected by iosf_mbi_block_punit_i2c_access
and the first thread to acquire the block exits before the second thread
then the second thread will call mutex_unlock on iosf_mbi_punit_mutex,
but it is not the thread which took the mutex and unlocking by another
thread is not allowed.

Fix this by getting rid of the notion of holding a mutex for the entire
duration of the PMIC accesses, be it either from the PUnit side, or from an
in kernel I2C driver. In general holding a mutex after exiting a function
is a bad idea and the above problems show this case is no different.

Instead 2 counters are now used, one for PMIC accesses from the PUnit
and one for accesses from in kernel I2C code. When access is requested
now the code will wait (using a waitqueue) for the counter of the other
type of access to reach 0 and on release, if the counter reaches 0 the
wakequeue is woken.

Note that the counter approach is necessary to allow nested calls.
The main reason for this is so that a series of i2c transfers can be done
with the punit blocked from accessing the bus the whole time. This is
necessary to be able to safely read/modify/write a PMIC register without
racing with the PUNIT doing the same thing.

Allowing nested iosf_mbi_block_punit_i2c_access() calls also is desirable
from a performance pov since the whole dance necessary to block the PUnit
from accessing the PMIC I2C bus is somewhat expensive.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lkml.kernel.org/r/20190812102113.95794-1-hdegoede@redhat.com

---
 arch/x86/platform/intel/iosf_mbi.c | 100 +++++++++++++++++-----------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index 2e796b5..9e24445 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/capability.h>
 #include <linux/pm_qos.h>
+#include <linux/wait.h>
 
 #include <asm/iosf_mbi.h>
 
@@ -201,23 +202,45 @@ EXPORT_SYMBOL(iosf_mbi_available);
 #define PUNIT_SEMAPHORE_BIT		BIT(0)
 #define PUNIT_SEMAPHORE_ACQUIRE		BIT(1)
 
-static DEFINE_MUTEX(iosf_mbi_punit_mutex);
-static DEFINE_MUTEX(iosf_mbi_block_punit_i2c_access_count_mutex);
+static DEFINE_MUTEX(iosf_mbi_pmic_access_mutex);
 static BLOCKING_NOTIFIER_HEAD(iosf_mbi_pmic_bus_access_notifier);
-static u32 iosf_mbi_block_punit_i2c_access_count;
+static DECLARE_WAIT_QUEUE_HEAD(iosf_mbi_pmic_access_waitq);
+static u32 iosf_mbi_pmic_punit_access_count;
+static u32 iosf_mbi_pmic_i2c_access_count;
 static u32 iosf_mbi_sem_address;
 static unsigned long iosf_mbi_sem_acquired;
 static struct pm_qos_request iosf_mbi_pm_qos;
 
 void iosf_mbi_punit_acquire(void)
 {
-	mutex_lock(&iosf_mbi_punit_mutex);
+	/* Wait for any I2C PMIC accesses from in kernel drivers to finish. */
+	mutex_lock(&iosf_mbi_pmic_access_mutex);
+	while (iosf_mbi_pmic_i2c_access_count != 0) {
+		mutex_unlock(&iosf_mbi_pmic_access_mutex);
+		wait_event(iosf_mbi_pmic_access_waitq,
+			   iosf_mbi_pmic_i2c_access_count == 0);
+		mutex_lock(&iosf_mbi_pmic_access_mutex);
+	}
+	/*
+	 * We do not need to do anything to allow the PUNIT to safely access
+	 * the PMIC, other then block in kernel accesses to the PMIC.
+	 */
+	iosf_mbi_pmic_punit_access_count++;
+	mutex_unlock(&iosf_mbi_pmic_access_mutex);
 }
 EXPORT_SYMBOL(iosf_mbi_punit_acquire);
 
 void iosf_mbi_punit_release(void)
 {
-	mutex_unlock(&iosf_mbi_punit_mutex);
+	bool do_wakeup;
+
+	mutex_lock(&iosf_mbi_pmic_access_mutex);
+	iosf_mbi_pmic_punit_access_count--;
+	do_wakeup = iosf_mbi_pmic_punit_access_count == 0;
+	mutex_unlock(&iosf_mbi_pmic_access_mutex);
+
+	if (do_wakeup)
+		wake_up(&iosf_mbi_pmic_access_waitq);
 }
 EXPORT_SYMBOL(iosf_mbi_punit_release);
 
@@ -256,34 +279,32 @@ static void iosf_mbi_reset_semaphore(void)
  * already blocked P-Unit accesses because it wants them blocked over multiple
  * i2c-transfers, for e.g. read-modify-write of an I2C client register.
  *
- * The P-Unit accesses already being blocked is tracked through the
- * iosf_mbi_block_punit_i2c_access_count variable which is protected by the
- * iosf_mbi_block_punit_i2c_access_count_mutex this mutex is hold for the
- * entire duration of the function.
- *
- * If access is not blocked yet, this function takes the following steps:
+ * To allow safe PMIC i2c bus accesses this function takes the following steps:
  *
  * 1) Some code sends request to the P-Unit which make it access the PMIC
  *    I2C bus. Testing has shown that the P-Unit does not check its internal
  *    PMIC bus semaphore for these requests. Callers of these requests call
  *    iosf_mbi_punit_acquire()/_release() around their P-Unit accesses, these
- *    functions lock/unlock the iosf_mbi_punit_mutex.
- *    As the first step we lock the iosf_mbi_punit_mutex, to wait for any in
- *    flight requests to finish and to block any new requests.
+ *    functions increase/decrease iosf_mbi_pmic_punit_access_count, so first
+ *    we wait for iosf_mbi_pmic_punit_access_count to become 0.
+ *
+ * 2) Check iosf_mbi_pmic_i2c_access_count, if access has already
+ *    been blocked by another caller, we only need to increment
+ *    iosf_mbi_pmic_i2c_access_count and we can skip the other steps.
  *
- * 2) Some code makes such P-Unit requests from atomic contexts where it
+ * 3) Some code makes such P-Unit requests from atomic contexts where it
  *    cannot call iosf_mbi_punit_acquire() as that may sleep.
  *    As the second step we call a notifier chain which allows any code
  *    needing P-Unit resources from atomic context to acquire them before
  *    we take control over the PMIC I2C bus.
  *
- * 3) When CPU cores enter C6 or C7 the P-Unit needs to talk to the PMIC
+ * 4) When CPU cores enter C6 or C7 the P-Unit needs to talk to the PMIC
  *    if this happens while the kernel itself is accessing the PMIC I2C bus
  *    the SoC hangs.
  *    As the third step we call pm_qos_update_request() to disallow the CPU
  *    to enter C6 or C7.
  *
- * 4) The P-Unit has a PMIC bus semaphore which we can request to stop
+ * 5) The P-Unit has a PMIC bus semaphore which we can request to stop
  *    autonomous P-Unit tasks from accessing the PMIC I2C bus while we hold it.
  *    As the fourth and final step we request this semaphore and wait for our
  *    request to be acknowledged.
@@ -297,12 +318,18 @@ int iosf_mbi_block_punit_i2c_access(void)
 	if (WARN_ON(!mbi_pdev || !iosf_mbi_sem_address))
 		return -ENXIO;
 
-	mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
+	mutex_lock(&iosf_mbi_pmic_access_mutex);
 
-	if (iosf_mbi_block_punit_i2c_access_count > 0)
+	while (iosf_mbi_pmic_punit_access_count != 0) {
+		mutex_unlock(&iosf_mbi_pmic_access_mutex);
+		wait_event(iosf_mbi_pmic_access_waitq,
+			   iosf_mbi_pmic_punit_access_count == 0);
+		mutex_lock(&iosf_mbi_pmic_access_mutex);
+	}
+
+	if (iosf_mbi_pmic_i2c_access_count > 0)
 		goto success;
 
-	mutex_lock(&iosf_mbi_punit_mutex);
 	blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
 				     MBI_PMIC_BUS_ACCESS_BEGIN, NULL);
 
@@ -330,10 +357,6 @@ int iosf_mbi_block_punit_i2c_access(void)
 			iosf_mbi_sem_acquired = jiffies;
 			dev_dbg(&mbi_pdev->dev, "P-Unit semaphore acquired after %ums\n",
 				jiffies_to_msecs(jiffies - start));
-			/*
-			 * Success, keep iosf_mbi_punit_mutex locked till
-			 * iosf_mbi_unblock_punit_i2c_access() gets called.
-			 */
 			goto success;
 		}
 
@@ -344,15 +367,13 @@ int iosf_mbi_block_punit_i2c_access(void)
 	dev_err(&mbi_pdev->dev, "Error P-Unit semaphore timed out, resetting\n");
 error:
 	iosf_mbi_reset_semaphore();
-	mutex_unlock(&iosf_mbi_punit_mutex);
-
 	if (!iosf_mbi_get_sem(&sem))
 		dev_err(&mbi_pdev->dev, "P-Unit semaphore: %d\n", sem);
 success:
 	if (!WARN_ON(ret))
-		iosf_mbi_block_punit_i2c_access_count++;
+		iosf_mbi_pmic_i2c_access_count++;
 
-	mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
+	mutex_unlock(&iosf_mbi_pmic_access_mutex);
 
 	return ret;
 }
@@ -360,17 +381,20 @@ EXPORT_SYMBOL(iosf_mbi_block_punit_i2c_access);
 
 void iosf_mbi_unblock_punit_i2c_access(void)
 {
-	mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
+	bool do_wakeup = false;
 
-	iosf_mbi_block_punit_i2c_access_count--;
-	if (iosf_mbi_block_punit_i2c_access_count == 0) {
+	mutex_lock(&iosf_mbi_pmic_access_mutex);
+	iosf_mbi_pmic_i2c_access_count--;
+	if (iosf_mbi_pmic_i2c_access_count == 0) {
 		iosf_mbi_reset_semaphore();
-		mutex_unlock(&iosf_mbi_punit_mutex);
 		dev_dbg(&mbi_pdev->dev, "punit semaphore held for %ums\n",
 			jiffies_to_msecs(jiffies - iosf_mbi_sem_acquired));
+		do_wakeup = true;
 	}
+	mutex_unlock(&iosf_mbi_pmic_access_mutex);
 
-	mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
+	if (do_wakeup)
+		wake_up(&iosf_mbi_pmic_access_waitq);
 }
 EXPORT_SYMBOL(iosf_mbi_unblock_punit_i2c_access);
 
@@ -379,10 +403,10 @@ int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb)
 	int ret;
 
 	/* Wait for the bus to go inactive before registering */
-	mutex_lock(&iosf_mbi_punit_mutex);
+	iosf_mbi_punit_acquire();
 	ret = blocking_notifier_chain_register(
 				&iosf_mbi_pmic_bus_access_notifier, nb);
-	mutex_unlock(&iosf_mbi_punit_mutex);
+	iosf_mbi_punit_release();
 
 	return ret;
 }
@@ -403,9 +427,9 @@ int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb)
 	int ret;
 
 	/* Wait for the bus to go inactive before unregistering */
-	mutex_lock(&iosf_mbi_punit_mutex);
+	iosf_mbi_punit_acquire();
 	ret = iosf_mbi_unregister_pmic_bus_access_notifier_unlocked(nb);
-	mutex_unlock(&iosf_mbi_punit_mutex);
+	iosf_mbi_punit_release();
 
 	return ret;
 }
@@ -413,7 +437,7 @@ EXPORT_SYMBOL(iosf_mbi_unregister_pmic_bus_access_notifier);
 
 void iosf_mbi_assert_punit_acquired(void)
 {
-	WARN_ON(!mutex_is_locked(&iosf_mbi_punit_mutex));
+	WARN_ON(iosf_mbi_pmic_punit_access_count == 0);
 }
 EXPORT_SYMBOL(iosf_mbi_assert_punit_acquired);
 

Return-Path: <linux-tip-commits+bounces-5497-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F32AB01D3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7CE1BA68CE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530D2868B9;
	Thu,  8 May 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4gE0OIL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7AwRfFqi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809021D3F9;
	Thu,  8 May 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726871; cv=none; b=CduooQWrWP2W9kHCcr7pa2eeJYE43tHmdAuAJP0lvPPoe1t7nBYl+GxAc+boi9KBuy4WH8fEK81fAu2tS+5nFxewm9ma23xEOR4OdfOprwt4M63U/SzrjeSbE5ZI49IzXul4xHhXjD5qdFM6IE1BCWbEP0f6hKaGN97phjEH5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726871; c=relaxed/simple;
	bh=hkmls6N+jFO5Q1a4XhGm9Gkdjq3oyk+T95TeOwL/6Z0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nax/qKpHO2sxop1t4vgLLc6SHKTqRhYH9Nzmg+iSansSy8kt93KiYSzMkEeIgR2PXmof+FfVIhySA38J3xpHpUnFYx/39xfW6CTEEb25tcakZyayndxm48hzYKNmf0vwG50EH+tafOxQrhDodpB7jJgPfly2Seq0ptkrdiJeUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S4gE0OIL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7AwRfFqi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746726867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCWpCoRbaVE9dFzkaoOMrIxDfvDevDtYQuEftvUNPEY=;
	b=S4gE0OILev6l0wW8qUeFDeaLv1xJ/I7CH1b5XqbK7py//3a5/Vxk+6EsLO+KQamHxPX4ld
	qv+/WCuZNMMI9Vj3vWe0Hr7hfWWbt2EmpskNN/bXNK4x+dmGi1n5k3oOWv3LsZTMaURVHh
	97KNHG5xptdM6BVHpyCyzfV8vmKCwY5qJaPM3YLEAXIITdjqWEK9UOmJabiGk1N4P4vedZ
	thrD2HCxkZE3edFbh4A8oDSRJ1CktTq5SV+nBmjDD+HtdYhJyYL/E35SDpHc8HAIKKEXLt
	2qM1etyEXKH/nb9FN/Ja01L8+X+Qpy8zbaNdsXh/lnTB3Scg1k8y8khNZppd5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746726867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCWpCoRbaVE9dFzkaoOMrIxDfvDevDtYQuEftvUNPEY=;
	b=7AwRfFqiZ0/7vBLnEbcqDp3euwnKc6N3qpHmq1oz+7d+GCN+N1qvcluYbsHbJQPVydsR42
	NqYuSHqRje6SrYBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] treewide, timers: Rename
 destroy_timer_on_stack() as timer_destroy_on_stack()
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250507175338.672442-10-mingo@kernel.org>
References: <20250507175338.672442-10-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672686663.406.11375214207590034772.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     aad823aa3a7d675a8d0de478a04307f63e3725db
Gitweb:        https://git.kernel.org/tip/aad823aa3a7d675a8d0de478a04307f63e3725db
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 19:53:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 May 2025 19:49:33 +02:00

treewide, timers: Rename destroy_timer_on_stack() as timer_destroy_on_stack()

Move this API to the canonical timer_*() namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250507175338.672442-10-mingo@kernel.org

---
 drivers/base/power/main.c                     | 2 +-
 drivers/char/random.c                         | 2 +-
 drivers/dma-buf/st-dma-fence.c                | 2 +-
 drivers/firewire/core-transaction.c           | 2 +-
 drivers/firmware/psci/psci_checker.c          | 2 +-
 drivers/gpu/drm/gud/gud_pipe.c                | 2 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    | 2 +-
 drivers/gpu/drm/i915/selftests/lib_sw_fence.c | 2 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c       | 2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c       | 2 +-
 drivers/scsi/megaraid/megaraid_mbox.c         | 2 +-
 drivers/scsi/megaraid/megaraid_mm.c           | 2 +-
 drivers/staging/gpib/common/iblib.c           | 2 +-
 drivers/usb/atm/cxacru.c                      | 2 +-
 drivers/usb/misc/usbtest.c                    | 2 +-
 fs/bcachefs/clock.c                           | 2 +-
 include/linux/timer.h                         | 6 +++---
 kernel/kcsan/kcsan_test.c                     | 2 +-
 kernel/rcu/rcutorture.c                       | 2 +-
 kernel/time/sleep_timeout.c                   | 2 +-
 kernel/time/timer.c                           | 4 ++--
 kernel/workqueue.c                            | 2 +-
 22 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c8b0a9e..95f51a7 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -560,7 +560,7 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 	struct timer_list *timer = &wd->timer;
 
 	timer_delete_sync(timer);
-	destroy_timer_on_stack(timer);
+	timer_destroy_on_stack(timer);
 }
 #else
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd)
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4ea4dcc..e530331 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1353,7 +1353,7 @@ static void __cold try_to_generate_entropy(void)
 	mix_pool_bytes(&stack->entropy, sizeof(stack->entropy));
 
 	timer_delete_sync(&stack->timer);
-	destroy_timer_on_stack(&stack->timer);
+	timer_destroy_on_stack(&stack->timer);
 }
 
 
diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index 9f80a45..261b388 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -413,7 +413,7 @@ static int test_wait_timeout(void *arg)
 	err = 0;
 err_free:
 	timer_delete_sync(&wt.timer);
-	destroy_timer_on_stack(&wt.timer);
+	timer_destroy_on_stack(&wt.timer);
 	dma_fence_signal(wt.f);
 	dma_fence_put(wt.f);
 	return err;
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index b0f9ef6..18cacb9 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -431,7 +431,7 @@ int fw_run_transaction(struct fw_card *card, int tcode, int destination_id,
 	fw_send_request(card, &t, tcode, destination_id, generation, speed,
 			offset, payload, length, transaction_callback, &d);
 	wait_for_completion(&d.done);
-	destroy_timer_on_stack(&t.split_timeout_timer);
+	timer_destroy_on_stack(&t.split_timeout_timer);
 
 	return d.rcode;
 }
diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index b662b7e..df02a4e 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -343,7 +343,7 @@ static int suspend_test_thread(void *arg)
 	 * later.
 	 */
 	timer_delete(&wakeup_timer);
-	destroy_timer_on_stack(&wakeup_timer);
+	timer_destroy_on_stack(&wakeup_timer);
 
 	if (atomic_dec_return_relaxed(&nb_active_threads) == 0)
 		complete(&suspend_threads_done);
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 77cfcf3..feff73c 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -261,7 +261,7 @@ static int gud_usb_bulk(struct gud_device *gdrm, size_t len)
 	else if (ctx.sgr.bytes != len)
 		ret = -EIO;
 
-	destroy_timer_on_stack(&ctx.timer);
+	timer_destroy_on_stack(&ctx.timer);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 401bee0..32c762e 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -661,7 +661,7 @@ static int live_emit_pte_full_ring(void *arg)
 out_rq:
 	i915_request_add(rq); /* GEM_BUG_ON(rq->reserved_space > ring->space)? */
 	timer_delete_sync(&st.timer);
-	destroy_timer_on_stack(&st.timer);
+	timer_destroy_on_stack(&st.timer);
 out_unpin:
 	intel_context_unpin(ce);
 out_put:
diff --git a/drivers/gpu/drm/i915/selftests/lib_sw_fence.c b/drivers/gpu/drm/i915/selftests/lib_sw_fence.c
index d5ecc68..522ad49 100644
--- a/drivers/gpu/drm/i915/selftests/lib_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/lib_sw_fence.c
@@ -77,7 +77,7 @@ void timed_fence_fini(struct timed_fence *tf)
 	if (timer_delete_sync(&tf->timer))
 		i915_sw_fence_commit(&tf->fence);
 
-	destroy_timer_on_stack(&tf->timer);
+	timer_destroy_on_stack(&tf->timer);
 	i915_sw_fence_fini(&tf->fence);
 }
 
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index f8f20d2..f248668 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -201,7 +201,7 @@ static int threaded_ttm_bo_reserve(void *arg)
 	err = ttm_bo_reserve(bo, interruptible, no_wait, &ctx);
 
 	timer_delete_sync(&s_timer.timer);
-	destroy_timer_on_stack(&s_timer.timer);
+	timer_destroy_on_stack(&s_timer.timer);
 
 	ww_acquire_fini(&ctx);
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 9a583ee..e23b0de 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -3806,7 +3806,7 @@ status);
 	if ((status < 0) && (!probe_fl)) {
 		pvr2_hdw_render_useless(hdw);
 	}
-	destroy_timer_on_stack(&timer.timer);
+	timer_destroy_on_stack(&timer.timer);
 
 	return status;
 }
diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index d533a8a..b75f46c 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -3952,7 +3952,7 @@ megaraid_sysfs_get_ldmap(adapter_t *adapter)
 
 
 	timer_delete_sync(&timeout.timer);
-	destroy_timer_on_stack(&timeout.timer);
+	timer_destroy_on_stack(&timeout.timer);
 
 	mutex_unlock(&raid_dev->sysfs_mtx);
 
diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index 1f2cd15..fd7fa76 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -704,7 +704,7 @@ lld_ioctl(mraid_mmadp_t *adp, uioc_t *kioc)
 	wait_event(wait_q, (kioc->status != -ENODATA));
 	if (timeout.timer.function) {
 		timer_delete_sync(&timeout.timer);
-		destroy_timer_on_stack(&timeout.timer);
+		timer_destroy_on_stack(&timeout.timer);
 	}
 
 	/*
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index b297261..432540e 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -611,7 +611,7 @@ static void start_wait_timer(struct wait_info *winfo)
 static void remove_wait_timer(struct wait_info *winfo)
 {
 	timer_delete_sync(&winfo->timer);
-	destroy_timer_on_stack(&winfo->timer);
+	timer_destroy_on_stack(&winfo->timer);
 }
 
 /*
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index c6b9ad1..b7f9404 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -598,7 +598,7 @@ static int cxacru_start_wait_urb(struct urb *urb, struct completion *done,
 	mod_timer(&timer.timer, jiffies + msecs_to_jiffies(CMD_TIMEOUT));
 	wait_for_completion(done);
 	timer_delete_sync(&timer.timer);
-	destroy_timer_on_stack(&timer.timer);
+	timer_destroy_on_stack(&timer.timer);
 
 	if (actual_length)
 		*actual_length = urb->actual_length;
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 853a5f0..7c2041f 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -630,7 +630,7 @@ static int perform_sglist(
 			retval = -ETIMEDOUT;
 		else
 			retval = req->status;
-		destroy_timer_on_stack(&timeout.timer);
+		timer_destroy_on_stack(&timeout.timer);
 
 		/* FIXME check resulting data pattern */
 
diff --git a/fs/bcachefs/clock.c b/fs/bcachefs/clock.c
index d6dd12d..f57f9f4 100644
--- a/fs/bcachefs/clock.c
+++ b/fs/bcachefs/clock.c
@@ -122,7 +122,7 @@ void bch2_kthread_io_clock_wait(struct io_clock *clock,
 
 	__set_current_state(TASK_RUNNING);
 	timer_delete_sync(&wait.cpu_timer);
-	destroy_timer_on_stack(&wait.cpu_timer);
+	timer_destroy_on_stack(&wait.cpu_timer);
 	bch2_io_timer_del(clock, &wait.io_timer);
 }
 
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 5b6ff90..7b53043 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -115,7 +115,7 @@ static inline void timer_init_key_on_stack(struct timer_list *timer,
  *
  * Regular timer initialization should use either DEFINE_TIMER() above,
  * or timer_setup(). For timers on the stack, timer_setup_on_stack() must
- * be used and must be balanced with a call to destroy_timer_on_stack().
+ * be used and must be balanced with a call to timer_destroy_on_stack().
  */
 #define timer_setup(timer, callback, flags)			\
 	__timer_init((timer), (callback), (flags))
@@ -124,9 +124,9 @@ static inline void timer_init_key_on_stack(struct timer_list *timer,
 	__timer_init_on_stack((timer), (callback), (flags))
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
-extern void destroy_timer_on_stack(struct timer_list *timer);
+extern void timer_destroy_on_stack(struct timer_list *timer);
 #else
-static inline void destroy_timer_on_stack(struct timer_list *timer) { }
+static inline void timer_destroy_on_stack(struct timer_list *timer) { }
 #endif
 
 #define from_timer(var, callback_timer, timer_fieldname) \
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 6ce73cc..c287118 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1501,7 +1501,7 @@ static int access_thread(void *arg)
 		}
 	} while (!torture_must_stop());
 	timer_delete_sync(&timer);
-	destroy_timer_on_stack(&timer);
+	timer_destroy_on_stack(&timer);
 
 	torture_kthread_stopping("access_thread");
 	return 0;
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4fa7772..f3f1bc8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2325,7 +2325,7 @@ rcu_torture_reader(void *arg)
 	} while (!torture_must_stop());
 	if (irqreader && cur_ops->irq_capable) {
 		timer_delete_sync(&t);
-		destroy_timer_on_stack(&t);
+		timer_destroy_on_stack(&t);
 	}
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 	torture_kthread_stopping("rcu_torture_reader");
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index c0e960a..5aa38b2 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -100,7 +100,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	timer_delete_sync(&timer.timer);
 
 	/* Remove the timer from the object tracker */
-	destroy_timer_on_stack(&timer.timer);
+	timer_destroy_on_stack(&timer.timer);
 
 	timeout = expire - jiffies;
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 836ba00..007b30f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -860,11 +860,11 @@ void timer_init_key_on_stack(struct timer_list *timer,
 }
 EXPORT_SYMBOL_GPL(timer_init_key_on_stack);
 
-void destroy_timer_on_stack(struct timer_list *timer)
+void timer_destroy_on_stack(struct timer_list *timer)
 {
 	debug_object_free(timer, &timer_debug_descr);
 }
-EXPORT_SYMBOL_GPL(destroy_timer_on_stack);
+EXPORT_SYMBOL_GPL(timer_destroy_on_stack);
 
 #else
 static inline void debug_timer_init(struct timer_list *timer) { }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cf62032..9e6cf45 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -686,7 +686,7 @@ EXPORT_SYMBOL_GPL(destroy_work_on_stack);
 
 void destroy_delayed_work_on_stack(struct delayed_work *work)
 {
-	destroy_timer_on_stack(&work->timer);
+	timer_destroy_on_stack(&work->timer);
 	debug_object_free(&work->work, &work_debug_descr);
 }
 EXPORT_SYMBOL_GPL(destroy_delayed_work_on_stack);


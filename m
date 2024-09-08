Return-Path: <linux-tip-commits+bounces-2206-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F138C970953
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 20:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF71C212EB
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD1178CDE;
	Sun,  8 Sep 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2dLwWCSJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fYX9MuAE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F4175D2F;
	Sun,  8 Sep 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821890; cv=none; b=WJGFwkm9185NfdJOsKlVgyqRwPnkl1D1d5rE+RSJgJUMAr9TKa+mJFcH+CbU6NvnUGpMnoeV13g2El+PIMm3zyZoRXK8nn2o+6YboVe4a5qtwdpz7a2pWIo3nrjwAlXEa7+gD+9I4cl6aE/oPMpN/UCwIhkWrXboKJAv0mFdFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821890; c=relaxed/simple;
	bh=zhaSyAHVf3daGSOacCERcsBV9rVBTRzUJBp2U47cPIA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gZjSWvMTQnwztNNdAguARXdtgVySZUDin1LcHKyk74TuNzBsfLCeBdTHxVe82Bl4+Ein1eauYLgsPjwVhCv8CkqYtPDi6B/av3JWEcXyWUoc0ccbqz9iMNMhk34FBZLX/04hvMaEHu4aJZwJTDrJmsh0bntX+dCS8bG+NIJNa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2dLwWCSJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fYX9MuAE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Sep 2024 18:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725821886;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZR/yS/Whpf999PKP9HIxInhPi5wUtZHAk4Ki6Dw1TA=;
	b=2dLwWCSJxSJXA3IBgEC0GaPKeebucoSMULKoxu5V3w3oDGcLaZm9zhTnznLcH2cQGevN3l
	Z9af8ECscnJzV+ve6MzW3abrs4C5I4v8YAb2GfSnbZwqrQEz1i7uQcpr7CMR8iuOcPRbXO
	qIlcFrS/9ninUjoHx2tudn/CQEDwMeax/uJylk97iGeAbRdJ/zbHLYXLqMkm0PG9G7yo/7
	OnYpIaTK3LyKKlgYhyjUIL6MtqeWBGPiKl7oh35TYmBg4gobzJasCt74XaKQunwD7/n6rH
	ZUG+Ot2OKkk7cjmWQbz254Mw77YzD9OPKlvJgwT2Rz1FKQuvldYazy3rtfNKnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725821886;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZR/yS/Whpf999PKP9HIxInhPi5wUtZHAk4Ki6Dw1TA=;
	b=fYX9MuAEI1tIjnMQPjzZiVtTI8Vs9ZDNhviJkgmX/nF3q5EXha5qwmffyuv6TjwcEuMRGH
	Q0tAxSgj6PpK/SCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] treewide: Fix wrong singular form of jiffies in comments
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240904-devel-anna-maria-b4-timers-flseep-v1-3-e98760256370@linutronix.de>
References:
 <20240904-devel-anna-maria-b4-timers-flseep-v1-3-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172582188636.2215.10942012594027534113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bd7c8ff9fef4b21a97f9b30a7364845ee6eaaf23
Gitweb:        https://git.kernel.org/tip/bd7c8ff9fef4b21a97f9b30a7364845ee6e=
aaf23
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 15:04:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Sep 2024 20:47:40 +02:00

treewide: Fix wrong singular form of jiffies in comments

There are several comments all over the place, which uses a wrong singular
form of jiffies.

Replace 'jiffie' by 'jiffy'. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Link: https://lore.kernel.org/all/20240904-devel-anna-maria-b4-timers-flseep-=
v1-3-e98760256370@linutronix.de

---
 Documentation/admin-guide/media/vivid.rst                       |  2 +-
 Documentation/timers/timers-howto.rst                           |  2 +-
 Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst |  2 +-
 arch/arm/mach-versatile/spc.c                                   |  2 +-
 arch/m68k/q40/q40ints.c                                         |  2 +-
 arch/x86/kernel/cpu/mce/dev-mcelog.c                            |  2 +-
 drivers/char/ipmi/ipmi_ssif.c                                   |  2 +-
 drivers/dma-buf/st-dma-fence.c                                  |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c                        |  2 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c                    |  4 ++--
 drivers/gpu/drm/i915/i915_utils.c                               |  2 +-
 drivers/gpu/drm/v3d/v3d_bo.c                                    |  2 +-
 drivers/isdn/mISDN/dsp_cmx.c                                    |  2 +-
 drivers/net/ethernet/marvell/mvmdio.c                           |  2 +-
 fs/xfs/xfs_buf.h                                                |  2 +-
 include/linux/jiffies.h                                         |  2 +-
 include/linux/timekeeper_internal.h                             |  2 +-
 kernel/time/alarmtimer.c                                        |  2 +-
 kernel/time/clockevents.c                                       |  2 +-
 kernel/time/hrtimer.c                                           |  2 +-
 kernel/time/posix-timers.c                                      |  4 ++--
 kernel/time/timer.c                                             | 12 ++++++-=
-----
 lib/Kconfig.debug                                               |  2 +-
 net/batman-adv/types.h                                          |  2 +-
 24 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/media/vivid.rst b/Documentation/admin-=
guide/media/vivid.rst
index 1306f19..c9d301a 100644
--- a/Documentation/admin-guide/media/vivid.rst
+++ b/Documentation/admin-guide/media/vivid.rst
@@ -328,7 +328,7 @@ and an HDMI input, one input for each input type. Those a=
re described in more
 detail below.
=20
 Special attention has been given to the rate at which new frames become
-available. The jitter will be around 1 jiffie (that depends on the HZ
+available. The jitter will be around 1 jiffy (that depends on the HZ
 configuration of your kernel, so usually 1/100, 1/250 or 1/1000 of a second),
 but the long-term behavior is exactly following the framerate. So a
 framerate of 59.94 Hz is really different from 60 Hz. If the framerate
diff --git a/Documentation/timers/timers-howto.rst b/Documentation/timers/tim=
ers-howto.rst
index 5c169e3..ef7a465 100644
--- a/Documentation/timers/timers-howto.rst
+++ b/Documentation/timers/timers-howto.rst
@@ -19,7 +19,7 @@ it really need to delay in atomic context?" If so...
=20
 ATOMIC CONTEXT:
 	You must use the `*delay` family of functions. These
-	functions use the jiffie estimation of clock speed
+	functions use the jiffy estimation of clock speed
 	and will busy wait for enough loop cycles to achieve
 	the desired delay:
=20
diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst =
b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
index 90a153c..731c266 100644
--- a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
+++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
@@ -109,7 +109,7 @@ para que se ejecute, y la tarea en ejecuci=C3=B3n es inte=
rrumpida.
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 CFS usa una granularidad de nanosegundos y no depende de ning=C3=BAn
-jiffie o detalles como HZ. De este modo, el gestor de tareas CFS no tiene
+jiffy o detalles como HZ. De este modo, el gestor de tareas CFS no tiene
 noci=C3=B3n de "ventanas de tiempo" de la forma en que ten=C3=ADa el gestor =
de
 tareas previo, y tampoco tiene heur=C3=ADsticos. =C3=9Anicamente hay un par=
=C3=A1metro
 central ajustable (se ha de cambiar en CONFIG_SCHED_DEBUG):
diff --git a/arch/arm/mach-versatile/spc.c b/arch/arm/mach-versatile/spc.c
index 5e44170..7900927 100644
--- a/arch/arm/mach-versatile/spc.c
+++ b/arch/arm/mach-versatile/spc.c
@@ -73,7 +73,7 @@
=20
 /*
  * Even though the SPC takes max 3-5 ms to complete any OPP/COMMS
- * operation, the operation could start just before jiffie is about
+ * operation, the operation could start just before jiffy is about
  * to be incremented. So setting timeout value of 20ms =3D 2jiffies@100Hz
  */
 #define TIMEOUT_US	20000
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 10f1f29..14b774b 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -106,7 +106,7 @@ void __init q40_init_IRQ(void)
  * this stuff doesn't really belong here..
  */
=20
-int ql_ticks;              /* 200Hz ticks since last jiffie */
+int ql_ticks;              /* 200Hz ticks since last jiffy */
 static int sound_ticks;
=20
 #define SVOL 45
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/d=
ev-mcelog.c
index a05ac07..a3aa019 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -314,7 +314,7 @@ static ssize_t mce_chrdev_write(struct file *filp, const =
char __user *ubuf,
=20
 	/*
 	 * Need to give user space some time to set everything up,
-	 * so do it a jiffie or two later everywhere.
+	 * so do it a jiffy or two later everywhere.
 	 */
 	schedule_timeout(2);
=20
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 96ad571..e093028 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -980,7 +980,7 @@ static void msg_written_handler(struct ssif_info *ssif_in=
fo, int result,
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			start_get(ssif_info);
 		} else {
-			/* Wait a jiffie then request the next message */
+			/* Wait a jiffy then request the next message */
 			ssif_info->waiting_alert =3D true;
 			ssif_info->retries_left =3D SSIF_RECV_RETRIES;
 			if (!ssif_info->stopping)
diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index 6a1bfcd..cf2ce37 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -402,7 +402,7 @@ static int test_wait_timeout(void *arg)
=20
 	if (dma_fence_wait_timeout(wt.f, false, 2) =3D=3D -ETIME) {
 		if (timer_pending(&wt.timer)) {
-			pr_notice("Timer did not fire within the jiffie!\n");
+			pr_notice("Timer did not fire within the jiffy!\n");
 			err =3D 0; /* not our fault! */
 		} else {
 			pr_err("Wait reported incomplete after timeout\n");
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/=
gem/i915_gem_wait.c
index d4b918f..1f55e62 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
@@ -266,7 +266,7 @@ i915_gem_wait_ioctl(struct drm_device *dev, void *data, s=
truct drm_file *file)
 		if (ret =3D=3D -ETIME && !nsecs_to_jiffies(args->timeout_ns))
 			args->timeout_ns =3D 0;
=20
-		/* Asked to wait beyond the jiffie/scheduler precision? */
+		/* Asked to wait beyond the jiffy/scheduler precision? */
 		if (ret =3D=3D -ETIME && args->timeout_ns)
 			ret =3D -EAGAIN;
 	}
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i=
915/gt/selftest_execlists.c
index 4202df5..222ca7c 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -93,7 +93,7 @@ static int wait_for_reset(struct intel_engine_cs *engine,
 		return -EINVAL;
 	}
=20
-	/* Give the request a jiffie to complete after flushing the worker */
+	/* Give the request a jiffy to complete after flushing the worker */
 	if (i915_request_wait(rq, 0,
 			      max(0l, (long)(timeout - jiffies)) + 1) < 0) {
 		pr_err("%s: hanging request %llx:%lld did not complete\n",
@@ -3426,7 +3426,7 @@ static int live_preempt_timeout(void *arg)
 			cpu_relax();
=20
 		saved_timeout =3D engine->props.preempt_timeout_ms;
-		engine->props.preempt_timeout_ms =3D 1; /* in ms, -> 1 jiffie */
+		engine->props.preempt_timeout_ms =3D 1; /* in ms, -> 1 jiffy */
=20
 		i915_request_get(rq);
 		i915_request_add(rq);
diff --git a/drivers/gpu/drm/i915/i915_utils.c b/drivers/gpu/drm/i915/i915_ut=
ils.c
index 6f9e7b3..f2ba51c 100644
--- a/drivers/gpu/drm/i915/i915_utils.c
+++ b/drivers/gpu/drm/i915/i915_utils.c
@@ -110,7 +110,7 @@ void set_timer_ms(struct timer_list *t, unsigned long tim=
eout)
 	 * Paranoia to make sure the compiler computes the timeout before
 	 * loading 'jiffies' as jiffies is volatile and may be updated in
 	 * the background by a timer tick. All to reduce the complexity
-	 * of the addition and reduce the risk of losing a jiffie.
+	 * of the addition and reduce the risk of losing a jiffy.
 	 */
 	barrier();
=20
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a165cbc..9eafe53 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -279,7 +279,7 @@ v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
 	else
 		args->timeout_ns =3D 0;
=20
-	/* Asked to wait beyond the jiffie/scheduler precision? */
+	/* Asked to wait beyond the jiffy/scheduler precision? */
 	if (ret =3D=3D -ETIME && args->timeout_ns)
 		ret =3D -EAGAIN;
=20
diff --git a/drivers/isdn/mISDN/dsp_cmx.c b/drivers/isdn/mISDN/dsp_cmx.c
index 61cb45c..53fad94 100644
--- a/drivers/isdn/mISDN/dsp_cmx.c
+++ b/drivers/isdn/mISDN/dsp_cmx.c
@@ -82,7 +82,7 @@
  *  - has multiple clocks.
  *  - has no usable clock due to jitter or packet loss (VoIP).
  * In this case the system's clock is used. The clock resolution depends on
- * the jiffie resolution.
+ * the jiffy resolution.
  *
  * If a member joins a conference:
  *
diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/mar=
vell/mvmdio.c
index 9190eff..e1d003f 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -104,7 +104,7 @@ static int orion_mdio_wait_ready(const struct orion_mdio_=
ops *ops,
 			return 0;
 	} else {
 		/* wait_event_timeout does not guarantee a delay of at
-		 * least one whole jiffie, so timeout must be no less
+		 * least one whole jiffy, so timeout must be no less
 		 * than two.
 		 */
 		timeout =3D max(usecs_to_jiffies(MVMDIO_SMI_TIMEOUT), 2);
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b158064..209a389 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -210,7 +210,7 @@ struct xfs_buf {
 	 * success the write is considered to be failed permanently and the
 	 * iodone handler will take appropriate action.
 	 *
-	 * For retry timeouts, we record the jiffie of the first failure. This
+	 * For retry timeouts, we record the jiffy of the first failure. This
 	 * means that we can change the retry timeout for buffers already under
 	 * I/O and thus avoid getting stuck in a retry loop with a long timeout.
 	 *
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index d9f1435..1220f0f 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -418,7 +418,7 @@ extern unsigned long preset_lpj;
 #define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC) +\
                                         TICK_NSEC -1) / (u64)TICK_NSEC))
 /*
- * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
+ * The maximum jiffy value is (MAX_INT >> 1).  Here we translate that
  * into seconds.  The 64-bit case will overflow if we are not careful,
  * so use the messy SH_DIV macro to do it.  Still all constants.
  */
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_i=
nternal.h
index 84ff284..902c20e 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -73,7 +73,7 @@ struct tk_read_base {
  * @overflow_seen:	Overflow warning flag (DEBUG_TIMEKEEPING)
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
- * we need to add to xtime (or xtime corrected for sub jiffie times)
+ * we need to add to xtime (or xtime corrected for sub jiffy times)
  * to get to monotonic time.  Monotonic is pegged at zero at system
  * boot time, so wall_to_monotonic will be negative, however, we will
  * ALWAYS keep the tv_nsec part positive so we can use the usual
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 76bd4fd..8bf8886 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -493,7 +493,7 @@ static u64 __alarm_forward_now(struct alarm *alarm, ktime=
_t interval, bool throt
 		 * promised in the context of posix_timer_fn() never
 		 * materialized, but someone should really work on it.
 		 *
-		 * To prevent DOS fake @now to be 1 jiffie out which keeps
+		 * To prevent DOS fake @now to be 1 jiffy out which keeps
 		 * the overrun accounting correct but creates an
 		 * inconsistency vs. timer_gettime(2).
 		 */
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 60a6484..78c7bd6 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -190,7 +190,7 @@ int clockevents_tick_resume(struct clock_event_device *de=
v)
=20
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST
=20
-/* Limit min_delta to a jiffie */
+/* Limit min_delta to a jiffy */
 #define MIN_DELTA_LIMIT		(NSEC_PER_SEC / HZ)
=20
 /**
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index a023946..e834b2b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1177,7 +1177,7 @@ static inline ktime_t hrtimer_update_lowres(struct hrti=
mer *timer, ktime_t tim,
 	/*
 	 * CONFIG_TIME_LOW_RES indicates that the system has no way to return
 	 * granular time values. For relative timers we add hrtimer_resolution
-	 * (i.e. one jiffie) to prevent short timeouts.
+	 * (i.e. one jiffy) to prevent short timeouts.
 	 */
 	timer->is_rel =3D mode & HRTIMER_MODE_REL;
 	if (timer->is_rel)
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1cc830e..4576aae 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -339,14 +339,14 @@ static enum hrtimer_restart posix_timer_fn(struct hrtim=
er *timer)
 			 * change to the signal handling code.
 			 *
 			 * For now let timers with an interval less than a
-			 * jiffie expire every jiffie and recheck for a
+			 * jiffy expire every jiffy and recheck for a
 			 * valid signal handler.
 			 *
 			 * This avoids interrupt starvation in case of a
 			 * very small interval, which would expire the
 			 * timer immediately again.
 			 *
-			 * Moving now ahead of time by one jiffie tricks
+			 * Moving now ahead of time by one jiffy tricks
 			 * hrtimer_forward() to expire the timer later,
 			 * while it still maintains the overrun accuracy
 			 * for the price of a slight inconsistency in the
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5e021a2..2b38f30 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -365,7 +365,7 @@ static unsigned long round_jiffies_common(unsigned long j=
, int cpu,
 	rem =3D j % HZ;
=20
 	/*
-	 * If the target jiffie is just after a whole second (which can happen
+	 * If the target jiffy is just after a whole second (which can happen
 	 * due to delays of the timer irq, long irq off times etc etc) then
 	 * we should round down to the whole second, not up. Use 1/4th second
 	 * as cutoff for this rounding as an extreme upper bound for this.
@@ -1930,7 +1930,7 @@ static void timer_recalc_next_expiry(struct timer_base =
*base)
 		 * bits are zero, we look at the next level as is. If not we
 		 * need to advance it by one because that's going to be the
 		 * next expiring bucket in that level. base->clk is the next
-		 * expiring jiffie. So in case of:
+		 * expiring jiffy. So in case of:
 		 *
 		 * LVL5 LVL4 LVL3 LVL2 LVL1 LVL0
 		 *  0    0    0    0    0    0
@@ -1995,7 +1995,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expire=
s)
 		return basem;
=20
 	/*
-	 * Round up to the next jiffie. High resolution timers are
+	 * Round up to the next jiffy. High resolution timers are
 	 * off, so the hrtimers are expired in the tick and we need to
 	 * make sure that this tick really expires the timer to avoid
 	 * a ping pong of the nohz stop code.
@@ -2254,7 +2254,7 @@ static inline u64 __get_next_timer_interrupt(unsigned l=
ong basej, u64 basem,
 					     base_global, &tevt);
=20
 	/*
-	 * If the next event is only one jiffie ahead there is no need to call
+	 * If the next event is only one jiffy ahead there is no need to call
 	 * timer migration hierarchy related functions. The value for the next
 	 * global timer in @tevt struct equals then KTIME_MAX. This is also
 	 * true, when the timer base is idle.
@@ -2486,11 +2486,11 @@ static void run_local_timers(void)
 		 * updated. When this update is missed, this isn't a
 		 * problem, as an IPI is executed nevertheless when the CPU
 		 * was idle before. When the CPU wasn't idle but the update
-		 * is missed, then the timer would expire one jiffie late -
+		 * is missed, then the timer would expire one jiffy late -
 		 * bad luck.
 		 *
 		 * Those unlikely corner cases where the worst outcome is only a
-		 * one jiffie delay or a superfluous raise of the softirq are
+		 * one jiffy delay or a superfluous raise of the softirq are
 		 * not that expensive as doing the check always while holding
 		 * the lock.
 		 *
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a..a40aa60 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -97,7 +97,7 @@ config BOOT_PRINTK_DELAY
 	  using "boot_delay=3DN".
=20
 	  It is likely that you would also need to use "lpj=3DM" to preset
-	  the "loops per jiffie" value.
+	  the "loops per jiffy" value.
 	  See a previous boot log for the "lpj" value to use for your
 	  system, and then set "lpj=3DM" before setting "boot_delay=3DN".
 	  NOTE:  Using this option may adversely affect SMP systems.
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 00840d5..04f6398 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -287,7 +287,7 @@ struct batadv_frag_table_entry {
 	/** @lock: lock to protect the list of fragments */
 	spinlock_t lock;
=20
-	/** @timestamp: time (jiffie) of last received fragment */
+	/** @timestamp: time (jiffy) of last received fragment */
 	unsigned long timestamp;
=20
 	/** @seqno: sequence number of the fragments in the list */


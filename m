Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC2161B7F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2020 20:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgBQTTQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 17 Feb 2020 14:19:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34646 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbgBQTSw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 17 Feb 2020 14:18:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3lup-0006Bl-3X; Mon, 17 Feb 2020 20:18:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9FFA41C20B8;
        Mon, 17 Feb 2020 20:18:46 +0100 (CET)
Date:   Mon, 17 Feb 2020 19:18:46 -0000
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Allow architectures to provide the vdso
 data pointer
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cabf97996602ef07223fec30c005df78e5ed41b2e=2E15803?=
 =?utf-8?q?99657=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
References: =?utf-8?q?=3Cabf97996602ef07223fec30c005df78e5ed41b2e=2E158039?=
 =?utf-8?q?9657=2Egit=2Echristophe=2Eleroy=40c-s=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <158196712623.13786.1563593496476976142.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e876f0b69dc993e86ca7795e63e98385aa9a7ef3
Gitweb:        https://git.kernel.org/tip/e876f0b69dc993e86ca7795e63e98385aa9a7ef3
Author:        Christophe Leroy <christophe.leroy@c-s.fr>
AuthorDate:    Fri, 07 Feb 2020 13:39:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 20:12:18 +01:00

lib/vdso: Allow architectures to provide the vdso data pointer

On powerpc, __arch_get_vdso_data() clobbers the link register, requiring
the caller to save it.

As the parent function already has to set a stack frame and saves the link
register before calling the C vdso function, retrieving the vdso data
pointer there is less overhead.

Split out the functional code from the __cvdso.*() interfaces into new
static functions which can either be called from the existing interfaces
with the vdso data pointer supplied via __arch_get_vdso_data() or directly
from ASM code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/abf97996602ef07223fec30c005df78e5ed41b2e.1580399657.git.christophe.leroy@c-s.fr
Link: https://lkml.kernel.org/r/20200207124403.965789141@linutronix.de



---
 lib/vdso/gettimeofday.c | 72 +++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index b95aef9..72d282f 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -233,9 +233,9 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 }
 
 static __maybe_unused int
-__cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
+__cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
+			     struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
 	u32 msk;
 
 	/* Check for negative values or invalid clocks */
@@ -260,23 +260,31 @@ __cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
 }
 
 static __maybe_unused int
-__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+__cvdso_clock_gettime_data(const struct vdso_data *vd, clockid_t clock,
+			   struct __kernel_timespec *ts)
 {
-	int ret = __cvdso_clock_gettime_common(clock, ts);
+	int ret = __cvdso_clock_gettime_common(vd, clock, ts);
 
 	if (unlikely(ret))
 		return clock_gettime_fallback(clock, ts);
 	return 0;
 }
 
+static __maybe_unused int
+__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime_data(__arch_get_vdso_data(), clock, ts);
+}
+
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
+__cvdso_clock_gettime32_data(const struct vdso_data *vd, clockid_t clock,
+			     struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
 	int ret;
 
-	ret = __cvdso_clock_gettime_common(clock, &ts);
+	ret = __cvdso_clock_gettime_common(vd, clock, &ts);
 
 	if (unlikely(ret))
 		return clock_gettime32_fallback(clock, res);
@@ -287,12 +295,18 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 
 	return ret;
 }
+
+static __maybe_unused int
+__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_gettime32_data(__arch_get_vdso_data(), clock, res);
+}
 #endif /* BUILD_VDSO32 */
 
 static __maybe_unused int
-__cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+__cvdso_gettimeofday_data(const struct vdso_data *vd,
+			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
 
 	if (likely(tv != NULL)) {
 		struct __kernel_timespec ts;
@@ -316,10 +330,16 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 	return 0;
 }
 
+static __maybe_unused int
+__cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+{
+	return __cvdso_gettimeofday_data(__arch_get_vdso_data(), tv, tz);
+}
+
 #ifdef VDSO_HAS_TIME
-static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
+static __maybe_unused __kernel_old_time_t
+__cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
 	__kernel_old_time_t t;
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
@@ -333,13 +353,18 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time
 
 	return t;
 }
+
+static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
+{
+	return __cvdso_time_data(__arch_get_vdso_data(), time);
+}
 #endif /* VDSO_HAS_TIME */
 
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
+int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
+				struct __kernel_timespec *res)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
 	u32 msk;
 	u64 ns;
 
@@ -378,23 +403,31 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 }
 
 static __maybe_unused
-int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+int __cvdso_clock_getres_data(const struct vdso_data *vd, clockid_t clock,
+			      struct __kernel_timespec *res)
 {
-	int ret = __cvdso_clock_getres_common(clock, res);
+	int ret = __cvdso_clock_getres_common(vd, clock, res);
 
 	if (unlikely(ret))
 		return clock_getres_fallback(clock, res);
 	return 0;
 }
 
+static __maybe_unused
+int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres_data(__arch_get_vdso_data(), clock, res);
+}
+
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
+__cvdso_clock_getres_time32_data(const struct vdso_data *vd, clockid_t clock,
+				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
 	int ret;
 
-	ret = __cvdso_clock_getres_common(clock, &ts);
+	ret = __cvdso_clock_getres_common(vd, clock, &ts);
 
 	if (unlikely(ret))
 		return clock_getres32_fallback(clock, res);
@@ -405,5 +438,12 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	}
 	return ret;
 }
+
+static __maybe_unused int
+__cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32_data(__arch_get_vdso_data(),
+						clock, res);
+}
 #endif /* BUILD_VDSO32 */
 #endif /* VDSO_HAS_CLOCK_GETRES */

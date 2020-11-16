Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014502B5209
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 21:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbgKPUIg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 15:08:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbgKPUIc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 15:08:32 -0500
Date:   Mon, 16 Nov 2020 20:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605557309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0vimLuqM8jdVFuRcftBEKkrbfA8mfIwyk26c32Mar0=;
        b=LF4M7FRKGnRKxUzh3SqnFKesuVbckAn7Zbh+radsjyl716QcXON8zH2OSCvWPiGCImWSd2
        9Khu/tJ/5Y1i3vamr/aZ5ZlDl11X2o7mCO3hlRpjhjF4VnulUIn6MkKvmRUVNptfhq1rxf
        25lZOMc3KlfRtDBICQKWaYHQ+DFHgDdKrRZHqVNiauYbpdTKPgzkgPSE+Ak0OyHCKcz/Qe
        dpa331/YZk1nylcEGolhyObtrKmU72l2ye6F67jnQkX9Qda9+c2KBuvHDG6YtaUOHvL50f
        0EgoSwDqApAWTFKG7s5jx+LyqgBsEGk+mbjgL9GSIv3VfCbzdNGne7NejnE9Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605557309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0vimLuqM8jdVFuRcftBEKkrbfA8mfIwyk26c32Mar0=;
        b=gR4mQV3z+gEtVXLObNaJCK1qNbZa+0o3RtjB0q59hsxUoI6SSD7IctRlkoKca5WWErRC5B
        sq0E9BzOSwnkeqAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/power/cpupower: Read energy_perf_bias from sysfs
Cc:     Borislav Petkov <bp@suse.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029190259.3476-2-bp@alien8.de>
References: <20201029190259.3476-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160555730888.11244.3110463362645056723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     8113ab20e850491b4144a1a64246f07a2d737a49
Gitweb:        https://git.kernel.org/tip/8113ab20e850491b4144a1a64246f07a2d737a49
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 15 Oct 2020 12:28:58 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 16 Nov 2020 17:42:12 +01:00

tools/power/cpupower: Read energy_perf_bias from sysfs

... instead of poking at the MSR. For that, move the accessor functions
to misc.c and add a sysfs-writing function too.

There should be no functional changes resulting from this.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>
Link: https://lkml.kernel.org/r/20201029190259.3476-2-bp@alien8.de
---
 tools/power/cpupower/lib/cpupower.c          | 23 ++++++++-
 tools/power/cpupower/lib/cpupower_intern.h   |  5 ++-
 tools/power/cpupower/utils/cpupower-info.c   |  2 +-
 tools/power/cpupower/utils/cpupower-set.c    |  2 +-
 tools/power/cpupower/utils/helpers/helpers.h |  8 +--
 tools/power/cpupower/utils/helpers/misc.c    | 48 +++++++++++++++++++-
 tools/power/cpupower/utils/helpers/msr.c     | 28 +-----------
 7 files changed, 81 insertions(+), 35 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 3656e69..3f7d0c0 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -16,8 +16,8 @@
 
 unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
 {
-	int fd;
 	ssize_t numread;
+	int fd;
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -35,6 +35,27 @@ unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
 	return (unsigned int) numread;
 }
 
+unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen)
+{
+	ssize_t numwritten;
+	int fd;
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		return 0;
+
+	numwritten = write(fd, buf, buflen - 1);
+	if (numwritten < 1) {
+		perror(path);
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+
+	return (unsigned int) numwritten;
+}
+
 /*
  * Detect whether a CPU is online
  *
diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
index 4887c76..ac1112b 100644
--- a/tools/power/cpupower/lib/cpupower_intern.h
+++ b/tools/power/cpupower/lib/cpupower_intern.h
@@ -1,6 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define PATH_TO_CPU "/sys/devices/system/cpu/"
+
+#ifndef MAX_LINE_LEN
 #define MAX_LINE_LEN 4096
+#endif
+
 #define SYSFS_PATH_MAX 255
 
 unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);
+unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen);
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 0ba61a2..06345b5 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -101,7 +101,7 @@ int cmd_info(int argc, char **argv)
 		}
 
 		if (params.perf_bias) {
-			ret = msr_intel_get_perf_bias(cpu);
+			ret = cpupower_intel_get_perf_bias(cpu);
 			if (ret < 0) {
 				fprintf(stderr,
 			_("Could not read perf-bias value[%d]\n"), ret);
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 052044d..180d5ba 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -95,7 +95,7 @@ int cmd_set(int argc, char **argv)
 		}
 
 		if (params.perf_bias) {
-			ret = msr_intel_set_perf_bias(cpu, perf_bias);
+			ret = cpupower_intel_set_perf_bias(cpu, perf_bias);
 			if (ret) {
 				fprintf(stderr, _("Error setting perf-bias "
 						  "value on CPU %d\n"), cpu);
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index c258eec..37dac16 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -105,8 +105,8 @@ extern struct cpupower_cpu_info cpupower_cpu_info;
 extern int read_msr(int cpu, unsigned int idx, unsigned long long *val);
 extern int write_msr(int cpu, unsigned int idx, unsigned long long val);
 
-extern int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val);
-extern int msr_intel_get_perf_bias(unsigned int cpu);
+extern int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val);
+extern int cpupower_intel_get_perf_bias(unsigned int cpu);
 extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
 
 /* Read/Write msr ****************************/
@@ -150,9 +150,9 @@ static inline int read_msr(int cpu, unsigned int idx, unsigned long long *val)
 { return -1; };
 static inline int write_msr(int cpu, unsigned int idx, unsigned long long val)
 { return -1; };
-static inline int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val)
+static inline int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 { return -1; };
-static inline int msr_intel_get_perf_bias(unsigned int cpu)
+static inline int cpupower_intel_get_perf_bias(unsigned int cpu)
 { return -1; };
 static inline unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
 { return 0; };
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index f406adc..e8f8f64 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -1,7 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+
 #if defined(__i386__) || defined(__x86_64__)
 
 #include "helpers/helpers.h"
+#include "helpers/sysfs.h"
+
+#include "cpupower_intern.h"
 
 #define MSR_AMD_HWCR	0xc0010015
 
@@ -40,4 +48,44 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 		*support = *active = 1;
 	return 0;
 }
+
+int cpupower_intel_get_perf_bias(unsigned int cpu)
+{
+	char linebuf[MAX_LINE_LEN];
+	char path[SYSFS_PATH_MAX];
+	unsigned long val;
+	char *endp;
+
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
+		return -1;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
+
+	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
+		return -1;
+
+	val = strtol(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return -1;
+
+	return val;
+}
+
+int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[3] = {};
+
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
+		return -1;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
+	snprintf(linebuf, sizeof(linebuf), "%d", val);
+
+	if (cpupower_write_sysfs(path, linebuf, 3) <= 0)
+		return -1;
+
+	return 0;
+}
+
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/msr.c b/tools/power/cpupower/utils/helpers/msr.c
index ab99507..8b0b6be 100644
--- a/tools/power/cpupower/utils/helpers/msr.c
+++ b/tools/power/cpupower/utils/helpers/msr.c
@@ -11,7 +11,6 @@
 /* Intel specific MSRs */
 #define MSR_IA32_PERF_STATUS		0x198
 #define MSR_IA32_MISC_ENABLES		0x1a0
-#define MSR_IA32_ENERGY_PERF_BIAS	0x1b0
 #define MSR_NEHALEM_TURBO_RATIO_LIMIT	0x1ad
 
 /*
@@ -73,33 +72,6 @@ int write_msr(int cpu, unsigned int idx, unsigned long long val)
 	return -1;
 }
 
-int msr_intel_get_perf_bias(unsigned int cpu)
-{
-	unsigned long long val;
-	int ret;
-
-	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
-		return -1;
-
-	ret = read_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &val);
-	if (ret)
-		return ret;
-	return val;
-}
-
-int msr_intel_set_perf_bias(unsigned int cpu, unsigned int val)
-{
-	int ret;
-
-	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS))
-		return -1;
-
-	ret = write_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, val);
-	if (ret)
-		return ret;
-	return 0;
-}
-
 unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)
 {
 	unsigned long long val;

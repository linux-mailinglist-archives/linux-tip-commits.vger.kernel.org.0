Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0A32B5204
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 21:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgKPUIc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbgKPUIa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 15:08:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9206FC0613CF;
        Mon, 16 Nov 2020 12:08:30 -0800 (PST)
Date:   Mon, 16 Nov 2020 20:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605557308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNtM+Tqm8xc4Yhv0kGDgHY27rB8uw2uBmAbWvfTcnjo=;
        b=bc2O+p8XDY6crVD4O+2wrSuebrIKlCSb9N6ouVaGCOQJXixoj0dmyatbBIIHhuM7nb07c2
        8nfzSdlxfgFz1xufW887FzfZ7RuPJVtJ4pjMTFmeMWLSQ3tDS7BHpjpZZuNGlw7nVCraGw
        vUTiQm2Wz7JyvdeAvRkovMud+QBJef/8YYQc4QbzwncCATq5uWDMOWoV4t8oWqoXzLeQ1v
        1GCcU6MLQmw/zX8JYu0jtUDkzqnYVD5mGe7icqpKUiz/dEf4ejo2ZI+B9MmmKwHfcaxfbx
        ObZcwcaLc5TNp7guki9CvOyFoCZs/WqfPDLyLggkkE4tIAmIp/FrZkK/fDppyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605557308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNtM+Tqm8xc4Yhv0kGDgHY27rB8uw2uBmAbWvfTcnjo=;
        b=Gkb7MRmDYyZXAQlJgCPm0+yPk3VxgFM7uL+dn7NQ8HxlkU4RtA3w6nW239POqTn39t2TyA
        eb0VWktYOFglSxBQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/power/x86_energy_perf_policy: Read
 energy_perf_bias from sysfs
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029190259.3476-4-bp@alien8.de>
References: <20201029190259.3476-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160555730775.11244.6939969381086396057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     fe0a5788624c8b8f113a35bbe4636e37f9321241
Gitweb:        https://git.kernel.org/tip/fe0a5788624c8b8f113a35bbe4636e37f9321241
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 15 Oct 2020 14:58:48 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 16 Nov 2020 17:43:28 +01:00

tools/power/x86_energy_perf_policy: Read energy_perf_bias from sysfs

... and stop poking at the MSR directly.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201029190259.3476-4-bp@alien8.de
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 3fe1eed..ad6aed1 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -91,6 +91,9 @@ unsigned int has_hwp_request_pkg;	/* IA32_HWP_REQUEST_PKG */
 
 unsigned int bdx_highest_ratio;
 
+#define PATH_TO_CPU "/sys/devices/system/cpu/"
+#define SYSFS_PATH_MAX 255
+
 /*
  * maintain compatibility with original implementation, but don't document it:
  */
@@ -668,6 +671,48 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
 	return 0;
 }
 
+static unsigned int read_sysfs(const char *path, char *buf, size_t buflen)
+{
+	ssize_t numread;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return 0;
+
+	numread = read(fd, buf, buflen - 1);
+	if (numread < 1) {
+		close(fd);
+		return 0;
+	}
+
+	buf[numread] = '\0';
+	close(fd);
+
+	return (unsigned int) numread;
+}
+
+static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
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
+		perror("write failed\n");
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+
+	return (unsigned int) numwritten;
+}
+
 void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
 {
 	if (cpu != -1)
@@ -745,17 +790,61 @@ void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int ms
 	put_msr(cpu, msr_offset, msr);
 }
 
+static int get_epb(int cpu)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[3];
+	char *endp;
+	long val;
+
+	if (!has_epb)
+		return -1;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
+
+	if (!read_sysfs(path, linebuf, 3))
+		return -1;
+
+	val = strtol(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return -1;
+
+	return (int)val;
+}
+
+static int set_epb(int cpu, int val)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[3];
+	char *endp;
+	int ret;
+
+	if (!has_epb)
+		return -1;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
+	snprintf(linebuf, sizeof(linebuf), "%d", val);
+
+	ret = write_sysfs(path, linebuf, 3);
+	if (ret <= 0)
+		return -1;
+
+	val = strtol(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return -1;
+
+	return (int)val;
+}
+
 int print_cpu_msrs(int cpu)
 {
-	unsigned long long msr;
 	struct msr_hwp_request req;
 	struct msr_hwp_cap cap;
+	int epb;
 
-	if (has_epb) {
-		get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
-
-		printf("cpu%d: EPB %u\n", cpu, (unsigned int) msr);
-	}
+	epb = get_epb(cpu);
+	if (epb >= 0)
+		printf("cpu%d: EPB %u\n", cpu, (unsigned int) epb);
 
 	if (!has_hwp)
 		return 0;
@@ -1038,15 +1127,15 @@ int enable_hwp_on_cpu(int cpu)
 int update_cpu_msrs(int cpu)
 {
 	unsigned long long msr;
-
+	int epb;
 
 	if (update_epb) {
-		get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
-		put_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, new_epb);
+		epb = get_epb(cpu);
+		set_epb(cpu, new_epb);
 
 		if (verbose)
 			printf("cpu%d: ENERGY_PERF_BIAS old: %d new: %d\n",
-				cpu, (unsigned int) msr, (unsigned int) new_epb);
+				cpu, epb, (unsigned int) new_epb);
 	}
 
 	if (update_turbo) {

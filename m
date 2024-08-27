Return-Path: <linux-tip-commits+bounces-2125-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F831960312
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308C31F215EE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669CA1386C6;
	Tue, 27 Aug 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="25wpZmBS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0537CsNm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886E4CB4E;
	Tue, 27 Aug 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743855; cv=none; b=oSOfSMhcrU6MIf8+P3FWfOwcvlsCnP+4T0PnCaqFSgE9M8v4VtRoeGKU3kHOLLdvFYA0WnDddkGwinvx6se5dLF1TI76VDHEOymBR+An2nUouj4aLdeirZ61xWg9B5CM0IuP/BV9jCWh/s4/L7DQOXVJerPfTcIQ19L9WRHy7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743855; c=relaxed/simple;
	bh=8Wr7BZGjfMI6smYAll4wdjlqgjfMGeH2n4+MLitHDZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lZDbRUqBaNXQiGhyacA25ezvyX7ZWYTzgSnzfJc+ja9MUZ6QPY0sCow22cB/EbxInTj4zoeN0xqBeCn23fa+KNKUjsg0SJTgxWH9xbmJF++RihYxStnbzTIBsYrz1f58u/PfrK6AeDs7xBCrj5GF/uQPJS+h7HK3FRA2X/JYwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=25wpZmBS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0537CsNm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 07:30:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724743851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLbW1K/uWENKz/WOLceLJg4xthcdObZ8jYsBAAk9RDQ=;
	b=25wpZmBSAnYTBBlq4VKOzjd++4Rhu61Tx5NHZElRKlpNfrmjHCFSMZpLNmGJVsXdX8zCeP
	Ge1x105+sW2nWWXpxpbx4v91sq4GwW31wVJn+Igs3lOvFdJqhAH+QMZJcmykUuCsmLRmrb
	zq3RqBYdlZPhuvhG2ltlMxG3zbotAERiO7iJUkXI8SqJ3V0jwR6D5k+ard7yXKWidyrsSp
	3SPRQ2oFee0tH/rC2UnWOjuPk/ZktV9H0smKuhkxgYZIo8zJE9CjVdP/3T8OHo5vYyKAJk
	nq+lsB3CQfso1oHJVouY+PrrDNGv4rtq8Y6udt93X2pfSelveWUgc5WdD8mvHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724743851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLbW1K/uWENKz/WOLceLJg4xthcdObZ8jYsBAAk9RDQ=;
	b=0537CsNmqYIP3vwXopJmOGnJEzCaULOa0kOHxdYP+LAccrEmW7A4uJyNPrIdOwvto6ul/W
	8Tk1P7T4/i32NoCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] Documentation/srso: Document a method for checking
 safe RET operates properly
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240731160531.28640-1-bp@kernel.org>
References: <20240731160531.28640-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172474385088.2215.1127927943478368007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     40153505259d8dc0e4ea6889fca5e567c42b76a9
Gitweb:        https://git.kernel.org/tip/40153505259d8dc0e4ea6889fca5e567c42b76a9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 31 Jul 2024 18:05:31 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 27 Aug 2024 09:16:35 +02:00

Documentation/srso: Document a method for checking safe RET operates properly

Add a method to quickly verify whether safe RET operates properly on
a given system using perf tool.

Also, add a selftest which does the same thing.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240731160531.28640-1-bp@kernel.org
---
 Documentation/admin-guide/hw-vuln/srso.rst | 69 +++++++++++++++++++++-
 tools/testing/selftests/x86/Makefile       |  2 +-
 tools/testing/selftests/x86/srso.c         | 70 +++++++++++++++++++++-
 3 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/srso.c

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index 4bd3ce3..2ad1c05 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -158,3 +158,72 @@ poisoned BTB entry and using that safe one for all function returns.
 In older Zen1 and Zen2, this is accomplished using a reinterpretation
 technique similar to Retbleed one: srso_untrain_ret() and
 srso_safe_ret().
+
+Checking the safe RET mitigation actually works
+-----------------------------------------------
+
+In case one wants to validate whether the SRSO safe RET mitigation works
+on a kernel, one could use two performance counters
+
+* PMC_0xc8 - Count of RET/RET lw retired
+* PMC_0xc9 - Count of RET/RET lw retired mispredicted
+
+and compare the number of RETs retired properly vs those retired
+mispredicted, in kernel mode. Another way of specifying those events
+is::
+
+        # perf list ex_ret_near_ret
+
+        List of pre-defined events (to be used in -e or -M):
+
+        core:
+          ex_ret_near_ret
+               [Retired Near Returns]
+          ex_ret_near_ret_mispred
+               [Retired Near Returns Mispredicted]
+
+Either the command using the event mnemonics::
+
+        # perf stat -e ex_ret_near_ret:k -e ex_ret_near_ret_mispred:k sleep 10s
+
+or using the raw PMC numbers::
+
+        # perf stat -e cpu/event=0xc8,umask=0/k -e cpu/event=0xc9,umask=0/k sleep 10s
+
+should give the same amount. I.e., every RET retired should be
+mispredicted::
+
+        [root@brent: ~/kernel/linux/tools/perf> ./perf stat -e cpu/event=0xc8,umask=0/k -e cpu/event=0xc9,umask=0/k sleep 10s
+
+         Performance counter stats for 'sleep 10s':
+
+                   137,167      cpu/event=0xc8,umask=0/k
+                   137,173      cpu/event=0xc9,umask=0/k
+
+              10.004110303 seconds time elapsed
+
+               0.000000000 seconds user
+               0.004462000 seconds sys
+
+vs the case when the mitigation is disabled (spec_rstack_overflow=off)
+or not functioning properly, showing usually a lot smaller number of
+mispredicted retired RETs vs the overall count of retired RETs during
+a workload::
+
+       [root@brent: ~/kernel/linux/tools/perf> ./perf stat -e cpu/event=0xc8,umask=0/k -e cpu/event=0xc9,umask=0/k sleep 10s
+
+        Performance counter stats for 'sleep 10s':
+
+                  201,627      cpu/event=0xc8,umask=0/k
+                    4,074      cpu/event=0xc9,umask=0/k
+
+             10.003267252 seconds time elapsed
+
+              0.002729000 seconds user
+              0.000000000 seconds sys
+
+Also, there is a selftest which performs the above, go to
+tools/testing/selftests/x86/ and do::
+
+        make srso
+        ./srso
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5c8757a..d51249f 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -77,7 +77,7 @@ all_32: $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
-EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
+EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64) srso
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $< $(EXTRA_FILES) -lrt -ldl -lm
diff --git a/tools/testing/selftests/x86/srso.c b/tools/testing/selftests/x86/srso.c
new file mode 100644
index 0000000..394ec8b
--- /dev/null
+++ b/tools/testing/selftests/x86/srso.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/perf_event.h>
+#include <cpuid.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+int main(void)
+{
+	struct perf_event_attr ret_attr, mret_attr;
+	long long count_rets, count_rets_mispred;
+	int rrets_fd, mrrets_fd;
+	unsigned int cpuid1_eax, b, c, d;
+
+	__cpuid(1, cpuid1_eax, b, c, d);
+
+	if (cpuid1_eax < 0x00800f00 ||
+	    cpuid1_eax > 0x00afffff) {
+		fprintf(stderr, "This needs to run on a Zen[1-4] machine (CPUID(1).EAX: 0x%x). Exiting...\n", cpuid1_eax);
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&ret_attr, 0, sizeof(struct perf_event_attr));
+	memset(&mret_attr, 0, sizeof(struct perf_event_attr));
+
+	ret_attr.type = mret_attr.type = PERF_TYPE_RAW;
+	ret_attr.size = mret_attr.size = sizeof(struct perf_event_attr);
+	ret_attr.config = 0xc8;
+	mret_attr.config = 0xc9;
+	ret_attr.disabled = mret_attr.disabled = 1;
+	ret_attr.exclude_user = mret_attr.exclude_user = 1;
+	ret_attr.exclude_hv = mret_attr.exclude_hv = 1;
+
+	rrets_fd = syscall(SYS_perf_event_open, &ret_attr, 0, -1, -1, 0);
+	if (rrets_fd == -1) {
+		perror("opening retired RETs fd");
+		exit(EXIT_FAILURE);
+	}
+
+	mrrets_fd = syscall(SYS_perf_event_open, &mret_attr, 0, -1, -1, 0);
+	if (mrrets_fd == -1) {
+		perror("opening retired mispredicted RETs fd");
+		exit(EXIT_FAILURE);
+	}
+
+	ioctl(rrets_fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(mrrets_fd, PERF_EVENT_IOC_RESET, 0);
+
+	ioctl(rrets_fd, PERF_EVENT_IOC_ENABLE, 0);
+	ioctl(mrrets_fd, PERF_EVENT_IOC_ENABLE, 0);
+
+	printf("Sleeping for 10 seconds\n");
+	sleep(10);
+
+	ioctl(rrets_fd, PERF_EVENT_IOC_DISABLE, 0);
+	ioctl(mrrets_fd, PERF_EVENT_IOC_DISABLE, 0);
+
+	read(rrets_fd, &count_rets, sizeof(long long));
+	read(mrrets_fd, &count_rets_mispred, sizeof(long long));
+
+	printf("RETs: (%lld retired <-> %lld mispredicted)\n",
+		count_rets, count_rets_mispred);
+	printf("SRSO Safe-RET mitigation works correctly if both counts are almost equal.\n");
+
+	return 0;
+}


Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2859DE486
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Oct 2019 08:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfJUG0y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Oct 2019 02:26:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33210 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfJUG0w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Oct 2019 02:26:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMR9U-00029E-83; Mon, 21 Oct 2019 08:26:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A621E1C0494;
        Mon, 21 Oct 2019 08:26:44 +0200 (CEST)
Date:   Mon, 21 Oct 2019 06:26:44 -0000
From:   "tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf jvmti: Link against tools/lib/ctype.h to have
 weak strlcpy()
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191008093841.59387-1-tmricht@linux.ibm.com>
References: <20191008093841.59387-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <157163920447.29376.9814329868243162602.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6a6fac11b11299aa5bd8532ea863fc2f652af2b6
Gitweb:        https://git.kernel.org/tip/6a6fac11b11299aa5bd8532ea863fc2f652af2b6
Author:        Thomas Richter <tmricht@linux.ibm.com>
AuthorDate:    Tue, 08 Oct 2019 11:38:41 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 11:47:38 -03:00

perf jvmti: Link against tools/lib/ctype.h to have weak strlcpy()

The build of file libperf-jvmti.so succeeds but the resulting
object fails to load:

 # ~/linux/tools/perf/perf record -k mono -- java  \
      -XX:+PreserveFramePointer \
      -agentpath:/root/linux/tools/perf/libperf-jvmti.so \
       hog 100000 123450
  Error occurred during initialization of VM
  Could not find agent library /root/linux/tools/perf/libperf-jvmti.so
      in absolute path, with error:
      /root/linux/tools/perf/libperf-jvmti.so: undefined symbol: _ctype

Add the missing _ctype symbol into the build script.

Fixes: 79743bc927f6 ("perf jvmti: Link against tools/lib/string.o to have weak strlcpy()")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20191008093841.59387-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/jvmti/Build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
index 1e148bb..202cada 100644
--- a/tools/perf/jvmti/Build
+++ b/tools/perf/jvmti/Build
@@ -2,7 +2,7 @@ jvmti-y += libjvmti.o
 jvmti-y += jvmti_agent.o
 
 # For strlcpy
-jvmti-y += libstring.o
+jvmti-y += libstring.o libctype.o
 
 CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
 CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
@@ -15,3 +15,7 @@ CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PE
 $(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)jvmti/libctype.o: ../lib/ctype.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)

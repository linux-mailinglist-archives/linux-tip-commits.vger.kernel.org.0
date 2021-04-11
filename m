Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF3135B538
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhDKNqE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:46:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbhDKNpI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:45:08 -0400
Date:   Sun, 11 Apr 2021 13:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iWUx0NewCmGhOGpZYTkvDhlanCzorNLztPBpfz+g1xo=;
        b=cDowa3CDEC6lKCZXJg6FPPOPN5Gn1wm0nbGsMKMeFkZVkQ9KMq88MfVHrwNRLZbkHWhZcL
        jGmvMOUabEHuH7w7FdxnsgIBlre0slog67GIEgNE6dkmNIcXIYiXHVZXGX7TbXtWjR/FBc
        jqAFyNRVHZcdu8EwB9j4ln73rQXA6dwaSupG46ApO7nrAJgvd8bq1Jbp5Q31POFT4JZvB7
        BdwUPKDxLuUev13kLtK2jPABPP0RQAa7lsyIA5nDqLSn+IeYucooOrJx0iN4wCK5EsRN8U
        pnxJ4KGryLhUzvOL/vdP/VaCxXMiyw6kl/wbKK2qS8BVqCFwE7pne9DKT1zidg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iWUx0NewCmGhOGpZYTkvDhlanCzorNLztPBpfz+g1xo=;
        b=hW9t+MGsFW21pRReqKrTFlW3Fa3m0l8p6XBtMHBZ66f42dy0pqPXgYH/PkNuFh+hT867wj
        jYzD6aNg2gRg2dDQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Add missing license and copyright headers
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814863439.29796.5850236988240567936.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bd0ccc4afca2d6ae0029cae35c4f1d2e2ade7579
Gitweb:        https://git.kernel.org/tip/bd0ccc4afca2d6ae0029cae35c4f1d2e2ade7579
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 15 Jan 2021 18:09:53 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:27:43 -08:00

kcsan: Add missing license and copyright headers

Adds missing license and/or copyright headers for KCSAN source files.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 3 +++
 include/linux/kcsan-checks.h      | 6 ++++++
 include/linux/kcsan.h             | 7 +++++++
 kernel/kcsan/atomic.h             | 5 +++++
 kernel/kcsan/core.c               | 5 +++++
 kernel/kcsan/debugfs.c            | 5 +++++
 kernel/kcsan/encoding.h           | 5 +++++
 kernel/kcsan/kcsan.h              | 3 ++-
 kernel/kcsan/report.c             | 5 +++++
 kernel/kcsan/selftest.c           | 5 +++++
 10 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index be7a0b0..d85ce23 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2019, Google LLC.
+
 The Kernel Concurrency Sanitizer (KCSAN)
 ========================================
 
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index cf14840..9fd0ad8 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -1,4 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KCSAN access checks and modifiers. These can be used to explicitly check
+ * uninstrumented accesses, or change KCSAN checking behaviour of accesses.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _LINUX_KCSAN_CHECKS_H
 #define _LINUX_KCSAN_CHECKS_H
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 53340d8..fc266ec 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -1,4 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. Public interface and
+ * data structures to set up runtime. See kcsan-checks.h for explicit checks and
+ * modifiers. For more info please see Documentation/dev-tools/kcsan.rst.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _LINUX_KCSAN_H
 #define _LINUX_KCSAN_H
diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index 75fe701..530ae1b 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Rules for implicitly atomic memory accesses.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _KERNEL_KCSAN_ATOMIC_H
 #define _KERNEL_KCSAN_ATOMIC_H
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 23e7acb..45c821d 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN core runtime.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 209ad8d..c1dd02f 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN debugfs interface.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 7ee4055..170a2bb 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KCSAN watchpoint encoding.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _KERNEL_KCSAN_ENCODING_H
 #define _KERNEL_KCSAN_ENCODING_H
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 87ccdb3..9881099 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 /*
  * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
  * see Documentation/dev-tools/kcsan.rst.
+ *
+ * Copyright (C) 2019, Google LLC.
  */
 
 #ifndef _KERNEL_KCSAN_KCSAN_H
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index d3bf87e..13dce3c 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN reporting.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #include <linux/debug_locks.h>
 #include <linux/delay.h>
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 9014a3a..7f29cb0 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN short boot-time selftests.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 

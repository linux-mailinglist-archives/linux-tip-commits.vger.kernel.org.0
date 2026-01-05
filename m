Return-Path: <linux-tip-commits+bounces-7819-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C22CF4AA5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A53932E79F5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8921834A3DB;
	Mon,  5 Jan 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GsBxeX2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQzkadit"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079B346FB0;
	Mon,  5 Jan 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628494; cv=none; b=NrL5FPqo6YCjLJs9FNwlJrHT70ao7hEhzBCeOrCZPQaiJ6yOHJI7F5laEZSOG7ujUnB8tVgYa2R3Z+PQjSAsDqKvGNurxY8mQnyGFSoUmCV3nx2EyOeOFK9uTlL+oyUxyIarrsv8AGn/oK4JNrTlCyOxl1UtOjOy3MXAqYACoR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628494; c=relaxed/simple;
	bh=7lF8A2+iL+J2C6U49bqR3FNe31i4VJl4xPNauaf1dks=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uvnRMOiIQzVUrK6/mazwbNuCgFQWIUSkjjBnnIECK3FsJJ05qIGpIohauvvMKydUKVuGDDNLqllCZm7XRmDKAFah6XoGPyLFrqO2ILcFC618H866kDEVKpjPAaXgf4MWNWEoGloiVRjXPEEmCZMT3Y/v4CEJSEWHCWowBc+Yn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GsBxeX2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQzkadit; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyQqQ3orl4Rj7LeTSNden2jyUvVfURBl/pk7o/8ErQ=;
	b=0GsBxeX27/NNXWRKEa75HGGKc9Vt7gQtHSnxJByVtOGRFz42hZ0jGnXiwh+dbTDYJKnJ4N
	z+vhxcUiQ/y+TFtvYYzltOXs9ojAF/++IMpCggYGpZXjhNFAM9/hCVyz5U8KzPTwxG2EBN
	coFcBl5OzC+k5I2xeGD5GxnBY3YAlzqr//DWvak1cHy3QGfMOn4l+fky5BFAbZzoY7Y6am
	k65xezUuFsiMD9Fadh7bWd5k4/OiTvZ9s1EAEJaYVk5GP3lKiBSTY+RfQawnGcjOj9L9xK
	edILisiLGS5nlIWF+yQIIunAUCULCobwy4enUanYKRd5HWAqeNs3Gnw/zg9VYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqyQqQ3orl4Rj7LeTSNden2jyUvVfURBl/pk7o/8ErQ=;
	b=BQzkadit5bJMyxtRtFjDugHhKzjlhlErAg/6kIlo5ly4WwWJn/6GuzpulgxkEBymT9z1lx
	sXMvtMEu3cqphaBQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] compiler-context-analysis: Add test stub
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-4-elver@google.com>
References: <20251219154418.3592607-4-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762848507.510.4572526344684889633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9b00c1609deeb7d6f68a61f3ec6988ab7e6f4535
Gitweb:        https://git.kernel.org/tip/9b00c1609deeb7d6f68a61f3ec6988ab7e6=
f4535
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:39:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:27 +01:00

compiler-context-analysis: Add test stub

Add a simple test stub where we will add common supported patterns that
should not generate false positives for each new supported context lock.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-4-elver@google.com
---
 lib/Kconfig.debug           | 14 ++++++++++++++
 lib/Makefile                |  3 +++
 lib/test_context-analysis.c | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 lib/test_context-analysis.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cd557e7..8ca4252 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2835,6 +2835,20 @@ config LINEAR_RANGES_TEST
=20
 	  If unsure, say N.
=20
+config CONTEXT_ANALYSIS_TEST
+	bool "Compiler context-analysis warnings test"
+	depends on EXPERT
+	help
+	  This builds the test for compiler-based context analysis. The test
+	  does not add executable code to the kernel, but is meant to test that
+	  common patterns supported by the analysis do not result in false
+	  positive warnings.
+
+	  When adding support for new context locks, it is strongly recommended
+	  to add supported patterns to this test.
+
+	  If unsure, say N.
+
 config CMDLINE_KUNIT_TEST
 	tristate "KUnit test for cmdline API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index aaf677c..89defef 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -331,4 +331,7 @@ obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_i=
s_allowed.o
=20
 obj-$(CONFIG_FIRMWARE_TABLE) +=3D fw_table.o
=20
+CONTEXT_ANALYSIS_test_context-analysis.o :=3D y
+obj-$(CONFIG_CONTEXT_ANALYSIS_TEST) +=3D test_context-analysis.o
+
 subdir-$(CONFIG_FORTIFY_SOURCE) +=3D test_fortify
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
new file mode 100644
index 0000000..68f075d
--- /dev/null
+++ b/lib/test_context-analysis.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Compile-only tests for common patterns that should not generate false
+ * positive errors when compiled with Clang's context analysis.
+ */
+
+#include <linux/build_bug.h>
+
+/*
+ * Test that helper macros work as expected.
+ */
+static void __used test_common_helpers(void)
+{
+	BUILD_BUG_ON(context_unsafe(3) !=3D 3); /* plain expression */
+	BUILD_BUG_ON(context_unsafe((void)2; 3) !=3D 3); /* does not swallow semi-c=
olon */
+	BUILD_BUG_ON(context_unsafe((void)2, 3) !=3D 3); /* does not swallow commas=
 */
+	context_unsafe(do { } while (0)); /* works with void statements */
+}

